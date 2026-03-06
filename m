Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461FC1862
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 04:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772771478; cv=none; b=rwe2xO/FdTGsvcpnTfFxdwyn5UDRkSziAVJY9B1klumVoSRPa82YIEaYTnsNYKUqWrtCegLn0C46tiipFG1Pt35VfzBa0aGGJNTfd8qRefdHrMhM12jdmIfMfaxBnbykfgHruZ9y+Wm0mjP2H5tf6THDRE0A9a/S149+e10CNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772771478; c=relaxed/simple;
	bh=M4by/rvNKLkDgEKsgXHux/ZSxUAds9N7/gjmDbTdeZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/83CM/nyr6XmjpuKPY04NkrJbOS2PKxBTqIcdZGuc0doeSitzEsRcljkDK2ODZYH1G6mB0IJLkYGFK9ut9OTL2xH17e2HniN5ojqe+b7wJ5ZO6q83qgR+7TFNnHg+WxcWOZXYVDWq+E8Y/LClAGnx9nrayZleHcFbRyVoefbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6WnHHnI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6WnHHnI"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829865a8471so1583224b3a.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 20:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772771476; x=1773376276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQ6Cs856c8k2tsy4Zzt0fV5zdxl7wPhWrFQog3cerVM=;
        b=R6WnHHnIN1297gVu/UuE+aKQl6hJFCQ9Czy88LJghtUsPGfsAJbOq9ABSf/mrBWJtU
         yj4RctUDWeswMYJdY8SQSEvBrxxErToSAYV9af7qL7fFBqS2G45ionXOiSsdF7jcFK9R
         THPtjytoghsWOSfIRKVnmpbnWhHCZuISEl1KWQQKCU4WgD5Tr6/2D1931wQLk018GXCZ
         sFhmgfp7ys67iaqPvhi+oy9p+iJGIKSdpjHSaMcCnMBlZUnQwZNq9td7B0dUlCyiyw/l
         mncz3/GreCu08pXCREYIZSXB+S4Ci2shiP1CEeHIIoa5CptONL4+AMyrHBdWZ7KnW1h6
         GGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772771476; x=1773376276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQ6Cs856c8k2tsy4Zzt0fV5zdxl7wPhWrFQog3cerVM=;
        b=BcPUinev4gsJdK1A/9iWIPYflSAVm058BTEuqVHwH23luugpRo2MMWro15JD4lnqd9
         Z9bBic6xLPxQQfL2dmoWWy12bkDcCcYA2L5t+yvww6BoDlMxpvug1cVr3sYcWRbPDzwu
         CS5zdluqWkOmCEga3IHH1EtULAfD75ZH3OsOI2eDiXR6WX4HHoQm36pltjTxBuoz4DTm
         epvVxXIilv3w1VS+j0LdCdU2LiQmBnrpecuJPLRq3uBQ5c7jfS4H9T2hlJAzyOw3efNX
         5S/JSy7+JjCE4IRP3ygtXYznBDdrWW0ofKyxCwUBrmxPfNxyKc1S4Ofw3Z0rlyVo+Ww2
         AyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXif/5YA2rD3DGJRcGY7lFeRC+Kw7CprdNkKq4azai5eMS0atNHkYo7FnM6Yue9Gyb3W/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjF87XbAlkw6uG2A3Y0ARlf3hXj23MmDmS33C9HAx8MQmq1poK
	eu248rZvlRSuU3LlIo+JR33zKZAxHGwiii9fl/pvaUSXErP4Ui6vSldK
X-Gm-Gg: ATEYQzwLoKeR7FwiqRdTIP9O5xSgUl1hMpiyc4VFHHQObghm4qPl1ZJzAOTHVaf3sMr
	IqXfRr/jkHUtVMe6i0DKkHXTOX2ofCuk81uwIKtrtlpHSwFPCVcDOW53gmpc7/CxnDoAV8iElug
	O2Re0ipP935WMgRGZV6IL0Ke0RAZ51AbwL8sb2keUjNL4ey6G7sEQA8rEznkoBYRtt9JBbgMt5k
	p+85bkR0ixnO9GbozXfhNxlpeb3PfuHW/P1W5LsFojD70c5UxJ+XWkvbnQtuH14iRmlz/0eT3mj
	1NvwX8VqobkBgvFXO3DTRvJvPBy/4P4nmVEQVtesqTA10uErvora1jpxIZI9S/Y+AAZAToY3VBf
	g5enBzvyZ2eBTsWsVRntnccj1DoOkVUH8VnL/piMYCBY+KtxOTahXYSCoQ224YFCpDJ1YvJSTSW
	xRfnOxTeTVnn7HB/niN4oTbwOu/C/hbeskhcFUgmsbtRw4wNBQzsn8goAXsUzNCCnOvcYci8Q+L
	o8c7FUSyXtlo2DRQ2WP/prX3RiC5jG/US84
