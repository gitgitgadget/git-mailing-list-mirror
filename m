Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2775215F42
	for <git@vger.kernel.org>; Tue, 27 May 2025 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384579; cv=none; b=g+AEFBBvrggGQY2WITF6FvMTs9q1Y8GmAg+Web6iNz19VZiFkAwcRQt0TL5+oLWQnzgwMNbHQeBoaeR3Kvun5ND0mG0MsNMUqHNIGt/eczPbGc1syuwCPYrxgiD/FsPYvg0UyUK8//gflk8IX5LZRdZbLJk+LPQaQKlEXBwzEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384579; c=relaxed/simple;
	bh=aO15pxPqB1MgTvSSNjtUZ4K9QHhs9+SwpiXfcxXUarI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Asd0iynzxh7uZyE6Lq6pZYCGSL66cdy2MqTBuM+IyUeuYkOplyWrEquFZBKvE06Ulga7YW8kLCdEG3qGxzDNkwWtHCONJ5WyMaclEOG276bHFYHElKRE8/hVstvnEUeQfvPFP+f3g9JwHgvZLiITInfCGc5JQ4hvq6Z+pHw10JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xs/UGz5R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxzACCvQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xs/UGz5R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxzACCvQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E503B1140146;
	Tue, 27 May 2025 18:22:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 18:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748384575; x=1748470975; bh=H3x2iBHYzN
	JYoSjdLT8TL6QSwUBlvJ51x/RwBAFRn+4=; b=xs/UGz5R30QypEK0SNoaPfCgmU
	/BGMb4/u8kz+9cKyOPr5pr5MuQQ1hJQxXprUwpStY3Xz6WOG6vljBztOKQCpY1zT
	Z+Wu4XrW9cXjFMmkvOhtst1mA0RSpwkNuTmaT/hgxiI6GNoLasZ6sRRV6SnVi/G3
	eFzvOaJZmHE8q00mx1+bPSivmgmnP5Q66vRQvVWw/37KD3OyH9RSr8NcRZPZ6ely
	/53GEywDOg9XVDHiEMAxBgguyYbJDcGOjcsvzfE5wxNMqvBufDMiqTZq2KWjY0QW
	EaHqx49Glo78F0T6in5WXb5wyjHs4JPJPTWUxYPXWwY0AAMgTZGwtEPz3fCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748384575; x=1748470975; bh=H3x2iBHYzNJYoSjdLT8TL6QSwUBlvJ51x/R
	wBAFRn+4=; b=LxzACCvQyMqAOTrHAU500FGtemKnhkCXRedaMGYymbXwdaYrvRI
	XMJEUI9mHXCLn2yZq8eDfbswI4ZMZw48LO4sHSi3iwgquIOjdmbAGEjVIaGnvm04
	CSHVwbfodZhcOc/pjKnN7wRplWotLbEj8wozwCOYmM8Ah4x0/T+sszh9BaPxODav
	sOIW7582OWRis2S9F12BbNYamodWaj33WAwU33XLq6HV89ITp/RIzNy69Dv8kcSc
	dfXYsE2iEb4QPSn7IW8VRdbqnGDtHkUq1oG8voK8InLDTbXZ0QFeMAGcKBoLdnjd
	8dBKIlb/xuBIW3/PVLwX1jnVsCw2mU7pRyA==
X-ME-Sender: <xms:Pzs2aJ5Wavrddnl-7DnoYHNrhJEzR_V4Fzp6AzObe0JegJlacIM9UA>
    <xme:Pzs2aG7xtk4yPX62S2JKwVKS2YEg9EVMK9bDkAuSBC50rlqE0kute089zxHOdOhe9
    qHI-pGLgZa7XDB8Og>
X-ME-Received: <xmr:Pzs2aAf4lc3Brg7oulr7uHrWHb2f4i7VNGax1dbo3ypbZ1VXzkhA44MNDvDt_ZNQeKFI36iJqe_yNxqQcTd4LpaPR3rAQ4t1eiV94VM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudehieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeigeejgfdv
    veffudevgeegtdelfeekfeeufefhueeuueegtdethfethedvleeufeenucffohhmrghinh
    eplhhoghdrtgifpdhnohhtvghsrdgtfidplhhoghdqthhrvggvrdgtfidpphhrvghtthih
    rdgtfidprhgvvhhishhiohhnrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Pzs2aCJRCENJQm0VpmPj0yWczSQSN04RRZZTWudvKKpw-SJCYAxiOQ>
    <xmx:Pzs2aNLbCodT6p9Ruke63SUTAnZq_50UqAKpQvNh5ymSE6ie9wieCA>
    <xmx:Pzs2aLzgnINt--f1coCUxaf6bfeV4srj6hqnBjjorXvdcX4QudBfLw>
    <xmx:Pzs2aJIpoqPMGH6PM6fiA9DrazHbiG2CFslHwEWHLSBU4VwRP6iXwg>
    <xmx:Pzs2aGq84OkADiqxQWEHmNd18v1Cle44bROtNjTFAuUStzMdOtT8NYdR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 18:22:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
In-Reply-To: <xmqq5xhmvuol.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	27 May 2025 10:18:34 -0700")
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
	<66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com>
	<xmqq5xhmvuol.fsf@gitster.g>
Date: Tue, 27 May 2025 15:22:53 -0700
Message-ID: <xmqqv7plu20y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> It probably should be a fairly isolated change, like the way how
> the expand_tabs_in_log bit is handled in pretty.c; give another
> bit and teach pp_handle_indent to return when that bit is set and
> the payload it was asked to show with indentation is empty, or
> something like that.

An unconditional change based on the above idea may look like the
attached patch.

