Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D9B281531
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404377; cv=none; b=FVbmvy4rvPxip/dNd0q8BGil19rFr3jdVNmsSc2PG1WoN71cUUzbRCXIizsbZsXDNvnBsFX7kUSdRjjX+ZQyLD+JGTux4/WUF/getIjZ55BzCMDUbxYIP6Ju9mshoe/xLStI0vX7BOoun0c9qpVAWtJVJVo9TNTxMzl8C2KmmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404377; c=relaxed/simple;
	bh=x0Eg0YSVVEg8aZTdW/HTLj+fc8mdZEr7EEiviAZySg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahkNm92SbVI7e/GrLoE6/JR6FGkGJ/5gD0FrJAothmYpNwbwMi0Nh/u3i7q1asMzoV0x6nPmkr2cngX/v3CAkw+n1I7rrwk29zNifgsY8UNNxYVPt82kvlYfK24iWGZLfBeRb0ZT/2kIzr3shnqKzMix86qjs+TvUgx6br5OUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMX78P8H; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMX78P8H"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748da522e79so2418153b3a.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751404375; x=1752009175; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+U+CZ+SABj8F0o9nTGF89xztyNyKcLu6JLJQw0NgfE=;
        b=WMX78P8Hvx5MxWR6b/vRSsh0vNsBDMYc7WSd7+4R99PjgHclE3ZfJSHjtNQxs2Jizk
         WyK/H6V1uXYYQ9l2kYxW2YJ5lefuqyl0NOI80wL6QReyaT47+76C2WZwv2frJ32kskEt
         NE1smB9TonNsaJa8dsEeUdo+xfyW189EwTXWV6+mDa+kduOhbSIW8onzTfLmpD1KEX1S
         KcUJQjThVCxTg6/t6U08aM2tGF+Vl/FBwfBnNMuiXXP2sAG5rrmJ/c8ZgK0s9MImckSy
         B/2Y+d/Or5bAWwbDvSIsmTV2H2RFNeZ86pn83+TusuwxjrEXaU/ES4roBmrc7n+Xto18
         8eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751404375; x=1752009175;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x+U+CZ+SABj8F0o9nTGF89xztyNyKcLu6JLJQw0NgfE=;
        b=YpkE0dKkUdF0lW9PPC4eJi/xce2rdM5ovaWnCwk8M3gavHCf8i9X5di6N8AkAf+fNk
         wYbktTkPMqWWhsuIWqsIPz1y1ZRQc6WQ5vpzYAkohJ748Se7ZTWCtMPC29drpWUwQ20n
         fZ+TG9jc4K5p1iv9Y5ztZ/3tLri0+bRxZwR22tptJWIsy94fKI5DtMM17nipaRRCBkma
         CweOY7iqewF7O4o8SlBvjLuXNruJIrxLzuxKHCQh+HF5TWiKcvXHHeDH2iqIECeJfrpc
         EwmnKs7nVQCEPfLJaTSGcPV8bgLXZJ1xYaVUCEckm7+Y4JBpiNbiEgCTYr5uqjwIfufx
         wdVg==
X-Gm-Message-State: AOJu0Yw+q5K7I494t3Oi+6AVagk2+VQ80kGcc+ZJrfIVsZ6tgPwn+qah
	R9oM8/ncLQBzGhTFSda9BO8ULb44857EzDyLihFe27K8KKqT+KnD1EfS
X-Gm-Gg: ASbGncvzsibopIw6h/VxIgE/ahS45AkCBFT7z0RXXyWmkdkGDdYhP7ZXqSPrZROgDur
	AQVNsybf871ZgqhmxNgsajpkylsSaz4yknIXlCylGnxu/koo2o94n8JwBHUVtocSmDuCvxRCcEm
	WsmU7MQswBJaL892Mu+U3xhKXWddTKErLfJwWIv54msr8Mt9bNXKMP9NreSkPGdSpBx2hFhUFG3
	UqMlkqxu8TpcQsoIub0Q9c27VfIZH3cmk/SAxXOzfdh3R82d88PKhDQG0unIUtUAsiywU2t/qtL
	LsnAa6ZTNl5uDiEDn9WUzByyHmWCkRE1BUiLFnBZGVSKiPb6tPdobkFvCdppEjYSK0RChRjS8Jx
	9SYTwVb1Mo230KySRZo1YQztX9c8=
X-Google-Smtp-Source: AGHT+IGzUm/jlwdOtIpbjnrPetWIYz5+yagkOtvvNmSmrSXlqC2ga5AVVQVdbIWRjGwFgARopTGdEg==
X-Received: by 2002:a05:6a21:62c6:b0:220:82c7:309c with SMTP id adf61e73a8af0-222d7db195bmr999739637.7.1751404375192;
        Tue, 01 Jul 2025 14:12:55 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af56cffe4sm12129740b3a.138.2025.07.01.14.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:12:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
In-Reply-To: <753b6548-9b7c-411a-ab39-adbf769f83bd@intel.com> (Jacob Keller's
	message of "Tue, 1 Jul 2025 13:36:29 -0700")
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
	<xmqqzfdnkdx6.fsf@gitster.g>
	<753b6548-9b7c-411a-ab39-adbf769f83bd@intel.com>
Date: Tue, 01 Jul 2025 14:12:53 -0700
Message-ID: <xmqqwm8ripii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> On 7/1/2025 10:40 AM, Junio C Hamano wrote:
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>> 
>>> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
>>> index c6e0e9d05186..61486e378cab 100644
>>> --- a/builtin/send-pack.c
>>> +++ b/builtin/send-pack.c
>>> @@ -343,6 +343,7 @@ int cmd_send_pack(int argc,
>>>  	free_refs(remote_refs);
>>>  	free_refs(local_refs);
>>>  	refspec_clear(&rs);
>>> +	oid_array_clear(&extra_have);
>>>  	oid_array_clear(&shallow);
>>>  	clear_cas_option(&cas);
>>>  	return ret;
>> 
>> There is an early exit from the function that would bypass these
>> clean-up.  Perhaps something like this on top?
>> 
>>  builtin/send-pack.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git c/builtin/send-pack.c w/builtin/send-pack.c
>> index b28da7ddd7..6ce9f6665a 100644
>> --- c/builtin/send-pack.c
>> +++ w/builtin/send-pack.c
>> @@ -305,9 +305,10 @@ int cmd_send_pack(int argc,
>>  		flags |= MATCH_REFS_MIRROR;
>>  
>>  	/* match them up */
>> -	if (match_push_refs(local_refs, &remote_refs, &rs, flags))
>> -		return -1;
>> -
>> +	if (match_push_refs(local_refs, &remote_refs, &rs, flags)) {
>> +		ret = -1;
>> +		goto cleanup;
>> +	}
>>  	if (!is_empty_cas(&cas))
>>  		apply_push_cas(&cas, remote, remote_refs);
>>  
>> @@ -340,6 +341,7 @@ int cmd_send_pack(int argc,
>>  		/* stable plumbing output; do not modify or localize */
>>  		fprintf(stderr, "Everything up-to-date\n");
>>  
>> +cleanup:
>>  	string_list_clear(&push_options, 0);
>>  	free_refs(remote_refs);
>>  	free_refs(local_refs);
>
> This addition looks good to me.

Thanks for a quick sanity check.  I'll queue it on top of yours,
then.

