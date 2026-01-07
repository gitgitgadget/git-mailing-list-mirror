Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D276026
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749715; cv=none; b=jWdyk9/YeLKrQVgYvxeboPGAc0wPYJqeJTe1l/CaqqbLCM1QMJtmu7aMvWcejCTr4yUJ2eYFtkOluAwOm+jmvAtyVccfb/z2oR0F8rzxnaQyD3A3qtAyS/nRTATXQEOU09P6SQVQ700p9GuMOBmqLOTvzjg85VgPGdGhsAt33u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749715; c=relaxed/simple;
	bh=BkD7SvkMTcTeddIFvREJ+NxPClXwPLqSgOTy06+41iA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d12eW9uZAlEVy0fp357itPNBrZ6q7Sf3jszL9a2y+KJIZeAPYmVHm1bdfvCheOaB7LpcA2tb3KRjLXrVnAOAE0kdkdA1bYAgiIRTclE1Gui4/Xm459E7s+yZt70A7h+xDiqsL42JQ/D/ixjHVPhDMSWMvKJO8MXG1/D6hceyLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0lJFWQM; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0lJFWQM"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so2176674eec.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 17:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767749713; x=1768354513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tws8GNZBpNxEi7qwUHZMJI4z7mYBaev3zVFE1he4K7s=;
        b=h0lJFWQMM7LgLpR0pZgChI31mkBfE7C+yhWgHN9MeGnZkkPRqeaTUJ+XxWhdyqah6h
         D+DLIKk/rm2RDVbfV9IHnCKSgpRKfEnRKvicMsJ6Bu5oXH9lhjr//l68/LeFGR/wiGCQ
         8qGHyjVcnNcXf5QYaRlE6bCazSnx9U3dY+N5iOJ4t9w9pPT7Ms4ag2bNd6fZojyaB23n
         9THxvTVwOjAORcDxbs79HhgATEnuzn1vS1qjbUH28BgKB4BXmNjs9+nIgIXu5YDpVxHj
         Wol0bCUIYeH11ZlDQw7ZdVgdcN51MKJ5yNktl4QLfOwxjapFjqPBoua8fRS5hgJHNY1r
         f/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767749713; x=1768354513;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tws8GNZBpNxEi7qwUHZMJI4z7mYBaev3zVFE1he4K7s=;
        b=w4bLdSX9FJceQlwApPuKRT1QZNNI9TUCJteiBQevXhJxTg21yPS2Hf2PGcyW1xHTzD
         jZvTcrbbEs6RDcAZhafwxwJtqe/k13d/+2Tu4PWWBe4TZEPrINqHg/uQsGTesq5U9iBV
         o7kPe4SUi66S12mErOl9Ej5q91zdVPoOMdaYr0H/j8D5FH1dioKPPS8LgRFV2w79zr7e
         c2SRSwTwU9GkSJmLw/lQY+mFSP1KNemQRdJWYCvhj14wF6cUCHCyiGsip5cuPH5W2X0i
         5Fu6RcNvuqALOM2/8YV8b8pNZtuIpv9mHCAzVY4xlBm5eFr5l0Bbz1Szh6gyPRJE01Eh
         MBrA==
X-Forwarded-Encrypted: i=1; AJvYcCWmRB3EByfx6Ch8SzAzd8ffX7Paon7GZEJdmoNNjemMuHiG7jA6YZwU0q3hqzlpWx9mMXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdhwglDX8Y7YzlrpCT2fRuG/UKHpz9IePd39312N5PK69V+4s
	3pjhr4vEA74lWpxRMJJXFsjsg+fTdG8dzZYB0KshSy+/RKa7Z2um0ZiK
X-Gm-Gg: AY/fxX6P+adu5W37rwiMdOGPxpPOQ4Tmu3iy+njyBecPQxhp2na02Uk9dlgGCvnlu4b
	lWIon6QCwXYSxdd0kg0aTuouiV96g14Q5DvQesCFzpgOuvT1+fJ34h2lc/ZDXEErTHKujO6R8Nc
	doumMJpGYkVa9gOTfl/PNG715NF7NuxTo6JrtlZBSBJZ7H5kPbD8c62rXKvYKvfp/h/cJPQHVQ0
	LCh31uWrWmIUAXUPfyMpIoML8aSmRyP1Mjh5aZsjnmYWOElXO0gbHhnlkxyCM3iYhmc4hGsiV0n
	mp7IiQMnuOY4dR0V7mYkC1hcqGkqfTuwCfryRvBwu+JGorBC+I2rSrubK9rqgPHedHAJtL/Ot04
	exrDWgQalFiNIU0/lFko3ZR6n/4ZXYgIAm7KbSWCWtz0NqlFNkdKmAd8768Gvd1duGn7a
X-Google-Smtp-Source: AGHT+IHRusFWD1MIaq+xkMnl2l4MLboZQho33VaFWht/qVO1iUTwqGNhDD1Nqs9/xIbCY7jOGiSZ4A==
X-Received: by 2002:a05:7300:d588:b0:2ae:5275:6901 with SMTP id 5a478bee46e88-2b17d31c042mr474715eec.34.1767749713257;
        Tue, 06 Jan 2026 17:35:13 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::361d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706c503csm6818918eec.15.2026.01.06.17.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:35:12 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>,  Matthieu
 Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Matheus Tavares <matheus.tavb@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
In-Reply-To: <aV2ZS1lvLivi8xRH@fruit.crustytoothpaste.net>
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
	<aVrCHr_NRDqNjPn0@fruit.crustytoothpaste.net>
	<CALH9GrYOjb92gjrtdjwapFH9L73XGg1Kan8uz1aVLpSXNURi+Q@mail.gmail.com>
	<aV2ZS1lvLivi8xRH@fruit.crustytoothpaste.net>
Date: Tue, 06 Jan 2026 17:35:11 -0800
Message-ID: <87secimchc.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Instead of trying to force Git to gracefully handle UTF-16 in its config
> files, my strong recommendation is to adjust your PowerShell scripts to
> use UTF-8 instead[0] or use a POSIX shell.  I'll note that Microsoft's
> new Edit text editor[1] defaults to UTF-8 (and, except on Windows, LF
> line endings), so I know that Microsoft understands that UTF-8 is the
> proper encoding to use on the Internet today.
>
> [1] Available at https://github.com/microsoft/edit and apparently
> shipped with Windows.  I will say that I was impressed at its
> functionality for a 231 KiB binary footprint.

Does it handle text that is not UTF-8 encoded?

An unfortunate trend that I have seen with Rust programs is that they
completely disregard the systems locale. E.g. using
LC_ALL=3Den_US.ISO-8859-1 and passing an "=C3=80" character as an option wi=
ll
typically fail since it is encoded as 0xC0 which is not a valid UTF-8
character.

I figured it was worth bringing up since Git may wany to think about it
some before introducing more Rust. I think it can be worked around by
using OsString [1], but I guess many people choose not to.

Collin

[1] https://doc.rust-lang.org/std/ffi/struct.OsString.html
