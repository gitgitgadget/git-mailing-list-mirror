Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970442D46A3
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173885; cv=none; b=c5TdCR8Td9z2GpnY8+WRQl5W8qP/WychLZqMp1NT1iBcV3ZMTjqjeCeWMB6TFk7Ldm0C1Mh9vg+zwCn9r9hHbGF+nNs2+1fN7Lk0yPU4mP4g8naKtsozpYgz97c/hsH2Ii6ZArmU8clXN+csT/NqAduY3QzIEJpv5OZLmDPWPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173885; c=relaxed/simple;
	bh=oQfy4YyZEV/uiwfyCOnQ43T7GXKtXjPJR1uwU6SCjMg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OL2TiyvBwt5x0zM7xsD2LAIq8k8rpII1HLXawWEJ9MqZy9ncE4cnCpp6tRqphniXxaGZ7pyElzCqdpj3J9RXmDrZXeAkzmNTdLn5h8KJyoKf4joFgKu267FwOP8wO9TY7HhfXKiOFzPw4AyEeJS3K7V9vkqv47g+71VK7Gxs5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM16TAlC; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM16TAlC"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5346b405d1aso2551965e0c.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753173882; x=1753778682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDlt32OeG19CBJnks5fx8Hq46Zv3urRM9pNZJJ8Ce9k=;
        b=KM16TAlCcrHB0PF3zIgbBfgxe9T4OKpr8moSBMaZiQw6+BHT8a5e4Z2oEnSDnH8dH1
         AHyMgG6NNiTDjUQo4aysshP0/nXdfUCKglPylUbfqlQulyFlGOAHUaYulo68pxeQoRA2
         a93AN2I6trdmm53LbdqBJIFBOVvuD8dfVQdpqgPFlOeQQD2a8N2cCGS/jA6iw6UjF9j0
         BxgRZKUHw/K9G5cDQSP8CR25ma2RJIXyfNjb3vAovsMPV2dVYOwPakQPdUVGFiTg+O80
         eCrAa8pd7AZLkQUjj1ocXs7n45LCJHXiXmQhNO5+89AkaYdUYG26RUF/aURZ03vsd9tf
         9lFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173882; x=1753778682;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDlt32OeG19CBJnks5fx8Hq46Zv3urRM9pNZJJ8Ce9k=;
        b=mZ2I2KyYrS6FaUPz/imxO4+hrRu2SgIkY/LmDyI0rjXwmmTQeGoVejG9paAonUGMT+
         68+c/oCJE+2xPFXfLJU2SXjsCjwveXQBvakJEjcJR0346DAOv6tb4Gysk0Gd4gwp+SS/
         kFN96+MfIZIJGuLkysY6rFqzzbMN8VMSpXNmvrGG/4rEBCH1FstCa1lTce5vht/fNXhk
         71hP4IdtMOAhLLCnA7Btc29Dq7+hYHkcRzS9kf0SW2+nHte0AA/8bPnY8vm8hd0tSezv
         wrf8vrTlNnZ27CktFwWZrHuqDSu++mAHIbSz7h8qfkKAFg4bI7s8ZI2Y2gz3ilD94GtQ
         koNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC7MHCs/WPSuEBQy96Y04F1Wx28SHdJ4QjsiBlinPf5fdPiegqN0cv7ScTQNBY6FlDQXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjoWqRkEe5Az18pSiWQRskHjmnSsJ9IbBfCFaQZdNIwdvMD+o
	0MRPvKmolshpv8drb7FLNlFJHpooUiS8EM0vwunPdIc93LOZKuXBcKF/cmF3USxtYxbVdqr6YRk
	ww0xPnsmpQtYTvEHej+mB2nbR2e9L/tM=
X-Gm-Gg: ASbGnctgsJgqwmbLEcnUYBwXz/PudrXZ9BSs8YbleYzJtw/OpZJADKixgW8qkbgpD0O
	sZfNZlBVJxdRXV5iFMxl3fXou4Olf3V+0V1F3o4N/XVAT6Zk69A8BjY8p6SLg+8C5psDX7m7wRM
	GAknZORm7bcW4n2J9l6UTxdno4rwM7cdlAc7VJkN392nFimMShHpQdr9i+x0WPmaKVBqR3BwKGf
	ZpqGMC5l3FxgDXo
