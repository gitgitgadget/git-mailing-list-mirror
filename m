Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDE1DF723
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771224356; cv=none; b=IMnV7VJnRU6jT6oRPk/3NUXwzemwrOnoMXPNW23ylk/AzkhkCYTwJuzsqO9oey0XN7sKGhqzTkPp7/VwxFdmnElogj8YGEDISOnuCYPIjjdQvwBJ73dMt3YsVGZFshSOULf2rOWmqfS0d/Eqrkp/PpIRu/yQ2BYY3Sb1pubCMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771224356; c=relaxed/simple;
	bh=ErrLXvdWniqsMHLeLy83Q7AXwCxoVpX1JUwaUp9Pm3k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=RWrlHZTxkAo9v4okJKzni8fJe52s6GdAQHvICjFJRwqF46jcqIdR9D1BKhRRjCki8kKzCzqEz7puprnx4wN5srm5F9QklWujmcPWhCG8tG4vmimfuwuo8P7Wnyt4Bg0lQo6R3xsNNQ7UvdIpGJZN/zoOq+iG1YazNHKq/n/KMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fWBxj+96; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gACUDjNe; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fWBxj+96";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gACUDjNe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D5437A00D9;
	Mon, 16 Feb 2026 01:45:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Feb 2026 01:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771224354;
	 x=1771310754; bh=5N6xg50Btr4HIPk3F5FpYKj5iD4gH4yUZQnNBWN5vrE=; b=
	fWBxj+965Tay5x52ItUwwwth3+6G6umtraYd/t2avPNfDezMk8ErvgwXukVG4SDM
	WrNksHpLUZWzSve9kOs7kbYyJcD+pLus3yHunBu3QbAh9mVjmf4SES6KqiP/ZVi/
	u7nBVEKlkdBtmXLfiDk1vo36EPxWEzqfEAryJCHGR3a/1YBMxPmqXiyaK5JRhHfo
	V+fjnjWP0TVNn99cWh4SVvEhLlEnSMw/2NxzVi7uacEI8ZX/2CWApe7FVtyBeMAu
	WuBO3YhDxgXH2QAt5S3oD1+TKEAM0h9L5qARBxQ1YiAhFMcA0p6C9QXKoiJiIS4r
	TP8LGei+57wktX0JeN9wIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771224354; x=
	1771310754; bh=5N6xg50Btr4HIPk3F5FpYKj5iD4gH4yUZQnNBWN5vrE=; b=g
	ACUDjNe1wygVNKfoRAR3qb9edzbPmNSgD5okqu3jdsDPMybjpCMkUsB7A4HAF32j
	fUjUP1wVxhsQgIRKIO9wFLh9hafkFv2HR/VViFvy1qzOB/s2PpbgiGPtVxMCyfhm
	x6/PJIIf4YiXjfpCXTwWQgpxh4+ohgw+N5FwVhZiktt3iXowE1wZluH/7bhZIAMn
	B/wSknSLdy+S/Gm663cG9C4pvOq4BxdcEODc4x5Ea+JSJBvEyKu4rg6gQuCl+yqH
	5pLTWPv7Q0T6y7IEk5BVMarUa+/ynnGNVYhI92mer43zQt3BbdaiVoS9wHhiGEpP
	J+chtY2Ji34YN3hDdAErA==
X-ME-Sender: <xms:Ir2Saf75nXZs_YUyCuBdGlDXQ67SWIBJaLNA78VJlDkNEfS1S2jc-w>
    <xme:Ir2Sab5lNI123uwSMoOUE7xARDFfx2EWVpyd8E4orByImxvKZYVCKUbR2MyyW7uzv
    wYNv8feJyMqe86D8bRnYtucPhrDdE8UQFiB-ggtvjsZDnRX9gIR7qM>
