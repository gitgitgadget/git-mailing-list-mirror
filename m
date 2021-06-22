Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A3FC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 09:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF36861351
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 09:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFVJFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 05:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFVJFV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 05:05:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4CCC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 02:03:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j21-20020a05600c1c15b02901dde2accccbso1726223wms.4
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2bKZb+NoPYUN7rapNePpH6lUQ59Fbymtv4u44OnpRDk=;
        b=M3KiflDbTLPbyxa1o+U8iwGH36HOGJTiXFrbvo2ziVoMCkwjCW4aSZIfANicypBVZh
         4EQdt68Sm+R0CZjVVyefNXGVA+nv0fy9MEh0TZd/LQ7jLPoEkKWXAA9etfG2Z7CWAfaI
         7Qc7mDmehDttzRhaHY+e6z2GfpK601lCW03NtanATGtmhxDYrJtbzVrQzUVHVsxjYUvO
         hjpg5u7E85GjAFz2cQSGcodk3b0j7L9tZKacGV59saQFIkiq6X9z4XPE+W6o3S5rjM5N
         rVtxErIsx/6tcctLyWFR18ssBHkfYGOv+zabeBiITIQO5T5yetlLYBvRUki/eMB5sWRx
         ZowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2bKZb+NoPYUN7rapNePpH6lUQ59Fbymtv4u44OnpRDk=;
        b=I/1Q9ErtQdzFObIkC51xNsZaKtfMglDaYyuhslnCXhmQHMAA7HAVsOnD9oOK0ec+Hg
         EhdtwbtqKmE/qzSF+wmTd5SqTuMz2vj+x5wrifzvz+Oy8jTZqIYsb5mVwDpr4yJ5fCTs
         ZS4vmWmpY+8G5pTwqdkvJKRnxfyIDuMI9uRwZPyUyb0trFIKde7Aw3g6kZK/6ERvAFDW
         KJTFLvtIIQt/xDys80owUUu4xVd5BANCpJCRKEZbHQlHakLkw+A9tIH0hsf43DX6/WuB
         h2gYHl5scxwDaQUl3Kao7vU0qhhrefrsQ4WsKoCUQNrgW6OFvtmoXA+5fjicrnqAfRi3
         sfkQ==
X-Gm-Message-State: AOAM533zaWy7nG9KDM2+NxrPNpp6xbfEU3JBVxLBMsp24qklDJWU7kbX
        m1gyCEn8WbJxlQD58DzGnyqCtIVx1Yk=
X-Google-Smtp-Source: ABdhPJzUOsJQwHZWHkbzz+tARexnKZXleQpH9Ko2jKRmfAPmMb7mVJKSXZVnYszXuS6dTgAVCJbvIw==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr3046676wmc.71.1624352583770;
        Tue, 22 Jun 2021 02:03:03 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id d15sm21542041wrb.42.2021.06.22.02.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 02:03:02 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 11/12] builtin/rebase: fix options.strategy memory
 lifecycle
To:     Elijah Newren <newren@gmail.com>
Cc:     Andrzej Hunt <andrzej@ahunt.org>,
        Git Mailing List <git@vger.kernel.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210620151204.19260-12-andrzej@ahunt.org>
 <6e02fc85-42a4-8b19-1fe7-3527c2308a24@gmail.com>
 <CABPp-BEQkUQLt-ZbwdO+ecd2rumttBUKUmh3=7LaKRxwXCkB+g@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d1ef45c1-067e-abde-62a2-1df2c12ba3a3@gmail.com>
