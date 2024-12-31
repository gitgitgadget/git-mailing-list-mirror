Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79B7BAEC
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735640361; cv=none; b=Z21Wr2h9vxDk2SlVZtLtcFe+g6cXO9eYkPxDdPRnQj/d9X8UILc9JxA7CxdDIukpRyW+qwv5ts/gyUPkr6nAs9DsWmZg9U3UIJw4rzJipu5i3mroNvNUiBFhTyyJPd+4J/rRyWFqUtMmPVTOK/60HAwElTQs4YTm5NKrh3FJvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735640361; c=relaxed/simple;
	bh=eK3s+d4nCNW5D4vctiI9MW7TC8TEtp87iY76pAlc5uY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Xq/rZvV1ri+es5eWZAJf495gsnltQhC9fU1XrWedjDXeLKHVl4A82bNlTkFynvxmfwyDA0C+lyV+TvXgTJAjZeQWwOieCJ1rGzylZf1foJTVNVaAnY+eflIPycEB2fW0JemOnsgqOBplzCc/bbvaps36y15hyH54DOsZ+XAQlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw//VXRM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw//VXRM"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so16522547a12.1
        for <git@vger.kernel.org>; Tue, 31 Dec 2024 02:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735640357; x=1736245157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TWwDC6Pznc7RHNlj6oNDao0lieR8FNL6IGfAgD7JIJ8=;
        b=Uw//VXRMz03TKtFHYcS+V1q6yFJ4bayl4LCASxngKpb+mBACiltO/XULb9cmwb+wj4
         5VAFX/KjbJk4cSICRjarpip+vMqR86lYizKDF3wFwuvzhKbGURLV6EAtlSaKA6N7xFbD
         sm0pMtQd0PCfHXxiiu8hS1m1ld3/Ttrjh+L6Sw6Ioj1jVtQSF+N/lAbHEMTw0CW6k4GR
         7l0Cr5fnxh7xkABgjURvfMn/8cN//Yv+4yELvqXTyIFJjrrR91Ny5js/D0+XmD1iee04
         CHK4gQpxdAzp+fAZlz1/o0K6a15bqw/cMe+ftXLbCId4U/4gW2Kui1M9C/N19VpZOzVk
         O2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735640357; x=1736245157;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWwDC6Pznc7RHNlj6oNDao0lieR8FNL6IGfAgD7JIJ8=;
        b=WIvU2cD+mIBxVVcT79At2H7skXEMFAppS41OutBzxsUZiovnzHbxSgS7/1aYwmOhFi
         VVr400jFvF8f5COsheKL8Z1T8w0KtmZechIgjHG6nSfadtn8xUBaImbV6JB17F/4f06S
         aVaqV0TZCAF3uB1skR1MKpcTObNVkgfEGf2LYiCIz1CWGaIzZN/PZzKs/j5mTHy23IKw
         KcfPQGuxhmFcZNOdP6bmX1XIyZW6JVFZOCs6nmPettcJPsUv5+rLBkkgc4BuRsfXqjvs
         kNRyk774yQqGNZV4Q2Kue+146lpotMeoZXXiUoQHzwVLBM7JlLbzOjDDId5j0XzMAXGB
         ue/A==
X-Gm-Message-State: AOJu0YxrDHdPWsDaJwC0Q5vt8pOEhu1n1bWy0x5HT93znePvxgXjK10r
	+iXV3Z2bSlYYkU4zGa6SjIkMfZfu7rfOlyCO8AXD66LO1D7I59icf10rP3X6IVer2Unxp3HgX0X
	tUPO6Efj9402M4xZjgtoP+pYc9gf8/z0v
X-Gm-Gg: ASbGncvK/pA7h7cxytlj7X09f1HjHEV3i92ryy1KLaGJqSWBMRToa3L7lJFRlazgTZV
	trNo3fx1J61WhG3VNYOjKiuwXmtN493Q5fVE5Tm00
X-Google-Smtp-Source: AGHT+IGjkyW8Pbhnhb371DhHIUCeB5QThPhvknr3rqd70bXTrI91vVIdO3qmz+v6MeMyU6ZVqELgTyBUKDGJ1KsPVxI=
X-Received: by 2002:a05:6402:26d1:b0:5d3:e45d:ba91 with SMTP id
 4fb4d7f45d1cf-5d81de39850mr35150346a12.32.1735640356453; Tue, 31 Dec 2024
 02:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 31 Dec 2024 11:19:03 +0100
X-Gm-Features: AbW1kvbbQaJ0vMWFZbPU2aH0_kXM4lwFO-wOlPcM6h1gMKf8Qu5M39w06SzJEWk
Message-ID: <CAP8UFD3y_m1D4pF1rCZgmW+C_6JYrxjuyUnGAhKBgbek+zBdRQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 118
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, David Aguilar <davvid@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Eli Schwartz <eschwartz@gentoo.org>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Henrik Holst <henrik.holst@outlook.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Paul Smith <paul@mad-scientist.net>, 
	Emily Shaffer <nasamuffin@google.com>, Kyle Lippincott <spectral@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-118.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/741

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
January 2nd, 2025.

Thanks,
Christian.