X-Google-Smtp-Source: AGHT+IEHdiSobpcAjBhQPTFW+A2F9wfl5YfPI3MI6ufPGtoLGY+QzPpT1kbQYLkHhG7/COC2MT6CIRYEHXBvw/TTP/M=
X-Received: by 2002:a05:6122:3bc4:b0:535:caf8:1198 with SMTP id
 71dfb90a1353d-5373fbb3fe9mr11450058e0c.2.1753173882342; Tue, 22 Jul 2025
 01:44:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 08:44:41 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 08:44:41 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250721212221.GA818305@coredump.intra.peff.net>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqple1gtyg.fsf@gitster.g> <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
 <20250717015402.GA2127425@coredump.intra.peff.net> <CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
 <CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
 <CAO_smVj4e0XOQyQr5sDyMZ8WPvqcBe2Y33DFHrED7C=VJnm4eg@mail.gmail.com>
 <20250717220929.GB2244266@coredump.intra.peff.net> <CAOLa=ZR==xihNsZcNkFPtqb1JbC+EbMHtgF-RUzdwOQp55+MOw@mail.gmail.com>
 <20250721212221.GA818305@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Jul 2025 08:44:41 +0000
X-Gm-Features: Ac12FXyRah8qgy3e9bGDL4xqMs1AEUTfUaIWLRvuZhqvkOMrqRdPH1R5RyIY77E
Message-ID: <CAOLa=ZTE_Hmnz5EMxAk94rSsvvT7+O9PrroLTbjPW_oe6AzCVw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via '--start-after'
To: Jeff King <peff@peff.net>
Cc: Kyle Lippincott <spectral@google.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	git@vger.kernel.org, schwab@linux-m68k.org, phillip.wood123@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000007cbf4b063a809a1c"

--0000000000007cbf4b063a809a1c
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Jul 21, 2025 at 02:27:45PM +0000, Karthik Nayak wrote:
>
>> > Applying this ancient patch:
>> >
>> >   https://lore.kernel.org/git/20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net/
>> >
>> > and building with "make SANITIZE=memory CC=clang" let me run t6302 to
>> > completion, modulo the bug that started this thread (and which I
>> > confirmed goes away both with MSan and valgrind with the fix Karthik
>> > posted).
>> [...]
>>
>> I wonder if an alternate is to use '-fsanitize-ignorelist', since the
>> MemorySanitizer is supposed to work with that too [1].
>
> I think you could do that, but it isn't quite what we want: it is
> annotating the access of those (false-positive) "uninitialized" bytes.
> So you have to mark every spot that touches bytes that come from zlib,
> which in Git is a lot of places. And so the patch linked above was an
> attempt to silence all of those with a single line: marking the bytes
> coming out of zlib as OK.
>

That makes sense, thanks for explaining.

> -Peff

--0000000000007cbf4b063a809a1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1edb72c3bb441a11_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oL1QzY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL29nQy85SURiTldkNHJlbHFQRFRMaTdPcHA5Y25oRgpncWtaSXhpank1
V0l3TFJBMGxsRStYTlhubXpXK200bHgwakRHNWl4MC9DMTV4M0lVRmpRTGM3V01uQ0dvenhlCmtl
WHhaZGpSbmNleUt1U2xUbjAzTUVrRzZwcENFeUhuN3BwUnRBbHk1Wm5qMzZhekFvTi9GNEVmNm1M
WllLMlIKTEptaVVsQmpFdStLMkNCdUIweHpHZU9HcFpxZjVaZW8zMWZIOWFHM0lOWE1oMU80bHZ4
dHRvTzlEK29vQm84egpHZFpPeHdPRUdWdmRveW50QXdRZlMySGFJc1Z2bmQ4Yzh6OFIwQi8rZnVJ
bmZLNDRxTjhjalBFeWNpTUVScGNkCmVkVmxGVGhnNmE1YUZQNG9PTVRhU3kyRzV2ZnBLc0NVYldw
aDJRZVNtVTd1Y2xlY204c1k3Nktpdk9sUThJZFMKYmt1akZKdW43dnBwQzJqNE9veHM5S3FYK0JS
TEs1OGljc082UG5mM1hrZE51TUZENUlTY0RwTW9GUGVIZEVWNgo2ZjV6WDdiTzhaVFBDRmIxNUJF
SGNKK1lWekNtaWNwMHN5RmhnOG4xRFZiMEwwRlBWVUliK3UxSUNXMTNvSzF4CmgwSUJoZGJ4Tmh4
YldpUU1XVFlKUk9OOGRadlg3NUlqK29aSFljVT0KPWh2NjkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007cbf4b063a809a1c--
