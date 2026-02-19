Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E92F1FFE
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482337; cv=none; b=kbyTNzIiEdoH5qpCGfctNkUXk/6U+IMJpxv/Vt9PbQFvTriRvF//4tWCxzk6XnRO2l3PeJ6UXboXrTBH5VxF9s7GKY0tFs/ts6bwpH2oPE4mc6SNYoqAL415zS9pFNZoQxfsLW4DmV4Wj662okxI3VmAlnydJe9j2I0FCIhZMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482337; c=relaxed/simple;
	bh=1XWA8oKtnXweGqe+P91lfLTYQtIZAcGILC8JqFuPa50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NekVALIwGgT/I1HyyEWAZX3WqasHRh9tpeQmkmCxRyjgPGKod/tWejh4n5Ss8dDpNgSZ/8QrU6W1VHGddjnw/xdsHFfs4gHApsa0oFajsj/DkvV5k6f0c7U75s+bs8zj3y6qJ+7+A8CM6HorvoIb1kQG8qm4UY+yIZZjtzzh7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ck8UOyol; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ATmYYVpm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ck8UOyol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATmYYVpm"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9165214001CA;
	Thu, 19 Feb 2026 01:25:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 19 Feb 2026 01:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771482335;
	 x=1771568735; bh=eGBqi+P8RvC8CnlTGoDo5rayMxj3MdS6I6wdH/PkTBY=; b=
	Ck8UOyol6bFfNWEoCFYYP5APn9qHDgOazZfaBXVTne8/NHJxpLwOwYU/JU772Osb
	TVOSXdNM+CCLga2yIrtEinKj+/aWU2ApVVfFipGEqKmnxjEJ+Zi/kR8zPzRiNbE6
	3EizWCAzN2ONJF3YSmYQ+CsvaIAcwtoMPnjCxJLZIbelKKWQ6d1psLn7rMLUqkS8
	g3NumGO/8xH+ZzL3cCgMZOERsP6fxyMOZbISuUPu1HPOKXkCgPLpWf0T2XVw+SSN
	G3QdP1PgxCS2SjBe8KGQ0r/7slqsMlDjzL3LFezJ9UjYRRuWHuNE49EQpRt7/wK7
	0UOS4xnWrWuXNQk6mcFmTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771482335; x=
	1771568735; bh=eGBqi+P8RvC8CnlTGoDo5rayMxj3MdS6I6wdH/PkTBY=; b=A
	TmYYVpmuApmqHbQvxIxceOjfFy+0oi1aO3w+Ya7OiIluNTWbpA/8Nuv2StM7LxSC
	lOSePGxrf63Q+M0pSU1KVQOPyPvkvskME0cvKLZ9FBrPuc98x6n7R608HXfRByBJ
	9XI2ofyw+hQ+S/3PjhAa4NYszSJyTOUpMXRZkLE7u+6JV1YNXWmneaBEdExEq3VW
	wvpPQp8dvSb40wlXe0WTM9MPA6rI0jF/iRgJHN71M/vHQoj9VNbzTRJxkcGQ8SCm
	GWdBQdreQxwVcugtvSEkNybmd3VjwD9/aF7FG1ZSznLq8HuHFQeBQJw5k3EVHRzD
	a+Q6CrGi9iZXGJB3nl/SA==
X-ME-Sender: <xms:36yWaVaGs5QEOEjuPJTRww5X24A94TVtHOD714g8drijEZ5tDwJl-Q>
    <xme:36yWaTRdliFHrh1YBTXWZOaeg8vxNNcSnwFjAFvM6taZ15kXOsBmYk78B-swQTC_-
    4_uNZdIz504ZGyaUMT2-019NnV3iLAn1BPawZPwiLLNG9xemr9Y6g>
X-ME-Received: <xmr:36yWaQT6xAseERlNvPnV19-l4XgO_uZ9maZRFJPnHCrk0flAPh2iIfGDbV4kDXp0An-X65SkDDaZU3KI1UIEh18QTZzGFJ55IiQxCiKTXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:36yWafQ1z3TU3YPm-SWvinZYq-ggljOKhy9NSpllMEz_QjoyLLfq-Q>
    <xmx:36yWad7tuHCxxdfQU1jMcYGwsF-Fm24AmnKBKcvUfJhUvdItEdhKbQ>
    <xmx:36yWaT0VF_WBxjSzoAa0MEbZ_AGxS3_nmqTb0kiy4iZvh0Y6ko1dow>
    <xmx:36yWaQAhXui4WI3TVNgybsyuYksN0Kd57Qgs6x0X2WwAO2NAzrX86w>
    <xmx:36yWaSu75leUuzXoDW66QkmeX5kcyBpUcDKBMxwST18cQz-m6y0GqQh1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 01:25:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dfc43193 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 06:25:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 07:25:27 +0100
Subject: [PATCH v2 1/7] ci: handle failures of test-slice helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-ci-meson-improvements-v2-1-6047b8307ab2@pks.im>
References: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
In-Reply-To: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

The "run-test-slice.sh" script executes the test helper to slice up
tests passed to it. As the execution is part of a pipe though, we end up
ignoring any potential error code returned by the helper.

Make the code more robust by storing the tests in a variable first so
that we can split up the pipeline.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-test-slice.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index 0444c79c02..ff948e397f 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -5,9 +5,9 @@
 
 . ${0%/*}/lib.sh
 
-group "Run tests" make --quiet -C t T="$(cd t &&
-	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
-	tr '\n' ' ')" ||
+TESTS=$(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh)
+
+group "Run tests" make --quiet -C t T="$(echo "$TESTS" | tr '\n' ' ')" ||
 handle_failed_tests
 
 # We only have one unit test at the moment, so run it in the first slice

-- 
2.53.0.414.gf7e9f6c205.dirty

