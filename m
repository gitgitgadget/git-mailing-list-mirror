Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63391898EE
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540419; cv=none; b=KzXB1ZBtAWDUZ9bu7X/2bFIWoEnMALQcYe9Xk33hLTPA/LYbutVNqMnDmxJLVDboEtobOBImMLqo8XXKYhwBMtZF8i/pRK7KwpJdLFnTou9Ff0DRFPuXOhyJn/stA5aX5iAMrKm3oPgFNrPOuJ/0hoxn6kl1WhSqlGRDCKmiCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540419; c=relaxed/simple;
	bh=/ic9MIHL3QyTMu7M7/29asdKmxS5mXFLyhMQuIix2lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIzd49hdR24aRrtn+cac7AjlWl/U04Wuq/yyyCvaGg1XOcSvF6GMc1ctlHhULuqmUsP14lyHP52cbIsPPvPiulPGZGD9E8D7WxeJHkeJOXRqqJwG1gvCDUDyBzNHbQ9EvSolauxU1HTicylBdiuOT6pIFI1YiVLP78aNL58UqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xauqv8HG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klo/wk48; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xauqv8HG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klo/wk48"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E2077138F115;
	Tue, 13 Aug 2024 05:13:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 05:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540416; x=1723626816; bh=hFRlzcjczf
	pxK1ueQ0shAFnbyuNdIiQF5YUy2aP39eg=; b=Xauqv8HGZH0U1K9sYgl/vr5P4H
	R3Og36+L0CIM+kMYZ1bTabWMEZG/LvoGFzUIgCCV94bwLPMw+dG63JLRKBZtwx3n
	PBVylybATLkXgBin1I/MIJkLXzlOyxGjfzqQBlFGnnutMFPPv30JIAwtK+VAo1sJ
	TAqQzLyDGtmDOVDgwZWa451+vpjkwK0d0QnnfIpRtIe35V7e4QjO/pgXzgI766y+
	cQ5Fd3WG7FlP2floup0kXVnYM0fopURUazKaV9Ua/gaHUZ3l2sF1nGlcDoXY8XNk
	Cm7VxIkYm+MaSNHq9br2hVM7DZrf1JL59PsclWeMkKC8AXCoSWe0SfuPhYUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540416; x=1723626816; bh=hFRlzcjczfpxK1ueQ0shAFnbyuNd
	IiQF5YUy2aP39eg=; b=klo/wk48I8YMwlOvOdAbdgT4dlajNG/3f2TA5qlh4NlB
	NMWvwONeu29VWJC7zjSq0aQUxI+6FGe4s5cateTj7twJ0GBLGKzyZbKWPd9lwMY2
	RTP3gtxpBmUsfX04Dy74wk3RnD9SkjSSfh9SZuqEDOWYBeYksRHNnWT05VU19ITk
	UHAHRzEXBLm+sttIOfNlXwRuQcC/9gChaudD9qdkp797e9hrM6FkLq0MEoa/wXVm
	Nul00czzj1yCgi48sSg+MZBNUEziRvm7l8X4X91wJ3sWKI6izLNWNG4KXWagr4Zk
	WXDiHBLVOn0FztnWK9NmYG8i2e55kEu0RHHZ5I9zZA==
X-ME-Sender: <xms:wCO7Zi7Vz2QFvwg1EnhJ7dNREflz8DtwnE0DfoX2PB8l8Ykin0TMOg>
    <xme:wCO7Zr40Y1iTg_UWO0RSBFdsPN20a3OM7hQu9CaGhVsHAmCEHEMWtSR1ZbT4Jy1Ru
    R8bD16a2JguuZZvfw>
X-ME-Received: <xmr:wCO7ZheBKB6D1w6-cX0lXednaGGtQoEgA4tPqtuZC1drhJOYBULs9HkaLU1NfRWlZT1_fYnxRvdkjZT6t--BigZ2Mzca5n8zaw02Nzef7Bj3PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wCO7ZvIMUXOto5yr9FsKNRfoE7kTOKP2Ha_cS1vuFZaum0Hai9mjYg>
    <xmx:wCO7ZmKzf_IWYIVZzwmiis54iq5W5wYLD22VOyhp-Mgqy4ggEB92nw>
    <xmx:wCO7ZgwJyNYro_2cUFTlqj6kM7Q7uMDWFOe0YHeEypfu3ftsWqNr2Q>
    <xmx:wCO7ZqIz-lzex-a00M6IxzgO8XtSJdYPG3yscpQwNcl3Mnxj96DE-Q>
    <xmx:wCO7Zi0EzJU1lxG8BNKy5IIxOXpr7wbI7fyG2Q7Ve0AxwVyiRzr_dI5w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 844a0126 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:19 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/20] path: stop relying on `the_repository` when
 reporting garbage
Message-ID: <bbaa85ebad458c60c59784b690be8be2ddbe76fc.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

We access `the_repository` in `report_linked_checkout_garbage()` both
directly and indirectly via `get_git_dir()`. Remove this dependency by
instead passing a `struct repository` as parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c | 2 +-
 path.c                  | 6 +++---
 path.h                  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 2d4bb5e8d0..ec6098a149 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -113,7 +113,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		usage_with_options(count_objects_usage, opts);
 	if (verbose) {
 		report_garbage = real_report_garbage;
-		report_linked_checkout_garbage();
+		report_linked_checkout_garbage(the_repository);
 	}
 
 	for_each_loose_file_in_objdir(get_object_directory(),
diff --git a/path.c b/path.c
index 069db6ff8f..97a07fafc7 100644
--- a/path.c
+++ b/path.c
@@ -365,15 +365,15 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len,
 		strbuf_addstr(buf, LOCK_SUFFIX);
 }
 
-void report_linked_checkout_garbage(void)
+void report_linked_checkout_garbage(struct repository *r)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const struct common_dir *p;
 	int len;
 
-	if (!the_repository->different_commondir)
+	if (!r->different_commondir)
 		return;
-	strbuf_addf(&sb, "%s/", get_git_dir());
+	strbuf_addf(&sb, "%s/", r->gitdir);
 	len = sb.len;
 	for (p = common_list; p->path; p++) {
 		const char *path = p->path;
diff --git a/path.h b/path.h
index 05aff5f4c3..9a4a4a8fb3 100644
--- a/path.h
+++ b/path.h
@@ -158,7 +158,7 @@ int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
-void report_linked_checkout_garbage(void);
+void report_linked_checkout_garbage(struct repository *r);
 
 /*
  * You can define a static memoized git path like:
-- 
2.46.0.46.g406f326d27.dirty

