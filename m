Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3D3AA19B
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007276; cv=none; b=eV4cTACD0UffkAmunpM/LOcB8llnpL08CD8OyLmRBqR2TZ+fTqEiRcOwdiCdkUDO5nLCEB2Ojpt/YxQh7L3cNFNXCyamvLbtK3WSQxy2/4V3HoszqfRvr2acMUMXq+AnH74U7or22WMzeOfpn/VnqmvWQmjkempD22q0NwMs5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007276; c=relaxed/simple;
	bh=nUDA0Ix1whoY5ioakC3L8i5kMsfleFN1CB4l2xAWBNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQoVa16sFxPiLNvzoaXX/6WvgBxEasfn7MLII5yDXZeg7/Us0MWaEScVKjGn5xUJabmFrszoii1CoKBKRiuoDBk3me75pBmaMCkDn8KjwUFz1G42yDv17jKExX1fmUlgNWJISQqUdnpMv+OI9mRqqI4lqleNF2rTMBitHXH8/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YNaVO/4d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hNgpT2Sy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YNaVO/4d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNgpT2Sy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D5A8AEC007B
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 07:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007273;
	 x=1774093673; bh=bjV13Y9FBPmdlsBp9jQgfUhkkehERcVgWNgf18imELg=; b=
	YNaVO/4dpchm3VgssFJxPjN8S9opu5XuMVdXyQLQYw3k1NmjY1DEu//S8ft07psv
	N32M8kj1nb1+Lc3YaRaCcUvXVLBa8SDtH44bAFvU330/YBOPl6iPzewh9zRxvfmZ
	ruCxziqfglR0i306yU/D+jqJWkkeaUSk/k8isZXLgbK4FsqXE4SkzS4KeBxjoLcJ
	CqFPAh1DPFPL2yTFS6S0lqG4D2rRlc3xD1q4bcvdmqwyN/G0tc2VkgsSZNKoCnp+
	LFrLiSebKDOg0jDlkNBX18OLTophjIHBR+fWwNLz8clnG/L7K8Yq39iD2AxQxy4j
	tkBvv6X/iYufSlYfH0IZeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007273; x=
	1774093673; bh=bjV13Y9FBPmdlsBp9jQgfUhkkehERcVgWNgf18imELg=; b=h
	NgpT2SyvA6eXAccUc6/7NGSKdvhkQiwQqBMMGgHh1U+2452MvRWKl8F+Pbrc2GQg
	/ZkD/VuA4oogJswdEVrjYMI23l4RUWJOx3ABhCfYaRX5bBKIWRcR8nA6XGAHzQp+
	QRfn8FRfrTDzePMoYGvU55vfMZhn7ChRVqKyyp7QAjW6Eut3tzDhJNVrKAXTFccw
	v98doqF/7BQY8GOR/XjYGbdFkCF4evAKRXbi0f576AqHQUr8bb1Gub2R8bfFgzxz
	99vrTtSO8/4CWbvHGDqlGASoIWWCBxNSQ+AJG5hcPOL0/gDjuKwGKiiStzoXyfrd
	TJqS/sTVEDxaHQKO/0g0g==
X-ME-Sender: <xms:6TO9aQ9g65e9XqFY0trSj5nTYuXDOgLcCDCkX6f4UxWcIDeYsPCgjA>
    <xme:6TO9afp0-V1CfzetYFLLS1rPqNT1AHYEIOK58O0PrMoqY0NOvP3UbHriHGays9orP
    pn8YMV613iClgKObIKmZWf1UI9YblFM5P_2dYWcMQM-M8eGlFbTwg>
X-ME-Received: <xmr:6TO9abrV6UDCe0jYXnTs0eBxog8LRpjAuQyQEfLbhoEv1SeEOPZkz_OokrnZz115SNh6XErO4x33r9ux-Z755-GQze5tmt7H--fFZHBhzfjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:6TO9aVmdgnXgBzdwL4GQ_N9reFwi74MTNatd6uQN5lsRaT2-LrN3Rg>
    <xmx:6TO9aVHqKz-7agI8EPuJtBJxjYubRwdT7EaL2U7E2zSbWu_I3UB4KQ>
    <xmx:6TO9aWp3jly58gg6xJRuxS54L4sMJIr7DA1z5NAOi6Q3eDAE0dDrKw>
    <xmx:6TO9aZ4dqXgBl5eiDcFaYbRaueONtGxlI6voDBK93Np5gtDv4lMFog>
    <xmx:6TO9aQv1rOlZKnAFGkaZUfF9HHLW3zYGJ94u3XLE8tV4cOd0dfddA2mt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5e668b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:47:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:09 +0100
