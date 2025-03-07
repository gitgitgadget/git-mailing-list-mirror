Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F112AF1E
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310143; cv=none; b=bav1M4X34DXaPuD09ctH2GHfBbciXZzFYXs83tA8++5VhHLpNPZJepOvGohpLbrBEQIHHw9/s12WoG3rRY5ogOWlQdX9FSYIEUVhLxrJaJO/QfmwDDmDY+Bqmky2dIPmZgiaYXzMLG9DmHOjIHu1da8bqYtv7fs907c4zc2VYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310143; c=relaxed/simple;
	bh=7bbuZIa40DxUwCl9ySMS1k/TEJkkmlJ/6xKjlNW+1YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CL6PGsX7o/XWqvKHvgnAALITm/EltTxCexr+Z36k8NV9d6rZYTL59/q3+cwT+Fu0YqqUBd/1NK8vfcxMIhieX3APmBznP2ghX9UwBZbfEWTexYXq4hl3iMkWkBy1Qc6oama15LATdZOTENLUy+8IdBc13q095zixedDPnlapUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFO8wSuD; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFO8wSuD"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86d2fba8647so1153054241.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 17:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741310140; x=1741914940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bbuZIa40DxUwCl9ySMS1k/TEJkkmlJ/6xKjlNW+1YU=;
        b=UFO8wSuD+2yF69yeiEBXAxoshvlt0hBEM8xPAZuO0uVu8Mw96ZPDRi+q81AJNiyMpC
         uyhDExX6nEWPkq66kyjwoYLOrmS97l01ZmsZKL3qg4utWwRepHPXyyL3oxAXDkcyVSGx
         EC5n8b7ZQpFxpa/lGnfHk4TKEFJmW/Zcr9bw2jkp988M7L1e5DDIVL9kvL7/soSHv8bg
         ZmDHJaUzNtoKTe6Iby8/nfKbRq6D5iEbJjtPrLZHGaz8g8pX7Zblvk2vXnD7AyhoJWyX
         1PVNomMMNrVWkG+H+1yNjKpdh2ucxcKATN4IkLYj5qX/eAl0JxEhOpjgm/XXjvZG9eKz
         gazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741310140; x=1741914940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bbuZIa40DxUwCl9ySMS1k/TEJkkmlJ/6xKjlNW+1YU=;
        b=Ar8PDObnTvDf15HUjpJ0RnphrLdW5qlSjNmXn67FQEU1fTMcXeOE9Y9MKr5ayBbMCM
         VQ166y5xKDyBubbc1ur2TKDCKSDV5kSe1J2VXGlP61IeBuBfmiaGvqhpVlIH0Nx0FCZ2
         QYWT33HnQbVfaspAb/yLzBxiL3TA7FE/FVXW5yy9Z8cQCg+14Gdvha32b9tpflNfYBH9
         /Aaroa/KB7kF4SCZMUj5hbl6JymBgQ6VONnj81FTLN9nx3Pif9Yo1R1oEMuDtSpaUqX2
         TvUPvAPhX05m6Z6KRu4wpeBpjUh9TQNe3vxRSJrxCH3HptOBtXK3zF1A4118Ybhzublw
         pEBw==
X-Gm-Message-State: AOJu0Yw+Wxq8PyZvZzvUWJJVyoUMyWSY9bSuXNSpcDECqyLKWGoZxfPf
	VqQlBwoPZUKF0bE8pXuqzEO9T8xyCBGK/CKFq8mkQF3g365cGvCOvsj1D7Fm+uybTaaQz/TzRA3
	H6EY1EQi/0U/4WuiZODCNixqrFb6fO1G6fKY=
X-Gm-Gg: ASbGncsxYWzwG+w+xcF255OGJ8ecZVuWK+zvdHFhVdWrNeOSxxEBOxwoyYuElEqdygV
	0viAp0kz3ISv4fSpdgvaDyOxuAiIdVDD8eiYb1OiC1eiauggacvKl/eqK+wja7GRJArmfrNIfeX
	XcWDu23kW74OulU79UlPOo39qhWA==
X-Google-Smtp-Source: AGHT+IEM+HCjysmdqjstGH+wz3nxLOKce9eoGFLzmxtt0XmNWpe6lgWY0Ty5xLuT8BYLMDy58FzKdWGVyTR7ntPD9Zc=
X-Received: by 2002:a05:6102:3054:b0:4bb:e14a:9451 with SMTP id
 ada2fe7eead31-4c30a6ab886mr999833137.20.1741310140601; Thu, 06 Mar 2025
 17:15:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com> <20250306143629.1267358-9-usmanakinyemi202@gmail.com>
 <xmqqzfhyggzb.fsf@gitster.g>
In-Reply-To: <xmqqzfhyggzb.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 7 Mar 2025 06:45:29 +0530
X-Gm-Features: AQ5f1JqQ53yyzZPSdAUuT68JuUzRZmV19Wv5HslM2eddvTmroxTMRCkslqxU1Cg
Message-ID: <CAPSxiM_fLNUvg86TtCHZTbsE_VnhKdMiDa3pfLPsLa3ThZfxmw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] builtin/checkout-index: stop using `the_repository`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, johncai86@gmail.com, 
	me@ttaylorr.com, ps@pks.im, shejialuo@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > Remove the_repository global variable in favor of the repository
> > argument that gets passed in "builtin/checkout-index.c".
> >
> > When `-h` is passed to the command outside a Git repository, the
> > `run_builtin()` will call the `cmd_checkout_index()` function with `rep=
o`
> > set to NULL and then early in the function, `show_usage_with_options_if=
_asked()`
> > call will give the options help and exit.
> >
> > Pass the repository available in the calling context to both `checkout_=
all()`
> > and `checkout_file()` to remove their dependency on the global
> > `the_repository` variable.
>
> Hmph, if we are passing anything down to these code paths, I would
> have expected that it would be an instance of "struct index_state".
>
> Do these two helper functions need anything other than that from the
> repository instance?
No, they do not. They could possibly do in the future and is there any
reason why we might want to pass the "struct index_state" instead of
the whole "struct repository" ?



>
> Other than that, I think this step does look great.
>
> Will queue.
>
> Thanks.
