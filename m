Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A37321F2A
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996110; cv=none; b=UpKubWpWLr3zd+r5VQaR1DwLV0lByi1LZRmB190wmHJDACkO+U03BNsGY+RoaSVoXraGorzQtNGPRyzS6EW5JxyV/drmxoQ8sfk9uqmY6WGhkj5g63lEfdsr+7L9Qpg1c6aTTGiLZhEoeToMVNmd4WVoOtnq6tYwDQhCmsdpv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996110; c=relaxed/simple;
	bh=ofcV8AJDNnVFZyyWYB+xOsGi0AV9IoFB+BqccuT8Efw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+vZ96+YI4XWxUsTsrno7cdXsMQu32nsxefO9/359/NiqAlS6iMoqH6rInKzVAQBb/J6hQAJw75PX+M3cyg2T8fhWqANnWATB6SeWctgfDgSTOViBfvgNFEvdGBe93mv9H0eiGz7ijlDmxFlezYp0mesX31ZO6YwZ1JV99JiYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lgBsh7aq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XXCmJPF9; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lgBsh7aq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XXCmJPF9"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 384491D00293;
	Thu,  4 Sep 2025 10:28:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 10:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996108;
	 x=1757082508; bh=QtycuTFKv0hzEVa/q02G6NWVKGOgpWLv3psaP4eZjow=; b=
	lgBsh7aqkoMjgQLshmyPGZ9CQUKKFUHRD4Q7RkmVm01FpZDIFB/Mgnh7woNS9XH1
	ffvMzTdIBKcRQHPXCaI06UoSXGDTOO+WhJzONlHoetqFD6teGo4a4/kmpmsK25B0
	hrF+sDMhjB1JIrov1EgjzBWfID8B5Dwj/KKcPIXRJz0ZYwyolBNzOstcpuM3Q+TM
	EDlV5imHl42TPzPx8hi479LraAgkvNJ9PyoS8RsCwyAnee4UUHLh2QsnLEKmUtCK
	4tq9EEK7jqPF4kSITiElyzVOpq1bzV4gdsefqHFqeIQh7mOEnQ5CpDtqCpY63iPM
	J5tLsrcMiqzzzxfE+yyjSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996108; x=
	1757082508; bh=QtycuTFKv0hzEVa/q02G6NWVKGOgpWLv3psaP4eZjow=; b=X
	XCmJPF9NPUrtrmIeoCcFOU3ve3Zvcrt7JTg/J62tD2cl7rtO28T0HX3vH5ht1+Ga
	tVjvfjOuhjNjcVPD4aTKsg5IoM0MnEwgoCzZL+qJIa13hIK96kmYPNRecyqLH4Ib
	jm3Ml8mof172o99z6uXbIxMqpRspX+pgcp9QczljZ4wzV+IQGll5cadsbymguj54
	P0GE8QQ4VhcEQj8VSwYRfXI4fWQLbxufao3euN3/p1RRAM3V7n4Brxp0jJzw+S5f
	bXOX3FWtxC08xB52e2RHfBtsqKFKD0NLORADWOPhPJfZnNQ0ssmNZOt/kC4mjqbs
	0rZ8L5N3MM6XMY4+J8+zg==
X-ME-Sender: <xms:C6K5aIBVW5VpIkKV069G1uGoxf-BmbQuIdXRLfv5nbwT_uRjQhoVmw>
    <xme:C6K5aIFD-GP7mSB0QYC-uV9_oRQ-31LpG1kd-TpUYOtQ5OUSx_dERGDaDAUai4j7N
    kQBS0_Xyv3oUyf-GQ>
X-ME-Received: <xmr:C6K5aCAS9kS7pHi85Y3Ap6u4qlMGPR1i1Dc31oCNwH3n9nXH3_wJCW557SdhCVr4q0wcDuZdAIt0xpu4UXO_l9ZSHH7fLA0Sb9kMQeBZ4XAXNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C6K5aAVMQy7Zp2-sZVMuNWT488YqiI9YqjG-oMR8KPN8svD7_ReYOg>
    <xmx:C6K5aOo73eW9PSFLaj2S-8Y7UaeolgYGZdrVGPtZhGD15GpxDcInIA>
    <xmx:C6K5aEQamT7ZSyV0WbaopYmxmNBtD72U4MJ4sZ2ycr3bsQGUrSByXQ>
    <xmx:C6K5aA1C4vFhqlVxslY6jJ7jTqzXTC6NBUkaUcHm61By2VOQzMMUdg>
    <xmx:DKK5aN-FnvOOOSHNol55b3JEhSHzCIfusij9hjvQwIf9VazooVJRcPcM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:28:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a4f0104 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:28:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:46 +0200
Subject: [PATCH RFC v3 16/18] sequencer: allow callers to provide mappings
 for the old commit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-16-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

When executing the "rewritten-hook" we provide a list of commit mappings
that tell the hook the original commit ID as well as the commit ID that
specific commit was rewritten to. Typically, these should always be
different from one another, as otherwise there wouldn't have been a
rewrite of those commits in the first place.

With two upcoming subcommands for git-history(1) that is not the case
though, as we have already written the new commits ahead of time. We
only use the sequencer infrastructure in that case to insert those
commits at the correct position in the graph. This has the consequence
that original and rewritten object IDs will be the exact same, which is
quite unhelpful.

Introduce infrastructure so that the caller can tell us the original
object ID for such already-rewritten objects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c |  7 +++++++
 sequencer.h | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 61447e5ccf..72d26b0eef 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2214,6 +2214,13 @@ static void record_in_rewritten(struct object_id *oid,
 	const char *path;
 	FILE *out;
 
+	if (opts->old_oid_mappings) {
+		struct replay_oid_mapping *mapping =
+			oidmap_get(opts->old_oid_mappings, oid);
+		if (mapping)
+			oid = &mapping->rewritten_oid;
+	}
+
 	if (opts->action == REPLAY_HISTORY_EDIT)
 		path = git_path_rewritten_pending_file();
 	else
diff --git a/sequencer.h b/sequencer.h
index 0e0e7301b8..e6cc8aeb5d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -1,6 +1,7 @@
 #ifndef SEQUENCER_H
 #define SEQUENCER_H
 
+#include "oidmap.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "wt-status.h"
@@ -35,6 +36,12 @@ enum commit_msg_cleanup_mode {
 struct replay_ctx;
 struct replay_ctx* replay_ctx_new(void);
 
+/* Used as entry for the `original_oid_map`. */
+struct replay_oid_mapping {
+	struct oidmap_entry entry;
+	struct object_id rewritten_oid;
+};
+
 struct replay_opts {
 	enum replay_action action;
 
@@ -83,6 +90,13 @@ struct replay_opts {
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
 
+	/*
+	 * Used by the post-rewrite hook to fix up old object IDs. This can be
+	 * used to rewrite the old object ID to whatever is stored as value in
+	 * this map. The map contains `struct replay_oid_mapping` entries.
+	 */
+	const struct oidmap *old_oid_mappings;
+
 	/* Private use */
 	struct replay_ctx *ctx;
 };

-- 
2.51.0.417.g1ba7204a04.dirty

