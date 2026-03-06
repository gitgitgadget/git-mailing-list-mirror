Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700761D7995
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772772914; cv=none; b=nYc6XiPWZCGr8DcD2GyyDBwu37m/4T1QaEdc8cU+P0i/pBj7n3FIo+kSLMIhvdAkhdqwnfaSe4uOy63qHnkhlbEA448L6F+IgS5csC4aCXABQzkmshoqgf/Y+pwWqA0kZQACHmz59OuDi455gcJlfYdb9eMNd6qm7vLHN5zsQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772772914; c=relaxed/simple;
	bh=mNFohrdIfxa9nO23BJzH1N8TraQpsC3jYO74xhJUq1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFD3rKvCHTyhbjDyh27hxUHtxQneZjm/YJnkAxN8lfYYWVIOfJPkAQcvtZgDQLvp5nKtAiOx88/qednpyZXwLToWdIWkVCge6owDDAwdsdGsEB7jBKQbjQYpNNOA4VH19zG7MJF9C5IkCDDhi+4u8EjlzS3/fVeZnhS3KkAOiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCmU8kqg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCmU8kqg"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3598cab697eso3155298a91.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 20:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772772913; x=1773377713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrN+M6lGFq4nS+IRs0loMZ8qpZm1fGyMqPN8SIMvOQ0=;
        b=cCmU8kqg4RV6XYoRw9tYi/g7Hpgnbu8xK1QBWxBehN/FIE10UBviYxpi3IArKP5VAa
         cBs6I2EK73cmuXkFzH0y77wez6EIIDd6/mBOSSkvWKOlUteoCHydwX8ZyKdoF6F8eHMA
         mn8gCJXSYYF56Yq+vnjUEkYo0DYDm75mQP5it5w9ihH0u0vil03jLPi/Y1vBZlXYpZ5G
         9UVtV7T4UctE2lIwkV0Ao4skoUKyTHVOz/fADt1amnqohdIJfNmC1QO3TMF0sUIHuhIc
         YKubbeCBo8UXEFhE2NgH/ynQ/DfgcZqsn11HRFqwBt93cCtcjuts7ieZu64NPd8l1rQX
         WLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772772913; x=1773377713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrN+M6lGFq4nS+IRs0loMZ8qpZm1fGyMqPN8SIMvOQ0=;
        b=eWEibPIFcrsNBiimLVGppMJhfeWKK6tHuB2WyNGv2ohX8/dYSSRsvyX1NRVmZVvfNd
         1Apfh0EV7uhSKnuDa3QdqMnG0kC8sibPVhxWnqoS0x1mU5YpvnD/EfU646sm8e39+GcD
         BijmbTFDdUXouD4tU86lqhxkD999k2IQk8IWGTVZqrAVJUhXYVIftQtFvnTry6fJVSN4
         82Lx5WUsgPOaWLcrjROa0VA/AOV7ISF9tCuwuX4C4+AFi3TsMFNpU8410sbQVQBvNFOy
         G01YPLJmR/YXZbikyuSV3z3QTKbXfHQEoC0E49RAjZKvZHTmZd8m7g1Kq95YGrOzY+Mr
         g1/g==
X-Gm-Message-State: AOJu0YwSG4Qf4GaMkWGFLoK9HqzrWM320wNHI9nJOk2SopHqcSIqUCWm
	96WLZsAP5c/bwuCRyonNuMskR0Y0KCjlVqoy0yneQ4HayajwKdt//iWu
X-Gm-Gg: ATEYQzyftfTg2CB3ZXKCC0R4SWeySV+u/phMmWwbdT4lOhhHZNR0e5GBDTpi3x6kjtI
	wKpMrPgkSapyubCbYKloTahusFgpbNkhc9mVE91VZL6aOO2eJlWWOnh5TrMVIQ/EfsRizO4ObYH
	l1zfD5IMlmQ3wvhagREHtOCaMzazWozeQcXdQxTHfEARaKswy9hOuJsMtCtAWcfbJQ9uv3H7gZZ
	VkT2wF+lFhD0WiBVYpnDUJKnc6fP6xT4BVoXNhKpGMWaQ9GMGlpKSXKavkkriduymQ42qqe2A+p
	yr2lptnn2tau/y+t8eiTsmcOn1+rsSuBlAqoBobZnbgToTw/HilMNmS0yQs7gfTmjiibPx0Hn3c
	tTtJs3dwOIBx+PaxXbXHCBA3fa+axZHAjiNYmB6m5HOxEnul1CWwl3Q1PHPblG6R+eq8FpBRp7n
	646sn/ehdS4diUK0E9CNXt1L5qdyDQpahHS0eJrHBDHE/MYkLfXYETCAYpsPZ5axiJOV2fo1ZT0
	cwu9aOnS3MABoE9Dtf9YQlGmoex1/zss0Fh
X-Received: by 2002:a17:90b:528c:b0:359:86f4:bc7a with SMTP id 98e67ed59e1d1-359b1ba4be4mr4139019a91.5.1772772912660;
        Thu, 05 Mar 2026 20:55:12 -0800 (PST)
Received: from ?IPV6:2401:4900:862d:bb67:1c20:bec7:1904:ead0? ([2401:4900:862d:bb67:1c20:bec7:1904:ead0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2de7932sm4490435a91.10.2026.03.05.20.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 20:55:12 -0800 (PST)
Message-ID: <272a8ce4-08a7-490d-901a-ca8b5e72eb41@gmail.com>
Date: Fri, 6 Mar 2026 10:25:06 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sequencer: extract revert message formatting into
 shared function
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, johannes.schindelin@gmx.de
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-2-siddharthasthana31@gmail.com>
 <87wm07e4ck.fsf@iotcl.com> <xmqqcy1s8p81.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqcy1s8p81.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/02/26 03:23, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
> 
>>> -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>>> -			   /*
>>> -			    * We don't touch pre-existing repeated reverts, because
>>> -			    * theoretically these can be nested arbitrarily deeply,
>>> -			    * thus requiring excessive complexity to deal with.
>>> -			    */
>>> -			   !starts_with(orig_subject, "Revert \"")) {
>>> -			strbuf_addstr(&ctx->message, "Reapply \"");
>>> -			strbuf_addstr(&ctx->message, orig_subject);
>>> -			strbuf_addstr(&ctx->message, "\n");
>>> +			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>>   		} else {
>>> -			strbuf_addstr(&ctx->message, "Revert \"");
>>> -			strbuf_addstr(&ctx->message, msg.subject);
>>> -			strbuf_addstr(&ctx->message, "\"\n");
>>> +			sequencer_format_revert_header(&ctx->message, msg.subject, NULL);
>>>   		}
>>> -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>>   		refer_to_commit(opts, &ctx->message, commit);
>>
>> I still find it somewhat confusing we have some the code that deals with
>> `opts->commit_use_reference` partly in here and partly in
>> sequencer_format_revert_header().
> 
> True.  Making sure plumbing commands are unaffected by random
> end-user configuration is a good thing, but I am not sure if this
> command is truly a plumbing.


With Phillip's sequencer_format_revert_message() approach, replay just 
passes use_commit_reference=false and gets the full OID path. The split 
logic goes away, so this concern is resolved regardless of how we 
classify replay.


> 
>> Part of the confusion comes from sequencer_format_revert_header() being
>> called with NULL for the commit OID.
>>
>> Was is not possible to incorporate Patrick's suggestion[1]?
>>
>> [1]: https://lore.kernel.org/git/aTZ5RrjnwJ2ZnT7A@pks.im/

