Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E562F3C37
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358676; cv=none; b=WKi3e1AXaftavEXd63femchYf29DbqVgWyR7rIkSL+Fd7lpeImgSeY3v0I1e4PGjslahu3oc0AOlx8kgM68afnAIRCwUPl3MkoAzeX1ZZhK0dzMp6rr3VnFyapMfj30G76W8FLC4nCljet5QFBiV8cXNk7n+Dj8Jfh+IKAm39TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358676; c=relaxed/simple;
	bh=5XVkEnH/KWtcRDg04g2sQKdR3fcTYITuvWP8MI7APaY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mNYjsYm1X5U6SJoY0yFgw6rGhLWnwTdIsD5LAL1q3BLN+jI2CsB7h3Lhhzl7F5tkJYnKK22PAfkkFa5EWzFo5FSS7jhlf7Q2Tu5vdi/cuLsHbZIbaJfoYkntF6BUsRoPD4gPiRrzvOp5HmdyCPK0sHPyxewq5fI1sPzIQRzSypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxXDNjVg; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxXDNjVg"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-34182b58c7eso787736eec.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790358674; x=1790963474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z6MdepKHqJjj3QQ5iP/ezKbO3O2yTcfxSr2Lg4OqU40=;
        b=LxXDNjVgg/tlr+yZtz+KPK2q8R2RRv5sn8xt7xlqeenmv6CizJCfw/hTCbBpiHcuyX
         p26Y8TwoNKWyBWfUsrNl+SKw5BTnAQQcpM97XPLtiAOaFHg6IdbNpwQsboI5GunA2uKu
         UtYx3GNFkhWdVVUs1GOOWYURSZjHUFYCde2wumAaGCqnCQht0S4FAENxFh7KSTGlMOsj
         4+Qm3HvZ6bICqoKuZ9HYcAHNMnT2SmMBbJ4G255FXFH/oZoJkKNUSuXRoX0nzlcyBiNw
         jAo9BsmKGOtBWfnDtA342vexuDCu8L0xJj09w6FBWa8YFW9fRUy0m/OLjbuujYbAR4ix
         E+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790358674; x=1790963474;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6MdepKHqJjj3QQ5iP/ezKbO3O2yTcfxSr2Lg4OqU40=;
        b=nRzMWYVEOvqThAAmibGbfs+05+Tv+heu3DwT5PjI16yiLJOL3guo+kqr+yGdrI/qTy
         Xmb8SCWoAD3T/SxPNz78M/R9IQwYGj3IfrLraFAGeESs8H9jAL47kIJ9xeABKWWKfKHg
         TtQ01gdqC/0j27JN8smcIdOnLO6uHVjbk0cR1pwQoc1Ku+njaQTci53hZ7HRXn9t2xu/
         EPtjRE+frhkyL41yfLgkDhs9S6KB/iwf3FSvemAkYfhYXJzacCjqNiIDW33oJ6SCHR2C
         nDQBLcgOKr1hfXR8RL4HnGHQlid/8oTV05EWF8h4eGqUPHX+9GqmIYM+4d8tcLJ7c6hB
         Ma4A==
X-Gm-Message-State: AFuF++lVdMdki4u2Zo4qDrXMMoWUBPOR9jjSIG5nMUDguHkXmiLx8v0a
	f4mo+2UYmozcScAiHtUgB//moe1S/OeOoCM+vP9V0ywuYACzakuHUckt
X-Gm-Gg: AYBFou3tx/8cCDmlphHuHyo/0Lmnd4dA4iTBZDlrEeeMRVpXJeU3UkhxDG5hBHZR02d
	eSeNuD9AH4TBGkAgLW8XUNghD+CNCIJ4XEdOnCAAl8vk1BJFPePc6ljeP29OMnj114igviUYxIy
	YMc3wRwRRdpdXt584zoIXswiQ4jpGvuEjepgD/hPlB6hW15vJ/NFU5seK9lMxRLFbepyj4I1CU5
	1TTFQ+8WlVDosvbZ8m/lgqGGmG0tNVlghXCxd6y3HP+ED5xGFdeXkNeYhIpcjjqPnFdksEHTril
	/l5DpRTFS3wVjx0o79zLxKMdG4nj6GqpBoizms49NAv1I8RcDxKqe53M90pyKFKbk2K/lVYwgBV
	Anoaa1tl53hCplTcrM+FqlGEigReOC6ZdChpGzB42rfizd4Oipen+uhD97agQbec5ziuXCLD6IX
	SzqxuqeLf8yeXHF3Cpz4lA02ObpBogaGntzEvOQVVyFO++K992jBoYdeGZD6ZB37xr8JGPRIapw
	kHVbNi2/zkk0YFU8ww+HhWfy0StPjsBzAH1uX+JlExUXcxXc3I7QA==
X-Received: by 2002:a05:7022:282:10b0:139:f6bb:c8e7 with SMTP id a92af1059eb24-146ce29fdf2mr729965c88.8.1790358673656;
        Fri, 25 Sep 2026 10:51:13 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:7269:1fbc:67b4:5dff? ([2406:7400:12b:61a6:7269:1fbc:67b4:5dff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm5805161c88.11.2026.09.25.10.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 10:51:13 -0700 (PDT)
Message-ID: <c7808d4b-36f8-4583-8836-7b7d8bc24905@gmail.com>
Date: Fri, 25 Sep 2026 23:21:08 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [RFC PATCH 2/3] setup: introduce new helper
 'is_git_directory_verbose'
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260924120502.2642141-3-kaartic.sivaraam@gmail.com>
 <xmqqcxu2z4cy.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqcxu2z4cy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/26 03:41, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> diff --git a/setup.c b/setup.c
>> index 0d157ac254..b3b53a1cfc 100644
>>   
>>   	/* Make sure it is a "refs/.." symlink */
>>   	if (S_ISLNK(st.st_mode)) {
>>   		len = readlink(path, buffer, sizeof(buffer)-1);
>>   		if (len >= 5 && !memcmp("refs/", buffer, 5))
>>   			return 0;
>> +		if (len == -1 && err)
>> +			strbuf_addf(
>> +				err,
>> +				_("could not read the symlink HEAD at '%s'"),
>> +				path
>> +			);
>> +		else if (err)
>> +			strbuf_addf(
>> +				err,
>> +				_("HEAD is a symlink ('%s') but target"
>> +				  " lives outside refs/"),
>> +				path
>> +			);
>>   		return -1;
>>   	}
> 
> All of the above (and below---ellided) look fairly funny way to
> indent them.  If you are trying ot match the style used in the
> existing code around the same area, I wouldn't complain, but I
> didn't look beyond what is visible in the patch.
> 

Indeed. My bad. Does the following look like a good indentation style 
for shorter messages?

	if (lstat(path, &st) < 0) {
		if (err)
			strbuf_addf(err, _("could not stat HEAD at '%s'"), path);
		return -1;
          }

... and this for messages that are a bit longer:

	if (len == -1 && err)
		strbuf_addf(err, _("could not read the symlink HEAD at '%s'"),
			    path);
	else if (err)
		strbuf_addf(err, _("HEAD is a symlink ('%s') but target lives"
				   " outside refs/"), path);


-- 
Sivaraam

PS: I'm not yet very sure if my MUA will send this as intended. Will 
resend if it doesn't. Excuse the noise in advance.

