Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147530F801
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351976; cv=none; b=t/pYziyy4FxDL70bvLHS7IiJ9Kfob874Nqt4bVtJZ00hZfo7Fghwb72cMdkTyK6fR3GDqsUxF+t+9npalQOyW3Ufg/6usaq26y5vUOUsdNFqmZIEfNQK4mHl6q39DNiXVcixCphXBjunDjAOEz5nXWUR+OAGkqM2ALoa6s+NCdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351976; c=relaxed/simple;
	bh=ACo1LEpCtyp7nShX0bNmxli+RfLa5XIMhHpAiyGwthM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcWkrBuHzQLxMjRjAGikV2EK2cbcU/wGpCypeceR/nh0gpqOIEIkPGNGo4RGu4bu+ub9wSE/FeNG9m39O8yronCKb857voFIWAFf+eI9OR6IeroQ5666V+13hIgbm0SjQaIYxuGf+g6+qMJwbYywGwdTgu1bfi5LaQrPnLDz0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgS2twFX; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgS2twFX"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336dc57f3f2so44283291fa.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757351972; x=1757956772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1omkyhVwOOv1p6HRg39a+rrLjqpBTwWRnyzjH/Xla4=;
        b=PgS2twFXerwbW6V3JzBja77j3McRUtR1X63XPAg5fCuBMU7OmWA+zNJpJcQjk3N/4/
         7LwF9tkuMLY+UDvME4knSYz5SClsb3xYpdk0+2QpCvKRaaPhURYXYSwNjtJ2jG+VbqpN
         GNDS842GtXjYaoFqxVDpHNa31UNdV9lwbfgM0y/2TPGbcuYI7OzxojnWAC4WCWI3mbXM
         D30W/WkPNB+rYRi6/rnh3sGu62HBlAs4vhZn1gQOIshbnPRwiDIlR0w8wnVmh8QpEdVx
         pbBfYHZmQU2pngaEtHQCerGN30R++ypEpI1xF2OCj5EbGRgM8nSB5eITnQjle/C2nFZv
         bc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757351972; x=1757956772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1omkyhVwOOv1p6HRg39a+rrLjqpBTwWRnyzjH/Xla4=;
        b=k1TxBmN/1HaKTRorpmZKV1aempImuRN+Rg0XeebwkRYWX3sxNlEkzeCaBVw4VVBm9d
         plMm/L9YuRZJ1H2jDbMYVXvPKfYaOE8fN3Hsp2BtBAaUCMLVqixhecAbeixIXk2JKqhX
         zNbkAl8++GPman3SSo58WZ/oHJcSGFb3y1J/waxyNSAN9iLLR+Qpe+oT0L53YKUAHezL
         y3/ZM82Dhq5pcy1AMSjwl3hF+KFZmsKVL6btJaeAv6JppgwUmjdiNJ1EvGjTe6Tmwk+j
         4sI/zX9JjHOT8JF+eIqYA6SjxXIPW5BxHi3S56g11hSlhLTyHveciSNODgoOE/j/o+Ep
         oN3g==
X-Gm-Message-State: AOJu0YxtlEeQXzbKRN9yvWtY8gTVgtT/e+pVZl7zTlm65PghDyo7OTrj
	DRaZdN++Eifipd3X9xTL0VT4AWEx7agKwwxuguxR31JIDexrFJgeCgxt8bK79NSsvDg/Tb/2ACD
	D9CzO4PQRA1vu/85dr6XWr87LWqo7QFw=
X-Gm-Gg: ASbGnct8tFoKJKbbR7N4/ZarY5A2OXK8RuAuubErFaTfs1+Ak64TfBMgQtIUOfBhgf8
	wdOHxvRCGNzYF1TOUz9Cdwux+9etTORyCyGK3q5ANWuctCRqD5fpB+jJVbyU8c2ofXrGFq8p+Ub
	OM7sEjJHhVeZCtWVtnyNkE9TXd+ivZFz5WP0i1r92HP7MqOtE4Rj9v+HxZ5/ydHt42ExAUl5W+D
	5VeJC/s
X-Google-Smtp-Source: AGHT+IFde9n4C6WruqdsbIfVoFT77srqGDbcDWkn6jTyQWD7Ve+ZOKTmYU8Ny+Hh0XiyqSUXOh5cKV4TZrxkYW97Z1U=
X-Received: by 2002:a05:651c:418c:b0:336:df0e:f4ac with SMTP id
 38308e7fff4ca-33b553ae818mr19201991fa.25.1757351972023; Mon, 08 Sep 2025
 10:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im> <20250908-b4-pks-rust-breaking-change-v3-5-1cd7189fed3b@pks.im>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-5-1cd7189fed3b@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 8 Sep 2025 11:19:20 -0600
X-Gm-Features: Ac12FXxRk-MvtwR-dJAm4aoKsOI2Lrf94oI1dIpbkv6PpEuDMdrsQOKxEIQDp8A
Message-ID: <CAH=ZcbA_8JM1hdUAfFe3ho0ShuniguEpV1308S0nCkCHOCsmmg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 5/8] rust: implement a test balloon via the
 "varint" subsystem
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> +use std::os::raw::c_int;
> +use std::os::raw::c_uchar;

I'd really rather avoid using C types in Rust, in favor of using Rust
types in C. I have written a commit that talks about why C should use
Rust primitive types and why Rust should avoid using C types, here:
https://lore.kernel.org/git/2a7d5b05c18d4a96f1905b7043d47c62d367cd2a.175727=
4320.git.gitgitgadget@gmail.com/.
In my opinion, the type c_void is the only appropriate C type that
should be used on the Rust side, and should be used sparingly.

The std::os::raw::c_* directly inherits the problems of core::ffi,
which changes over time and seems to make a best guess at the correct
definition for a given platform/target. This probably isn't a problem
for all platforms that Rust supports currently, but can anyone say
that Rust got it right for all C compilers of all platforms/targets?

To give an example: c_long is defined in [1,2]

// Rust version 1.63.0
mod c_long_definition {
    cfg_if! {
        if #[cfg(all(target_pointer_width =3D "64", not(windows)))] {
            pub type c_long =3D i64;
            pub type NonZero_c_long =3D crate::num::NonZeroI64;
            pub type c_ulong =3D u64;
            pub type NonZero_c_ulong =3D crate::num::NonZeroU64;
        } else {
            // The minimal size of `long` in the C standard is 32 bits
            pub type c_long =3D i32;
            pub type NonZero_c_long =3D crate::num::NonZeroI32;
            pub type c_ulong =3D u32;
            pub type NonZero_c_ulong =3D crate::num::NonZeroU32;
        }
    }
}

// Rust version 1.89.0
mod c_long_definition {
    crate::cfg_select! {
        any(
            all(target_pointer_width =3D "64", not(windows)),
            // wasm32 Linux ABI uses 64-bit long
            all(target_arch =3D "wasm32", target_os =3D "linux")
        ) =3D> {
            pub(super) type c_long =3D i64;
            pub(super) type c_ulong =3D u64;
        }
        _ =3D> {
            // The minimal size of `long` in the C standard is 32 bits
            pub(super) type c_long =3D i32;
            pub(super) type c_ulong =3D u32;
        }
    }
}

[1] c_long in 1.63.0
https://doc.rust-lang.org/1.63.0/src/core/ffi/mod.rs.html#175-189:
[2] c_long in 1.89.0
https://doc.rust-lang.org/1.89.0/src/core/ffi/primitives.rs.html#135-151:
