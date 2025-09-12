Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0F3009FF
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680827; cv=none; b=FXNy7y+e6EEt8+mFk3QH8pG85v/PovIqGj4kgIlFI17/SnFFgQgVD/X5IHPsDvxtxYCoR1W8Hqr6Dffe+NxDHS1ASuZdHUDUjlkTHHyyTTUopTqgsAnz4I/AiiJCC51j0eEGG5o7lyE27/ri5MFpVqivgWsiRC9Xui++8H4A2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680827; c=relaxed/simple;
	bh=wv/Hhuw5Q/BBtgPbWa+XjWeMNHYiBqyas8GhrIJG5iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgVq6a34Ze+pVicGP127IXVPv8/BKoagsUXdP+cBr58Ea9hmGlYbOK+cBT7uzePoUQL6Ry9+hupRWNSUGN4RmsvpI3Wj+pYMDdIpQw6nkPfz9IzGWyxMijsi5ZG64dohY7O0BsTTB9P16nvknAOqh6zxYVyW+JdZHTplgD4pWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq8OcAVF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq8OcAVF"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e96so727320a12.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680824; x=1758285624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZRtF3+0N9HidIsV5oUMsU5NcFaW6PWdFJtKBJgJmU4=;
        b=kq8OcAVFf6BHf57NNHclS5mIw+lMAOlKZSIDyxX0Qg8NMvimIzr881cZ3bGB8IcUMA
         JdthWG8obeBzi2/b1Q0GnHR2Z8yk3rbci2d06VQkogLcMqKFlAwLy4qW99XPv1qdjZBN
         nwpEcKNR0/FD34nGyr5Fvdh82DK0Gr1asMmFcE6n8Ofxpd4P6dDV3gDycsprHPcB8PXM
         /zQwvnTyNgdj2+p3+evGqXGxjVXI/dOQ6D4PvQG6H8FZh8cKmDvYHfnTEv6xjYpDgJ7K
         ui2zBTI3J+8sAIcHCT0jHGiBXE9ArSnDOe+vuYecinAeErxC8NHMKfXjeE8Dlgfgesb8
         zi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680824; x=1758285624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZRtF3+0N9HidIsV5oUMsU5NcFaW6PWdFJtKBJgJmU4=;
        b=e5B9qbDB3k8x3J6pw9prxA6vuFnLiXqGo4UIrZuMEbFA5liYmR2VvODZM9QUHIjuUT
         rg+3YZJwMfwcF6RyfgMzY8+dyECSZ9HFCoJ+W4V/1pnhUJOZXcgxdxWqM+1Q4V2ziMfJ
         7QKsfHvzDz5BYyoTE6T8rACaFv9cs/4nevzH7lkzTtpULW/FtNzXN8NNVOQAX7LxZIp+
         onyfikd0s5QMc8BVqCjXnGRlcOAGzmtTOnjC64RRdzUiR58jClueNp5966YVOD49a9Up
         NwHRPyIJDgyR3GDuMOKkSBtQGrsDbcIlVWLOStMK+WaGW8JhZowFX92IQaJl9nBwohEh
         GC4w==
X-Gm-Message-State: AOJu0YxmQVjSJIsWbEhBH6pv8WtmRY0yPO0UqpRiGAH9o17PKT1xXtuc
	sEEPI6jk/2FFWqU/dTa8QfKAxMsOOEuaWRGpn27dIJ0BvIdfHzcid6nBQWCHHP08Bfol3bBved6
	AS3HC1MOBVNXJ7wF/u+iU6bQg1+32Ii4=
X-Gm-Gg: ASbGnctPPILmZAt9UfzL/tdzUDSXmidmwy5HRhFb2+jAYq3Yvw98MY+AjMhSIlFShp4
	0C41WhAkx7Gd2Iqu5Fnss7OwxuVkpIu8WfTA6AxQOQMk/QvI5DLAEa0QAmG7FTyrDAEJJdDONgm
	XVfBf6yavrCAO9AVpVn44UuwNkjayzWPqa3KpHli4X6Av49sF/RTdYl380fmmlehoSoxL/R4C9L
	cOGg6Je8w==
X-Google-Smtp-Source: AGHT+IGIYa/bUXglWGf+093+pGfj9mgBh/rjOWJjQ4FvCM17FGI+96+JvKM8mNusPMi3c3sZfaeuQHQIYgDZmLcwep8=
X-Received: by 2002:a05:6402:13c5:b0:622:173c:63f4 with SMTP id
 4fb4d7f45d1cf-62ed851af9dmr2889835a12.35.1757680823662; Fri, 12 Sep 2025
 05:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-2-christian.couder@gmail.com> <aMJm57VmWb3h167z@pks.im>
In-Reply-To: <aMJm57VmWb3h167z@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Sep 2025 14:40:10 +0200
X-Gm-Features: AS18NWAraFg9ikV_IOk7Em_ccfk7xfrmahXBanT6qym80FwoLzksPeo5qXnAZPQ
Message-ID: <CAP8UFD33cdNg6qrsmOCbJbC1ZS_VY17UkdYfN_8YChAqrFpXcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpg-interface: refactor 'enum sign_mode' parsing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 8:06=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Sep 10, 2025 at 10:08:38AM +0200, Christian Couder wrote:

> > diff --git a/gpg-interface.h b/gpg-interface.h
> > index 60ddf8bbfa..44856cc55f 100644
> > --- a/gpg-interface.h
> > +++ b/gpg-interface.h
> > @@ -104,4 +104,19 @@ int check_signature(struct signature_check *sigc,
> >  void print_signature_buffer(const struct signature_check *sigc,
> >                           unsigned flags);
> >
> > +/* Modes for --signed-tags=3D<mode> and --signed-commits=3D<mode> opti=
ons */
>
> Nit: let's finish this sentence with a dot.

I have added a dot in the V2.

Thanks.
