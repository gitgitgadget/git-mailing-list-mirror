Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317651BE251
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734800; cv=none; b=elWP64eEzzxnCGoUgTKGSDpwPgeowKlS+fNbBvhxOeuo73VdYNIiKMmExrigJnO5gneKCG68fJZuTgo+XqD/dP+D+LMneIIGeAe59NbiET0Oy4fH+QpNh/kNo3JuhMDPXm4nTgekLFekEyMYV088Ph6lYzpz9lCvx8funkhKBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734800; c=relaxed/simple;
	bh=xZiAuP6ICpHIKWE69WYBhEaI3lLFqOz8p+b9qGoTBM0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=mMDyNwDWhLKBCH2DT3B73qqF1907Zk4C5vlPCwQvOW+IydbudIl8eYBLL7mX8zPyh2oemmyi89C4cNVZ/wMiKZ9qS+2NuXpZ/Y0SuuR4TBKR+Sqsq2XwDhbwVXzB8trtl9Kqh19StgfzQMO+SZed+uNd5d83kp6oCG3KtRHy3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=15in1oC7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hJABFBKo; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="15in1oC7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hJABFBKo"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 41108138044C;
	Tue, 20 May 2025 05:53:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 20 May 2025 05:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747734797;
	 x=1747821197; bh=fJTXA0NkmlQ/YPZZcBNspa8+bGQp/HH09hnq0AbMrDs=; b=
	15in1oC73vvp+3AiXU6BLPzP4BlEnHbVukyLvAJAidQhp0xZ9kOwoq3e4AMHEh1E
	ePJhAiWY1iCXpon74uUlAvvXqyTkZ2NwYCjbiGUpLU79CGhgJh6/Xz5b9WDHsGge
	4AUGpIX3XamjFk3LooZBocvDfboTlDjvXo6Pxqkv6XFDHJ6jA5gr3wdrwBrbKcod
	/drEzYuORP683/O6q0nt8AYLgbVeC1bN/8mOMTSe6ANACVBvvqil2j+Monolhwuv
	EAPd82D3QmYM2HLHpaLOCvkXYoX+XRENSN7E0MNsFyQ1Sa+tOEuOq6hI/uXxhHLS
	a27NrfDeGAOuzXmFOc5BUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747734797; x=
	1747821197; bh=fJTXA0NkmlQ/YPZZcBNspa8+bGQp/HH09hnq0AbMrDs=; b=h
	JABFBKoCtVpq2KquCj7D74tes6ADaZ7U75VnnYFCdifTEznveDF/edPO2ddckb3O
	Kr7hCegSsUo/4cbGqG6Oq5hGmSb52ccHFTQQq+K4l7WR+G1mMjt1usWJsJPWHgPf
	ZPGFXu2vCigEYeIbAdBJpU4AoMSXfYikNuPdzXp79ZGuppZlkaQFdbGX/cLg/3uv
	zIzWo09XpJEswaRfyJO1KO+xIe70P052qFPv2VMghPtJUXrzhCkvIPfFdUw8OyaW
	N1PmOE44bXDYChUik4ynrRGqaazZAbwA6pSqPP+W/88T3fxL+SX9BFi2R/7L4Ckq
	QrVwceMFUoBLInaSBsDFA==
X-ME-Sender: <xms:DFEsaJvsk77V7xEUjchAUFsw3Empm1fxeM5mnr2dttz-WRQ6kCc8Xg>
    <xme:DFEsaCccadzI4-5ZYkfXPf94BD-skXJ5Mb_JMFzWG9A0_-JXuZx2FV_DYKP0925rl
    nLL2trNkvGQLEumkQ>
X-ME-Received: <xmr:DFEsaMxeYAUtIy2uO47MFCAskIBPPf1rEAV8ymDFqSpg0acBs7VFiL6iBk8sYrU_x8IeyFPMUQo_CnsFr7vEQaPmjx00FSL4d2godFhZQGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuf
    ffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuue
    ehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DFEsaAMRJ3ANdji35PKjcnya19Zrq6SIMw4T3KbfNtgz6IOTI1tVVw>
    <xmx:DFEsaJ-08l57CjLS6VtFfqxrihoOj8xLyQk_RcjBxnl7D7HjO72Csg>
    <xmx:DFEsaAVeGGGT2Ex2dNhuXg44U0x3s1QnCY9XnaesZ0HY9z1t14CbAA>
    <xmx:DFEsaKcXErH8UKzeI6I9Fd3iQjIYgt1LpR2mabJlktalx2_H5fP4JQ>
    <xmx:DVEsaIq2jUBWuaHHb1bZA5vKKf8trI0dIueNVMqVvPc7aMQ9j0ukgV2S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 05:53:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a6f59a2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 20 May 2025 09:53:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] packfile: avoid access(3p) calls for missing packs
Date: Tue, 20 May 2025 11:53:08 +0200
Message-Id: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAVRLGgC/42NQQ6CMBBFr0Jm7RharKAr72FYVBhgQmhJhzQa0
 rtbOYHL95P/3g5CgUngXuwQKLKwdxn0qYBusm4k5D4z6FKb0qgrrrPgarsZbfTco2x2E/QOFxZ
 hN2JD1as2tTHdUEK2rIEGfh+FZ5t5Ytl8+BzBqH7r/+6oUCFpGi59U98aWz3y48wLtCmlL9mjM
 sDLAAAA
X-Change-ID: 20250516-pks-pack-avoid-stats-on-missing-8e3b75755cf0
In-Reply-To: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch addresses an issue we have recently seen in our production
systems due to a stale MIDX. The MIDX contained entries for packfiles
that didn't exist anymore, which caused Git to repeatedly look up those
packfiles. Each missing packfile resulted in four repeated syscalls:
three access(3p) calls to check for supporting data structures, and one
call to stat(3p) to check for the packfile itself. The first three calls
are essentially wasted though when the stat(3p) call itself fails, which
is being fixed by this patch.

I doubt that the patch matters in almost any repository, but given that
the refactoring is trivial I thought to submit the patch regardless of
that. Another step would be to introduce a negative lookup cache -- but
that would be a bit more involved, so I decided against it for now as I
don't want to introduce complexity for dubious gains.

Changes in v2:
  - Drop the patch that reorders syscalls and add a comment explaining
    why the order is important.
  - Add a negative lookup cache for indexed packfiles.
  - Link to v1: https://lore.kernel.org/r/20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (2):
      packfile: explain ordering of how we look up auxiliary pack files
      midx: stop repeatedly looking up nonexistent packfiles

 midx.c     | 10 ++++++++--
 packfile.c | 11 +++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

Range-diff versus v1:

1:  31ffb3712ca < -:  ----------- packfile: avoid access(3p) calls for missing packs
-:  ----------- > 1:  6125b84389d packfile: explain ordering of how we look up auxiliary pack files
-:  ----------- > 2:  8cb82a771c0 midx: stop repeatedly looking up nonexistent packfiles

---
base-commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
change-id: 20250516-pks-pack-avoid-stats-on-missing-8e3b75755cf0

