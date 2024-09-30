Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8417A5A4
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687596; cv=none; b=jomzpk459AYbTsYWzx3tlCga3lGGV7UuvPRKOffD4zomqJLA+nMIx1LkkQkJ0DFuNqvpLPz62qLlJINIoQAEGc4rawLITqEvOZQD2cNnln8n7CCK+Mv42GAFWjfPKNhVe98922b08CCXbU4za8WKIC1r6wvrGCi40513/A9kYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687596; c=relaxed/simple;
	bh=NAuKVxJVIqwyH9FbAQoE2sJvXDVgn9OTPaRjSYRaYKs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utIjyz45EovF7opHSJgXkAbyrHJO8hjIU2EOYJVFX/Y7V+xq122F0LcLl4Kk/Unp8q77WftFaNYbFYadVIb+adc13prkYGAUnhGm7fZ4sq8Ta6PZ9QS9spewlREhI2DHGca3G+dc+olkJqFBciWI+/qlrqXRr+iPD8G3gewT6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q3Jb6qIE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8p15ENa; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q3Jb6qIE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8p15ENa"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA1AE11401C0
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 05:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687593; x=1727773993; bh=/+iEFVksHw
	3ckGIFAJFBIeZD3j5d4/LzbVzZaO3IbPg=; b=q3Jb6qIE5O3YuIZ5PhfGUMqRMN
	BN30A9Pyh5t2TiZalVGUgBvR6HiAVhBAiY2btrlHfO2oGJbzKUODySqwI7cop28v
	07OOPs4JbV45VJ/j4uGdYMcjZV8qB3+K3M2qalCFBJ5G8SMy6MDcovRdQGpCA/BQ
	/PotaDK2W0RYKd+tnQ1E95PO+fcZOUY/xmwZarEU29PnUocn8yntWRSmGeQXOjou
	6saBAyI7CQmK7RlSWHOZJEH+emd3spxxmy0MitFae30uA1BqA4Bsjdc7uljjHygL
	ENPfUwKS+wyEz4ZNN+bUw7gBRErAa5+Ivi6StJIGjQ0xPe/Ma/Rb2nyvyR4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687593; x=1727773993; bh=/+iEFVksHw3ckGIFAJFBIeZD3j5d
	4/LzbVzZaO3IbPg=; b=K8p15ENaQjxW7Yr/tM1neQcShi1lvdqiYk20BLm8QRxm
	1710srIC1QjsAhuQWLcZNWXIVb/29RnN7Gl9ngJZuFucs4Asf8Dr43q91ikbCvAg
	u+FpbrYv0RTi5opLZam1yxPu8zsx2XTStT3dugwxzD9Naru3zQBJKjsn0brc7Kz/
	0lOqEnfdyCfWXoXtGh80hJKAJa28Wf5BhjqKTPAgD1mNbAq+M5W4bt3g1pqvE2Oc
	iwRiBmu3wCFBF/HJ6iZhhioFdNKWKxNvM41CqnUzDVO48CSQb0QPuVfZHNVXGXYS
	E9PGylZySsFqdMdVuzksFKZ2QSbIDEbV6wau6dQQPw==
X-ME-Sender: <xms:qWv6ZlW6d2-j9aqaGWgubov_qVTXwGwpVutoyr3-hN-ggmBJhPCIbg>
    <xme:qWv6ZlnQtMs955dgSaXy8BiMY6x6ubPKcBG2fhOkPGT_76GuBQvHtzwkOdZcced39
    CWqXH6IN6LJqxmxNA>
X-ME-Received: <xmr:qWv6ZhYEmWbCVSFLfpX3-iynMVtVhvc0IiW0MeMJqE-NFVWuCRl8zX6au8J9UUzmDru59fHUCN8MBmb8Cl1C2Ud94gY0e_woxuWFT8dKzGN3Bq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qWv6ZoXt_UWGP_Xr8tkTXIty_082KXZ2BRI3cxVDxfpNrLX-Hcbpkg>
    <xmx:qWv6ZvljY3m5f4G88rQnbLqsoL7YRHv1PxlWkG7tjGJt3lAi-nNWVw>
    <xmx:qWv6ZlfjlZONa1QZFljiI--8vYDdQm6uGVuq8J1RSeIRo2LHiNXEjA>
    <xmx:qWv6ZpGH4_kG6-0X0gS-VJPEeG5NKLdcrtIIFxkL0in4KdTdB_PRfw>
    <xmx:qWv6ZntE0cZniyZbQTepKFh_8CFOnOQIfUL0Z_LLx5OLBn92JSAPWK5H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 986ab7de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:27 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/23] builtin/annotate: fix leaking args vector
Message-ID: <0a2a2085159e3817100fb639f2c9908fa7ee2f8b.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

We're leaking the args vector in git-annotate(1) because we never clear
it. Fixing it isn't as easy as calling `strvec_clear()` though because
calling `cmd_blame()` will cause the underlying array to be modified.
Instead, we also need to pass a shallow copy of the argv array to the
function.

Do so to plug the memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/annotate.c  | 20 +++++++++++++++-----
 t/t8001-annotate.sh |  1 +
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/annotate.c b/builtin/annotate.c
index a99179fe4d..03413c7df8 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -15,13 +15,23 @@ int cmd_annotate(int argc,
 		 struct repository *repo UNUSED)
 {
 	struct strvec args = STRVEC_INIT;
-	int i;
+	const char **args_copy;
+	int ret;
 
 	strvec_pushl(&args, "annotate", "-c", NULL);
-
-	for (i = 1; i < argc; i++) {
+	for (int i = 1; i < argc; i++)
 		strvec_push(&args, argv[i]);
-	}
 
-	return cmd_blame(args.nr, args.v, prefix, the_repository);
+	/*
+	 * `cmd_blame()` ends up modifying the array, which causes memory leaks
+	 * if we didn't copy the array here.
+	 */
+	CALLOC_ARRAY(args_copy, args.nr + 1);
+	COPY_ARRAY(args_copy, args.v, args.nr);
+
+	ret = cmd_blame(args.nr, args_copy, prefix, the_repository);
+
+	strvec_clear(&args);
+	free(args_copy);
+	return ret;
 }
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index d7167f5539..d434698919 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -5,6 +5,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 PROG='git annotate'
-- 
2.46.2.852.g229c0bf0e5.dirty

