Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A92857EF
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218463; cv=none; b=uRHLW23gZTH1KA5K2OU7C9zsPEhuVoPY+oY4CuAo7y66DcsBtVEAUqyUjw3RbkDKRleot7auEuB6bVMr4BQUIBRDAsg1xPJGGAH1ww8rk33NCffcmI7W8xBjNyg+7J1qAmbrm9K8NZ7kksiOxihAYWMCWKL8Ol7KVMkpXeOOxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218463; c=relaxed/simple;
	bh=PUp7jGFU3iD2a72kqEBJ0si/hCEUiY1WS1hSwipuF5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sw50plXYhLXyZeUcpclIndb8HywFQztVJCGdF5aKnRapkn0I6h0H3mNCa1pqt9DZaSFtfFC5/iOq9H77bpuw4T2MH7caUHO5QH00jFxa97+tQTN504iHaro6Caz5IyEEcqRbCXB7sRPisDk9BwBpU5JLlD3caBFRbqwwTqEd7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G9e2uUzx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PB/3EvE3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G9e2uUzx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PB/3EvE3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B3789EC04ED;
	Mon,  8 Dec 2025 13:27:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 08 Dec 2025 13:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765218460;
	 x=1765304860; bh=nChRzL8Eq9vmv5tU26mnSujIhiaN9nmTmoNoMx6JFRs=; b=
	G9e2uUzxmGG5gaK+dBpG0vQEtONe6+NOfF0DYrsy26UoZMJVOw8ApyELorGnUKUH
	gIhxGJrWrmkz9+4RNHW1jrK36CWwhTGmRFRCuCknI97pcSZwBp6pY6ekn+XDQLf6
	LLrIWMndzknryWKzcEgAi+nAUDpfIwaMIYyydiZUXeO9OGNEedaPP9MoYIUB3uhI
	ONf5W8han0zWd2ISjExxMPfPLA1Z5PGzFPs2xrFHFZQzaC5rxwOjX8Ol56PxQJyP
	3HrdLt9kknkBWVz5z1gQXEMIhOITfV9Qlw8qzJ3RqfFxlbDIh1lNUuPRN1UTnlxE
	yr54bL/jgxGiwvqlVU0nkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765218460; x=
	1765304860; bh=nChRzL8Eq9vmv5tU26mnSujIhiaN9nmTmoNoMx6JFRs=; b=P
	B/3EvE3ry0dzUun43EzqKBwuH71hwsa2YAKSoLakXz1KZJedR6w545RlSv2ucbvj
	zYGqzoPWUZ9/icpWbPZDA3NffLMsJ86AQL2JDfRH3gp9oHf8FBQlB0VhUbo6lnVx
	MB9qGNKQCMCl/W3kL4FVnanYrbskRMcfl5yvFRYXG6w4l1IrJ/eA5J8iGEJ50BGs
	Uad0VqtieN3h4zFPjBBDoo1qS2tjug8thirPh4utN2DWFgKD3GglLq02mGnzlACj
	Jegi8Z+X/NBE1bZ+D3jCCG06HVqW7W6L9UcVARwH3b1yb1eEju/gnkqSIBwhaTHy
	2+DHhWqlTlgYCDKIWYqCA==
X-ME-Sender: <xms:nBg3aZ4FRtOguimRt4vMm0XXpIoI84xEapR6gTPIkO994ouzdtJ3Rw>
    <xme:nBg3aeVPVsEE1tZj60sxuIxcmVaXIztupPWBRV_yM0Ycc9dhyLcLd5Tq_DDwKXkDA
    TTcrQcKX75Q-2Dley76qIzQF5IjdDqiWPvzvSUWQF5nHm6GuYmaB6o>
