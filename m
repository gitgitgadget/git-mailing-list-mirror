Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51495C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiB1QBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbiB1QBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:01:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33767091D
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:00:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso6007493wms.4
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PM3ey4oWLPHRIC6ugC7KEkJij/tQLewdQxCQZ8KxqnQ=;
        b=VY7q/s7Bo4IwJ9Vr/7Id51YZ276ogM88ENlZdf4CkFSCGiPigLeo7gSLCX3n4e4cYk
         ipuS9crGe7Jmk/60Vm/ziniTqOOutIeacOE1cEquHGo3P6PboKzcV0iN/2wMRjXl+T/l
         7qFLrG9SB0vnIGPZb1sOZpseUlA1BzMau6/Krj3wNCBT/nzsmq8ZvwWoWUM32f6tui1t
         0CKIE0MyhBf4AQq9J+AmenRBACCyc6hGDx8J2TOwzMTg2ciopTcp7Ls6miLYj3vvprGX
         CiVEMRdihy0jMvmSU01IH6mq/uA5E4sw3AvLb/ykkLcnO/OCnoRLuGNIlZgxgm2fnPk4
         d1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PM3ey4oWLPHRIC6ugC7KEkJij/tQLewdQxCQZ8KxqnQ=;
        b=K6AK2cjHioTdkaJub7FPzSXbzWw3MBfJ9FQmhNNMvDJgIisM0C2KjKSvo9LTySo7dr
         fcG4Yn0E0EJm7OBXMT20Geb+2vmwJveJ8HFxieXca16NG81bbyZFHcDRl6yBAoKW04MM
         +tMKLedl+7/QWbmCbhLHrXgC41D+6Ey3DJ5uHB4eP8TeCSSxZVzxQXYxBnt7dD8CHn5u
         uCGFAVHUNPaOfaak8sauAV9KVRfT9S3xK3yREcjY19eEYLVvKRYNvmk6m0dLwEhqZsh0
         96T/2b0LH8k5YYwDCA7g6RLxHn5PpUSMCc57SlS7+XrOuhKz2MMhMKg4bbA5HTWh6Wta
         oKqw==
X-Gm-Message-State: AOAM531NKY6AjypzF7ghCoes95nDPbZV2sgmQCAvFwvQ/+EoKFrclq/f
        B6T9MmcDKwaD85x8HQzxnu8=
X-Google-Smtp-Source: ABdhPJyIBzyIdOqHKz+Qr++PknKg2KSeTRVUoo0/ZZx+x/v0J1FjrddwLnA5Lbjb9uGTBgB+Zx4svw==
X-Received: by 2002:a05:600c:3785:b0:380:ce6c:cece with SMTP id o5-20020a05600c378500b00380ce6ccecemr13931332wmr.0.1646064022506;
        Mon, 28 Feb 2022 08:00:22 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id n8-20020a5d6608000000b001e73a0f21ffsm10879822wru.6.2022.02.28.08.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:00:22 -0800 (PST)
Message-ID: <e90340b0-09da-bf3a-f8eb-47fa408c51f1@gmail.com>
Date:   Mon, 28 Feb 2022 16:00:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] worktree: add -z option for list subcommand
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
 <xmqqh78mesj6.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqh78mesj6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/02/2022 17:59, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> [...]
>>   	reason = worktree_lock_reason(wt);
>>   	if (reason && *reason) {
>>   		struct strbuf sb = STRBUF_INIT;
>> -		quote_c_style(reason, &sb, NULL, 0);
>> -		printf("locked %s\n", sb.buf);
>> +		if (line_terminator) {
>> +			quote_c_style(reason, &sb, NULL, 0);
>> +			reason = sb.buf;
>> +		}
>> +		printf("locked %s%c", reason, line_terminator);
> 
> OK.  I suspect write_name_quoted() may be a better fit that does not
> require us to have our own strbuf, but this should be OK.
> 
>>   		strbuf_release(&sb);
>>   	} else if (reason)
>> -		printf("locked\n");
>> +		printf("locked%c", line_terminator);
> 
> It is a shame that we need a special code path for an empty string
> given as the reason, only for the single SP after "locked", but we
> have to live with it, I guess.

We could have

	if (reason) {
		fputs("locked", stdout);
		if (*reason) {
			fputc(" ", stdout)
			write_name_quoted(reason, stdout, line_terminator);
		} else {
			fputc(line_terminator, stdout)
		
	}

which shares the code to print "locked" but I'm not sure it is any 
bettor overall though especially as write_name_quoted() means we only 
want to output a terminator when there is no reason text.


Best Wishes

Phillip
