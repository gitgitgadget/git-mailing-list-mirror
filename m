Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42B0381C0
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705861731; cv=none; b=oP/YwkX3AsvLU+5X8wk9ZUdP4x85MpAlUTbZvMf7DM9sthand1QjKeTrxAHndsT4lRe6hxUTL9BMeDYbSqk+t6ySyIAAnu+0bIPM36Q7R4k30YD1YgSmrddE0g8J1Fu1Ck8xplmi0QPMh9sMF5OozVSeZsFvBGNPuFPmuU3E4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705861731; c=relaxed/simple;
	bh=VDIllDUDutWbYWuG47TF7PYINx6Nf9mDAsdIj4ik/VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouLeUvZBawn6UdGzEzAgTP++Au7+pkGBoAVL0ug3/3/jRGtfn/d4quaQd2cxWHHF6HAow/rizu/5NEnZVZO8QFzyjDHa8l+ObBsSePPglpj42xixr/GeuiSoUT5BTIw7bmlf8ZU1vi/dquU3PyMDxQdtINn0u5JTaO2MITzqgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF8QV/+A; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF8QV/+A"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cdeb80fdfdso25434851fa.2
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 10:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705861728; x=1706466528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL+Z+FjRuqPVbVcIviQ0GKO2PZhG/rMSxbsd3Mq6+78=;
        b=TF8QV/+AXexBvY7bWltsmecwdsxxisjKtVWSSchxaLTwSdVMO9w/3T/LGMykgLfwjb
         4AYCHnJK1P4LPaDT8qhoPxuUbtyVFvUXVZMzzWU1hH7iidD9jqxHz1h7gKE4m1H0hyoA
         TrQrK2igEvm5XgRL/QAwrysvffZKAk5pazLdgPoBIAp3YyJI9YknWBSaOYAy1yCi4FQL
         RONXsdTQtObWapffl+oCIU7FbW2LYl/wg/UiB0yeWKz+QI8DvEj/MpGdiLajZsh0C31j
         jcR5ICOlA8S7VNN7nwq1xvEqqHMVSxSlKD6TuLM54gy6c1rf0+QWw8Viyslk9S4h5zP4
         u1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705861728; x=1706466528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pL+Z+FjRuqPVbVcIviQ0GKO2PZhG/rMSxbsd3Mq6+78=;
        b=LdqPyrULjQYOR4KjDzTOUvbcaOA7Gv/2jl/ZPs7uK6q56TAVe325Y4C8k89IEX61S0
         fSdWaCwHV9P6U3tHYF28YYXejXSme0H3XCliuR+vbnJKqhL2usC8w/x3bnccN8e54IZ6
         aHWih32Tbvu2cUoRrEGK1lpw0FQw0HhzN0r9C4I6ODMghias3v34DgNVddxfHLkRSK6p
         LwXuzOb/50drEN2WBvoiP/KZgbezrooEAfgQcVfU1V2Eg504qFN/IW/ZLmnOugUBjn+R
         q9WUDXWvtwK/4VAMRt8muLHHbQimU3zEEqrIuhL0VQF4kc3hNTIWIqjeEWUM2FhLjKRg
         zXyw==
X-Gm-Message-State: AOJu0Yy1bHzwlK2TaM1TPYx4MfGBNcUrafGrArsyJXQIXmhSvMllY/jc
	WsPqT6P+mu7om9vTcEeJFlr+EFmSPh1RA1aMZiXvJn+iRutbmlVVaqWkCFekIevWbi+j9Wyo7QB
	p3vZS32N+p7rBHhOJsm1MAA0weCg=
X-Google-Smtp-Source: AGHT+IEn+BJv1VSmu2n3CJseykzkLAslxpjH01V4yc8dcmGiJyNXvkeCwGQTtpV7FRm51lxT1sW+9Xwn9bECdCMozg8=
X-Received: by 2002:a05:651c:1023:b0:2ce:f945:9d57 with SMTP id
 w3-20020a05651c102300b002cef9459d57mr88870ljm.166.1705861727768; Sun, 21 Jan
 2024 10:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com> <06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
In-Reply-To: <06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Sun, 21 Jan 2024 12:28:11 -0600
Message-ID: <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant
 commit handling
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 2:24=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:

> On Fri, Jan 19, 2024, at 06:59, brianmlyles@gmail.com wrote:
> > From: Brian Lyles <brianmlyles@gmail.com>
> > ---keep-redundant-commits::
> > -     If a commit being cherry picked duplicates a commit already in th=
e
> > -     current history, it will become empty.  By default these
> > -     redundant commits cause `cherry-pick` to stop so the user can
> > -     examine the commit. This option overrides that behavior and
> > -     creates an empty commit object. Note that use of this option only
> > +--empty=3D(stop|drop|keep)::
> > +     How to handle commits being cherry-picked that are redundant with
> > +     changes already in the current history.
> > ++
> > +--
>
> Trailing whitespace on this line.

Thank you -- This will be corrected with v2.

Is the sample pre-commit hook the ideal way to prevent this in the
future? Or is there some config I could set globally to enforce this
across repositories? I was having a little trouble finding a good way to
accomplish this globally.

Thanks,
Brian Lyles
