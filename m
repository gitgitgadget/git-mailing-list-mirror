Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0F3176FE
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295292; cv=none; b=CEbtaJOQo04yn1N0EYVAwIg0G1kd2+tOvpWOYed0akbX++4XM9uOkBKGfmreJQBgTNaPqu4v3V2zOpfDOJy3mhqtOpgY+aQ7Y8bQs1aEs+vECPFNxl+3GCcKgMtuRPMV5BBtDVwSr/I4Bxgm0To0DEkXPIbto1p1XZKRmChl1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295292; c=relaxed/simple;
	bh=+YtSsUUBFd3Pr0MCyOK/6s/XmJ4//LNAxdqpMJqYAEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r5wY8WEegLAvWI5t2kVO3dCsMLqwjvEt1WZfC5ywcX44XzrLM+AYhS80tgUHkBR3pv/H2keBwWKUbOpI1LaOPrmrFgYyNkiRBlQqwfKGcJeDl19Fv46VlfFQqgwBfDx4fJat7/MyNU5VwyOXXJNXYIxCtC8LCBzGVcfueXEclWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G04Dx3bX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcAM4yFk; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G04Dx3bX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcAM4yFk"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F2197140006C;
	Fri, 15 Aug 2025 18:01:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 15 Aug 2025 18:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755295288; x=1755381688; bh=YB6FPWDh1+
	MGGr5vL9r8SWtnLfvcZ8hHU6OoREkZ7Bs=; b=G04Dx3bXm0IcJIfDJJrutVd3qc
	DPDif5EnB4bfNHCbdEwUmRQqb8WTf50x3+utJ9Mtv8DvtnWkXfg8GrcKsbqCflPH
	u4zZbEhPQQvQ3bG+HDK653H5blmejYx7jj5TcEAxfFfI+9ZuJPqlLbnqD86sZGo8
	C2egTnI6A+x5eGaQfg6j37t/4EHSfv3B+5nvIZRaHcHimkMei+ur7hUiA4/gr5QK
	Es/IpWK6A4LjOKRTS8EBMk9qPVTPap49lE1As5QOgHI57z7AnzfQHeWuotpDDn+N
	WPr/xVYqWO4WiW7trpxeHNsLQeNuHIDHOCeJNpEUzd6SvVAwxfGEYn1Wl82A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755295288; x=1755381688; bh=YB6FPWDh1+MGGr5vL9r8SWtnLfvcZ8hHU6O
	oREkZ7Bs=; b=UcAM4yFkOpaUTzhn3clQ0Dt/+eGVLeE9ePoKOfhO6LD30P3GqvJ
	IdybQsNn3PBQayLajv3q8Z27fV76luS9JrMcUwqlCP2q8c8mxIIrJ1KrXJikzj91
	KhMd2u1Qw6ReLTlVOq39/dfJ13sRI6hQ7qxjB8Okcd/8nLCrYzWtvc0HQXK7C9PF
	/j6aHi/SsJjTf2vMfk+qbIY0aGNyR94L2PbkIPVIZeo22roBjAHlRTuGSChr9IKO
	MTqh97/fZKI64B7pMh/ggvSt1MLVn3K952CN5cRRwJqp0M8hd7f+6xAScxbCoMBL
	8drQ9O8Vt8Nx20fEEboXMa1wCrlol2JYgXA==
X-ME-Sender: <xms:OK6faAOLgERN1_CqB82nWk-gvPWBTvSiXGIq65qWd62-bRDG-qmKiA>
    <xme:OK6faAYYpRVZyeefJonO56YZBvEEJLlywnWCJQF3MUmRZMhm4D0dIwOPF9ntgJiAO
    NeumQogE2H8zh8baA>
X-ME-Received: <xmr:OK6faG3s_jJIUmTajGbFnoRItg_O_B0n9P1ow6V1_nDldXlWK1EachZoUhUlhXmLORwGcxmtfif2MGI0rzLyGTg89GpNT_u_YrmG3yo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepheekueefheegiefhveevteeugeduueeftdekveettedthfejjeffudekjeei
    gfevnecuffhomhgrihhnpehflhgrghhsrdhnohenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgr
    hihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehophgvnhhsohhurhgtvgesgh
    hrvghgohhirhgvghgvrdhishdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:OK6faOerW8EE_wkXk8NxzM9dPDcFQhWwwdrBHh-x9OQpVnp6WYHnkA>
    <xmx:OK6faPGhmpYdhXJ4uMXnicieUpwnhaR7z3gGkYwbQxijM3Glvd6dFw>
    <xmx:OK6faH0MlPg3iMHlfu2C6SN-CWCdlEX0iDXzPmevXN4wRkUl7WTMKA>
    <xmx:OK6faHnJHknpGsPkVYBjYU8S32pc0a4UbdoQdeJv7Edu0cFwhTFo2Q>
    <xmx:OK6faLtdh07WqZQfEW15Lmro3Co1ys1IEcRGhGEBHCuNF5LgN7WfzIFB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 18:01:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  Gregoire Geis
 <opensource@gregoirege.is>
Subject: [PATCH] diff: simplify --no-index taking advantage of the fact that
 prefix==NULL