X-Received: by 2002:a05:6a00:9087:b0:829:7a37:2bd2 with SMTP id d2e1a72fcca58-829a2f126edmr646676b3a.32.1772771476505;
        Thu, 05 Mar 2026 20:31:16 -0800 (PST)
Received: from ?IPV6:2401:4900:862d:bb67:1c20:bec7:1904:ead0? ([2401:4900:862d:bb67:1c20:bec7:1904:ead0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4865c6csm302358b3a.39.2026.03.05.20.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 20:31:15 -0800 (PST)
Message-ID: <71de4ade-62fd-4e66-b225-d87d3d5b97fe@gmail.com>
Date: Fri, 6 Mar 2026 10:01:03 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sequencer: extract revert message formatting into
 shared function
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, johannes.schindelin@gmx.de
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-2-siddharthasthana31@gmail.com>
 <87wm07e4ck.fsf@iotcl.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <87wm07e4ck.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/02/26 22:31, Toon Claes wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> 
>> The logic for formatting revert commit messages (handling "Revert" and
>> "Reapply" cases) is currently duplicated between sequencer.c and will be
>> needed by builtin/replay.c.
>>
>> Extract this logic into a new sequencer_format_revert_header() function
>> that can be shared. The function handles both regular reverts ("Revert
>> "<subject>"") and revert-of-revert cases ("Reapply "<subject>"").
>> When an oid is provided, the function appends the full commit hash and
>> period; otherwise the caller should append the commit reference.
>>
>> Update do_pick_commit() to use the new helper, eliminating code
>> duplication while preserving the special handling for commit_use_reference.
>>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>>   sequencer.c | 47 +++++++++++++++++++++++++++++++----------------
>>   sequencer.h | 11 +++++++++++
>>   2 files changed, 42 insertions(+), 16 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 1f492f8460..b32347c853 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2356,8 +2356,6 @@ static int do_pick_commit(struct repository *r,
>>   	 */
>>   
>>   	if (command == TODO_REVERT) {
>> -		const char *orig_subject;
>> -
>>   		base = commit;
>>   		base_label = msg.label;
>>   		next = parent;
>> @@ -2365,22 +2363,10 @@ static int do_pick_commit(struct repository *r,
>>   		if (opts->commit_use_reference) {
>>   			strbuf_commented_addf(&ctx->message, comment_line_str,
>>   				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>> -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>> -			   /*
>> -			    * We don't touch pre-existing repeated reverts, because
>> -			    * theoretically these can be nested arbitrarily deeply,
>> -			    * thus requiring excessive complexity to deal with.
>> -			    */
>> -			   !starts_with(orig_subject, "Revert \"")) {
>> -			strbuf_addstr(&ctx->message, "Reapply \"");
>> -			strbuf_addstr(&ctx->message, orig_subject);
>> -			strbuf_addstr(&ctx->message, "\n");
>> +			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>   		} else {
>> -			strbuf_addstr(&ctx->message, "Revert \"");
>> -			strbuf_addstr(&ctx->message, msg.subject);
>> -			strbuf_addstr(&ctx->message, "\"\n");
>> +			sequencer_format_revert_header(&ctx->message, msg.subject, NULL);
>>   		}
>> -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>   		refer_to_commit(opts, &ctx->message, commit);
> 
> I still find it somewhat confusing we have some the code that deals with
> `opts->commit_use_reference` partly in here and partly in
> sequencer_format_revert_header().
> 
> Part of the confusion comes from sequencer_format_revert_header() being
> called with NULL for the commit OID.
> 
> Was is not possible to incorporate Patrick's suggestion[1]?

You're right, the split is awkward. I tried to keep 
sequencer_format_revert_header() minimal so it didn't pull in 
replay_opts or refer_to_commit(), but the NULL oid path is confusing.

Phillip posted a cleaner approach in his reply to this patch -- he moves 
everything (title, body, refer_to_commit, merge-parent handling) into 
one sequencer_format_revert_message() with a bool use_commit_reference. 
That eliminates the NULL oid entirely and addresses Patrick's suggestion 
at the same time. I will go with that for v4.

> 
> [1]: https://lore.kernel.org/git/aTZ5RrjnwJ2ZnT7A@pks.im/
> 

