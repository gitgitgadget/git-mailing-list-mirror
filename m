Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B124DCE6
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756498324; cv=none; b=AhQJeHENcIqDUtsnS6hURK87WalJ4MSauUSjlpWCaOiZN4vqmtUSicYvL/+t0R/Fej0z8zLEr7a/LAm8tPuR3hLH+1+m319gmpK2d5KxxKF634rRH6FzGOgJ3i4NMBo2BE6f/FxFzEBcvjCuUW+CCV3Z2tqjk/OYk1QnLNoLX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756498324; c=relaxed/simple;
	bh=uJQko6qCl5CQKgbeUfcES2v45XavCKcoJ06xcOiH/zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cXPbvyke+5YkNyd4nc9kMBI5F1GIi0d6/tgSZIkDlkWWr8cTnx5drxknViH10y4+MKYjFlrFz0xLdRl5wEA4Hv1/QzXdkb48RnX03ulA05P4YniWwew0T9kfN9wVu4QCiSVIQ9LjtQoTp1hdK4rStt7YezxocQt5ZintTb6bcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSB6LgaQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSB6LgaQ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336c26e676eso5153581fa.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756498319; x=1757103119; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWLnYs0C9zfJYloxKVeexn9JJUW8QLHAGzaRjKbJQFs=;
        b=JSB6LgaQJcC2QirBVo8nkzNR2DuyMLspuuqFFH0KF37od9AmL2NTAAlY8eRe+KE+LC
         v2L28uFWc7Y3dvnxOK/tYQgGHrxGOuA59ZTXiTxeb6mnui19KeP0zUTUwNlucqImDZXE
         3KjQFVNmhEAHjSfETWGlRAzmYqNtj1/dzeFBW4UsXZinZyiFcW+JMTyYDw66v52G5468
         A1fcufoliTuhXlqRypYfzIyd+CrHcgX2wI7/L9exiw5BHh3AklYCB6QA43Ndeho1uUNm
         f5YzLdrlX/eIfTwRqXHCV8/DHf2wVRClolG9xun7UrSsrQwXn/a+FxYMtdoDGrSafZDm
         dA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756498319; x=1757103119;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWLnYs0C9zfJYloxKVeexn9JJUW8QLHAGzaRjKbJQFs=;
        b=LrSDB07YPOYF5rrsdqv4w6x128yFS1EwyyRp9VprFTfI3udNLOKZxlj2v3HeF+eluu
         gH8i7Zs/+92QT4329nLZfTKZW7CxQ2BiKy5FXfw1xIRd65UUXZJ/pEL8fnRG34e0nA7j
         3dxuh62nqYQFOejAz1eJUcBh4JuSeXcOkjWXF4Cnxhy2U2xxzAbadyYmC9SD95Fqq2qO
         HRVSIi1ppaznU0rHTW6otETwZh+UxwF9lQo/F0JE1svcdoVGaH/EUko/yJnLY5bMeRfB
         Ip9PVN9TpgUknwjTiS9LFx/qGkE2nFGDLopSBB/BpxzmEWa3/CwNG1g3rpdaRnv1OszH
         IKKw==
X-Forwarded-Encrypted: i=1; AJvYcCUucG1ItkoVp/g6bJGtc9DdcsbGpOYdv6bsFQjEzsBS0k9COqokykrt3b9a/mcplTvOEkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kXtIj0KnezH0W9QzZFm54TcESyYGDMsj2zkkiSOqsCkjGBd5
	DHaI5NHnEI5h3wwojmvsnzm79upsF1O/RGGh2bsfsaIFOC0TDGlnKjKX9hSTtkxCKPEjEnStfHT
	gBBjDqKy3qO9SRsVc+3UesszVQbMq2Mw=
X-Gm-Gg: ASbGncs+fVsVEszv+TMmTeE7rrfkMHobBiLs+LaMZY5dchIliJ6HiEWFGwBFhmniuZI
	U9ecWUbq1uKj+tddPVub9wH1S4vVnqV/JOwORzL6sU7Exti5pIW6tSD3iYeDv6fW3cLdPHS26xL
	+1AbJVNzqwzQJt/c3LoZLfNbmP5nD+Ymy668CDJctZ7/MetZ4/2Oqs79LytYM+3QsctPaX3JQY9
	NltUeYqffHq61Vipqk=
X-Google-Smtp-Source: AGHT+IGpsCE424fiA3B07gphB1BYG2wl5sNCWmZ9o7wX+Tz/UudUCCkk1gO30/kljSBkjZCrCcqVVYi0SUevUVQBxcA=
X-Received: by 2002:a2e:bc1c:0:b0:336:8969:2ef8 with SMTP id
 38308e7fff4ca-336c80b216dmr936601fa.11.1756498318371; Fri, 29 Aug 2025
 13:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <6d065f550fe871cf010409f7bd2a63438cf52723.1756496539.git.gitgitgadget@gmail.com>
 <aLIG5bLOisbxfn1y@fruit.crustytoothpaste.net>
In-Reply-To: <aLIG5bLOisbxfn1y@fruit.crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 29 Aug 2025 14:11:46 -0600
X-Gm-Features: Ac12FXzq1OTwm073Uf703JkUTM_j7uE2lvO_fCxX2DA2MiycRvd8_c8dSwzzOtg
Message-ID: <CAH=ZcbBJV0oT1Ht6qVKmq7xG8ki9Enutq+VNes4n9+2r+0nrvA@mail.gmail.com>
Subject: Re: [PATCH 01/15] doc: add a policy for using Rust
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	"brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 2:00=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> > +Tools like bindgen and cbindgen create C-styled unsafe Rust code rathe=
r than
> > +idiomatic Rust; where possible, we prefer to switch to idiomatic Rust.=
  Any
> > +standard C library functions that are needed can be manually wrapped o=
n the
> > +Rust side.
>
> I agree that we want to use idiomatic Rust whenever possible.  However,
> I don't want to define structures and function definitions in both
> languages and rely on people keeping them in sync, since that's a great
> way to create brittle, broken code.  Very notably, I have seen these
> kinds of misalignments break only on big-endian architectures, which
> most of us do not use, so we can really end up causing problems that are
> very subtle this way.
>
> I would prefer we wrote these functions with cbindgen to avoid this.  If
> we define structures only in Rust and never ever use C structures, then
> we can avoid bindgen.

Could you create a patch with your preferred wording about bindgen and
cbindgen for me? I'd prefer to introduce bindgen/cbindgen in a
different patch series because this one is already doing a lot just to
make Rust exist in Git.
