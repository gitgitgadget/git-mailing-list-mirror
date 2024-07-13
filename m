Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10853389
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720873830; cv=none; b=CCWdEIpWWgEOpgjQlCUezpaOS4SZTXIjuiPJflLj/m2Z24su0LLWImLi8wH0IVC1ceMlpyMaRBVGVJMQzWjt37/pUsz73sMeAlvw4SPMeQHT/weYmNv+gXdWswsrqz5M0/WkA+rJEMbU2G5OiF3hREaKss3C2sy165xhXX35I+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720873830; c=relaxed/simple;
	bh=Jp5xsn9nx7JiijIojrgX0yvL1IfqO9jcaDMqUiN00xU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dl/O8VGnF2hE5+Hh4jwwCjmgFDW1NzhLi3K4Ebdpm5I8e06v9KhSnW8iVQ4YggyFVKXnjdeTrNW8hF9FdQfD2atv+hy6RDyrkElDs6Ci8QZSfd6TxiNUoEAedGaorebgxRR8y1J3s6vH0rL23EUYWPND2ROb/iAbDc4kXdFhl5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3yMU/O1; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3yMU/O1"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d6301e7279so1865565b6e.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720873828; x=1721478628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1ZMUFnYwcqChfuLKMcfkByHp4Ta7igewe3kPVJ9wuU=;
        b=Q3yMU/O187xZPLCEez6+ECKM61NUZsNcHeLvCXs9xbhhakIRpMXmq49P8mhphNIqWM
         GqC8ic7gXl48vJHdqxzRgL3fR8WAPK+A8kXBcl/5aNjUrFxyHglhYzmCAgqMK4Op9KB3
         OemvpDfUiszXIVj/kYuXYgYbkJBV9lX7TCF92SXq47aysPDCcD1yl7c8l64NNIFfOhca
         10vm4gTwwnno08PdgkCVzz/H5XDk6CL2foNM3WL6xGbFx7XJXLI49/5P8lqtYVPMTio1
         3J1V3Mu0lFqVc81aK1mgnky1QrJ52TOFDMdhP+cK9j/LlG+UEOPyf9ypapxvQz6UiW+H
         ccfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720873828; x=1721478628;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1ZMUFnYwcqChfuLKMcfkByHp4Ta7igewe3kPVJ9wuU=;
        b=jl+WHYI/fbKCthbMkfIkB6wdl23seYlKTF80yZROwTAdwjHHjsZIEMclXTUjXTa6Dp
         B86CKRixAzjdzalbH1N6t1qhKUyxjNDkkPNhOQD9UiGMKWURMpSXKuhvX0MEo1R5FWLz
         5/kkT4w/XXby0ixKM6T52/NbWw/XZDZy9Y2csm3hEtrMCS1ajwvchOX6h1HhaNhWSp4X
         LfWeoarLKxQciY83oCpVIHIIPHjesHkxIY7VbcmVt5qqX+wHLJoqPXQziBsR+Sqyya5V
         ykK6zDmceWzJmnNBhxM+/+MutwzbRxGFjIlsNwJvS3WPFES3tCbL/ryvlMpFG6iHf9k9
         pIIA==
X-Gm-Message-State: AOJu0YzNis4dIZ8HeWGkSGEsxV3gq4f5ZnlOhRvf0xAz/7biIUVO1OSc
	eb1DNKwYYQcYNKunPdJKiaggpUi46VHkULY9IIYg677hC3fOXMZ2LPCOmxUZwXm1H3gmCpDgDAC
	NdOmt8tVCqHZon8dnmxiukExgnc8=
X-Google-Smtp-Source: AGHT+IF/q3h/Mx25b+rR7typGyhVUB+1YIH9ljiER0kRdkYxSQYZVhDjmKCEOwVo2cvrqXIL9oMkhPvF7a3M9GyIoQ0=
X-Received: by 2002:a05:6870:1583:b0:24f:dc76:f6d2 with SMTP id
 586e51a60fabf-25eaebc8b75mr12126744fac.45.1720873827841; Sat, 13 Jul 2024
 05:30:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 13 Jul 2024 08:30:26 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <12830e1d-598d-4e7d-abd6-3349800e277a@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-6-karthik.188@gmail.com> <xmqqle2bj0dl.fsf@gitster.g>
 <CAOLa=ZSb_S7X7pdFPp0r5bfNc3o95mGe5pU+rC1T_yM89NRqCw@mail.gmail.com> <12830e1d-598d-4e7d-abd6-3349800e277a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 13 Jul 2024 08:30:26 -0400
