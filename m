Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B98C1E9B37
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755941357; cv=none; b=pBS8cGLEEv5LXj4BVZs5+pULzZPKZLCQwR9SyiCoZAC8GeuM92eVD9IS2nMQwlWqJiAMjN7y6/LVW8NGAz2saEgV4dDaBrzMai4xgpluTXmdSdVSzyw21P3Hv0G7UxU8vCDpJzijneppd/ovyzpNYz1S45GJW+mDSFbmdZwxayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755941357; c=relaxed/simple;
	bh=B7RPbEE1ZQYXyblG0NjgXRaOYP3BdT5PQSywilnkm38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSGPBMMCQ9kayIt+G3Hi2uksQru5Kh/s7cPe8hE4VLO+9kLRiA9b12UqMk2w+EhoQRjJTSkWRmgD+xz9AwTFiMDfdWd8hLviS7/cVeBdaXuGORylJlVfNylcSYnze468lypaxL+2PtODquW7s0k1TM3Kq/J+uMLQ/T9+o7fx0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guXUT8pQ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guXUT8pQ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3354b208871so21292301fa.1
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755941354; x=1756546154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sExYj1Zu9HEkx5CrTNigciGyoVqO8L8xBO0IT2YYGEM=;
        b=guXUT8pQoWac1jxdCrvngzklZdhdXNy3BhNQLIIJNgTfbeqZyCQxMbFH9UI+hdyR68
         w4CsxP28kIHPH/dfSkqGhHS0i2Et0GADLp3cjFadMftrngKqhc/y2ksTR0xh6dkQ8SEJ
         /oedxKArj/nkMBfGygeIElqU6/5PE4RIAe/0MHyoDjJa3J5UUtRF7y6E39dIORRpgZXs
         AK1ZQ3dKSzE4Es0MQYOQ24+TEqHIJwwQxkRMtDSSQIIpfolueOwdiX0hXDXRolmLGXsu
         T77nvQpTsm3i9oGGZN9vX6/AWw00nC3FvREV+U3JSYiWKtA2Doxh5HDJ5Gk9/arJuJV2
         Sokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755941354; x=1756546154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sExYj1Zu9HEkx5CrTNigciGyoVqO8L8xBO0IT2YYGEM=;
        b=gt24ez8qaewyoa+VDGwBejsIpHuNwryLyOSc/qXD2aycVXJtgYKCUbfRZA3wXbpqg7
         ZUkkruPZh1CtFa/KTDPK5EZDbgfs2+Fk3eT4sZfKJ21brFXqRsFQ3FcLjjq9p2HBHtn2
         DjD8Abq8zE5tLcA/9up9KhOmnx2aHa8x1AZ+TfsO4m+QO/iJoiVh9FeJE696F/RVUIzx
         089fpZ71NLOOm0ChbhUmeZbwakDlfv3eCuedDxtw4w/9N5AlxMdGuDtQ2iu5QPoIQSFk
         FVTqnBJ++nZe5lc3PPjDdAujqrBqOTb7bWhCs4QovpzaCXGPIAKSCRZ9aA/ZWdN6Jhf0
         2/nA==
X-Forwarded-Encrypted: i=1; AJvYcCUqKKwYsGU61Gf3JT9IYImjO2cBYElfZOnb8enL0XUREdeaOPiq9zw8Oc/xblZTimibJr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhB4w69p/viGEuxflbFgyRkKEdUo818tPFGxf23w9T6WevPhe
	8Bd2r9OFNqJepUWBcTcnwYtZoI0dPEMfP9nmMoPwkTYGxRCW/y9CeMCHX1S41qgt4lFU9H5Al+r
	XT1JQ2bfz/1wJ4SIHqs3cUU8cajYRc78=
X-Gm-Gg: ASbGncsmv/PhAGAYvfJ9XSC2IlN2F0R62MgNF03uj2uuugx9V/Plarm9R3vnF9Z69Oy
	0g4tUy7EgwsgJqux+PTHD/d8ziBKnC+HbZqZok/NUoESVUH2AYPOagfXAflJ/38eES0e1IkhdIP
	hnVQ/ZEfGx3jeEfbThclDuDccx5V+oZBmRAmsIRePosWmiYZV4Kkd1fiv9QdR0yNojKrqWTdjyA
	xksSBku
X-Google-Smtp-Source: AGHT+IFCVUoohjKzJOEq8i16jzARrNz2WaFS2KTEHy0Rb9R8NkthSCieIl+Me/TKV285SVFBCQMyj56OE0O5rLHEX80=
X-Received: by 2002:a05:651c:23c8:20b0:336:51d4:16ba with SMTP id
 38308e7fff4ca-33651d41c26mr11069761fa.40.1755941354203; Sat, 23 Aug 2025
 02:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
 <ed31658a-9241-4d75-a086-633448b711a4@app.fastmail.com>
In-Reply-To: <ed31658a-9241-4d75-a086-633448b711a4@app.fastmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 23 Aug 2025 03:29:03 -0600
X-Gm-Features: Ac12FXzTBFWt3mLqa33QA9FTQNyv88-dW25qmwwrP1_MxJVZlONddGfGBzidxoM
Message-ID: <CAH=ZcbBCg8837kN9LjvdRtgVWL9vP=EDYw04wEPZxO6NLscbGg@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is interoperable
 between C and Rust
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 2:13=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sat, Aug 23, 2025, at 05:55, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > Trying to use Rust's Vec in C, or git's ALLOC_GROW() macros (via
> > wrapper functions) in Rust is painful because:
>
> nit: s/git's/Git's/
>
> > [snip]
> > diff --git a/rust/interop/src/ivec.rs b/rust/interop/src/ivec.rs
> > [snip]
> > +        // assert_eq!(vec.capacity, vec.slice.len());
>
> Why are there three commented-out assertions? (all capacity/length)
>
> > +        assert_eq!(expected, vec.length);
> > +        assert!(vec.capacity >=3D expected);
> > +        for i in 0..vec.length {
> > +            assert_eq!(default_value, vec[i]);
> > +        }
> > [snip]
>
> --
> Kristoffer Haugsbakk

Good catch, I should have removed those commented out lines. Looking
back through the code I also missed calling std::ptr::drop_in_place()
if the IVec shrinks. I'll apply those changes in the next version.
