Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582971E491
	for <git@vger.kernel.org>; Thu, 16 May 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871630; cv=none; b=VwqOHv2vhOdNg7hUDUF/rb2SHDR1CTKYvP938AaPkaQEU2BrPyysGAG2FJKVcUfJboeAhoukrVE5BEUrD2KF9L6NHqbiSqWwZUcDeJ2LLd89UeW01yNqbqe9wukhuSpRwGF39Ax4Ze0IRCrpHUYKnba/T7lvG/m9NVAT/oKxNec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871630; c=relaxed/simple;
	bh=6NBJu3H9oiCQXwilWgeQEDFw8Rp9JjPgtspWpNKJymE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Oby0AHCShNoyCrrLFRJl2LsE6gxnUvW4t62PounukKqN/eGyH6tbI6skn3CAFNE1h0G16vAZGjdnWZfd7QxEYIfW19R8DzI69Ybpr5XrGhadGzqTAwcGOY++v8RijzeIg9jFeNIYWIIvfh8tttpLMlg/z7+NR1KAU1h+CVpE87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed/Zm+8s; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed/Zm+8s"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23fb9c871c8so346954fac.1
        for <git@vger.kernel.org>; Thu, 16 May 2024 08:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715871628; x=1716476428; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6NBJu3H9oiCQXwilWgeQEDFw8Rp9JjPgtspWpNKJymE=;
        b=ed/Zm+8sCU8toaisupb3BKu7HPrRT9Ajk0qiNw9mfb4IUNUXF+gFlq2uJ0O2jEbkG5
         +Taou0WHL+5AIgqaQcMUEUa+oKTr01NQIR/jtWn7PVTD4e+9kcHHl+ufxS2jyoen5dIo
         +/RlAf+iIxNMwcxbhZpm4F5nClOnrEAQv4kuGV6CjgvzaeXlRqgMWzbxi0FwHRcLYopR
         Jk4q968tPDp+WI8dyPQr0mfAXhPp0DBDBaUbvlxWCwvEDqm6CJPWrubI5KDBTCE+S3h5
         9Wbkf6WYUpLvXA9fYOEsNfRwCHFD0NUbsVxMBu24/GpZCf5bHe7HgGduHWf/FX0tl3dX
         8apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871628; x=1716476428;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NBJu3H9oiCQXwilWgeQEDFw8Rp9JjPgtspWpNKJymE=;
        b=sGlKfkVgEERKZIyHhnRuA05pqsKU1T7NOLHZiFAetF7Osq7y1AcinlyN/HqS85nsfm
         m1a8oDN4KrpFWuyMz0TQJNNGHHoFthl1iLc7tHKTEe98JDTBqbT5bqAauKSBQbYxkXxM
         xv/ZGsPccBJcaC8oa6VvjjAjH55MmCJYOd1O48QNcwrSbuOA3/IAJ7IfOevBwEYHWXQt
         y7DAsGFlqSZYl5wLcsjZ/YozHL5/hpGiT6MsHOiChstCcq2xchpvKpJP1G/uEUSKaawT
         GT02X4ZU1xC5Dm1pyLx0rjTS+/xNS6dwhzQVNGCzzRV3HEFXLw19/iH8LvH160xyWelp
         GzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnkis+lDDwOkkjf7WCNJia07/pwaEL+b5I3IttpcnY+aq235kM9N1bb+CMfrgOGSkppjdMXoSCbM7+Ue99uD4p7FUb
X-Gm-Message-State: AOJu0YyXofEyB/TPpsnmUkWiN61RYakd5YuM7ArRZtIKZCDH/b9hl7Ah
	TjlrCvKrVVcsbcekKxhO/FCFfL5SoQQBFAi27qqFVRLkaVpOIx4JEM+zyO9lBPWBtt4b5pQenTX
	IxkKWj1qE39LeYejXyeJr02BBumw=
X-Google-Smtp-Source: AGHT+IHpoWYPfgHLvsptR0I7TNUG7AuWkH8ur0TjLvmoCex+riJQFB6bVGJTSGGHC6EWVCYtVAeeRBsTrUdiki5ZWg4=
X-Received: by 2002:a05:6870:89a4:b0:22e:1487:a94b with SMTP id
 586e51a60fabf-24172f5dc39mr22017595fac.53.1715871628173; Thu, 16 May 2024
 08:00:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 May 2024 10:00:27 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <3cc2b4e5501ebe1464a6d75b7aea9f2ad6030c4a.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im> <3cc2b4e5501ebe1464a6d75b7aea9f2ad6030c4a.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 May 2024 10:00:27 -0500
Message-ID: <CAOLa=ZRmMQ=rZTSs-hbWexwnJi5kBZC-t4o7-ZZE3N9ZCeqTYQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] refs: rename `init_db` callback to avoid confusion
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e0c5800618937e79"

--000000000000e0c5800618937e79
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Reference backends have two callbacks `init` and `init_db`. The
> similarity of these two callbacks has repeatedly tripped myself whenever
> I was looking at those, where I always had to look up which of them does

Nit: It would read better with something like "repeatedly confused me
whenever I was looking at them".

[snip]

--000000000000e0c5800618937e79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 492166a46ea03f08_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aR0g0a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGdVQy8wU3FpNm42TVBXVzJEamRGZ2FqZVI2OG16Tgp4enMrVzMvNlR6
UHZSU1E3ODI5L2pvaWdNd3NSYzdsTzJ0SmtZckhLUUlzMUxHU2QwV0JEV1E2TDB2UWltcWFlCmN1
c1MxMjY1WFFhRWxsUFJTSkowTDBwSk1qbEFxby9JdDROMUtMdnRxcDJPS0lpQzFJUmlwMjRpQ2Nt
bXp2ODQKNEZHRTMxYk0wejdxUkhYZUJRN0RFdjdaRlVTZzlQU2FqOTN4a0NibTZDaTd0ZUw4ZHFY
OVYxRGR0YWc2bjN6Zgpqa3BFZ3ZGbHlNUFptVXNYYXZ4dDY1dVhUUzlldFJBZjE0VVNNb2pndDZQ
ejliNW83WGNhMVlPbjFhZFdJYlJDCkNlR3dBNlY1cTZtY0lEaFRlR1BRcVdHQjA1d0lPTUtzUTVy
d0V1dFkzZWJaSlBRWk0yZi9OYmFYcTBpVEQ0NHMKRUpoRFIrODB3M1pUUnJwNjBBQ2N6c2lma082
Y1Z4K1hMSDgxVFJNSWxhTERVa1k5N2dJaDlMbGlPbDdKaDAxegpwRkpZcEI5Wkk1THUxR28weGFY
NU1ybGZwZ0F1RWRBZFBXYjZWOEVwa3hIemFXRmZYZU0xR0ZmdEtBa3UzaXRxCm9Bb0hNMmJiSzdI
S0xZRDFnQWk0QzVqVnErYWdCUXp6blQrVG1aWT0KPVRWQlQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e0c5800618937e79--