X-ME-Received: <xmr:nBg3ad3KIU8WCkAuwlTHDs4_PfWfwZRKv-PSshO4QnIPn-f8DTYRx-6sLURifqXq8txB9xNQWmM65RxL8Emhg57yoagIcf30szBrha6y_2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:nBg3ab1xLKCH25PZG7LxrButFSstKn2pYJnJ55ayAAGeyAOIp8a57A>
    <xmx:nBg3aQ-3uUtAL2O5DnxSlsKGA89W41QF-1OaZ6tDrBCZSCd9pdrPtA>
    <xmx:nBg3aY3s7-atR6vKLGdUOwqIycN03S01MhZ8XVRd4e_NcwTlVq6ScQ>
    <xmx:nBg3ad9vfag5fMlW2C8y78avh2LF34OgmovzzHew64Z6e9ZMUvxWDA>
    <xmx:nBg3aXze6RpwhLd0s3knrBg44cTtZnYRptpOzZ689bbbCpduIKhAazCN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:27:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0f49078b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:27:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 19:27:14 +0100
Subject: [PATCH 1/2] midx: fix `BUG()` when getting preferred pack without
 a reverse index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-pks-skip-noop-rewrite-v1-1-430d52dba9f0@pks.im>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
In-Reply-To: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

The function `midx_preferred_pack()` returns the preferred pack for a
given multi-pack index. To compute the preferred pack we:

  1. Look up the position of the first object indexed by the multi-pack
     index.

  2. Convert this position from pseudo-pack order into MIDX order.

  3. We then look up pack that corresponds to this MIDX index.

This reliably returns the preferred pack given that all of its contained
objects will be up front in pseudo-pack order.

The second step that turns the pseudo-pack order into MIDX order
requires the reverse index though, which may not exist for example when
the MIDX does not have a bitmap. And in that case one may easily hit a
bug:

    BUG: ../pack-revindex.c:491: pack_pos_to_midx: reverse index not yet loaded

In theory, `midx_preferred_pack()` already knows to handle the case
where no reverse index exists, as it calls `load_midx_revindex()` before
calling into `midx_preferred_pack()`. But we only check for negative
return values there, even though the function returns a positive error
code in case the reverse index does not exist.

Fix the issue by testing for a non-zero return value instead, same as
all the other callers of this function already do. While at it, document
the return value of `load_midx_revindex()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c                      |  2 +-
 pack-revindex.h             |  3 ++-
 t/t5319-multi-pack-index.sh | 13 +++++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 24e1e72175..b681b18fc1 100644
--- a/midx.c
+++ b/midx.c
@@ -686,7 +686,7 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
 		uint32_t midx_pos;
-		if (load_midx_revindex(m) < 0) {
+		if (load_midx_revindex(m)) {
 			m->preferred_pack_idx = -2;
 			return -1;
 		}
diff --git a/pack-revindex.h b/pack-revindex.h
index 422c2487ae..0042892091 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -72,7 +72,8 @@ int verify_pack_revindex(struct packed_git *p);
  * multi-pack index by mmap-ing it and assigning pointers in the
  * multi_pack_index to point at it.
  *
- * A negative number is returned on error.
+ * A negative number is returned on error. A positive number is returned in
+ * case the multi-pack-index does not have a reverse index.
  */
 int load_midx_revindex(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 93f319a4b2..9492a9737b 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -350,7 +350,20 @@ test_expect_success 'preferred pack from existing MIDX without bitmaps' '
 		# the new MIDX
 		git multi-pack-index write --preferred-pack=pack-$pack.pack
 	)
+'
 
+test_expect_success 'preferred pack cannot be determined without bitmap' '
+	test_when_finished "rm -fr preferred-can-be-queried" &&
+	git init preferred-can-be-queried &&
+	(
+		cd preferred-can-be-queried &&
+		test_commit initial &&
+		git repack -Adl --write-midx --no-write-bitmap-index &&
+		test_must_fail test-tool read-midx --preferred-pack .git/objects 2>err &&
+		test_grep "could not determine MIDX preferred pack" err &&
+		git repack -Adl --write-midx --write-bitmap-index &&
+		test-tool read-midx --preferred-pack .git/objects
+	)
 '
 
 test_expect_success 'verify multi-pack-index success' '

-- 
2.52.0.270.g3f4935d65f.dirty

