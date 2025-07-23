Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06AF27817A
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257656; cv=none; b=CGWcfNkJW+cD1CJdQEsUtuAEV1P/0G6xMI3bPifgsDHx2AVizcdEjUzds/tNGtHBM8BYE1K+ONAkOupazqeZP2PzKAlsSzeZvW8YSGeEm0Ik0Y9s1Ya3MgmHo7LZlJOmJLVNbmoV0XWUQECJD4UZr/B7fZ4ehcgkK7BtPaYWGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257656; c=relaxed/simple;
	bh=GH/2vY9LJhAA7US95BD5UWxFWJt+b1pl3MypanRM2HU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=remrc7MhenMjp71uz11kbhI9LdY2yKEXNEE8wdusHSrLi2ZJwmtWn98fMYGp7+hFRWpEQ2QL57HU58lusrl5MB1ht5RVn4Tv5sT/SEOH+hM50eHG8UeBuTJxlhr2FRyxtF+emUtfUAj6fVhONyc4TglnKFM00XjAlL0traJOI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGPcaztm; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGPcaztm"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-748e378ba4fso7435707b3a.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753257654; x=1753862454; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH/2vY9LJhAA7US95BD5UWxFWJt+b1pl3MypanRM2HU=;
        b=EGPcaztmcvaHwhdFxrumMmzyFUt9rphBhuzG1iExYMKs9eiqSy05R7FUhbpeHAxl3z
         fDobuSr0759GR27WGj7cEX8nbGxTeez+6L0NzjXcrn58w5zNNg0uPkMCTAS4IgyH6ePv
         6nUdu6Vlow9UVHrmE7TuECDUw6i98dXSV9q7rGQJJ3Tord8GaT3VDTRnATwlFYNBBG60
         soUgOcYg+Bo5oFHnpal3eK2BjIiVzyKMtgXsZ1Z4eBkUGLA6PNheF/Gp3qkdLsKOdria
         1j+L7jMLgMPi7nRUVdoi1uV9CPThXwmeZGDYhNGMaB5esAwD8LnohJGtFUzBMTvqZeur
         vF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753257654; x=1753862454;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH/2vY9LJhAA7US95BD5UWxFWJt+b1pl3MypanRM2HU=;
        b=g1mSNrFhD07LsZG0z4jAZqqyy2A1ddGBkd1KWYQfx/XHoQI+301h3qxdSLpRpZ0N2S
         NitAnPWlWkaLSOoQKzOOp79yJkSLYZZbDObaxNlCQ2H7lYm6RGxXGgiVnaKg1KmSJZXQ
         hQwJNiG1UM2BkoN2drsFtocKtbhSpk7iJkq7lhdFeg++RGdJ+rycrge3hd5o/rVesmqc
         nHRu4TBjURQ/yuBcC/Hlz2aRS5KGkMwk6AZh64r9pCLk+iWiNem0yVVSHx2XVfPoTYPe
         +6/6XvnJdwsHcDb6vdhRFZWyfdzhWyHUpLpDkmMf//tZAGO8n/xFJOywVumbgOuA64YO
         9DYw==
X-Gm-Message-State: AOJu0YxyQSio6d0NJ7qH2J0Y1FJG0yjPOHGAvTa9CElmB5A1Tma+6BZ3
	mpCjWiv4wmG+0iSd6bslnd181zZkVEEZFqanOGa6a0kSozFN5yaztOxtb2CKExA8U0U=
X-Gm-Gg: ASbGncsFn0yGz6oT+K+lK4zradzx8LZMEUcHdtxDWGs3UecCzgVSPoTvEHqHSwAdbld
	RAtO6IqzzOv9APobzm3bOpW7bcbJkwIGo765sCSyd1Zr6lW5lHNsFVUdvKlT4jhNriwqbumGcJ6
	Ok8iS8kP3Xj6QTx+V683LvVzcKGRt2O8S91G+AEGCc+0M7bSW4kGmh+MoJTLFDm3C1zga4+63hD
	BstndsGd1Gv2HneEDtDl2hN0Wnm7DtSb64XAykOLad8RSoIvQLVY8Um1ECKrGuETglL1UiHvHxk
	BdUA7jkVtBNUVrXiuG9kgNq9dLIkDtK3DVC1AD04vZGUsHZ8a78duBR82IMQu9Yic3wSEWiMWdY
	Nb6QaOrfabcRtq/Q3aOR70teMTssAEENcW5fqDxy5T6O8TnyBIBrEmv/K0D9JCtLt5z2sgmqjHc
	bPDHciw/44vu49CsY8hEaIS/w=
X-Google-Smtp-Source: AGHT+IFvL7JkQPc4mgm5gpsgz0vqiOHTGy3+dQgNmPwRo5A/w2PuzUal0BJxYjP+rymQBWUQVYo4Cw==
X-Received: by 2002:a05:6a00:1491:b0:748:f406:b09 with SMTP id d2e1a72fcca58-760367de539mr3354364b3a.23.1753257653783;
        Wed, 23 Jul 2025 01:00:53 -0700 (PDT)
Received: from smtpclient.apple (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbd67ed2sm8957857b3a.135.2025.07.23.01.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:00:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <87a54v8nmz.fsf@arnes.space>
Date: Wed, 23 Jul 2025 16:00:43 +0800
Cc: git@vger.kernel.org,
 =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com>
References: <87a54v8nmz.fsf@arnes.space>
To: hi@arnes.space
X-Mailer: Apple Mail (2.3826.600.51.1.1)

hi@arnes.space writes:
>=20
> I discovered that diff output is not filtered when the `--name-only`
> flag is given, it always lists all affected files. Is this a known =
bug?
> I could not find anything in the documentation.
>=20
> Perhaps related, `--ignore-matching-lines` is ignored by my external
> diff helper difftastic[1]. I'm not sure if this is an upstream issue, =
or
> if the way external diff helpers are implemented is related to this at =
all.

The `=E2=80=94ignore-matching-lines` options is introduced in =
296d4a94e72
(Micha=C5=82 K=C4=99pie=C5=84 2020-10-20 08:48:09 +0200 5803) Since the =
Git documentation
doesn't specify how git diff --ignore-matching-lines=3D<regex>
is supposed to behave when used with --name-only, I'm not sure whether
this is a bug. However, I'm confident that this is not an issue with =
your diff tool.
The reason is that git diff uses the built-in diffcore_std() to filter =
out diff file pairs
that shouldn't be output. However, in the latest Git source code, =
diffcore_std()
does not filter file pairs based on ignore_regex.

It appears that ignore_regex only takes effect when using the built-in =
diff (builtin_diff).
I'm not entirely certain about this, but if that's the case, then =
regardless of whether
your external diff tool supports --ignore-matching-lines or not, this =
option is likely
to have no effect when using an external diff.

>=20
> The behavior can be observed in git 2.49.0 using `git diff =
--no-ext-diff
> --name-only --ignore-matching-lines`.
>=20
> Best,
> Arne
>=20
> [1]: https://difftastic.wilfred.me.uk/

Cool diff tool

Thanks,
Lidong

