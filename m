Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A211277C8F
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820135; cv=none; b=DOBHKS75ZyNvju4GfuJN49AMu1mJAFvKmFuwfZ2UpPUHBH59Q+seIL+1zKYZWpwcAgWmqeHxB4LTXr24a9bZ2HQpL//mfyp9lzYNJ0NnmnqRhLtr0N/Y1HC5rQlbOzuGVyd3TfHsdFyfWzeLj2GJH1GucbbjzB/ehwdPIJ0kvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820135; c=relaxed/simple;
	bh=z86vqufj0264e7/RqHNboIcBX8zLNkvphtZbt3hHPKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fauWCCczNHiW0E0fGfTSQ8V1wpgyQzdrVzjgFpmAk2y2Rnt/5gWDVipvlHR2NSKTpFa3Xp1iyeDsu0CIRmRuXo0gDKEh/YHi7hni1TZ3H6+BrMgCUISdiyLk05MhVaOD0mJ22EH8bdoQhVA4zhAjsDAraJrc8nm3uzRCQ44Pr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EmINuuDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWTCtGzY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EmINuuDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWTCtGzY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 501F514000D5;
	Thu, 25 Sep 2025 13:08:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 25 Sep 2025 13:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758820132;
	 x=1758906532; bh=dGZCPo9/a43X72bnysGclPA7R9POB6YIsCDtJmv16JU=; b=
	EmINuuDuMfe+L/Hl8TSKwqIdtRklu3+/ClXNeOzfpzA6dTgsotbqVMR7/z1nlDez
	Ip/dH2nY5pJHc10brb8HOe/VV1/yumOePbx3WMmV8nsUKzwpX84eNRw8B4i2QGS2
	1gpDauffKZX+TZiu8Q3InevkplLUk4RjjIZhSDWuzL/9UUjBJSiKezcjm9k34BKC
	M8I3pboOMNo+ozw9F/abbH6QCO7rdSgvG+yPjBCzFd0XbtQlJ4c2bhvkP5sGeqdZ
	iG9V2kD65HSTqhjinRI1XDWG3SyWlgVQRphulc6XEe0opT1us+BF+T45O4fx883h
	Zv4LAtlAiXyBHu1muifL6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758820132; x=
	1758906532; bh=dGZCPo9/a43X72bnysGclPA7R9POB6YIsCDtJmv16JU=; b=O
	WTCtGzYoHiYywo6YGRaD95VQsy43j6LGyqVXxzo7tXk9hcHKUxyNgYJo/6vDwIXl
	4YHXTpnRns+Oqf7LbsCL+a9nSz4vywL1/kkWfYhtz9s8QaGUb7JRIwpmvNnw/HWG
	3KXF+g9upPR/d7+59UcsZfmSENFCorT5ZuzSct91rOYcPL6/zWnBb5ye0UlTSIqm
	cv66X9uDfpWOdDdOA8VzW/8kzsMifJX9Cp87RxpqYZEVcE0thWknnVDKaUpxk9/6
	TLwxstwk9HlWaTg4yMxMMSEN0emD1uysXWyf19iG+yAuC21pHPgO80Eus3J/aMIM
	pk8DezFIvkJLTHvppZCEA==
X-ME-Sender: <xms:I3fVaOAgPRQAVQxcOocv_lFCClVm1RU5AO22zbfMJ2pZgY4ewJKxAe0>
    <xme:I3fVaPj_PntkJeIechSeNI5h4O_RraCtTA5wCHcGtb3VhQ7nEiqHcJrcn9pHxyAPX
    rYlKgzRpkOy7XVWIUSFtfCZQZPOV1NWnPyCa4g2qJfXr8kU9G-TnTU>
X-ME-Received: <xmr:I3fVaGnaVYpV634yq7YYBLOhNWBhSh2E7ZIDN_PVmyWrLcHOpMWPoz6FwtTbpY3ySGk__nQ_1YE17SmvVPSGq52QSawYmnCovi0EHgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekgidtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepjeffffejgeejtddtveefgfehtedvieejudekudfhueefkeevvefhueegleeiteek
    necuffhomhgrihhnpeguihhffhhophhtrdhnohenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehlihhurd
    guvghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:I3fVaLpitEiE9BzbYnY6TRPkggW0zbI3bvs0f5r_i-oSjU5tE0f8pg>
    <xmx:JHfVaPFaOgLBGMvSx-SVEzhHAIxHCXhD0EDdzdi8xLpb4TMXEUPY_A>
    <xmx:JHfVaHyMT4M4yLflaCLneYQpHwkWFf_JTR0RNQZihffnd2N-otzZ1w>
    <xmx:JHfVaEpMUfM6pzJ8ckpqXO_8QWxzPS-nCFgwGHIieSMaXY_uSr_3Tw>
    <xmx:JHfVaOG94Wo_w8wn1J4DQuE9K857voI10YJOWo0R1CI4WcSkyxhdOS9t>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 13:08:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] revision: add rdiff_log_arg to rev_info
