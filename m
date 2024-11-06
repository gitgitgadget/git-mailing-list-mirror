Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D190204957
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905886; cv=none; b=Tuoj9dE2M1d7GNntCFkUufedfCfSee5TCmYpRzba0ZBVoHaum4Z6Dmg4INv6uiSY1YYbZ6Q/HfwjLfi2SYOH4TF6oAXpJg5S578cwLOp4pdnJ28ZSsHNdTHwHGVXgpnHmeHb47kyrTtVlzFSjVn1h+OdaUAwmSHWyDZnIwUcxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905886; c=relaxed/simple;
	bh=3XIhMrM4PXt9xCAFngABAnSkFwt1OL5W9lzVrI0kp9o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3SgTk95MwNwoFdODKtCByQY5QQTg8PWmtqlkcBR83jlAcZ6wG3PZ+kgOWwAy21/flTEqBg3MKPXJWsy0tyY/MevCMSq894PTrEvGSy1ACP6K8tGUxw7x8DetUdp7KCqhlZpMfURrhcw7pbKYa9sU202V7osx5cfb2BKdr0VLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dq6m24s8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBrxuHgl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dq6m24s8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBrxuHgl"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC9A7114008D
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 06 Nov 2024 10:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905884; x=1730992284; bh=QdhJD76EVw
	qtnrg4wmxh6aC+O6gH82mCGAcMbMe/dtc=; b=Dq6m24s8wj2W336MTDgGc86xjP
	MSwvSU5j6WrE4ER/XE4dRmtsAPCwl2reUU0LSqwFhBWVxejngIaV25bq8I0DODZ5
	nuxra+uLi15WLHkIKBnzU9ekBHWNkIY4Qxy5pwrJuWfXcuN26iYw7IGppjxdcN1L
	agNU6vKJOF0LYC3A2o/0ggafAnk6um/UjKCeb11DPbEP7IYD/wXpUTMKPmN5JGjY
	Yhz4zw07vmM/0nKacWoCoJmpeCkhWuMJFH8DWTUMOEMT43JqKM4fTVJLjYKi1E0a
	2rbMv4m9FfnggyPBig3uik/vPk8xYhzyfQVwll6a+BM4xR9ltIYZV52igLEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905884; x=1730992284; bh=QdhJD76EVwqtnrg4wmxh6aC+O6gH82mCGAc
	MbMe/dtc=; b=TBrxuHglgqjv7m03FMeWGUgjKar1idRchYxWwVuRbn0qLcvAhHv
	wWEeMFLFDKVGF1Ke8feuEB4KlVYSwwuWXldAI+St67CK5egg35gn7VEnTZvaAyAJ
	d98g36CEXp7Q5DJedXXNFuL4avdrn8DVe0RmqhzaFo87LrAHXP4QkpOJgZUrF0NW
	4zcf636IJXtNQgzXA+hztscY8hCrRF2pama8JPVz4Hq6RNwFUfGmqheDcPlZAv7y
	vrQ5iW96jNHXqgp+yKSa6Y8juO68QcNK58dsM6KHujDyLZEoSWRwYo15uv6wRkqm
	fpZVakiH1hDjy6EV63rinbXcjIeCr+IUUJA==
X-ME-Sender: <xms:HIcrZ51HV1S_yidtXkJqAO0JTJOD1KmrM8LdgOdElVdFrM5_tovYPg>
    <xme:HIcrZwGoMsaKzXzGrZjGP7JfsPfP7c8pewql9zA7SJV1SH0OSDE1jj082n00Jwy1A
    Rqm0h6sOm1mo0wySQ>
X-ME-Received: <xmr:HIcrZ57GzpyMJETetjbgHRLrdjTH23foRK4ggP0ql5hc6vywmiELQZk3BmiSNZgn62C3B-wieKoKtAo0J2ExVPId6ADTA0dEIKHcpbQi1Zi4Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HIcrZ23xB-138kgsIdG031XUonfSN6BSgsBql3T6KLO_O_yGevRCVA>
    <xmx:HIcrZ8F9CWLELgL5BTnQtw58Qx4gYAkmuwLxhi0EeazUqqTEGCioJg>
    <xmx:HIcrZ3-N2BHWclb2ZtHEE24vsa5eAVQQI4lOJqg4mAcKfQqTHJB-9g>
    <xmx:HIcrZ5nqBS4kxrgyEqPHixi0jVMEErpF-xZkxk8_NfOcRT6Iko9kJg>
    <xmx:HIcrZ2PdEDDM6fVOIiHll1I4wZIOq3qbKLKdhIo_b8oz8FwRf_PNNJId>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3b96ca0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:59 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/26] builtin/branch: fix leaking sorting options
Message-ID: <e0aa2c5bb258589bb2cac19c54fddbb70614a487.1730901926.git.ps@pks.im>
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

The sorting options are leaking, but given that they are marked with
`UNLEAK()` the leak sanitizer doesn't complain.

Fix the leak by creating a common exit path and clearing the vector such
that we can get rid of the `UNLEAK()` annotation entirely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/branch.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index fd1611ebf55..05ba4cd7a64 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -722,6 +722,7 @@ int cmd_branch(int argc,
 	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
+	int ret;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -851,15 +852,15 @@ int cmd_branch(int argc,
 	if (list)
 		setup_auto_pager("branch", 1);
 
-	UNLEAK(sorting_options);
-
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		return delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
-		return 0;
+		ret = 0;
+		goto out;
 	} else if (list) {
 		/*  git branch --list also shows HEAD when it is detached */
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
@@ -882,12 +883,13 @@ int cmd_branch(int argc,
 		ref_sorting_release(sorting);
 		ref_filter_clear(&filter);
 		ref_format_clear(&format);
-		return 0;
+
+		ret = 0;
+		goto out;
 	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
 		struct strbuf buf = STRBUF_INIT;
-		int ret = 1; /* assume failure */
 
 		if (!argc) {
 			if (filter.detached)
@@ -901,18 +903,22 @@ int cmd_branch(int argc,
 		}
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
-		if (!refs_ref_exists(get_main_ref_store(the_repository), branch_ref.buf))
+		if (!refs_ref_exists(get_main_ref_store(the_repository), branch_ref.buf)) {
 			error((!argc || branch_checked_out(branch_ref.buf))
 			      ? _("no commit on branch '%s' yet")
 			      : _("no branch named '%s'"),
 			      branch_name);
-		else if (!edit_branch_description(branch_name))
+			ret = 1;
+		} else if (!edit_branch_description(branch_name)) {
 			ret = 0; /* happy */
+		} else {
+			ret = 1;
+		}
 
 		strbuf_release(&branch_ref);
 		strbuf_release(&buf);
 
-		return ret;
+		goto out;
 	} else if (copy || rename) {
 		if (!argc)
 			die(_("branch name required"));
@@ -1000,12 +1006,17 @@ int cmd_branch(int argc,
 			create_branches_recursively(the_repository, branch_name,
 						    start_name, NULL, force,
 						    reflog, quiet, track, 0);
-			return 0;
+			ret = 0;
+			goto out;
 		}
 		create_branch(the_repository, branch_name, start_name, force, 0,
 			      reflog, quiet, track, 0);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
-	return 0;
+	ret = 0;
+
+out:
+	string_list_clear(&sorting_options, 0);
+	return ret;
 }
-- 
2.47.0.229.g8f8d6eee53.dirty

