Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455FBC3DA7A
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 14:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiLaOvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 09:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLaOvf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 09:51:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A690BF6B
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:51:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so22513234wrz.12
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKAw7vPBCRWjS67yJhq7AkW4xI7LQ/dmjEsnBHotvjs=;
        b=hO8FOuOaMzYT6C3QkSNBbVPmWy/eszhuI/7e+pysWgWD8BbjDghKxWaKYE7YrPWlbV
         6PTsMCZelrb/vPwYilsPHLGYtCryY2oScQYOT1BtI3MehLL5ATFaHa/i3k7Mtr/tIZtQ
         RvEBx8gSnu1RoK6Vw4Y/Xzo+8K6DqBSCKidiQ8l88F+7+P1kOjFQ8fYC/S5Vm0E8Mdrz
         ++3Bxt+BEObFIE4Y0sdACSJBbsE7CbySJ57O4To09g2NZaXSbbzH/gEpL9jHSGPk35Qo
         AvH3QeIP5qESEI8MSqkzMZMRm7L3H0h+dg930gQsMf7YWscGTt7PAhGQIeka24C9sKic
         iXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKAw7vPBCRWjS67yJhq7AkW4xI7LQ/dmjEsnBHotvjs=;
        b=RLtClYkB9wm+vptkONg5h/PhmfDKtOKCoAWJrbtiLk4Vm2v10YvNu+QJmQkitwgE7G
         AGzxqxdnhflVOCzPgH++cwplTwUhtxEJ1CnMSUhISM4z6f4Q1I9NLLmQ1yZN6rLsVDI5
         bit3xOw2pc7Ks9hGKLfAw7BlwYUQfcO8WN7Tm1zpCwaNRSeguWxUfoRwEYUIIc8dPvQp
         iW/sGkREuUwyAXgwk+QZlgBtZKQJ7WzGIsKvdEhVTGo22yoKGpQA54w8jtSycggR1xj6
         7hNv4ER1QarOvmwtdIh/X+9F8X4XixeCKP8x74Zp4RhdMHVwwvq8LzYNPs4eoUvU/xin
         buqQ==
X-Gm-Message-State: AFqh2kpXtCLL9cNVoO+WPg5wzAWf3Qca9jwkMo7GFzdS7P7U+NG8aZuX
        KYYv3OBpUR3SIt57Wk3iAfo=
X-Google-Smtp-Source: AMrXdXvzCKgobU9svrj7hARQG2RCcavGy62wewGkwaOHU+44t4yM7KFB4fkWGUR03frhkFpuGhZt9g==
X-Received: by 2002:a5d:514f:0:b0:293:3671:a70f with SMTP id u15-20020a5d514f000000b002933671a70fmr1504457wrt.69.1672498293279;
        Sat, 31 Dec 2022 06:51:33 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d618d000000b002425dc49024sm23352600wru.43.2022.12.31.06.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 06:51:32 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8b2a58ec-b883-95b3-52b5-cd673a47efad@dunelm.org.uk>
Date:   Sat, 31 Dec 2022 14:51:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 02/10] sequencer.c: split up sequencer_remove_state()
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <patch-02.10-4994940a0a9-20221230T071741Z-avarab@gmail.com>
 <efa1d3d9-03a8-6558-fdfa-ff2d776cdacb@web.de>
In-Reply-To: <efa1d3d9-03a8-6558-fdfa-ff2d776cdacb@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/12/2022 17:35, René Scharfe wrote:
> Am 30.12.22 um 08:28 schrieb Ævar Arnfjörð Bjarmason:
>> Split off the free()-ing in sequencer_remove_state() into a utility
>> function, which will be adjusted and called independent of the other
>> code in sequencer_remove_state() in a subsequent commit.
>>
>> The only functional changes here are:
>>
>>   * Changing the "int" to a "size_t", which is the correct type, as
>>     "xopts_nr" is a "size_t".
> 
> Good, and you declare it in the for statement, which we can do now!
> 
>>
>>   * Calling the free() before the "if (is_rebase_i(opts) && ...)",
>>     which is OK, and makes a subsequent change smaller.
> 
> It's true that is_rebase_i() can be called after all that free()ing;
> here is its definition:
> 
> 	static inline int is_rebase_i(const struct replay_opts *opts)
> 	{
> 		return opts->action == REPLAY_INTERACTIVE_REBASE;
> 	}
> 
> But why?  Making a subsequent change smaller is just a trivial fact if
> you do a part if it earlier, but that in itself is not a valid reason
> for the reordering.

Yes I'd prefer we did not reorder here either

Best Wishes

Phillip

> And I can't find that patch -- sequencer_remove_state() is not touched
> again in this series.
> 
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>   sequencer.c | 25 +++++++++++++++----------
>>   1 file changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index bcb662e23be..655ae9f1a72 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -351,10 +351,24 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
>>   	return buf.buf;
>>   }
>>
>> +static void replay_opts_release(struct replay_opts *opts)
>> +{
>> +	free(opts->gpg_sign);
>> +	free(opts->reflog_action);
>> +	free(opts->default_strategy);
>> +	free(opts->strategy);
>> +	for (size_t i = 0; i < opts->xopts_nr; i++)
>> +		free(opts->xopts[i]);
>> +	free(opts->xopts);
>> +	strbuf_release(&opts->current_fixups);
>> +}
>> +
>>   int sequencer_remove_state(struct replay_opts *opts)
>>   {
>>   	struct strbuf buf = STRBUF_INIT;
>> -	int i, ret = 0;
>> +	int ret = 0;
>> +
>> +	replay_opts_release(opts);
>>
>>   	if (is_rebase_i(opts) &&
>>   	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
>> @@ -373,15 +387,6 @@ int sequencer_remove_state(struct replay_opts *opts)
>>   		}
>>   	}
>>
>> -	free(opts->gpg_sign);
>> -	free(opts->reflog_action);
>> -	free(opts->default_strategy);
>> -	free(opts->strategy);
>> -	for (i = 0; i < opts->xopts_nr; i++)
>> -		free(opts->xopts[i]);
>> -	free(opts->xopts);
>> -	strbuf_release(&opts->current_fixups);
>> -
>>   	strbuf_reset(&buf);
>>   	strbuf_addstr(&buf, get_dir(opts));
>>   	if (remove_dir_recursively(&buf, 0))
