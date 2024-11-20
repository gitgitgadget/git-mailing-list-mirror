Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC21BD509
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110010; cv=none; b=oWuydxn9qLoCc17vRv8zQMhDQxGlYBM21GW4GSosfLBsqYPUMQ+1r0EXpIELNCZMfL8xdcqtPcI/KFjffew8L6XJ1ZUIBjuA8JT+zS1Vu90hZBQIaOtSwmhbAdJsfaAgFfw4pBqLW42/WuhjISPkyk1NcQNJF7aJKzqTmOZRd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110010; c=relaxed/simple;
	bh=vMLuoRQclcQ7tiJa3u6WoZzXQ3fWzWYK//Zl4aDNHhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZnPnoOaBQz8DOZLJQdADSxyWTxVEThj3PK2g3G0/LisOM5/k2JMT2MYms+k1ydpYxhkeLOjusQHsUqI9MYjz64sIYTSIej4mxq95UFEpTwBaqbw1vtPIsXJUnWgwVph7+e7uANjcu4SCR/G7iVyGuMWIU6BB+3P90ngHmbJFu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mf+WgGka; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HC2rEaZk; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mf+WgGka";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HC2rEaZk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3198311401DF;
	Wed, 20 Nov 2024 08:40:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 20 Nov 2024 08:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110008;
	 x=1732196408; bh=e/X/DhxzRIaj1Lw1yf+htFyCzORaqY4/wCm4+PRCmx4=; b=
	Mf+WgGkaf1DxD9sRz9AG2UvSimtGGdbiLh5BzoF3r+fvH8ILOLz36WmWn6NV6D4e
	YTvxrfXkMwUKqEMxA4ip4obZi1Ownrljc1va/Odl/lb7364UQhhrovuXtiu6rcO5
	Leie8TK3bqJJsJSr4gZ93e1x/SxyntWw34VtOoAqCbZYAwwxcGmfkavG1AGczmyC
	vFcVNI/St47Xi2G4vYcbxBwIjOD+qYtri/zyQftiUVOcjvojGpcSBgUIl0BnxsMF
	ieXABe+xTlyWB48RvGRbiiGRAtDJhqA9r8tsf/tsuwyAmhm1wdrn0mAMwLCE7dAp
	ypWGnM+sb2BbUlAEt1ZE3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110008; x=
	1732196408; bh=e/X/DhxzRIaj1Lw1yf+htFyCzORaqY4/wCm4+PRCmx4=; b=H
	C2rEaZkjhTHEiL7H7TTBZqYpKhcXifiFkr4CiTF4ktCYzHckvwgp4uuR2lvjMb/c
	7vtx0BU1jXB6hL9VSLDSph0/RR1X0N0nLA/RiZl1oYZ9hK0atmtYQ3WL+CM3lZtc
	CPon15zzhjyEbpMYpOL/TMK18uCawJzvSudkAAOal50CBoVP5XhGcdLjsfZbuB8D
	8zERjCJ995lYaSDpeZmFETkmSehKKLUhyzwRXzmFlTAKoYpNLuxgoc6VdkZ/E2pn
	ib+T+H8zaZYNvSbbSk88N/ewxbL5SHztoSWxFgITeDgojF7Uo1aosjLBj0+nofzM
	Fys8xcV/wfX81KutADstQ==
X-ME-Sender: <xms:uOY9Zwwr2LMHrc3n-pdZjGmf5hfnAIGgvdbIAc9SLPZtMPO09_lRmw>
    <xme:uOY9Z0Q4vSjuvLpCaF-9NgGxRDqhqDfe2tFy6vnKLK-X1qTMiqM4HS3wngQsrA9Xi
    2k8FoBLsOteOurSwg>
X-ME-Received: <xmr:uOY9ZyVlLif1qLrIofjr6hsFfsboZ8Vz8WWtoyT__XqaLKcyTnh9Bbu-GNcGYyfRWlxp1qMbpHUBbx0MfvCGYZFZYDno_NKGJ7vFNRDSjYAGvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:uOY9Z-i6n_ZX64Pm1XbAKac7g3-P0uo2sk_DnRDUBiqjmResmP8awQ>
    <xmx:uOY9ZyDJEj6MqwqklGDkSCbZP2UI1WGAsXN8avjUy_vIdZQ0-j1vMA>
    <xmx:uOY9Z_L-GPkDb4wNQzpohgAVOIMjbkpnB5Wjf-wbvnzCP2qruPDa_g>
    <xmx:uOY9Z5CKZ9riEGFeppjlEueKV6hNHt44aStz_w76YfsgxZUMkNMVNA>
    <xmx:uOY9Z1_bKUKlyzVNFbqukPuyDIWJG-ENHde8QmRIxEwItwe7-9mY8KOh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc0482af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:48 +0100
Subject: [PATCH v3 19/27] builtin/branch: fix leaking sorting options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-19-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The sorting options are leaking, but given that they are marked with
`UNLEAK()` the leak sanitizer doesn't complain.

Fix the leak by creating a common exit path and clearing the vector such
that we can get rid of the `UNLEAK()` annotation entirely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/branch.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index fd1611ebf559f7665114c41ee379db24fdb357fd..05ba4cd7a6454d8753d983082807a06dd989cb48 100644
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
2.47.0.274.g962d0b743d.dirty

