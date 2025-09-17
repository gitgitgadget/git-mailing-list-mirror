Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CA2FB99F
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130269; cv=none; b=iEPA02JfholRSJg33s/OQSS+zsaOap9FYIimFShv37pF5t/7HWkUfPBqo8sKKD4F4Zbkjm/UTRqaYG4/7dX6/JdtOFI5hVCXNSEcJVAOS5d8Zn6Iwh9vGacHD4E6PhIWcO5wCgJWj46/Pd2GBXR1ZLQEv8JvCqG5KlDlhxJcfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130269; c=relaxed/simple;
	bh=LHtO6xMCxa67YNO0Hrx+5hnDVyNr8g9xQj/nb0XhzYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFJthtC5sGRq8dEkC7XZmXIUc/GAX1OvdWw3PzHlP2+LipWAKMl1oLqPbqHeW7wwMdlG9PLIW8dWOzpAWzm1bUtjdr4Q5yOIaiCsWopwxBBEJirkKhz72Sr0esct/yjNYtTc4Xr9L4itXHY+SVQ0uQ40k9ge6rnOol6dSy6ZzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDYKvKz2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDYKvKz2"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-336d84b58edso123201fa.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758130266; x=1758735066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHtO6xMCxa67YNO0Hrx+5hnDVyNr8g9xQj/nb0XhzYo=;
        b=PDYKvKz2RHVEzbNnGLylsYVBSLS9ye+kXsJm4B01P2UpKYjBTEgPOHAbYJgXXN5dQn
         wuk3l8fADmKO3IxsFBfPty3URd5vaq3XqegvLVSJJJ0REp4ra7GPSJYG7ybsDOWef4Hw
         qd/Wlf/04yCwvo8IHAPNJVaortkjRqBPav54r/GioFFkYd+keDolcwibMe3KGb8b0y02
         s4JvpobSSe8A+PFjahFZEAQ/sCOoNoe2fMxVazORUXBTNUeCbAzQ8xd+L0gDo82Yzz7r
         26o8Q/ODCcPEOoB7lAjgYBPSCGuTOs4muIxxc3V7kYyxlaUbk6RNZI611w0KwgBb4dlA
         IdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758130266; x=1758735066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHtO6xMCxa67YNO0Hrx+5hnDVyNr8g9xQj/nb0XhzYo=;
        b=AlpSNUa6hAwkDH6F++HR0UY0XCW01xMRjF3QNTPl1Oo5t0UhOKdkof/gg6VGp+HHCW
         G48ABhX5zM36cl/5dUJajs86txmtYMDF2M0kDuGcPPxSlfU9smBRpd86ZaWAIRUtl6j+
         uaB8cKLFHe/yko09BvAkIJb5/v4esWhHnTglL27QgyFE4LyittHc4breJIOvJfWXsa/y
         WvgfhaS0ozxj6rVjggfKB5aBWH3ShQerMWadyAdW4cUQMG0wCbikj7R5CCG+0gdGgXPG
         7P0Kzl8TtGhiYHwm3/9Ldi5QQo7Lqf1+tH1Ia1X0BtsldXjeP1Gehg4XyLI81gZ5sSxI
         DAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqtb8SlUKL4bzI00/OPrGYQWOqbYQGcScKUWDbgv50jFKqD4V6mqmyJDKcimADIpQqIdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YVNZILjIUH6ZJAvN5Pwe1y2E85F7yH79ACA4fGHedPxm3t0/
	w/bY9Jq+3LFgNtPyIbYEOCJjLLUzk4bNEcGxa4SBgRHzqEumJx/XpIxR0548nME4IBIzC2IsKPS
	kX6iZTkGpuJznkUTyjBAiuCKrs/IZoDY=
X-Gm-Gg: ASbGnctaCjp/QpQe+6E1SeX33tmj0raTYrty6s/Ix+bH5TNiTFtNK8hX0btHGmyEdzp
	fCYgMxF+jsi1lPSWeQdMDIndu10p7KHadV0ENvUKfEfjSjnpWwEfFh7DJ27s8x2HiwbD2R3fGqU
	QUkdJ1i1gGQwwQJkbbEGbGYJ5MyAY6reOodyMvmWp7drQ3OUKwuRZ8nqQi8yuGlrvmyXVz4rAGc
	oYjRvCU
X-Google-Smtp-Source: AGHT+IHyvPFGYhj2XNTszdpvG58DDJuKYc7c4e6vd19/zgPCqevnlVeK9w/y7Da5d1eV4S9QS+An9bWNphDNhYBKEB4=
X-Received: by 2002:a2e:b891:0:b0:336:e357:882c with SMTP id
 38308e7fff4ca-35f65a8fdcemr10349751fa.40.1758130265336; Wed, 17 Sep 2025
 10:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <CAH=ZcbB0Qv=b-hdB2EVW-D-dob4NnzyWDYGEThYZm94S0V7OGg@mail.gmail.com>
 <aMk2mo5OHPNQi0PW@pks.im> <87plbpffk1.fsf@gentoo.org>
In-Reply-To: <87plbpffk1.fsf@gentoo.org>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 17 Sep 2025 11:30:53 -0600
X-Gm-Features: AS18NWAaFwluiStzIiMt7jVd9ouVXGWxcdZPIt3TXl_fSTDHkfFaA7Cz8tOzSH0
Message-ID: <CAH=ZcbC51LbvubZuLQvajJqUJHARCjF5_ZBXWDS+DAcBvUMwfA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Introduce Rust and announce that it will become mandatory
To: Sam James <sam@gentoo.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
	Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Elijah Newren <newren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Taylor Blau <me@ttaylorr.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:07=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
> I think adding external crates especially will need discussion given the
> licencing and "offline" issues (which are solvable but they should be
> examined).

I agree. My opinion is that creating a new crate in Git should be its
own commit. Same with adding a dependency to an existing crate in Git.
Just because it'll be easy to add depdendencies doesn't mean we should
add them willy nilly. But making them easy to add encourages trying
out tools to see if it's a good idea or not.
