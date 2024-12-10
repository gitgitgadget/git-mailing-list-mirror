Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C02D23ED41
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856733; cv=none; b=fbzMCo09toLOMZInEE4DuziNPstUBaqygPjQxrg6FzQ4pjXmklvjm+6VEPblZ1dQS4okKHHZJs2jD1t7oUvu2K3uQ0Esnap1ilASz9hStj3Zd/5PIT0jcoJNOI8x9l0N8W6TEwfzlsjVwUz4RrS1fZRcTHv6oiPNjp23CtXwP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856733; c=relaxed/simple;
	bh=ClHb8VXFKJr8BD2Z1A61uWcyS4V37Jg+gDVmdnI5qGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDmY3LZGHdeTm+GVxnsnjwWlQVS268CBBTXRnhHvAvb+szqB+WgYX9yFK9tvVUjnIsTiNmZhY3sU2V/9ZxdOkPyf11yUrzndlWeP/b340iq04Kg8+cM1wpPgAkysn+HV8emX6X6yftzw1cZpNvGZ9946Px9Jb4SjcL7UrkGPpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImrRpv6y; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImrRpv6y"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85ba8b1c7b9so3001068241.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856731; x=1734461531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClHb8VXFKJr8BD2Z1A61uWcyS4V37Jg+gDVmdnI5qGI=;
        b=ImrRpv6y9jc0GNYx7L6he2Sa2U7Fxziz9zP3Yc9eOspDzZy+CK647h99NJcjn+4b+U
         TpnQhEPRK9bEhrDFf2/LTf7tSZfs8UOmQYLwTDCEs+5Zsh/N8VADDQGPBtv9fPCsfKuB
         wvFO8gutlLCEHVO1/w2qhGjNGnzbJDJvBnRvDKzBQi8PoUDWCKFYVJle71zd7nrSz+j6
         ZExm88ZAW/FXP2HyGkkD7uK3ctLdzvCYgzuklMK4AVNh0YxNI9qa0Q9SMgBSxO3qplNn
         fkY32R0lre6eolgdHxoHVzWEN/N99mVVx0BhCZ8/aE+bSLqr8+yP1SvEcOh0/x0/xFlH
         N8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856731; x=1734461531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClHb8VXFKJr8BD2Z1A61uWcyS4V37Jg+gDVmdnI5qGI=;
        b=nRT/LcnmeAYoTir7iyujcdGSKSF0k0ULnQDt8YJFsJjZzsut9r0bdPergW+HfivIIx
         so0ugvAaljT+jMONdBcKh+ciyZujO4Rpo1gQ2GjbH1qV8WPeWMNXHvDZuGNWdSQ0OPpR
         YacgRg8VA86J3MIUAWHkHhEvzEDGLdZH1Te2qB57Mn91796GoaGVzufJFzPj9fcD0Wye
         MLiPS5a4aVsWKV5JckoEqTlpH0yY9vtH+aQrdeOgMvWosAkxVyIQyT0benIFh67W2Awn
         nyUvXUZvP6lfLdniFkbFgrEt+ZsMTtbGOL7FLhmfmlkOd+xvFIdaiBLfi2cu4KtGf+JZ
         nmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqkEakVtrgA0r4cK2172BzDIcpV/ZqQKCEmN6hmBD5Ubxsc+F/GPbAM6j9mX/5eXSUpIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4KImDvVh2BjgaCQuHzXBkMmMDjLKjZ2VTZPgH9I/1BaNCFZe
	YdcvQ2vIzU8I5wleZkLiFJliwpJsmlXK4ebiEAmq9w80CtpEkg5jFnb977ysddMVefSjcVROWZA
	wmD3AldHZzwWi3VMWOuSozmy1rFg=
X-Gm-Gg: ASbGncsa11SjWtnceSNa7jQ9HCnHqKuA4ofNcwhgyfzd70pb48LTyCRKj8a478DCkNT
	+FDQCboGl/w0hcWeix+CWz0z7VQ2bSbyitu0=
X-Google-Smtp-Source: AGHT+IHGQ3iCMw2k2wrAR+wlFcXG1VQ27C7BrIZJYmToUll0SkXIbBCvedH081C5UsuAzcnREMerIWyvBBF9L3LHawc=
X-Received: by 2002:a05:6102:162a:b0:4af:ed5a:b68d with SMTP id
 ada2fe7eead31-4b1196d9696mr3969502137.6.1733856731160; Tue, 10 Dec 2024
 10:52:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqfrt7y3xp.fsf@gitster.g> <20241209161445.10321-1-usmanakinyemi202@gmail.com>
 <00e201db4a58$3b198fb0$b14caf10$@nexbridge.com>
In-Reply-To: <00e201db4a58$3b198fb0$b14caf10$@nexbridge.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 11 Dec 2024 00:21:59 +0530
Message-ID: <CAPSxiM8hYPAuZhiTX06jmw7FRr0_6P5+4WjudM9Ad84Lid6gDA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Advertise OS version
To: rsbecker@nexbridge.com
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de, christian.couder@gmail.com, 
	git@vger.kernel.org, johncai86@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:04=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On December 9, 2024 11:15 AM, Usman Akinyemi wrote:
> >Thank you to everyone who participated in this discussion. I am Usman Ak=
inyemi,
> >one of the two selected Outreachy interns. I have been selected to work =
on the
> >project =E2=80=9CFinish adding an 'os-version'
> >capability to Git protocol v2,=E2=80=9D which involves implementing the =
features discussed in
> >this thread.
> >
> >You can find the full discussion about my proposal for this project
> >here: https://public-inbox.org/git/CAPSxiM_rvt-tkQjHYmYNv-
> >Wyr0=3DX4+123dt=3DvZKtc++PGRjQMQ@mail.gmail.com/
> >
> >In summary, this is an outline of my proposal and what I plan to impleme=
nt, which
> >has been influenced by the discussion in this thread:
> >
> >- Send only the OS name by default while allowing a knob (custom
> >configuration) to specify other information (e.g., version details) and =
disable
> >sending OS names and any other information entirely.
> >
> >After discussing with my mentor, @Christian, we think that adding this a=
s a new
> >capability (os-version) is a better option compared to appending it to t=
he user-
> >agent. This ensures that we do not disrupt people's scripts that collect=
 statistics
> >from the user-agent or perform other actions.
> >
> >Intentions of implementing this project:
> >- For statistical purposes.
> >- Most importantly, for security and debugging purposes. This will allow=
 servers to
> >instruct users to upgrade or perform specific debugging actions when nec=
essary.
> >
> >For example:-
> >A server seeing that a client is using an old Git version that has secur=
ity issues on
> >one platform, like MacOS, could check if the user is indeed running MacO=
S before
> >sending it a message to upgrade.
> >
> >Also a server seeing a client that could benefit from an upgrade, for ex=
ample for
> >performance reasons, could better customize the message it sends to the =
client to
> >nudge it to upgrade. If the client is on Windows for example the server =
could send it
> >a link to https://gitforwindows.org/ as part of the message.
> >
> >Please, if anyone has any suggestion or addition or concerns that might,=
 kindly add.
> >Thank you very much.
>
Hello Randall,

> Is this build-time or runtime? If run-time, please make sure the code is =
portable or provides
> hooks so that non-linux systems can contribute content.
>
Thanks for pointing this out.

Yeah, the aim is to have it at runtime and to have hooks that can be
used by non-linux systems.

Thank you.
Usman.
> Thanks,
> Randall
>
> --
> Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)
> NonStop(211288444200000000)
> -- In real life, I talk too much.
>
>
>
