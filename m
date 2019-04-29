Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4634F1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 15:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfD2PK6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 11:10:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37017 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2PK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 11:10:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id y5so15395162wma.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UrjlrnAH4+pfH7ahHkrJsR4AQnB3LsNW8VZQ8wXmj8g=;
        b=D95hToh/feH6AkvAlfX/NEYIrDdtRwyHfRv66r1g/E0XfVPTs+kInPGDf7507ureIu
         k5CbGvFR6gI2gERlcEos3w6T21uJwAdThBVtyQby+ubUPA7MJfWouWkhzRzuJ/nbGH2J
         LysF8uX4aXIu0WTxJDlUf5E6s9YPZPJ4KYbCdD/QLa9aECS67c3RMx4E2VTMTxeG5xrS
         WpP+qWHCXQEnYFy4lluyaGJSL4eXb8xc4sUSM98XDZHESfm8nOf2yFp5NYOQqqXnK56z
         xtGxBRtWFewyMz9RHlgnLQ8nvUVzmpTTOjv+oESjp2QpDDlessuTkdMv/TiaXY21nyeC
         sHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UrjlrnAH4+pfH7ahHkrJsR4AQnB3LsNW8VZQ8wXmj8g=;
        b=M7GtUUH67RvM+iv1TjNGXUtgoYejpSwdn6ghJInpGVQhZsI6oUjFHaiVQ/DLiu2Roc
         5mT5+Ot7oS6Ceaan6IqC5uNcurK52oxiPsUSGkDAoLKAuX0OiPryVKY+XjEwP79YLoR7
         DlJsODtqRsUpzx4R+QIfkF1cAokHDIuTeZze8vBXPo3SzBIa2eum4jgcNp/tQY39Y7eF
         fG8ywMiessPj2Zxer/TZvvh2cPmsHCsuWkXGMcspXBTRgjjMkaZodX6ee594l1lKcyr2
         7Cxh7x38jnJ+Ln5YjRCsO7bGmW85Ru1va5JEuAnAYG7vca+S3giWE8IQzUWwoHMq+/mV
         2l6w==
X-Gm-Message-State: APjAAAUmOnmxRltHPwOFi2P/qxHTItplqNFBIIQe+M0U/5gLggCoBNtM
        Brbutum0IX/DUkE+yGj1Els=
X-Google-Smtp-Source: APXvYqxTNoVUcw0vynFLrIDN6gBuPKH1hi0uQ/sliTeRv8p56E2rJQjNFWTzxWy1fOmNPq2nrHkPPg==
X-Received: by 2002:a7b:c141:: with SMTP id z1mr4501995wmi.84.1556550655270;
        Mon, 29 Apr 2019 08:10:55 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id q3sm869655wrc.45.2019.04.29.08.10.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 08:10:54 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 23/27] switch: reject if some operation is in progress
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-24-pclouds@gmail.com>
 <78c7c281-82ec-2ba9-a607-dd2ecba54945@gmail.com>
 <CACsJy8ASYRwUGV8VnVKLhBqdv9V+UTAhb6U3+4BUjJFnJ+2Viw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <38c4e7fb-0d32-7696-e2d0-83766027383d@gmail.com>
Date:   Mon, 29 Apr 2019 16:10:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8ASYRwUGV8VnVKLhBqdv9V+UTAhb6U3+4BUjJFnJ+2Viw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/04/2019 10:16, Duy Nguyen wrote:
> On Thu, Apr 25, 2019 at 5:33 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 29/03/2019 10:39, Nguyễn Thái Ngọc Duy wrote:
>>> Unless you know what you're doing, switching to another branch to do
>>> something then switching back could be confusing. Worse, you may even
>>> forget that you're in the middle of something. By the time you realize,
>>> you may have done a ton of work and it gets harder to go back.
>>>
>>> A new option --ignore-in-progress was considered but dropped because it
>>> was not exactly clear what should happen. Sometimes you can switch away
>>> and get back safely and resume the operation. Sometimes not. And the
>>> git-checkout behavior is automatically clear merge/revert/cherry-pick,
>>> which makes it a bit even more confusing [1].
>>>
>>> We may revisit and add this option in the future. But for now play it
>>> safe and not allow it (you can't even skip this check with --force).
>>
>> I think this is a good compromise, lets see how it goes (I think I
>> broadly agree with Elijah's suggestion to allow the switch if we can
>> safely switch back again if we want to add --ignore-in-progress in the
>> future).
> 
> I probably will revisit this topic much sooner than I thought. I did a
> bisect today and found out "git switch" would not let me choose some
> "random" commit to test, which I suspected more likely where the
> problem was, or at least helped reduce the bisect steps. I had to go
> back to "git checkout" and was not so happy.

Oh that's a pain, but should be safe as you describe below.

> This probably falls under the "safe to switch" (and not even back)
> category, as long as switching does not destroy any data, since bisect
> is basically jumping between commits with a clean worktree/index until
> you find the right one. >>> +static void die_if_some_operation_in_progress(void)
>>> +{
>>> +     struct wt_status_state state;
>>> +
>>> +     memset(&state, 0, sizeof(state));
>>> +     wt_status_get_state(the_repository, &state, 0);
>>> +
>>> +     if (state.merge_in_progress)
>>> +             die(_("cannot switch branch while merging\n"
>>> +                   "Consider \"git merge --quit\" "
>>> +                   "or \"git worktree add\"."));
>>
>> I'm not sure merge --quit exists, 'git grep \"quit origin/pu' shows
>> matches for builtin/{am.c,rebase.c,revert.c}. The --quit option for the
>> sequencer command does not touch the index or working tree (that's the
>> difference between --quit and --abort) so the switch can still fail due
>> changes in the index and worktree that would be overwritten by the switch.
> 
> Eck! Let me check if --abort is the same thing there or we need to add --quit...

I think the --quit options generally leave the index and worktree alone, 
they just remove the state files whereas abort resets the index and 
worktree (with reset --mixed for merge and cherry-pick/revert, I think 
rebase does reset --hard) and also rewinds HEAD for rebases and 
sequences of cherry-picks and revert but that wont apply to merges as 
they are one-shot operations.

Best Wishes

Phillip

