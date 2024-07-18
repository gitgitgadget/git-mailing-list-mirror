Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D791BDD0
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289846; cv=none; b=N+f3sfVO2hf8XgZrPZZGBikvrVJVXlxGR02tQD9o5m0iqgbzL1OZR6H5yvWzlqh5jfwnjW2/Y0vh+gA9vlFZ95YUImdGb3ssMUKdxeDoYc/vSHIQC9APYZvgcm4OjuUqfmHYbSbC7N/ROsQROtjYpuJbAZKvElFV3jg/H3r2Qso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289846; c=relaxed/simple;
	bh=rbNM83uiAC2ex9BGidAP1h/MjnrHXPQ4qXy6+yuQbYw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XymQVs4KpgIkWbELrywEmoxjdo5iFZeL7+fAPk1d3FlWOiWNkUk+FQm8E2JgadrSQnD37YeBEvzoXTWO2yUBBs92mAZU+wpQwkn7knjradnhq3vljSUyhBr6bw/YF7RXJvJTVy47H1vM6yMc6+Gv3cUemthFpaq4eUspQNVhWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkRPVWb+; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkRPVWb+"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b9794dad09so222033eaf.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721289844; x=1721894644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbNM83uiAC2ex9BGidAP1h/MjnrHXPQ4qXy6+yuQbYw=;
        b=KkRPVWb+Nn7hvQBge9YbaovhpvaadLbVJIwLHkeXSxILpkL8A5JEl6C6tZlWuPIb5Z
         KNlQXz6mu0aI9NNzLHroJoUUhE/ql7ts+dbNqj8IT2NyDSaipKmRC/jBFXUyxz+FhyNn
         Cpxt5p5OMsukUH1h1Ngyk2qH7SZwKmHR+cr0Zb6A4Na9WTBirFYakM8tft92/hmjuOBB
         yLqyCyEtllgSztEYGAElOKGO0x+m+GvGBam1cYgHlLyap4HQc6ZxUxSWLnQEg/Jv0H8z
         8W1+LX2xGR67ybiFl08cV5osVMdZ249D8jfbQbptJYdD22cwqwjKtDKMI16aixcqC9Yf
         pUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289844; x=1721894644;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbNM83uiAC2ex9BGidAP1h/MjnrHXPQ4qXy6+yuQbYw=;
        b=xHMQP0rdjd5RvPIA63yDAlCT3oyiIKvwrlguXcDbfB/mmlkEc0NNrdVGq288upFI7O
         gYl7MXgHgGO+IxSfSr8YfDMfHmUVl2OGtCJqVZwZg+8IC0wIZ70dydooq6n4RtwGKeOf
         xh1MG9CosP0125/Sef7SknVrTEZvKmLG06a8vknJirBesjFP1dhbPlNQn0ZcO/34Aw/y
         b2frd28S7Dc8+L/YqaJADDXBrG/p/FMJ/h4XW2gkLa345xv4TTrrS1bz4uFgtR91Xqw0
         9jBLcBfjvB9XRRDhIDG1rtTSorcf3J6OgiKjqbPF+Pwgp1rSm8jDSgp5NdybvmzHdiB6
         1V5A==
X-Gm-Message-State: AOJu0Yy1hw14LXll7GNZqqecXq34aIR25Uyn+WrAxSjHzlppXqx642ve
	gcj5vYs2e79W5gkstU9/s7SZElWsr7UmDWfwy/UmLwrfNNHzYY+Oe20XAu4+mVewswuRu+AVgqL
	Fw42/ALaakPug9WENJjvQFnllCBc=
X-Google-Smtp-Source: AGHT+IEtGm9uRsb2kK0SHpX3oVG7DU0TBDOqpMRGlV1NZ7iYeLB9+qJ049fFhLnlWwcwAOsQ4E0UuvYKlicdU573F/0=
X-Received: by 2002:a05:6870:8289:b0:250:7dba:9501 with SMTP id
 586e51a60fabf-260eea17afamr1703088fac.41.1721289843804; Thu, 18 Jul 2024
 01:04:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jul 2024 01:04:02 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+J6zkQpNiM1UpGRzkNP9o04cEL4ip-YFkQvXk2zgSjpE4uGBw@mail.gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com> <20240716075641.4264-3-chandrapratap3519@gmail.com>
 <CAOLa=ZQ7xQFKZ9Oeo0WyrgzvjCvNm4dbgatp0JTvP33sUQ_3fw@mail.gmail.com> <CA+J6zkQpNiM1UpGRzkNP9o04cEL4ip-YFkQvXk2zgSjpE4uGBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jul 2024 01:04:02 -0700
Message-ID: <CAOLa=ZTJ_oyqmR0ktJa=AABy290Z7RNLc0_ES9UNB=zXY0-5zA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000b22c97061d810531"

--000000000000b22c97061d810531
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> On Wed, 17 Jul 2024 at 17:19, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>>
>> > reftable/tree_test.c exercises the functions defined in
>> > reftable/tree.{c, h}. Migrate reftable/tree_test.c to the unit
>> > testing framework. Migration involves refactoring the tests to use
>> > the unit testing framework instead of reftable's test framework and
>> > renaming the tests to align with unit-tests' standards.
>> >
>>
>> Nit: it would be nice to mention that this commit copies it over as-is
>> (mostly) and the upcoming commits do refactoring. This would really help
>> reviewers.
>
> I do mention that in the patch cover letter, specifically this paragraph:
>
>> The first patch in the series is preparatory cleanup, the second patch
>> moves the test to the unit testing framework, and the rest of the patches
>> improve upon the ported test.
>
> Would it be better if I transport that here?
>
> ----[snip]----

I think that would be nice!

--000000000000b22c97061d810531
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: df324423262180a8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hWXpIRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMG9FQy85ZUFaQlQxTW8rL3R0UWJLSEZjN1dkTENuRQo1Q0lzM003eHVZ
L0RsbGl5TnRVWW5uSExHWVcyZFB2aGxGT25FeWtZcDFwOVk1WTZOMUMva0FLeGg5ZStBbmZ5Ck1M
ek9rS2RYU2xFSEZJcldsVVl1L3l4NlZBY2JDQ2ZtVTZ6MkRydTlGRzBHQ3hHbUZ3R3p3VkoyL1Vn
Y3ZNUUsKR0s0K1V2MGMzcktvQXdOd2dmYUM3OGF4TGdyZXBKS3RoN09jYUR0WmxhREFsTFE5UFRt
am4zQkhFL2ZBdm9aTQpyV1N5TG9UNU96MEZUa0JNRFhwaldLMW9GZ3kwWWp6VDI5bkRGZlZ6VWRK
Uk1qN1FXNmRycWd5L1RjQjZDMmYwCldhUUpQWGNJcmlnY2g1L0J1UEppOUhZbmU3L1N4RVF5dGhP
SGZyZGhjRXdNY2FvN0k1R0htdFpoN0ZZZThHWUEKYmtwektLS21CV3Y4VEp4aCtmYzZxWWkzbkxU
QzcvNHhTSVVlUTdIcnNiTWZFUmxXVkNkRW85RmpkY1ZlMkJSbgpjSUh1YVFFSi9oZTdJWXhTbWNI
S0dONU93OS8yMTM0OEJva3pYZEpHbUNaMGx2SWFrSkVlUjNhRjFGcm53MkNRClFXOGs4dExzV1NX
ZFB6QUJKMWI4cTdENWZKckIxWWkrUU9aNjBoYz0KPXc2WmcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b22c97061d810531--
