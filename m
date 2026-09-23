Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FC38D6A2
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173358; cv=none; b=hvtzl9imrBfG0CM0MT3LUPrk8Nyj4L4w7/cfF8+C1+LCzRn12djEoh/0QHk4WSZy/q7MV77kGNrdx5gvyuf134ERAYrpshzFZW0qDxOkhjs8qCd/KNBjymsbK8WaDZT5aaYiATUPUZuRJipx1IgboM9qFIF9bFVAn/2CeqPSJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173358; c=relaxed/simple;
	bh=+xiPpFr62r7BB692XyucJl7okIRZXHFwwhX21nAzPXw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BwoKyejn5eNsH7n/8vDc83/NakJyzTw5tcQa7l9LrtvDMVKZeePp3BWr6AWJZFveypqNbHmKo4t6FtalENuc6EUdnJKgPTPG+/fWjb3mwIHu3rvPav7FauuSfv2gedU7sjMUeJflp1w+E4qDkJGa96xyQdgqXt+/ELrPOuKcRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9Ax34LV; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9Ax34LV"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so122107766b.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790173355; x=1790778155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mR/tnKslMNjTE9rQ/QzbPgHNsO2VohTg4pSJpu7bW5I=;
        b=M9Ax34LVumWITnNvF+6zG58dkJqiUGhxyAN7Pie5KTAdgZvlUNoP6lpjlJiM+EXlRO
         geE4pHjtXNpUe8TNJ+kw1TcqXwMrGbjakemi1k7p/UZnDzCjJ4++NY7eceImx0Vf4fMU
         GwIL54iLy672D6ySVBOel75F4t+orhrmozD0MniP4v3hVuJsmkw/aQIOdvA6Mx+3MYsX
         OGFecf8zhSZM4A5cB7BAR0ffT/cg8/et+lkON6X+JXRv3lMi7cHT7tk5+9EWroOcZOWn
         7lzD19oi0SQ91hlYc2f8jPGm7h8NGMMSKfoc9ljSOPACDbhIOzT4eweqUWl0cRJ+epxt
         NJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173355; x=1790778155;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mR/tnKslMNjTE9rQ/QzbPgHNsO2VohTg4pSJpu7bW5I=;
        b=0xc30C5OT6nchoxBWt4owHJRW4MJur0IvbvOo17Suq7as14FA9V3mvxjk1c8ld6m0i
         uDQua7uUwZ/B1vLPFiXgrrt6KXL1870uaSGm3mqiPNHZ/vwJnYcF01PfSOEchkUHDQJX
         bHMKtX/TN/qltQ2rFZ28+4Rr1K3Cr+YBib8P8fgraPpGQUgkL37FXWM3p9LN2jZFB4Yc
         HUUZN0lgFrWGbwOlqi1rCoCdz4Po65sYgYwsuhbKpp9AyNPJJrlTdv75YozFRbocqdqY
         3h0WBEQQ8e9/q55rkcjdOgtEPLuwFOYZQuhAJuxh7Yavu7GYpduCRZrhwUFk6Kxz7aA3
         +XDg==
X-Forwarded-Encrypted: i=1; AKwUvByuXGKTBY+Dns5PrWUHHjokTrg0IMJZaGmPMUjB3rpR4c1fPkMZ2sSqINiSJPRd4R2DJuE=@vger.kernel.org
X-Gm-Message-State: AFuF++kvsygLV6n14/gO18agQkPeDzcGCZm4q2Jjhb3r8tXz91ylHvqg
	tE+UqmMCy+8eV07uL90ERP/eiUbe7QF/lXHgSnieq/YFSdVbIyMzSkvA
X-Gm-Gg: AYBFou37tQURepQ0w9pjI/br5ovPnZy5Ns5t7bbiqce5LfUJtQem0s5Cp0fAHZFe0RD
	2ZudsJxnnk9NPvIIc5gnYqyfW4Jo1Y8vNpAui16H0HJSqymQ0UYytG5y+1KCl1wqr6J3OlWD/+y
	TJe4hpSR/LVGJH8ob1slEKVDAhsM03Y+cEICiLeCB2SzLxF08OVMon5tga/Ya+Pop0j5Fe7dZkh
	+xiKqPwsoSvGitPpg6TOPNO+doh0IYJ3y4IlE4DmXLDj+IC0/+vW/DHJ5MxOJitDtgh7lSCKGtT
	7oLMWlZU9BT4m/YgeewiJBykw9vBxYGDAf4f2wA2G7YSAFtixdY0L1TKT+NZmohE+IAGyxsaIiA
	oANWBm9CsfmVTka2CJSoXAdcrsysePBzXgsIHJnE+mxGySYEaFG6G0xI0NdkZh85ExQ1TAN67Az
	0PhIeioL0scnEXb1gvICuOSP8nC7fIby5IbCIzbcLFGnpGoo5n5DB1H+GjkVDX2z5WWFBGvekr7
	DzijDvMmWqPXQCLh3/b7KDkj4uL5AfPQE5FHOZQFH01vLkv+v7zLw==
X-Received: by 2002:a17:906:6a09:b0:c21:450d:cd7e with SMTP id a640c23a62f3a-c2aade19376mr236450066b.9.1790173354822;
        Wed, 23 Sep 2026 07:22:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c89d7sm132889666b.10.2026.09.23.07.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 07:22:34 -0700 (PDT)
Message-ID: <24cc4bcc-1d26-46f5-a502-ba673713f4f0@gmail.com>
Date: Wed, 23 Sep 2026 15:22:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
From: Phillip Wood <phillip.wood123@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
 <c12d2ac3-5263-4301-aa64-a311a343dd40@gmail.com>
Content-Language: en-US
In-Reply-To: <c12d2ac3-5263-4301-aa64-a311a343dd40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2026 15:02, Phillip Wood wrote:
> On 23/09/2026 14:16, Patrick Steinhardt wrote:
>> Instead, use the existence of "MERGE_MSG" to figure out whether the user
>> has already resolved and committed the conflict. It feels somewhat fishy
>> to base our decisions on the existence of that particular file, as it
>> really is only a proxy for what we are actually after. 
> 
> I think that's probably the best we can do. If, after committing a 
> conflict resolution from "git rebase", the user runs a merge/cherry- 
> pick/revert that has conflicts, then "MERGE_MSG" will also exist, but we 
> don't want them to amend that case either so it should be fine.
> 
> The code changes look good,

Let me rephrase that. The code changes look good for "git rebase", but 
do we have a similar problem with "cherry-pick", "merge" and "revert"?

Thanks

Phillip
