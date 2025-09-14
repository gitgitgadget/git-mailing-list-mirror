Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E32E612F
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879447; cv=none; b=VZ7nJRrEcK0TrrsCzoyMfp8yof3Ce169lPJGVMFeEdakLEFUMSb7VsgVz1BYRSWC4qfe+G4mNNYGageArRWIkalGLBNQhOQU8fC7CuYKg+vzqZjKcmtDTK9/R6pJCRg7sjzVXk61XPbxp0mGAo09/0HV0nQoAEtVmKyT2RlQty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879447; c=relaxed/simple;
	bh=GaudBUSmWWLfLW8Q5ZL4gMRQHgbR8MK7vWmWV48DNsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qItsCd7xwFepkaNXLaxwqfvKHdenxG3q9vnq4bTvQNJcUr372WtarWHYT/2q6eeEXNBIw4l2IAtPH1CZip75+NsWQG8UucpMvAlEkRrtH2MikLJzqdnTrZaqbIJ7CRl4WvLkmgGEEHrrk9wrjZpCBVzSR9DiwvUE9ln4GDfIU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IMFqvXb1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=doS4Bec4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IMFqvXb1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="doS4Bec4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E4BE41D0012B;
	Sun, 14 Sep 2025 15:50:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 14 Sep 2025 15:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757879444;
	 x=1757965844; bh=FQMuvClqA3Fgz2T6n5g4tpjnxPAGUj7/jTUIjSovzBU=; b=
	IMFqvXb1m6mCj1r6EbKBaQlhN5Itpzx8ACWWQLq09IUruSqrQzby8q2QkNB/dtqv
	TTYTaqCkcomByAZJDYCFOCpE5GweDF0NU96C9VWaEgZ2XPBU1Pjb1uwWeO8QY0OF
	mIutCruUKhwB83OQo/I3iXmDRoUOLgImbbeR0sqyTsZRL4G//a1oqyO7RMjuayob
	yKCjodxb2Q8PSxSkhEYK3DNKw48eti20SBPXltCVgQfXgHOW97uw/KOgjY+y9l/y
	5PE3alxgafpAs1AKUUGDullpDR0YpSNLn59f3X5oROKCJKgkt549v5ouJ151l8Oz
	GXzEzrcoy2wcX28b0jQ9cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757879444; x=
	1757965844; bh=FQMuvClqA3Fgz2T6n5g4tpjnxPAGUj7/jTUIjSovzBU=; b=d
	oS4Bec4x5sXqbTVEktrMQUU6uOb87PG6KCT67DBw3Vbge/tkcH4GED0chJUu/5Yr
	FIkUdzOzcW6svQIQXK+u+wgT+E+RoE8v46LhEFeVIJHOOeoom3YicB0NOncOVn0n
	31k78Vr+1EGged0P4jmDS/3THI0c0uF3hcwwPTBN23RM719G7a80pmPczp3J51l6
	b9S6aOjnH6l8EHKQpwFtD7l+wICVi98du/ZzTinj4z1Ag9TSmkcDiWkIQnyqdqW0
	lMc4S+WMgVXdbrroWvV3JkSMvsi5k17n22/QB+pkcIBnNJmhtmaUhFfRhQPNgMi+
	fioLJ/nqONkfDPbXVyE2A==
X-ME-Sender: <xms:lBzHaN8V4-oTbULAlQRWE6qRq3nWafwPHBzBYRUa-22VD_G2zfxDNP8>
    <xme:lBzHaKIErtyr_daubuUFCETsOib2w7UXb5QKYaf2vi1aa-giqGUZpAT9ZEhrXzRtd
    T32aZtpVb8KQlKQzQ>
X-ME-Received: <xmr:lBzHaLf0hvPLFj9tJwQXJL0n_vIFZaKjXhpqZWf8s7fEVaM2S-g511K6LfGvxjijQ1lN8Bx1SQ5JqEgycYL73nrUiZ3INt33sgXaZMxoUHfEgF7fJmxYvL_S1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:lBzHaB9rfKF4qS4HRaCM-wJMs2anaH2wooPAwwDXX2hHqjAHn2cyEg>
    <xmx:lBzHaAqV-7vXl9gaerJTnTmC7EYLFX6pCKrMNoOpvQj3coT-I_uKNA>
    <xmx:lBzHaODnRTFktQTH_9gTq0C7ufhJ7B6Dcethyqr30Na2-B1GSbZm4g>
    <xmx:lBzHaKz-ZMrA69zSi4iNsXFiHMuzv2JkKC2GbSdbW0Op3R3AzjRvJQ>
    <xmx:lBzHaMVGCSz65y3S5iyUxVEVecTblenjBSvodST6ShQwaG_I4Kyq4yLY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:50:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 1/8] git: add `deprecated` category to --list-cmds
Date: Sun, 14 Sep 2025 21:49:35 +0200
Message-ID: <13682553018470845b4b000f0c5fbdac0539c8e3.1757879060.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757879060.git.code@khaugsbakk.name>
References: <cover.1757446619.git.code@khaugsbakk.name> <cover.1757879060.git.code@khaugsbakk.name>
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
2.51.0.16.gcd94ab5bf81

