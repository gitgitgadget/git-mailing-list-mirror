Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012515575B
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487133; cv=none; b=ab5c9Vqw+qZLCviB0/IxdUMcY+mk40wUKsaZu1QUw4++rKND8aUx03C5BJGesCJQGew6ehrP0hHeeGnC8alKWu9iTJ8RWbtpJfNciPb+pUa+tRpCKinUKQ8TpdNT0RL8SJRUsCF1bdylSsYKlmCQQE3DOqgK2cV/R2YWOPkSZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487133; c=relaxed/simple;
	bh=/Mkj4LhspWe9G/jHPGzpraKAibeOo+VefIElPFTFQPo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+3u9YbFW/h2Rfj4TIFO1Ybe9RjnhgiRJHp6UEnXsVti8sZ/7BAdbn4uhdmNL2ruGqZA2R80xk2LZSUUGFnMKajMc5nP29NDSJgR+JsoQKTWVlbkbyY5KGj3tUwXPPPH8/7YVCROl7ECERjN09XmDti+dhM1WAqmWG2gbM2V2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WK6AQXuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JS/e6M+n; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WK6AQXuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JS/e6M+n"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D3991140125
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 07:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487131; x=1726573531; bh=Gy9dRi/RIr
	FcIF9V2ABkUu47w1+Eyo2IO+2FM5Eh8cE=; b=WK6AQXuhUnNdDbb59ly2QPC+rr
	9NaWZUIsxX0xmWhImotHzSb7GtREomTVMHcT09zEV2qA8J4LbMuTF3Uc/GVqY8GU
	RpK3eWTS9QciizQQKy6dwynrr609U+lElA8F7yv5Z4TUrmIljeDocQvMEOryoq0S
	091A1pGNgPnHkNSfM3kjwApvUMrMM1SbUkU0opliQeNFJ2G+UoLWj/cxQMbj+Att
	g1Gp0b1g4iHIWyjv5NB1X0zob+g8uYkvZaNV4ou1DJCWHdGie5wI9jL8LoMvlG3e
	FRcLolIhvzmPKTew50NEV+U4HipEHa6nJhmksIRrExjVapGppKJoXnB8RIAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487131; x=1726573531; bh=Gy9dRi/RIrFcIF9V2ABkUu47w1+E
	yo2IO+2FM5Eh8cE=; b=JS/e6M+n/Y0aMsRz5a6VHg9LEaHLHTSEOhfKv94lkINA
	msyQnlXN23xhZsyCtT4/GyxMb0J5K/KOFmETKlO94XDeVmDXYpAqB2rh9vhl6zhn
	KcGfPwq3hHr3h3xpHOIn1g8eLHx8OB7cegyRUiEJnhjL12ziEUzrnt2dCsw1hw/o
	bzxIEsAq6RtyYIfSHp2/aE/bZusj3wNrPJsYk2GPIvELiQEDf2q/GMypd7hQFY5G
	Om41nukaJ3iG0uTBYllUJzDSPkMj8cKUkSjFQqtb/Rf+qHmUSE+LAxDoYazPcfJh
	sNpfj719wWwAH45kT6LT7Vfe2EshP13YxmSouuUBVQ==
X-ME-Sender: <xms:WhroZnzIv8Zhs48tNRD1P8dFmWkgXv8C3pH6rM0R4kbU8Djl2Fkh5w>
    <xme:WhroZvTgDZBfje9tSmo3Ngrep_QzV2ly_tisn6iRaDFbrZeu6lImOGVFL6-8bwFwS
    fJ37NNJhFdAUglqGQ>
X-ME-Received: <xmr:WhroZhVYVL7-RACtw5Z7fIVURagwo-UmzoVtWkwii1de2O0WNvBBtujzzYWvmAOrpZIyHB0wVs65_YZvqo7EXvziMEYqRxxqLY4XIvNiysUAZv02>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WhroZhjLS3_Yr8m-FZX43kWL2jIzjd-3Y-wV9nZV-gzg95nq3pOrng>
    <xmx:WhroZpDNIJK5IjmPpwmC2Pg4b1EhlP3GIEZeZy2BvWXTGDjFJS_r_g>
    <xmx:WhroZqKCTZLl2w8uH7f9r1NDVDRq6o_RZFK3zYueRQ4WG6SXACm3Rg>
    <xmx:WhroZoC8U0q5Y76CIU0bEm9cCFAEp2u6p_85evwH2lNvHOmcI50Wrg>
    <xmx:WxroZm4huNmtnWu88osmTuw0SXMsz30jt4sgqIsz6Al2uD_eBUQmb6cE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 31bec77c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:13 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/23] git: fix leaking argv when handling builtins
Message-ID: <ea3dd851add1eeb5d53063847b73480b5f6245ed.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

In `handle_builtin()` we may end up creating an ad-hoc argv array in
case we see that the command line contains the "--help" parameter. In
this case we observe two memory leaks though:

  - We leak the `struct strvec` itself because we directly exit after
    calling `run_builtin()`, without bothering about any cleanups.

  - Even if we free'd that vector we'd end up leaking some of its
    strings because `run_builtin()` will modify the array.

Plug both of these leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c           | 22 +++++++++++++++++++---
 t/t0012-help.sh |  1 +
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 9a618a2740f..3c7fabfda26 100644
--- a/git.c
+++ b/git.c
@@ -711,6 +711,7 @@ static void strip_extension(const char **argv)
 static void handle_builtin(int argc, const char **argv)
 {
 	struct strvec args = STRVEC_INIT;
+	const char **argv_copy = NULL;
 	const char *cmd;
 	struct cmd_struct *builtin;
 
@@ -731,13 +732,28 @@ static void handle_builtin(int argc, const char **argv)
 		}
 
 		argc++;
-		argv = args.v;
+
+		/*
+		 * `run_builtin()` will modify the argv array, so we need to
+		 * create a shallow copy such that we can free all of its
+		 * strings.
+		 */
+		CALLOC_ARRAY(argv_copy, argc + 1);
+		COPY_ARRAY(argv_copy, args.v, argc);
+
+		argv = argv_copy;
 	}
 
 	builtin = get_builtin(cmd);
-	if (builtin)
-		exit(run_builtin(builtin, argc, argv));
+	if (builtin) {
+		int ret = run_builtin(builtin, argc, argv);
+		strvec_clear(&args);
+		free(argv_copy);
+		exit(ret);
+	}
+
 	strvec_clear(&args);
+	free(argv_copy);
 }
 
 static void execv_dashed_external(const char **argv)
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 1d273d91c21..9eae0d83563 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -2,6 +2,7 @@
 
 test_description='help'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 configure_help () {
-- 
2.46.0.551.gc5ee8f2d1c.dirty

