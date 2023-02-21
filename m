Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6339BC636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 16:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjBUQaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 11:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjBUQaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 11:30:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A38273D
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 08:30:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o4so5081281wrs.4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 08:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FeNoX89mYDIqzhIUzLA54TZNSAMNY0XmNDaALEskqbE=;
        b=khlw1xmBGBu9E1yHuPNOZEXUIcXdAr8m5xOQUd/JF84aJMoEOcuhy/13Rn4ZeGlDS4
         VRBYacvxy2dd3Lo96iXxQR/0aTN411Y2AA87XFChFn1DYBxoM/PHqYu4FE9bMMQfKIlw
         xAAoKPvowS/tX2AtE4r7QHc/nN+0MEb7+g8QXZAVFveSoEhD7PwrPlkrvEucgc18ZILs
         kJvEu/qYPuF65VBBwBHm5lAUYhgrviE/1UPXCSwEc+8zMzn55efXKdeamvQe9xDEqVY1
         MFposlcBanMTeLb/YCMFsAQzjoMQqcPLaXD8xes1PHA40hudSzQHwtb8+IuIJvTqHZtv
         4rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeNoX89mYDIqzhIUzLA54TZNSAMNY0XmNDaALEskqbE=;
        b=dNn6AgfKBe36xaHIe5bJ9Ft9DMfXLjkytN7FhHGluWTgI/pgFdiL2aqJxkUIIGnuiY
         Bg8Xnu+3Gr8Ldn6D+BRxuFv/ADMoem7Hz6Mfh9RCK0NBymUWLCNo04M4qoRMv7BvFe8F
         642nqDBT/bV8C+XG3TQYoYyUKDvBD7Aq/yh1UqBLFgSoXnXzqh5wiX3+6pe5ZchyXWw+
         k1sKJBRzWkbLCOr/Y78D9gP01ixBkeX0dig/VjaR6Uh6Z1rBxmuP54dmta+RlE90rNh8
         gYljhsoHVj0aQ9iac6JOmIcgkmuKHkKrqGxicCQIvoOlf3il/NB0lyq4jpZeF9e2O8Bz
         Obkw==
X-Gm-Message-State: AO0yUKW/XlHnPkWbeP5bQObZ5AnOtXWfwuemlqthZZU6OXpqmS/5FVd0
        crKYRmfdMMR4UhF/TlKx+nY=
X-Google-Smtp-Source: AK7set+rM1QPl+WURkAmxTQSuPcThs20x36h9OHNL/377EblHvV+Ami+SLVAkcymHa/oIL5GphgtTQ==
X-Received: by 2002:a5d:4acb:0:b0:2c5:9a0d:709f with SMTP id y11-20020a5d4acb000000b002c59a0d709fmr5378853wrs.15.1676997000985;
        Tue, 21 Feb 2023 08:30:00 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d4710000000b002c553509db7sm9164053wrq.52.2023.02.21.08.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 08:30:00 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <09ba35c3-1434-ac23-7ac0-1295dd8aca60@dunelm.org.uk>
Date:   Tue, 21 Feb 2023 16:29:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rebase -i: check labels and refs when parsing todo
 list
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
 <pull.1482.v2.git.1676902774366.gitgitgadget@gmail.com>
 <f99d7043-7757-2e19-d1e1-4ee9b887af1f@github.com>
In-Reply-To: <f99d7043-7757-2e19-d1e1-4ee9b887af1f@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/02/2023 14:24, Derrick Stolee wrote:
> On 2/20/2023 9:19 AM, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
>> +static int check_label_or_ref_arg(enum todo_command command, const char *arg)
>> +{
>> +	switch (command) {
>> +	case TODO_LABEL:
>> +	  /*
>> +	   * '#' is not a valid label as the merge command uses it to
>> +	   * separate merge parents from the commit subject.
>> +	   */
>> +	  if (!strcmp(arg, "#") ||
>> +		    check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
> 
> Tabbing is strange here. Within the case there seems to be "\t  " to
> the left of each line. Then the conditional has strange spacing. I
> think it should be:
> 
> 		if (!strcmp(arg, "#") ||
> 		    check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
> 
> (The "check_refname_format()" line is correct in your patch, but the
> lines above it are not, for some reason.)

Yes you're right, I'm not sure what happened there. I'll re-roll

Thanks

Phillip

> The rest of the switch statement is correctly tabbed.
> 
>> @@ -2525,10 +2553,19 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>>   
>>   	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
>>   	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
>> +		int ret = 0;
>> +
>>   		item->commit = NULL;
>>   		item->arg_offset = bol - buf;
>>   		item->arg_len = (int)(eol - bol);
>> -		return 0;
>> +		if (item->command == TODO_LABEL ||
>> +		    item->command == TODO_UPDATE_REF) {
>> +			saved = *eol;
>> +			*eol = '\0';
>> +			ret = check_label_or_ref_arg(item->command, bol);
>> +			*eol = saved;
>> +		}
>> +		return ret;
>>   	}
> 
> This diff is much simpler to understand for the purpose of this
> patch. I saw your comment about splitting out TODO_EXEC for a
> future change, and that would be fine when it happens, too.
> 
> Thanks for the updates. Outside of that strange whitespace issue,
> this patch LGTM.
> 
> Thanks,
> -Stolee