Date:   Tue, 22 Jun 2021 10:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEQkUQLt-ZbwdO+ecd2rumttBUKUmh3=7LaKRxwXCkB+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 21/06/2021 22:39, Elijah Newren wrote:
> On Sun, Jun 20, 2021 at 11:29 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Andrzej
>>
>> Thanks for working on removing memory leaks from git.
>>
>> On 20/06/2021 16:12, andrzej@ahunt.org wrote:
>>> From: Andrzej Hunt <ajrhunt@google.com>
>>>
>>> This change:
>>> - xstrdup()'s all string being used for replace_opts.strategy, to
>>
>> I think you mean replay_opts rather than replace_opts.
>>
>>>     guarantee that replace_opts owns these strings. This is needed because
>>>     sequencer_remove_state() will free replace_opts.strategy, and it's
>>>     usually called as part of the usage of replace_opts.
>>> - Removes xstrdup()'s being used to populate options.strategy in
>>>     cmd_rebase(), which avoids leaking options.strategy, even in the
>>>     case where strategy is never moved/copied into replace_opts.
>>
>>
>>> These changes are needed because:
>>> - We would always create a new string for options.strategy if we either
>>>     get a strategy via options (OPT_STRING(...strategy...), or via
>>>     GIT_TEST_MERGE_ALGORITHM.
>>> - But only sometimes is this string copied into replace_opts - in which
>>>     case it did get free()'d in sequencer_remove_state().
>>> - The rest of the time, the newly allocated string would remain unused,
>>>     causing a leak. But we can't just add a free because that can result
>>>     in a double-free in those cases where replace_opts was populated.
>>>
>>> An alternative approach would be to set options.strategy to NULL when
>>> moving the pointer to replace_opts.strategy, combined with always
>>> free()'ing options.strategy, but that seems like a more
>>> complicated and wasteful approach.
>>
>> read_basic_state() contains
>>          if (file_exists(state_dir_path("strategy", opts))) {
>>                  strbuf_reset(&buf);
>>                  if (!read_oneliner(&buf, state_dir_path("strategy", opts),
>>                                     READ_ONELINER_WARN_MISSING))
>>                          return -1;
>>                  free(opts->strategy);
>>                  opts->strategy = xstrdup(buf.buf);
>>          }
>>
>> So we do try to free opts->strategy when reading the state from disc and
>> we allocate a new string. I suspect that opts->strategy is actually NULL
>> in when this function is called but I haven't checked. Given that we are
>> allocating a copy above I think maybe your alternative approach of
>> always freeing opts->strategy would be better.
> 
> Good catches.  sequencer_remove_state() in sequencer.c also has a
> free(opts->strategy) call.
> 
> To make things even more muddy, we have code like
>      replay.strategy = replay.default_strategy;
> or
>      opts->strategy = opts->default_strategy;
> which both will probably work really poorly with the calls to
>      free(opts->default_strategy);
>      free(opts->strategy);
> from sequencer_remove_state().  I suspect we've got a few bugs here...

It's not immediately obvious but I think those are actually safe. 
opts->default_strategy is allocated by sequencer_init_config() so it is 
correct to free it and when we assign it in rebase.c we do

	else if (!replay.strategy && replay.default_strategy) {
		replay.strategy = replay.default_strategy;
		replay.default_strategy = NULL;
	}

so there is no double free. There is similar code in builtin/revert.c 
which I think is where your other example came from. I think there is a 
leak in builtin/revert.c though

	if (!opts->strategy && opts->default_strategy) {
		opts->strategy = opts->default_strategy;
		opts->default_strategy = NULL;
	}

	/* do some other stuff */

	/* These option values will be free()d */
	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
	opts->strategy = xstrdup_or_null(opts->strategy);

So we copy the default strategy, leaking the original copy from 
sequencer_init_options() if --strategy isn't given on the command line. 
I think it would be simple to fix this by making the copy earlier.

	if (!opts->strategy && opts->default_strategy) {
		opts->strategy = opts->default_strategy;
		opts->default_strategy = NULL;
	} else if (opts->strategy) {
	/* This option will be free()d in sequencer_remove_state() */
		opts->strategy = xstrdup(opts->strategy);
	}

I'm going offline for a week or so in a couple of days but I'll have 
look at making a proper patch when I get back.

Best Wishes

Phillip
