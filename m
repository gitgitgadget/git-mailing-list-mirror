Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8EF18787B
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530955; cv=none; b=s78yVE4opNQo/gRGtWZIBInUl2DU+5LROk2dLZMX9a5M4AGHFXuo1spza9iVw6s8Wk5OcOmrh95t7IKbu+bzURFZDUnjvlHmcIC7CtdPV6eWrDIf5H9FUhxyUGz9A7CsvQ7vFCCE/INTBhtF/jU/ao/2tqOmaXlDfx+bo5oRDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530955; c=relaxed/simple;
	bh=ujqtWT3V15sawy++z32Z3WRLHGOu9irBBW4kCSqJv7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX4nXFo4u7If3s6vGhMbIJcC07NWkMX6Wi0g4BfVDXBR5dBtU5II9afB2lUDBgn110wmwWA9iRF5FDqnG4h0kiQ7M1UlBsDxcOS3xAgMMrPAmbEWaGD++xrUpIFa2nIrhWb3cjI6DwsDDm13XlaTDrHAqYAq4ZCJdse6LE8ekVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FE6diLP/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jP5jFbez; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FE6diLP/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jP5jFbez"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 935E91380338;
	Thu,  5 Sep 2024 06:09:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Sep 2024 06:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530952; x=1725617352; bh=kWw3q0QTZR
	9BBwcffOcFeQgdGq38RYOJHM0pVyG6120=; b=FE6diLP/a7numpEFe08avK3Qty
	BWvV+yEWmqY+MHoEjOtrgnPJeSY7eBO3sD5kofYEuCgXToArkJSAc6yRi2yT13Ie
	32iHQwxhJwc1y1dn/nLl5J77eOjbJmPpZ7vikZeWyVoJDMRYUEXdus5D/dvdq1tn
	fikyTKJxck8QYSEjRdDDaGj1k7j/T1aPqYUrESss4Vj3SAfEkk1V91CteI7olXN+
	LeuyJE/ogi3INYU6hqaLm91yAANyC61RRFdPQ1wv/kxi659XW2mV3w0c/3gFD6tH
	yyUgdU/aBtxnaXGRLsh/x5l/CfRw975V7P7zMONpqRrQZh/pXPFFbNFcz9zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530952; x=1725617352; bh=kWw3q0QTZR9BBwcffOcFeQgdGq38
	RYOJHM0pVyG6120=; b=jP5jFbezLtGAPh9gwpnXqspr0YuQrLNAtFgAg6JNafK4
	Cj25WfHO77iu4IgbCj8az4DylNFk2FQqpvM/GfDkceZNO9tPXUpxlANJkO4jdzdE
	R5kE4pa+DkTR2Gxs5h76fFpPrcbvm5elBMwUQp9wc2B6DyO6u5e9yEYSK8sXnTDI
	a2H565K6tlN7C8tDtcpX6LGr5KBqgj9bYI1q+Ql+eczcGBnAMh8mu5X/JXsQwjmK
	1TflKpPl/4VK6zWwQUd/rjO43tORBy0wp0ZYcvFxT91nJOSzUMfdOlvVUQzN/JMT
	EhkSezKwNB3Waj9A6E2w90AE5mT9O7jNzdMvRdA77A==
X-ME-Sender: <xms:SIPZZiiksnX_ccaCbyjiAFczEqmVFU5xuSpxzA40q7JmJ4w0iUDEdg>
    <xme:SIPZZjDxYekYr3K866oOnVY4MFLYFwEk3NDHXcf6zEL46zv2yhTcSRN5zTmbRiRS2
    4QYdJRRaHB3LC9YgA>
X-ME-Received: <xmr:SIPZZqEpBU3VDrLEYFwKQ4wPUkdzvkNvSzDOxPdbFqG6E3_2hN8qZ_9BVueFVDp_31m81bT9GZLH5J7ReFIVY26gs5ceNk6FMoyDGaTbyc9RS7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SIPZZrTL6LEl0miZnWM-d1a8K7whZte_Dbm-xlC2JcpbAYyMTx25vw>
    <xmx:SIPZZvw3VgUyzxJd2ipwSveR_89mHd7P1cJ-zL94A1NEe_Gwr1rlOQ>
    <xmx:SIPZZp7aOGFd7S-tO9Du8fRI28PqQg-iUUL4dCThoNxyqnzjEIO3ow>
    <xmx:SIPZZsya5Hlq2WTCOO39G3IthqyC8JSynhDWzIk31IsXNIkXBsFKow>
    <xmx:SIPZZmljMVXxjiTbPLcqu0el4TT_HzVnilNgXjoTQdV4MYNfuH4SyVlm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92e49632 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:00 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 11/22] gpg-interface: fix misdesigned signing key
 interfaces
Message-ID: <ddebe2f6f6b088cf1d2bfea5c89ef7e3fe96026e.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

The interfaces to retrieve signing keys and their IDs are misdesigned as
they return string constants even though they indeed allocate memory,
which leads to memory leaks. Refactor the code to instead always return
allocated strings and let the callers free them accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/tag.c          |  3 ++-
 commit.c               |  9 ++++++---
 gpg-interface.c        | 26 +++++++++++++++-----------
 gpg-interface.h        |  4 ++--
 send-pack.c            |  6 ++++--
 t/t5534-push-signed.sh |  1 +
 6 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index a1fb218512c..ab3b500543d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -160,7 +160,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
 	struct strbuf sig = STRBUF_INIT, compat_sig = STRBUF_INIT;
 	struct strbuf compat_buf = STRBUF_INIT;
