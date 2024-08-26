Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419713A899
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656932; cv=none; b=SbHyeV7TOxxmUWtB8hDIy2VvSZNTRiwbQaUhSm3mDhZSaXq+OGRzZum3LolmT5eNL5Inb5DtabpX37J/C0uS5SwXISrDV4EoDtDE4uUrlUSMsFcIgSUeDcbXxXuoRd7Aswabq8YBSCHK5vdid+ysQWgVTzIPxANtnzduiBgKp7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656932; c=relaxed/simple;
	bh=lzUf1E8qGNDvEYMQZhH2ULsH9MueXo4kh7Gryf+i3Gc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKV/vqNzdYT71PKFhYzILg9o3fcBsG0GQdfGzU4S2eC6OY+7AHqaalVLq7rsvK/Onu+G7ghCqjNi2CCt4lRXEgIKps4w/8lgTajUelTGEs79ouoMKG1Q4n0Zp4GVE1J/icOZJBEx3LFRLQiwZgx9La2tnZz9QOaSP0Kqux6K1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rpPdf4Kr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I2R0Ok4o; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rpPdf4Kr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I2R0Ok4o"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8A6A31390957
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Aug 2024 03:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656929; x=1724743329; bh=HRQL1DmHq2
	z1X8D4VBXSshcZ3YMw/KTR3ozQ4S+pWjs=; b=rpPdf4KrUHmQL04E6g6KJF8suA
	QtJlzdsHsJ9k6Gdcz718K0GrCuw6xCLYOFsfyzYfgBQa3U3Lp8NjymnMHWXQM5Wb
	+GVH0gX8Kk2zaJimuOlkNMXtK2Jbma/4tnZbvRM5PygGgNRgQO/CtMK3SjnBRC9Y
	KZ2RUvKZGgjA90e/uoj1xHS8icEM3PxzYevyELK9hqmWKYb/5q98eJna2hLilLM7
	a+flLVwxcTfagEHjQnLP9AaU7InpUFULHX/o2CZYAFbYWlJTEZycPBazkK9qHJxH
	78x+D1sAxzTWrfgOrWUupAhP4N+gPvmiEWd8i1FpbF453DmILJNilEciaBxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656929; x=1724743329; bh=HRQL1DmHq2z1X8D4VBXSshcZ3YMw
	/KTR3ozQ4S+pWjs=; b=I2R0Ok4oehVuZh1vaV3NKaTDed8BxhHLMglh3txAoZ/3
	7ht4JOG29FAeTXCoM/Z21lbxbf40eKeuL05FW0XNKJIbuaS5k7Y63hBes+Ko/YFq
	5Uf0UjeiDPIyc9M67eAHJxu9VyDCLT0n5Ie2wjngRy/5bh1Da4dtjlcd43UX1tK3
	6USDqICP6W78mHdM0rLFa3rDcQeBcPYpxyYtLI3coRKcn+ttsyGfXvBYGnoFcz0x
	Y44i86/XmXp9BOczATI3ETB9FZnFle8s6seLLk5+llCPoIDqK8H53OVmmt/mM/3B
	iI4BErkHLI+LkGCjxsYqQqxbHn/3VCMOi/4eRiRJ3Q==
X-ME-Sender: <xms:IS3MZvyeDgqoMSjrdg_K12YbcPZuhsMoyERBvPD_4Pbw3Hxh-V0MRw>
    <xme:IS3MZnQ1VsuhJOZBo5B2_X8SCBYNx4rd04F4_Wp1ymFmqMEAKhjlfO1tFMomqP5E9
    Xmf-W08lxyF043FBA>
X-ME-Received: <xmr:IS3MZpVSC97iarJ2qMDw6nXO-IwBRVMw2xpxkuueJ_DZ4Sk9ZOFXKgLeNhqYFJwVfdS_oj3v1Mo7MDh9cZ02e95dAOeszeQrWJUmR0O_3stj9wc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IS3MZphzQ1Nl_4jtXqx56IL8KgrEKXYcr7rX1Zw2ZdufOoCDwrqODQ>
    <xmx:IS3MZhCM9qlzxdIm_NgFKZbOzmQPQgJQETjp4GOgMmkmWlUG25dYIA>
    <xmx:IS3MZiKfdl88VewhT0szjQXkPNkrkbKqmLc90QYVRK9H90m9xI8x7A>
    <xmx:IS3MZgDfb9qRbVDgA6RvbJxyu9JGp3Xl-tfWvBuMSX5cd7uNfklLrQ>
    <xmx:IS3MZu5ZzNgYDNz1_DemW4IG9GJ5LxstAIFrI5l4w1KbFhd4co81ujz0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d958e676 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:07 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/22] gpg-interface: fix misdesigned signing key interfaces
Message-ID: <a1fca8104b345bff4005fcd7e4c8edb67424fd20.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

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
2.46.0.164.g477ce5ccd6.dirty

