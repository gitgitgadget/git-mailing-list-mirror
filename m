Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92275198853
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805120; cv=none; b=Fl/ljpqBgcnqxRbseALwVNozwtdqiqPWfgnO0Oyq+ypAHmx8cHmB7Ooz5BabxweN3g6ctHwMwSNpY+WNnXkidu+fSb51Wj3r+7M79EJHSmhSHHdVeA3SqFE0ik2hAB3HCQxCS/geDtpWY3kyQ6Y6jt1lqwxduNl0911kDMg88dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805120; c=relaxed/simple;
	bh=KSWsfajIcUFRTvw5OXCvMJXWv8lmrp53J2EwVytGMyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qte/wj8qxPpNjF1OKA/RPfZnCFgvPO8sg1jxIRHF6rabUPHnxdaFEKdSBeNB7/dyMap69ZyHHcgsFGZlvcXK7Gh+2gRHWF62WqB0zrrsgCuECvbzMGa5vGQJ0G69YmCm6vMTXb5ruvmI2JH0DZ+kuk0frcX3Xkn23ft8y9qOUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R+eOFL4B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBCBVpi1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R+eOFL4B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBCBVpi1"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id E7AA4138FE48;
	Fri, 16 Aug 2024 06:45:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 16 Aug 2024 06:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723805117; x=1723891517; bh=KgsNH8wJ5B
	XMfgoqLPY8FcTf3d+ImoI1XBkyOliaKJQ=; b=R+eOFL4BAz82Xum+GLu1Nd7Kik
	K8TCjIco5YiMOwbDfCuhOS629rYg4r+DVjp4hiwvpw7qu/Y03tswINqmEWumRDWQ
	BJ8Ws57cTj7UIE+76WUE+UnKvEPXiEe23t2y73l2h9/DqpnkeXLEifMnSDhvNL58
	xC3PzsAsNWMn4UO4vKT54QUjpQnOMFgOteZf/GSkrHJKoUt2f4pLUaI3mncYn9XE
	0sBIhKqnGawHE1LcM8F7JC9vY4hqrZmtbuQOWY49TPfJF9cz+SK1U5cx73jSHPcO
	gfSakd88NGtQr9YodS2A4XhXMP9VP+zCsXpBQoZXFXz73VkrqE7+ZRBwk2xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723805117; x=1723891517; bh=KgsNH8wJ5BXMfgoqLPY8FcTf3d+I
	moI1XBkyOliaKJQ=; b=tBCBVpi1YyGSbZurWOuWpufqb3i1LeZyJhAk7SmodH6T
	kvL4T7YN3Tma0yPvpS0VmUAu+yNw8VFTxsn4F/D4w2Hz6dd1HdnJ2xcY3XE7u1qF
	O/iksEnZrJ1sEiugyNZDXa1j6Xn5zeu2scmHK503Ut0Qh8R6KqUfBOF9sh2MzSZM
	ziJyTz6b+9AivBDnAXBvlWK21PU37pel/I2UbO/KuWPM4HflpxgcDv+rtBIuh/is
	bhla4rPZVAbrVo4kLvE5QEUFIhhHhSfm5pCQyewO4u+HbHAP8QL1yFz1M5vft8Ir
	EQXrE+qYdO4fLnDT20QqgHY4Z4KHxRUNe/uOsB0GGQ==
X-ME-Sender: <xms:vS2_Zowjs7f-7up3SJUhFxYanwE2zbetGC0xSUW-sWFYqYJell7nGQ>
    <xme:vS2_ZsQGPJ4EacSxwoAKUeB-av7lBdDCEtl4Ob1eeScHdvpsCpgesuzMwb5pa_mrJ
    bjk4cMBw3gf5h0gFg>
X-ME-Received: <xmr:vS2_ZqVRs3mbptXkm47wtpF0vueIpj7aQw0B_WEBr0TMZvRs4a81fmiC5IP5UgspUskFJ99iQ9_AArgTFSWYaICWIHGtNKsAQJ46ThGotMkrylo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepleeuffeggeehvedtteekiefftddtheetkeeutdekgeei
    tddvhfeuveduleekgefhnecuffhomhgrihhnpehlohhoshgvqdhosghjvggtthhsrdgruh
    htohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:vS2_Zmhts4vjEp0fM-3n7eAuGXCdmKhBwVSF27sUX14JXVIdydktCA>
    <xmx:vS2_ZqDJ1Pc9jWxJHC9HluS71gEnK2DcSLeSWHaV688V1B8Ye9VHIg>
    <xmx:vS2_ZnI1JtMWjfADLbvajDecBx40bpSHrZouX5mKVnUUazCKSsuoPQ>
    <xmx:vS2_ZhC__s7W_uT9EXaAru8kGrGrujsjMpOxlz2usou_m9fyFFgWsw>
    <xmx:vS2_Zs2DoFFZStz_ndePeHtGn20GfId60e1FyRhwqSTPxyhbnfV1NMcb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:45:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 223a9146 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:44:53 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:45:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/7] builtin/maintenance: add a `--detach` flag
Message-ID: <347d0a200201ce215f5b2c46d23de0cdd0181956.1723804990.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723804990.git.ps@pks.im>

Same as the preceding commit, add a `--[no-]detach` flag to the
git-maintenance(1) command. This will be used in a subsequent commit to
fix backgrounding of that command when configured with a non-standard
set of tasks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           |  6 ++++++
 t/t7900-maintenance.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 269a77960f..63106e2028 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1426,6 +1426,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	}
 	free(lock_path);
 
+	/* Failure to daemonize is ok, we'll continue in foreground. */
+	if (opts->detach > 0)
+		daemonize();
+
 	for (i = 0; !found_selected && i < TASK__COUNT; i++)
 		found_selected = tasks[i].selected_order >= 0;
 
@@ -1552,6 +1556,8 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "detach", &opts.detach,
+			 N_("perform maintenance in the background")),
 		OPT_CALLBACK(0, "schedule", &opts.schedule, N_("frequency"),
 			     N_("run tasks based on frequency"),
 			     maintenance_opt_schedule),
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8595489ceb..771525aa4b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -908,4 +908,43 @@ test_expect_success 'failed schedule prevents config change' '
 	done
 '
 
+test_expect_success '--no-detach causes maintenance to not run in background' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Prepare the repository such that git-maintenance(1) ends up
+		# outputting something.
+		test_commit something &&
+		git config set maintenance.gc.enabled false &&
+		git config set maintenance.loose-objects.enabled true &&
+		git config set maintenance.loose-objects.auto 1 &&
+		git config set maintenance.incremental-repack.enabled true &&
+
+		# We have no better way to check whether or not the task ran in
+		# the background than to verify whether it output anything. The
+		# next testcase checks the reverse, making this somewhat safer.
+		git maintenance run --no-detach >out 2>&1 &&
+		test_line_count = 1 out
+	)
+'
+
+test_expect_success '--detach causes maintenance to run in background' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit something &&
+		git config set maintenance.gc.enabled false &&
+		git config set maintenance.loose-objects.enabled true &&
+		git config set maintenance.loose-objects.auto 1 &&
+		git config set maintenance.incremental-repack.enabled true &&
+
+		git maintenance run --detach >out 2>&1 &&
+		test_must_be_empty out
+	)
+'
+
 test_done
-- 
2.46.0.46.g406f326d27.dirty

