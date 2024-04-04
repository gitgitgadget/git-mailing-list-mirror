Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046345C903
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219790; cv=none; b=Zt0IaEiR0aaPS+tYqxcuUJpRI6+kERHaBuGv00MuuVoipvRkxbiP1q6DrdHHONliTLEWM5L0APXclbPvcQ+gmCY256RNqZs+AKNecskhsRi4msJkXZaUbPZHlox8liXJ3b0x278b2W3gisX6EGQw7hzVqmFu+wXzDrLjTmIbnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219790; c=relaxed/simple;
	bh=P0ipYxxlpoBGfM0e+flGzFvq54vfjvDBy8pk2H/YRPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzZ6jjBcXEBO766/eagrYzSaop4Lv0Jx9OMwciJjCtJZKrhFhEhfS2LXl714b8eSEAFznicLC97/qcxk4PUSn28ReicojwxGnQgqnjjQGySz3QWVZAagrbBaUrtPXDLkoJ6YTa1eFOCP+a6Vd5TFIq6EVsYel/faUxJ7PB2wLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivAfbLmx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivAfbLmx"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e152c757a5so529443a12.2
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712219788; x=1712824588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0ipYxxlpoBGfM0e+flGzFvq54vfjvDBy8pk2H/YRPc=;
        b=ivAfbLmxLwr8RayrZcfCKGfg3FVBZ8+f8d6xvgIMX10FVyaYHBRteX6ClNtG8kHNb9
         4sWG8TI5O7Ct9/r/lTWUYtE6W+kEdJT4G946RdzjdZxEvu4adqQXkziVcm68w4D7koxB
         A3FtdvMv3NNBh4SozL6KiQO/KlSyaxycMFY4DgPMUWPE4zdQGrUq/3j1BU3HaTp10WDl
         6XNkIXmDJ6HuKSyt5dCrR4xbSRi/T+RisvUj9cOV8VJhfSFnJ3CNyw0pYh5/fzGbul32
         umXc6AanHq5kE7vI0kwv0ziwYqsz0NHD6ZRcSJv5iT/N3c8sXEvz+vJEiJld05zKZuol
         jdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712219788; x=1712824588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0ipYxxlpoBGfM0e+flGzFvq54vfjvDBy8pk2H/YRPc=;
        b=p48ZdO07qNLM2lRQyxwbxVRT0DSLLtwBVWhOPiZgkToKJGkhGv3LTxArpGCONU4K1i
         lWxzFvCIJ+npcKaWa4FuPFLb52VRcM6Uq2YNR7BcYM97DHm6QzuzdMBYGvRI4b2Laa75
         Ic8AOC5P5j5aGk30x3AV7CB1BENS2/JD6SDV3XMgTvNHNpdfh4GNTErreXrSjgRbKLcc
         CUWIXENoLAIVwkvxKa/5CJhDtGZO1a2E8WWaMxD2nMhBjL2Q80qTHbh2lVe7bPO0ht/o
         Vxjn4tCsVlxroli7dURGHT6maA7l3OmzP3BMqn52Jc4AxlYEB3LwauRh1cd5+DlBIGIu
         +XtA==
X-Gm-Message-State: AOJu0YyaMkU0SNiTBjCkzswWepCccmDqO0NE7TB/jUDBrHHbh/lCKrS0
	YiQtLy47EuvbRh9QcEpeRxpZILxAzeb7oHsaPwViNf+3VY7PaiGyjjEZxtISPxsa3QwVQCGFEyP
	J54ooZldjZkODT5vdIiwJu4MDFXg=
X-Google-Smtp-Source: AGHT+IGBVYKm3fq8POQwPfxxE0CJX9dYC7ajLXAW8Gw6LngxCXhyOGsVeIzjecy01KWH4ywo2+YZf6PW8uMvamKQDV0=
X-Received: by 2002:a17:90b:1081:b0:29b:b5a4:c040 with SMTP id
 gj1-20020a17090b108100b0029bb5a4c040mr1636788pjb.46.1712219788212; Thu, 04
 Apr 2024 01:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
 <Zg0zs2_QLpXv2PwT@tanuki> <CAOw_e7Y_MwgrrJzuHk7tzBR9a2kDfTnwCzC-7_rgj8UJPKqp9g@mail.gmail.com>
 <Zg5HXZrL_4BsyzfG@tanuki> <CAOw_e7Zzc2uLX0FtkJ3fB+wuNJt5piMmoYVes+ayApe8BEN3+g@mail.gmail.com>
 <Zg5Up_kSvOmQODO3@tanuki>
In-Reply-To: <Zg5Up_kSvOmQODO3@tanuki>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 4 Apr 2024 10:36:16 +0200
Message-ID: <CAOw_e7b-zTZVGW_u6_ZY-CboHGOSWHbW7mxnqmxh+uuQa-VsTw@mail.gmail.com>
Subject: Re: reftable & jgit compatibility
To: Patrick Steinhardt <ps@pks.im>
Cc: git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 9:20=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> Different blocksizes is definitely a bit of a sore spot right now. I do
> plan to expose write options via Git config options in the future, e.g.
> something like "reftable.blockSize" or "reftable.restartCount". But for
> all I know the CGit reftable library doesn't yet play nice with block
> sizes other than 4k.

It shouldn't be too bad. Many unittests use blocksizes other than 4k
simply because populating a multi-block table takes less space at
smaller blocksizes.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