Date: Thu, 25 Sep 2025 19:07:35 +0200
Message-ID: <d9419743773.1758819879.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.311.g9b2318464ce
In-Reply-To: <v2-cover.1758819879.git.code@khaugsbakk.name>
References: <cover.1758574974.git.code@khaugsbakk.name> <v2-cover.1758819879.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-format-patch(1) supports Git notes by showing them beneath the
patch/commit message, similar to git-log(1). The command also supports
showing those same notes ref names in the range diff output.

Note *the same* ref names; any Git notes options or configuration
variables need to be handed off to the range-diff machinery. This works
correctly in the case when the range diff is on the cover letter. But it
does not work correctly when the output is a single patch with an
embedded range diff.

Concretely, git-format-patch(1) needs to pass `--[no-]notes` options
on to the range-diff subprocess in `range-diff.c`. This is handled in
`builtin/log.c` by the local variable `log_arg` in the case of mul-
tiple commits, but not in the single commit case where there is no
cover letter and the range diff is embedded in the patch output; the
range diff is then made in `log-tree.c`, whither `log_arg` has not
been propagated. This means that the range-diff subprocess reverts
to its default behavior, which is to act like git-log(1) w.r.t. notes.

We need to fix this. But first lay the groundwork by converting
`log_arg` to a struct member; next we can simply use that member
in `log-tree.c` without having to thread it from `builtin/log.c`.

No functional changes.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    
    Rewrite the commit message.  The message jumps into the problem without
    setting the stage.  I think the problem should be presented for a future
    reader with only some basic prerequisite knowledge of this area; they
    might use git-format-patch(1), but they might not use Git notes *with*
    format-patch.[1]  For that reason, start with two paragraphs that pre-
    sent how notes are handled.  Then continue with the story in a format
    similar to v1.
    
    Note that the different “range diff” and “range-diff” spellings are
    intentional.  “Range diff” here refers to the diff output while
    “range-diff” refers to the machinery that creates that output.
    
    † 1: I don’t really see much Git notes use on patches on this mailing
         list.  And even less with non-default namespaces.  But in any case:
         the stage should be set properly even if regulars here *did* use
         format-patch notes a lot.
    
    Also fix handling of struct-in-struct (helped by Junio).
    
    • Rewrite the commit message
    • Fix struct-in-struct
    • (And) Reset author date.  I started this in June but the time
      investment is mostly from these last days.
    
    v1:
    
    There is also `other_arg` in `builtin/range-diff.c` but `rev_info` does
    not seem to be involved.

 builtin/log.c | 7 +++----
 revision.h    | 2 ++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 131512ac1af..9eff62ce111 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1400,13 +1400,12 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		 * can be added later if deemed desirable.
 		 */
 		struct diff_options opts;
-		struct strvec log_arg = STRVEC_INIT;
 		struct range_diff_options range_diff_opts = {
 			.creation_factor = rev->creation_factor,
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
-			.log_arg = &log_arg
+			.log_arg = &rev->rdiff_log_arg
 		};
 
 		repo_diff_setup(the_repository, &opts);
@@ -1414,9 +1413,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		opts.use_color = rev->diffopt.use_color;
 		diff_setup_done(&opts);
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
-		get_notes_args(&log_arg, rev);
 		show_range_diff(rev->rdiff1, rev->rdiff2, &range_diff_opts);
-		strvec_clear(&log_arg);
 	}
 }
 
@@ -2328,6 +2325,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
+		get_notes_args(&(rev.rdiff_log_arg), &rev);
 	}
 
 	/*
@@ -2487,6 +2485,7 @@ int cmd_format_patch(int argc,
 	rev.diffopt.no_free = 0;
 	release_revisions(&rev);
 	format_config_release(&cfg);
+	strvec_clear(&rev.rdiff_log_arg);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 21e288c5baa..ce30570d86a 100644
--- a/revision.h
+++ b/revision.h
@@ -334,6 +334,7 @@ struct rev_info {
 	/* range-diff */
 	const char *rdiff1;
 	const char *rdiff2;
+	struct strvec rdiff_log_arg;
 	int creation_factor;
 	const char *rdiff_title;
 
@@ -410,6 +411,7 @@ struct rev_info {
 	.expand_tabs_in_log = -1, \
 	.commit_format = CMIT_FMT_DEFAULT, \
 	.expand_tabs_in_log_default = 8, \
+	.rdiff_log_arg = STRVEC_INIT, \
 }
 
 /**
-- 
2.51.0.311.g9b2318464ce

