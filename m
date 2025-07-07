Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45128983B
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878750; cv=none; b=Y9pMgpsCWK+2qFGZvdFT29pqFBud3dfYkmlQIFrz+azarrgtfnCHa4vGvptt6cYCd4Z6mRYKN8Y/wo/w4pY8cUaK0y/LShtMFLCVM2TCypJOnNMYpWS9TztCdf+xtfC3RI2hUQue9nnus7m7MTME+wPfNJhX5Nfird06Ok2hTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878750; c=relaxed/simple;
	bh=tREWDpVo6WzFSzS6gh7KcDFawLE/PkCKffO0uQ9GMeo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn6mwED+jDcpiVFNPGOj4rcEmkgwtxmigHdzHAv/4FKSFBBlpcEwpjPAehCCWdSSKUvjO7PIHMww7IxJxM5JbARHaNNXuHIz9JuhFShn9EnykfG752zbYrK6BcVU8b1Ip72RiWUB7pab/gluumZKL0SFNj1uJ6EfJUCKqmjurGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajj8inEH; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajj8inEH"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-532de49b7e2so973268e0c.0
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751878747; x=1752483547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6AiVrD/hecDeVQ0kRFXJFU2u67LlF5bfQjR5RnMv+s=;
        b=Ajj8inEHbYmlNhaIJRxZyxSoT+iJ82iNCspYqkK6Z6tZkyxsit52F9W3HSHtayoANE
         K+Vwg9oq3AslKq2Dmrk4+50+5YsD6OAOtXQRxA8nTva0NIhkPg3heW2CIr2mFzzh1Pvy
         fId0ZB63OVDrCaPPENCGS+nPQzKXuC2g+iMzYQfEy0tDRRjFLK2KJUt8ttbFePtrymDG
         +qtRDb1aMk4gI9UEhANZHjfc69Iwdhgx0nGwXYspZbzRONoFaX0lsfWKSKc/Hjxym73Z
         udww+/S+KmdPh7xF0Sm9x7L00e5SsU2NqwfUDjq1XmEbSm7heTWa8TmyhO0Q0csrbDpS
         JMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751878747; x=1752483547;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6AiVrD/hecDeVQ0kRFXJFU2u67LlF5bfQjR5RnMv+s=;
        b=D605yuUUCjb7JEATyg0TxyHIV51QEiF+/DG5cAReTk5UnaslZ2+WRQdrWVMnqdHgb4
         BjAFQdbC5osg9m2+HfOFD+YboGBtc1B1TiFrYWQyQABCStM2igwmwpJ4ln8UPxzmZ8Ll
         JLjpfC+TztRxnKSKm6y4S9Y0/COwOJB0DfQSlPNEAdJr/DEgfMLalEG3hUe/2uw2tlma
         wGL1WYuwJVq03vioVPeavZOpQyAYj2049faocPa7Ycos3M6BdSPFt4nM7zcnGzBrtQHq
         kQlRXsJ3BNHAxH9vFZeQKCtsEirhxEJVTlsLvmmjubmcUqdKB6Ry3nEi58yTxOIDr953
         CVwA==
X-Forwarded-Encrypted: i=1; AJvYcCVrYh2Y98zejt1rFvIGOy01H4pdqB0NFUD+HnwYAwmJMZxAcDtVUF/NBkETT5hCPhKJhiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5aGsHIvnb80PHA/1YEfz2e/4ZYOd2Nc2H6eDXstkZMG/mZ1WF
	+vKUoPNQFNBg+sRUdAbkNJIw6mes6ZARk0fmNcg0TMZp/xhR05aJJEADzFzTZ6etlF942+UB3vO
	pjVaHrFtChPvHCJk9YrMB3uyHaVhZx4k=
X-Gm-Gg: ASbGncuwbGKE3CvlcXV1cCS1JwQtl8hmcGyFka36JaOyz4OrQrsHLH3vggnW+1rljyl
	3aMzUd6mTypYqy+OVFR09SuNhi/5yywl77SUFY6wNKhf5c9QysJvxqr+aISWnH+/qL7vlZ4dlxw
	WmL1fXnqFz3xUsSCAMgC+va/y8U2B2OJ8lyPvAMICQqOGa9R50nVwDMEm37qeH3oXaBqblnjrp0
	6eLGw==