-	const char *keyid = get_signing_key();
+	char *keyid = get_signing_key();
 	int ret = -1;
 
 	if (sign_buffer(buffer, &sig, keyid))
@@ -190,6 +190,7 @@ static int do_sign(struct strbuf *buffer, struct object_id **compat_oid,
 	strbuf_release(&sig);
 	strbuf_release(&compat_sig);
 	strbuf_release(&compat_buf);
+	free(keyid);
 	return ret;
 }
 
diff --git a/commit.c b/commit.c
index 24ab5c1b509..ec9efc189d5 100644
--- a/commit.c
+++ b/commit.c
@@ -1150,11 +1150,14 @@ int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct gi
 
 static int sign_commit_to_strbuf(struct strbuf *sig, struct strbuf *buf, const char *keyid)
 {
+	char *keyid_to_free = NULL;
+	int ret = 0;
 	if (!keyid || !*keyid)
-		keyid = get_signing_key();
+		keyid = keyid_to_free = get_signing_key();
 	if (sign_buffer(buf, sig, keyid))
-		return -1;
-	return 0;
+		ret = -1;
+	free(keyid_to_free);
+	return ret;
 }
 
 int parse_signed_commit(const struct commit *commit,
diff --git a/gpg-interface.c b/gpg-interface.c
index 6587085cd19..cf6126b5aa0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -45,8 +45,8 @@ struct gpg_format {
 				    size_t signature_size);
 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
-	const char *(*get_default_key)(void);
-	const char *(*get_key_id)(void);
+	char *(*get_default_key)(void);
+	char *(*get_key_id)(void);
 };
 
 static const char *openpgp_verify_args[] = {
@@ -86,9 +86,9 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
 
-static const char *get_default_ssh_signing_key(void);
+static char *get_default_ssh_signing_key(void);
 
-static const char *get_ssh_key_id(void);
+static char *get_ssh_key_id(void);
 
 static struct gpg_format gpg_format[] = {
 	{
@@ -847,7 +847,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 }
 
 /* Returns the first public key from an ssh-agent to use for signing */
-static const char *get_default_ssh_signing_key(void)
+static char *get_default_ssh_signing_key(void)
 {
 	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
 	int ret = -1;
@@ -899,12 +899,16 @@ static const char *get_default_ssh_signing_key(void)
 	return default_key;
 }
 
-static const char *get_ssh_key_id(void) {
-	return get_ssh_key_fingerprint(get_signing_key());
+static char *get_ssh_key_id(void)
+{
+	char *signing_key = get_signing_key();
+	char *key_id = get_ssh_key_fingerprint(signing_key);
+	free(signing_key);
+	return key_id;
 }
 
 /* Returns a textual but unique representation of the signing key */
-const char *get_signing_key_id(void)
+char *get_signing_key_id(void)
 {
 	gpg_interface_lazy_init();
 
@@ -916,17 +920,17 @@ const char *get_signing_key_id(void)
 	return get_signing_key();
 }
 
-const char *get_signing_key(void)
+char *get_signing_key(void)
 {
 	gpg_interface_lazy_init();
 
 	if (configured_signing_key)
-		return configured_signing_key;
+		return xstrdup(configured_signing_key);
 	if (use_format->get_default_key) {
 		return use_format->get_default_key();
 	}
 
-	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
+	return xstrdup(git_committer_info(IDENT_STRICT | IDENT_NO_DATE));
 }
 
 const char *gpg_trust_level_to_str(enum signature_trust_level level)
diff --git a/gpg-interface.h b/gpg-interface.h
index 7cd98161f7f..e09f12e8d04 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -80,13 +80,13 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 const char *gpg_trust_level_to_str(enum signature_trust_level level);
 
 void set_signing_key(const char *);
-const char *get_signing_key(void);
+char *get_signing_key(void);
 
 /*
  * Returns a textual unique representation of the signing key in use
  * Either a GPG KeyID or a SSH Key Fingerprint
  */
-const char *get_signing_key_id(void);
+char *get_signing_key_id(void);
 int check_signature(struct signature_check *sigc,
 		    const char *signature, size_t slen);
 void print_signature_buffer(const struct signature_check *sigc,
diff --git a/send-pack.c b/send-pack.c
index c37f6ab3c07..31a62e6a98c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -348,7 +348,8 @@ static int generate_push_cert(struct strbuf *req_buf,
 {
 	const struct ref *ref;
 	struct string_list_item *item;
-	char *signing_key_id = xstrdup(get_signing_key_id());
+	char *signing_key_id = get_signing_key_id();
+	char *signing_key = get_signing_key();
 	const char *cp, *np;
 	struct strbuf cert = STRBUF_INIT;
 	int update_seen = 0;
@@ -381,7 +382,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	if (!update_seen)
 		goto free_return;
 
-	if (sign_buffer(&cert, &cert, get_signing_key()))
+	if (sign_buffer(&cert, &cert, signing_key))
 		die(_("failed to sign the push certificate"));
 
 	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
@@ -394,6 +395,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 
 free_return:
 	free(signing_key_id);
+	free(signing_key);
 	strbuf_release(&cert);
 	return update_seen;
 }
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index c91a62b77af..d43aee0c327 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -5,6 +5,7 @@ test_description='signed push'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
-- 
2.46.0.519.g2e7b89e038.dirty

