Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9C15B554
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321531; cv=none; b=AQM92hAJC0GqCE1ayIzMrRg7vDAWw5akk4Bsrv7/w3E23VwFhKFuiS/5cCbfHsaXxM1lf1mJcHSprpeqOwCCRWWFvXVodYGAEVls1aeVM2tdvHda4QCYvkImIsnQHSGG05sc+OY4xuhtoFmSBbtIVHXzn364Bi72NLpRafNQHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321531; c=relaxed/simple;
	bh=ly+eOXAkODhvN6tv6GAk4l1iDmyIBduAlm1S8cjy9Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThwRxL5FfdP1l6t7gBDoCzhTx8bfh6d0As/DrotFIaTG4F4CpUiDHzCfWkw+Qqt+px4ZCQzAW8w9//jntENlk+zKbGAlo+46+H+amUxSieIsG+H8pYnXvw/9BndUR5bdfqWI4KN1itcumgR48WPfracA9L+/I36VNaC0g6w1MDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fQOWl0c8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VlIDOJH6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fQOWl0c8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlIDOJH6"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15FBA114010D;
	Mon, 11 Nov 2024 05:38:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 05:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321529;
	 x=1731407929; bh=nxt2WpzGZ7nLQLyMMr2hROFkLq2LfmU7Q1xmh9W9Zvc=; b=
	fQOWl0c8SrVRoS6/KSTz5TNqldbcZwY3ES5ZeRtt980Yrpj6f5oQvAIOoJGxkIiO
	uar72v9ayt3ucyZ3BMhCKx6PRQPkRyQDLB1aDSF4KFdG+0QMpK3SJ4DhugTZTcwX
	F5hfDb2/BGVKN0tXCCd8ppZ0KylimR2s9kY6yITfrX4YUDKeXA96TIQoLpp3UTDh
	j2i30YKRoqoAIgFYw6qnp5vS50JgGYZSe3rDgLXJjt6g8w6vr+t5GQNNr558gaWA
	Bq2BHCVpMxomYLwVwQz9HPDz7p/pQoVT48Op/mLC8VFGISXIyIj0xLF9/9+iXfo6
	R71oyYAyKrWpJoMGUXNBTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321529; x=
	1731407929; bh=nxt2WpzGZ7nLQLyMMr2hROFkLq2LfmU7Q1xmh9W9Zvc=; b=V
	lIDOJH6JxTiIdoIKIZFD8j0fKw7/MFSnVi1VcHU8sckXv/vva9sv3H1QAFNmuD1U
	whUPRrfzad1fCbY0vmszdQyL/87pp75OzhqlDS89hdb4dGuNKpTARXSeIWBTeHtf
	lvOXAAD0v/yKtnWne9B59EdmJcF0L6JTOj1EAEIpdk8NyD7lePgqNBO8/IcMmvGp
	XiI8OgDfrtAobzFKgMKX70egUBfkEGanfpq84WzYL2/iukskinpWz5dIfggZq1CY
	RvJFIXRfLvBCfHQ8lldTNWOIh9xA7iSe3Z70rycC4TZaaonLgPlBA0EQYq2FtaAS
	+y0hfUn/L0KqBxDzs96tg==
X-ME-Sender: <xms:uN4xZ2VOz_sQwlZV_1PoT8DkD6Jr3IQm5g3DF7Z-NY678Ek6GG5roA>
    <xme:uN4xZyk7xZq3mZkjIAQG5-tFN20410zlkKVkjcPwbSucBmJ0tcWDwlalYzHn0lWk8
    Yw57XkQF30CzEZ_aA>
X-ME-Received: <xmr:uN4xZ6ZeTShJBrn5PAm2ku66gd_syMYMKcUvmLC2kSiduGusMKvaXH_jZ_TJoNv6lQcNFnQvJXb6lM-LcCIAfVl31QAgIVLxfgJe9DVfs01ETPZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uN4xZ9Xc5SXxnlRECCuSdtVY00mKLwwuS_cGlnCvteYyolKNOdlzpQ>
    <xmx:uN4xZwkp5i0-8b6i1PLyT_LwuxuxPs7w0-SuhVQDQ_Yxn7jR0ikriA>
    <xmx:uN4xZycrEHer9fUCRTodxyrn1Kmbe526NfebMQVYkpUoJB1UW0D41g>
    <xmx:uN4xZyH7OEU3kNfawEma_72qyppiTo9bPTl33986IJWA2tYJemGHHg>
    <xmx:ud4xZ1zuPyDkXT2Dc2jaZf9Cw4H5Lox3eNvp1vhnQuAcMrWWFfAgpwv4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 082c0434 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:30 +0100
Subject: [PATCH v2 01/27] builtin/blame: fix leaking blame entries with
 `--incremental`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-1-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
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
2.47.0.229.g8f8d6eee53.dirty

