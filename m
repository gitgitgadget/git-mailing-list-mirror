Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80425C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F4B60E75
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351558AbhI3N54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351466AbhI3N5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:57:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7A3C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:56:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d6so10179159wrc.11
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xCNVhwV5JSLJ5gG7IHImDQ0RLusGnQq2/sAiEc07PEM=;
        b=aa+IGV7+Y6Y7WmMZsqmeACIvawPCeriZ15daYcPG796gYq33rJxJCyKL1FQqkXkXKP
         UAQp+BxcQFYClei2DU2nbJomRO97aEJ62orWZtH8oaaNRa+8JGdWMo4E20DtcP77SDgO
         OfySYlm+dOCF2GVvOklpUtYs+1zCMQPKVtZZzAmWFwZgpyPmKCiRhOzDshRnxzbkbTVW
         fYDwX5DxBEEEACeikBlKIkC3frunv7z09O+vtlhkAXBCBy36ShoL62PLoiDQcLKdN/TP
         HV6yT0yuZinfTEMGktqt1dW5ZvOIsHWvkA7qPjfN31bzsf8YvFvCtk/SIfBE+wVgsA0m
         pDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xCNVhwV5JSLJ5gG7IHImDQ0RLusGnQq2/sAiEc07PEM=;
        b=vKi7HWzjfKrkQ7RYiFDi+DU+0zTUaOBIwHGHNismXUKLMQKBwBRRGyy8Og7HMiLC1B
         AGZ+1gMGh5H5CZjqZP1qs2LUSDBpyGYtQLsEbgHmUholbz0IbTRcYGsY/KtE6raGV+bG
         nFmG/rd5Zcn1CPsycGhe7o2b68a/LDFI/EtcYEUVbUnk6Yo0owXfls+Lhly2++33Rh4v
         ILieFDilFbhf5hTq/pKO+svuzkUOeLqhGhFC9FJbhpHvm4ygQkK+gqGc/mFL9w9Eoy0E
         oi5TwOkBm2B7YJ05/bj+/wJDkwnv7sv5SRhNMQ/WJVOk0KnbrbByi7bmxB/NxkYr3SGg
         hBbg==
X-Gm-Message-State: AOAM532c+mSuOOT5Li285UyZ5t6r1VSg2T2KiDOEkDagzEmUWmNCl0sq
        pftE+DMQtIPxoDEHdDkxRLM=
X-Google-Smtp-Source: ABdhPJwynW6N7sT8vzvEK1qIMi0RLXNHUQ43b+3bKAguMgOe6Gts32oTb9tCBYfA+kCY5bnaDhPqTg==
X-Received: by 2002:a05:6000:550:: with SMTP id b16mr6508958wrf.297.1633010168272;
        Thu, 30 Sep 2021 06:56:08 -0700 (PDT)
Received: from [192.168.1.240] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.gmail.com with ESMTPSA id j4sm3142477wrt.67.2021.09.30.06.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 06:56:07 -0700 (PDT)
Message-ID: <18e7c572-3f71-e3d3-b5c3-1f8c54196899@gmail.com>
Date:   Thu, 30 Sep 2021 14:56:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Feature Request: `git commit --amend-to`
Content-Language: en-GB-large
To:     Glen Choo <chooglen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Aidan Gallagher <aidgal2@gmail.com>, git@vger.kernel.org
References: <CAENgTz2DoStQEqoKYKa-qMcyaez64u55mnv1HHOzDm392fuEqQ@mail.gmail.com>
 <CAENgTz0st6RpnVusP67-SSh2eENSxQn1_qiEqUDiMKzg=r54vQ@mail.gmail.com>
 <CAPUEspgr71t-thozi+Ez4xwxAkSJizsLuV=0TnROKZ85M6-kBg@mail.gmail.com>
 <kl6l1r58r6ba.fsf@chooglen-macbookpro.roam.corp.google.com>
 <87y27gv5bk.fsf@evledraar.gmail.com>
 <kl6lwnmzpbhq.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6lwnmzpbhq.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/09/2021 17:55, Glen Choo wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>>> [...] I think the problem
>>> has more to do with how Git manages merges and conflicts and less to do
>>> with having shortcuts in the CLI.
>>
>> I think that users who'd like an --amend-to would probably be happy with
>> or might want to try out something like "hg absorb", which is something
>> I think we should have stolen in git already, but it's never too late.
> 
> Agree. I think some "hg absorb" features get at the heart of what I
> meant, which is that users would benefit from making this merge conflict
> resolution a lot simpler.
> 
>> I.e. it's a "git commit --squash" on steroids, which tries to find what
>> commit to amend things into.
> 
> But this is an even bigger step up from what I was suggesting. I blame
> my own lack of imagination for not even considering this possibility.
> 
> To me, what really sells the feature is the "history of lines" approach
> cited in
> https://gregoryszorc.com/blog/2018/11/05/absorbing-commit-changes-in-mercurial-4.8/:

Thanks for the link, I had not realized absorb did not use a 3-way merge.

>    The automatic rewriting logic of hg absorb is implemented by following
>    the history of lines. This is fundamentally different from the approach
>    taken by hg histedit or git rebase, which tend to rely on merge
>    strategies based on the 3-way merge to derive a new version of a file
>    given multiple input versions.
> 
> Traditional 3-way merge is extremely frustrating when you find yourself
> touching the same lines over and over in a rebase, and I think "history
> of lines" maps quite cleanly to how humans think of lines. 

I agree that conflicts get frustrating with fixups but having just 
played with hg absorb it seems a bit too cavalier to me. The test script 
at the end of this email sets up the history below. I was surprised it 
applied the fixup as to my mind it is ambiguous whether 'z' should go 
before of after 'x' in HEAD~1 and whether 'p' should go before or after 
'e' in HEAD~2.

Worktree HEAD HEAD~1 HEAD~2       HEAD HEAD~1 HEAD~2
    a       a    a     +a            a    a     +a
    b       b    b     +b            b    b     +b
   +z      -x   +x     +c      =>   -x   +x     +z
    c       c    c     +d            z    z     +c
    d       d    d     +e            c    d     +d
   +p       f   -e     +f            d   -e     +e
    f            f                   p    p     +p
                                     f    f     +f

> However I'm not sure if Git has any machinery for doing this.

I think we could use a modified version of blame to find which commit a 
line comes from, but bail out in cases where it is ambiguous such as my 
example above (I think we'd want to require that the two context lines 
either side of an insertion remain adjacency as we track backwards 
through the history, and that a group of modified lines remain 
contiguous). The commits could be rewritten by applying zero context 
patches taking care to adjust the offsets where the fixup adds or 
deletes lines (similar to what add -p does)

Best Wishes

Phillip

----- >8 -----
write_lines() {
     printf '%s\n' "$@"
}

repo="$(mktemp -d)" &&
     cd "$repo" &&
     hg init &&
     write_lines >file a b c d e f &&
     hg add file &&
     hg commit -m initial &&
     write_lines >file a b x c d f &&
     hg commit -m one &&
     write_lines >file a b c d f &&
     hg commit -m two &&
     write_lines >file a b z c d p f &&
     hg absorb &&
     hg log -p


