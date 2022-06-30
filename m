Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8306CC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 09:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiF3JrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 05:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiF3JrO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 05:47:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00148433A8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:47:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d2so26157129ejy.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XoQXrdTkkfvP/S+TNbT4d2/XhpafteUnR/slL7fBtFk=;
        b=Nqb5Ffi1VMSUXMVOwinQXgPAA7aEFZ6FU2BNnYDbhOZHJ4dJN7hj0/HjkSpPfGYkFS
         Nuy/JSmQOOxvHNum6V75luxLiirQ1TKbs8vHqBYU9/wATleI1k+j/38ndLYoBP6niOa+
         1Jfnpv6rb7TB5vzkT7eVUEB/Gdn5N6kzpq80GKFUfwdB7vpLitcj/D2uo/5sqnTsuL8q
         PdhTrqCcMLUbGrHfjQkDhCoSiSvY7jd33YqOat1ty5NITU0lR1aHSbiy+G8tAuIo+HGN
         7LlVpEy9RDjfNuyjEpY+53EHlZNhP+wCfWM3n4eiATX/YS4Wweruqg7HvDdBHNKUnjYM
         b/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XoQXrdTkkfvP/S+TNbT4d2/XhpafteUnR/slL7fBtFk=;
        b=i8jqmsW79o1aR3AX1jzsKP3RPPJhBu7qwGhQ/pN9qSsKxaMfMzOUIMNX13kiutxaZ/
         1yzstecZY7GnDU38GJvFbfodGGzfXWffP6OnubSZ/2pfwV90vCIL+GjfpW7in53MFj3b
         tQfwu7OEEYz65Ab/At2M7uUMAvrh320yzkoOi4smg2AL74yNRwb+XlPGBwfwZX0GCeTE
         wGIcNSPgfyj4Aszi8yJkvjIm7KBzWzJ9/A8A7+QwG/A3BOaBgWJA3OkubCi+oS4bCpO0
         MFjD4TA/Lsq5Gm0PPgitLwQt2Sn2Arg5AzACfhCwSad/87I3y6fC5i2Jiwcly2AwXuVg
         7c4w==
X-Gm-Message-State: AJIora+c90ayWtn2QQRQsXcZNgxlEsktf30qloQOZ2H0IT73Hd3uAraV
        m+iY5RDj+88YZWN7Z5kad10=
X-Google-Smtp-Source: AGRyM1sTTU3Gzg+Qm7gW8JjWiQRBWhEWvYr2qOQaryEiIDdSMc6q92A2HlFdfQFt75ReiVsabqL+zw==
X-Received: by 2002:a17:907:75f9:b0:72a:38f3:f0b5 with SMTP id jz25-20020a17090775f900b0072a38f3f0b5mr6813894ejc.549.1656582431578;
        Thu, 30 Jun 2022 02:47:11 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id s11-20020aa7cb0b000000b00438ac12d6b9sm1016731edt.52.2022.06.30.02.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 02:47:11 -0700 (PDT)
Message-ID: <4907af96-cb62-1d7f-d9ea-18d0e646f4ea@gmail.com>
Date:   Thu, 30 Jun 2022 10:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/8] branch: consider refs under 'update-refs'
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
 <xmqqpmisikex.fsf@gitster.g>
 <9d188e11-7bb4-cae7-b38a-f9f38c8c2fe1@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <9d188e11-7bb4-cae7-b38a-f9f38c8c2fe1@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/06/2022 13:58, Derrick Stolee wrote:
> On 6/28/22 4:48 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Derrick Stolee <derrickstolee@github.com>
>>>
>>> The branch_checked_out() helper helps commands like 'git branch' and
>>> 'git fetch' from overwriting refs that are currently checked out in
>>> other worktrees.
>>>
>>> A future update to 'git rebase' will introduce a new '--update-refs'
>>> option which will update the local refs that point to commits that are
>>> being rebased. To avoid collisions as the rebase completes, we want to
>>> make the future data store for these refs to be considered by
>>> branch_checked_out().
>>>
>>> The data store is a plaintext file inside the 'rebase-merge' directory
>>> for that worktree. The file alternates refnames and OIDs. The OIDs will
>>> be used to store the to-be-written values as the rebase progresses, but
>>> can be ignored at the moment.
>>>
>>> Create a new sequencer_get_update_refs_state() method that parses this
>>> file and populates a struct string_list with the ref-OID pairs. We can
>>> then use this list to add to the current_checked_out_branches strmap
>>> used by branch_checked_out().
>>>
>>> To properly navigate to the rebase directory for a given worktree,
>>> extract the static strbuf_worktree_gitdir() method to a public API
>>> method.
>>>
>>> We can test that this works without having Git write this file by
>>> artificially creating one in our test script.
>>
>> Hmph, I am not thrilled to see an ad-hoc text file for things like
>> this.  Do the objects that appear in this file otherwise already
>> anchored by existing refs, or can some of them be "floating" without
>> any refs pointing at them, i.e. making the "connected" and "fsck"
>> machinery also being aware of them to protect them from collected as
>> garbage and reported as dangling/unreachable?
> 
> You're right that we could have this sequence of events in a todo
> file:
> 
>    pick deadbeef Here is a commit that will become unreachable
>    update-ref will-be-lost
> 
>    squash 1234567 make will-be-lost unreachable
>    ...
> 
> So if a GC runs after this 'update-ref' step but before the rebase
> completes, then that commit can be lost. The ref-update at the end
> of the rebase process would fail.

The commit is protected by HEAD's reflog for a while because we update 
HEAD after each pick but it is not permanently safe.

I've taken a look at the first few patches and they're looking good, I 
hope to look at the rest tomorrow

Best Wishes

Phillip

> I wonder how important such a situation is, though. But I'm willing
> to add the extra lookups in 'git gc' and 'git fsck' to make this a
> non-issue.
> 
> I'll take a look to see where the other refs in rebase-<backend>/*
> are handled by these processes.
> 
> Thanks,
> -Stolee

