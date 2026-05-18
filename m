Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E853E3D9A
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096704; cv=none; b=FrIsfNfU4x0DJlVLaUENwRfXrsmm88NLajQ9Sgv+6KPDJUuM7XCdUon1TxofuXEZB85BaGRdHUZywEh1ltXcnjfLJRUWuJB+j5RgHIiW0v/5fr+jqyNt5omxda01etVF5TIdWSsfeSsGChuVX7PE5qNkT6/UG+L13mmcprP/SUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096704; c=relaxed/simple;
	bh=5Lzq+1dO6dYaLwn1tE0zdPuwo4hlCHu84Ul0S2XMa/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hj5dQ29/H/tJ7gKgSWJEpoiRWC2/ODcTAsZDRfX23m/llkc2XEbpC6P7CPZPp24C8SVjwWyWLTQdIqL2Wfh0LvFaNP4lLO2TUIu6LWs73/mS/Je93+CuBJiGsgsG+iXazPKNbMJwiIF5XH+2OHyhXToPcsQ9sb1rCCYGewLi9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TK4MU9ZI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UTyGY7DU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TK4MU9ZI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UTyGY7DU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D7447A00CD;
	Mon, 18 May 2026 05:31:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 05:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096702;
	 x=1779183102; bh=Pvj13noLJzFtQPgFnY0525vMtJO1ikduaZLQ5aW+BxQ=; b=
	TK4MU9ZIoI+64JyePesA6aZ0TArccx4MR8k6T60+EqJxvwtNmhO2RvjhF+n6476/
	Qr03QGO5Y+QNngeUBcKgNyBrDFyw5D2y7E155NQACgSGhTxAFn+jxG4A5SGgEGal
	EJlrdPAFYvMa64MGBaCCgnKtuBYnaQP9eyFQ5EcBa8yfPmorO1FVt1dlXqbnAFLe
	/1BXIXhpDg6igxCp7WdxQYvNiWDeKibV+HcO477Yio89PLJzZuks/YVTe53Z4Quf
	BNKpCPuwnkGOaz+l0h2SkDI8NcS1WVP1msfx0eP1AQChKpj9x+RS5DH235WjZe6d
	XCN28oVGcCwTkSb7pUzYXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096702; x=
	1779183102; bh=Pvj13noLJzFtQPgFnY0525vMtJO1ikduaZLQ5aW+BxQ=; b=U
	TyGY7DUqZDtq/oSpTOHexjYqh1G22OMvMCod/1Ug2FqilPkNtFVWzyIgAxCSx3o7
	R6sfXIvukUy0pYhke6IZvFqS3cktvPZKTmaJralA2RD5qk2TgMiiU9SR/YAn/rEG
	fdgtADscNls829KyryTgcMaxHZN3xkGR3wkeG3N846HNbi6JLmReuuJUH85UapdE
	JsmfcmXzdLy8PdloUJZ4uwSVXJaIuRww1OO/vdRlWao6eMjsIqlm1RUtVBRXkioW
	yx60Hi8lnIxcnr3fHPj33Suq90C+UhqozniAfu0ojBC6YyYCNMaINZ6fIjWAP51e
	yrgIxvzXa408Nrwmjg+Og==
X-ME-Sender: <xms:ftwKagZleBKCiOMU1UMhUNZYt8iBSoLdi1AHGbIwKpVuX5LsHgCLZg>
    <xme:ftwKaiROu3h3BvaIhXiyZgXnsjH55PQDZsj1ES-KT2fsDM0Ns1bKoBLa8F1fH31uA
    3-akIVCJ4-ME_l0zoHuIZhQ4T0mMY9yZhi4buW6BzTgwKPZItuWWec>
X-ME-Received: <xmr:ftwKajQwN5RwPP2S0mKpraV9EkXJMY-rxIPa1zL0gzDHVW3lNeIc6sT5xYt_iqTFzrbHTRZGJmMIVATvjrH2b4tgXToZYoCFevjwXViFWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ftwKamRoX7549iP_W97nfnfvHlw6qN_6a8JqI162ZzqDi-oYGFtFiQ>
    <xmx:ftwKao4Hr-9IEsbr1vwFBvPD57D3a_zq2qwCk211vkaQC1otT9RvxA>
    <xmx:ftwKai0lNG13ADb_VcihjwfyxZ6zDzksTcgw0HTVDF33IGlJzwfXog>
    <xmx:ftwKajCKT_oqZIkX-P6SkhgGqcqXFJsrmH4PY6pQCDGO8NCHdoSSXA>
    <xmx:ftwKatgpBjJlNdNT_carfSQkqKporoAE_7TucXM-0W4uakmlAtE9KsFA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 402109da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:31:05 +0200
Subject: [PATCH v2 14/18] setup: stop using `the_repository` in
 `upgrade_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-14-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `upgrade_repository_format()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects-filter-options.c | 2 +-
 repository.h                  | 2 +-
 setup.c                       | 6 +++---
 worktree.c                    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index cef67e5919..bc5d98f9e6 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -378,7 +378,7 @@ void partial_clone_register(
 			 */
 			return;
 	} else {
-		if (upgrade_repository_format(1) < 0)
+		if (upgrade_repository_format(the_repository, 1) < 0)
 			die(_("unable to upgrade repository format to support partial clone"));
 
 		/* Add promisor config for the remote */
diff --git a/repository.h b/repository.h
index d391aff8ab..c3ec0f4b79 100644
--- a/repository.h
+++ b/repository.h
@@ -281,6 +281,6 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
  * Return 1 if upgrade repository format to target_version succeeded,
  * 0 if no upgrade is necessary, and -1 when upgrade is not possible.
  */
-int upgrade_repository_format(int target_version);
+int upgrade_repository_format(struct repository *repo, int target_version);
 
 #endif /* REPOSITORY_H */
diff --git a/setup.c b/setup.c
index 5dc27caf15..ed0c14e98e 100644
--- a/setup.c
+++ b/setup.c
@@ -811,7 +811,7 @@ static int check_repository_format_gently(struct repository *repo,
 	return 0;
 }
 
-int upgrade_repository_format(int target_version)
+int upgrade_repository_format(struct repository *repo, int target_version)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -819,7 +819,7 @@ int upgrade_repository_format(int target_version)
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	int ret;
 
-	repo_common_path_append(the_repository, &sb, "config");
+	repo_common_path_append(repo, &sb, "config");
 	read_repository_format(&repo_fmt, sb.buf);
 	strbuf_release(&sb);
 
@@ -841,7 +841,7 @@ int upgrade_repository_format(int target_version)
 	}
 
 	strbuf_addf(&repo_version, "%d", target_version);
-	repo_config_set(the_repository, "core.repositoryformatversion", repo_version.buf);
+	repo_config_set(repo, "core.repositoryformatversion", repo_version.buf);
 
 	ret = 1;
 
diff --git a/worktree.c b/worktree.c
index d874e23b4e..988be84a30 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1104,7 +1104,7 @@ void write_worktree_linking_files(const char *dotgit, const char *gitdir,
 	strbuf_realpath(&repo, repo.buf, 1);
 
 	if (use_relative_paths && !the_repository->repository_format_relative_worktrees) {
-		if (upgrade_repository_format(1) < 0)
+		if (upgrade_repository_format(the_repository, 1) < 0)
 			die(_("unable to upgrade repository format to support relative worktrees"));
 		if (repo_config_set_gently(the_repository, "extensions.relativeWorktrees", "true"))
 			die(_("unable to set extensions.relativeWorktrees setting"));

-- 
2.54.0.771.g3ed373ac14.dirty

