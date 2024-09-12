Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C61A42AA
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140595; cv=none; b=n2nq3h5DQoHmW8ZYMfstvtJt0Jk6WPJoF8MFU/6yqgHZ70elwLecySsAIalCXKNGd4hH+JjwjK1fiHTIawjwv0jKGNlacmbddvbDQLTfkL7fwrn8+xHkK3YIInQvsZcJEFiNyWfWzFAMfM186guK16rr67h78jsajLHXkqfVbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140595; c=relaxed/simple;
	bh=fSCdOtp7TcKC5KRao/zbUmBXCPnn/1xpgY7r6C0HL7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDka7Xojfmor//PijLIjoXFfHFYIdAauhQhWkMFofh7KPalV6KQ0FOLVHShKiy8lZbrq9STnHb+iARQoD2UlJtwLVRQiw/xH2RJDcdRyJRov2eUuWAMdSMy0OI8+ZaIqraKPGMd9CYU7r2eMcpyt2rJXvwmCN9PoO4bghgYW4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=US8ngGV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dm96CQyU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="US8ngGV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dm96CQyU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FBC411405E3;
	Thu, 12 Sep 2024 07:29:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Sep 2024 07:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140593; x=1726226993; bh=b6zuSIOKwK
	1g+ZH/hm+RxB1LuZgj1gvTKZZq+3nQarw=; b=US8ngGV3d4RLy87ozecFvbsjR7
	gi2kxyQ2Q+Ulx74pclDKMT1C5HKElTeMPLky/0sBRTdIIRNRwhyI+xvbzyf07T2T
	pcvNSDY9mCkTJ3XEz5fGFZ/gNzY7Hz7DBzhIYCcgT9RHe85JNQmfdBR2h6DBtfYP
	kvFiEDPX5TGQwTYQmNQ4av5VMNA5jGVLqbipEYRFhd91RjiNDmY/n9Qeuc/cmx5A
	KCzdWZsL6xWVmqz43YcLzo/R9F/vQ3PfIc+lpuXec3JfWVRjnXzexaGIw2b9wwnR
	wppNWRCEy6WDmjWiiAauD9muuAJkCoKobUwXOdCmRWOy19H3tgVwn+r0XUQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140593; x=1726226993; bh=b6zuSIOKwK1g+ZH/hm+RxB1LuZgj
	1gvTKZZq+3nQarw=; b=Dm96CQyUkHtS3TDiVlkKG7D8JAKHelngEvXWGlAgeFJX
	sO7di46cONBpFqokfRfF1y2Xkh6ZL1Iw7KnlMzwq0nf6iPH05J2TLyiY7hx1Hn/A
	bnf1+/8R84lglNdvV/AMyqieyub0cCJSye22bvwPTB9fBL6sYWxd8ey9WWUmlvJy
	9lbAFTXpD07RVs8PxyyciAj7Wfa7hc9LbKj9IpzvWVXVu2D0M0KNqTPSl2cvVohj
	CoOvGmLAwa6I9Tp0Z7SUb5Tfzo9cDsUnaCUGGHVGF55lTN8wpAgPSAad5sWhFHti
	DyReBM9L56M//xeDSsJh0Vc851mu3irSyvy7AcH1xA==
X-ME-Sender: <xms:sNDiZg1-EzR3MhHNO-HIrqMsEArQmI7moU2ib1o76heT3WMPwmxbbg>
    <xme:sNDiZrF1fnHBoTQeKeK-oYeEMlQlLfXQOafYyPhOBl_T1Y6rmEXCU3XSWrIjKeRk8
    sWqsslxF0Sh5JQLkw>
X-ME-Received: <xmr:sNDiZo56IeVuYsScxm0bjbuqyCjep9RSgaeizdVdvm2LlXBIvr7fUBOXqrVGoKcrrsC9wB5CyikvC7X5kvBins_D87C5J6OMN6NNvYiX_aHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtgho
    mh
