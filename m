Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AED17F7
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109991; cv=none; b=EG6cNrP6pQy0frA6im4bnMjc8IUQE6YC49cHx/s1hEP/PqyG2kxNdf9v+gkiu2Rl41fUfhTlngDRH3GJUSiYA+4HLL9WFmh/dTSiaWsTWs5LiJvRY90I1oWGl7m+dnFRwLJDkCuPut60QIOQcAUAPBH7+krPNiqGmSAi3RQ8wSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109991; c=relaxed/simple;
	bh=nRu4MQL8qbE6xcL4XvtXwDfHMPsLmET8gK5nOMjKgIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRSlEfjfEQn74zu1cH58e5cSelJ+P5Scw64dde4jnMczHJtBws9nW2NoDIrFrQSc2arMSW6QxXGo9mgMnQyXEF14kFBa6AHIfxKmwwlzOqGjDU1qVt5IyD4TetlpPLPwwvBq8yD7Q4SxA/khiqwq7LsRbpU5q4yg919GK7YiphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wzlHP7l6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R9Na+uZb; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wzlHP7l6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R9Na+uZb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 104A613803AF;
	Wed, 20 Nov 2024 08:39:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 08:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109989;
	 x=1732196389; bh=5V+ROl0X931gprocLhFyR5sK8ZvuGIMMqKPGAR+YYqc=; b=
	wzlHP7l6qqeQnJfM5vTsW+fNg0C5D2Nbph8X3DJ4Tu869QiACAR3j+Uo60gMNwsy
	ZnS/Zv/fHt45EIXSigplCAd/2c+eV1lXk9n9I2pq55JsBKg7cQq4v9zIYu7HSP02
	K5c7Zl7xiXA6KGNl2ye77V1I4u9pArnvSBhGEbnnW/94ihqFVlJbwLKxXKX7njC0
	9SWZ7zBL+gFwxFCDKzkyLrmS0LGDQbto4JwlPphLeoreQ76fe8Z/CzAlO5U4513y
	t34gA5zHic2TUdFNtSt6oyX2L1Lc1BMmbR+Zlj7QXA8DO564S7t9p2PgXRAN7+hh
	jDS+muDYc6eweADZDnCY9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109989; x=
	1732196389; bh=5V+ROl0X931gprocLhFyR5sK8ZvuGIMMqKPGAR+YYqc=; b=R
	9Na+uZbgk+g4bMgL6lPdM8ZoVXH1J/2iwb28KdYZ6VXjHux14NWg42pt12Bwu+Dw
	GfsAzXs+30YYUyR3afGrfmV2iJzJGW5MZnPocj8RNPvCPlIC29zidMGggzarb74G
	lKUcOxNtm8jCw1hsUrWHI8uryIbKIi1sKRetVbS58X2EGSersZnO0Ymun25lD4We
	bP8yaGkkiYPO4AOyzVB457kNf7SYAqRUKJ8N539wp21LBVYHDymXnvM/elzoYpxe
	T4c481r/p3FWH3aL5CQhuL2xkfHDyunNjdrMJaGIpmfVy9USfyAdQpQd0Ou8oToc
	J6zfZEsuhZ5IgrcWWokBA==
X-ME-Sender: <xms:pOY9Z5XSAmCJWQ9fRHBPRSLXcJrSPqcWCN-iHF8R22_DsDW1G6Hjiw>
    <xme:pOY9Z5mjtwkeNB1gGwN-Ze6espzGk5tTA0vaNT71EYeB8xZTxwnKzY6rlDnK6TdK2
    te_EfnsMLKUo5Z3Cw>
X-ME-Received: <xmr:pOY9Z1Z2mJZSrzpsfWzpr3Vps41K6PbSLsXwFP-kQcWZC2fpblSIe5t4xL-J7zrB4nLhEyllMVWCTNuYuUE6FDL0IkCNJF-tHQDVb7_nsQsJcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pOY9Z8USZwkke1eUdPn4qNmWpYnC9bBqmiSxFXGPH6x_s1b1bV485A>
    <xmx:pOY9ZznAn_stDwmEKpx6eiuHYRTuZz0DABY-pKRH0zpbL10ZdhMlSw>
    <xmx:pOY9Z5eqKs3b1bBZxLoXolyHN_AWoFgy1lT7TR-fWufIdvnFDhnUxw>
    <xmx:pOY9Z9HdP1gYyC3rtFjR5ThezpbrKGchvFtvLpqVLIhFTQpijExwMA>
    <xmx:peY9Z8D1Jj6ICaXk5GgV3Coe9BeteuxCsMKLgmLBJMrm4Qf_tWgKRV1Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 89a6826a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:38:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:30 +0100
Subject: [PATCH v3 01/27] builtin/blame: fix leaking blame entries with
 `--incremental`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-1-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

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
index 90633380cd583b689693e6cfe65c26a79448b00d..bf69768a7de6d2b989b85339a06af0a4763db4ad 100644
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
index 5b4e47d44c613e31fc4788c12ee9d8dc2a49d571..3b34be0e5c6932666bf5f738eb645da25adc0997 100644
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
index e407a22da3bacf6bd26a6738e0ab0292ffadc216..6a7bb3b07248fbdfeb5ac3a05fed20fff4989a48 100644
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
index 7a1f581c240c71106c709a830d3897d84fd8b32d..fa765aff99aa7fbfc4737cc91aab2a6a1bce30bb 100755
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
2.47.0.274.g962d0b743d.dirty

