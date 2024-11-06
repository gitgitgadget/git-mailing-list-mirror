Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298420493B
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905876; cv=none; b=pUe4zFX9yCivtzeu1jViMQwkJpiiO8LU1DunMF9CIdksrXjQxa6VfzWssRmHE9Lg28GqtRhO5+XVqzfevVA7U9hbmGDqrkhzK0sbZR6l68ucr1DGEIr19S9DkTzgpprR/LoplWPHwq0btutd+vqdoo/EbxLev6cYlj+aj6By9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905876; c=relaxed/simple;
	bh=UqIuKkuFrOkcnR/mu3Zh7LP2sgM7ybvf7And3Cf8N9Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwCv2dFE2USJegYuwtOCVs78FK1k2BTgYXWnAghFxk0LgT11csVuBWIAKCrx3OsJY7LbzBDpRnZhC/uFtzkaXaoqF5TBVY7CwVY3tyGTX/qb5J2dj56zS8GDgPitDu5P6JExxTLfOfGet3SvZv3pN/TIXLXLio4shRivZfvrSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jZx9yqjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qrnxa/W9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZx9yqjR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qrnxa/W9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0531B1140129
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 10:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905874; x=1730992274; bh=mR1W0rIhWC
	KWi+sjqRpK8KdRIVoPu84XICp+yZ4KZVg=; b=jZx9yqjRdTZxjBlF0ymOK8yrjK
	bhBxfGRJD4n6mrkSR6gZMBy3X4eNvhKfi4OHTAxngxZfrA/DLYC8rkjoeVJ1+tBT
	umL0P12p6IEjCzGZcnk+Wq3YOpsGc2RWEP10QXpedy1arbopn/VyoDnlRMgvaLfI
	0EJmZ6Opj95Oc9NaEcG5PW4bl1cHpqGVV9aB+FF/6pRZAlJqTSq6dE3bLd7E3zMR
	beOy+MkcJgLDtrmwPLBPMt+peXCfkbwYQkZapdApUjoqlOAofSYcwreuRKHo8lTG
	NZt/Z5/zbHgPPJFRp29AITGLUu9KtvpTmcMsvE6WtDd1FR70ngj5AoEezV/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905874; x=1730992274; bh=mR1W0rIhWCKWi+sjqRpK8KdRIVoPu84XICp
	+yZ4KZVg=; b=Qrnxa/W9WlLZlzOyDjzv6ndAUBGQ5fbX0JYYfpTexMA2plSAwgD
	I04cfR0lHcQCI51NgEbn9HfHTHxDJKFaYl8WMzr0Lmt73VpBqQMEVsARToFoMLcF
	dnanGFHHIAXsUhr+PmxiLr1kGtLmPl3gY4fMMeFKlnedZqelMM+Vil9hm95CFu6G
	sdfY054qXqHIRk2uAodvsvIhVECMRwUeaoReGAHEPBOcRpXuxOKPS+V7LJhl6NsZ
	WGMrpuzv2FmbPgT2BCAB3um0v9PAEqcSUy3dIKhDh7NlpSnMsztNHsCyRjU1mx25
	mdm7n3balGqX7oAoWeBvGntucaXTdX0Pepw==
X-ME-Sender: <xms:EYcrZ42oo8PdxeaejT7_c0UnKAOOor66DwOCKvAiwMYoqGP0lOQ7sA>
    <xme:EYcrZzGOD0axzqM4TFpIpHlDO3eRGPCr3aA4MCN2yLePrMK9qHAtks4WVRcQFP5Ig
    4dEr87-nWcaF-5xGg>
