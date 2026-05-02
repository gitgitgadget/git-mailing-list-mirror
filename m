Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F2282F06
	for <git@vger.kernel.org>; Sat,  2 May 2026 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777716021; cv=none; b=V2FKpm8mJJQW/WRDhWJBIoaUKgZkbtelAJD3nIdRYWpvlvka0zhzeDhTLteiT+sOnQQzbwhL+uAeBjzW7VNSCGuCLEHpwFmJc6hwB1apR00VKRSwBETR4HxrDYfWScl+lCVy0hU1Qx3x1z+AMv58RIOa1w/v7THnv6pOJtfweec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777716021; c=relaxed/simple;
	bh=NV9MhOuyXJhEbqEhHWtfHyymLg4vzVnMkQnJJDQBbIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WD++jB9Ng1+I2i4PPB9vNLl5MEUPPI3sRwj07n0k+kl46tXXJq5JhniJXBJueSW2FwrD+bJrrwFspp49yKTJ35vxXXhLFQ1yF3B5gbjoSZAfiKMIqS9n2aszi4LNCO26myAj7sjlxtbwGbp3Du1RzwWP039GtGzKVhsLNPnbd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFG7T7os; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFG7T7os"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso143678f8f.0
        for <git@vger.kernel.org>; Sat, 02 May 2026 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777716019; x=1778320819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/zDnYTMwcTAldix8s1js5hw6tnAzjezmlv0TuHcnE0=;
        b=VFG7T7ospGpPh5+bVG6VzywZNqY2xAXYsHevMy6vH/UJic010nsdBTF/BeaezxwhY0
         ts0zZid52gFcv5TzWnNX6t0FPSARKKsn7snW1XcobIAT7ea78y6rzNHaBwQKsdA9IW6G
         jSTxoRSBXT6CfXbuYltZ8rMYLxetIi3/v5JmrY82s1BboojRsOrSWTaUfk2VEPqV6PYi
         cBhws1c8Pi2zDKAG+8ukqbINkbTlcSS3ARWmVYWjDca+VqO+xuWEtjUSt7mAZZF1T/TV
         A/bUlSv+UFLdU/Dz2VHZvIKvOfPcVv6ATEMNZrvpRAmUmdqg1MsZYSNsaXvAae0VaJLc
         A7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777716019; x=1778320819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/zDnYTMwcTAldix8s1js5hw6tnAzjezmlv0TuHcnE0=;
        b=U97MQ0eKvMMJcQox+5KdXAyCaBPM/TUG51ENApQKvuvh6WfLzZI+mcGHLTqAl2FIbx
         +KybkIEoJrT4+utGMDOkPC5dep6g050sX7Et9UAcv/134q0t/hbFwbRcinzEO/HwkPGH
         ubFxnSkh4utNMbxTs4AqpfegECD29kOOlCNcZRXAPF+HnQltYOBphvl/OwvavJEQUXEg
         /xsnKhEegXqfZEqsMVeJgEka4wvX2LjKYLBua9BWt41u06zQH4jtC67PDPmJvyDwr3FG
         rJWI70HMbNM9r2RBdNJ4stS/nNlQgJQtrhvCWpBLLr/7CTjCQ7BObX3qEj58zNfWedzl
         wRSw==
X-Forwarded-Encrypted: i=1; AFNElJ9RNVYu/11LK2X08BU7HJG2Ms9pisnvj3CjfQ1pZiYtZUCt3cIR1PWaR01S0a4Is087990=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXi7sHiNdVh2M8n7FoNpRwFTHUSAvx/c6UM/kJgPYM6i1Db/E8
	UZ/XcRwFKTXGKjZ9f0nh3j8wucfYuZtfLWHZfUogkDilICNP6edql7oh