Subject: [PATCH 04/14] fsck: drop `the_repository` in
 `fsck_set_msg_types()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-4-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We implicitly rely on `the_repository` in `fsck_set_msg_types()` because
of our reliance on `the_hash_algo`. Fix this dependency on global state
by requiring the callers to provide the hash function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/index-pack.c     |  6 ++++--
 builtin/unpack-objects.c |  3 ++-
 fsck.c                   | 27 +++++++++++++++++++--------
 fsck.h                   |  3 ++-
 4 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3d1f7dbd5f..c4117e5970 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1932,13 +1932,15 @@ int cmd_index_pack(int argc,
 			} else if (skip_to_optional_arg(arg, "--strict", &arg)) {
 				strict = 1;
 				do_fsck_object = 1;
-				fsck_set_msg_types(&fsck_options, arg);
+				fsck_set_msg_types(&fsck_options, arg,
+						   the_hash_algo);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
 			} else if (skip_to_optional_arg(arg, "--fsck-objects", &arg)) {
 				do_fsck_object = 1;
-				fsck_set_msg_types(&fsck_options, arg);
+				fsck_set_msg_types(&fsck_options, arg,
+						   the_hash_algo);
 			} else if (!strcmp(arg, "--verify")) {
 				verify = 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 9596b3ea4f..3e748a55d9 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -649,7 +649,8 @@ int cmd_unpack_objects(int argc,
 			}
 			if (skip_prefix(arg, "--strict=", &arg)) {
 				strict = 1;
-				fsck_set_msg_types(&fsck_options, arg);
+				fsck_set_msg_types(&fsck_options, arg,
+						   the_hash_algo);
 				continue;
 			}
 			if (skip_prefix(arg, "--pack_header=", &arg)) {
diff --git a/fsck.c b/fsck.c
index a7ebab9581..efd987dd2b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -182,7 +182,8 @@ void fsck_set_msg_type(struct fsck_options *options,
 	free(to_free);
 }
 
-void fsck_set_msg_types(struct fsck_options *options, const char *values)
+void fsck_set_msg_types(struct fsck_options *options, const char *values,
+			const struct git_hash_algo *algo)
 {
 	char *buf = xstrdup(values), *to_free = buf;
 	int done = 0;
@@ -207,7 +208,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 			if (equal == len)
 				die("skiplist requires a path");
 			oidset_parse_file(&options->skip_oids, buf + equal + 1,
-					  the_repository->hash_algo);
+					  algo);
 			buf += len + 1;
 			continue;
 		}
@@ -1404,11 +1405,16 @@ void fsck_options_clear(struct fsck_options *options)
 	kh_clear_oid_map(options->object_names);
 }
 
+struct fsck_options_parse_config_key_data {
+	struct repository *repo;
+	struct fsck_options *options;
+};
+
 static int fsck_options_parse_config_key(const char *var, const char *value,
 					 const struct config_context *ctx,
-					 void *cb)
+					 void *cb_data)
 {
-	struct fsck_options *options = cb;
+	struct fsck_options_parse_config_key_data *data = cb_data;
 	const char *msg_id;
 
 	if (strcmp(var, "fsck.skiplist") == 0) {
@@ -1420,7 +1426,8 @@ static int fsck_options_parse_config_key(const char *var, const char *value,
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addf(&sb, "skiplist=%s", path);
 			free(path);
-			fsck_set_msg_types(options, sb.buf);
+			fsck_set_msg_types(data->options, sb.buf,
+					   data->repo->hash_algo);
 			strbuf_release(&sb);
 		}
 		return 0;
@@ -1429,17 +1436,21 @@ static int fsck_options_parse_config_key(const char *var, const char *value,
 	if (skip_prefix(var, "fsck.", &msg_id)) {
 		if (!value)
 			return config_error_nonbool(var);
-		fsck_set_msg_type(options, msg_id, value);
+		fsck_set_msg_type(data->options, msg_id, value);
 		return 0;
 	}
 
-	return git_default_config(var, value, ctx, cb);
+	return git_default_config(var, value, ctx, cb_data);
 }
 
 void fsck_options_parse_config(struct fsck_options *options,
 			       struct repository *repo)
 {
-	repo_config(repo, fsck_options_parse_config_key, options);
+	struct fsck_options_parse_config_key_data data = {
+		.repo = repo,
+		.options = options,
+	};
+	repo_config(repo, fsck_options_parse_config_key, &data);
 }
 
 /*
diff --git a/fsck.h b/fsck.h
index 7d0d876103..3ca1683f74 100644
--- a/fsck.h
+++ b/fsck.h
@@ -118,7 +118,8 @@ void fsck_set_msg_type_from_ids(struct fsck_options *options,
 				enum fsck_msg_type msg_type);
 void fsck_set_msg_type(struct fsck_options *options,
 		       const char *msg_id, const char *msg_type);
-void fsck_set_msg_types(struct fsck_options *options, const char *values);
+void fsck_set_msg_types(struct fsck_options *options, const char *values,
+			const struct git_hash_algo *algo);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
 /*

-- 
2.53.0.1055.ga2ffed1127.dirty

