Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979B1A5BBC
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447203; cv=none; b=uO6n3FgTb5xAGfHmrZETbC7ytChnxywF/CwkdasFc1Bot3BNnCl0zO2nEmfFQOZ2129+8G56Ji9lCEA2Gwnq2ACslJpH21mwxTxQl8daG/c0/UU0nM1T/ezmmrUdHV3RhcDFQdAPChg2l68lSOGXF/jgPjvyuM6UBvuP8R67gUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447203; c=relaxed/simple;
	bh=82nY+yeu7+ZC5/vC5qbxfo+d9kltawe6rKct+a/fVVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TX8HZqif8bhxBHx4Qn71PVXp5IEVa3L7CNAnyVBZ8KSi7REul4UPlnlwbHZKGckWiWzEA9PMPtM/8cx035v4M45J2n+AegbvJEYt/lJLqaaXZ2BJxohe8EFb1BMTv4uRwVjQpulkJVZZGRnvIenOBpFB1a+A7p9LH0Yqx5UPyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SAaF5ZIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ws6xG+2R; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SAaF5ZIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ws6xG+2R"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7BF33EC00E7;
	Tue,  9 Sep 2025 15:46:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 15:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757447200;
	 x=1757533600; bh=7Ejhq8NeuTj0QyBP8xpoxg7/qdaUkPrxGrCmFa3NTrA=; b=
	SAaF5ZIntmfSKbZRcD9tFLTgZhemQcAeYFb1gzeA40iq1Him6Tvj9pCC/Y5A5hjd
	JoU/9M5WUWV15B4KkbjGw9pIdnr7G8SrSy7/rq1ACe44V0elSIR5nhRBgRK4ThJh
	/BqkjPfvm7Go/K8RdNxI4hJ1bnBCELeIcfrP2OJT3RyrMSTon2koWi8X69BPNWJ0
	nbx+xVTqOaK1AHLDzntTcQELbbn0Zwwmh7ETald5hEM40U//OyJD4f9lvLwUKcjF
	FlMODtR7d0dO+Kk3UFXYUCCGV478OfpArgSbDsxNui6bkp7mmQJ2SjHu9BiDyJ/4
	+zo6MZw/IC9OlLQgIROV6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757447200; x=
	1757533600; bh=7Ejhq8NeuTj0QyBP8xpoxg7/qdaUkPrxGrCmFa3NTrA=; b=W
	s6xG+2RSsZveyN6mGdkpCyoL9w57n6Uf4aIlXarosdPVa+6KuWbZihzRhKHlBcyR
	+Jo+Adr+7EeYtUxpV23CX3LlnCWepPYxtpOHHG87Oa0PMyaurOTCoXqCsCMgpbRC
	VIsmZB989NiN35pB+RdcYvBhHUmC71ep4elT6iNemV1N1RSaNoi2PyM4Vrk2XQsy
	vo+u29IYf29s4b8r4gbcR+9koHrEInhD5NE3zU0IoY/R2j2Yqq8tqGZqjSjrfQT9
	FwwtHuoME23y9NatPij4wUioGji+WNt+ANTEUcdFV5VDzjqCTTY/UrsQ1sNIUcyC
	LR2eX9LuZoZZyxIbpA4xQ==
X-ME-Sender: <xms:IITAaMDg8JwR9jlFvxvm7PUzoNhWv8RoTV6tvwSDwFzDF04pG7mcRak>
    <xme:IITAaKDEjpBXUgiCz3jiv3vmvzaIINWPKLDo3-5W8WfTr2tv4yetUYd-KR526g5Ws
    gYgBO3-7Sjhxlx2Eg>
X-ME-Received: <xmr:IITAaGCiklqKRWzreHUlXZO66sTig3S4m7DgDvH6VVQDL8W1GDaJ7HvQ_CF__ZUBidVZWR9UjA2RGpHNCO6HFHByyJRCRm2Jfr-v246rMUcrSgPtYhFQPBMv7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:IITAaNof53MsBdEJnbwGNU8LQiau4BCywhSWULvYaA6CnP8aLubp1A>
    <xmx:IITAaInF-mxzx_j3Y69ouYqkXcx1nDktqPrbitr8iBs1vUYurlrRnw>
    <xmx:IITAaFx5xPJ3AJAFs2mWl10iHGmCnoUOL-CLo5TpqQk2uWqMjDW28A>
    <xmx:IITAaI-V8YIOqURLezCztseHSCbnX96vtvqjRVYvgVTiT7rH6errKw>
    <xmx:IITAaIbBL5f7wHML7h_kWGpSkH4jw7xhNGFsOSUkdfY2_L90dZ8iJ_Ql>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 15:46:38 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 1/7] git: add `deprecated` category to --list-cmds
Date: Tue,  9 Sep 2025 21:45:51 +0200
Message-ID: <66e6a9554b16b2079e5613a415a2d27a601d146b.1757446619.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757446619.git.code@khaugsbakk.name>
References: <cover.1757345711.git.code@khaugsbakk.name> <cover.1757446619.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

