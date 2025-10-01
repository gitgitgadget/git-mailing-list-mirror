Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47352737F4
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301896; cv=none; b=r2PzAx+4+xxVQ+Yxj79nI4hBuGP57CRQqXsvhxt1jFUl2SnuzHSxxeiAk4oMrdV0tau1cgJysaEh0nQxmTkG26k1nsiJ/NaNMBudecwAjB4UkvNsamsncuvUNIMu02ZLm2uxR4GP1MY7jA6Cfysi1N2K4lIztf+5Nu7MZZixIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301896; c=relaxed/simple;
	bh=mjHP8EunJdEMMrw0w4EL0eYu3xl+YoYL6X+zWzhX98Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p8GqFA3DeHou70qnrckCEN5i2V0K6zluukafe75cKlE8V08yS1x7wsJqYm+dpzuufsZyXOYp7HPtXsUjCnsGbJLLFawa1IO4gVBGdJH31GHOAXFBOfhMeymPwi8rVx50FApLUHAc9eClLbfFjJXJDTWHTG9m3JftpiUQWLgFa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo57aDtT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo57aDtT"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7322da8so1330741466b.0
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759301890; x=1759906690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iZ30s1rLA+0HJRWUL9wMVdoBig362eLrAgIn2QQrJtk=;
        b=Jo57aDtTsdrP5VWtWTGT6RvVSQIRlUNG02I2ky0n+x/4qcWR0li9XOov7GCikmEVRg
         gHBzXjXMIEbBi1UVVhNxMlwZNqXL4Kg6hL/0itmZjXfV1Gq7LrgKF0jy+3MnfTpIy7Rl
         CFzgxQJZ843jFRh0BCY+lbLuueBisiCzk0K2W8S8X8pM6SgqIUwYTc+yB/U/JywxqNA0
         evjx7SmLKH2Mbjmho8MzrLZ7COsPAL7diRZuFbj4dRcp4aeOy02FAOXepx8J9bicCUQJ
         54BjUrjjlb0aBoTn0aPJ/S9ibdXwpwPk54kMf4BD/XOI/9ZRMcf/HleqDdasPpA1ewC8
         +HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759301890; x=1759906690;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZ30s1rLA+0HJRWUL9wMVdoBig362eLrAgIn2QQrJtk=;
        b=V37zNZ08akOMxwC9cR7DEE8Ug4lzzXbRTwg3g10UWeUscFLKJqSrkfZ12uYboDPP4P
         gSy3iWGL5CiOCSazdBtlBVMZD7dR5otHeUkips8QzZDULzK8AkK0UxvX6Ua/Hka1i1tV
         /2M8QZmYU0bb5OnwVHK+v7N0trnxeYQ2D4s0yG1RxwDHLQaX+zQBYkJGeW01ZGE1daMe
         LF3W1Ji6se7CCXZfZXs9VgvhzaTGeBFO7AERglLS0n+8BK29R82dnFqYFAYicX3MwK1I
         XiQgwEuJvO+W9JDR4c2PcZY6Mx5EWadrI+husp4CKaBarSY/1Ipe0yaMGWDIvnqR9Uh4
         7rjA==
X-Gm-Message-State: AOJu0YySRI9PbQoX/zn3paSQREC4wlQg35Q0EnmOefPa1KZo199vRwSB
	zpDdiRB7UU/q8dlazJHrv/FuwUnTLOHcw2jBYbVIG1Wh5hHPiXOMIXM/zEEjRZ5mFzOciQeG1/A
	MU19cloN8wX8FMR56jzEZ8LmlFr6hGhcB3HHrzco=
X-Gm-Gg: ASbGncvoOMzCble1bbGqHx5WqFFv/d2XwLr6K3LgZIjtowZyrsfsyd2E2puH2a8gTDN
	3f96ikNu/1qAA9kLIoYDxdSk32Uy1X+jEN6D7BQmcwGuYzlH/iLq1xMoEIE8PUpqf2eO2L2JBir
	2rCYajU1dQTzv3UeobMjinKTQpo40xAE0muG7ZsD5TCB0Vp/EDC87Xh3rRbCLr5Hz9y7OLOSSZf
	Jw6H296Xb+9A2jQr1K/tkr/dQZBHmk=
X-Google-Smtp-Source: AGHT+IGx1OdyZXa4nukT1LBtRivO89NOyH0DpB+lhNlZ5eI8v7TNt56LUpRSRcSU8JDb//wLBKp8RDGT87SeWcee+Ag=
X-Received: by 2002:a17:907:720a:b0:b24:3412:7cfe with SMTP id
 a640c23a62f3a-b46ea41438amr279038666b.63.1759301890420; Tue, 30 Sep 2025
 23:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 1 Oct 2025 08:57:58 +0200
X-Gm-Features: AS18NWBQpMMH0X5xJ3SVF1tP2e13-Jy9w8PCId4gdv52jtwZSt5FJm8mRAtil1M
Message-ID: <CAP8UFD142fn2x4yS_Z-N6x5AFf5V=ouq+gJqAbHAoB6tDoCSrg@mail.gmail.com>
Subject: Draft of Git Rev News edition 127
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Patrick Steinhardt <ps@pks.im>, 
	Derrick Stolee <stolee@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	=?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>, 
	Toon Claes <toon@iotcl.com>, Gerard Murphy <gjmurphy1@icloud.com>, 
	Jack Lot <jack@themoderncoder.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-127.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/797

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Friday
October 3nd, 2025.

Thanks,
Christian.
