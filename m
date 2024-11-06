Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888A18F2D8
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905833; cv=none; b=NWwRxfWpuHvLakr3fLAkZqbwHKOC7NpPEFL8yCCuFNBwlK8UNk/QWsIrwHk3bG8Kng7eAqW6EFIpBwhBWz5n3Uq1E7qaLtmx7nXXOSj1z0A0O6rLdCdQ6/5TzyI29QzI0VSFz37LCGVI3VZpUcduNhjiGMHbwjVxfwznLHTul/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905833; c=relaxed/simple;
	bh=/Crwwua3d4IqUX12EeCmeZijnxx+Ls9HfSyx/wGjRgM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhEpEBTW9Cisa5E/uj2XweHI1onfwQ0+Tdp7v4xNGZAEDF2Hwjo34cw183XuDMn9qqeV/bxLlJeGd+byWi+A7uPzUZCmvQEPx3Eq3ggdAiyNO0mIen6+RMMw9oN/TaYzZuCZzUkbeDTDVfQCL6BcDaLZ9MtTRhY0Vt/RMv+/+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A+/0S+px; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fXQh/jeJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A+/0S+px";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fXQh/jeJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD2921140165
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 06 Nov 2024 10:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905829; x=1730992229; bh=GXmMGGoUpR
	vJWxybh+Md8oLLTNf+UAiaWAhDHpqHRrE=; b=A+/0S+pxOx2Ir3XCU9w65kKYE+
	IsxIN3WFxi/igWSxP38uKcUZb4jC+qVNHar3HQ01zEjslxHPlDepM/Ri2kb0RB64
	RXPdhG6fRc0JKh1eBjehClyQK3a/dYxKsGyZFHaXdUWH9BoPdS3DdeMzRnP9n9/j
	m7SxcQTOlr7JhE1lPbitOLigNnOg+mucN0uAGHXGlbowr77GnzyPMX52dv/OXLps
	TuzPk+h3S2mGMGJRROfqLgVBPf7ui/5p/jumOIMgJRtp9MhF6DI07vEvL9hq0EQF
	iFfr/PJ9LLfdbrVkZGhnpEpCvjGm6cCKv22akNA++TZBuw1JR7F+MUkxPsFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905829; x=1730992229; bh=GXmMGGoUpRvJWxybh+Md8oLLTNf+UAiaWAh
	DHpqHRrE=; b=fXQh/jeJ8X16XE8aLV3nYsEAM/eUHMOS+PSfUMxSBFU8sMTmYxK
	6637KCaXMywZWGEtWMMprJhX/yR2PdJE2xAkqbXZXUBmtDysSPDtGhtz0Ec2cChq
	YkrXJp/PxkUkqW26ldLeZ43ng5NbftfIBuKGnBqU4qwpMoTHop94ZKFGm8NqCR7+
	w9X7MFgWRDcO9oiyn13kqj7YEsJKKyv4zDoeH+B11emRkl1wqD9TyUtQC8XCyqSB
	jBMmj3GMjRJ7qhg5Fh88QGTwvJ/YwyQPmxrvTzE0fKStzTnWKC+PcnVUy/f8d1Kg
	/dfF2dSwBrFjs96Taj4dUvbqgMnSIT0BoGg==
X-ME-Sender: <xms:5YYrZ9rPbm-MGO_dvzJCyQTdxBYDfO6s3iDjDTbWeej3ASR1sjQdrA>
    <xme:5YYrZ_p32vEe3bjb5isupE6m8YC-vSxnShxNLR-hM2cjJdEtsEF3UyylfdnWGAH4A
    qR2fA8OWs_24RrIOg>
X-ME-Received: <xmr:5YYrZ6MJqJ_1JWgNVLLmfJFU3vfgvvzidFVEnjrqpq39NxnlldRM0tsZdpYe4c3kdHec6_a-51FwhR5XdBou1pppFrQzE3HCoISsWHDFUon_Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5YYrZ474W3TIibDySAnw4WmPubKnueRetPsEy-rnubUHg0zCSc3IHQ>
    <xmx:5YYrZ84spK-ZLP4KVBrLqxjy1OHTwRAN8crFQj7YAohMabvmwz9O3A>
    <xmx:5YYrZwjE9rtMfWYK4-L_s01l0Fg5NEht8VNJmgwfYh8_6FKy3cTMVA>
    <xmx:5YYrZ-44LtbC8L2J7lIW_FxLRjGo1qaD4qp9HV2lESi0t8eRa3fYBw>
    <xmx:5YYrZ6RHGFmmAJnpcPyBFw85NiVsxE9ZZpIEzjGHmvhG4kqX7_eBYbZy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56d6920a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:03 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/26] builtin/blame: fix leaking blame entries with
 `--incremental`
Message-ID: <732dc6642aa040455f8b5c73fee3417da524e0c8.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

When passing `--incremental` to git-blame(1) we exit early by jumping to
the `cleanup` label. But some of the cleanups we perform are handled
between the `goto` and its label, and thus we leak the data.

Move the cleanups after the `cleanup` label. While at it, move the logic
to free the scoreboard's `final_buf` into `cleanup_scoreboard()` and
drop its `const` declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c               |  1 +
 blame.h               |  2 +-
 builtin/blame.c       | 12 ++++++------
 t/t8005-blame-i18n.sh |  2 ++
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/blame.c b/blame.c
index 90633380cd5..bf69768a7de 100644
--- a/blame.c
+++ b/blame.c
@@ -2931,6 +2931,7 @@ void setup_blame_bloom_data(struct blame_scoreboard *sb)
 void cleanup_scoreboard(struct blame_scoreboard *sb)
 {
 	free(sb->lineno);
+	free(sb->final_buf);
 	clear_prio_queue(&sb->commits);
 	oidset_clear(&sb->ignore_list);
 
diff --git a/blame.h b/blame.h
index 5b4e47d44c6..3b34be0e5c6 100644
--- a/blame.h
+++ b/blame.h
@@ -116,7 +116,7 @@ struct blame_scoreboard {
 	 * Used by many functions to obtain contents of the nth line,
 	 * indexed with scoreboard.lineno[blame_entry.lno].
 	 */
-	const char *final_buf;
+	char *final_buf;
 	unsigned long final_buf_size;
 
 	/* linked list of blames */
diff --git a/builtin/blame.c b/builtin/blame.c
index e407a22da3b..6a7bb3b0724 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1216,12 +1216,6 @@ int cmd_blame(int argc,
 		output_option &= ~(OUTPUT_COLOR_LINE | OUTPUT_SHOW_AGE_WITH_COLOR);
 
 	output(&sb, output_option);
-	free((void *)sb.final_buf);
-	for (ent = sb.ent; ent; ) {
-		struct blame_entry *e = ent->next;
-		free(ent);
-		ent = e;
-	}
 
 	if (show_stats) {
 		printf("num read blob: %d\n", sb.num_read_blob);
@@ -1230,6 +1224,12 @@ int cmd_blame(int argc,
 	}
 
 cleanup:
+	for (ent = sb.ent; ent; ) {
+		struct blame_entry *e = ent->next;
+		free(ent);
+		ent = e;
+	}
+
 	free(path);
 	cleanup_scoreboard(&sb);
 	release_revisions(&revs);
diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 7a1f581c240..fa765aff99a 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git blame encoding conversion'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
-- 
2.47.0.229.g8f8d6eee53.dirty