Message-ID: <CAOLa=ZSrVOBkziX+z3g1RqudiLp=SN4gW=OL5Ky++KukPF=QXA@mail.gmail.com>
Subject: Re: [PATCH 5/8] clang-format: avoid braces on simple single-statement bodies
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000367632061d202968"

--000000000000367632061d202968
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 08/07/2024 21:25, Karthik Nayak wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> Set the 'RemoveBracesLLVM' to 'true' which ensures that we avoid curly
>>>> braces for single-statement bodies in conditional blocks.
>>>
>>> Hmph, two warnings in its documentation [*] sound ominous, especially
>>> the second one that says:
>>>
>>>      Warning
>>>
>>>      Setting this option to true could lead to incorrect code
>>>      formatting due to clang-format=E2=80=99s lack of complete semantic
>>>      information. As such, extra care should be taken to review code
>>>      changes made by this option.
>>>
>>> which implies it may not necessarily a good idea to add to
>>> automation without telling contributors that they may get hit with a
>>> false positive (or incorrect rewrite).
>>
>> Agreed on this one. I'm a bit skeptical to be honest too. I think I
>> should have added information about the warning in the commit too. I
>> will for next round. Overall, this also contributes to the reason why I
>> decided these CI jobs need to be allowed to fail.
>
> I'm a bit confused - what does "allowed to fail" mean? We don't have any
> automated requirements on the CI passing. We don't want to train
> contributors to routinely ignore CI failures but if they don't get a
> notification that this job failed how do they know to correct the
> formatting?
>

Well, it mostly means that the CI would show the style-check job as
failed, but the overall pipeline would be successful. We want to ideally
fail the pipeline too, but I'm being careful to not disrupt things
suddenly and I think once we see what false positive rate is and once we
fine tune this settings maybe over the next release or so, we can
enforce this.

[snip]

--000000000000367632061d202968
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b2c749540cb6e5b7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hU2MyRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHp6Qy85M1AyNEc1cE52TUxCa1grWEhTNkpLZW1yMAptTEF0YkRYNjZh
Z2Vzc21WUTFOMHg3bVp2T0JTWDBIZ2EvU0xaejNRQWdmYTVHWEkxVjR4WFd0Q0ZZN3lubjBXCkZq
VUdoWjdYRjdnM0FwcUNjNWJtY2xOaFhlVno1NUJzV0l5V05yR3lCZVpkVlRvbktSUmVzVExBUjNq
U1lUNlEKUWI0SURLT2RTTmhsTWx6bERSTnk2dCtVMy9PSmJCeUNvZStZcGREeGZFQ3JORTZrVDNz
eFF3R1hPR3dFSHNSNwo5eWF0cEhEcHIwdkRkVS9aSjh6Mkxzc01HelFoMlJ6WFlhN1lvUFZ1TGp6
cEZlb0pveTUvZzhVR1UvVDg1dWxVCm9VV0V4ckJKeFJTalZWQTN2T1pMSno1WmszZys2dXRTZEJE
QkEwdytHUzh5QzM2OGFGWjdKQ2Z5UkViVlFqaEcKbjNOdlFRbFBuWU0xaFE3UUJZU3BTMlFvU1R6
Z04vV0hKNGo4WWpSazI5QUxWM2hkUjZGdFhxNVFWMVYxYUNFYgpDRGVIV2htSTRSUzZZZ1gvUmFE
dElERkV1YUc4QU1uNnZvUFhURlJLM3hxMy9hMGRiYnUweFl5YXVwVzgyR0VDCkhBS00xaEhrQk1l
Y3g3Q29tZlo4ZVkxN2pzbGd2M2lHUzZxRUQyUT0KPWFTV04KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000367632061d202968--
