Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D602277C9E
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932335; cv=none; b=XpCStWlHT7EWNQHov4dbxZkvQnYEUv5Tva3r4eekswTOpm+x50ieC/7ztioEj4qNtVaFq/qpL6OHATe3RWi5vUTIFPYrQyXw10pVDzLDUqoqC9LAMwIqC8gCfIx/vGBWDe42jyjfNVbSRzfLh51z8H1qS/cx3QHuTF5NvKlhCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932335; c=relaxed/simple;
	bh=LE1xd9N46b2I3yh938Lx4JVszFTJlU3XSdZ7abDQvJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKKOgyG0VD9GmPNeil0oDMkZfAkVAGQSk8cW4HuUty1985yQjFs3JubX5wLyRe5gTm1R+9O485Px1L+XhOukIatrRsSWAqmxJZD35FnHy/g3M5QMq4pu/2bCG2dkEKmSbRP27OPCBx8kGyu40eHcky3nnVrje++J5Slm5RhdodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7J6tuTJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7J6tuTJ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e9d633b78so78805866b.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 23:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762932332; x=1763537132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9a7dXq8ZXEzbSdMVYlU7EHdBQUxrDdZgQLf8Q4ezBc=;
        b=T7J6tuTJrF0qgDPHktlh0QTRHAcxm3wtWR84lkRctR986JjbRQBoRO+O2m7PXlFuKF
         59snJYpQOgCLAvnkcN2fPDvjSgLYlIqqWrrsN2bv2fOhscC2oZBFdlceasoSLrxuV/xa
         B3/XUK13Xu/JiR5bafFlMLKjxbZ82bl4OJ4eO+6EIANf7eueEfrnWpnARCRJ1tICZH9b
         yhhoteMsvugYuBB5cEV429Fdq970VZVPz6x7J2NfEbwN9P6t7zKNZpqytUId95ysQlPH
         hILC78gMCbylb83fYOHgRWIXtcZ7DUUhGei9D2ROGVUzOwPyPJaMPGCyfZcGyhwUobGc
         slVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762932332; x=1763537132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e9a7dXq8ZXEzbSdMVYlU7EHdBQUxrDdZgQLf8Q4ezBc=;
        b=bhMcSuWkVsLcbcvVzOSmrtBZbP43NzzOTqGbdnf8Qz+oeyT1TLVupCl/iBjmLJvEdL
         TJyYG4n3mYdkZry3Ld9BiI4xZ3qU2tqAJPS3ShrvxAVCb0m8PyzLZbOQH/1je9OqC6xf
         SVT+pmcR0aSo63RNaFfihNA/u1m2L6pU5cjE+Fe2DQCbSRMf50twRs4W+r+DeufdYXrk
         fi53+KBVTIbboU64XrwyJcoRHP9a55tgITWohB5tWwQvtru7zV3YA5Dd5luwi0y/NELL
         6VLm7SOxNpQg6HR4vi4zQAoj9mbLG8ot9ORFzL4ebHiXXJcisk3r5x0f/xh7r05+fRcy
         VJ/Q==
X-Gm-Message-State: AOJu0YyI0BQdRFGQpgaZcU8/dK7PqTRg9j3YQh6tCnAp5UmVKlejGNZn
	+vi9nEMunfO8IoH00JLBYymh5Antqsa8ph2LtBsUsO9bIOGjJyhizKfOt91EsFO44vNCXZKKPe3
	8ULgIxzf0DdKkV5hVF75udtUH0Pfp740=
X-Gm-Gg: ASbGncthIrV4fKFiV9+qF3+KObA6Ell7Hh0CxElW5J8i+FdKmP5U6QlA0ZRkul72X1h
	8qvx6l4y/gptoVWw4T+JUP7YGxAd2VZgm+0J4bKRn91SctXKBOaIXJNinM9IDPL5bNTT3kbJ+Ab
	zB8BRN1ErR4UWHm5/u589RO0JoHy5WNRKUQ8M0AjINn4mcGGmQ5bf7TxEPsEqESK8kfCCf1Urr4
	YjRX5kiwKik+kgV8qVQwb351dLFNSZ/QDo5FKufOFbxnQK6oJT6N80mfOKh
X-Google-Smtp-Source: AGHT+IHDl55Wse22LpX0HlfP28j81RZppmaB4HPPI2xLPpvlPfd8n44C1rLOap0O3JFxmbDvHPOUDacqbD0p5FknkqA=
X-Received: by 2002:a17:907:6d0b:b0:b70:b161:b9a8 with SMTP id
 a640c23a62f3a-b731d1498femr673128466b.2.1762932332240; Tue, 11 Nov 2025
 23:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105061918.3688870-1-christian.couder@gmail.com>
 <20251105061918.3688870-4-christian.couder@gmail.com> <xmqqjz00e5ns.fsf@gitster.g>
In-Reply-To: <xmqqjz00e5ns.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Nov 2025 08:25:20 +0100
X-Gm-Features: AWmQ_bmdOSrahXGrfNh49RuQiCUwxcq3dRhJ1PvTors2eozv83YM5j-aZfifkDI
Message-ID: <CAP8UFD3G6kn-n1_rXJgcZf1djUE4Ner5xd1YaNr5tz5h8d_Ypw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 7:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >  t/t9305-fast-import-signatures.sh  | 118 ++++++++++++++++++++++++++++-
> >  6 files changed, 226 insertions(+), 28 deletions(-)
>
> Unfortunately all these tests that assume that explicit-sha256
> repository as a subdirectory exists would fail when the topic is
> merged to 'seen' and the tree is built without the optional Rust
> support.  This is because brian's f6581e23 (repository: require Rust
> support for interoperability, 2025-10-27) changes a couple of tests
> to require RUST prerequisite.  One of them is what creates the
> explicit-sha256 repository.
>
> I do not think this topic to preserve or strip GPG signatures
> particularly cares about the dual hash interoperability, so can you
> rearrange the tests in this series to avoid crashing with the other
> topic?

I will do that in the v2 I hope I can send soon.

Thanks for telling me about this issue.