X-Google-Smtp-Source: AGHT+IGohkQciTB80/ErdsD9IkmxUNBQwRUETKmobblde3YxAa/nK4wUGeVhgdHl97nNl/yrCCe3vN98Wr851tyIvbA=
X-Received: by 2002:a05:6122:3708:b0:531:188b:c19e with SMTP id
 71dfb90a1353d-5347bee764fmr8032793e0c.2.1751878747300; Mon, 07 Jul 2025
 01:59:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Jul 2025 01:59:06 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqa55jc3md.fsf@gitster.g>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
 <87ms9kcbtq.fsf@igel.home> <CAOLa=ZS0uP+5xso_SEG2GJZHeac-0F2_wMJKtvbFj_wROKbBkw@mail.gmail.com>
 <xmqqa55jc3md.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 7 Jul 2025 01:59:06 -0700
X-Gm-Features: Ac12FXztr0jD4BW7zPjy7AQhSg6TGBt94hgCQOUakpPE_xeyhQar9AGkg7cxe1o
Message-ID: <CAOLa=ZTDcssjQcNcvDOA4-r-j2asp-XHCy2D_qoHEidz+KsKCQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: Junio C Hamano <gitster@pobox.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000006c44250639530ef1"

--0000000000006c44250639530ef1
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I think I was a bit against '--start-from' and '--start-at', because
>> they imply that the reference provided must exist.
>
> It also implies that if the reference does exist, that would be the
> first one that is shown.  But I do not think you want that, as ...
>
>> Consider the example
>>
>>   $ git for-each-ref
>>   refs/heads/bar
>>   refs/heads/foo
>>   refs/heads/main
>
>
> ... after a paging application starts from the beginning and showed
> a single page of some items, it knows the "last" one it showed.
> That last entry may have been refs/heads/bar.  The application may
> not have seen the next entry (i.e. refs/heads/foo).  So if it has to
> use '--start-at=refs/heads/bar', the first entry it gets from such a
> request may be for refs/heads/bar again.  The application needs to
> remember the "last" one it showed and skip that, which is a bit
> awkward, isn't it?
>

I do agree, I was modelling this after what would be the best approach
within the Git codebase. But I think it would be nicer for the clients
if we skip the provided reference.

>>   $ git for-each-ref --seek=refs/heads/cat
>>   refs/heads/foo
>>   refs/heads/main
>>
>> You can see that the reference doesn't have to exist. So implying that
>> it should can be a bit confusing.
>
> For that reason, whatever verb you pick from seek or start or skip,
> it would be great if the option name also made it explicit that the
> named one, if exists, is not shown.  Conceptually, it is "skip
> everything that sorts before the named item, including the named
> item itself" that such a paging application would want, wouldn't it?
>
> Thanks.
>

With that I think '--start-after' sounds like the best option. I'll
modify for the next version accordingly.

Thanks!

--0000000000006c44250639530ef1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8bc9c04672d56251_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ocmpGZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2NUQy80K0QwbGR6QVNaMzhpdy96NlBrMExCWkN4cgpzTkNnR3JZMEhT
dDhBdFR0eExodE05ZDlSelQ1T0l4Yzg2NFFhTG1LVjdrTGpNVFhhTmFGcGI0QWtCVEdid01VCnQ3
YThzTld6Q3VrV3Y2SUw3ZGVIVkdUR0tXZjd5MVFvZ3lhOFlFbXIyN0dOTWR3NkVIK2t1dW9ZWmY5
VW0rWnMKQjAvRmZ6MmpSOUdiOWxTVHpVSmU0a3hGc2RtNHMzd09NSWYzY2pLQlEyWEhHMXpxM1dO
RURHQmpCMUUxUGVONApRNWNIREU5VklrSmp0a1g1Z3kyRi9pQ3l2QlhZTkd0L0g2U2RDMWNFRjlX
MkEvVSttdks2Q052eW1ySXZPUU1LCnlJYW5OUkZraFZFNDZKK3RMYmVVdkFvMTZjZ3VEdUU2eXRS
L0tHaFFRRVVzeXVBeDR0UlJIb24vUjNNMHVGeTAKanp0VDEyZGV1cnEwajRkR1VmenM4dmFzamVv
U3IrUEI1QjhIRDNyeWt5SGRNMHNZeDIrdmYzY0ZCUCtGa0tsQgo5MENxWGZjaktYWWZDUE1jWUFJ
M0REQXNUNVJLKzZxVDFQQW50dkRjSXR0T3dMb2I4NEV2SjZ5TkNlRFBKcjBtCkRNQjQxeTY2c3I4
cnNHUjhNbXVnaEszUXFSQUEvTEl1WVlmUUwrRT0KPUpYYUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006c44250639530ef1--
