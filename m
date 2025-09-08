Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27932FCC1B
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345907; cv=none; b=D2Vsls2Zyr/bpTykXb4zZvL+AwpEkj/kw3/Tje4u84l85i2RUpUrw07elBpSMb0qslp5v+0VEKddeft4yDcnHNsD3sKib3Gs5AemFToUmoGZMBk/FVwB+LbV8zKy54hzpWfWUBNpns78gXVYV5lvc+uW69Of1CYhfCpWjKdWjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345907; c=relaxed/simple;
	bh=DqEFtHjLn1qmV4MyjfneAf46IAiVJbWEFktp4uRAp0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jhld5rrxrEMtYI5d/JOFyd2fIDBpQg8RwF63CT41aAPpqU4egVQkfmjC629f0HU028jyX6al/dDRYcipgWhHTujaNLbccaAr6lpZCAbwkVwdmJ6tPYHF4k50KSOcFkIwSSBsLgHuFOwArfvkk9QoharvXlZCb6J1b0m//5mQtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Id0xGWSZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HSbM5qb3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Id0xGWSZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSbM5qb3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B73A114000C9;
	Mon,  8 Sep 2025 11:38:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Sep 2025 11:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757345904;
	 x=1757432304; bh=21crlXS7AHXpBSiYSJM4DHflXbsszcd+mLPBQClOo/8=; b=
	Id0xGWSZANQnCFTPsQi3Z7AqvJ1kWAjWpwPh8np4d3VW1NjPnx6bgqoBFttDy33T
	Lpow5qtkxG6ZyHJdNogAW2w0DoEq8x0z8EDNAbpiED/M++UmRpJK5KAWG1bPvb/Q
	ZHEtnVZVc3oUWbgrYbPAj3pPAU1KnMIs+A2N0NN1uzwdpCF+eLrahH6/lQWBN00j
	t5JonK63pP0GpMyigguh8d6jbwum0J+3hRc/ovbN2NRW5TGYTyq/eVPiforExhPl
	wz0grVUsc32JNAid9+VmNySMTTrdRG3EsyYEuBVZdhAFRMMvaYSyRRKTXNti3GPi
	ToGZPlw3Z2JUEgmY0ic2UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757345904; x=
	1757432304; bh=21crlXS7AHXpBSiYSJM4DHflXbsszcd+mLPBQClOo/8=; b=H
	SbM5qb3RfKVrKYe2wbHCBfe7cUS/8nMVRvvaZQrafbG8X5xPrHA6jvZBRQoptYCP
	neAIi0FQxZbhALFkBNi7xvi+un/Tz8iuqMqT8SxQ84KRC7VjLifdlOyeI7yTfOpP
	fzRfmntFrr2BQXnxEWh50b5NwgTCNpZn2OP+IaRFSo661IBHNiKcDoseveSnA+qM
	a02mH/uD86u9M7hP6vrEUecTTWIWEKVslBC9JRIdVUjRPtq8jtwbjxm+BmyjYjI9
	6EfsCMvePxpCHYJ6aVj3y0L+U8WECPvUuReG+EA0jeLJ+PtH33u0bHXbVqtyTxS3
	Ns3i4uTBrIMOfZJo5QVuA==
X-ME-Sender: <xms:cPi-aB_yeuR8BtCJu34qvTrhp1imCFgWInW0QA4KJwgWDjRZz4jG9TI>
    <xme:cPi-aAT_XkLuFd8-AvOXyflUSd8typxzIKgYELCU6v-2WfVT38iFHcgTcfacJu2lz
    jNpYeWe8cT3dSqr5g>
X-ME-Received: <xmr:cPi-aLk6YAQ2NxDWklvi471_obQmerEDVNN-uO7QIW_LBLmxo7ChigIHchQpYmfdQoDYYTH45pi4lWSvp2d7xsaBccgqCmoQAHCe59A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvth
X-ME-Proxy: <xmx:cPi-aIRsiI90zcWYeT_NXPj6oY90vbgd5p_FnmlzCn3y7wOmOy4rjA>
    <xmx:cPi-aBMa234QjE5ciCnN_CNvWWsDBXKE14bnEcKf1Qfbz0R8cw1BQQ>
    <xmx:cPi-aJU_Jui96LTaYHwgxAk7OUO6vnL4PGUadXlftodCUGti2JqD3w>
    <xmx:cPi-aAfX8SMu_7pa7wFcoesYPhR5V74uDrcqdLP2oGoWmfpcR8kGmg>
    <xmx:cPi-aFMMG18b4WnlNP1OfaHpEB17nVadfp3-9mVRUZFt6EEn5V7TB0Ij>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:38:23 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net