X-ME-Received: <xmr:Ir2SabcTyi-iDYBvHRXKvEWJFiytIhH7r4KGPkhQXsYy6gHNmHSiLVqnEhDcbPZAFhWpR2bnS0kcRZNCkDT-6bAlSQUYVYK3bmkWuOrbBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ir2SafDclJ4qRUayOwgmbvRk5R0kaXp42WxypUdoijqshNyUeTdCgw>
    <xmx:Ir2Sae_nYr5A5Z7HCw27PbPjhVmRo6yOSmsPJz6uikoEErAMCUvHfg>
    <xmx:Ir2SaaLIZ00cX3BTiN_iU6RKEDNGLihKIvVXpn1DHtP4VdmdK_-6BQ>
    <xmx:Ir2SaXgMtSxR84fHWqmrKPYu5D18Ld4ZO5wqfs9UCNxFL1WEK72ANw>
    <xmx:Ir2Saa9kT_AqstjBK9etg3bYN5B5-LffMq-ilV40Mx2JHxbcBia37bpK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 01:45:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc38e302 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 06:45:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/5] builtin/history: some smaller UI improvements
Date: Mon, 16 Feb 2026 07:45:43 +0100
Message-Id: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABe9kmkC/4XNTQ6CQAwF4KuQrq2ZHxjUlfcwLmCo0hiBzOhEQ
 7i7hRjjxrjo4jWvX0eIFJgi7LIRAiWO3HcS7CoD31bdmZAbyWCUccpog3WOwyViy/HWhyc2MuH
 eoak3uaLCqoocyPEQ6MSPBT4cJb/7y5+k5+1fMmlUqD0p2zirva730lrzFWYvmW/D/jSMGGXhK
 m9LR1sqPsY0TS+P63cG/QAAAA==
X-Change-ID: 20260212-b4-pks-history-dry-run-2b840e530ae6
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series contains a small set of UI improvements for
git-history(1):

  - The first two commits adapt git-history(1) so that it performs
    verifications before asking the user for input.

  - The last two commits rework the "--ref-action=" option to instead be
    split up into "--dry-run" and "--update-refs=" so that the option is
    less focussed on technical implementation details.

I decided to send this patch series as a small incremental step before
sending `git history split`, also because that series conflicts with
aa/add-p-no-auto-advance.

Changes in v3:
  - Fix a typo in the commit message.
  - Link to v2: https://lore.kernel.org/r/20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im

Changes in v2:
  - Use `strvec_pushv()` instead of looping around `strvec_push()`.
  - Document that "--dry-run" writes objects for later use.
  - Document the default value of "--update-refs=".
  - Mention the subtlety around false(1) in the commit messages.
  - Link to v1: https://lore.kernel.org/r/20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      builtin/history: perform revwalk checks before asking for user input
      builtin/history: check for merges before asking for user input
      builtin/history: replace "--ref-action=print" with "--dry-run"
      builtin/history: rename "--ref-action=" to "--update-refs="
      Documentation/git-history: document default for "--update-refs="

 Documentation/git-history.adoc |  14 ++-
 builtin/history.c              | 254 ++++++++++++++++++++++++++---------------
 t/t3451-history-reword.sh      |  20 +++-
 3 files changed, 182 insertions(+), 106 deletions(-)

Range-diff versus v2:

1:  26db5f0113 = 1:  21b4933c39 builtin/history: perform revwalk checks before asking for user input
2:  9bcde0b932 = 2:  37e42cf770 builtin/history: check for merges before asking for user input
3:  e070d8ecfa ! 3:  fcfd80b2b5 builtin/history: replace "--ref-action=print" with "--dry-run"
    @@ Commit message
         will always operate as if the user wanted to rewrite all branches. But
         in fact, the user also has the option to only update the HEAD reference,
         and they might want to perform a dry-run of such an operation, too. We
    -    could of course introduce "--ref-actoin=print-head", but that would
    +    could of course introduce "--ref-action=print-head", but that would
         become even less ergonomic.
     
         Replace "--ref-action=print" with a new "--dry-run" toggle. This new
4:  59f470b158 = 4:  8333a4ebd6 builtin/history: rename "--ref-action=" to "--update-refs="
5:  bde39d43a9 = 5:  9ef41103f0 Documentation/git-history: document default for "--update-refs="

---
base-commit: 6fcee4785280a08e7f271bd015a4dc33753e2886
change-id: 20260212-b4-pks-history-dry-run-2b840e530ae6

