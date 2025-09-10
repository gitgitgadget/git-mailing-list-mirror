Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ABB2877DC
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541746; cv=none; b=S+ClKp9ZefZ1ft7ba3NQpfdaT8NxqBWR5f6GIhyo9fjbeg6iMYqbOrPBgkSBKEIqbZ4waVG2Paz8TmFVYbQgu5pBiC0cdLdITsHxLdaV8BOPCTAZriHi7bkebIIoTA+aUccqDSA1IbxX7N+Ym7Hedp7tDlEfVyjhoVrJzr6WJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541746; c=relaxed/simple;
	bh=hBxea8wSTmOa7VpbN3O7mkL+uSL3WLEdrhct24TgGA0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dJvaJnw2LCbVXlcjFtExO/hdaboaDDG2qSK2yqz4KimLzxU/9TjtAJI1V0kZxXHGClBPyMw+vROZUzsojAZw9RLtT0bai/JfUgu4eHTQCaO/RG1VJyurAGDvK+1osxuxOP1Y5mjjJlaCDNPWH7XZFexTaaZQI83QABjQX8dZuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgXdKt7c; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgXdKt7c"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e931c858dbbso33221276.0
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757541744; x=1758146544; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72pJ1w8sFDrDrIOg/2jBMVy/DQ64F/J/AJgqYGhGrrc=;
        b=CgXdKt7cZdVlS9dLdxSCP1iTNxwlKpAYmvG5SKT+lkIQTe4JL7tmD6Tg5StEaq1uRk
         e5PTg0UbymPj+MSyzWhraUQg0f2UiJ5PSlrclPws54D0MQ7w+xueiLbF57/gYQBNyUCx
         WZt7atmcD1pfveIim19n9vBzSbp28D+n2jVOHVtaqk3oybPFp0qs9zrZPHcw6/yuWJHC
         roBThteR2FrmgWcXJp9rdyO9TXXJlIbznWfOaBWrOoQLJ3L9S0jaxMnEy7qj2cd4C8dy
         S8G49YPHXQ3UWwQhCm8mPlLpnVFTwMhzFJ78pz/FHW+jIVdkUTQnVSoqi0MLrZGpC7eV
         x69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757541744; x=1758146544;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72pJ1w8sFDrDrIOg/2jBMVy/DQ64F/J/AJgqYGhGrrc=;
        b=hqO6vEr0CAevOa2wU45oOh8TOQZmPIR3gHUpOzC/tBzEi3HPDi/xXtVzPJ8iiZVUNh
         MeRtiJ3Sk7ElXflkqdW9A1G2ROIa751e/jzYpe8KjRsDh/S3W3oksHnqynpoqiiPhJ85
         c/eG7A0U+BMm+6h3ogMIm+TQNSpw2kmCdPGznKcJ7c0+IsaWcfaB8LT/zTmZlPUG2ZUm
         DSOrCeYsJ5UQf2Z6WCWSMnHNeiGyy6N31rkm0Pd5dU8jHB8iat+V09HVLmxP+d12/ZJg
         sLusWTnevGU/m7LOB/TEHDyqFcUX0ZmaXw6zs6ht8llCaltSJxb4j3oorIhENAv/SbMO
         cWHw==
X-Forwarded-Encrypted: i=1; AJvYcCWyf/6bbQwLjqWJ2SU699Zi/HByRnsW7tXzQFpGicjW3fEnf4eP3YswSYRPPE/yfX92BXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQfcuXVXrQMuQftIs4M2HHzFk/7rSUr2u+Y7cRuXS6WoiMRXP
	FqEsM6n3OfAeSHQimC3oD18j9P5eGp4NKWVboOXFwMJiQw+04IVijjBV
X-Gm-Gg: ASbGncvdEsOH0dB5tfikKRBKeiwsvaV9d9OjRFDG9gdMzVVawTTWwdq3dwZ9JIjqMZN
	Xy+28mugLRF6ZLTRUcQTFAQEUayVZKACO/MTp5/PYLIcYr48A94qGAWAP9MCtzjRDgGt7jFkEyL
	C865EA0FyqRVTcZo6xdNcVhPi1Padh+cFk4dGciseRgOSHPZhrUzd75ny5oes/oLVTG6sPxjOgw
	0hCnQL3tP1KtNHtPjGjYEElYC/KDRmUcx3Ks9txilzFlhgifCaEs8TxP/msutbky8UPpZmUMqxK
	ZFZEx4J/BLksb/Sa2uPff0GL9QDW52+om10A7aEXJGmEalX1IHGV1WQHpR1/2U7U01w/Qu2A5+p
	+PqCQmTg1XgdinY98JgDN+7/w4J62YCyYoxYkkHlp/ibNPkHnlBACAKtxkhWlHA==
X-Google-Smtp-Source: AGHT+IFTrLBVmvOTcAvCIVHSOJRt1daMe7khRg5JbELew+HFW6RhSSO+pZPCIE/2XGF90Nl/8H6Pfg==
X-Received: by 2002:a05:690c:4448:b0:721:67ba:6f0a with SMTP id 00721157ae682-727f428dfa7mr136502667b3.7.1757541743926;
        Wed, 10 Sep 2025 15:02:23 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:f561:801f:d723:c13a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f16e3e0a8sm1316617b3.62.2025.09.10.15.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 15:02:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 08/17] xdiff: delete chastore from xdfile_t, view with --color-words
Date: Wed, 10 Sep 2025 18:02:13 -0400
Message-Id: <C3E33A5B-9BBD-4973-A6AA-9EB16044FCB3@gmail.com>
References: <CABPp-BHdKu2nsWhpfGY4MexfChxfwv_0mqvpgrV3kbYgdCYKEg@mail.gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
In-Reply-To: <CABPp-BHdKu2nsWhpfGY4MexfChxfwv_0mqvpgrV3kbYgdCYKEg@mail.gmail.com>
To: Elijah Newren <newren@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 9 sept. 2025 =C3=A0 04:58, Elijah Newren <newren@gmail.com> a =C3=A9cri=
t :
>=20
> =EF=BB=BFOn Sun, Sep 7, 2025 at 12:46=E2=80=AFPM Ezekiel Newren via GitGit=
Gadget
> <gitgitgadget@gmail.com> wrote:
>>=20
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>=20
> My personal bias is that things like "view with --color-words" makes
> more sense to include near the end of the commit message, just before
> the sign-offs.  Not sure if others agree on that.

I=E2=80=99ve been using a Best-viewed-with trailer; I saw Peff do something s=
imilar once, I think.=
