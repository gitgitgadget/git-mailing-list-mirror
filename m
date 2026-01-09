Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21D350A26
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947757; cv=none; b=qb5aImLmgnv52ny0lxllW2R+zGefLYG9/dIw91Esmig2BiPJRNDHU1atosQprT4GEvVUdOeMjoGIQRoVDXcooEDxJa44T/hVDA7RyzVTb95it8dkkRLwcZ95xhHmLAgRQEQXNTMJ9TOMrC++92Zx0XqOItJRIluqbRoPq90eqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947757; c=relaxed/simple;
	bh=FWbAYy8nAHaCZ0pEf4LT+xM5lJqZmCPGOcKZP3Cd0hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aykzR0KE6sqPs5ccbcS+THcnO5CKZRF1LFGjFuaQSejndLyJjYZN6RFGcUWoSUYSoC3CKOM4YfaSvmMbJSK4RBJgv2dQe33gfIWMfzkGDu9RsTzzGaQaL/z5xvIgX3GrPKZAI5N/rIcgzpjhW0lYjvLoTTeIwJHQLWyQkN9hBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PxyPxOju; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o42zVrxN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PxyPxOju";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o42zVrxN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5ABD140005B;
	Fri,  9 Jan 2026 03:35:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 03:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947753;
	 x=1768034153; bh=EDsQMeqO2wYue8rDI4Z8vssyNeGxOxlm284pRV1ibes=; b=
	PxyPxOju9OwKea2MRJ2xCnngpuMFUP29cNKGBBLlCrmclPXD71XZiywtDwhCbSZ7
	AkeEAYD/7AEr28usudR5xi7+6hzTU7OIRBCQwrOjF9EKy/z17PZMfWpvCtRFjNlE
	KtDhkw6K0Ohfq48ZmJk3+i4cFaxqKzxTI6y3mCLKHs7DwA/V260ZX4ekZRcca+EY
	wQsKJ3pV9S5H76XrcBB1hQC6C59PUyyluIBP8h3NFgQghY7OptF84epq186LJLus
	1fxuRfSYLsJ1wgFWzfIoSgBsXdz44nAxRssEBflsKJ6Ivv4I9WZCQqAKefK4efNC
	UBD6MvtocTGoKjPb7FDldQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947753; x=
	1768034153; bh=EDsQMeqO2wYue8rDI4Z8vssyNeGxOxlm284pRV1ibes=; b=o
	42zVrxNOc9lA7gywql9pAHzljG6tpgfv4N1rZYxb6iXu4uRM+UH2/j5nqcQxGluJ
	AL9Zg1gwZjCuUYx7SG2ro04Jhqg6HvBl3+QA0YHRC9y2vk0IXdvEmHc1VAfjdOCX
	6sZddWQw8lvy3ArR5lCualmTENVkGcvBiG4wODnBWKWvgCnYbdYUgChVUV3oh1Q0
	JuDmrSdtE7oy4qsh+XvT1WdzBzh+PBW+R0hAJRXMSrMwhyvdEmBFJqEeNhTgAuzx
	paKiJa3bFpixFiPRz4BMn74DusWrafdIRVQINmNPWZb8nlqLJBCBwFVo6wiMwG5u
	d5qPSDG86qKCK83+x+D0g==
X-ME-Sender: <xms:6b1gaVk28LsqlbTNUmvpjx6wgYUS7BmaNPKzx7vYRF55yAhFIAn8UQ>
    <xme:6b1gacqEWNu3-7Z-yUIeUcpdirWAP_ahDpIGnRg_6yWaeHCMxj1F0r4CpT4ulmC2D
    OTPsmE43Wh4Cd-xED98f3BAL0f66Ry_HhE2qPbkUM-foa-k1Czy8g>
X-ME-Received: <xmr:6b1gaXA_h0qixQFB-Un7KO_68Voycb11DMdCnkn-pVTZNSKCNMFecBTS03UukAyyyvwuS0Nh3Gchero9jQ_ZHSuva1lTZTvixUvo2pnlcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehsoh
    hrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniies
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepshiivgguvghr
    rdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:6b1gafHfggzIJn0681VsxaPgE0GYKxVjtNyUzTCGcT4D1xZREEg0TQ>
    <xmx:6b1gaR12op-87hYuIvR1QpmajrXKcPfBPVBr6vKyEKPOtMPoqidw2g>
    <xmx:6b1gaQMqBSL6o1YA3OzloYdUb4Nplefd9ReWlBSALYD6BkNmQgKGbw>
    <xmx:6b1gaRajTj5efAm-D8LP62YnIoL_0iJ2loPFEtZNRj-iwuoK0FCBow>
    <xmx:6b1gaQkCm8ySnmFY6EC0L59nH2mV6UuAAwq0GtpQcytbGJteJVDq8wMG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:35:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57b14fac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:35:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:35:39 +0100
Subject: [PATCH v9 4/7] replay: yield the object ID of the final rewritten
 commit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-history-builtin-v9-4-8766101814c6@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
In-Reply-To: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

In a subsequent commit we'll introduce a new git-history(1) command that
uses the replay machinery to rewrite commits. One of its supported modes
will only want to update the "HEAD" reference, but that is not currently
supported by the replay machinery.

Allow implementing this use case by exposing a `final_oid` field for the
reference updates. This field will be set to the last commit that was
rewritten, which is sufficient information for us to implement this mode
in git-history(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c |  2 ++
 replay.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/replay.c b/replay.c
index 313fb2a768..20560e792b 100644
--- a/replay.c
+++ b/replay.c
@@ -338,6 +338,8 @@ int replay_revisions(struct repository *repo, struct rev_info *revs,
 					   &onto->object.oid,
 					   &last_commit->object.oid);
 
+	out->final_oid = last_commit->object.oid;
+
 	ret = 0;
 
 out:
diff --git a/replay.h b/replay.h
index 84bc8a7a5b..f8f9889112 100644
--- a/replay.h
+++ b/replay.h
@@ -46,6 +46,22 @@ struct replay_result {
 
 	/* Set to true in case the replay failed with a merge conflict. */
 	bool merge_conflict;
+
+	/*
+	 * The final object ID that was rewritten. Note that this field has
+	 * somewhat special semantics and may or may not be what you want:
+	 *
+	 *   - If no commits were rewritten it will remain uninitialized.
+	 *
+	 *   - If a thicket of branches is rewritten it is undefined in which
+	 *     order those branches will be rewritten, and thus the final object
+	 *     ID may point to a different commit than you'd expect.
+	 *
+	 * That being said, this field can still be useful when you know that
+	 * you only replay a single strand of commits. In that case, the final
+	 * commit will point to the tip of the rewritten strand of commits.
+	 */
+	struct object_id final_oid;
 };
 
 void replay_result_release(struct replay_result *result);

-- 
2.52.0.542.g9473a8513b.dirty

