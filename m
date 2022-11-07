Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD1AC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiKGTfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKGTf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:35:29 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8919413CCF
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:35:28 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso8845650wmb.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERgD1js8i2+0TU6o9fT7w7frvJbb6avgNQrc/8E9vqk=;
        b=NNjuPIs5M9dHqZ0X1AjnGmKhBmq4R/SsdYhkLmMvVCTa4kExoSEIMUqR38HFaFJJ3m
         uFmIPnR0XItlMlZTTJ6xdkD91lbgCRIXx/RmUQs34/6b6CF3jJnS+q16wiYsKqFuG0gR
         jeyL9Gy0f9M7u5c1AaFMfE6SljVX8yqS2ULePWdw67nksDvmS84GHOot7gmJMaJQJ5JB
         snE7dyyJiL0tFw1soYarIKJzyGJQIK9pt1b+nMPj3aKx3wBs8Vp9im6rpllX98r8xM4z
         6TlxxUIq6wZXeXxG4Pb0UlrPqLuMi64WLrpStBpnL9Wn+LnZEzCv8roWzadtsR/wS79Y
         byCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERgD1js8i2+0TU6o9fT7w7frvJbb6avgNQrc/8E9vqk=;
        b=X1dmmAu4VpIn+eHy0qhDsRAbewKbUJO0vmgiFPqPieWXU8ZXZCqYZYE7m7ja95TJWV
         +ENzCiWRNeplZPHzEvzh3t3bRxfj/sQPV57WOeiTwh8shuMBWxCYCBE/EQhnsnGaqc9r
         XQAveJe3Q2oU9RdHgbAAxxnvYb06u99ruuTzcqMm3iSNl8JXTDdPT9QTAnTF8SYDJ/2v
         TN+tpKVslVFrpgy+wXbp2o8SiwJXDHnHMakyUbe8pQz4ObjhkqbzO00CiPbxofqpvtXj
         QJSo7LnNT3Sc1MQWnNQ4+9Ys8aZx2TRrDeMHhX2jmNHTHIxp/ku7ti9KneR8shCZlOqw
         /Mzg==
X-Gm-Message-State: ACrzQf2OWCBrWLsNlO8hItvh67xN09EIEroaexJ03sqOQdcRwvsNJYQa
        PWGVKvbQCla1xTDeZq22y1Y=
X-Google-Smtp-Source: AMsMyM4ABPQqSDO5KxdX/tRkHYeZ4ClNaLJ8+iR20/zKLX5YPwokhQYBoDJM0cH8AZofU0wccoakhg==
X-Received: by 2002:a05:600c:5114:b0:3c7:8eb:fb28 with SMTP id o20-20020a05600c511400b003c708ebfb28mr33646422wms.93.1667849727026;
        Mon, 07 Nov 2022 11:35:27 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600003c900b0022e6178bd84sm8250035wrg.8.2022.11.07.11.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:35:26 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <03cd4cdb-5f6b-11b9-1959-d58d5b544565@dunelm.org.uk>
Date:   Mon, 7 Nov 2022 19:35:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] sequencer: stop exporting GIT_REFLOG_ACTION
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <e9c3f5ac5c6b7a01ee9e43730889d8066a270271.1667575142.git.gitgitgadget@gmail.com>
 <221107.86iljqvhzf.gmgdl@evledraar.gmail.com>
In-Reply-To: <221107.86iljqvhzf.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 07/11/2022 16:12, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Nov 04 2022, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
>> +static const char *sequencer_reflog_action(struct replay_opts *opts)
>> +{
>> +	if (!opts->reflog_action) {
>> +		opts->reflog_action = getenv(GIT_REFLOG_ACTION);
>> +		opts->reflog_action =
>> +			xstrdup(opts->reflog_action ? opts->reflog_action
>> +						    : action_name(opts));
>> +	}
>> +
>> +	return opts->reflog_action;
>> +}
> 
> We always return an xstrdup'd here, so this should be a "char *" return
> value, not a "const char *"., but

We always return the same string, it is only allocated on the first 
call. opt->reflog_action is freed at the end of the rebase in 
sequencer_remove_state().

>>   __attribute__((format (printf, 3, 4)))
>>   static const char *reflog_message(struct replay_opts *opts,
>>   	const char *sub_action, const char *fmt, ...)
>>   {
>>   	va_list ap;
>>   	static struct strbuf buf = STRBUF_INIT;
>> -	char *reflog_action = getenv(GIT_REFLOG_ACTION);
>>   
>>   	va_start(ap, fmt);
>>   	strbuf_reset(&buf);
> 
> Here we just reset the strbuf...
> 
>> -	strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
>> +	strbuf_addstr(&buf, sequencer_reflog_action(opts));
> 
> Here we leak the freshly xstrdup'd value, mostly untested, but shouldn't
> this instead be:
> 	
> 	diff --git a/sequencer.c b/sequencer.c
> 	index e23f6f0b718..58a97e04c67 100644
> 	--- a/sequencer.c
> 	+++ b/sequencer.c
> 	@@ -3695,10 +3695,11 @@ static const char *reflog_message(struct replay_opts *opts,
> 	 {
> 	 	va_list ap;
> 	 	static struct strbuf buf = STRBUF_INIT;
> 	+	char *msg = sequencer_reflog_action(opts);
> 	
> 	 	va_start(ap, fmt);
> 	 	strbuf_reset(&buf);
> 	-	strbuf_addstr(&buf, sequencer_reflog_action(opts));
> 	+	strbuf_attach(&buf, msg, strlen(msg), strlen(msg) + 1);
> 	 	if (sub_action)
> 	 		strbuf_addf(&buf, " (%s)", sub_action);
> 	 	if (fmt) {
> 
> Of course that requires dropping the "const", per the above...
> 
> 
>>   	if (sub_action)
>>   		strbuf_addf(&buf, " (%s)", sub_action);
>>   	if (fmt) {
>> @@ -4497,7 +4511,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>>   				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
>>   		.head_msg = reflog_message(opts, "start", "checkout %s",
>>   					   onto_name),
>> -		.default_reflog_action = "rebase"
>> +		.default_reflog_action = sequencer_reflog_action(opts)
> 
> Here we'd before hand a fixed string to reset_head(), but now it's
> xstrdup()'d, but the corresponding free() on that side is missing.
> 
> But aren't we always just returing "rebase" here still?

Yes but I think it makes sense to call squencer_reflog_action() in case 
this changes in the future. Note I don't think this is leaking anything.

>> [...]
>> @@ -5116,7 +5121,7 @@ static int single_pick(struct repository *r,
>>   			TODO_PICK : TODO_REVERT;
>>   	item.commit = cmit;
>>   
>> -	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>> +	opts->reflog_message = sequencer_reflog_action(opts);
>>   	return do_pick_commit(r, &item, opts, 0, &check_todo);
> 
> Here you're adding a new memory leak, which you can see if you run
> e.g. the 1st test of ./t1013-read-tree-submodule.sh before & after this
> change.

I'm not sure how, opts->reflog_message will be a copy of 
opts->reflog_action which is freed at the end of the rebase. I'll have a 
proper look tomorrow to see if I'm missing something.

Best Wishes

Phillip
