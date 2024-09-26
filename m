Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8410175D2F
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351172; cv=none; b=FbnPTiSBiqrQ1vraNzuRkvGsFRzRLmLOURFltBiSh9MlBA0v3YNtIRMKOUFgUTr4Bg2Hxkvf2ii7Vbda6ugc1LkU+U/osnR12RA82/AlXbklEutjp6kfm3+PIkeYGvm61X8o0GnKxGPKK94m6SfnWSGKYp6po5IbudQlvJZi8kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351172; c=relaxed/simple;
	bh=N29Z6FCFX4LIYLi4VuafNX1bdgnYjuYAa0dOszjbEwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSn/9vxxmgaU+ZgUWnSmNfq37XUZQzIBzq+wiyRWgYuFJdzIRxU4HJBTiC5tgP3XwWqli/CWfQQ5U3+LCV6E+Hy+JUH19kyacSk+/GH5mACRj1oA5z6hzqyovoAUD65Hz1juTftNyfxJbiKqFnLjO9ihEIGwmLNBeunQ28IzhcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AIMntsZ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/JVKWXL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AIMntsZ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/JVKWXL"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E74981140287;
	Thu, 26 Sep 2024 07:46:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 26 Sep 2024 07:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351169; x=1727437569; bh=cOtAXVypPJ
	zDa3172izHSAEX8Z8/gnl71DjQa0yTJGo=; b=AIMntsZ9SPPq2uKP8uhbKGtpLt
	aQW8fILP62GqTiEv3pVGq5H9dFaOhOpASX4ZV+ad/Gmwpq0QMtV4yS1u8AF1Ree0
	kRIiU4vLd1R+DSOYuxeQeIUxGwFRJ9cYzbXpIYaQa8naKHn/K/jQlCnTIdkFR9+/
	vbc9XU0a6WDvSlBB8026ihKhce0JBQlIWnc/cu3YaslVny0h2BsndcOtI8z4JNR/
	i/91YG2efkhKzfpr9xJD+45LNaW1DzsM3VZxuXFQInmfh8hLeuWd4cXPMp4mBslJ
	Ot3Ont00PXxZfCQreUiu9F9dN3j7GaezhGF519mVEG7DGYLnePgR13IMcWbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351169; x=1727437569; bh=cOtAXVypPJzDa3172izHSAEX8Z8/
	gnl71DjQa0yTJGo=; b=G/JVKWXLiOOjERid0SzJvRukM85zb3S8gjroH1JIHyYo
	+3pRaKMi3kc3AVnTna8DuGq5T26LhwOEBMVXlNJRgYlhBluOj+cEbWUmRXn9c+OB
	OKjza0zY8tKUVMhr87jFi0+dqOc/3U66thcq8WFHTxs4joaklpuivzvVw38ANUp9
	Wd7ltYfyIRrZ7B58nQZ69C52Wxn3tx3sC1UgHUgMI5ubfpgLeJ/iPEJXj8vESsHy
	pfkaJO6yoXfsM2lKgD1bdCPPXD5JqFH/ND1h8QjXlC/OWdZvPDCOgZlJO1eUA5pi
	jzLZKZ8Msl0Mg44Ty6KhVdBC8dO46qZppbxjpljfPg==
X-ME-Sender: <xms:gUn1ZtkmtRECegXHHHRzRvKganxnXb5yTgPjlJwyOfjUuTwR-2-CvQ>
    <xme:gUn1Zo2cCpFEMOFIXlGxPWlQyIuEXoUexof1ifrgq_3dxltWI-TGr3yI42zsOy9tp
    DhZTabWCTCCT6BXsw>
X-ME-Received: <xmr:gUn1Zjquh9m00aufywWhcZlcNy7e7lF3D1Lrcil7QNsZPcftl1WXbEao3TBY6NGYXCEXhRANa-Q1se7NiJsTiPBLa2nwgk5gNC5luaIFOFM_MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gUn1Ztm2qLOz-gMqpiay_Pw4RpkIdWntUxpWiI6sZInn_zUObYi-nQ>
    <xmx:gUn1Zr2UbA2ZFxVsKXpqO9hC6fSlkyce4L4cfsh2CprVp41x2u7BTQ>
    <xmx:gUn1Zsu-_8mdtakz5sVQ37M7zAbUDg7yEV-IikS02sUVTNn6D35sMg>
    <xmx:gUn1ZvUvECdoRb3vw3y--udKDezOx8_xRspYlhS1ySV-Fz-4fLdQfQ>
    <xmx:gUn1ZswSd2_8W9RZmIxSK1YrWi8jyR8O3J57Gx0Az1-sMu75hGZlmk0a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id afba5aab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:31 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/23] git: fix leaking argv when handling builtins
Message-ID: <ea3dd851add1eeb5d53063847b73480b5f6245ed.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

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
index 9a618a2740..3c7fabfda2 100644
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
index 1d273d91c2..9eae0d8356 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -2,6 +2,7 @@
 
 test_description='help'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 configure_help () {
-- 
2.46.2.852.g229c0bf0e5.dirty

