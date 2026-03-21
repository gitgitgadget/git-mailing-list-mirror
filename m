Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F0277C81
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774110431; cv=none; b=dmHV2bYCGuNgW2YMgXdlP+rAmaU3vgXG2bemmQzN0JHnxtqJlYByxvbv1RX+OnLsiLB/Nm79TMPLHAdexpZcL1T5Q6v69JSKMAUtZqz+81neys2P/zZeXriGPDlXUedYZEzZwbX4jDEc4OjtaPWHRb3K9n4EeFSXi+Rl0uIG3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774110431; c=relaxed/simple;
	bh=gcv9ELMQt/dydpyCCZQKwnWvz7xYA2TWqvlv+L1/+Hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=buTkzhsir9pN7kA99lmjwLzb+Et/Pg8Yzkper5YVQc/sGpDiw8ZKzb5OQt9Kq2oZbXlEPduGK7EkvWlfTD4uGkcfQYvTvs2n1BxTl0dhbYKhCHzFBAq7POTTreK4W4gZBBgUEWP5kAThESIinwNQdvH0FrNfXaOdBQJF/M0AauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CNTaOfjc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZ287JJT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CNTaOfjc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZ287JJT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B6891D000CD;
	Sat, 21 Mar 2026 12:27:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 21 Mar 2026 12:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774110429; x=1774196829; bh=jgXplQSu2W
	HGrixzDgEtLJdLJIUmTVqxvafQ8pH0WqI=; b=CNTaOfjcF8CjZDkyGZc5Os+YDd
	yF8D3nhKmV3IL3oGI+qrZUkGNH+5sS6gBa5TauZYSuYKOqU5I44dWRQRG4pK3Rut
	BGQ+pFFp6FY/VQUS5vCOuUJ/azItB5SurKigt9ugHidYIvTLaHk5gYypBKYmOYUg
	ebKtToHxHeEmNWfIwHBeiYUixzybyO1/tODVU2//hEyUobyGT21Xtk3irna/+9Z1
	dagCssTLTZU382R5kPnPAIpAMW7RLjIJ7hgkHrpSvDIyf1ozDRHrJ/algnsJWSBC
	KiJGyzHAh/GJKfjFSTh8gUHjUQDNXM/hRmDihu/aim8MM+2NaWdbHmKxPnZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774110429; x=1774196829; bh=jgXplQSu2WHGrixzDgEtLJdLJIUmTVqxvaf
	Q8pH0WqI=; b=hZ287JJT5HmVeQ4vG9dIpvB2evx3IT9gjgJ5DC5pT5WiA8+Q+ad
	xPgEFyJdunmgMOlxUl6S4+91pO2P4zhbjLZkkyNqz+fowMtm7mph635MMW5OqQ/Z
	1LYq3VzK41tw1hOvOeVfi8MPNz/QVXNA+TAD/OsyG/mcwto0PPQ+is2tFAcqoPoz
	+fVK/1WJfE5RsRdw8sLxpYPyIQrdtIhPMiN8YJHaSCm4ndv6jCBwZFF++qUXySV7
	bWYZu/8juCTx/pvQal2LjSdNmcruZzAFmpazEC9nlGtTJKPD5Fv6VLr5LEfS8nvi
	Ebo+MXd06G/AGEYJGsjFLi+2Fh2XJG8NBPw==
X-ME-Sender: <xms:3ca-affGOCWwSgx-h9ugRZovyyEiS-jmMyGSjdF3N3o_qh2Apn_2dg>
    <xme:3ca-acqYdCtcS0ImmKl6W1G5gdZmn4Tx5CsqrvzdraYtbX5Xa7ECMqjOuVHh6SoXp
    Tl0SZQABffiwx7S50H3cYuju_xrX-xVYD5X--CnOm-PIZtXb1k>
X-ME-Received: <xmr:3ca-aV6SoHxOXvxMUbiVYnUAKWY1jQDJOtREh-ncBJWCSxwonK_IZOpyS9zQ-EprZg-4huptPiW1fdRpt_OT_MJNo5E3LQ1iwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:3ca-aapJUa_y1CLT6MsZnjJUaWuYa4NyT1iaUhbfE5EtXRAQsuaOpQ>
    <xmx:3ca-afiU5Gx39FewhDkY1Z4rdd_7pqyOatRD7tP7dI0DHLeGhGw4_w>
    <xmx:3ca-acK-WypxTh0AQJRfIdfnyEjkBES8k78TQrN4gNAcqcEWfhdodg>
    <xmx:3ca-aXCOHfsSJH1ubgQyDPX80B66eU1nLgd60bMt45YmNvAk0NbAIA>
    <xmx:3ca-aTV3N7HhiwSny05vz4TRrwBjBR0WPZdbhhxmBCumjTwRr5NPc4jV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 12:27:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] git-gui: grey comments, askyesno with meson, tabstop
 positions
In-Reply-To: <02518d2c-d1f1-40d4-8b14-ca27968ac87b@kdbg.org> (Johannes Sixt's
	message of "Sat, 21 Mar 2026 12:51:23 +0100")
References: <02518d2c-d1f1-40d4-8b14-ca27968ac87b@kdbg.org>
Date: Sat, 21 Mar 2026 09:27:07 -0700
Message-ID: <xmqqh5q9b12c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit 1a729ccb930f3c3e206117aeb4f536c9864e09c9:
>
>   git-gui: mark *.po files at any directory level as UTF-8 (2026-01-25 10:53:08 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/git-gui.git master
>
> for you to fetch changes up to bb52cdac6254c006e06bf0bb820268dcf024fc22:
>
>   git-gui: grey out comment lines in commit message (2026-03-04 08:04:37 +0100)
>
> ----------------------------------------------------------------
> Chris Idema (1):
>       git-gui: shift tabstops to account for the first column of patch text
>
> Johannes Sixt (1):
>       Merge branch 'pks-meson-fixes' of github.com:pks-gitlab/git-gui
>
> Patrick Steinhardt (4):
>       git-gui: fix use of GIT_CEILING_DIRECTORIES
>       git-gui: prefer shell at "/bin/sh" with Meson
>       git-gui: massage "git-gui--askyesno" with "generate-script.sh"
>       git-gui: wire up "git-gui--askyesno" with Meson
>
> Wolfgang Faust (1):
>       git-gui: grey out comment lines in commit message
>
>  .gitignore                                |  1 +
>  GIT-VERSION-GEN                           | 16 ++++++++++++----
>  Makefile                                  |  9 ++++++---
>  git-gui--askyesno => git-gui--askyesno.sh |  0
>  git-gui.sh                                | 18 ++++++++++++++++++
>  lib/diff.tcl                              |  2 ++
>  meson.build                               | 31 +++++++++++++++++--------------
>  meson_options.txt                         |  2 ++
>  8 files changed, 58 insertions(+), 21 deletions(-)
>  rename git-gui--askyesno => git-gui--askyesno.sh (100%)
>  create mode 100644 meson_options.txt

Thanks, pulled, and the merge summary I saw matches the above.