In-Reply-To: <xmqq1ppk58ob.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	09 Aug 2025 17:20:36 -0700")
References: <xmqq1ppk58ob.fsf@gitster.g>
Date: Fri, 15 Aug 2025 15:01:27 -0700
Message-ID: <xmqqsehsmeh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Since the caller of the diff_no_index() function now undoes the
effect of setup.c:setup_git_directory_gently(), i.e. figuring out
where in the working tree the cwd of the process is, recording the
cwd relative to that top directory in the prefix, and chdir()ing up
to the top directory, we are now guaranteed to always have NULL in
the prefix.  When started outside a repository, prefix would already
be NULL.

Take advantage of this fact to simplify the implementation.

 - The code that conditionally calls prefix_filename(), except for
   "-" given from the command line, can go away, as there is nothing
   to prefix.

 - The temporary variable that points at the memory allocated by
   prefix_filename() for later freeing can go; so can the loop to
   free them.

 - As the prefix_filename() loop that had to special case "-" is
   gone, we do not rewrite "-" to another constant address that has
   the same string, file_from_standard_input[].  Teach get_mode()
   function to strcmp() between the path(s) and "-" directly for
   simplicity.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 88ae4cee56..8bdd0021b1 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -71,9 +71,8 @@ static int read_directory_contents(const char *path, struct string_list *list,
 }
 
 /*
- * This should be "(standard input)" or something, but it will
- * probably expose many more breakages in the way no-index code
- * is bolted onto the diff callchain.
+ * stdin should be spelled as "-"; if you have path that is "-",
+ * spell it as "./-".
  */
 static const char file_from_standard_input[] = "-";
 
@@ -97,7 +96,7 @@ static int get_mode(const char *path, int *mode, enum special *special)
 	} else if (!strcasecmp(path, "nul")) {
 		*mode = 0;
 #endif
-	} else if (path == file_from_standard_input) {
+	} else if (!strcmp(path, file_from_standard_input)) {
 		*mode = create_ce_mode(0666);
 		*special = SPECIAL_STDIN;
 	} else if (lstat(path, &st)) {
@@ -305,18 +304,18 @@ static int fixup_paths(const char **path, struct strbuf *replacement)
 	unsigned int isdir0 = 0, isdir1 = 0;
 	unsigned int ispipe0 = 0, ispipe1 = 0;
 
-	if (path[0] != file_from_standard_input && !stat(path[0], &st)) {
+	if (strcmp(path[0], file_from_standard_input) && !stat(path[0], &st)) {
 		isdir0 = S_ISDIR(st.st_mode);
 		ispipe0 = S_ISFIFO(st.st_mode);
 	}
 
-	if (path[1] != file_from_standard_input && !stat(path[1], &st)) {
+	if (strcmp(path[1], file_from_standard_input) && !stat(path[1], &st)) {
 		isdir1 = S_ISDIR(st.st_mode);
 		ispipe1 = S_ISFIFO(st.st_mode);
 	}
 
-	if ((path[0] == file_from_standard_input && isdir1) ||
-	    (isdir0 && path[1] == file_from_standard_input))
+	if ((isdir1 && !strcmp(path[0], file_from_standard_input)) ||
+	    (isdir0 && !strcmp(path[1], file_from_standard_input)))
 		die(_("cannot compare stdin to a directory"));
 
 	if ((isdir0 && ispipe1) || (ispipe0 && isdir1))
@@ -349,9 +348,7 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	int i, no_index, skip1 = 0, skip2 = 0;
 	int ret = 1;
 	const char *paths[2];
-	char *to_free[ARRAY_SIZE(paths)] = { 0 };
 	struct strbuf replacement = STRBUF_INIT;
-	const char *prefix = revs->prefix;
 	struct option no_index_options[] = {
 		OPT_BOOL_F(0, "no-index", &no_index, "",
 			   PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
@@ -359,8 +356,11 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	};
 	struct option *options;
 
+	if (revs->prefix)
+		BUG("caller of diff_no_index() forgot to undo setup");
+
 	options = add_diff_options(no_index_options, &revs->diffopt);
-	argc = parse_options(argc, argv, revs->prefix, options,
+	argc = parse_options(argc, argv, NULL, options,
 			     diff_no_index_usage, 0);
 	if (argc < 2) {
 		if (implicit_no_index)
@@ -368,18 +368,8 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 				  "compare two paths outside a working tree"));
 		usage_with_options(diff_no_index_usage, options);
 	}
-	for (i = 0; i < 2; i++) {
-		const char *p = argv[i];
-		if (!strcmp(p, "-"))
-			/*
-			 * stdin should be spelled as "-"; if you have
-			 * path that is "-", spell it as "./-".
-			 */
-			p = file_from_standard_input;
-		else if (prefix)
-			p = to_free[i] = prefix_filename(prefix, p);
-		paths[i] = p;
-	}
+	for (i = 0; i < 2; i++)
+		paths[i] = argv[i];
 
 	if (fixup_paths(paths, &replacement)) {
 		parse_pathspec(&pathspec, PATHSPEC_FROMTOP | PATHSPEC_ATTR,
@@ -406,7 +396,7 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	revs->diffopt.flags.no_index = 1;
 
 	revs->diffopt.flags.relative_name = 1;
-	revs->diffopt.prefix = prefix;
+	revs->diffopt.prefix = NULL;
 
 	revs->max_count = -2;
 	diff_setup_done(&revs->diffopt);
@@ -428,8 +418,6 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	ret = diff_result_code(revs);
 
 out:
-	for (i = 0; i < ARRAY_SIZE(to_free); i++)
-		free(to_free[i]);
 	strbuf_release(&replacement);
 	if (ps)
 		clear_pathspec(ps);
-- 
2.51.0-rc2-158-gf97fc618fa

