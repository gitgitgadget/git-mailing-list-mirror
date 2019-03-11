Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1393F20248
	for <e@80x24.org>; Mon, 11 Mar 2019 17:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfCKRDb (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 13:03:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41962 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKRDa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 13:03:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so1476052wrs.8
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Bl09eGxS8zrPHwYStTG+/5MqEkbSSN0XMKOLW1cBrw=;
        b=p8P7j+AoWF0Cy6UdLsfgKwC2w74AMP8rHFhdq3Wrt20WO8AGjz95X58WIRWi7fqAJB
         nMQ9G5O+jTg1rOT/KY2QH1zsueXXpzQGs9pjPDoOfZvygt0wkJVfTejEU+XZ9h8IdaS0
         6HDs3cTwlK1SY0tFma8eAemDknUuZzl/r4YLlogOOHKs2n6XzcfLO3V098pnZkhyUrnH
         jAjLTIIBrRr3N4+5NTcA0mhBvvTB70U2S8+CJjgLUqinyI1hCtcizqaVMbm/YzMKehdx
         MPfvHjiHfKDINhsda1yo+2CnuorEUhBC3eN27GwOtA8OmdRRIYU4WPJGLI8mGni/0TvW
         lHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0Bl09eGxS8zrPHwYStTG+/5MqEkbSSN0XMKOLW1cBrw=;
        b=aJDrDLv6CpmRSd1GXKLbH+KypXTEaRwLDKiq8AnfsmaLWvwdzy1eI2S9mDGrOnZi43
         sC7F657DWnwmjT65eVBttVu/gbZiQy6o6Dhz/WJatVUdlmvnCSQGtwvRLQlEVymBb70F
         LLSSQtet3Np2yB2gHtsbjl/GwwCEBmlHcOuKPkYoQq3w0ksmOL8f35+cJ6vrZTjpnd1c
         sDDn/cw1BEiRRTUEoSpHWvcg6z8rVN4i5JJBI+PwuiFuZAzZ/s4n3nBul4/c4zbcYsTi
         /wp2UQrlunZblnqOQnC41sd3l1i8M/SgAIb3oYbthF/GM0HnOHzMWyx6nmogIgFfhzRC
         ZzVA==
X-Gm-Message-State: APjAAAXfjhNd/gRrOKsw2XtqcKkiQaWVQRcFO6f68mELIbvmq9JqlKM8
        NeroCabMkRL7DjKqTObg9Mo=
X-Google-Smtp-Source: APXvYqyqsrEo8NkSFLupNMalBU80NsfazhVT1B2hN1wcoZTfTCHmj+CigsoexYB00bjDRhHz8O4GgQ==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr20349303wru.116.1552323808070;
        Mon, 11 Mar 2019 10:03:28 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-27-66.as13285.net. [92.22.27.66])
        by smtp.gmail.com with ESMTPSA id p1sm31210983wmi.9.2019.03.11.10.03.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:03:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f63a7ae7-0a08-02f2-23e6-4389d8fda729@gmail.com>
Date:   Mon, 11 Mar 2019 17:03:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy

On 11/03/2019 11:47, Duy Nguyen wrote:
> On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>>
>> Hi Duy
>>
>> On 08/03/2019 09:57, Nguyễn Thái Ngọc Duy wrote:
>>> "git checkout" doing too many things is a source of confusion for many
>>> users (and it even bites old timers sometimes). To remedy that, the
>>> command will be split into two new ones: switch and
>>> something-to-checkout-paths.
>>
>> I think this is a good idea, thanks for working on it. I wonder if it
>> would be a good idea to have the new command refuse to checkout a new
>> branch if there is a cherry-pick/revert/merge/rebase in progress (with
>> an option to override the check) as switching branches in the middle of
>> one of those is likely to be confusing to users (if I do it it is
>> normally because I've forgotten that I've not run 'git whatever
>> --continue').
> 
> Interesting. I think this would be a good default if we have an escape
> hatch (which could even come later). I often wander off to some other
> branch and go back. But then half the time I end up forgetting I'm in
> a middle of something and just "git rebase --quit" :P
> 
> Of course with git-stash (*) and git-worktree, I guess there's little
> reason to just switch away from a something-in-progress worktree. I'll
> try to implement this in the next round, unless someone objects.
> 
> (*) I hope git-stash remembers and restores "something-in-progress"
> status. Dunno. Never used it much.

I don't think it does. For rebase it's non trivial as it needs to 
remember the refs under refs/rewritten and stop gc from collecting any 
of them or the original head (in theory the todo list can contain 
commits that the user has added from other branches as well so they'd 
also need to be protected from gc). For cherry-pick there are gc issues 
as well.

Best Wishes

Phillip

> 
>>> +-C <new-branch>::
>>> +--force-create <new-branch>::
>>> +     Similar to `--create` except that if `<new-branch>` already
>>> +     exists, it will be reset to `<start-point>`. This is a
>>> +     convenient shortcut for:
>>
>> If we're renaming the options to be more meaningful then maybe we should
>> consider a different name for this one - it has nothing to do with
>> creating a branch. Maybe --reset or --update?
> 
> -C can also create a new branch like -c though. --reset or --update
> does not convey that (and --update sounds a bit too safe). Another
> option is --recreate.
> 
>>> +-f::
>>> +--force::
>>> +     Proceed even if the index or the working tree differs from
>>> +     HEAD. Both the index and working tree are restored to match
>>> +     the switching target. This is used to throw away local
>>> +     changes.
>>
>> I'd always thought that --force meant "throw away my local changes if
>> they conflict with the new branch" not "throw them away regardless"
>> (which is better as it is deterministic). Maybe we can come up with a
>> clearer name here --discard-changes? At the moment --force does not
>> throw away conflicts properly (see the script below in my comments about
>> --merge).
> 
> Yeah if you want to redefine --force, now is a very good time.
> Personally I'd rather have separate options than the "one catch all"
> --force (or worse, multiple of --force). I'll leave this for the
> community to decide.
> 
> Adding Elijah too. He also had some concern about "git restore
> --force". Maybe he's interested in this as well.
> 
