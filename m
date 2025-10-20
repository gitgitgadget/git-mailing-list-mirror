Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6DB2E6CAB
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992088; cv=none; b=Fz0s6LOicsjjeMYyWDgav8eahpiXzAoOaafqINSUagjQD96gG5aicwC86IFQ7QPnOS58XTNZdF7/SZhQIH35Kj3XRC5WclirsfkQRVKBfU1F0L+rCmohI42heRzMJuTHPLuGoi2lnm44ZaOfeu6vxqpda306O1ZbFVik9/LpstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992088; c=relaxed/simple;
	bh=uWXqwdPunSMRAxfRJO9U7d9P4vKHhC5G5k1DACEh5p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXFAd+VGhlv3aFGwGLRdmdqQ2hylTnTeOi+0g+a9nf7orpZXGwpnJqZSc0g/AHA23ZRQEBYI026tril22T8DsD+nvDKk759gy4BMNGIDuLiRGdenWDBhrPpafNq1OqqBBoO2SKwyDHS0uCiS1UgknWjIdfn977z18GxW4pbkz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTzyc58N; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTzyc58N"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso5717565a12.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760992083; x=1761596883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWXqwdPunSMRAxfRJO9U7d9P4vKHhC5G5k1DACEh5p8=;
        b=PTzyc58NK2oq/HEHZh6LhiC7uW4ZnLdDPZx9wNFEKIaTvdxGHtcFBDyuyDcQisF9eu
         46H1NH3axVq4jjz9NBb6JSqeKMXh/gobQQDU8i2YcJZt7fCi8hCTNil2JUp0Y6Jo8049
         99VPqKZ6pdTozvrsGnmsAI6AsFVSn5eO43pcldPwi9am0LrAj8qCHruXbsU0ib73gL+G
         XJquNqSOdOMWyRjY+PE5iupPHLc7W3ks8j/M8I6lrqwerDkh9BV6BwcdRHFnJDnpChRV
         p6epgKtZ4tDC9CiFR1oxuNgZFPCuG+VBCCkgll81UHN5RhX5KzQYQJcxnFYamfFfgGsQ
         pikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760992083; x=1761596883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWXqwdPunSMRAxfRJO9U7d9P4vKHhC5G5k1DACEh5p8=;
        b=K31Quii6CGsCClz22v0MiJ+8fPHv4TZjn4fMq9AZ0ceUJNkpKcsOoCLwz67lZYssXF
         kRkr/t5uRyulZADJJLvAPPynLnFFiTUNMsmDeBPHjUuCHsWV1B3QtCNn3BLqG70aFMG3
         AqkwW1xixvKu8s1heeXx0D5wH6KPJPb1qBU9So0p2E2KOQdMm08I4P0i/YgU9lNRuWks
         wJndkcbnGBHF8SxgiHScKFA177Q2LR0hvjtnyRdIgeFBE43W2TzmmuA7I0Bqlb3ZaZis
         0zpdrf/Srv5DrA2N+BV4T9nXVCtRssHLvTf8ri2hUbcDHSoaV88WDqR/yw+JbxjqWXrX
         JXrA==
X-Forwarded-Encrypted: i=1; AJvYcCWMJP9leNCPzcixqZCgEqGzWZnOIGa/0+M0p/JAyWfJ1N09iC4u9AneBI3Zgr2da+NhAjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS9gnNTzADWVBb/Z5No/7xKe7yrLg87XiiTs9GVA7ZLQgHdX03
	27tg81B+AiDtMXJtWqjC2SAp57Qp0DdfXPcHiyqif247oSi/cVFCYZ4WDbbAab2XBPaowFHL5F6
	1+eRjQszb82GTv3jfMXUl54vRcuH4uUw=
X-Gm-Gg: ASbGncvVplTvO0jiGOPZjyOtA8E2fb2janHEAK+odoO55bwo+Gvmro0s/GO7Ts8VUI/
	GenNJV0KLbWTN1tRB/BJvppMa8WKE8lpypZFLLFKJafy2WCLXBDFDIyclWnY5IgeJp7bGL6J7Nu
	l6Ank9SX27JAGxQXIyJ5wQPk+fjnZ6E1i1FmxbP+Cu6DT5pmEUHNUXjlGfPufi2CmuZK7iA0NQ+
	vcsZFf56uULaCWW0W39GOWJelprdIjGbPNzCw1DWA4NC6fXSW5CcB7MHXbr8RMcYw4jDubI1Fi2
	mDPIqkmLHMXzoFM4iYU=
X-Google-Smtp-Source: AGHT+IFBDPBBi3N80Q6p+5wH5H9oUdX1PlVMqrLGplf6rIWzd0dmQojrRiRvvuuiQv8tuhiVdJRPM18OBekKqTQay5Q=
X-Received: by 2002:a05:6402:440d:b0:639:ffb5:3604 with SMTP id
 4fb4d7f45d1cf-63c1f6edf8amr13198623a12.37.1760992082443; Mon, 20 Oct 2025
 13:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org>
 <A563E028-19E7-48A0-B538-82ACE821DB67@gmail.com> <5d780103-285b-4e6c-9b26-2a87609837cf@kdbg.org>
 <CALnO6CBwn-NP-ZdoaeOD37_VM8N4D-KKopm3nnf4a9b+9OiizA@mail.gmail.com>
In-Reply-To: <CALnO6CBwn-NP-ZdoaeOD37_VM8N4D-KKopm3nnf4a9b+9OiizA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 20 Oct 2025 16:27:51 -0400
X-Gm-Features: AS18NWBMooNGNr5i4Ud-3LLK5O9BfMSKgB5clc0R5PivvYkVwn9FCFu96hUrtGA
Message-ID: <CALnO6CCfDy19J-DTT4Vjp9EYf6M8sk5DpMjsm-Mp4_kNO9=kdg@mail.gmail.com>
Subject: Re: [PATCH] t7500: fix tests with absolute path following
 ":(optional)" on Windows
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, Noah Pendleton <noah.pendleton@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>, Thranur Andul <thranur@gmail.com>, 
	Michael Grosser <grosser.michael@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:27=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 1:32=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrot=
e:
> >
> > Am 20.10.25 um 15:43 schrieb Ben Knoble:
> > > Going forward I will probably stick with using pwd, given the
> > > difference in platform behavior.
> > $(pwd) is usually safe, but not always. If we have to look at every
> > instance anyway, we can use $PWD for efficiency if it does not matter,
> > and $(pwd) only when it is necessary.
> >
> > > Is there a doc or test lint for that? If not, might be useful.
> >
> > If this were documented somewhere, would you have found it and obeyed
> > the recommendations?
>
> Likely yes, but I'll admit to being the exception rather than the rule
> (I like to read). A lint is more valuable in that it can at least be
> run rather than searched for.

Ach, and yet=E2=80=A6 I clearly didn't ;) hence the lint

--=20
D. Ben Knoble