With 145 builtin commands (according to `git --list-cmds=builtins`),
users are probably not keeping on top of which ones (if any) are
deprecated.

Let’s expand the experimental `--list-cmds`[1] to allow users and
programs to query for this information.  We will also use this in an
upcoming commit to implement `is_deprecated_command`.

[1]: Using something which is experimental to query for deprecations is
    perhaps not the most ideal approach, but it is simple to implement
    and better than having to scan the documentation

Acked-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    
    Incorporate Patrick’s suggestions about the for-loop refactor and
    formatting the overlong lines.  Now drop the function doc since it
    doesn’t apply anymore.
    
    Also adjust the commit message now that we use it in the C source in an
    upcoming commit, not just/only as an assert-helper (in an upcoming
    commit).
    
    v3 (new):
    
    This is something I wanted to submit independently until the point about
    aliasing builtins was brought up.[1]  It will help (in a small way) with
    the upcoming patch “git: allow alias-shadowing deprecated builtins”.
    
    By the way: should `command-list.txt` be updated in some way (I didn’t
    know what way?)
    
    🔗 1: https://lore.kernel.org/git/cover.1756311355.git.code@khaugsbakk.name/T/#mee19f8d39572f9021f9d3000758e87b6c32c967c

 Documentation/git.adoc |  3 ++-
 git.c                  | 24 ++++++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 743b7b00e4d..a2f0838b168 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -219,7 +219,8 @@ If you just want to run git as if it was started in `<path>` then use
 	List commands by group. This is an internal/experimental
 	option and may change or be removed in the future. Supported
 	groups are: builtins, parseopt (builtin commands that use
-	parse-options), main (all commands in libexec directory),
+	parse-options), deprecated (deprecated builtins),
+	main (all commands in libexec directory),
 	others (all other commands in `$PATH` that have git- prefix),
 	list-<category> (see categories in command-list.txt),
 	nohelpers (exclude helper commands), alias and config
diff --git a/git.c b/git.c
index 83eac0aeab7..fca6ebfce3d 100644
--- a/git.c
+++ b/git.c
@@ -28,6 +28,7 @@
 #define NEED_WORK_TREE		(1<<3)
 #define DELAY_PAGER_CONFIG	(1<<4)
 #define NO_PARSEOPT		(1<<5) /* parse-options is not used */
+#define DEPRECATED		(1<<6)
 
 struct cmd_struct {
 	const char *cmd;
@@ -51,7 +52,9 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-static void list_builtins(struct string_list *list, unsigned int exclude_option);
+static void list_builtins(struct string_list *list,
+			  unsigned int include_option,
+			  unsigned int exclude_option);
 
 static void exclude_helpers_from_list(struct string_list *list)
 {
@@ -88,7 +91,7 @@ static int list_cmds(const char *spec)
 		int len = sep - spec;
 
 		if (match_token(spec, len, "builtins"))
-			list_builtins(&list, 0);
+			list_builtins(&list, 0, 0);
 		else if (match_token(spec, len, "main"))
 			list_all_main_cmds(&list);
 		else if (match_token(spec, len, "others"))
@@ -99,6 +102,8 @@ static int list_cmds(const char *spec)
 			list_aliases(&list);
 		else if (match_token(spec, len, "config"))
 			list_cmds_by_config(&list);
+		else if (match_token(spec, len, "deprecated"))
+			list_builtins(&list, DEPRECATED, 0);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
 			struct strbuf sb = STRBUF_INIT;
 
@@ -322,7 +327,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (!strcmp(cmd, "parseopt")) {
 				struct string_list list = STRING_LIST_INIT_DUP;
 
-				list_builtins(&list, NO_PARSEOPT);
+				list_builtins(&list, 0, NO_PARSEOPT);
 				for (size_t i = 0; i < list.nr; i++)
 					printf("%s ", list.items[i].string);
 				string_list_clear(&list, 0);
@@ -590,7 +595,7 @@ static struct cmd_struct commands[] = {
 	{ "notes", cmd_notes, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 #ifndef WITH_BREAKING_CHANGES
-	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
+	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT | DEPRECATED },
 #endif
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
@@ -647,7 +652,7 @@ static struct cmd_struct commands[] = {
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
 #ifndef WITH_BREAKING_CHANGES
-	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
+	{ "whatchanged", cmd_whatchanged, RUN_SETUP | DEPRECATED },
 #endif
 	{ "worktree", cmd_worktree, RUN_SETUP },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
@@ -668,11 +673,14 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(struct string_list *out, unsigned int exclude_option)
+static void list_builtins(struct string_list *out,
+			  unsigned int include_option,
+			  unsigned int exclude_option)
 {
 	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
-		if (exclude_option &&
-		    (commands[i].option & exclude_option))
+		if (include_option && !(commands[i].option & include_option))
+			continue;
+		if (exclude_option && (commands[i].option & exclude_option))
 			continue;
 		string_list_append(out, commands[i].cmd);
 	}
-- 
2.51.0.16.gcd94ab5bf81