Subject: [PATCH v3 1/8] git: add `deprecated` category to --list-cmds
Date: Mon,  8 Sep 2025 17:36:12 +0200
Message-ID: <bdc683a92b38884e9428cd4bade1f86960ef432b.1757345711.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757345711.git.code@khaugsbakk.name>
References: <cover.1756480827.git.code@khaugsbakk.name> <cover.1757345711.git.code@khaugsbakk.name>
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
upcoming commit to assert that all deprecated commands will have been
covered in some manner.

[1]: Using something which is experimental to query for deprecations is
    perhaps not the most ideal approach, but it is simple to implement
    and better than having to scan the documentation

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3 (new):
    
    This is something I wanted to submit independently until the point about
    aliasing builtins was brought up.[1]  It will help (in a small way) with
    the upcoming patch “git: allow alias-shadowing deprecated builtins”.
    
    By the way: should `command-list.txt` be updated in some way (I didn’t
    know what way?)
    
    🔗 1: https://lore.kernel.org/git/cover.1756311355.git.code@khaugsbakk.name/T/#mee19f8d39572f9021f9d3000758e87b6c32c967c

 Documentation/git.adoc |  3 ++-
 git.c                  | 38 +++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 12 deletions(-)

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
index 83eac0aeab7..87d61f12594 100644
--- a/git.c
+++ b/git.c
@@ -28,6 +28,7 @@
 #define NEED_WORK_TREE		(1<<3)
 #define DELAY_PAGER_CONFIG	(1<<4)
 #define NO_PARSEOPT		(1<<5) /* parse-options is not used */
+#define DEPRECATED		(1<<6)
 
 struct cmd_struct {
 	const char *cmd;
@@ -51,7 +52,13 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-static void list_builtins(struct string_list *list, unsigned int exclude_option);
+/*
+ * 'include_option' and 'exclude_option' are mutually exclusive.
+ *
+ * The default ('!include_option') is to include everything
+ * except those filtered out by 'exclude_option'.
+ */
+static void list_builtins(struct string_list *list, unsigned int include_option, unsigned int exclude_option);
 
 static void exclude_helpers_from_list(struct string_list *list)
 {
@@ -88,7 +95,7 @@ static int list_cmds(const char *spec)
 		int len = sep - spec;
 
 		if (match_token(spec, len, "builtins"))
-			list_builtins(&list, 0);
+			list_builtins(&list, 0, 0);
 		else if (match_token(spec, len, "main"))
 			list_all_main_cmds(&list);
 		else if (match_token(spec, len, "others"))
@@ -99,6 +106,8 @@ static int list_cmds(const char *spec)
 			list_aliases(&list);
 		else if (match_token(spec, len, "config"))
 			list_cmds_by_config(&list);
+		else if (match_token(spec, len, "deprecated"))
+			list_builtins(&list, DEPRECATED, 0);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
 			struct strbuf sb = STRBUF_INIT;
 
@@ -322,7 +331,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (!strcmp(cmd, "parseopt")) {
 				struct string_list list = STRING_LIST_INIT_DUP;
 
-				list_builtins(&list, NO_PARSEOPT);
+				list_builtins(&list, 0, NO_PARSEOPT);
 				for (size_t i = 0; i < list.nr; i++)
 					printf("%s ", list.items[i].string);
 				string_list_clear(&list, 0);
@@ -590,7 +599,7 @@ static struct cmd_struct commands[] = {
 	{ "notes", cmd_notes, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 #ifndef WITH_BREAKING_CHANGES
-	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
+	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT | DEPRECATED },
 #endif
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
@@ -647,7 +656,7 @@ static struct cmd_struct commands[] = {
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
 #ifndef WITH_BREAKING_CHANGES
-	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
+	{ "whatchanged", cmd_whatchanged, RUN_SETUP | DEPRECATED },
 #endif
 	{ "worktree", cmd_worktree, RUN_SETUP },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
@@ -668,13 +677,20 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(struct string_list *out, unsigned int exclude_option)
+static void list_builtins(struct string_list *out, unsigned int include_option, unsigned int exclude_option)
 {
-	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
-		if (exclude_option &&
-		    (commands[i].option & exclude_option))
-			continue;
-		string_list_append(out, commands[i].cmd);
+	if (include_option && exclude_option)
+		BUG("'include_option' and 'exclude_option' are mutually exclusive");
+	if (include_option) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++)
+			if (commands[i].option & include_option)
+				string_list_append(out, commands[i].cmd);
+	} else {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
+			if (commands[i].option & exclude_option)
+				continue;
+			string_list_append(out, commands[i].cmd);
+		}
 	}
 }
 
-- 
2.51.0.16.gcd94ab5bf81

