Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622CC296BD8
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917795; cv=none; b=CuHNtISo5f32/dGoGXpwLy4MI7VWPIJ0vXz5ScHaaSYH/IILZAA66OB2jzqMYHYqxaJHyLA8R1fMUhAYzGdfi/mfQ26kN3bykznKI4bWFVpC+r0QRy3HIAaWqXUCNBJefewTJt+qUwnBdDUH6MVoAOLWKvvf9RIZFgtMMK7N66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917795; c=relaxed/simple;
	bh=zaPkIAPmWQVnvGqVeLC1XJ/5SldWU5+vYuLmOjfIJdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/M5vRE1kHc+mz7Tj2FwAc8xTHk4BlxEpyxCpqav8Q7cxTSr8/F63zl83jkpdG3F3AUiT3LjS1RJepb+Vwmt1oP4eX0yqngRUMOYduN3kVkpKprgWwpBAFEsZBz9roh8ZBczcnr6/cg4p+doDTavxlDc31/nCrd7OMbNTR8Ksqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee2qn7n5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee2qn7n5"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b48d8deaef9so1062074666b.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759917792; x=1760522592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkbD+7SsIXrgAslKoKSUvhSRbfMAE11XUOl5SZ3ZNrY=;
        b=ee2qn7n5zEbxza3UMOiz9yFidHcH/tG7rcrOlhBtdRp2Ya18F2MzSx8PeAm38h/6K+
         IsOP0qmFCIhKaDrvFwO8sXJn6xJnzHRdmvsDRhZN8u/qLJVk0WOR+uNDc8k/qviRgpwU
         j2tUaS0TtMIGmuQGvQ7BBeNsclygEsjdBn8E+8Ksf9aFpD0HSyP+ki6CS3kAWND6X1Np
         dlO8Sn9pw9JAvxfef7gSBlRoMSrFB1B1OKEkAxdOean/zt3DJkCc2rfAmB074sIrAZgU
         1lGxYmb/popIlRUeSzXCS565PKx1qUD6KQh7iA8Ln9jh9HUrKv9f0Zz2LnJ89IwYf6Yx
         xHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917792; x=1760522592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkbD+7SsIXrgAslKoKSUvhSRbfMAE11XUOl5SZ3ZNrY=;
        b=Wmpyk/5DGy7SvsgQQvIQyls2b46CzCKRCaMqXo8o7opTn3Vc0DHFUMVXrJ0pHrik8N
         S5QUbG0RWtDymz38tfSwJXlVeN2ouaGbt3M19pnq4XFf/8whdIY8X7/VOCIEz24eM4sz
         sBz/CZm+NvZMQjGzuo3l+psYdH02V9L60Mm8FQAieHN+i+jx1aacM2x54K4/Gz4bblVQ
         cY2o1LC0/m510Gq1zbizjGgCNMYdFXyJIj58SpljYOw2WyhLdVvhYhqhAVjL1rkYgipR
         ExP7Q07pWolPlecFLZZt9ev0CI38swMGUfO7MUYzqWk2bpEF/Qt3JksjoGP79lTjo3T3
         h1TA==
X-Gm-Message-State: AOJu0Yzg8iPiHCsoslqaJZGeT+G5Jjk/8NeGzhpe/OR8+TWW6dMBqLwB
	E+wK02LhU5vnyfhoRQbtlYXoTPOEmmCiuVLrSBRdQSUoNmI00fy7aV+V7Dp1gOi1qOL7P49CjIM
	YsGYLZkROF/AZJiQz2o2EK8wdeYM6j6s=
X-Gm-Gg: ASbGncsYozCSGYASrzTPCKd6RJAO0JG/9qILu+fy2Le4cMXHoi6Dv96B3uH7X90NcC4
	6+zXE57bjz7PV/xNsHBJkoOMCPKED/ChdR2rIqZhkeHfsS4ex9SA4aEtkQCS0ZPdsnO0VbddZ0i
	SbyxrV7gDHtkBCiiNefEwp9tCsaPOTtGOTc6HwmCM0Scmi1KrqX9ui/vrSuY+71sPBIgwalYwta
	onrxE7vdrvLm2tvkXhjl2ARQAsEU38=
X-Google-Smtp-Source: AGHT+IE/WY+EneSWuINXqrgXPPRy4Ip5rNY+N0ch1M1r9n14OAAejtiBr1ElwnbChMYuHbaQ1f01p8k/szsH+jMgrdQ=
X-Received: by 2002:a17:907:2d9f:b0:b3e:8252:cd35 with SMTP id
 a640c23a62f3a-b50aaba153cmr313976166b.21.1759917791557; Wed, 08 Oct 2025
 03:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-5-christian.couder@gmail.com> <aOYPWvdE4VnL8T7z@pks.im>
In-Reply-To: <aOYPWvdE4VnL8T7z@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 12:02:59 +0200
X-Gm-Features: AS18NWAxaiOfa4ZazY60V8nMm22SbWLba4EkbMXdnUyFqVIfJCZQ6A2Mt8r_YSk
Message-ID: <CAP8UFD2HxcJjaWfBWX3bo_LM4gSQMmFZZiYS0Yqp1zV3yZPvag@mail.gmail.com>
Subject: Re: [PATCH 4/5] fast-export: handle all kinds of tag signatures
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> > diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> > index 21ff26939c..5a46608f65 100755
> > --- a/t/t9350-fast-export.sh
> > +++ b/t/t9350-fast-export.sh
> > @@ -279,6 +279,54 @@ test_expect_success 'signed-tags=3Dwarn-strip' '
> >       test -s err
> >  '
> >
> > +test_expect_success GPGSM 'setup X.509 signed tag' '
> > +
> > +     test_config gpg.format x509 &&
> > +     test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> > +
> > +     git tag -s -m "X.509 signed tag" x509-signed $(git rev-parse HEAD=
) &&
> > +     ANNOTATED_TAG_COUNT=3D$((ANNOTATED_TAG_COUNT + 1))
> > +
> > +'
>
> Nit for this test and all of the below ones: our modern style does not
> have empty lines at the beginning and end of a test case.

OK, I will use the modern style (instead of the existing style in this
test script) in V2.
