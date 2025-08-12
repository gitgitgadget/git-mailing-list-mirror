Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9B2E7658
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989738; cv=none; b=I4NFGUbBJ4i5hDtaQEy/MN9u40NzvzZ0mq+dIQ3DslI7GJNmYpv5G4Lw4MxVTVkFNaDVEv1ywznEvNaaWZUo2HLDDaXWH3vzwXOo/z78toGOBC8zRJDiFSH5YpBvdlL0x62vZKMtjLFUw1ipPfXnUZ/2Eq7YZjQS8vHrKMVL7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989738; c=relaxed/simple;
	bh=4De2VPZ2KGK7hdPfQMWcCElFtCtUaJOTDe59XwxPHoc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBAuXTUx3yRmGdUD6TsJQbWfkiYM9UpmXkWmdAsfyRIAUeGGHM5hPe0+pJaVYWJF/boJb4S2ULMajOWuln6/mUHOMU2rOnTjELofMRFw3AQHpb5wHzFUP4f558vW3SrTeK1I7ahrGBcDwXNGWCXgi9V9BbbvTR7Z2Fdtw7rgiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQApd40u; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQApd40u"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-88e54605501so106541241.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754989736; x=1755594536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=STWeUnQqm4pie0v+c4NqgGhM2JVbzSUSUni6fYUWfBE=;
        b=bQApd40uj/60RrYiiDJaCTRg6dI5r4V2e1RFQF9rVijEfrI2T0SGee1AnEveP+1ha/
         9vdyiVY50qA5fPjnYi50PuOfZ+Q+K+FaZ7OxnN4FLFdMuX8746ahg6rkwtyCzfc371gL
         he7NzttSYJfh0bOattoRfLeVx3KWIlcSdJNhgsgXexFCMKbm1TgBf7pLQvyUbwxSJIuV
         gqWRAyhRkjv0Ipzqdm2+wQ2WIKa5AqmGZqMvWqvrwkccJPzfvoWbnEWSuS089ce0/pbo
         yqsfAS8zFoVl2IbjezH4nih070Ich5+nd+B4RyUBNIbhEDNNGKIlj9roRgRUZNoaiIsC
         UFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989736; x=1755594536;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STWeUnQqm4pie0v+c4NqgGhM2JVbzSUSUni6fYUWfBE=;
        b=AMA+yJylQItPVfroZTnBipu1TARGK9IuoHaiNxv7UVf0tPYToZe5qOvIgNJaZIT8F3
         ddpm4sleYiBMIzW8rb7lOATbqgM3/XsTeJ/XxLWRvQffVGSGa8GWONE9s6fu91Go3Uhv
         YjESwAIGh6alHLnftIr7pOYMiIk57xGA9CLMIHBPiSH5bPcPnU7QjDeZ0XxV2kbsf11X
         3z3+5onXEtcqbGRkwza4zKPLuSIFTQ+HHapWwD745poDUsuqUD7iKhetH+hw5gmV4OsU
         013/SXgRZyV/RdVRIytu56Gzb4myVLWAHyEDJEPz/XczzmweSXPJ780mucwVDTaByhc/
         CgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2vmKGPZfi4RfVtK+1/JOLS5+8VubzG3B0mxFngCJ0L8eDioeOY9u8xMRlTWBDj15Iyxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpEyq8ZiVbNXzvBS1TnnuY8LzSj8oPzpPWaoq97jgvVrYfLTi
	U/Z5JKa7eiYRz5SndjK9H5MUVf6MrOdfgPjpLkWvW0lhnET4ZqBEy6y9fqlO01EzAT3mRnG17IZ
	EdcZNPMNQAUKzUk4kNdYo31o3fzJJwAQ=
X-Gm-Gg: ASbGncteoI+TNnvHbEwqzJAst3wJs3g6E+T0DRJjFOfoxdAx9Ly477SC6wRMLDQPN19
	mNRNeuVVC+nkwNLHbM8GHAGQWad4T1SFaPfE7wmSKtVwjgjI0JVppvEoLu8OCR0r1+Eko+/emdn
	qWnrWEt1ZBazox0B4hs3PSNzPOn7r9HUqv665kmWngTLoe9BHhEWLKSEzIF/2R3hOldCK4rzQdM
	69c6u8=
