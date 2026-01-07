Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC663326943
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780627; cv=none; b=tqc5S3UpY0we/1/kCH8oD3WuTxzHpPyXaMjzr/ULxvPoDfTnO3zE0KfmoOmu9B3Gv5sqSaqVuP2cNImTbQjwcI+JlKYaCSgYcgshCdADWTJzjQBo8SaBJx7xpyc+BYv48OMn+qULZdZxj1Xg2/Q4i+9o3hxV+AQQsUm0AivWBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780627; c=relaxed/simple;
	bh=7ocGOhDgW2MeZe/zb7KwlwQKxE0D8FULIJbYo6xGHTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVfs/crNoqrcSQt4MZ1pKGtpn5cjmB4G1UrjaraZAG9vLqGIlJV4krCgSj1jxbgsfFSJEHTRPW5UmeK2m7lqCymHsC8CkNJF5ItjTLgQBiC3jDh0XdLZD1czyzqmY7ZXaoJ1Adhvt8eOc6ImV9x9kpv99afMySnhitmfl+XlXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wr0O0qN5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UED3S9xo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wr0O0qN5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UED3S9xo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D8BC140010B;
	Wed,  7 Jan 2026 05:10:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 05:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767780625;
	 x=1767867025; bh=trDc4evtWfD6JxddiD58lkgrzZoK01J5RsrlX/54MTk=; b=
	Wr0O0qN5v5UgLq4/I/QY1DaNnbt5cqdMmap95EBZG6z+jX923G8f1E6wqLfLQpD8
	fENOXZjfD9+TXngDuYNuuGgVi2ji2xyKcqSLmq0FW4cK+4EYUSBUJk/t/Grv4owV
	wlPWsOP5m5QjiZ+wr2ZHWPvKrfPu6GUMbXDteK2W0zfQ0FjIq7bQf93LuhEQrT9T
	v8JrVrI2/8iG/xWuSHVeJy7+0k9heVAe+aexrbU3Ph3ZoUh1nfrZOAlomnZu/vqz
	EMr2sa60gCvu8Y+cAiCUXRl3/2g3C+r8AEGoM6Up4f4IaXUvaRQeFrH0w/3c6+tn
	3kd5tM+c1s4xWvCc9y2Qig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767780625; x=
	1767867025; bh=trDc4evtWfD6JxddiD58lkgrzZoK01J5RsrlX/54MTk=; b=U
	ED3S9xotKGAeYUcb5TYlv8UYUMgA/8QunkVfjxKpiL16hSSVXvHC87Tm5rN+l2sc
	IXPPvgw+GDkgufKM43UxIJ0HI3z6DO4UvBAzglVz4OJqeaBfTQsYAXY5UxtskqZr
	GALzmIbvQLvGpVp1o8lM74Amhy5apeV4IR2ysr/DvsIUOJ6xE7uI+uO/CDFKvwqJ
	cujoJTHR//F5J+SLct+KD/yGJQvRNHk95Jj0vguWb9e3d5WA1VaG+aehp4f/pJ/s
	VcWWjmpe86p4qnaJ+ChwgrioPOeuC360fmEjw4hwQ3OA2cN40ugp0v3q/MiCkSkb
	YKOVn7MUYq0Ll5/SGhvXQ==
X-ME-Sender: <xms:EDFeaVuF474nSxFPiMCnFob5MBzER3_iW2DlXu6G_oZ9GS_K5icBLg>
    <xme:EDFeaaT0xEeu_pg9HwvcRsyn5LFgdU4WGpK1JBlDGmz-wkibZuPD43z_ezo_0mY4o
    r5h3m9dTz-C8gliZOKohB0VRq3md3HVBk1a8uL9DiLHdba-m-gN>
X-ME-Received: <xmr:EDFeaUK7KApabS4PKAa0eA9T4mdb0yHFTBIcc40G6L8MXop8GRera3T8JaTLOn3c41W_LiWdtwYYr5oyBLprek8mECPLbVUPJsbZqgG68v0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrihhlsegsvgih
    vghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:EDFeaVtEG_v3TzTuBN4RjHSUynqnYDMOis04f04D3vNV5ZDo8tMBEQ>
    <xmx:EDFeaT9zdJ4QyZfEVWBUhgA9ZfsgJfn4xGM5pFijz4YBVE7GVmjnEA>
    <xmx:EDFeaX19MiJfdJkKX2Of0O0txvPTap-SMnnSygA2920bgHLGIY17Iw>
    <xmx:EDFeaQjKEstoZXf8SmEL6elfmFYK48LMWJYeaF-IRlz4mj4hILlLGg>
    <xmx:ETFeaWtMmLfTAB-M_etsVEz5nzL_nqE7tuPQ8vU8L0B7WGQU6qx_BrCs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:10:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a3a300d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:10:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 11:10:11 +0100
Subject: [PATCH v8 3/7] replay: small set of cleanups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-history-builtin-v8-3-18e9779e3a26@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
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

Perform a small set of cleanups so that the "replay" logic compiles with
"-Wsign-compare" and doesn't use `the_repository` anymore. Note that
there are still some implicit dependencies on `the_repository`, e.g.
because we use `get_commit_output_encoding()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/replay.c b/replay.c
index 1926fca4b9..367951395a 100644
--- a/replay.c
+++ b/replay.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -79,7 +78,7 @@ static struct commit *create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
+	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);
@@ -91,16 +90,14 @@ struct ref_info {
 	struct commit *onto;
 	struct strset positive_refs;
 	struct strset negative_refs;
-	int positive_refexprs;
-	int negative_refexprs;
+	size_t positive_refexprs;
+	size_t negative_refexprs;
 };
 
 static void get_ref_information(struct repository *repo,
 				struct rev_cmdline_info *cmd_info,
 				struct ref_info *ref_info)
 {
-	int i;
-
 	ref_info->onto = NULL;
 	strset_init(&ref_info->positive_refs);
 	strset_init(&ref_info->negative_refs);
@@ -122,7 +119,7 @@ static void get_ref_information(struct repository *repo,
 	 * the second because they'd likely just be replaying commits on top
 	 * of the same commit and not making any difference.
 	 */
-	for (i = 0; i < cmd_info->nr; i++) {
+	for (size_t i = 0; i < cmd_info->nr; i++) {
 		struct rev_cmdline_entry *e = cmd_info->rev + i;
 		struct object_id oid;
 		const char *refexpr = e->name;

-- 
2.52.0.542.g9473a8513b.dirty

