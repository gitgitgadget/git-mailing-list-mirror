Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35643A0B27
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808885; cv=none; b=n6Na6JKeVO4TwU6Who5R6UEY0eZztcPGcf45GZ7w6eiUt5Oi9fd7CszCxiprhRRLDdzhKx2bxCI4dwZqRDZOd0m6JUoPmwrbd27602KQUU5nZ5V1WMyYCxuFFeFXcqHDaouLflqXYSVbj0HTaqLYXtkuRJgX0maSoHQGL7oO2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808885; c=relaxed/simple;
	bh=hAFpMEl7gxZd1jgEwAYEMFgAugi6LoAlDgom1WWqaSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxtYUKN/nKYNb6S3A5LZtZNEh15HFFji027MxfAh3pvPFX1gyHIn+up+NvgNWZ6LjDUPrVDHTKu0/I0pmdDgLFAaCgdD7joU/Mg7DWowXb6B9O90U8JMtlf9tW9amDfa3kH2HbTJUO2ENQ+0ROUKt0EccGeYE2OI5pmd8p0HlSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNJw5sXe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNJw5sXe"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso1386722a91.3
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808883; x=1768413683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pFs/BGojHqt7l2oNMSh9YdRF9zdMKLIhVue4o/enqE=;
        b=fNJw5sXeUr9lgGjsEdn4xXOEBx7e1e0y+Uu3SRXHl01g1OJnPZXA7xScWAd/zYJEyP
         xNccsDm/0EPUowrocrXcXUEcN5YdCyc2w1p+RmOVN14Fy5A0lFJaWs/8juaXM6Gq2qmV
         NnAI/A96OXOUMBQD5n0ktyzYFYifCukZczmaLnpFNQQx0K9bsMBVY7BBmo4FyJaRb/Ku
         fFkUE/w2ZK6bfppD28g9N2EicVFCCSWEhSe4MwW95Z9yNdQFcIqIuqq2dPjdxyOC5JqR
         nJv8W5X4KzdXlayJgi+sIV/O/vdK2+vVpr3LRtzbUK1bfuPmoh8dkwLvDbImi54AKTjV
         e8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808883; x=1768413683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pFs/BGojHqt7l2oNMSh9YdRF9zdMKLIhVue4o/enqE=;
        b=jxErXq5xAnqRACSYTxxfTjchWFkCOmOCJFGhWk18GSYhxllFULX5KZVN+uldsiZCkF
         jVBra2erDXpUq7bVouYe4XQCo+FsXikp42jFRdMA8tTVM/lUFdG9KlFNjw2uv5TnaXds
         oGVMVSoLt3wr1RwqbaZSdFdhHOtkJP/kxEXAAvlB178n0eZlSagd9AhjuEUcQmGGgjAS
         JN/iDih6luwOpKcXkR5DYFxHbX7EBunJKmac5rzR7xJKab7UsEA+9hxxNHsqVw6OURRj
         TTRilQpua9T3gVmOYVZuqzb4P6Q+CXTFZQVmKKbpTeLH0rzC5+wSAQuIqeKE2PRQFCZV
         euxQ==
X-Gm-Message-State: AOJu0Ywmjl0iMUxbAQ8VByZxbjwlGUJ/Vib03ul0kE3nXpLaGtEJ14YH
	HPkCao6Lf2pHH5BEGczbnpgcupIp+ebMWRmosJ15Ur7VABu7dW8g+UjbaFKRI4evKznsCfXTRip
	6nX44LR7+JLkquZXco7V+q7IWjabMFxI=
X-Gm-Gg: AY/fxX6HXD0fEvc1HBNymitEl2fsyfEsUdheStV8Ee5lz6USnUpnTgifHJSh6WDAC+K
	pDssmv2Ox7V/xjRBx3RoX5nUl+KBEKkzo8YOMntbHye2Ev9Wt4i7h7MtWAETLhRLzBGkUdPYVmf
	7ARv4b0IdT+Kjd4HRHMCkbW7EjFThxxwd4LI5BT/BhvHgwhJZ4iPKmBKt/NIrNHtIu9aVfWOohc
	zXXilXb654wlAzNiI/4VlMLft3tX7MhcJs1QjTgf5YttAUWPGmnvFWpcThlxfjEPpu/DCwaAhMG
	uQJrvJfHTWwKUGSZZy0y2+oxA+cLQA==
X-Google-Smtp-Source: AGHT+IGO384OdaV4I+Tdzj+krjeJaHYPPbok6U6aVU1UxYm3A95fEjVvkgbz5jbfu1Pci3IjeAW/HRbwT7T5vthe7K4=
X-Received: by 2002:a17:90b:1f8e:b0:34c:3501:d11c with SMTP id
 98e67ed59e1d1-34f68c47f87mr3044903a91.37.1767808882730; Wed, 07 Jan 2026
 10:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im> <20260107-b4-pks-history-builtin-v8-7-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-7-18e9779e3a26@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 7 Jan 2026 13:01:11 -0500
X-Gm-Features: AQt7F2rNScLbEv9L8aW37odmALULRBrLhlVwA9YguDOiavUymY-8y1widlStNWA
Message-ID: <CALnO6CDG222mhCeWyBCpGU3fQiHPVwBh=5EygRFrFN3JOcx6Sw@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] builtin/history: implement "reword" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 5:10=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Implement a new "reword" subcommand for git-history(1). This subcommand
> is similar to the user performing an interactive rebase with a single
> commit changed to use the "reword" instruction.

> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> index 5a9d931efc..4eea317e5c 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -32,8 +32,9 @@ Overall, linkgit:git-history[1] aims to provide a more =
opinionated way to modify
>  your commit history that is simpler to use compared to linkgit:git-rebas=
e[1] in
>  general.
>
> -If you want to reapply a range of commits onto a different base, or inte=
ractive
> -rebases if you want to edit a range of commits.
> +Use linkgit:git-rebase[1] if you want to reapply a range of commits onto=
 a
> +different base, or interactive rebases if you want to edit a range of co=
mmits
> +at once.
>
>  LIMITATIONS
>  -----------

Ah, looks like this commit fixed one of my befuddlements during the range-d=
iff.
Bad history edit? :)
