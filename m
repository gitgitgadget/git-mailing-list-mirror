Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BAD310644
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725545; cv=none; b=enaD43rG6ovwULsPs79kZQq4jTCskA/jUBrbdNdPYKQ0FyQrmIGUs/zgtLdscIE/1nO3ZcSBRL/hlY096zqkyDLyamQyWyy9wP8cJAx2w+Vxt0FtiWYZkKuXXNH8sJqbIezL8EIpBEf3BzVG2JA3ia70foUdwgu/ACWcSX9qlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725545; c=relaxed/simple;
	bh=1cxhDKz8i9kmQ5E8KskYbKTpFgqB3WcdocCtTYqzRMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVhHNry1v7VFiVi5CM0BbK544V+hmbs27q3tPMETgkOC24sN8O90p19kbnVTtuJHUye5w2N87OwT25ahwx8bHbmtX/y/4Q0IKMO8bjq4Q9VzU8L4k/YjGrQyDm9aZxxdQOtULL+q2DLVVoMhIq7xgHMkrOGAY0KegiJZuHyuUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+hcLWCd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+hcLWCd"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57992ba129eso6910403e87.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725542; x=1759330342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cxhDKz8i9kmQ5E8KskYbKTpFgqB3WcdocCtTYqzRMs=;
        b=M+hcLWCd9Wa37c/FzBwIxCoH5F09MGk6Y/WkiW8yF4IYYzUgjLJ8MQd8ItJwFoDvUQ
         /Hn/b9Luwut3X0v3a9LoD7FB8OVMDCyGelOiVE9NV5of4Qln1XoUXV86q57kxp3+XTYt
         hjoBO3+bn8XLaHn4BIattKEgpuFoZV+5c5jwdInKJPy7OpquKOk/4gGvYzVKwR9obYjZ
         zlmPuDbGzpd20GDhD/CUXz0dlOk8+6Vi57iNOtkwv83b4Kp8caSq4s5aSFiCIHKheJ8E
         wCfMSHlUXfM6t8urMALDkc1bcu4N0HB/e6Ftcg760rwrvJv5hPTes6mpLA8YnT2G8GeJ
         qpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725542; x=1759330342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cxhDKz8i9kmQ5E8KskYbKTpFgqB3WcdocCtTYqzRMs=;
        b=EHamifqERc+qo7ac6abRKb+DgIzJuc0D4pA1/u65Gxvf7Oe2xQeYPpeRDydOI07Tau
         Srh9nTM6NoqSW+ApznYnNghb/+FcP9nIu7ByXMsKFdsJNzmFTT6dO2T8jEFxFVg4TIDM
         pqeXLc11+Uo6IeNjAadew6m8/QcTv352hqrCWD6fkGNoj6558arLlvpIcNcjYjWfh1QN
         8+XESd/280FvqissHn+BOg/v+9SZ+Rjcq2ELOAvcMauzHTjCDkqlJIPzNQpzrcGHLjLz
         aSM9nG/LsknrneEjTOwCTJQVXJY59V1BQTNyFuZ+VKX6V2C26mw71iQdGMTsyu8ziTW6
         NJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXGWrUjkFTfUuZD9Y5OnI1NwaZrax3C2a/FDnK3TeoUXbbIBkpQBsKJcSdw+8XBlNOSI88=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0xapKsLwF0oRNGWJYkT5u4C2s8omABp6w8ujcDw2D0LE615h
	mcdw2koqbMP6CAHrCEH2rDmOG2IZcH2r52//7Ctcm8ixH9N5JFtINQ/rf2JuH9VY6dL31V4xw0A
	0bNDnPHtSsCUbz7r8iNCAwtm21Q/vvOs=
X-Gm-Gg: ASbGncvtFZSUqrLwHYW2/4Pe+Dwyw4JAdWj0ZrwKNNou0H1K4kPnSWpvfI6fUmRqU/I
	IWE5Ij1d26XMl8E1IL1mHzRMG3nOmsuEtUV6aorSfUx038bNPUIrbolObZ106Q/5dKj+It4FBsM
	0paKOZd0gdDOg+9rpi1UCs9Wy/6I2CCVeNTn/jnwIc6UgNG322SilEbZU/u4MMKGpfD4tNI32os
	JjNUHfl
X-Google-Smtp-Source: AGHT+IHkRCqHPsrMbUzHSFi7MW39xZBu8t61XnEV/SPANYJUY+Vy4/CkCEjCGCOV6uQWJ7hQH6uRBrsXwXOIFUvamak=
X-Received: by 2002:a2e:a589:0:b0:336:72e1:7f45 with SMTP id
 38308e7fff4ca-36d170f7334mr17486651fa.24.1758725541574; Wed, 24 Sep 2025
 07:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <1d550cf308a189721ba089443f29678ead0344e5.1758662670.git.gitgitgadget@gmail.com>
 <3d03290e-bfad-41de-9735-91b126ae9e57@gmail.com>
In-Reply-To: <3d03290e-bfad-41de-9735-91b126ae9e57@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 24 Sep 2025 08:52:10 -0600
X-Gm-Features: AS18NWAWcrUiSXPkGS9x2I2leRwWV5GtBL8YCHOtqXJ_-4oonLJoeEjl4K1U_eQ
Message-ID: <CAH=ZcbBtL5xVKhHGKeb2PkCjNE4dDEO_jc0XsxwR2-jnX-f8JA@mail.gmail.com>
Subject: Re: [PATCH v5 05/13] xdiff: delete superfluous local variables that
 alias fields in xrecord_t
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:21=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > Use the type xrecord_t as the local variable for the functions in the
> > file xdiff/xemit.c.
>
> This explains what the change is but not why it is being made. Commit
> messages in this project are expected to explain the reason for the
> change so that future readers can understand why a change was made.

"Use the type xrecord_t as the local variable for the functions in the
file xdiff/xemit.c. This helps tools like ctags or modern IDE's more
accurately follow the usage of xrecord_t."

Is this commit message good enough?
