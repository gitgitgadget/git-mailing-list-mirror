Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AD84D09
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408879; cv=none; b=QfOHfKl63TgoNMvLZG7BqucZU79lhGlYpGTDIosjxwG43a2c4eyNFLD+zJLOWa9TkfvifsrJjOQNd7w23BSgBcwTQu0ySTSsHQLYVRM0soxBBnUM0Rc87vfh/dbQqTINVZOYUBuMq5aMvn9UdVV4tqArdIZivNvKQ6ZO7YTBjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408879; c=relaxed/simple;
	bh=JyS9AhyW+2soKbyCRVdbPLIhsU+WjNhDz7WogN5k7tA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pvw2CX7ReLkC0FNud/V/f2taW9C4j4g3oqB/AYXuOuZik4qeo+hDi3i+F2FNhvqwS7O4Ls41x9z2TffBq0UnGyaInXHsiFoEjG2UJKVyAApAIS2XocEiYne7fSj7zh9ymHWdJm0i/giWtrZ0bikoPiKwwT10DSpxwg0BL1Bga4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8wHvLt8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8wHvLt8"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso7947571a12.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714408876; x=1715013676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OkxjciNQ7LFT2pIF0EaJcOTNtTNUpGP0v8yIVo1XcnE=;
        b=T8wHvLt8O53jMdrHeHF36DdfFnw3ItDK1VN6WCDWcl4l/A2fiB8yYjmTFj5o+iEjg3
         Tt/ddQ1mRGrJCDBvZJ9h+o6Na1tFR9lmojJwS/sLDFykMi1dCgYBoRDmM+4HYd7SQDjK
         N9cqri8ruu8yfJG2fyL5LMoUoIeHNsManSIK3mTSUOQhgYjyLGQ3Q9NNV0wq5vPgX36Q
         mD5H460fum0GwkXRxdXrjX6s7rhxsa9ZQvyxEtdwkRQT/tJlcFWAqpCeObKrZvdYmzOr
         KDRyM3Rj2R58LxbFw8nRRr8GIJQEzQ/Np9UMC99Cq0hr6ldgVzIq9bLgNSJ5F+5k8at5
         KaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408876; x=1715013676;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkxjciNQ7LFT2pIF0EaJcOTNtTNUpGP0v8yIVo1XcnE=;
        b=fn4IUANBislLVrgWQggrVuZNZrFwDJ2Mnrdk3Dl/WK5UUtUSaTv9edSKcm/4qXNmuo
         N2uQXdhtCv9RlsIGVRqLHCjVArSS2AixwVPAPggHBOIyJtzWa5rrUFsuJCWa7llx9osQ
         Rc1mrSkgX/ZbYDVv6RecOyJ2+Fl/miyb3jpqVuruaKZnR0EV1xqvp0SVSI403e9+SYRq
         C5zGB4iy0ctxnPGNRhhOHiuZAjPbflJi2a/CLOKX/HIoatalc5XrsSLAN6KIfJ+OQDXG
         eMHwwaCGQsxJIT96MCCR2c8b8/MmGL4cvAQWXPSnfdpslKWVtAwGyaOM6A76OjK026+E
         TTIw==
X-Gm-Message-State: AOJu0YzCxImBiGMC4vVmU6wQJ/diEzoEqulurVB16jX+pzpxuNp/Ty1g
	mvarwPV8zsGZ4GTtS0bBBJrIYIV0xSFyQ8lNWVk9wCrgwQbswVkOQtJ3Fz0YrtWmaiBQi8atXJj
	G9cUZv3X2INr33G6T/uOZth+1+sDoBaan
X-Google-Smtp-Source: AGHT+IHIi+saQ1xZtcbYPqTeZHuprW4VeXhLtTD1IcD8fnq+uSjYBfcPYVXkNBb2QvsAmsuCMLmB70WOohhaBKIo1hg=
X-Received: by 2002:a17:907:bb97:b0:a52:2d35:5e28 with SMTP id
 xo23-20020a170907bb9700b00a522d355e28mr8658611ejc.57.1714408875585; Mon, 29
 Apr 2024 09:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 29 Apr 2024 18:41:03 +0200
Message-ID: <CAP8UFD1Feotp4ra2tpeA7+iRiqDOFzLsQbzw6mUDqt1Uq1oTVA@mail.gmail.com>
Subject: Draft of Git Rev News edition 110
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, Brian Lyles <brianmlyles@gmail.com>, 
	Max Gautier <mg@max.gautier.name>, Adam Johnson <me@adamj.eu>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-110.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/705

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Wednesday May 1st, 2024.

Thanks,
Christian.
