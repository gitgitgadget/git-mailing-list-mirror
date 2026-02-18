Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781133890E
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455192; cv=none; b=BHuDNrxXFYfs+mih5V4TpsdMAcwTYtky+0Fm/l/CyJ4XIMB+ASJEPSYbKkAV5MTf7e0P5SXUE0be9WhmFO1eHsdNuIvEb3wFOdmVQhYnjcZyo+AuMG4yVoKdlmrDsRxB3fbqfq7iFgfEzzdxqIlI4rtDRvg9c+tQDPb2JvCSn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455192; c=relaxed/simple;
	bh=P68Kl+VJsfyhbVIcDoDAfNDKY7ZG//Fur4FTa3pzsTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzNao5SFv09VC12Ru95Q1sMQS4pofQlSr5AR9/Xs/wJDpm6O+2BmyDMKeIfs8QdsVa6SpBdodL0Ob/Z6lZ05EjFsYwlzWoIi12bdu7f1Ez9l0/eVd2G2+HA6LjOiJeskpT+nSE/dTWsb3yzkbDXwK8gnWmbL30VePw2FdyAPiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeGXJ+z5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeGXJ+z5"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82491fbf02cso155633b3a.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771455191; x=1772059991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrQWA8xva/GWcByFIyq6a2YPRt+kQw0CFHHvggQVDpQ=;
        b=CeGXJ+z5yHcMa/iUYHROQRoCu03Md3poBjhNfSCckqsg6zZ7XdbxyRO2A7n4NA3ySV
         71dpO2QEdaN4YZAtvN81td3iq9FGftnJ/7/aJ1g/jW/FnJlobItJ0ugjqO6S5vWugB5H
         DcGE8L08Obm1Yqt0cDPaCEm2uiRMbcmp+uGml+pJOtg7Y7zz5Dk1AVVkcHWXyYHZZC2n
         aI/5/Fy/wfVEv3Yi1i79p7y8eDay8Cqnzhu1Pay9LontFap2ER21LvRYEbbhTihA50dL
         J+xOWpv/31oRjGP7k851vE5C/ki5G19eWPSkW4mJZFhQwU7tq4BM0RWoJ7rsF9pPP+db
         ofTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771455191; x=1772059991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrQWA8xva/GWcByFIyq6a2YPRt+kQw0CFHHvggQVDpQ=;
        b=Mqtco5moSyx7PrxJJycdmYufS3fdSoiqX4d4fPpK/9CqL6Nd4EZSu3/YrMDqp0BL1F
         zuTlGF3OUvfJXDtaJP1zlZyW9pvw7Rlpo7M1nHDdOi7SMPv2bGP+L0LyVRget23KgFpt
         QvD7SkxAytWewKdwP9cm3JGba30rIpwEXRGG1B+WW3Ju9sLrZVHVl2wp38uGiCWK85Ug
         ApYm1my0ve0cp5FZD1dAy67ZD911tStUTR2jk0jAzPS79YBfDS73xrhDIvF6SYb2Xyd7
         iWaZ5H/IOu8EZS6e1TX6PHL9pQVoz9ru15gCYNsKg/1QPdEkZXKHY3noc+Ah+KJK9mBf
         gR5g==
X-Gm-Message-State: AOJu0YxwqJtyuU99muGbJ3o2pe5vVsE2leNJqdPgDnsIjU6heLaRt8Un
	Z/aQqJbQ9OX6piXlsberZLVS/uKMTPKfdnVDdk+ZWNvuZWb62dVmtoP3
X-Gm-Gg: AZuq6aIfkWcbZx6Le39wA0ZIiP8Uva3I+wNmtO5Pprh2u+D0WkE6i1rVq3xMwkrGsJa
	nztdhJChEOdgyMg7TNbx7PAlZomcvwUdN8BRmJv5JBLxiCjM1tiR7HzrRr0YzWxvtLHuTAZy0m7
	5a52gSWix0USb+wgjBhfxoCUzsUaY/cza1jZ+O4Ot63RrgR+AZtqEh20m5muwXqo3JybXmijoz2
	c1ft+c0vGURIHRzKokJ4DtAiGyEKcp0oEXffI6PaTHdr7P5UzdsdC5MNFWBJa2UN/5InYSRKFA1
	mvkautzCoy05SJ6OqdKxp///zssd31Vp76T5VWMKqkHRZnpN2g1a+9eb1UN9kNX8rzOcG/AxiSV
	0STZqXs2NveMcxZVb1w5sZ2gqOREpDoL2+bWRc735fkGvkVxrl+QOe+zcHptrZovj+TX8coGmRk
	qPFKENe8XZbuZGL3m7WjnkmDMRE2AZTf0ZxemABU3DGNkw/YZOFitLuHPiM7zdoXoBNe15t5CVe
	SxVH4hgY2adktgAPPhIP1EC3M+Ps8g9RWk=
X-Received: by 2002:a05:6a00:6d59:20b0:825:227c:5933 with SMTP id d2e1a72fcca58-825227cd0f6mr2877924b3a.32.1771455190596;
        Wed, 18 Feb 2026 14:53:10 -0800 (PST)
