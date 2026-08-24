Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07532E1722
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603801; cv=none; b=hsmBWqH7JtNopeYK6DhGOPO7q4/T8mU46yToMI3ILljV+Ddj27gyOVDHhh9iV3NKxqG+bWzzuGyD4qjpy4NPNHodqU0+3oER0/gMcjD2EVqKjZPIut54cmHF6mo/P/oQbTWszufOmzXdJYPw/Lmxz3omlxSQlfGKCVl1UBjASgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603801; c=relaxed/simple;
	bh=IzMw4vD31boywJyLNc2p8ZQ89wSn5e33xKKZsXzsXxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mi2JmniZbtysSEtmXFOm2fDaHA7jXwPo9h5fz4f9aD8vR2qvG9fY/Ju9qJJ4Q/yj8ld2ADsmNPxVcFYIY4YvkGRPUXL3mlZoLXEo8BpUHMydzympBSh4hpiVKJMLjT67yysL2J+YV7psB5jx1nNcGkBs6iHsoeCkG2FxVdx+DlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nBt5w2gI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dbbr2tU6; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nBt5w2gI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dbbr2tU6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 08F471D00036;
	Mon, 24 Aug 2026 16:36:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 16:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787603798;
	 x=1787690198; bh=5EEJyJlRQrIiNVmjUjfvj7bspFwD9KI8WzGgjIBOtxg=; b=
	nBt5w2gIZPyhvNMhYbNic93j3XD6pQuEVA1iYVuPeKhL1UcR8BoUYEwbL6oPS65L
	YYSuLG+6pNFTxVFO2UuEZqllpYk7ju7/2oEcOnWLBmnzJZfGW7c9VmIVRV67cAGR
	Utxa4D+qtE1lxxuGO1S3wKRy8qNpLbHB6NWiP3W6GM/wZU5PtxNM8hw7UQJw8Sf5
	PLUt+BPaOcljOh1/R3E5Dwz5X1R9MyfeRx4id7kWWZbEhhFkoQg8ocNYFP2QON+/
	fTma3rip2TVdklA3p0d8rMFCsIxTD7h5TiRhYmhCmjVzp8tjnGHoOW4/U1Y38qpy
	V1rNi+3UiSf4FthD0QEo1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787603798; x=
	1787690198; bh=5EEJyJlRQrIiNVmjUjfvj7bspFwD9KI8WzGgjIBOtxg=; b=D
	bbr2tU6W5GEqJWs9GHejlbPZe+jIx/k4ubF0YiMLR9M2lFEZRVfdMtzB4x7D4Cgl
	QDwwTta83CuMvYxcapUVFQ7dm0BkzLa8uOrnhgyW7ECTPCWiApuCsum2orcFNWyG
	LXVgrt83fH+kKK7XWdj2Caqpe30TXA0ymJR9oHn9p+jyD1dgvXjhS9/Tjx9Ex8c7
	4V1bJtoJQxn2GGZAOPL4JHPOw1p+hdgdT6CI2MuiaU+wBN0xRNjfKImGFCaf2mHQ
	m+0/GLUKvE6zcM4iuij+TkDun+Cc5Wg6VCg9X3cIa7LS0XBulu65mCul6JvApQbL
	BzHjS+roMIgjeUCalZ+wA==
X-ME-Sender: <xms:VquMarYQld6rwAMRTYh951IR4ei51R2ClHYD94YsZYoQ_3m2Jax-uwo>
    <xme:VquMagZB18ZReOZgWRpvhdSE1xV6jM_U40xCtNHkO8BPgbD-Y4t1olYB7fLc_5g4l
    8XG4KqY-9U9LVopVYhXKFKGBODWxv_ocw3fXheq_t2qwyqiz03d1w>
X-ME-Received: <xmr:VquMarkJ42fAwJfaxYMLs97nd46QmNmMf0BhmJE4P8_AKIiaxHb0TqGG2gdOKlMIEtgV-IaK8399WFujJuJamjusOARs3D8sK113lCoWM_is1G8sInNAqBiD7g>
X-ME-Proxy-Cause: dmFkZTEFzKoTKXM/KBIBJkz9HCO1w6gsZ5R1eBYFUcezAEaXwhxHT7DUDDmdnvzNPtZGrD
    InoIW6icieXJnE8VUQygqaBWFNeMhGLKWv3ebZvzh8WdKEq8Yj5mQ0HyXN59lgxJZVG+9R
    WRAlucfQdfVkJk2KTnqi5mT6L+qCZo8oPuGiqpoRwucXi6nESB8KnA60j916XnvfN9zyj2
    yqdbwRLjrVVNrxEGktFTvMR6z5owEXeweKdezeOWWCnYaiK6uHXR388avfW6MlhrRE3qPD
    SjGnloGMI+Pkcign4Hf5oUonC5HUx8vEBQRALqkNIqDVpJ2TVBkcI1uFgALVv2RTMzXLMu
    ad20dTJKT2TznsOGwQLgIgL5fh1+5hyVj/t0OcGOch9l0dS7sHnytPda53xAxu+Rl3Yenm
    uURCrPoeUAE6caeF+MfW9+TUzrXV/xSiBP4Z8RRHHSdoAKrDg7MsjTnUz/K9sVA1spT+Ez
    kttF1l4xsRv6g1s0DMJO1Lpj5M2+/5AfCnM3w3f+P4g/y2NVHWG6fXDthC6xCghTaYB5NF
    C3E+pL3On9+j0Mvwdoss0BBi74PvcTK5SrZI8dzk3R5nJC62L0CVjeG/iih9ZbQh+dbBXH
    TKawfPGH7rGW4wOh1D33j8a5yfFfjqe+uxbS9asfCY3S88T6SGCXu6B3KzXA
