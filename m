Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9CB1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 22:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbcH3WBo (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 18:01:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35445 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbcH3WAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 18:00:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so4939300wmg.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=iKNLU8eI9M1aFwczyz8Ml+exesYO2SKCk0QcvBxGDQs=;
        b=0Prue+2XoXDiiVZt+ZXMSLigl5dJBbJPUKfhiWdlYo1QxjnQmelL4P3CCOeKFWXLfv
         TZ2LgnYPZJyXl6XoLFkxurxTkK282c716xS+zf1KsgRySA33RygVKtKW5oyKpsTlTyKy
         eFclCEat6ZY5ccIMpxbFqey2PFjSE9K0cATguB41/ckHjDNAotJmwHE+L5bQj+Foixa+
         qPkYV2XcQ82caKfUn4uLelbIjm/UlAvnqcsBg1UEk4bPpssf6Yvdvyrf3l8BwM/KqNf4
         naDUqVIW461hiBFfSK/pOypNlgAn9TdO0D9EvGQ1AMPOdrQ0+mb6bS/iBoyXIWjaYH+T
         4MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=iKNLU8eI9M1aFwczyz8Ml+exesYO2SKCk0QcvBxGDQs=;
        b=Lqhx+/Vumoi2aRUTbIIsB5rTcktk3Ckq5wiRABwK6wX4EybQjBVqQnIqhKys446hoW
         9lRk3UFTUraC9o6w8znkZAvaAwB4egToDz/fsUJikG6o/sCDWt4MKAvn3hdsRF+sBvI5
         9ZS+ynPN75boyhl/YF/L4A1g6iPAVa/oGjY/6jY2t3vSsVBstyBGGo1heqsVNgNzBoFc
         VA5+hbGnuokeE8Rw8uIYiObXwituzVXOu1xsTcdxP+CtFmd6P920JOano4XDLpeU9G4Q
         1s/HoW76sxWJGJI5Cy4jdvY/jeJ6pi0NWNSIu5p9TjQ7vkQOl1kG2excpA0njCb7EoaH
         dmdQ==
X-Gm-Message-State: AE9vXwNnEEA7Yfjvn92zVkMTnNlsil3n0ekrQcSmTCNoePN0WbWBmWoy++Qpkl1QQYigwA==
X-Received: by 10.28.154.21 with SMTP id c21mr6114662wme.63.1472594405828;
        Tue, 30 Aug 2016 15:00:05 -0700 (PDT)
Received: from [192.168.1.26] (dam9.neoplus.adsl.tpnet.pl. [83.23.12.9])
        by smtp.googlemail.com with ESMTPSA id vv2sm41369043wjc.29.2016.08.30.15.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2016 15:00:05 -0700 (PDT)
Subject: Re: [PATCH 06/22] sequencer: release memory that was allocated when
 reading options
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de>
 <9797cb9e-115c-bbea-51d2-a5d686aca514@gmail.com>
 <alpine.DEB.2.20.1608301948310.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <20bf659c-c081-a05f-f18a-bf0b43e0dbf3@gmail.com>
Date:   Wed, 31 Aug 2016 00:00:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608301948310.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 30.08.2016 o 19:52, Johannes Schindelin pisze:
> Hi Kuba,
> 
> On Tue, 30 Aug 2016, Jakub Narębski wrote:
> 
>> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
>>
>>> The sequencer reads options from disk and stores them in its struct
>>> for use during sequencer's operations.
>>>
>>> With this patch, the memory is released afterwards, plugging a
>>> memory leak.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>  sequencer.c | 13 ++++++++++---
>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index b5be0f9..8d79091 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -131,6 +131,8 @@ static void remove_sequencer_state(const struct replay_opts *opts)
>>>  		free(opts->owned[i]);
>>>  	free(opts->owned);
>>>  
>>> +	free(opts->xopts);
>>> +
>>
>> This looks like independent change, not related to using the
>> sequencer_entrust() to store options read from disk in replay_opts
>> struct to be able to free memory afterwards.
>>
>> I guess you wanted to avoid one line changes...
> 
> Actually, it is not an independent change, but it free()s memory that has
> been allocated while reading the options, as the commit message says ;-)
> 
>>> @@ -811,13 +813,18 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>>
>> Sidenote: this patch would be easier to read if lines were reordered
>> as below, but I don't think any slider heuristics could help achieve
>> that automatically.  Also, the patch might be invalid...
>>
>>>  		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
>>>  	else if (!strcmp(key, "options.mainline"))
>>>  		opts->mainline = git_config_int(key, value);
>>> -	else if (!strcmp(key, "options.strategy"))
>>> +	else if (!strcmp(key, "options.strategy")) {
>>>  		git_config_string(&opts->strategy, key, value);
>>> +		sequencer_entrust(opts, (char *) opts->strategy);
>>
>> I wonder if the ability to free strings dup-ed by git_config_string()
>> be something that is part of replay_opts, or rather remove_sequencer_state(),
>> that is a list of
>>
>> 	free(opts->strategy);
>> 	free(opts->gpg_sign);
> 
> That is not necessarily possible because the way sequencer works, the
> options may have not actually be read from the file, but may be populated
> by the caller (in which case we do not necessarily want to require
> strdup()ing the strings just so that the sequencer can clean stuff up
> afterwards).

I guess from cursory browsing through the Git code that _currently_
they are only read from the config file, where git_config_string()
strdup's them, isn't it?  And we want to prepare for the future, where
the caller would prepare replay_opts, and the caller would be responsible
for freeing data if necessary?

Would there be any sane situation where some of data should be owned
by caller (and freed by caller), and some of data should be owned by
sequencer library API (and freed in remove_sequencer_state())?  If
not, perhaps *_entrust() mechanism is overthinking it, and we simply
need 'is_strdup' boolean flag or something like that...

>> The *_entrust() mechanism is more generic, but do we use this general-ness?
>> Well, it could be xstrdup or git_config_string doing entrust'ing...
> 
> Right, but that is exactly what I wanted to avoid, because it is rather
> inelegant to strdup() strings just so that we do not have to record what
> to free() and what not to free().

Maybe inelegant, but it might be easier than inventing and implementing
*_entrust() mechanism, like Hannes wrote.

> 
> BTW I have no objection at all to generalize this sequencer_entrust()
> mechanism further (read: to other, similar use cases), should it withstand
> the test of time.

Yeah, that's my take on it too.

-- 
Jakub Narębski

