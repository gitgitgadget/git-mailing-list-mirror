Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF5522F
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744581148; cv=none; b=c+IfF72o9F8kpmzCZZWvFOt8oNa/ZkF+91yazIf4tkYs8gmIkvhB90GPAuKF72xZIg8R3y5ZU1F9TWhD+J5t3FQAc6lERiganZg62EzOF75TPrxel5AGLNgx5l1/+IVGPStjEZqkSUPhEadOZjNVBpY3sfI7YJV5xkHuR9i8kkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744581148; c=relaxed/simple;
	bh=GmR2iNmF4nVkrlTaVijhGzrO4Xtr6zdG8z+6v3IqQC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7hVaDjHVqiNudq+Yuir7yox7y0JmiUovfOGtMD6LGH2A7k+4XPy6T734EEYiYnDqQQXO4VsZ7/468XFI8kPi42E8EWKwBO2eb/4q+TkGG8LBmwGIl5Ud+F+fzBvYK0KPL5S+XUm1EixfkgWWYZmR5nwE8zxYCqj6LAVdAc3ApA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi5T/4U0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi5T/4U0"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso6809707a12.2
        for <git@vger.kernel.org>; Sun, 13 Apr 2025 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744581145; x=1745185945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmR2iNmF4nVkrlTaVijhGzrO4Xtr6zdG8z+6v3IqQC8=;
        b=bi5T/4U0mJe0peRiPhStiH+fXvJr4LOPuDS+G8rVcJ/VolLyyeEb9W7LOisaJuqdMC
         Iqgt7XwIbsNOkaM/Py7+3OgzAK+mglA5TfrB6+8QXaYP56fMY+0kcxagibP/xFUHPymW
         STEu/bDMG/kxJXnNwbbvj4oQHKBmk349jdv1vkZfwxUDJQIwH8mi1HsweeAJ+VNp0i+0
         YtsVLW/o8rRCaDGPFv3U+3PtsuzY0xhLkGV7fDI1eCS3cD+iiojWwZr0neGwlhn9L2ds
         +aKBSPjIJVxFLEusk3I/HFCOJ3XpRrCAfiV/25bNfjNww+RjrA0ukws0GB11giylTceh
         1kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744581145; x=1745185945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmR2iNmF4nVkrlTaVijhGzrO4Xtr6zdG8z+6v3IqQC8=;
        b=wAQfR6nvUBaiKt3QNz4lvlhKsPP6ePCopP9k1rkXS0TktGxcUdUIlsQRFzqr3jnEGu
         JFjVsNj0bUFx7oRhQvlKfgzZxmCVEi2RczMBVeKhaQ0A0Eg0RounieRNc2NNDzVEpT5d
         k8Kt277MlRbN3ZZk/OKK2mhNcpwHJa0hRs1W3iWqilFT4qPzTA4P7tp88xgBd/LfXrKD
         i/HVpA9oULupTDSE/1ny1qBxR57AODJ0UNqkXNjlfG6Bb9f9ekOrTK26ThC1puzpaLgo
         kjwkfMMIGtvkhOHGPdalWp0XZyHfK1ZdS3xA/dSwTQYtbE2Ld9ulBjbSA9mSG/ap5W/j
         MH8w==
X-Gm-Message-State: AOJu0Yz8/XB0V/B2VpeSQjR38edp56do6WFfngZKX2Q5Af7LJ2+E27Of
	yWUD/XAZ3TMVbMkn4CBOu8nSMBzlKyWdH7OlhkkgNqyj/ffvyhu8aAvYHa5Jwbo92zxbifBYHqN
	gebrI8ypwSc/p25bOnB5rIglf6Tc4hh8o
X-Gm-Gg: ASbGnctC8vGh2GtjxR9Q3y9+uX1s2tq3JZUlWAoIHxVW/OqDa+5pz0c5UCMqys0ewSE
	ghmaYZMh5XsDBas8lH9asiu5fpu8J6QEhpIqRrffOQ+Nq1EoPlARzT7yowKoarHdr9J0MDW8IQG
	G5Sat3DPsGacYSgL7hd8oBs7V59S3ZpEFuDj0lih8J1BsTfCggeivXiEvd
X-Google-Smtp-Source: AGHT+IHE0crQosTJzZmOOR3BNysxQyHeqTCRVSdE6XiNaGdQhsu7AzvRsjSLgBod0NWHpzRIXKUIUqWbzyz4pznZjMc=
X-Received: by 2002:a05:6402:270f:b0:5d9:82bc:ad06 with SMTP id
 4fb4d7f45d1cf-5f36f778101mr9322557a12.3.1744581145020; Sun, 13 Apr 2025
 14:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2afd91ca-13d8-4b40-aa8b-c1917f0882df@frank.fyi>
 <CALnO6CCUHE6-RcZkTBYT-CeXHnYPBPe1eGSogWd7=5tK5NyuxA@mail.gmail.com> <669a6a0f-bcfb-4596-a0c8-73c722a6ec10@frank.fyi>
In-Reply-To: <669a6a0f-bcfb-4596-a0c8-73c722a6ec10@frank.fyi>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 13 Apr 2025 17:52:14 -0400
X-Gm-Features: ATxdqUHybNvX1MThoOI2OUw0RQRj6o0GtdYEzmo-yIef4x3Z1tMr_GXnkpLeleg
Message-ID: <CALnO6CALCFLWSs9HBWX13V_BUZkoeZuVjHVnF4_e0OMy3LfEjw@mail.gmail.com>
Subject: Re: Way to "impersonate" remote or sync remotes without fetching everything?
To: Klaus Frank <vger.kernel.org@frank.fyi>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 3:02=E2=80=AFPM Klaus Frank <vger.kernel.org@frank.=
fyi> wrote:
>
> On 2025-04-11 20:43:24, D. Ben Knoble wrote:
> > Maybe I haven't totally understood your use-case, but what if the
> > authoritative source is your local repository, and then you push to
>
> There is no local repository, that's kinda the source of all of this.
> The sync script runs in a CI/CD. I'm kinda abusing CI/CD here to run
> a kind of cron job, in a separate repository that does the sync, maybe it
> is easier to just call it scheduled pipeline/action or just stateless
> cron job?
>
> Lets make a more quick example:
>
> gdm is being developed here: https://gitlab.gnome.org/GNOME/gdm
> so in order to make a PR I'll have to create a fork in that GitLab
> instance so now we're at 2 repositories. Then I want to have my own
> independent archive mirror in my own gitlab instance. Then I also
> want to mirror it onto gitlab.com and github.com just for the sake of
> this example. Now we're at 5 remotes.
>
> Now I'd like to have a script in CI/CD (that runs server side) to sync
> all of them. In example the gnome.org one could probably mostly be the
> autoritative source (except for the branches that contain my changes).

That all makes sense, except: why need the sync (cron) job? Treat a
local copy as authoritative for you and push to all your remotes. This
puts you in control at the cost of not happening automatically. (You
could conceivably have a local cron job that did this.)

--=20
D. Ben Knoble
