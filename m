Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE922FFDFE
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141848; cv=none; b=nJJI/lMyc88uzjQMG6u5lAeBehWqy/jTXIOm2QtD1m9ICvUJlFhSY9tbqPfHgHeL6yWYdEGfnRZcEZ92BCrFi9RKH9LxlCidMm/0FhlHBcA0NBS9faoVJrjbb9QkaX7GUOsehnnbDaX1/yJcwLzeWD8WhDDht4G/EVMmu+Vk4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141848; c=relaxed/simple;
	bh=JiLtTPkbVFF0rljhpR9RXt8TX1EV6G0q9fJ7b5tsiTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX2obt8jDH73NzOmbLfnaRfn8Ok2buon82wXxyRML+ZR5bOD2MUZQjeiujUwC8XvcNk/STF8sViG/wWy4CahU41ohnR+2rnIJQ/K+S8Buo+f2Bpx15ZEoBNm9appkI4wYk8fJyzLAD/sbBoQ7g7PcTPW27ehOdOYC/+639IRgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEnclA7U; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEnclA7U"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3ee18913c0so1328084466b.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761141843; x=1761746643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJIyhs4UlbjQ9DUXUahVF2Ui6xuwj3hSnrpZ0mVugjY=;
        b=XEnclA7ULBOkR5WXTwOzQyhh2norKaVaekkPC9utlU1g5o8cqfKRjhX9pqO7kLptSH
         VEZhrvbuycU9dUzvHz461Di+NUrecchk6jiQHGzMxYJ/tSxR0/AJWGu0zF95T+kNyoBh
         d1Y6wdMf25VrqXsx3LCU64xk4H3Hu3OuxA0OH7htmQfJ0EeLW5zd2yot53G/yEnYWylo
         5gsf7Gwc/zR0xDI5sEcJS9IGrRdP1prnlIcpRlzNbgqPDP6dKDzWfv0WpqeIVK+OSTMB
         6kELiFTSQEnisCNOj/GD1lsCCVFAx8JXPXjcKCcw94wC6ZHGJ3a/e8fLKpIXvEbNIiWV
         ywPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141843; x=1761746643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJIyhs4UlbjQ9DUXUahVF2Ui6xuwj3hSnrpZ0mVugjY=;
        b=uMzr6QZBFX+nRx3oRCjlBnvJ+ZmAwCPWb8IDuUyYLz0tEaPyBBKgmIoWe5CVehzRYg
         +qxCIY60NFVSgfEFsDmXd09/g0kb8rebIavuKBETsNRD7pA/zsLGv8uTm15t9pLmZTm8
         EHvTtgz2Lvr61Cd3OhonpyZkEtuV/JAlqWXPXiMuoO5miJv5etfdEjMDqlVoh8eUmKb4
         Yzd0IfROHFfLTVP+BLSseQoMc+RRa76SqONfzi7hdin/8pxmDUK7Kiq8GrS0KyDUZ0pN
         2Yy5ajwnyydlqpEYT3Bmtn9d7ZLuFmVG62hAlR7tXPZKSo8+znhExcwpThGUrG21M0RZ
         3bRw==
X-Gm-Message-State: AOJu0YzOMdqLtB1S4/3Cjkn+/Dh+UpO5yK8qcBVpAl0n3tUKYB89Mb4N
	XKPrEQ5mKHoo8pLdur25lAHFQtZAVvWUpqWEv0HL/uhpkrQCmkLnvtRqBJo3bDhCDMD87WPc+1r
	/ptoRvZl4D27Sb7ZxuQUgnxQezGMYOEw=
X-Gm-Gg: ASbGncsT7jzqet7UQGiYCVfAvtHwcuvqDYy64K5JEg/KFUVbeoboYAgjbWaunoC4RHX
	WP5aOmQqJbrN15DFxNkr40Nedc1MT1XZy3MiDRkuJp+O0Rqu2nyJoAw1i5tfABujN39EnCD/vi/
	X02lc8U8hVXE0oeY05XqkHAlFUjw+OAOiD4s70bEhq+DQ70aQRH02Yh3DUFx74MYSiLDZKGKQk2
	FBgPfXAs1BBu8j1H/GbC9BtclUa6IMkgf7++Co2G89YFtw5P3MmKx5iujBXI8YNZBVu57g=
X-Google-Smtp-Source: AGHT+IEHh5cHJLRVqZ10Jukh3fKcAP+8Mi4ant+/VRim24jsWxhlpyWIJF5dZH5e46OwOGsF0QWOFRcHrldCAWLED+k=
X-Received: by 2002:a17:907:3f88:b0:b3d:5088:214e with SMTP id
 a640c23a62f3a-b647501277bmr2299545666b.64.1761141842231; Wed, 22 Oct 2025
 07:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761135129.git.belkid98@gmail.com> <5df667227b8b8951bad6c3cba54230ea8f6d3830.1761135129.git.belkid98@gmail.com>
In-Reply-To: <5df667227b8b8951bad6c3cba54230ea8f6d3830.1761135129.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 22 Oct 2025 16:03:50 +0200
X-Gm-Features: AS18NWBpW8yOHe6j4dk1JvDTXGQ6LdB3bVuMKNDTc2cN08KVWupg3pECO69D27o
Message-ID: <CAP8UFD3OTMi6uxv+z4rTqJ4wVpmezSG2Yj8tZMpgptWaWU343w@mail.gmail.com>
Subject: Re: [Outreachy PATCH v5 2/2] gpg-interface: do not use misdesigned strbuf_split*()
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 2:40=E2=80=AFPM Olamide Caleb Bello <belkid98@gmail=
.com> wrote:

[...]

> Simplify the process of retrieving and returning the desired line by
> using strchr() to isolate the line and xmemdupz() to return a copy of the
> line.
> This removes the roundabout way of splitting the string into strbufs, jus=
t
> to return the line.

Nit: here also I think it should be clear that these last two
sentences are in the same paragraph.

[...]

> @@ -887,19 +887,22 @@ static char *get_default_ssh_signing_key(void)
>                            &key_stderr, 0);
>
>         if (!ret) {
> -               keys =3D strbuf_split_max(&key_stdout, '\n', 2);
> -               if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_=
key)) {
> +               begin =3D key_stdout.buf;
> +               new_line =3D strchr(begin, '\n');
> +               end =3D new_line ? new_line : strchr(begin, '\0');
> +               first_line =3D xmemdupz(begin, end - begin);

That works but I wonder if something like the following is not a bit better=
:

               if (new_line)
                       first_line =3D xmemdupz(begin, new_line - begin);
               else
                       first_line =3D xstrdup(begin);

Thanks.
