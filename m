Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2149118F2FB
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540442; cv=none; b=fSHdzNl69mfHBh/QEDBwBqqFS29uwx3Lc3xYFuYLDToadU6p1wZ1akXVOuuNsLjPHyPzfPtnESr/AT2kqu9+gSeqGTFdM3uqHoMjzDl+ky/0yHfoIGSVMvUP+rem+3nP4ZwvROm5Bnfa4+rp/6/EZA+FgDQhrTSOr7hqeaAkNQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540442; c=relaxed/simple;
	bh=C3eBMAYgypUrGtw5QbL7nAXFpF6zqaPnqTL//e3y8ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGyQLLc53KHwgiGXnYPjD/o/hD3ihXyYxN78rqtE89SkxVIX8V/Wq9maFZ/NSgv6mRlJX4duweUCx0lWQq/zEV0OvHDKB+W76y/mk8e385AXOQoqSltr5ho6jdzNXAljnY8C8P5jWUMhITlZChCII5CqskCoYVnLSTv7oPiljoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FnwPZS4i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRDFJtzw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FnwPZS4i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRDFJtzw"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2BF8F138FACF;
	Tue, 13 Aug 2024 05:14:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 05:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540440; x=1723626840; bh=GDh9XV0K/m
	DiOtIKJJgPmT0KG/3IIc6KBKCE6VEC/98=; b=FnwPZS4iu1LlSW9t6hKFieKiJk
	VGuNv0Lss3G97M6eBRvylLjw4CFJ7+8Z+RY/cAPEV7zburK6R7i6XLAuOO1dcZaQ
	OpjkghaG4GMNdy3caK0OWZdlaDxQJgg56PECChPvtWWSfKilpV2iIHSQk+CNyj57
	vT07FmfaNbXOLrIL7bwDLgQkh/CBolFF+cGA7BvO4jfmRdX8+IAOwGxAYDEVF/OM
	tP9OMUtK81vjMCDRf6i3cDo/RVX0Mr9BgOqo52TXZVfPWrgW8zdv2jSJHGQyUlns
	xlkf2XL+WQjz1RXlKEl14Tk54436V0L0SeL4l3HR4Iuq+9SEGJ6HK9DjFqVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540440; x=1723626840; bh=GDh9XV0K/mDiOtIKJJgPmT0KG/3I
	Ic6KBKCE6VEC/98=; b=KRDFJtzw+nelXtqRhxtS5VBFnabbuBphUGLvC84cSvC6
	nH1EZRQiha2/xcaxNqAR9s43cSBz/a5Sqd9b4bqBsru7iXn1eCDacTKlzTG5TyJX
	3AB6e8LGVLq/ZnDmxwVZTozKHxWYeVS0pxZcFCPd5QisZ/xo4M9eyuV42mjV7dMU
	EIPuHLHfyvcwfh/PTQRxN2uGldx/6a+aQiB4fEEDGUmP4rmpw0tQK2EnfTnAgXYA
	WnkfYfpMSujP88zHkLUO22lqHvjC0qyWQ90Ax7vLwds7FN1pUGIBZt4C423yr3E8
	ujCM2Z/dncnagr4qnB+Rl3DJ+QgpkpO6366dA48khw==
X-ME-Sender: <xms:2CO7ZqCXHBwmj3Lotz9ZD2hr9yYrMtIqVpgXqNw1MLtOf5DYjr4ITA>
    <xme:2CO7Zkhr3He6ABbtISx0zPUztOGwTZ05wAfMe7RnC-tAhxufhs9GAa_P07N4YXCNr
    ssv9a8WuzRQeB7Xcw>
X-ME-Received: <xmr:2CO7Ztm1_F4m38gumD4-wZX7CicY7iV7ylUg2kVSxgmtmGyxYms1HxxP6Ld-Qo7BoIrK16sfFL-qRByWKZ3hJsFFJz3gLNVOMgIKdhkjBGKJMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2CO7ZozP6ZOr26T1V15WwSblSpa15yngfjQsHPMrSxHzZne34ZzXQg>
    <xmx:2CO7ZvTqWAQ43ds_xIjizds530ZjgzRS3AFSnKKYqPn29aIdjyQZBg>
    <xmx:2CO7ZjbeyW4E0kdFbAXJRy8ccQOd_mAK-MejnGcE-VmgU3QOoiIi_w>
    <xmx:2CO7ZoSy_alRrJSH46XIEGl6HW-GI3Da6yo9iSrURvtoz0AdaMqxdg>
    <xmx:2CO7ZpeUfzb3i53dsoWYXlU2aip-13cceD8d95hT-3NZ22pTYCdDObao>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f362fb5a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:42 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/20] config: pass repo to
 `git_config_get_max_percent_split_change()`
Message-ID: <17c5420d6386f46a730940de15eed03d2f9db75a.1723540226.git.ps@pks.im>
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

Refactor `git_config_get_max_percent_split_change()` to accept a `struct
repository` such that we can get rid of the implicit dependency on
`the_repository`. Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c     | 4 ++--
 config.h     | 2 +-
 read-cache.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 89fb7ce6b1..f1d2fb6d4c 100644
--- a/config.c
+++ b/config.c
@@ -2811,11 +2811,11 @@ int repo_config_get_split_index(struct repository *r)
 	return -1; /* default value */
 }
 
-int git_config_get_max_percent_split_change(void)
+int repo_config_get_max_percent_split_change(struct repository *r)
 {
 	int val = -1;
 
-	if (!git_config_get_int("splitindex.maxpercentchange", &val)) {
+	if (!repo_config_get_int(r, "splitindex.maxpercentchange", &val)) {
 		if (0 <= val && val <= 100)
 			return val;
 
diff --git a/config.h b/config.h
index 35cee9d4ca..dd7127b8e9 100644
--- a/config.h
+++ b/config.h
@@ -712,7 +712,7 @@ int git_config_get_pathname(const char *key, char **dest);
 
 int repo_config_get_index_threads(struct repository *r, int *dest);
 int repo_config_get_split_index(struct repository *r);
-int git_config_get_max_percent_split_change(void);
+int repo_config_get_max_percent_split_change(struct repository *r);
 
 /* This dies if the configured or default date is in the future */
 int git_config_get_expiry(const char *key, const char **output);
diff --git a/read-cache.c b/read-cache.c
index 12c2da5a8b..1e52db7f36 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3275,7 +3275,7 @@ static const int default_max_percent_split_change = 20;
 static int too_many_not_shared_entries(struct index_state *istate)
 {
 	int i, not_shared = 0;
-	int max_split = git_config_get_max_percent_split_change();
+	int max_split = repo_config_get_max_percent_split_change(the_repository);
 
 	switch (max_split) {
 	case -1:
-- 
2.46.0.46.g406f326d27.dirty

