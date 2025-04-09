Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD37E1BF33F
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216368; cv=none; b=QPM5Uh1uTt5qWuX3ymBotQAbiL4b09rqGRO6L2fEHPkDj3y3YEFLQEiHivQN07c+b7+Ceict+f9pigljkqB6cOrTORR/2MK+Nhx1NG6h+UYnEy5ZzVgVGCOLUcmDhoxWtWFrQl16tls+RvcGFkv/0lAnawD/qCVaTrFblwfilzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216368; c=relaxed/simple;
	bh=O/WNaZCagVYDX1EEcE1Q7h2TTQTzDwhfXkG/BheckT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jD3NVBiV4AP6X0yrLOZl+sVFrLBgUCmOcr2pfy0y6onpG+ZUFbvXoOvGSUIgd8T96Lezim06v/fIgr2N6KUkmfJ0NT4f0bN+D6OeVtuYB4mYClQLFkDoFxhIDnw2+qtzgVxb5rUxStVNAItLEZ38/ui8hyYYkCEAMr59DMIzPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUloyMWH; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUloyMWH"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54addb5a139so7739927e87.0
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744216365; x=1744821165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22tHVXph9sYuhhUDZ8VtR+2MQsFYttpEjsvf7o7TZeg=;
        b=VUloyMWH3x1bv4dQBq0S+U75M0rBvlJLC6WAlcHc46uesxcLUInaKE81SauSLzBX7W
         A0TfGQnazmN141ncE38kroZMGhSdtzXgqwVAFdE5LVazbakPGmpMg68QAq9YG8EHXSri
         5kRCFyQSNmmmmuTiJr0qLEF1ci4QyguvrLNPaS6njDwohG0LO9iNHgnO5E/Il+fI6nng
         /8iHF6uErunWLqA6850RHHQpoj+obFAyTo+uffnTzPZfmioAHOzeCUSBj419ajk+y6mn
         N4El8ihUzzsMgekl42IT+zvfMIZ/XsrnSdmeMtc46H0S4hsdVZZtrZMXaBC97337ZjxL
         XODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744216365; x=1744821165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22tHVXph9sYuhhUDZ8VtR+2MQsFYttpEjsvf7o7TZeg=;
        b=xDa3OC57XSIp58Ln2x26CZbT9+SmfrqkgYsFo7nEKOwX/ujwHsHkN5RJl4PxwjOwng
         4e8vxxQixUeHgV+ZIxXiFJM3+RJ325qf8wPKuCyB3YTt9kqif9z+xw+dBAqyuXYp+9S2
         +sNVsJLvPyI1vWsPUZbikSvWs6LoCdp8bG6TZwTfNfGdw3wXl/0FNUCJZYr/EtrrSCXI
         9ylAbxEiejYgF3ZfQumeIo6GHVI2e3ljeACoQhOr7dDCfdLGPP7qi8TuuEbxj0hl8WNQ
         3ElaTFhRCDjTf4CyerbbkqxFCo29zMIVcYZUrp4CLFy4N0VR79k+YLl3WVVWzjn+9LVJ
         J7+A==
X-Gm-Message-State: AOJu0YyucdKJclOl5Fht9b3SO3nW11Gpa1bri8mNDi22iPZ/RiwkTHF6
	vQxGFzUETeHHn/SuZ71aHNxDCxPwv3/HP8jQ5KFNdeqbIs7Uz7YwqTT7n7zIHdBzDy+CmkR8UV8
	tmR1MOOtvfwskavC+bSquhIcm0QQ=
X-Gm-Gg: ASbGncsmRwRCBolbrF3BkQ/QtX1+aPcJylQPctOXBuUYYS8Mml293yVrBcXJ1nRAW2P
	CQNYBVXxnNylL2QGw3Fd5CEyrOsUy6QpHc4LI8AHEGlgqu3x+B6lGxfLRQ7v54Qjqsrdtwj2DTU
	BWnp2KHRbt00HUI1sSbW4iAnKzfpK+y60b3zFCvlbwiYMWasc4yyDsqqk=
X-Google-Smtp-Source: AGHT+IFdF18iLkYQMRQVJ9n5VClfJLQtc+JN+PgvyQLEK4tgRjAjYQbMdpF4E/lCrqC5Y9fN0Ah8gPXUStLuArUGKdw=
X-Received: by 2002:a05:6512:3e03:b0:54a:c514:76f0 with SMTP id
 2adb3069b0e04-54c444d90b4mr1086176e87.14.1744216364789; Wed, 09 Apr 2025
 09:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403144852.19153-1-sn03.general@gmail.com>
 <CAPig+cT1dQL+MfUctyw=9O5Wd2yUqA40pXSgsRHKfNf=6vxQ7w@mail.gmail.com> <CAPHxB8un1w-NBnfLne9d=vv9Sqa69eGoLhjOM0GcmhgkYKt-PA@mail.gmail.com>
In-Reply-To: <CAPHxB8un1w-NBnfLne9d=vv9Sqa69eGoLhjOM0GcmhgkYKt-PA@mail.gmail.com>
From: Subhaditya Nath <sn03.general@gmail.com>
Date: Wed, 9 Apr 2025 22:02:31 +0530
X-Gm-Features: ATxdqUF3ym8dZt7tEPPrYgnW821labG8Xa-QThHnekY6_J6eZPr6QcZEPKu3LYI
Message-ID: <CAPHxB8vGANCjXRFHmxJL_73u6Zv_DtAvtAc20CSdE6v=LOFtMA@mail.gmail.com>
Subject: Re: [PATCH] t7422: remove extraneous argument to printf
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am terribly sorry. It seems GMail auto-formats the email to a specific
line length, even when explicitly instructed to not do so. In my
previous email, it auto-formatted the printf statements.

Please ignore the formatting error.

Regrettably,
S.

On Wed, Apr 9, 2025 at 9:59=E2=80=AFPM Subhaditya Nath <sn03.general@gmail.=
com> wrote:
>
> On Thu, Apr 3, 2025 at 10:35=E2=80=AFPM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > [...] for the sake of consistency and to match the author's original
> > intent, it may make more sense to retain the argument to printf and
> > instead employ `%d`.
>
> I see.
>
> The problem is, there are multiple ways the printf statement could be
> written -
>
> 1)      printf "[submodule \"sm-$i\"]\npath =3D recursive-submodule-path-=
$i\n"
> 2)      printf "[submodule \"sm-$i\"]\npath =3D
> recursive-submodule-path-%d\n" "$i"
> 3)      printf "[submodule \"sm-%d\"]\npath =3D
> recursive-submodule-path-$i\n" "$i"
> 4)      printf "[submodule \"sm-%d\"]\npath =3D
> recursive-submodule-path-%d\n" "$i" "$i"
>
> Which one of these is to be used?
> I shall update the patch with the approach that is decided upon.
>
>
> Respectfully,
> S.
>
>
> P.S. Sorry for the delay in replying. I got caught up in something...
