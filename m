Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C48230BF1
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743593208; cv=none; b=TJ8XQMXbhqHf/64zDJLQXvyOSr0y0fYKqI2uM7Xe/qx5n9/cTbrgBprIeoBxzboDEm22OFwThrbLb7uHuwdEcP4GCGK+zbpVtpldhEwBLG9MK35mYykdcDJdozLvRSSYQY1MHXbYxYw2mNpbzbwRXpM+RgT8/2T9r0sUDdqf3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743593208; c=relaxed/simple;
	bh=fKlc4Bqqyl6Q2I5Fw2Os6P9uI6oLxpWYpTRdNzs/orA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqIPxpPk9dpLwSq5nfjZfh9AETmwhcGNaX+tSkLs+vpzoHwVvXPobfrF16n+yhFk7qFI1ylf7UVqHG/33ld5D88EYpqqyQPBzjMOa5cHNLODtCXZNPbRJWTB4+8D9BFCbQ6hGsxvHA0Acm/GluhAXh5jlL4gK3d8fu+u0oVapiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfE4fsDx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfE4fsDx"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso12514670a12.2
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743593204; x=1744198004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNpFBc1TSP/uoo45XKhFcffNG5HZuWSb1ox0clVyb6s=;
        b=GfE4fsDxbC+9I4AtT07RQDvAF/XGs7GVpHWBhcBGvSZAZhlr8eX0GqUoKEugIaWY5d
         TutNqp5k7NETmkGnTOD9UBryD1Jp58FWvyopgMaJDX3g7jZMgL1dHHA2mDsS2FmigA54
         TWojqtEJy4vnVBNsiBcawRlMf75Vkxp1Ctz3hvGWffG5S2aX0k7yNtxkKWJjn9eJQRI1
         /lxnnz1wYsjb6tdhrBrl1Y+73jg5q/bZLOUkq1u9MBzbrHSddvNem91alb9XTRgTS3d9
         Sp8t/NODXtfoBfjG6CgtQHX5Op8uKXp1JiZuhkcglHDJqGGdBgB1pUI+X8Vl53Q5uOuE
         x1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743593204; x=1744198004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNpFBc1TSP/uoo45XKhFcffNG5HZuWSb1ox0clVyb6s=;
        b=VB6ekCbjtZh2bC2s47SVU1P0M3LmgHKE2JAx+rwkXCE46zKxpE3da7cS29YMpXGCme
         ryTHb38P2F62T/1E7217an4Ii+E2mxZhen5Bkyd28sRfbRzR+06z0daqAyFYfRKhAYCF
         ULlHp4IHYyjs7Qi+j2i/b0pMrSMntbJ5oqFZtq2Mv+EDJcBIc7kCRmO02FrmcWo62x0t
         ws0rq+AAcXnCxZ+45QW8UMFlrh1J5+/DYv/RduupKstcGTyvt1DincfyjHGkAom49VQX
         p+BGa3809efbHeuu5QZsXlYpUtGNhbAzFRP9r0gIH8Q5Xx0/LKro/Tvrwh928crw7NFj
         1w3g==
X-Forwarded-Encrypted: i=1; AJvYcCXfOl6dBF+VtfWS/JEOhVyrRhpzGdixQBh8vwpM9qZIUTukvty+xi1TmDeHGQDB6mSI8bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykmzZfhRUGltU+/r74i4vLoBrRUOfURSo1liXTKBE2F5d8zRjF
	rwpyd4qhN8QUHoZLEFSFT2UskdyRJUJgAJ0j8u/gyJWLhamqiXh1Gk9Rk6/Iy+32Umc0kqrCFu7
	mxBH5T0BkdXYhTj+XjesxXy3cImRcjMWV
X-Gm-Gg: ASbGncuNvPzYbZeXVN5UGRGCE9gAo7UjIknUlhL1xmVFBGpM5Bbls1zSk1/3/SeSh1o
	7+WAZqEtRgH6NAYY2Hu/QBtTIri7lQPy6yLRCBzVDW14KjybGoQr2ARYzLPMH5+ytoPJ+MblUDh
	0XOcuaAx1rOORp5Y/5CLyNlta+XQVV
X-Google-Smtp-Source: AGHT+IEXlJn7Z6Zj7AhtZQzCbVOgMYYpK8dyHPqUcAHCwkhwRAqhopRK9rnr7Ka5nMeejDCUB/rw6YOL3lKaJy+b3Vg=
X-Received: by 2002:a05:6402:4305:b0:5d9:82bc:ad06 with SMTP id
 4fb4d7f45d1cf-5edfcbe93c7mr15544329a12.3.1743593203888; Wed, 02 Apr 2025
 04:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328170121.157563-1-jltobler@gmail.com> <20250401203630.285451-1-jltobler@gmail.com>
 <20250401203630.285451-2-jltobler@gmail.com> <Z-zpY3D01Fg4q0Je@pks.im>
In-Reply-To: <Z-zpY3D01Fg4q0Je@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 2 Apr 2025 13:26:31 +0200
X-Gm-Features: AQ5f1Jpi902dqGori4ORGQfQkOKMS2152e7_-0zjtNKhQ6fWMHYrHnYwgjfqsCA
Message-ID: <CAP8UFD2UpEpqBYxqeo=vkDHwWdoO9v2RPVtnUBSOUS5MOK6n0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] help: include SHA implementation in version info
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 9:38=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Apr 01, 2025 at 03:36:29PM -0500, Justin Tobler wrote:
> > diff --git a/Documentation/git-version.adoc b/Documentation/git-version=
.adoc
> > index 80fa7754a6..f06758a7cf 100644
> > --- a/Documentation/git-version.adoc
> > +++ b/Documentation/git-version.adoc
> > @@ -22,6 +22,9 @@ OPTIONS
> >  --build-options::
> >       Include additional information about how git was built for diagno=
stic
> >       purposes.
> > ++
> > +Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK=
` do not
> > +have collision detection.
>
> I think this note is somewhat funny for an unsuspecting reader. On the
> one hand they're going to be puzzled why you're talking about SHA1 in
> the first place because it isn't mentioned at all beforehand. And on the
> other hand they will wonder what collision detection even is in the
> first place.
>
> So I would either drop this paragraph completely or expand it to give a
> bit more context.

Yeah, I think it's worth giving more information, like perhaps:

"For the libraries used to implement the SHA-1 and SHA-2 algorithms
only symbolic information, like `SHA-1: SHA1_APPLE` or `SHA-256:
SHA256_NETTLE` is displayed. Note that the SHA1 options `SHA1_APPLE`,
`SHA1_OPENSSL`, and `SHA1_BLK` mean that no collision detection
algorithm is used, so known SHA-1 attacks might be possible, see
https://en.wikipedia.org/wiki/SHA-1."
