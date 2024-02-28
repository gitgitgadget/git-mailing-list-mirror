Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE886241
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155510; cv=none; b=ld9qd+cszuPfCX7mBqUryhtHUSrsHO0PLY9U23ZGr0dadvfnzynW1d6XqCOVS2t+/NzmF0YaobiIF8qek+4ZPUY8CiJ+GLSt3Dveg6A6tGifGK9KB9oUhvN8YAdKE6Wig3wsMlg7+kFwQjBy3WH/YuA/A02ek/rjNUuQ/2AS0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155510; c=relaxed/simple;
	bh=a2t/veYJTtdrg5kO5f4nsCNN3kmFDAh4t2uCC7OM3cY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RB9KTMQuRYy/InNSauq0qLb2SzWlPXA2ZABbYi4297UJnBjOZW4zPuxfAzkc3xWLjzhLaUyCG/EZ+hJ7Bt2079LwCeb906qej88uaY3KBGaJkq/OLk2TmporILJqzAZu2xrees/Rwr24lIGVKhFUHsu2SSKc6M626iWtdajnf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCx/bDaL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCx/bDaL"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so2546468a12.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 13:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709155506; x=1709760306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9XMtHcTqTv+W5qZ326hy4K/5kKhjFya9NBfJdCNFw4c=;
        b=hCx/bDaLBKigfRzP3/7b77TPePHjV8nqfqPomLmjUg7twgLwSu/2oKsiIRPH6t8Cia
         x0atQ6EjayQQQeL+fxlU+SHN9b1zPsKTdpiDY8SvPEXI2DrS4QoKHS3kolaDcYi+t1QA
         GzX2y2D+niO0ChJ7svodKgxJucXXiLpoFJrJN+ezFn2dkHWiPEXIq7JHFRlPYYCQTU2c
         zdc3657syKqNrpYzr+bYa79CvqeMpxwmaEgA0nS3s26B2OfNQhX5mcH/LGIquETIFSRA
         RWjJ++BL1XSxw+FGvF1b5/5HfJhcuUq3AJJFng2/VpbrEK2ybXdr0V38WOHsUe8Akrqi
         5XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155506; x=1709760306;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XMtHcTqTv+W5qZ326hy4K/5kKhjFya9NBfJdCNFw4c=;
        b=TavNdEkIeqEtPu11jLUdnPtM+HiQIV07DtnJVqmJnNy4o+vait4jEsT0Xf1HH5MA+V
         7Zku42fx7ElesUdSsAibfrQPsNVc5DjQG63SZyOHCkprkcIFNV7HwtjKCVe6H3FCJW7S
         g8i2yC0MR3otbOM9VSkZ4IIij+tI8UhrQbOWe4BDbLMf78Py6QiSLcEco2zFpM4KEhJQ
         8K6JMGgYA3y/J4kKqV/KhArG5E0A5lyRlQVyDsycNy+DJ1tVso50z9Y2nZ/LL2AX/yqP
         uyqshBuCfi3fnr336ELySjXtH2ZkWybvnS49CVwbZIF6Wo9zj3PiHqU0Iyd4vSWIKgVB
         wNmg==
X-Gm-Message-State: AOJu0Yyc7s6F+tSvLvUsRu3ZrlqAKVpkb7gkS6xchcRaVxSulO/x1Lvh
	j0dbyH+PEX069wdq7mytbSVHwrvGepLO3hqIxeL1Lc+Um4Y089+Him97/QndADZbfLiGUIepSwW
	F2CD42o7svWsGkKKVoQjs2trD5y/4PsWEiWA=
X-Google-Smtp-Source: AGHT+IFkDaCxNUWPi/OofYwscP84mQnXW7ePrLrxP4quudDJSOrgdlfHpxmV5ypqtsQt5z8qVp9ZZ++ZQJk/QsUUPVs=
X-Received: by 2002:a05:6402:4487:b0:566:3d1a:92f with SMTP id
 er7-20020a056402448700b005663d1a092fmr510037edb.16.1709155505959; Wed, 28 Feb
 2024 13:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 28 Feb 2024 22:24:53 +0100
Message-ID: <CAP8UFD1cRV3iM0hMtB_gGsd=GXJf3w8yWbHVuiHFpqYv_V6NjA@mail.gmail.com>
Subject: Draft of Git Rev News edition 108
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
	Jeff King <peff@peff.net>, Dragan Simic <dsimic@manjaro.org>, 
	Brooke Kuhlmann <brooke@alchemists.io>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-108.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/686

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Friday March 1st, 2024.

Thanks,
Christian.
