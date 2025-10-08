Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098E2FB63A
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938663; cv=none; b=ntbkxofrRM5N1fjJRMGRLxKNT9Wm38s/SdntU7y7FOMjvS+1a4eerGD8uEyZpAMxNip9EOgEfi5QMMkNCxP7ZFYCOZcJyZf31pYnoWXXxCYA26KqR6+GDKf3CZutQWrM1JHg0rvwJ7oGZzwQ9wUbYWi8rc2ZECuZT1oaWLBxJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938663; c=relaxed/simple;
	bh=eobaAJ9cfz9c8HdEtn6kk6HX7KqIbKRz3zky8V77fZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5DzdS8S9A+zz9yMO8qdM4b8HZfTYxamHs+Pa9GSnE6ERVa5yWNN5RhfQQICXYROByYNopZGGb4+r+u4zrlxNg+PWdg4DbEtnl1yTOgoo/zgWSWIEvwm4wbgfHdsKQ5NFVoCk9+URLtG/lUgshHkb1c4arg3tT+n9OPYLl1kJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtlsIVgK; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtlsIVgK"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-583a520bd81so3606773137.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938660; x=1760543460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eobaAJ9cfz9c8HdEtn6kk6HX7KqIbKRz3zky8V77fZo=;
        b=LtlsIVgKaP20cgAaGHdm3YcVeUW8Dy/BKgeU3/S3TzfQoEa10yojd1nfbKfdEs18wQ
         +EMGjkJLTTJXiBPb5LTnSYUzOw+RvF6+39hFcDjNx7wqeBZypDavU/HBAyozQi25ks8k
         5rigW2LCXoWunqo6epcE+e/bfQ9z/dgdjxyVTyDv8oVNpuqbInu2AvlHQDHqaH4bAMZS
         5NM8GFZ+kMkTeGS3gdexlIkO9DJ3ks+GM33ULa8I4p5oIzqfoiXPIeWDr9U3BULYCzek
         K5xjKfWm4fztE262GURARZEQddau2KnJh3pxB9xbwTL26BhyYSxXoiR6Dzze9ivlKJta
         FyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938660; x=1760543460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eobaAJ9cfz9c8HdEtn6kk6HX7KqIbKRz3zky8V77fZo=;
        b=nc2fZHlSXA5OyIsVKZLhZHheZrSNS6WSG9LzeIqsqE8uIyUmgPDu4uPLnIluO1Ql/6
         KIX+qge45VFzgmwhezcKXt4nkudsrT2X2D25VIY82p1tASAAlcemW2SXr7kPvGvyeLP/
         xSUsAFn9cyBcsNogEv9szuJeeOZTfiR2ag6NTix1ATK9iVsOdpFrPJRybAtBU3jDoqNX
         Be/h0YsXEZpSpSznERZeTveZybE618NJaZb5HQGOB7/pRUJ5L99OnE/f07cep9XuvYhZ
         XkGijaVaGo+/fydpT8xyPFpK+3MHGjkMegG2z67CqZV+BOkP9uPEXs4nnawc7MKGr51M
         7heA==
X-Gm-Message-State: AOJu0YwxNf/tXKw+jJXHt+sCBGlKmwmv5xPOnnGnlHoZca0d6fmZVYi5
	0KBtdFl3ZQs1ECPU4/MsW0Zp/ulm+K3bfflWjCyQk0x+oF4OjZKoQjdnWQKkW/gKzVHJBPEuCxV
	u8CUMEMUSp412dqQbZydBddBL1T6N8tnYzCCVFWw=
X-Gm-Gg: ASbGnctwAiK1braqC0gzKbSA3Mpj0NwdfQg9bkvTfZvSgyYAsn2MFKQTzkCMzNRljLy
	24nIFQfvckyQ7Ntpjz0ofEXqV3MIWe4zXj6oMavd+0xw+8h1NFMGClr5BwsIOXKxH3zzZ3Ww3EO
	/DdKLKyckJwaE5x0aH/y/dJiGK0JIDVm7AtUhldt2tRqhWxNgDqdA3i0NAgqwCxle2fBJFw1DOV
	dYpj4+YnNms3yh5Ulx9aL0QgPn5Ej2MXaZi0Tb3F3b5ioVWqe2FWMhVC74x6QAYVYFWcFdbXg==
X-Google-Smtp-Source: AGHT+IHoEnQOV1bzMNr+aSnj6tp1XLeBs3O5PZqaM1ifRMuytxtI8Wsug4ya/jeEc74eHVCvyTuY3xqwFCPhGcGoZPI=
X-Received: by 2002:a05:6102:598e:b0:5d4:1e69:fda0 with SMTP id
 ada2fe7eead31-5d5e21fb69cmr1764912137.1.1759938660564; Wed, 08 Oct 2025
 08:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJXmEzSBzfXEarvjGzKhpvkcJr0yxucyw0DZ01ne-HfVxh7T7g@mail.gmail.com>
In-Reply-To: <CAJXmEzSBzfXEarvjGzKhpvkcJr0yxucyw0DZ01ne-HfVxh7T7g@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 8 Oct 2025 21:20:48 +0530
X-Gm-Features: AS18NWCD5wm5w5rbr_Wwwn4dDD1AucpVdm_cyJYojXNvUO91diHtuy1qXVfs9FA
Message-ID: <CAPSxiM-RXtyB=BYcvEm-FaJH_Cx=sFKjYD3oJg1gc2j52TthkA@mail.gmail.com>
Subject: Re: [Outreachy] - Introduction
To: Immaculate Atim <immaculateatim56@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hello Git Community,
Hello Atim,
>
> My name is Immaculate Atim and I=E2=80=99m an Outreachy applicant. I am s=
o
> interested in contributing to Git while working on the project,
> Refactor in order to reduce Git=E2=80=99s global state. I am still going
> through the project material provided on the outreachy website so I
> can get started to work on my micro-project. I will let you know my
> progress soon.
Good to hear you are interested in contributing to the Git community.
If you do face any problem, please let me know.

Thank you. Regards.
>
> Looking forward to collaborating with you all.
>
Usman.