X-ME-Received: <xmr:EYcrZw7p61jOJZgVL019zpP80nMfBw3joi3ECdHR_9aYSwCDNDsA3jNVjsQoPVAOrxBk3bk5LPW0hEnjVcmwq9muckIsoeJUZFHy5NCpwkLMsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EYcrZx07oBF0Y9zB6PxUs7c2HPeY9lWvKpV3WHfQEA9VEkyoYQweqQ>
    <xmx:EYcrZ7H9VFfliA-EFzQmcJ-RGNejFcC_mop98gCOCihf6QzLaPfNkg>
    <xmx:EYcrZ6-mL2mjOJfZJ8BgbBOKRaW-m-KiFB4L3__x1-LX15yQPGYpAA>
    <xmx:EYcrZwnE_HaM3IS00Y0_sV0v8NBY6-O7nU4mEp5Z23zQakcSN3PKwA>
    <xmx:EYcrZxOt5nNbs_nGXhOj_ihpPU9jl-zTb3oeMWCLcuVx_Ze5EWoylH6U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58682150 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:49 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/26] help: fix leaking return value from
 `help_unknown_cmd()`
Message-ID: <ea8677ff965711ebca140f130c62c704e0ab0753.1730901926.git.ps@pks.im>
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

While `help_unknown_cmd()` would usually die on an unknown command, it
instead returns an autocorrected command when "help.autocorrect" is set.
But while the function is declared to return a string constant, it
actually returns an allocated string in that case. Callers thus aren't
aware that they have to free the string, leading to a memory leak.

Fix the function return type to be non-constant and free the returned
value at its only callsite.

Note that we cannot simply take ownership of `main_cmds.names[0]->name`
and then eventually free it. This is because the `struct cmdname` is
using a flex array to allocate the name, so the name pointer points into
the middle of the structure and thus cannot be freed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c  |  4 +++-
 help.c | 11 +++++------
 help.h |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/git.c b/git.c
index 159dd45b082..46b3c740c5d 100644
--- a/git.c
+++ b/git.c
@@ -961,7 +961,9 @@ int cmd_main(int argc, const char **argv)
 			exit(1);
 		}
 		if (!done_help) {
-			strvec_replace(&args, 0, help_unknown_cmd(cmd));
+			char *assumed = help_unknown_cmd(cmd);
+			strvec_replace(&args, 0, assumed);
+			free(assumed);
 			cmd = args.v[0];
 			done_help = 1;
 		} else {
diff --git a/help.c b/help.c
index 51adc530d7a..0290aba9f38 100644
--- a/help.c
+++ b/help.c
@@ -612,14 +612,14 @@ static const char bad_interpreter_advice[] =
 	N_("'%s' appears to be a git command, but we were not\n"
 	"able to execute it. Maybe git-%s is broken?");
 
-const char *help_unknown_cmd(const char *cmd)
+char *help_unknown_cmd(const char *cmd)
 {
 	struct help_unknown_cmd_config cfg = { 0 };
 	int i, n, best_similarity = 0;
 	struct cmdnames main_cmds = { 0 };
 	struct cmdnames other_cmds = { 0 };
 	struct cmdname_help *common_cmds;
-	const char *assumed = NULL;
+	char *assumed = NULL;
 
 	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
 
@@ -696,9 +696,8 @@ const char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 	if (cfg.autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
-		assumed = main_cmds.names[0]->name;
-		main_cmds.names[0] = NULL;
-		cmdnames_release(&main_cmds);
+		assumed = xstrdup(main_cmds.names[0]->name);
+
 		fprintf_ln(stderr,
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
@@ -716,7 +715,7 @@ const char *help_unknown_cmd(const char *cmd)
 			strbuf_release(&msg);
 			if (!(starts_with(answer, "y") ||
 			      starts_with(answer, "Y"))) {
-				assumed = NULL;
+				FREE_AND_NULL(assumed);
 				goto out;
 			}
 		} else {
diff --git a/help.h b/help.h
index e716ee27ea1..67207b3073c 100644
--- a/help.h
+++ b/help.h
@@ -32,7 +32,7 @@ void list_all_other_cmds(struct string_list *list);
 void list_cmds_by_category(struct string_list *list,
 			   const char *category);
 void list_cmds_by_config(struct string_list *list);
-const char *help_unknown_cmd(const char *cmd);
+char *help_unknown_cmd(const char *cmd);
 void load_command_list(const char *prefix,
 		       struct cmdnames *main_cmds,
 		       struct cmdnames *other_cmds);
-- 
2.47.0.229.g8f8d6eee53.dirty