X-ME-Proxy: <xmx:VquMasyizcIRCxYKuYWPvkSsnBh2e4tDMfICBTCsKYy_vp_VUMIE8Q>
    <xmx:VquMapMWqJctyu8TqZXl5Zzr32beulwcARky5HkQJUARVOv7OwW_DA>
    <xmx:VquMagSa9X3vYyvRjkXIiDV1QYtysza-gWVSluhdSTPcFmShscvy4Q>
    <xmx:VquManbeNpmn2YLqcjQoZeQDb-AaR6j9ji2ELxXSt6yAU_Tom7nR_w>
    <xmx:VquMauyxPomOBNFzuA9rcxqhC4bbMUh42vqkpODpLWaLE3x_FnDAb_RY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 16:36:38 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/3] revision.h: rename struct member to reflect notes role
Date: Mon, 24 Aug 2026 22:35:43 +0200
Message-ID: <member_rdiff_notes_arg.c59@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The `struct rev_info` member `rdiff_log_arg` is only used to pass
`--[no-]notes` options to git-range-diff(1), which in turn passes it
on to git-log(1). The “log” in the name is fine since other code paths
could choose to use it to pass something else on to git-range-diff(1)
(as long as it makes sense to git-log(1)). However, we will in the next
commit change `revision.c:handle_revision_opt` to push and clear this
`strvec` based on notes options that the user passes. That means that
only one type of git-log(1) option will be suitable for it. So let’s
rename it to `rdiff_notes_arg`.

This structure member got its “log” name in 85bd88a7 (revision: add
rdiff_log_arg to rev_info, 2025-09-25), which was based on the renaming
of the `range-diff.c` variable `other_arg` to `log_arg`.[1] Now, in
`range-diff.c` this `log_arg` really is used for multiple different
git-log(1) options, namely `--[no-]notes` and `--remerge-diff`. But we
can keep this `rev_info` member notes-only.

† 1: in 71fd6c69 (range-diff: rename other_arg to log_arg, 2025-09-25)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (testing):
    just compile tested

 builtin/log.c | 10 +++++-----
 log-tree.c    |  2 +-
 revision.h    |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 560af00e2fd..28a93c45463 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1336,15 +1336,15 @@ static int get_notes_refs(struct string_list_item *item, void *arg)
 static void get_notes_args(struct rev_info *rev)
 {
 	if (!rev->show_notes) {
-		strvec_push(&rev->rdiff_log_arg, "--no-notes");
+		strvec_push(&rev->rdiff_notes_arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
-		strvec_push(&rev->rdiff_log_arg, "--notes");
+		strvec_push(&rev->rdiff_notes_arg, "--notes");
 	} else {
 		for_each_string_list(&rev->notes_opt.extra_notes_refs,
 				     get_notes_refs,
-				     &rev->rdiff_log_arg);
+				     &rev->rdiff_notes_arg);
 	}
 }
 
@@ -1475,7 +1475,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
-			.log_arg = &rev->rdiff_log_arg
+			.log_arg = &rev->rdiff_notes_arg
 		};
 
 		repo_diff_setup(the_repository, &opts);
@@ -2569,7 +2569,7 @@ int cmd_format_patch(int argc,
 	rev.diffopt.no_free = 0;
 	release_revisions(&rev);
 	format_config_release(&cfg);
-	strvec_clear(&rev.rdiff_log_arg);
+	strvec_clear(&rev.rdiff_notes_arg);
 	return 0;
 }
 
diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b1..fd6ddf32af4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -718,7 +718,7 @@ static void show_diff_of_diff(struct rev_info *opt)
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
-			.log_arg = &opt->rdiff_log_arg
+			.log_arg = &opt->rdiff_notes_arg
 		};
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
diff --git a/revision.h b/revision.h
index acf6d06b241..39cca04d9e5 100644
--- a/revision.h
+++ b/revision.h
@@ -351,7 +351,7 @@ struct rev_info {
 	/* range-diff */
 	const char *rdiff1;
 	const char *rdiff2;
-	struct strvec rdiff_log_arg;
+	struct strvec rdiff_notes_arg;
 	int creation_factor;
 	const char *rdiff_title;
 
@@ -432,7 +432,7 @@ struct rev_info {
 	.expand_tabs_in_log = -1, \
 	.commit_format = CMIT_FMT_DEFAULT, \
 	.expand_tabs_in_log_default = 8, \
-	.rdiff_log_arg = STRVEC_INIT, \
+	.rdiff_notes_arg = STRVEC_INIT, \
 }
 
 /**
-- 
2.55.0.13.g85d2d65e389

