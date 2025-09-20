Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114113597A
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758394858; cv=none; b=s73iVwMu+5c4YdVYjfff/OHwXc8rkwUaqv3SOKDnV2/M4ate3uceVE9EUvRa9Ae7PF66bsM5BmqX6oLGIUGqhz5M2a4tT8mimJa8gdnFdE6wbyVdiOe+k7htYf4tOrmSomoC3BYLPiMpSXxjeiqrMzxuUaldj8iH+Ku4E6mfpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758394858; c=relaxed/simple;
	bh=FynP71LIB/Fb0UHD4VrYgbfQPoGvd56SVupEU7aJG5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atrovwjLVJuwf4MFbcDFv7QEYCqU0SrgD46D+u5OmikXWURf/xyBIQs3h5fEH0/7EomCKF63TR089TfvQHIQ63uOH3H3x0TmqWD5Fg3PuBUEwCKMJ47SEqhmqTjkQqXe4YBzsDUgjyIM4SmhH/uZjLUclcIldYlTF3eHeDvRriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwaDJCvI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwaDJCvI"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-579c95a2be2so2720025e87.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758394855; x=1758999655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FynP71LIB/Fb0UHD4VrYgbfQPoGvd56SVupEU7aJG5Y=;
        b=GwaDJCvIs7FbGbF6YAoCYqE87N9+mYigy/V0z7tqtGm7wzJHFgXLHXdfeu8iAnS82/
         3tnU/ozJ+/GoLOg+CLVfUz/1lbFmtS8qXM45CWO/bLLWSn2JtlKEl8P2iY3HNLbZ6Lku
         zDI4L7A3qIyAjUgehoSYMUnZtD7ut+TwerNKsoAxKiiig9CPTW49OXOUGv0mRYVXPy29
         +9+YLxMsCwIHyymsvjQB6j4PicqVwqAn5svZvUsSnfTJ6ibRWBQdGYlauYZUZ6ZuwcGH
         JK2gc6CzKhF3poiGmXc303HEOwE6PA3vGCWQH1SFyzQguG7QU5vn+Ezt6CLgwXG8IXoz
         TuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758394855; x=1758999655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FynP71LIB/Fb0UHD4VrYgbfQPoGvd56SVupEU7aJG5Y=;
        b=sb1TFomShgqyxOvLedxZPlMtMD49Kanjev/Zc7MAsGGXETMnrr+DkNnKc/5T644G5S
         rCNrZZBuRhPqad/qWyp1MRgy7FHGO4x3ifqu3DqlcTJHjPOI+RxG/F/mKiTevPhhFV4N
         XUlO77NERTX2w0rD+U9j7amQ2Ac0ucCBXluHWdiI3AyUiKRLtTxOoEUPXXO4ACkJSBuZ
         oO+mlSAMH8tcl6P8gsAFYH/iOE9uUhgcw2Uyd7FcDsVuJvI+nZKJVHxD2QX5CamkIS/S
         ++VyLfkUn+8pyO6wvmP+Zu1Bsb+2ldOnXhnSuKC/SO/IARlzbj4RCFX5c9p/Z0vfAYmH
         NWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEANcXKtnEIw0nv4dXaZRhizFtkqGgqtLxo8VVCp/gFTne/w3NtR2/CHZr2aUAWRPmHLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYGCVW5rk1Rdz5PaDdHooTbH5aQelagfAVJJHDackWf5sgO+yu
	39urgNqU0pk177ruNoPYKbX6HqO5i9gtNITcxgMSmMG5fZBf19iyyZgzQELo3wsMGXLpeBZICPx
	Sui1yw5eq4LFsuVHZPqKQ41DzHBWqTLYvrqf6W/k=
X-Gm-Gg: ASbGncu6gBW3O+PBd4mtIQTn5VMogvCHhuUK5fKoIQkLkD5Ca8X1XShlXFhOJSDxuxy
	T04aLVz6zQUBi46qv/i4jKs5fWWVCd/U2O1xjteBoT0d+RZFkFnRB8gPN9eQyuOR0g50aI5sXwp
	8K9xsE2AO13tELkBhpgGc3E+QT9q2l0mnVuFfNr8EGrLNKLjU24XFq4BHcZQhT5ODvS6tbHh2B+
	K2iWq+3
X-Google-Smtp-Source: AGHT+IFf17+JDPgY60W3q8C+4aQs5+XzB6ciFZeksVC3YZmVuNgvsOVMlF434SGR9kOL+ETHPD36xx0CjRur/WGkrDM=
X-Received: by 2002:a05:6512:440a:b0:57a:6d7d:dd7b with SMTP id
 2adb3069b0e04-57a6d7de10amr2031675e87.8.1758394854939; Sat, 20 Sep 2025
 12:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org> <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com>
In-Reply-To: <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 20 Sep 2025 13:00:43 -0600
X-Gm-Features: AS18NWDPDE_pa0-Fd42bI_BF1y98OYkbM9Vq_3Wg3TKkwrw6qjerNEAlCIjienU
Message-ID: <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
To: rsbecker@nexbridge.com
Cc: CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com, 
	20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im, 
	Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org, 
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org, 
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, newren@gmail.com, 
	phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com, ps@pks.im, 
	sam@gentoo.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 12:39=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> To clarify, gcc is not available on all platforms. The overlap where gcc =
is
> supported and Rust is support is likely high, but more, where gcc is not
> supported then it is highly unlikely that Rust is supported. mrustc is a
> difficult more that requires gcc even if that is not clearly stated - it
> does not build with c17, for example. This double requirement is making t=
he
> probability of being able to continue to support git even less for me on
> NonStop. My team is working hard to push Rust availability and we realize
> that gccrs is an easier path, but those two are currently outside of our
> control because of complexities in the loader on NonStop.

Is there a C compiler that works on NonStop and Linux? I ask because
I'm wondering if code from gccrs could help with augmenting that
compiler. From what I understand gccrs is written in C++17, but Rust's
native approach uses mrustc to bootstrap, and then the rest of the
Rust compiler is written in Rust. I don't have $500,000 to spare for
testing on real NonStop hardware, but if there was a C compiler that
worked on NonStop and Linux then there'd at least be the possibility
of people trying to make Rust work with it.