X-ME-Proxy: <xmx:sNDiZp0uKAcwsTcfyOr2c5tqF1I1Ls5RanwGmqmUPWhq_ca_ZoCoYA>
    <xmx:sdDiZjGr_IDMqx9k8tPNNX462PADUYeJBHotzumolnwGrOJOrrn_Rw>
    <xmx:sdDiZi-Gdb3ad862JGBucJsMx5T0caTMyqQt1xouM4ldFhboIwxjvQ>
    <xmx:sdDiZontiSlTkmi8MwsDB5C7YqYrGZQRK5juqtd0_Gn1wdORTds7sg>
    <xmx:sdDiZkPtf4inhVtOifmPHcsXGrhMVOQaAtVPKWyE_wkBkJQSfq_KQJMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1bae4791 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:42 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 10/21] environment: make `get_git_namespace()`
 self-contained
Message-ID: <85c10fad522ba6d7369129d115e5cc240ef6d352.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

The logic to set up and retrieve `git_namespace` is distributed across
different functions which communicate with each other via a global
environment variable. This is rather pointless though, as the value is
always derived from an environment variable, and this environment
variable does not change after we have parsed global options.

Convert the function to be fully self-contained such that it lazily
populates once called.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.c | 57 ++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/environment.c b/environment.c
index f337efd1dd5..49844418419 100644
--- a/environment.c
+++ b/environment.c
@@ -122,8 +122,6 @@ int core_preload_index = 1;
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 
-static char *git_namespace;
-
 /*
  * Repository-local GIT_* environment variables; see environment.h for details.
  */
@@ -146,27 +144,6 @@ const char * const local_repo_env[] = {
 	NULL
 };
 
-static char *expand_namespace(const char *raw_namespace)
-{
-	struct strbuf buf = STRBUF_INIT;
-	struct strbuf **components, **c;
-
-	if (!raw_namespace || !*raw_namespace)
-		return xstrdup("");
-
-	strbuf_addstr(&buf, raw_namespace);
-	components = strbuf_split(&buf, '/');
-	strbuf_reset(&buf);
-	for (c = components; *c; c++)
-		if (strcmp((*c)->buf, "/") != 0)
-			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
-	strbuf_list_free(components);
-	if (check_refname_format(buf.buf, 0))
-		die(_("bad git namespace path \"%s\""), raw_namespace);
-	strbuf_addch(&buf, '/');
-	return strbuf_detach(&buf, NULL);
-}
-
 const char *getenv_safe(struct strvec *argv, const char *name)
 {
 	const char *value = getenv(name);
@@ -205,8 +182,6 @@ void setup_git_env(const char *git_dir)
 							  : "refs/replace/");
 	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
 
-	free(git_namespace);
-	git_namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
 		set_alternate_shallow_file(the_repository, shallow_file, 0);
@@ -229,9 +204,35 @@ int have_git_dir(void)
 
 const char *get_git_namespace(void)
 {
-	if (!git_namespace)
-		BUG("git environment hasn't been setup");
-	return git_namespace;
+	static const char *namespace;
+
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf **components, **c;
+	const char *raw_namespace;
+
+	if (namespace)
+		return namespace;
+
+	raw_namespace = getenv(GIT_NAMESPACE_ENVIRONMENT);
+	if (!raw_namespace || !*raw_namespace) {
+		namespace = "";
+		return namespace;
+	}
+
+	strbuf_addstr(&buf, raw_namespace);
+	components = strbuf_split(&buf, '/');
+	strbuf_reset(&buf);
+	for (c = components; *c; c++)
+		if (strcmp((*c)->buf, "/") != 0)
+			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
+	strbuf_list_free(components);
+	if (check_refname_format(buf.buf, 0))
+		die(_("bad git namespace path \"%s\""), raw_namespace);
+	strbuf_addch(&buf, '/');
+
+	namespace = strbuf_detach(&buf, NULL);
+
+	return namespace;
 }
 
 const char *strip_namespace(const char *namespaced_ref)
-- 
2.46.0.551.gc5ee8f2d1c.dirty

