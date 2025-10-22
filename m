Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFE27FB2B
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169889; cv=none; b=kYZ6uh18FWfBItSUyAF+cJxxEZivu1wskZB0NJfyIHmjSxTYKcqeWn/1mGRCWNXIF63V/NTVQEb8jlUeAEG9nfd6XnjyjrPrS77mFWlH9QNrtvmAQr0p8h6JIgsob+x1G8DWZ9nOPdheTKVoBG29C51qwB2JM48Rfj7eFCmKYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169889; c=relaxed/simple;
	bh=NnU6t/tmFg7vcY0YjC0L3ODu3Jg5htX8pG6Q0R3iKjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfxMS5GW3nRuFWci/hCgU86ursdVCOvmP3pOUX4rc+idNGL4MOxSo/ZjzvVNw2M24Uqh7mGJH8MtUS5uhr9vhierQ2cx049y/+eGBpgm7jztaxrVgHoofeI5pivAD+17gp+mz0+PkQY8rFm3Rjr3YyWg2wN5BjOz87QMlGban8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qfbx2rSo; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qfbx2rSo"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378cffe5e1aso1623011fa.2
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761169886; x=1761774686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwSH+vHsuq0uAdCTVs365QYOkCXFd88tZ4fTPHyAuJU=;
        b=Qfbx2rSoTz4CNnnYrRrKuWHSVhH4uUdlu6UwuG55gi3c8H47qhgnxA5au3/e0ocCbf
         x2vnn+MNY350iCNxyqL4rP2BnjpqOpoSaW7nVzj3ptAoCu85MmU3+/TKQ/Ql53lWB1i0
         UNc6qszgJr/gX32wuNsZKZjgl1/oDzflPAKkSFA20P/hMsz56W94gMSvRFC/2Z/lcu9R
         aM1ODbjuWLFL7wyTKPDNI3dndL2fWN9G9J5n+3BCXlugeZx5NCR/vVW49sdJw7JYKW6+
         2/aaZF6ILmKhYTHY+nqHGrZrji5Oy2lDygMrAnSBEildJHC37oXdcd+PJ+sseI/Hl41R
         XYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761169886; x=1761774686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwSH+vHsuq0uAdCTVs365QYOkCXFd88tZ4fTPHyAuJU=;
        b=jo5PrR8XQVijTupuzpcDNCOPi3VoATot4lb5KCt0kjoC9PtI/3sElIQPK8Su+By33C
         4/B5UdLxzKliHF6sr5GMOddtDZK2Oe0cnXi73ZvgWoBfoNEga8pOKtMlvGbOYtjeMmB7
         JE59aJqSnR4qaNi4VrAbrngPjWnDl/eVlx12rEcawn/v/WpUFBk3mb4KfEshg7p85VpP
         GViVJs+ijGscjhmdi7B+dalD9lRxnq+nCPt7fpEGPUYq53+IO4VVlqx5PsZJ7+OT2eCV
         dqJEZFae2lNQixBa/qr52BP0MP2slWaWgUNHZ96JYVIuj3IfdtK25YW1PWQahrOSE7Or
         nOHA==
X-Forwarded-Encrypted: i=1; AJvYcCWB0El4Wm2rvkfg3XrxiU8+prhu9WjDW+hPlZFjz23EGRF6WuzDuFicMTh+wZZuTZK2gpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZm6YNAQTJvV6O9M/QKilqCQ0TT4phkqsPFc7dQvwtsWG/w4p
	Rlb+qITPPcA3AMD3/nQaaoqoDTopZ+izHpLphx2WKOdmolFbj6UZdmPRWvL6ToIuNsd7eG0c6yE
	gOi4cF1Hj6LUVBbut6SHI7XWH9/6IPVE=
X-Gm-Gg: ASbGncujQnaQk0RNjFmyVcPq0xOdEHvPFy5NL7gLcAotS4+kBjClwEcijCDhnaRYDpR
	l9CHb+t3G4X+tVLo57bguOIjq/2PT4fua+Qmut8qjexf28DIuoqt8B25S+pJi/lhW7alkit9uwl
	fn2BRGtcDT1JotaA5pUscerROQPEnalSMrlna7QEirF8TShnwWZPz6GWcEnjMiOxl5o/nfPgQUy
	uSJH+4evrvXF0Aq/SaHCfV1737/Zbf7ibQ3LyWBaZOncBtNFTG8R4kttcYJZg==
X-Google-Smtp-Source: AGHT+IGxd+CK0M5NroRpi/bMaCkLO68KWSF6xusGU4Z3XSm17Ob6Au8ItWnig+yigno+UmHK7OO9P0cNoA3hee9LPNE=
X-Received: by 2002:a05:651c:1989:b0:365:a58c:3ca with SMTP id
 38308e7fff4ca-37797a8946fmr67928691fa.40.1761169885755; Wed, 22 Oct 2025
 14:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <1fa9a7d7d1c309f2f651da351ba7bc0b36272d91.1760563101.git.gitgitgadget@gmail.com>
 <9eafee4d-ea94-4382-ada0-58000d229d2e@gmail.com> <xmqqecqww4u7.fsf@gitster.g>
 <CAH=ZcbBmdWCBh9zH1Y1JxcnNS-E9AU6Q4rRXPhMOtDBmkxLd8g@mail.gmail.com> <xmqqqzuuwra4.fsf@gitster.g>
In-Reply-To: <xmqqqzuuwra4.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 22 Oct 2025 15:51:14 -0600
X-Gm-Features: AS18NWDFzfsYE76APC6Wx3OfnJ1yn4BfKJtYl7Ljng012hwy_EETWAkAcFHSpak
Message-ID: <CAH=ZcbDVBWcRzOmJM7OWvtap2F-84qJ0zcU+Z8u8yX4p7CWb=Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] xdiff: use ssize_t for dstart/dend, make them last in xdfile_t
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>
> > In my compat/rust_types.h file (which was dropped) I defined isize
> > using ptrdiff_t rather than ssize_t. Maybe that file should be revived
> > so that we don't have confusion in code reviews when structs are being
> > expressly converted for the purpose of Rust FFI? I'd really like to
> > bring that file back so that everyone has a clear reference for how C
> > types map to Rust, but no one seemed to like it except me. Maybe it
> > should be an adoc file rather than a header?
>
> I may be mistaken, but I thought that the latest agreement was to
> use conceptually the "same" type in each language, have each
> language call that type in its native way, and if needed convert at
> the FFI boundary.  So if we agree to use, for example, 64-bit signed
> integer type for counting things plus returning error conditions via
> negative values, maybe C-side can agree to use i64 for it, without
> having to worry about how that thing is called in Rust side.

Your understanding is correct. Would
Documentation/unambiguous_types.adoc be an appropriate place for this
documentation?

> I am not sure in what way <compat/rust_types.h> should be used, and
> perhaps a documentation file may be sufficient as you suggest, but
> in any case, I agree that it should be made clear to everybody what
> C-types are to be mapped to what Rust types and vice versa, and if
> some C-types have no corresponding Rust type in that mapping, or if
> some Rust types have no corresponding C-type, that type needs to be
> converted before they reach the FFI boundary.

Alright. I guess I'll drop the idea of compat/rust_types.h permanently.