No tests, no docs, no configuration, and I will not be working on
this in immediate future.  On top of what we can see here, probably
the following would need to happen before we can call it completed.

 - "git notes" should take a command line option to control which
   one of "--indent-empty-lines" or "--no-indent-empty-lines" is
   passed.  Optionally, we can introduce a new configuration
   variable notes.something to control the same.

 - "git log" and "git show", but not "git rev-list" plumbing, may
   want to start paying attention to a new configuration variable
   log.indentEmptyLines (which defaults to "yes" if not specified).

   I am not sure if we want to do this item; as there is no explicit
   end-user request to add such a feature, I am inclined to say no,
   at least not as a part of the "while editing notes with 'git
   notes add -e' the shortlog ends up with lines that are commented
   out with trailing whitespaces, which upsets some editors" topic.
   But it should be trivial to do.

 - documentation.

 - tests.

I've only compiled and then manually tested

    $ GIT_EXEC_PATH=$(pwd) ./git notes add -e

to see how the commented out "git show -s" output embedded in the
editor buffer looked like.

 builtin/log.c   | 1 +
 builtin/notes.c | 3 ++-
 log-tree.c      | 1 +
 pretty.c        | 8 +++++---
 pretty.h        | 1 +
 revision.c      | 4 ++++
 revision.h      | 2 ++
 7 files changed, 16 insertions(+), 4 deletions(-)

diff --git c/builtin/log.c w/builtin/log.c
index b450cd3bde..dc2d7d3a07 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -2148,6 +2148,7 @@ int cmd_format_patch(int argc,
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.encode_email_headers = cfg.log.default_encode_email_headers;
 	rev.expand_tabs_in_log_default = 0;
+	rev.indent_empty_lines = 1;
 	rev.verbose_header = 1;
 	rev.diff = 1;
 	rev.max_parents = 1;
diff --git c/builtin/notes.c w/builtin/notes.c
index a3f433ca4c..b559b39cf0 100644
--- c/builtin/notes.c
+++ w/builtin/notes.c
@@ -167,7 +167,8 @@ static void write_commented_object(int fd, const struct object_id *object)
 	struct strbuf cbuf = STRBUF_INIT;
 
 	/* Invoke "git show --stat --no-notes $object" */
-	strvec_pushl(&show.args, "show", "--stat", "--no-notes",
+	strvec_pushl(&show.args, "show", "--stat",
+		     "--no-indent-empty-lines", "--no-notes",
 		     oid_to_hex(object), NULL);
 	show.no_stdin = 1;
 	show.out = -1;
diff --git c/log-tree.c w/log-tree.c
index 1d05dc1c70..e8ea2481ea 100644
--- c/log-tree.c
+++ w/log-tree.c
@@ -879,6 +879,7 @@ void show_log(struct rev_info *opt)
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
 	ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
+	ctx.indent_empty_lines = opt->indent_empty_lines;
 	ctx.output_encoding = get_log_output_encoding();
 	ctx.rev = opt;
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
diff --git c/pretty.c w/pretty.c
index 0bc8ad8a9a..4974af4d02 100644
--- c/pretty.c
+++ w/pretty.c
@@ -2247,13 +2247,14 @@ void pp_remainder(struct pretty_print_context *pp,
 
 	for (;;) {
 		const char *line = *msg_p;
+		int is_blank = 0;
 		int linelen = get_one_line(line);
 		*msg_p += linelen;
 
 		if (!linelen)
 			break;
-
-		if (is_blank_line(line, &linelen)) {
+		is_blank = is_blank_line(line, &linelen);
+		if (is_blank) {
 			if (first)
 				continue;
 			if (pp->fmt == CMIT_FMT_SHORT)
@@ -2262,7 +2263,8 @@ void pp_remainder(struct pretty_print_context *pp,
 		first = 0;
 
 		strbuf_grow(sb, linelen + indent + 20);
-		if (indent)
+
+		if (indent && (!is_blank || pp->indent_empty_lines))
 			pp_handle_indent(pp, sb, indent, line, linelen);
 		else if (pp->expand_tabs_in_log)
 			strbuf_add_tabexpand(sb, opt, pp->color,
diff --git c/pretty.h w/pretty.h
index df267afe4a..21e584e185 100644
--- c/pretty.h
+++ w/pretty.h
@@ -40,6 +40,7 @@ struct pretty_print_context {
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
 	int expand_tabs_in_log;
+	int indent_empty_lines;
 	int need_8bit_cte;
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
diff --git c/revision.c w/revision.c
index 2c36a9c179..ae6b98e701 100644
--- c/revision.c
+++ w/revision.c
@@ -2564,6 +2564,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
 		get_commit_format(optarg, revs);
+	} else if (!strcmp(arg, "--no-indent-empty-lines")) {
+		revs->indent_empty_lines = 0;
+	} else if (!strcmp(arg, "--indent-empty-lines")) {
+		revs->indent_empty_lines = 1;
 	} else if (!strcmp(arg, "--expand-tabs")) {
 		revs->expand_tabs_in_log = 8;
 	} else if (!strcmp(arg, "--no-expand-tabs")) {
diff --git c/revision.h w/revision.h
index 6d369cdad6..49b123387f 100644
--- c/revision.h
+++ w/revision.h
@@ -278,6 +278,7 @@ struct rev_info {
 	struct date_mode date_mode;
 	int		expand_tabs_in_log; /* unset if negative */
 	int		expand_tabs_in_log_default;
+	int		indent_empty_lines;
 
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
@@ -412,6 +413,7 @@ struct rev_info {
 	.expand_tabs_in_log = -1, \
 	.commit_format = CMIT_FMT_DEFAULT, \
 	.expand_tabs_in_log_default = 8, \
+	.indent_empty_lines = 1, \
 }
 
 /**
