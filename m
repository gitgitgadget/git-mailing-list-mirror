Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB5256C6D
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227440; cv=none; b=mH8Xhr7KEh825vJ41LFRQl2npUXz8FRDr6OjGwRdm25mZWLb6pHVAfaV3x0qLRnhWjAoM4nmUCu6tFsQi/PSDBCmMWw8uYCu5RE6e1dGKahKQZk1gmiJL5IQY/dyxmfjdnxOqe7VCBVQ7+gDuQNcHp89t4qsuk/mobfEQodgQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227440; c=relaxed/simple;
	bh=MCiLdX2dcXn3+5p39O9RNpUon/VvShszu3vjBgoCanI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZdb5MyuiHzDtRmYm/I4hzPnqE6EENbSHXkY48D8ggJ6EybRXIIEXYQ9RGxX/MI+DlsYDq1+XCdfHRwUSakc4DKok+Zu5QxhRkwcAvq8TxjbkPhcCnsp35NOkPNAyHj9It/V3zTeY585fgaTO6qES4kDjFMRJ9yNgmA4k/CQZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b85SvAxH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gcKM/hai; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b85SvAxH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gcKM/hai"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D416DEC0593;
	Mon, 12 Jan 2026 09:17:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 12 Jan 2026 09:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768227432;
	 x=1768313832; bh=efnavr9dJ7/HGqgh9cWgnKEL9ooBnKRan6QWSp8CyW8=; b=
	b85SvAxH1BqRKQK8ECpXpq2YeTjruDj7TW+1/S+Iru4wdJerghWRs2MyZ9KBe/mT
	vXgcZnvgG1+lEG2nD1MhtknO4gbKvHu+PXLl8/lNjDywemaEguDfV6Og/zRA3Bh0
	ILDmtGVoKXZDDOuXwb6FUBvPJUKs8Vt9FMjyDAsHHqB3CZKjkPEUEi8/mxHrsZt2
	nlXkxXs2ezNHfERgBQhMJHS+SaBfPXddsnAF0tdCLx6F6q1joAPD6GPhxBJFEJMo
	F5XOyY+/qZeL8NuuXN3nXzJr4txREn9tQd+Jq95s//IZz+KEuKl9bHTv+edHHFOP
	O2ns/r3yvFBs5dTm+Cm44Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768227432; x=
	1768313832; bh=efnavr9dJ7/HGqgh9cWgnKEL9ooBnKRan6QWSp8CyW8=; b=g
	cKM/haivuV9moT8rftQVn3mh7QN6xBR9AqiOv8CN2BG7Yritj1iEUVU2Yo5WYgRr
	IY5aJaEhG52CEy/fTN+xWZCtdaWaavvjHIoMZpFmUDqMDPfJ2RocH9egwzE0rBb4
	WBYctTNEMGKl8iglpnvs2xLG2QkUi7losHpoG6lTW2L6l7l4c2oubC0WiVHS8MZk
	UUdacWaDFlfK8kWei+s0UTXAQFfyUYDTocL/O8TZsuP4AUbkZx95KM0UW78IjtDn
	JxVnxGfJy2xnLGwt8ax/KDnuNaDIJovaFKlopR5O6S5J3IYd4tdYlpr5cVLu08Xg
	XiTZb9oxNBLjpxmPHdfaw==
X-ME-Sender: <xms:aAJlabZtUZ-k90OvqqwdNmdMZzThfAHLJELrizYhRb-qI9JIUYhdiw>
    <xme:aAJlaWOlNrN_Mv-AZ3hO3dtBGTv8fS_P2ZC1kTDM7PXeG2U42n3j-05RRqhdyK0kD
    I5BWJmY__xegrT4UEi_5Sn38LnhELcXE2KuP8xLNl6FpVaYVMTNZQ>
X-ME-Received: <xmr:aAJlaZWWcIDcKXrnwwHXF6Ybw09p9LmjdX-3eXCQEpTvwlY10LfgyTbMj0SXXZ1WU9dUUeUKIKzLJ-_2n9Da4TreTnVSTQxy1t_gHQOGVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhho
    nhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    iigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:aAJlabI4RBHaL-m1p5ne2aaJygCNO8ZlEduRD3IM_GgRxn7Qq_qAxQ>
    <xmx:aAJlaUqmnov15ERxtM9YqmZ6i88JOulgmmwmAH7nXEild2ICBbvgfg>
    <xmx:aAJlaSwbKp-UlzuW4hczpEOGybD616wSHN24zarFpvlOnHN4-oA0Sw>
    <xmx:aAJlaYsngJfIRZvO5NqpgYihdVWv22bhlmpDSJvTTIuzVU0EiE5DVQ>
    <xmx:aAJlaVYqaCY0YDL2Gjk1cT1ypCKT7CCzLY-VV6SuXjxSnlU3xoGmPeMs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:17:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f8739cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 14:17:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 15:15:15 +0100
Subject: [PATCH v10 3/8] replay: small set of cleanups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-history-builtin-v10-3-e3c6aa5b4cec@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
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
index f7c61dd83f..1e660171d2 100644
--- a/replay.c
+++ b/replay.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -78,7 +77,7 @@ static struct commit *create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
+	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);
@@ -90,16 +89,14 @@ struct ref_info {
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
@@ -121,7 +118,7 @@ static void get_ref_information(struct repository *repo,
 	 * the second because they'd likely just be replaying commits on top
 	 * of the same commit and not making any difference.
 	 */
-	for (i = 0; i < cmd_info->nr; i++) {
+	for (size_t i = 0; i < cmd_info->nr; i++) {
 		struct rev_cmdline_entry *e = cmd_info->rev + i;
 		struct object_id oid;
 		const char *refexpr = e->name;

-- 
2.52.0.590.g1f87b77810.dirty

