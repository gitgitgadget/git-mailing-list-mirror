Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89A1F12F6
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271922; cv=none; b=CxpKJVJESxOt0yy0NnolKdR+dEYJm+sDwnlTM1+nZvQDTMxgh0TQ9oiOSAmK96L85IGn64+hPyTIXdEMmplfF2LgM0NTae3wozZEadEdPaY9A7/RJ0aWdCmU1BsMf9bcskdm4q+YfAOtwODwFB/uAn0lPj37OZFPXuVQPlK0xS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271922; c=relaxed/simple;
	bh=4AzA164PLC4A3HcYC9eQ7HApchibKmCXdz7/jt4wIg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tawmfLnwB0TDsd+BGXwpZtPWG51h2xwXLzNCwcUCZNEuaLWpaPQe6DJJMqb56kII1VeocA11VW14XwRsvkX2n2yR3xsgRUaXDKZB1WnTQIDQ6toDoTR7vhzRMLGOJC1filMJUjtX7bf3eyVU8KuRzvrxTPSJ84LL7o1Ww/EOBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObZiDjSL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObZiDjSL"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so2686572a12.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 13:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738271918; x=1738876718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q2CqOA3xXxSHVzjfhvG1ATsTE6Z5jDTwlVdqm82Aqt4=;
        b=ObZiDjSLWumEk4oBklGp8xyPJss5ChtBttBVIXwKMqdTGp6DI5Eh14VEjFF9OOs2hu
         DyAfDzfYXMkWokciLH9CXpvvjmxtIAw538VzWbNB9UZbhwGnB7uptbf4MixGbjKGdgUb
         /IaopXdfxa2zADkc90grXa2opTi4VwbGJ3O4ZbmwCzkRyGwxj4+Wsjiq49Uy1wmhG9ri
         m7JSGOr5PqU+JP/gkbtKaSc8NAiq3N3gHyJ1/USxwaOL60uUNyPgDogFGaqPI0rbzKZs
         5a7wX0a6RC0cJmEUhzQtNqE/K/LF+yn5sFTw7qILNPcEPdDqkLGYA8VWrzTjfdmoF2cg
         RnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271918; x=1738876718;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2CqOA3xXxSHVzjfhvG1ATsTE6Z5jDTwlVdqm82Aqt4=;
        b=RwXHV2VE+l4SRWQMQX0uX80jEBLT8/OSsy74r86t6vyNG/Ek6ywIAaJnkiVM3rHald
         u9zIu6K7wa/oHmjKUWUxb7PTf7L8veN+kJz3BQ3zcUSDQGBYnnFby1AdMeEHPwBDQus0
         BGwy9FQMvt6wgQ18izJJnvC+/t8Xd1SYJtC9V1uf+vbo8xO2ghxoue9Io8QIUrUx9CDk
         qIAIslfjnfju5LzlGeiAHkC9OpwO5A29GkwZlBvxHOpQV8jB5rYD1CoUPQqFhKU44FlY
         DnBdMBK/35o73f5xWXmE1JBPcolUlbtjibBTnYySgkAghsm+056zsHZqn2TPBA4HJRYH
         YJnw==
X-Gm-Message-State: AOJu0YxPR4xo626Kvuelex2rkgKY+LfySQyPntexHJgNjDw7q+q2rlkh
	IRzI2rYawCKXM+6IR83aTqPXw1X9Ee/VU5j4rWzpCmg3gieMfNC4qg6s0lNn/aIjR+siLiv4mfd
	SYXSBZ4D5fC2pTb1v7agWtXGKQpHSMgiN
X-Gm-Gg: ASbGncsI9Zp5v21Fa5psHDBlTRFGMYUVTPzAF2z2/ROLCYRICvDoBTnZy71WTR6Yj1R
	HIKleS29/4zGFmfMaQYk6DjP06qfLL40bMUpvqOzEjhbtRECvyVzLce7D/7ft9X1BxuvdlU5vAG
	0=
X-Google-Smtp-Source: AGHT+IElQDPZCqbHNVKoQUc2Sa1Q7kg/if4aEi97jskCplitP7J9HEHXrXmTkhSdAFWP8J2FUhzzx1GchBFSj7GQgxo=
X-Received: by 2002:a05:6402:2812:b0:5d9:f8d3:6e6b with SMTP id
 4fb4d7f45d1cf-5dc5efec2famr8769776a12.22.1738271917534; Thu, 30 Jan 2025
 13:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 Jan 2025 22:18:25 +0100
X-Gm-Features: AWEUYZkr1dpQMBL6AeMGNQ2qHd_KuBhzmjI8z9tyIoJz3D_RnfbNYhk1jkJZdsA
Message-ID: <CAP8UFD1wUUwNhCbGi=Vo4pCfquLGwxXsh=mP0DgQDU3JhtXgwQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 119
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	"Peter B." <pb@das-werkstatt.com>, Justin Tobler <jltobler@gmail.com>, 
	Brandon Pugh <bp@brandonpugh.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, Adam Johnson <me@adamj.eu>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-119.md

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

Jakub, Markus, Kaartic and I plan to publish this edition on Saturday
February 1st, 2025.

Thanks,
Christian.
