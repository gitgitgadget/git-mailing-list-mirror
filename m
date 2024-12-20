Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449D1C3316
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692130; cv=none; b=HFZbY8thLqldFoYwpQ2RZTReBIPed7oepjaf8NSX6frhS5CgthKagXMPSFnxNnabEyqwN5JdaT3E8t/L5k56Q23Oi4SP6LTmpzy3NXvfhMnkzvnDEeh3U/xP62qihcRmCYmaQ1+5e9E2ZZ3VtTSXd+1FdNNU0TW4+LFPQkOy+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692130; c=relaxed/simple;
	bh=18qNwT3DjxoCcgxBKfKhrVFEQY8olnSGZTrCqbVZIe4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyeuVWa7Omx48qkcdC7VzdjymH0j8zWfesVEfcH/uhX3cBhUjj0NA9jUUrvy/ae9HpfnFAOfeyaJlsZ6ZP2wjZy0VMseL1BAkNCYykiovxji8jEu34VpvXDwPm3tQPorv6Iw8+ma9IJPdqFh0JVXqq4+pniS3wvd+uUp5LVjlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBHlGPFA; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBHlGPFA"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4afe70b41a8so504827137.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 02:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734692127; x=1735296927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gD2lUFPQcNAsEPDrjfdSCouvxyiJHtoPn1lJPfypI8U=;
        b=dBHlGPFAOcKSCENxPDrPb25Yuq+nmowJjkCrZV7Hn5iCQfWyBHHbkmJhwKN2tk8YAQ
         TOtMmeOAd7sUeNAf8OGrAZa9m8LP45FesKOFq6j+71Sy0AQCGO237Hhi63GAfk4PzRIS
         3WX1nmt6kO48RLXx3sjJsub1/Z7Q2n3UFPNtUczbmsERwbKDDi+EA67GcYqjgsVtc991
         tPzp0NYRpWkdls+5evO7vKzChPtZO7UZaLzcLoI0VGhtaqLrdsiEMiZhTQu87VfUgFu4
         vUP8YYbnm0LL7WQBDVIJ1G5Y+fw9wblqLOstu+EbVIJg66gWVf7J57xtC+1l25t1mFyp
         XUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734692127; x=1735296927;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gD2lUFPQcNAsEPDrjfdSCouvxyiJHtoPn1lJPfypI8U=;
        b=LB8HPEfv6tRjlHHL/oLO4ggp8Ofa3Hp/9Bj/GSpDJSaAknrMxjTrb5gCMMadQ4X19t
         I0Elaoja8wJpDVZBQ0buvyZVGTS41/vfqOh6pGH/BJ5w7PLGNW9rNnM+MnkLP0n4WBo5
         dygp2j5UE7nLPuIozKeHpk8OfsVZA7aPV8srHM075x+80ifLlPHXr9Nwtgwx57ZUcvuC
         6q3ytuZzZlvDgD5lP2Pn7asZyqvEhsxiubDxHheXmOekzyXE4wU1heaQ96vEKC/jHSrD
         mC8SYLBMU6PLbYjPzfqYvOU5JG0Z7xkQrBB68eQONsa2Jy9eVpqSLQcvgk0bEdrLOqCw
         r0GA==
X-Gm-Message-State: AOJu0Yzk0jUHeF/jbR10tfj9Tq5Y10Ilh83X2vVtXqQvJfDftT1I9qlP
	Pffe5DfAmK+9QEO98/Bv0GyfBYpjMCuywto/sy4r0C0VLgyXwTPGdsEuNi8kvxSuZ+2broTdJoD
	J0UFuQcTzZWXEXuYnr8uz+GYqGh0=
X-Gm-Gg: ASbGncv3Sorm/Bwh5RI5KOQ+uIsjlqBPMrdM/eE9g90JFqfgnuXVOQREfxOnAPZfUhT
	o3Ci6tJFoZds31vRdAtXWByN7pA/5RMU7I+rp
X-Google-Smtp-Source: AGHT+IH4S0JGfORNbAWEQz9qW2oD3Vq13GVRZyetVGlFVltZPCQiVruZWPjvZ7737NnIMIYfGQsIsm8BAAITcVpxU00=
X-Received: by 2002:a05:6102:a4f:b0:4b1:1439:b4f0 with SMTP id
 ada2fe7eead31-4b2cc45f0ecmr2007603137.20.1734692126668; Fri, 20 Dec 2024
 02:55:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 02:55:25 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq4j2zifmy.fsf@gitster.g>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-6-d7cd3f197453@gmail.com>
 <8734ijh3jg.fsf@iotcl.com> <xmqq4j2zifmy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 02:55:25 -0800
Message-ID: <CAOLa=ZR3fNRdGyYcvOBi=79WyOEr5VF7KD=p3JuGO6jUCfxANw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] refs: introduce the `ref_transaction_update_reflog`
 function
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000000287810629b17c2d"

--0000000000000287810629b17c2d
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>>> +		const char *what = flags & REF_LOG_ONLY ? "reflog for pseudoref" : "pseudoref";
>>
>> These strings are not localized.
>>
>>> +		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
>>>  		return 0;
>
> And the structure forces sentence logo.  If "reflog for pseudoref"
> were masculine and "pseudoref" were feminine in a language where the
> verb "update" conjugates differently based on its object, the
> resulting construction cannot be translated.  Rather, we'd need to
> do something uglier like this:
>
> 	const char *refusal_msg;
> 	if (flag & REF_LOG_ONLY)
> 		refusal_msg = _("refusing to update reflog for pseudoref '%s'");
> 	else
> 		refusal_msg = _("refusing to update pseudoref '%s'");
> 	...
> 	strbuf_addf(err, refusal_msg, refname);

Indeed. Will add this in. I think its better to prioritize good
translation here.

--0000000000000287810629b17c2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: af1760807b3c18fd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kbFRSd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFQ2Qy9zSDNmN1VEWHZKOGh3M0ZXaTMrd2pYL2c4TQpITTJ6VG9EVlRv
K1BRWlZRd1JsSWdCK2FOZVk0Sks3bTVaWUxQYWNqb0F5YVRwQmlPQ2lSbjhJL2Q5MCtCNE1nCmds
SmgwMFMxN1dOUk8wVmVDbklvR1cxZjBQZk54L3RpeGxqa2hxbG1qbllKaTdaS3pXMVVzWkM1UEs3
VjJKWTYKelpoMVlHNFBTYVp6UEZUQmhHYjJBcE12YWJHbmFZWGFKMTQ5MVh1VVVXQzRZdmpkR2U5
blRxMDEzc2l2Z2tFawprb1BLTWhZWnFpdlE0dWk1c09ZOXdEaSt4SFRGdUVjTTNIUTB6Q0Q0UXMw
VWRyQk1PWUJwc3JiQXE2bm4wZUxrClhQWW1mSjRsd3FWTnF6YkN5NGY0SVBUcUhneHBiNEF4R0RB
eVU4U1FGaEhteGNMbFY0bHpTTE5UcElQZXlsazYKNVdCVHRHZHZIUVdUWllaYmwrbVEwc21TdzBO
Rk56NEFiVHVkUXd1cjVIMVVxbi9FVDRVNXh1cmZHay9nZlFMYgpYZ1c2cGFkL3VvVXozUkNibit1
V2JSSDlkRW9uMTJZZkh6ZG9ZUVZlSVR4OVRUMXhkbG5ZaGg5dzdyUS9wNnNOCjhoRXJoRWp1bXRO
dWFRT1hMRnhQbFN6UklMTCsxS0o0ODJLZ1kxST0KPTRFQzMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000287810629b17c2d--