X-Google-Smtp-Source: AGHT+IHzwVIESEtQdP30oBrGslIrVk6WVEs5tVMiMnYqJx9Cw7vo8fDrABgNi83hJkaALTbK6ttrln3J8wG469p6EBs=
X-Received: by 2002:a05:6102:2910:b0:4fd:5c41:bfbf with SMTP id
 ada2fe7eead31-50cbd4cbfdcmr1203515137.7.1754989736120; Tue, 12 Aug 2025
 02:08:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 02:08:55 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 02:08:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtt2d3l3c.fsf@gitster.g>
References: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de> <CAOLa=ZQqY8MDTs846mkVsxXrmOmC5O_sv6BxUHqYjGk1Ag+Osw@mail.gmail.com>
 <xmqqtt2d3l3c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Aug 2025 02:08:55 -0700
X-Gm-Features: Ac12FXyAok-OnD6AefuaZ38H5RfoXRhmn9kjI78HJ49-1iTaCBxR3aktMKcqfCk
Message-ID: <CAOLa=ZQGaZA=Yynv5JkYpSbYBczfVnemwmzABrqB6er19Utfeg@mail.gmail.com>
Subject: Re: [PATCH] for-each-ref: call --start-after argument "marker"
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ce7221063c27638e"

--000000000000ce7221063c27638e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> -		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-after"), N_("start iteration after the provided marker")),
>>> +		OPT_STRING(  0 , "start-after", &filter.start_after, N_("marker"), N_("start iteration after the provided marker")),
>>>
>>
>> Ah! I did fix a typo here, but your fix is better. Thanks.
>
> Here where?  Is that "fix a typo" something I should go around and
> make sure I do not miss?
>

I meant my earlier patch fa0f4e46f5 (for-each-ref: reword the
documentation for '--start-after', 2025-07-28) which is merged to master
now.


> Thanks.
>
>>
>>>  		OPT__COLOR(&format.use_color, N_("respect format colors")),
>>>  		OPT_REF_FILTER_EXCLUDE(&filter),
>>>  		OPT_REF_SORT(&sorting_options),
>>> --
>>> 2.50.1

--000000000000ce7221063c27638e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6eed39b6e4f6b958_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pYkJLVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3VrQy85MDBBd09IcWlYME5SSTlvK016enpERXVkYwo2RmxiSWpsbG5S
aDB5aFFNTGhyME4zMThGRUtVWXhSdXcrdiszMTlGd1FCcm5keUtheDhNVXowNWxSVVNOWnJ6Cnh2
d3kzNkQwN1VSZGgwa0Z6OUZ5UVFnaFRLUmErbUtsQzJlU2haTURNeXpETG5NLzF6VVdGMWpPRWpV
OG1VY0sKMVNGY2RhNWFtS2RnOU1mU05Pb3BIclhFb2U1dW4xZHJoMHozQjUvYlA1Ulo3L3JRSmJ2
Yk1QdmI2L1dHcFZWMApqcEpjYWV1bXNPVmM3VkxCYzVydDJBZmdCdGQrUEI1YjNGb2RraWNLVWxI
dnJ6cmNPV20xNmF5NjBYQjlGeHRKCnBITVJmOEZRSmU1TnJ3WjJ1SExMQUdpck4wUWxSa2Q3ZUFN
SjR6MVZmME1QekRpVkJDaTV5bWw4cHNXWlpiT1kKYUhSLzlUR09yQmFEa215RlFEbFcvOEx1dVlZ
VXNobEV6RUdrYmFVY2lNK3kxeHkxaEZwL1h6NS9zUDIxVWZrdApzR20reUoyRHBIVStVZmhUMDJ4
aUxSVnZGVFpyOTdobEFXQXYyeTZLR1lvYWxIdzVCajRYaVJKdTh3Q2hrdFVRCnplOURjcEt5U0Er
SUZXQWYwNGFoTjgyTERwMDZKQWJ2SHpvUUpPQT0KPWZ4bGgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ce7221063c27638e--
