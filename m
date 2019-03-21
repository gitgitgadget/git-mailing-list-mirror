Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B83520248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfCUO7w (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:59:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39664 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfCUO7w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:59:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so3058509wma.4
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lwVxzzpBUcFYANVgq6Zd/WO6NN0zEFbAWH+4GbF1jSE=;
        b=McDfWtScE3KNVN/SIbhKMex+HaHo0sXWvuGHTyYQ+GOZ6lA/xLRFdpNa6MbibMNvPo
         BO6L5DdKz7OfVVRyO9f+xWX8nnhIxKgiIP5NrpkVRXLtkSZItxwkfXu0Ft4ORywU2nSz
         oWXy95odzi7zKFB8hDGXBj79uLSORKYwi0WILf4xJf3IbwKQ6Y6hzB/3YUkuO4+A3sws
         ynhoaiEx08Lf/kXIMmUMqvbZOC5F2EcWn6gp0mSlVWYdfdPajgpLU/9rVTuW4Vb4+voy
         mJpBzWQD7xrwbAcISXmx9V1dy49FMz5AUNc8+ZpBFeiKqBLsVDnuCY3Svyep/3h8+bCf
         Huww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lwVxzzpBUcFYANVgq6Zd/WO6NN0zEFbAWH+4GbF1jSE=;
        b=Dr//S4vUNut7apArk2jkTSF/7r3pKA+SYzeydsiqSCdFWsh6UMI/pft9RXa2MMD1UD
         KNUJrHC8h1ZFs6TcmLLcjeidvobdei74v58XdZvkT0LcGmEJKB+/x3RFNioS1B5wII9N
         BCxsRHie4nPTrh3b3ojNGVnpJQiGVB0a3cfTb6dMOrSfKQnqYzWZ2Vx18bI6gMQq2AAm
         2iLXG+x2UcMpuli7lhSoXNHOVcUWU1AQj/HvWrKZI9Et5AEqLRkKfx10FwIqOHbk6kBM
         s28zq1ENjwokZd4xVNKWC+vecO/MNNaPqgRVg7XDX2D3DxNg9//nv7tFQycJM/MgqF2A
         1HUw==
X-Gm-Message-State: APjAAAVDY8GFKoSPcm1B4zVtiiwih9l07iVbD38rLnZk3VZubnZnq8pX
        /Ny0RamrTaQ0xUk+NFgfsq0=
X-Google-Smtp-Source: APXvYqyqg/5hbTLjRm8SphhVfBRceScKn2PFfuZXSwySiuPBZsUVCwA0o53x7VKeBFme4W+8UQHRxw==
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr2939581wmo.52.1553180390800;
        Thu, 21 Mar 2019 07:59:50 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id v20sm11950208wmj.2.2019.03.21.07.59.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:59:50 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 08/11] rebase -i: use struct rebase_options to parse
 args
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190319190317.6632-9-phillip.wood123@gmail.com>
 <xmqqwokssvq6.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <94fe6518-ca13-8eb8-d455-e2a6fcaeb1d6@gmail.com>
Date:   Thu, 21 Mar 2019 14:59:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <xmqqwokssvq6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 21/03/2019 04:21, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> +static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>> +{
>> +	struct replay_opts replay = REPLAY_OPTS_INIT;
>> +
>> +	sequencer_init_config(&replay);
>> +
>> +	replay.action = REPLAY_INTERACTIVE_REBASE;
>> +	replay.signoff = opts->signoff;
>> +	replay.allow_ff = !(opts->flags & REBASE_FORCE);
>> +	if (opts->allow_rerere_autoupdate)
>> +		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
>> +	replay.allow_empty = 1;
>> +	replay.allow_empty_message = opts->allow_empty_message;
>> +	replay.verbose = opts->flags & REBASE_VERBOSE;
>> +	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>> +	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>> +	replay.strategy = opts->strategy;
>> +
>> +	return replay;
>> +}
> 
> This calls init_config() and then sets .action; does it revert to
> what dl/merge-cleanup-scissors-fix wants to do, which flipped the
> order to fix some bug?  It is a bit hard to tell.

dl/merge-cleanup-scissors-fix changes sequencer_init_config() to depend 
on the value of action so action should to be set first. What is in pu 
at the moment in not quite right (though I'm not sure what the practical 
implications are as it looks like the rebase tests are passing[1]).

[1] https://travis-ci.org/git/git/jobs/509332448
> Unfortunately because of the earlier huge code movement the changes
> to _this_ file does not conflict and cleanly merges, but because the
> other file is removed by this series while a topic in flight updates
> it, the semantic conflict like this luckily gets discovered.
> 
> Especially since this is still an RFC, I'd preferred to see it
> without moving around the code too much (instead, exporting some
> symbols that need to be visible with each other after renaming them
> to more appropriate names that are fit in the global namespace).

I'm happy to try doing that, though the textual conflict would be in a 
different place in the file to the semantic conflict but at least they'd 
both be in the same file. I think it would only need to share the 
definitions of struct rebase_options, enum rebase_action and the 
declaration of run_rebase_interactive(). Would you be happy with the 
addition of builtin/rebase.h (there don't seem to be another headers in 
that directory). We could leave rebase--interactive.c around until 
rebase--preserve-merges.sh is finally removed.

Best Wishes

Phillip
