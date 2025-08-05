Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0D2797AE
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406711; cv=none; b=uifrsz0Tz3VHRGO4LqFGUhy01WLY0Raw/GN+gRxTxFbjVgpIcDWRVZghNw5Z/en0HEusHdvbyz4TmZqf1uLtvKtPNA92MUzFyqrlhHvBYrzGLRGhOXwMRuP9UwtM89iOc74zS9IhoPS1ydrGkJRaXdSLU+lfIDZCJEIohfXeb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406711; c=relaxed/simple;
	bh=Nwq/Tt8IP7hnctWQacq0jJgm4t0x40gOguV+IboQOfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRcFxtMXI/nlgmIzGiYtTUWYc+qZSVUsLrKEMNSiZOGjWfjnOjsYeqeOaJD+GCcbhjqZajCslj98LL/4pAJ5Maihg9Rr3i3wrX0lCmcIPcZu+EhmXmTpxJ4kZXzdilLXxlHoUqIqciMwINPqYWySwohIpHy7BL75YHopZ/sms0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aq2CFyvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=duhdbYfD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aq2CFyvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="duhdbYfD"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 42A7AEC01C2;
	Tue,  5 Aug 2025 11:11:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 05 Aug 2025 11:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754406708;
	 x=1754493108; bh=abf+4AMlBh1x9QnvcmSEf2vSHrDuf2cozL83rWfXQEk=; b=
	aq2CFyvXzBtDbdlVSr1HjhmLhftOJ0oDIo4wAcE6831ny7lVTDIyogiAb/18Gdao
	OH/87R3UdYuqEc7BViDnVjsz21y1VOzg7yVIYgTwWahl8jdFZGmQWLJa2J/JpZah
	pyZr7dX1oN4JYP1erlk5jBUvDwDRX+8nGH9B2kNzZaYRxASXkH0p8Zso194bJ28M
	i8taJrgsqcTG+ncmTQXbKe0kdc8r8C2tvPEiuwLTfMTzRCqcDo/vX64qxupRgUB6
	m0I4uiJkkzxhWv9zAifB6fGEQ3Y/qq+4cwp1IpmFDfmjTyq9Suixzj0TqqhlIU17
	3UNeE+CgPtQq3nSm2HlPYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754406708; x=
	1754493108; bh=abf+4AMlBh1x9QnvcmSEf2vSHrDuf2cozL83rWfXQEk=; b=d
	uhdbYfDZydqBbrqQHchTM2zJ3G+tAlJBhY32Lu+tmtyydwpZXzMYxax/BRK29jXr
	tuH5q+5gqRTq8S7FJEIj4G99g6/HBBrJ2gRoGnwg+kR77BzURqOADEaebfMSI3ML
	Lrv1orNV0HxoD/yTFzW+L4UbFspdx3im5Qta2fCdrnUUJhrK8lRQMm7h4d7nmzzt
	PZmGcu2qAhqQb+Ec2LE2NKqG5s+U96AqUAh0UOIU3drWLmBdL2nTUqbR6AlRjSNI
	I1QMI3fWUDPq+1W+7Cy507fB6vtEHg+Qd2FeDMTCKJ+pnIeaEfV3RMfKriTOA5gU
	VZHj3E9Gg9xkVLCZ5IXGw==
X-ME-Sender: <xms:NB-SaDns9H34jC5yhvjLh_fMDmO8PTkEOHRlPiP5wfpOacLWPOJMKQ>
    <xme:NB-SaDufLWemJL5JiA9fRgAHkJD8hC3ws2sx7YzYF27QsvSHRc41E03vy9qN5EO3g
    h2ecUOEJeJnKOs1Fw>
X-ME-Received: <xmr:NB-SaJaDbO1RzilpLIZ6I_2qfE4MXdHy8DQrnTWAaKpPjzhpc2Ay_yobXFfURU0UyAPFYERvKdY-l7s12g6AYCqo1Q3mOYHqKX85qwmyBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrh
    druggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtgho
    mhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NB-SaLD6NHnS9su-yk3QnUBxW_v4wcapZlYT3CF8uyL8GfsW-Tdyjw>
    <xmx:NB-SaB-TqgA6ZTdBR8F_KPsjo2_3mdtLUtSKdYgBgOVUK4MkisA_6Q>
    <xmx:NB-SaHR6adQFX3JIxt2hR0-KcUdfCq3_x3CiOtQVvInAqZvCuLYepw>
    <xmx:NB-SaFVCqScw9bMxvo9MQmjJ_EYOQxIZnJ2p32dv8-hmQPnzOrf6bg>
    <xmx:NB-SaMBj9xasy7IM4kgscXzq2pPIlEnabNy8bT0tMBrUq3gLCs0WOIqX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:11:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a8ebfb9a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 15:11:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 05 Aug 2025 17:11:31 +0200
Subject: [PATCH v5 1/9] Documentation/git-reflog: convert to use synopsis
 type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-pks-reflog-append-v5-1-050997db09d5@pks.im>
References: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
In-Reply-To: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

With 974cdca345c (doc: introduce a synopsis typesetting, 2024-09-24) we
have introduced a new synopsis type that simplifies the rules for
typesetting a command's synopsis. Convert the git-reflog(1)
documentation to use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-reflog.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 412f06b8fe..707a9b39ed 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -8,16 +8,16 @@ git-reflog - Manage reflog information
 
 SYNOPSIS
 --------
-[verse]
-'git reflog' [show] [<log-options>] [<ref>]
-'git reflog list'
-'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
+[synopsis]
+git reflog [show] [<log-options>] [<ref>]
+git reflog list
+git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
-'git reflog delete' [--rewrite] [--updateref]
+git reflog delete [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
-'git reflog drop' [--all [--single-worktree] | <refs>...]
-'git reflog exists' <ref>
+git reflog drop [--all [--single-worktree] | <refs>...]
+git reflog exists <ref>
 
 DESCRIPTION
 -----------

-- 
2.50.1.723.g3e08bea96f.dirty

