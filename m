Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1913F42A
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731225340; cv=none; b=V/l3QK52AJUrXP4U/PLGwE/HfUcWQ5hLLp1+FUYpEhQ31Bxf8K9ACL3fI2UyIEPvTYVyD/8itykjuWpty9u4uxDnHD4TEE95dqIxZyV7Mr9V+azaSoA4eXJrKDIZNJ4Alr7H7jyFNavEuP4qQSQOPEcj4fSDMqBCiLbWuJEkMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731225340; c=relaxed/simple;
	bh=TVpxazmJU+PNPhfw3rZFMSERg/pkChoAzLAw6vylhFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDYK2RNxOjSpcq6uGHeMrpD2se2Hl3lNSStiynXIvQPTvXuZBNMN/CPff79L0LZPvywB1XPxd6HdxzIVlhZJntfNCmLmI2i0LEgKRAgBtPkYcBjdY/WsaEpToNfopSeP5AGSLYagQ7ryp8hkdmvKBuPX8hFIDMbeUBFR3toOG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou5uxbRI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou5uxbRI"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so2587246a91.2
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731225337; x=1731830137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TVpxazmJU+PNPhfw3rZFMSERg/pkChoAzLAw6vylhFg=;
        b=Ou5uxbRIe67hrsdr+khuSDTFEvQ1k9hDtDrwTgqE5PQMiljOHjVv4yUcsgC5dsrQLT
         uoXfvFgR0990dwgymxgGgsn1jmGahc7saRNHVdxFlrIP17RYtkQ0XSXgC/cdoVLaB+3j
         AXUkEZZd6KtFGCJcQk2dXvh2mNSG9ehWdgAUBQL3heSDxTGR3LL/eSPdv1ofY/+TQ4uv
         59+bTMQbOxQCniRYNC3ww/TW8cyz2UVMEeabqGoCJx6nSHzi22oC7rxnM0fZv7npHJr5
         sWnWTXO4Uii7LIl6aII0bHITRoXbbhk6/wHlX81QLTEXMF7NxfFYsCZnDoNhwT5m0B9n
         Wm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731225337; x=1731830137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVpxazmJU+PNPhfw3rZFMSERg/pkChoAzLAw6vylhFg=;
        b=E6x+qGcKKj3ATW/xsHqcJVyRcc7OhLLG75HyTAy+J8dStHkxZe1SYXi7pG8VEP+8VT
         naU3Fre2LFTM0nAysLjvBakiVsUHcLFwlEc6pg+to8GOMsY8uHFcCr6mVNNTFaLrM+vM
         1uZ5Ks87Nof6o1cG4/HqXongN0rCtx5dvAe71KatBWV3BdRm/rt8veCmUX0r0NnNWQ2W
         pIALZ2YOm3kyRfHGqbKI9s6k9R5rdv4Bto72LnqlUDxWRJt+Lg2kbAe46prbwjrsDwRO
         PmuhRq4HLA2Gg6vORgEnaAW0PYerKOF/lwUqMMGjKntnqinMyvDmhTymJ+m5yB8fnR2r
         P+6A==
X-Forwarded-Encrypted: i=1; AJvYcCVyf57HOekHCJ8XN50UbZ/Osi5J2r7dGqbEAlEyP1V/DH3vjGePPOSn9VHqgo8UP8s8NrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWe8EUDmMKaMVocojOZbKgbcMYslViScvwJWKYvHujilkdIuE9
	HjhzZWt2yDb2mFg5PQrXVhht5Og5GijAtAjl9YIKVYc/buY5DUQfh7KkkbiGldpi0mjvI4xwREB
	Gm7mXJGJdWp1dogvag6Wt8XjvgiawO6j5
X-Google-Smtp-Source: AGHT+IEJKzSL2qZTSsrKs/RYvSoZBtGaVz6+zSlLLWMLuRw7ILQSboVo2i0cwLQZUinEfwXxhFk0B1C90Kr77t6Fn6k=
X-Received: by 2002:a17:90b:1d50:b0:2e1:ce7b:6069 with SMTP id
 98e67ed59e1d1-2e9b178ee2dmr12426375a91.33.1731225336855; Sat, 09 Nov 2024
 23:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
 <D5HQH12Y4SWF.2W70SKEDB7HBF@cepl.eu> <debabf92-7d23-4d17-bb0e-36691c94430a@app.fastmail.com>
 <D5HWL26B3HOT.1ZVXUC37BCGL@cepl.eu>
In-Reply-To: <D5HWL26B3HOT.1ZVXUC37BCGL@cepl.eu>
From: Martin Imre <martinimre25@gmail.com>
Date: Sun, 10 Nov 2024 08:55:25 +0100
Message-ID: <CABg7He0upi8kmagGO13UMwSWOLeHoryZQU5CGsfbhgqedBKw=Q@mail.gmail.com>
Subject: Re: Feature Request: Interactively pick fixup revision
To: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for pointing me towards https://github.com/keis/git-fixup/ and
git-absorb (https://github.com/tummychow/git-absorb).
I'll try them out and see if I like the ergonomics of them.

Just as a general question: With 2 (or even more) different
implementations that solve the same problem, wouldn't this be a good
addition for a future version of git?

Also, out of curiosity, how do they achieve their binaries to be
called as git commands, ie, why can I call the binary `git-fixup` via
`git fixup`?

Cheers,
Martin
