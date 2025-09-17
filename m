Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72022D4DE
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140758; cv=none; b=NjQ66rcZN1uw5QC0PRXlONUH0ihJwNbWSkvRFtkC2Dmxe34h4idi56UYMCd/zXaq4wIKO3NWzlhtjnDVNbcNVhR9z7mDvGSz4Y+Obl6e37Ai97V6PbJBscw/dIjRk2x0QO6TCTt4gjoBiu14C+RRY/jOuT7e+uieytjvf5Basz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140758; c=relaxed/simple;
	bh=lolwLa8ei9qRU9cbW7SIsz980n0xN5UuH+om8Wv+cNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CkCveZRHx7MyrUEUgAG7a3E6pYymjUTs+O4TWX3fmUDwMRDeW2EUKVVNwnA3fpBcDG2857na/i7smEzBEiFICOBQF0kYANH2nr3eaKugWPz6Gg0QEm7UMn/WoTG7ypgiRJ1TwcZiN6axUauiO9y3zbsnH/CxC9aydMmazaaoZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WRifHmyx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KtlBpLL6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WRifHmyx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KtlBpLL6"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1ADB5EC027D;
	Wed, 17 Sep 2025 16:25:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 17 Sep 2025 16:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758140756;
	 x=1758227156; bh=pz4Au4/C/Tjah6O+JDJlHz+6Uv2cYsru3h3HjVSHEJQ=; b=
	WRifHmyx1ebaX23V2OpEtSw8zJcgziBlixaft17DUTZrfQ9E9lAzBzOCeOoLHOpI
	QzMQ0J0+nVrEZELKn/Bh1tJBqRr56Vd5PGpZjqNf9U8fWPh+WwVQc0RGjWYJQB+F
	43CZgZTW96GtYPCne5V9E/XyoPttbS1FHkESv1n4cf8yoYwEbeXpgxsFv78TbwJl
	0baNh9pDToYO6YBxZSWu/2drbRWMLxy1KPyUDplmjXDbTqTqnn3+r9X2I/y7bmTK
	y1HI7HwAS3207MDyBeUpvxvtdB/SttbThiLu2wgNzerskazkgMIW8+TVzf/z1ifM
	erWPkbUEUemdFjB2lkCR7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758140756; x=
	1758227156; bh=pz4Au4/C/Tjah6O+JDJlHz+6Uv2cYsru3h3HjVSHEJQ=; b=K
	tlBpLL6/oR2SMQcLnb/Lamt+P2358nV5FLOHKTvMEawDVCZTi5Qhbdh7ylaxmp+/
	RGJevKFlyqmv+iX0Ss609Wx/zsNbWlTeZKuvM3s3cdOBJ9zibM6omrFJb5ApbFgC
	bMfDacifOMdMuZsRlprBpG5jhIcICw0iA9VlVuzuGDdAHbgJh0ECLH0YwilDNSqf
	MwW7waQCXOmbRvG9XV7qATWmtYkgEhz6ZDCRlUw9F7lKs1PH5b+n9Y9TsYD5hO74
	Vi6uQHJ+cyAol4kW3Ns3Fd8LuRFE8DSoeJnJ/YMxp55pkQYFLyIIgWwlJEF95wMw
	cEWs+DXodk7aptzH+aMLg==
X-ME-Sender: <xms:UxnLaNe6evtTry36g3bBDHEKHsn-vPbNAMQmAERN0hejkv5sQM1wKF0>
    <xme:UxnLaDoSFlD42VAMDk6Jy7L-xvPOgUqWwiqkWQhHBc7F-tkaauqqKRquiP1nUiJVJ
    6sKiw8RwPGDaN36rw>
X-ME-Received: <xmr:UxnLaG9OK-u0fE9qBk9jTlU94g-yujrdrnPRS7YR1dRzXU9RIQtsLa_SSxhCicT7MTFmPnf4kZbp4ppvcWKDWv7uJhYlj-yveWOP24KujW94NGiIYY40BoKGvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:UxnLaHfusQAUj0QcVt_aa2kI47BKeinr5Tnk0KbjOy4YCs2CxCnVxQ>
    <xmx:UxnLaIKR5b65RtW1h7pkZebzGiogSNyxtDdDKxvLoZ-SC50gAWYPwA>
    <xmx:UxnLaPg2WnZiQ3FWimtKllFnKkoLI_Xcb-6StoxgPOfX4W-A9P8LMw>
    <xmx:UxnLaOQ7Oi2uI9LpXK-8fzqusASKXabet0BUo3_JDXWZV2g2lf8r_g>
    <xmx:VBnLaF5qlOHcS0jDEfZMZP_3PkoH3rDzyek310o99WW_34jwBELxpV5O>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:25:53 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 2/9] git: add `deprecated` category to --list-cmds
Date: Wed, 17 Sep 2025 22:24:12 +0200
Message-ID: <c10a2.1758139856.short.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.274.gdcb64e51a0f
In-Reply-To: <cover.1758139856.short.code@khaugsbakk.name>
References: <cover.1757879060.git.code@khaugsbakk.name> <cover.1758139856.short.code@khaugsbakk.name>
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
    v5:
    
    Add back the `BUG` check from v3 because I think it makes sense to only
    populate one of the two options.
    
    Link: https://lore.kernel.org/git/cover.1757345711.git.code@khaugsbakk.name/T/#m922b852384911511c45afd458051f52b50dce62f
    
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
 git.c                  | 26 ++++++++++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

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
index 83eac0aeab7..511efdf2056 100644
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
@@ -668,11 +673,16 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(struct string_list *out, unsigned int exclude_option)
+static void list_builtins(struct string_list *out,
+			  unsigned int include_option,
+			  unsigned int exclude_option)
 {
+	if (include_option && exclude_option)
+		BUG("'include_option' and 'exclude_option' are mutually exclusive");
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
2.51.0.274.gdcb64e51a0f

