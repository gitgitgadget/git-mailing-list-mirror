Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE8199E8B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321546; cv=none; b=QiNVgPkk0uHRMh3zO/pGBT6csfHB+mULaX8goKtMxctHymxESeQgaCSXpeJClLRyjdg1G9zp/UaAW+ie59XivS5rFb5O7Q97BQMdEZrvT64tEb+b5gDC6DEws//NNxypDXdV+CjLwM8qTBPrnJ9ExkQvBT0jl54bgOCyKSnD+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321546; c=relaxed/simple;
	bh=tnzkJCFZ+jb/AI5OxzRuFD+AZnETWoJyX7KoGfu1B8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKhilNJFCGqzRBLXR4hSaJfK1Zx8Pzt9h3qtmNPVXmZSNIPWUcg+dFj4w9gFJMsNo1QFZx8zEfnEfMYpPWSbtc4n6JUZPflCyQ/mgVkNZP32TBUISMtzRTMSn35FLTb41aHb2iuuY35Ow7NC8U6KvjczI2Xztsmp6J4ACctesTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G/Zna+Je; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nxAgflNU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G/Zna+Je";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nxAgflNU"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD4031140114;
	Mon, 11 Nov 2024 05:39:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 05:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321543;
	 x=1731407943; bh=2e+hhuxwuqv5cOTK5itNanEwTzK11GZjWn2ZdwbacCE=; b=
	G/Zna+JeHV5+jWK6b9/dLk5JKKucuK4t/ViRUioBOC53oLFf7yzw4R8CBYQkKRFH
	soWgScPYUHDoXt2VoG51huhPDQ48hSByvXc2yvC9cz1xDpKVeN0aONOFaH3E3uds
	OPE2vE/yP8/zTBs15265SHQ6LSk7gPVuEnhFjZdWWsOCAquBCfPicWPQ1ggxQW9b
	49M+BezZIEIJ42Cr97q9/yAC/we7ara8KmjxxWvjzMeAmx2my01Jf/1+J2Op3EC8
	aJtgV9woPatZeP+IO6eQ5jq+Y9oiFadyAC+EeqklDGe+atpY2inritbISSB2wqQ9
	g5WQWppJO2CL7AcQbVM0GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321543; x=
	1731407943; bh=2e+hhuxwuqv5cOTK5itNanEwTzK11GZjWn2ZdwbacCE=; b=n
	xAgflNUHSHvBl3Zt+g7TeYQqrWkQ6pJl1xh27LC3FfZhNX9bzSx2hTfFELOHZXZ8
	HkOuf76Dt796Q4lXPfqCHHA3kvVOdDPA5kOdDKetEO7P178dJeyP/rQicAh9Qp9Z
	Aam8WpUib8AgroXK5Obd0i0eZJ3yzwJKumj9jGVwyNCEOX4hWU+hysnbWjaGS5Kc
	pSNS1RfFtwgSntL+4bs37WgcEEeufXzf/m5PY1nqIylSd5SDQ9/75PYu7OC8buIw
	NZatKHhCruJLsidpeJSynAb6NWW18YObFUAvqlHFZECJAQ/n3eVbjFIMTv3FL9pO
	EgBsSLAXDWkbm6PMQ8tPQ==
X-ME-Sender: <xms:x94xZ_lvFFKeJXYzLY9jZU1zM-zJN8VA57lW1eYr7zqRO_mOZM4NKw>
    <xme:x94xZy1_z74Rdr2ezhiur4T1OLhMcIV8t_pX3Y9O2cILMtq4NyvijU25kwhLneRNn
    qDjlepcPtN7xLGTIA>
X-ME-Received: <xmr:x94xZ1rsd-Xs5NKlzCyh_jcZlRw9tt0wJvsf6I746DN27wnjAWVYk22pxsgJnJvHMkPhdGIcxc_10RljJtXZRf75vW5ap7hE9izj7JjnLyOFHmou>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x94xZ3nqQ6bbC3st7cdxWTrziXNXDAjBSpUEHpNmlAsPdnm6pRNVxg>
    <xmx:x94xZ91PYyFmw0ahhPQa3EU60QYEvAP3qdpoEYm5UuQLCZ2cOifKmA>
    <xmx:x94xZ2srrDfizOzJyAQ3a7R6MGEjkyYMZajKXm0svk0cprim-Hf5-Q>
    <xmx:x94xZxUwkqar0W4o2msOvmKzJuKEmStFtHU_y0suMN2jI1yWh-VLzg>
    <xmx:x94xZ7CbI4fR2xAX3rPZ6vFVfQLDUxOJDNEAbT04iKSZ5U2_x9WtRe2g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8b97b556 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:48 +0100
Subject: [PATCH v2 19/27] builtin/branch: fix leaking sorting options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-19-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
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
2.47.0.229.g8f8d6eee53.dirty

