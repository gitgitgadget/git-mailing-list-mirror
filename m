Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48D91F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 18:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfJBSDd (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 14:03:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41203 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfJBSDd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 14:03:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so49082wrm.8
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0YnwF9NA8j2NoEezPrnzZTc9VkpW5Wqz5NpzZG6j1dU=;
        b=ZHmUDxH8zmLx984cTxL+Z2oPLHzlIvj41xOUms1GtZSnYZTvA75v8618CWiTEKF1nG
         2Y/AjW0WtY0mFI3RN6KXjgMjc1W6pNlr0oLIqEjlwmD6d+xitYU+5nM9102wLAjzKgNX
         L1ELCPc07bgvGNbC/HHhwQxSt4BSMysIyzfXq+M/K3otCIbeDCZ/cv9uQKr/StYE+wbc
         xRMgko1S8+gAlbuHzEdTP5voRFuHBRT7cPBK8+EC5mWxucmjqHElqAtGi0oHfoZ4entO
         C2lt1/cAYHi6NmkqqABqv7v9VlXN71WPD1gcOWbvR7nSsURF/K6W7Gq8t4snFOALuiii
         +9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0YnwF9NA8j2NoEezPrnzZTc9VkpW5Wqz5NpzZG6j1dU=;
        b=B7dHcnRzmcknumBpQoe0X6U4n5yitWET0heUoK5Bs/Iv8N30Ew4rCuLvLUGoKOBjci
         rndUt3yi3ex0N+OIuyo03Ua6ZoAaebTJyxAb4rLBBGzGQgjNVzQ8wvzG+qTX4oFEM77P
         zBz7f09klsLbGV17Hwwn4jTf5vdjUTP0B/C6TCNo55euqAakK08uiqsdiLG6E0FEiPZ+
         dGfj3SHoNe5Z2qiX0JnewroFRdWqoLtm9aLH474fNWBhcIJ9ojjXVqBv4uRYvxzoqkmF
         qfLgl5czszI0tHynLkf4JEzfiDHS13nrrOw2nNc1XnRdPZLmpg7Xp6hA91cXDYlS6Sb8
         t6DQ==
X-Gm-Message-State: APjAAAVnT3pDpIowBljLYuTcABzHVu7xGpmfEH+KS4WoR/KL2SUvmY0j
        XHGNrkmWjcT1QOBdNED8ons=
X-Google-Smtp-Source: APXvYqzgQ52ecvHnJ9MPhgI/l3uN5F7NuV9quaObZNSeuK6KJUIfyE43gQ3ymkxoDFVwbMS72gOp1w==
X-Received: by 2002:adf:f343:: with SMTP id e3mr3769847wrp.268.1570039410863;
        Wed, 02 Oct 2019 11:03:30 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-236-54.w90-38.abo.wanadoo.fr. [90.38.111.54])
        by smtp.gmail.com with ESMTPSA id w5sm177956wrs.34.2019.10.02.11.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:03:30 -0700 (PDT)
Subject: Re: [PATCH v1 5/5] sequencer: directly call pick_commits() from
 complete_action()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20190925201315.19722-6-alban.gruin@gmail.com>
 <212cdc0d-8cf3-9172-d405-39b3868e6ca4@gmail.com>
 <nycvar.QRO.7.76.6.1910021018360.46@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <e37012e1-09dd-41b9-aa51-b6dd2b28a9c4@gmail.com>
Date:   Wed, 2 Oct 2019 20:03:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910021018360.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 02/10/2019 à 10:20, Johannes Schindelin a écrit :
> Hi,
> 
> On Fri, 27 Sep 2019, Phillip Wood wrote:
> 
>> Hi Alban
>>
>> Thanks for removing some more unnecessary work reloading the the todo list.
>>
>> On 25/09/2019 21:13, Alban Gruin wrote:
>>> Currently, complete_action() calls sequencer_continue() to do the
>>> rebase.  Even though the former already has the todo list, the latter
>>> loads it from the disk and parses it.  Calling directly pick_commits()
>>> from complete_action() avoids this unnecessary round trip.
>>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>>> ---
>>>   sequencer.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index ec7ea8d9e5..b395dd6e11 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -5140,15 +5140,17 @@ int complete_action(struct repository *r, struct
>>> replay_opts *opts, unsigned fla
>>>    	return error_errno(_("could not write '%s'"), todo_file);
>>>    }
>>>   -	todo_list_release(&new_todo);
>>> -
>>>    if (checkout_onto(r, opts, onto_name, &oid, orig_head))
>>>     return -1;
>>>
>>>    if (require_clean_work_tree(r, "rebase", "", 1, 1))
>>>     return -1;
>>>   -	return sequencer_continue(r, opts);
>>
>> sequencer_continue does a number of things before calling pick_commits(). It
>>  - calls read_and_refresh_cache() - this is unnecessary here as we've just
>> called require_clean_work_tree()
>>  - calls read_populate_opts() - this is unnecessary as we're staring a new
>> rebase so opts is fully populated
>>  - loads the todo list - this is unnecessary as we've just populated the todo
>> list
>>  - commits any staged changes - this is unnecessary as we're staring a new
>> rebase so there are no staged changes
>>  - calls record_in_rewritten() - this is unnecessary as we're starting a new
>> rebase
>>
>> So I agree that this patch is correct.
> 
> All true. Could this careful analysis maybe be included in the commit
> message (with `s/staring/starting/`)?
> 

I will do so (same for your comment on 4/5) and resend this series as
soon as possible.

Cheers,
Alban



> Thanks,
> Dscho
> 
>>
>> Thanks
>>
>> Phillip
>>
>>> +	todo_list_write_total_nr(&new_todo);
>>> +	res = pick_commits(r, &new_todo, opts);
>>> +	todo_list_release(&new_todo);
>>> +
>>> +	return res;
>>>   }
>>>
>>>   struct subject2item_entry {
>>>
>>