X-Gm-Gg: AeBDievdq37nSy3rdzQM2RfzEfE9k2ZE189idLtfD/Rx3wZMjuRp042ec1hphfrBklS
	2ltMWaLvHCBhKUiwiNespqx6qcC+Yk0NsfkWmnNyYG8rhbxu/wkSitTDCy8awzoYcRYVB+FvNbd
	pLXEiw20FzXM+RujDRnRMXO8cCfIN0hY12iG2CgvNf+esih/aGsKGxsNWzGe+vs2qLTOTZGxo8h
	43fM4FZT1eG7xTbY7oup6iQclQvArKi7vaYMyZBTf0OBoUwBXRUwX0hCHRAPV/CbgjgnJwdWf6i
	nQITZ9ejV7gJWfIAHBIrEg4YfeztO/lsIpdC1YzMKpnPCcKYBunwrEUjnzXCpFzD6PNXw5+VKj7
	CpY4DMjMCIMgklg6XNXrcxojHh7u4wPRgkxrXDO8r7A/cXZZvrTSnl5BAZe6RcJzh1IN8CylBuS
	Ih1zooqwN8F2uxXkBybRXhtmwT64yDaUigkgJPToAbsCM/0mpGAtZnztXMXrRyxSW/C0UbC8y65
	HibDgTSefILYmSRDUNBLvxM
X-Received: by 2002:a05:6000:26d0:b0:43d:67d1:2022 with SMTP id ffacd0b85a97d-44bb4539885mr4315405f8f.19.1777716018153;
        Sat, 02 May 2026 03:00:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1706:1a01:2df2:6378:5a72:d2d2? ([2a0a:ef40:1706:1a01:2df2:6378:5a72:d2d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ef52854sm11056661f8f.12.2026.05.02.03.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 03:00:17 -0700 (PDT)
Message-ID: <65e013cd-5bca-4340-8018-bcbb44371e4f@gmail.com>
Date: Sat, 2 May 2026 11:00:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] name-rev: factor code for sharing with a new
 command
To: kristofferhaugsbakk@fastmail.com
Cc: ben.knoble@gmail.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <8016697f-9eb7-4c75-be87-d9479186919c@gmail.com>
 <20260501172450.25037-2-kristofferhaugsbakk@fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260501172450.25037-2-kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/05/2026 18:24, kristofferhaugsbakk@fastmail.com wrote:
> Hi Phillip. Thanks for taking a look.
> 
> On Thu, Apr 30, 2026, at 15:54, Phillip Wood wrote:
>>> [snip]
>>> @@ -524,25 +543,32 @@ static void name_rev_line(char *p, struct name_ref_data *data)
>>>    			const char *name = NULL;
>>>    			char c = *(p + 1);
>>>    			int p_len = p - p_start + 1;
>>> +			struct object *o = NULL;
>>> +			int oid_ret = 1;
>>>
>>>    			counter = 0;
>>>
>>>    			*(p + 1) = 0;
>>> -			if (!repo_get_oid(the_repository, p - (hexsz - 1), &oid)) {
>>> -				struct object *o =
>>> -					lookup_object(the_repository, &oid);
>>> +			oid_ret = repo_get_oid(the_repository, p - (hexsz - 1), &oid);
>>
>> It would be safer to restore *(p + 1) here rather that relying on each
>> case block to do it.
> 
> Yeah, I didn’t want to repeat that bookkeeping but in some iteration it
> looked necessary. But it’s good that it isn’t.

It looks like the printing code is shared between the two case blocks in 
patch 5 as well so we should move that outside them as well and just set 
"name" inside the switch statement.

>> 			*(p + 1) = c;
>>> +
>>> +			switch (cmd->type) {
>>> +			case NAME_REV:
>>> +				if (!oid_ret)
>>> +					o = lookup_object(the_repository, &oid);
>>>    				if (o)
>>>    					name = get_rev_name(o, &buf);
>>> +				*(p + 1) = c;
>>> +				if (!name)
>>> +					goto start;
>>
>> The pre-image uses "continue" which will increment p - why the change in
>> behavior?
> 
> They looked the same to me. So I will need to think about this some
> more. Just a lack of C experience on my part.
> 
> Replacing the `continue` with a goto at the start of the loop was also
> unnecessary. Of course the `continue` breaks out of the loop and not the
> switch-block (unlike `break`).
> 
> But I didn’t break `t6120-describe.sh`. So I’ll also take a look to see
> if there are any holes.

I think the difference only matters in pathological cases as "goto 
start" means we end up looking at the same character twice but the loop 
carries on as normal after that. We should just keep using "continue", 
I'm not sure we need a new test case.

Thanks

Phillip

> 
> Thanks again.
> 
>> [snip]
> 

