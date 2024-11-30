Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD492F3B
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732945188; cv=none; b=pH2u5ktDUBC6UtGDsXX/oOgrpmpTkLlDjnJXPfhC4XZ5NiLJjR3Ljd0se5MJzcUfUQU86jSzL3Lyi0FynXAOdVwU7D6c6xsz9LCQrb31rIc2/HrvGwkn2Nh4RcPoLMc8I6hPzLpl6rLHAAsurWEVpRdaBlW3629XjHWpTFowfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732945188; c=relaxed/simple;
	bh=kGb9/9XYGJ0u/zf2n25Vh2Ox46QyaHpJ89ZxGAstgYU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sqNViG25FaIURXvta5TJhFvSK1UV8B+YdI7mDHtC42/69YDBBe10B/MgWY872xLKr7BsaTQ5C9V2nVmTDMCEjicvsVghqTitj+DetIQnKQ2PMY5nzHoBlaeuAFo/lowDIMacuQIX/fUCkDfE6qpQzjdrvhtUGluGPaBVmviEKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBWG9EZK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBWG9EZK"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so148597166b.1
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 21:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732945183; x=1733549983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=466KXFZz5YeooEX4Mt6UXm2DC08SP1K046QcVz4TCN8=;
        b=VBWG9EZK8I0z6QWoBnV1ol97NeGjIWQkJpbRpYhakuVouHWT7Qh9DKe4pZheBIlAxM
         7kcFgKLLgbIypsUTeSDlMcFYNljob2V+RF4vwLfByKay2e8e2khO2yZ4Mlb94UjBv5rV
         /Wl4Cx1hsdu4NLPfdeMbODGHnaVUZ5xPnwvBmbTdf/isfugTHv8XqJLpMy0HfJALpnc+
         8XCdc5mSTS6Pp+tnyxTUnAX0ekIiIoB0Rv/yeCm7qr/jJ94ISX2O1w0JjV5baKSC5kRM
         S7Krheqi5/QEfnipLY/+BNsm8uLD0RwIkvr3qE8susKto7dRMcHcKNPqjevbh6duZq9/
         MdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732945183; x=1733549983;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=466KXFZz5YeooEX4Mt6UXm2DC08SP1K046QcVz4TCN8=;
        b=G1H0l8Yb1HtKXxGaj21mUVFagHo9u84t3Ro8JvTlj7vT9JI4KQg9+AthoGGNeRm+rn
         CEuAPINma8Tl46XoanmhNuq/P8sblfGc8fGLMpR8LDgbp21ypxYrnFlRPnhH2ccM1zPf
         K0ttZTKY80F75TF7OyXTSdrxJ8BeXRbuXw+jjE/TvoTpjgOErSs/dq8eCG0P/wpiMdD8
         bn39VQk9H/rpepDMHQIaf49ZBXGk8YWbQwMuSBpwsvMTCbYD6AumE0vNfs4ytbvXDGCW
         M/9PnP6/lyLl5EqBgXklrGaM0Nl1KfnnNiM5l8zRhLVnH598AlJ0LK26ShbX3mQS3oFy
         NM0w==
X-Gm-Message-State: AOJu0YxebEPoGhTQeifftICrPrugzyOZXDmK9QUKxVwggMU60tv3L24d
	UwJdQXPBdPE5ge7qirUZFru5Oi5TLrwsAgQI/CKXPa53o1pvQ+VsDfdOPCZ+aM7Ae387rELnItS
	sVpwlvfmTdK7EHcH87GbdHS++dJwjJLPG
X-Gm-Gg: ASbGncuaqqQ+LrtIABWH0OQBocRj5bYEu8d5LGe9iyqC5Xg8xfSPoxtp5p8nn99SD+y
	2gC5lc3LRIQsrxg0hY3cJaf970vewNKhakQ==
X-Google-Smtp-Source: AGHT+IGNM/0TDXo8N1+5XFR4is7il9hkuD/VlH51Ztu7gqlN7RuS59PaXzMqrmdgfY595uLgI3uGI6+wsGF4sag6mXQ=
X-Received: by 2002:a05:6402:2807:b0:5cf:cf74:8527 with SMTP id
 4fb4d7f45d1cf-5d080c64750mr20307943a12.28.1732945183220; Fri, 29 Nov 2024
 21:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 30 Nov 2024 06:39:31 +0100
Message-ID: <CAP8UFD1R3Cp00KF2nAX6C5q=dtYLdaJKomXWM4DjM5DwjLi53w@mail.gmail.com>
Subject: Draft of Git Rev News edition 117
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
	Bruno Brito <bruno@git-tower.com>, fox <fox.gbr@townlong-yak.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-117.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/737

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition late on
Sunday December 1st, 2024.

Thanks,
Christian.
