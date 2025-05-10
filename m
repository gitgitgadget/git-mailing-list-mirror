Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9A1428E7
	for <git@vger.kernel.org>; Sat, 10 May 2025 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746904957; cv=none; b=gwu+miYbqvvg7wsii2yl8yCZ2g7XVsAsBrPKnjunqCujSU6nb9tJsd6Jy4L//30C/qcFDxxdFLB9lgfwL+xcGMKZQitHUmP3x9m3a7bR5Kg+8ap/7LXYD9mpj7Hl4sVwoLFlKYTv2AAeFOXCd+aD1Efzdq7IDihD+t4G5r23FgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746904957; c=relaxed/simple;
	bh=L4+Ei3//OoXiIV+CeGLvw8YllfJqQYTlyrwuy9766Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfzEU7dGttcznSI9NkRBr9Y5WoWfMAzytmIpNwZ/CGLi6gviIHguLztRjXDP2i0bgGiLN0xeaUbqVuW40kvILdGY7Z0Q0fSEZp3t/NC1drg134+PNGwtD6pjinKNNdSDpJITEGnNiRM2O3HckJHzGvK6ch/Uk0M7tRvGZLzRyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh5cfmsI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh5cfmsI"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso637351066b.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746904953; x=1747509753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4+Ei3//OoXiIV+CeGLvw8YllfJqQYTlyrwuy9766Ts=;
        b=nh5cfmsIYLYccDYsRo3d94ouZIWtecdgzFZyGIUjD9lTR7Qvj3MDYEAOzpvIzbpEhN
         zEjFoI9WUMNED7s7Nky2R9vnBAsXOQms3V9CU+8jq5G3UKwEOXZD9QzJvl188h89kGCp
         7CWUs2hBtieeiCr/2ch6nmf6vNClj5YtjZdAu5fubmttrA/Iq0B0riMb0DBdGOTC7OGy
         Q0Jp+1U9eog0NX7VvgAgoIGziyE8bsIiiyzLGOkmYQflMXpMFjx1M51viQ9f10KyMSon
         FW2buYKrmGGN8JZjPrGL/R8h1+Iv0P5cRJcRwN7aveGOb1V2wWccSOXYpSRnT9O09RCh
         7i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746904953; x=1747509753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4+Ei3//OoXiIV+CeGLvw8YllfJqQYTlyrwuy9766Ts=;
        b=FwRlf+G4RNGPnn0TNYiKzjPI91FTonlTAQLRc9fvVc+5C327/ZixwUMU/jeVOhIGAt
         0UGc/D/mSEincOtuvyD9xxvMvfXUafLQcUCDmOy89qFzPKhKEaL13lo9wjJox3ugQXQk
         6SrYIaRytCC/v6kMp+GXeLV6dpAkYY5b2MsHNEJv6bNol9ZMamFskeNjbHuI1O0A5N2f
         NRBBJwe/R2XzJmG821oOMkPPEtO2/pktodxJdYCUw1e+sykon2GVo2qk/Jf+/OKPZYhk
         bLp+frgtNrtlZeI3sEKpJdx6Yp5vTDtFY8heDcZkMkIHBpuxOcmSqfR9HcNUvFw+WQ1R
         zfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNJfLuALFA8Ra1gXWJWBsXaj65hIr02f6o/VMfW9NHlmf26iuoIVsR3MboaPOZFYsgKGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pHbJCOb/QDskWnj2+dTdZDcRwTuCjblmKO2TOnkWNkffaEUc
	zmkuIY5LRYKeHs5+orzqZ3GB8KOj5FaFEYGhqVQdW4+BCMswIIpv7EfR76D1HSDgMw/YMLxBSY+
	YezOVdMUzOSlfmrOZQlmY4fBBUgU=
X-Gm-Gg: ASbGnctrdWIBP/MOMMWBJAIU1+KbKAW0Q6AzejmXM+HzeVtFI+ViJ9z6YsftKiBLuRN
	/DOt4dhCDx/9F7dd26UG2mSK8R2wNynZdTJcFL9rRVS3OZ/SqeF510MAZqaNkP88Q64e2+17ncR
	2XhoJt3rXM86sm8X/XlQZ6f6JKA2p2WlhmxiFAFzxPZhTFYz4rGufIB673PnPwx59oFQ==
X-Google-Smtp-Source: AGHT+IFx8z1khpnSg32gx/9vpzz0qjDLuEIhXiYoFirHmTCjVwLKCm4FAf0uxlfcv9FEN3ikmnsXxwDKvaotbboqZsw=
X-Received: by 2002:a17:907:6a13:b0:ace:8004:2a87 with SMTP id
 a640c23a62f3a-ad218f1e3d7mr788207866b.16.1746904953139; Sat, 10 May 2025
 12:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
 <CALnO6CB6aH5DEDP3QL43RCFfaZJ3uzrAY1LdGyTNi8F3XVoEhw@mail.gmail.com> <20250510081005.GA4318@tb-raspi4>
In-Reply-To: <20250510081005.GA4318@tb-raspi4>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 10 May 2025 15:22:22 -0400
X-Gm-Features: AX0GCFvslXtqgNaW_rEgGpi7DPhUrfZhBcUggR1QNrO3zHpqWWETwWbLfGd7Eo0
Message-ID: <CALnO6CCuTa24gJTPfp-1e1Y7=1wV=+rq9098xBoW0=ZkGcbgKA@mail.gmail.com>
Subject: Re: Bug report for pull --rebase
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: Mr Bill <billc56196@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 4:10=E2=80=AFAM Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>
> On Fri, May 09, 2025 at 12:41:47PM -0400, D. Ben Knoble wrote:
> > On Tue, May 6, 2025 at 5:44=E2=80=AFPM Mr Bill <billc56196@gmail.com> w=
rote:
> []
>
> > P.S. I was having trouble building master (something in the linker
> > with _false_but_the_compiler_does_not_know_it)? Revision 1ee85f0e21
> > (The twelfth batch, 2025-05-08). Log at
>
> This has been fixed the last days.
> The fix works under MacOs,
> do you think that you can test the patch, please ?
> <https://github.com/gitster/git/tree/tb/macos-false-but-the-compiler-does=
-not-know-it-fix>
>
> Or look into the seen branch.

Indeed; a recent (unrelated) build off of the tip of master worked
just fine. Thanks!

--=20
D. Ben Knoble
