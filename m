Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA72E645
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712408613; cv=none; b=U5iQNf2rC3+fNxK1zRtmIlfpicCX90M4ZDUrJgd43WjnY5zngseJ5dmLlCR/0c31D+gZtsoGSF5jDJhFx5obMtWAyMGgmoZJdgUM8O3ztcPipu8dxg7RtTVIKjhcgDarqV+IGyIZnTVp0fslJp3sLSfX+MPg1CEtPrX7A4xVWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712408613; c=relaxed/simple;
	bh=NqrSEp8CFA2QqFd9m6Kpr3IeHEcTouHrbrpOpKNy/iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipu13Ao3wjEAd4xFhjQqppD73ZUeJCpzu1ZiaF57XLqaVeOjPRvE0FwdDf/sZzIBexow0NMLY66SZVdLwU7RVD9txjXPGdcyaY5c8qZ5O6T1J1nXNO3xgWll9RKATpsLy1b3wMn2s2hHa/gm+H5Y35JVk0EQf8Goh/1W9c5zDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWn8iikZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWn8iikZ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2507764a12.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712408611; x=1713013411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVv4+54y4/P2QeTgwJrKJn1px0xzG+/gviFDt02864k=;
        b=PWn8iikZg9ig41JxQrsEpOCVdlb3ZWjgRDgpUZI5RDjRxAHoUt6hAKyaeObivORQyu
         SmO11EvCVjhcDy5RIj3Ta50wMHBk+1BMVNjy4xZlYJaWj6oKdWJOtK9JaaAldjvsBnvW
         3Rb0WEAcAyBiDs6HbIUOvUaWuzEcsuxPO6ceFGr9E2/lOevJXA/5t73CMVutXJ1V7ymd
         x3UfmF/qFi7suVlyS3zL8XoYMwNY1U8uVYVqvwlUkipOfKCDFZzZtBMPqqmOPvykij9C
         kHizNax07LLpRGSSuQ20XN9zjWtzwh2ogx16aCXFMABcgCaxuh+n2dQjws0DSdSMCGsY
         embg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712408611; x=1713013411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVv4+54y4/P2QeTgwJrKJn1px0xzG+/gviFDt02864k=;
        b=Z+6hCMLagDtoKoVjbVZewGF/rJEjiIu5X5P8iccm2BHxiwdDPopHWbk3rDdP6UsaNQ
         75bILTtjzWOeXrDH4HmElncqLAhW+6Zqqegj8vXNf9XhPE9Vkw9YS7fnEBm/jd4iaW9G
         nKHfk6HRTnXqWk0lMM56KKa4m2+OfR5AyUd1VLOHPcrXSe6qkSu/zgnjVEQZ0vR7KNpt
         eQQxNi7OuJDw77MVoTLSwW3X9L1BSzXDZz4NdZXNGtja52Sxyj3Wq61pvATVhb8VFoA9
         R8XJokgnxoRr9D7Xa6LGpzKp5v3gcwcvrtisCkBS+aU3RJke2MP7PHXNxOyclp8RLNLc
         GA6Q==
X-Gm-Message-State: AOJu0Yw+ycl2aVNFmDrqbWK8r0AKuM+jPPsyvk5o6ZrkDhlj6EsFSXKI
	cOM2xIhDSpoUIghtJelHNM+fOXyvY9YECEdPK7ntkM5QGs6aZfuIyw22zciTqiB7ZqJ4XilF2B9
	z3hCDb/VH1B6HBynILl82FyahEZ9QofTM8FE=
X-Google-Smtp-Source: AGHT+IF3REQnE6NrErOobs20aenjX7S80G+a2btlhthyFffVm6FLgbI65z68UxWoA7MThcZlUD0ezRRZ0WXHIbpyoIc=
X-Received: by 2002:a17:90a:cc0a:b0:2a2:ad4a:691a with SMTP id
 b10-20020a17090acc0a00b002a2ad4a691amr3697881pju.22.1712408611439; Sat, 06
 Apr 2024 06:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712235356.git.ps@pks.im> <db66dd4155d80b714719e80ff90f64c1d36b97d0.1712235356.git.ps@pks.im>
 <CAOw_e7b5wDKOcY9hSty+c+z-NWVUgri3h3ScF0qd1Y6cmfsyVA@mail.gmail.com> <Zg_HPQFlNazTlDRa@ncase>
In-Reply-To: <Zg_HPQFlNazTlDRa@ncase>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Sat, 6 Apr 2024 15:03:20 +0200
Message-ID: <CAOw_e7bx=KEeA6sdoDPti6LvxU9Pmr9ZyzyrXfyTmT3DUcHL6w@mail.gmail.com>
Subject: Re: [PATCH 12/12] t0612: add tests to exercise Git/JGit reftable compatibility
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>, 
	Luca Milanesio <luca.milanesio@gmail.com>, JGit Developers list <jgit-dev@eclipse.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 11:41=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> > > +test_expect_success 'JGit repository can be read by CGit' '
> > > +       test_when_finished "rm -rf repo" &&
> > > +       # JGit does not provide a way to create a reftable-enabled re=
pository.
> >
> > You can do "jgit init && jgit convert-refstorage --format=3Dreftable"
>
> Perfect, thanks for this hint!

on a tangent: I wrote this a long time ago, and it does no locking,
which probably leads to unpleasant surprises if it is run in parallel
with other ref updates. What would be a foolproof way to stop other
processes from stomping over the repo while the conversion is ongoing?
Maybe create a packed-refs.lock file?


--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