Received: from ?IPV6:2409:40e3:308b:f961:7c53:a549:9942:a8a1? ([2409:40e3:308b:f961:7c53:a549:9942:a8a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2c881sm18213526b3a.13.2026.02.18.14.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 14:53:10 -0800 (PST)
Message-ID: <77e44b68-30cd-411b-b298-7f47911357e3@gmail.com>
Date: Thu, 19 Feb 2026 04:23:04 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sequencer: extract revert message formatting into
 shared function
Content-Language: en-GB
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, johannes.schindelin@gmx.de,
 Patrick Steinhardt <ps@pks.im>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-2-siddharthasthana31@gmail.com>
 <aTLDA11AKs0jlxFJ@pks.im> <ac12100d-4aba-4d15-8bcf-c50e6100c95e@gmail.com>
 <aTZ5RrjnwJ2ZnT7A@pks.im> <87bjhvqvol.fsf@iotcl.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <87bjhvqvol.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/02/26 18:33, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Mon, Dec 08, 2025 at 04:30:58AM +0530, Siddharth Asthana wrote:
>>> On 05/12/25 17:03, Patrick Steinhardt wrote:
>>>> On Wed, Dec 03, 2025 at 01:46:10AM +0530, Siddharth Asthana wrote:
>>>>> diff --git a/sequencer.c b/sequencer.c
>>>>> index 5476d39ba9..9f621aef4b 100644
>>>>> --- a/sequencer.c
>>>>> +++ b/sequencer.c
>>>>> @@ -2365,22 +2365,10 @@ static int do_pick_commit(struct repository *r,
>>>>>    		if (opts->commit_use_reference) {
>>>>>    			strbuf_commented_addf(&ctx->message, comment_line_str,
>>>>>    				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>>>>> -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>>>>> -			   /*
>>>>> -			    * We don't touch pre-existing repeated reverts, because
>>>>> -			    * theoretically these can be nested arbitrarily deeply,
>>>>> -			    * thus requiring excessive complexity to deal with.
>>>>> -			    */
>>>>> -			   !starts_with(orig_subject, "Revert \"")) {
>>>>> -			strbuf_addstr(&ctx->message, "Reapply \"");
>>>>> -			strbuf_addstr(&ctx->message, orig_subject);
>>>>> -			strbuf_addstr(&ctx->message, "\n");
>>>>> +			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>>>>    		} else {
>>>>> -			strbuf_addstr(&ctx->message, "Revert \"");
>>>>> -			strbuf_addstr(&ctx->message, msg.subject);
>>>>> -			strbuf_addstr(&ctx->message, "\"\n");
>>>>> +			sequencer_format_revert_header(&ctx->message, msg.subject);
>>>>>    		}
>>>>> -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>>>>    		refer_to_commit(opts, &ctx->message, commit);
>>>>>    		if (commit->parents && commit->parents->next) {
>>>> Is there any reason why we don't also handle `refer_to_commit()` in that
>>>> new function?
>>>
>>> The `refer_to_commit()` function depends on `struct replay_opts` and its
>>> `commit_use_reference` flag, which controls whether to use abbreviated
>>> commit info ("%h (%s, %ad)") or the full OID. This is specific to
>>> sequencer.c's interactive workflow where users can choose the reference
>>> style via --reference.
>>>
>>> In replay.c, we always use the full OID via `oid_to_hex()` since it's
>>> designed for non-interactive server-side operations without the
>>> `replay_opts` framework.
> Even if it's non-interactive, I wonder if we should make it obey the
> config 'revert.reference' as well? To me it makes sense git-replay(1)
> and git-revert(1) give the same outcome if that config is set.


Junio clarified downthread that plumbing commands should ignore user 
configs, so I think sticking with the full OID in replay is the right 
thing to do here.


>
>>> Including `refer_to_commit()` would require either
>>> passing `replay_opts` to the shared function (leaking sequencer internals)
>>> or adding a format parameter which feels like over-engineering for current
>>> needs.
>>>
>>> Happy to reconsider if you think there's a cleaner way to share this.
>> A simple alternative might be to convert the `struct replay_opts`
>> parameter into a `flags` field that tells the function whether it is
>> expected to use the object ID or whether it should try using the
>> abbreviated commit info instead.
> I was considering to add a bool for this option alone, but I agree flags
> is probably more future-proof.


For v3 i went with an optional `oid` parameter on 
sequencer_format_revert_header() -- when non-NULL the function appends 
the full hash itself, when NULL the caller (sequencer) handles the 
reference via refer_to_commit(). it is a simpler split than flags but 
gets the job done for now. I am more happy to switch to a flag approach 
if you and Patrick feel strongly about it.


>
> Patrick, I assume you don't mean to revamp the `struct replay_opts`
> completely, but only the parameter that would be passed into
> sequencer_format_revert_header() and refer_to_commit()?
>
> Siddharth, I see you have plenty of good reviews on this version of the
> series ([PATCH 2/2] in particular). I'd love to see you post v3. Or do
> you have any open questions you need answers to before you can send it
> out? Let me know if I can help with any decision-making.
>

Thanks Toon! v3 is ready, will share on mailing list thread soon. The 
main change beside addressing Patrick's and Phillip's review comments is 
a rebase on top of the latest upstream, which moved the replay logic 
into a separate library (replay.c / replay.h), so the diff looks quite 
different from v2 but the approach is the same.

- Siddharth

