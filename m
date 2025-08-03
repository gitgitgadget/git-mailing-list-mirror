Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2293207
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754184388; cv=none; b=n2w6jweMj6mZmEek1hQUDhOJKR/diicPzULEN62jYeaFwNhJ57KE9jc9w3W3i8mEM9fgcXxVddghljT01f94LJhiCl0tJBXR5a1BSSnGb8YVWLun9Ym75ToLkx09O0CG/cObe69IIkzANQCSE9cT7wG67Ioj5wOqMvLpUbsE1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754184388; c=relaxed/simple;
	bh=4VjvBJIQQwDLceWRu7lI3ypFxTNP1mV1lwjFeuab1Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNEkUjmE1goJy0UopntWJzWVfRS3Vj6fbikegzTTeFvOeZjl2caUHQvznHaG7R4nJouC+e6rvT4mO27zCFx2sPBC5zT8c0D276i2PcRxb8N4tDQ1mOBuqW5Z01A+kEefzQ+u5A2SyuoYye3VKPsAxziOq74VLL/a97gwA9mmZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vili4n/7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vili4n/7"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8fe929b147so1339728276.2
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 18:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754184384; x=1754789184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGy4Rfu9TguMUvt51ntmpq8omXCDlq9mGQjpnO9G1eE=;
        b=Vili4n/7tQM2uCc/c/NGem4iIVP/DBncfYbVZjuyyiWox/2QZRcp+mLrzwk3yP+xkk
         BsodTPA1pEQqeFBVrGGXc2wJBDWk3ZRzROicpua8cqM3cOTqPrOF+bMB8DQRCv8a1c6O
         UGE2uYCjpgH+1TF14qbQnFs8/N0J4S0KPric13cW3MOVbPGAizWI4znXFydJLlON8BOv
         e+6h0RbKvNpth83EYIlofPJ+mN/7ci31In9YuMbGapoaIRXOqReB+/cWVa8jibDYfn8k
         dKHzquKswOi4B5Wm3fwqOYaMBufA0cgFKFtduIQHzK4gvXivtON97cGXVNzC9QBnX/0O
         uKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754184384; x=1754789184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGy4Rfu9TguMUvt51ntmpq8omXCDlq9mGQjpnO9G1eE=;
        b=szQnct/2PhLHxf/VBzlLFRh9uMdF+L6ya/QXjbd09/nea0OEqVluk2hkfHI6XquoCa
         QDc6KooI3sSvo2Cacqd/929/huPg4GYYpEoFw27kblB6TAQjxu4cOP9ha5zGK+Zla2Ty
         aQg27JB40WvPTPACBN8nbDMxiGDjdrbaipaAz+u5uTHrQJt5kF5qAXCJehyGMjdN6lM5
         v/kVn3TUiWQEiJ3lXWXKjGPvjXjqRYCo/K/YIH2uXZSeKgMM9HRaBcxzyEo+b74X+EM9
         JLQslnTTOdiPLM2OhqoRljRXSiBPsZNovwXSR4cxwnt83gQFqw50qC1HR8XihwLmuvbC
         10EA==
X-Gm-Message-State: AOJu0Yy4TNwWalqvI7AuAispGlSX2Gs0B5105J66s/LC5NCtlfnnj5wD
	jJsqo/xs7BCK1Pgxze/Cvr8iDBiia0T42lj0/M9rlNq374Gol7awZfq3pRU5xnsB
X-Gm-Gg: ASbGncuJshU0ppzs1cxPgmNGqI125DwPxx1OGpLeaKB+3gUMvLHELwRlKf8VdssZltP
	852lI0N3T5R4xlJhNBAtdve8KDFnV8rsEtR9zdGmGPKlHqUng3jsDW0XnvTfmET+fz76W1iRYQb
	nVw47g2dtUs7S7dZSMWBkNgNDMCFK7c3/AMNfO38fa3yMKH51JWqfoASceYy3iAM82pLF5vTC3V
	G1rqm67nl8k05CXh0EPKCvDPN00Q+AboiCuPKg2KzMYhyixG12G5g9NzrUgyyFGEwvvTxhxhuRf
	1t0DjItF+Wd9RsT3WBhGvMvJ8p+pxexkUUG/sq7O7LyP/DcJgIKRsf/B49KlxDskhhUg61VvTNd
	GPwhgS5lvG42hfvsnRy2hovpcN0RUN79kiPiCfG3L/hYytcdoEQceebEmEU4lv82kZ6g=
X-Google-Smtp-Source: AGHT+IGbhdPE4tvW9aCcbWnydcaIjCoGob7hMqM89CL1nclpFQmF77c7zK0CfQKxMtoRwRv0iza47Q==
X-Received: by 2002:a05:6902:c07:b0:e8e:1a50:be82 with SMTP id 3f1490d57ef6-e8fee10273emr5178007276.46.1754184384461;
        Sat, 02 Aug 2025 18:26:24 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:88ae:3d99:b445:935b])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd38ba780sm2673602276.43.2025.08.02.18.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 18:26:23 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] permit -h/--help-all in more scenarios
Date: Sat,  2 Aug 2025 21:26:01 -0400
Message-ID: <20250803012613.54086-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726165320.4039-1-ben.knoble+github@gmail.com>
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v1:
- tweak refactor commit message to indicate no behavior is changed;
- use #define'd constants instead of an enum for internal flags;
- drop controversial [4/4]

QQ: Is there a better way to add --cc's to format-patch than grabbing the right
folks off threads from lore.kernel.org/git? (I could also grab them out of my
mail client.) I assume this is where using tools like b4 starts to really shine?
To be clear: I mean CC's _in addition to_ the use of

    sendemail.ccCmd = perl contrib/contacts/git-contacts

to keep folks that participated in prior rounds of discussion abreast of the
next version.

--------
Original
--------

This series depends on ua/t1517-short-help-tests with some fixes, which
show up in the first patch. Merge that branch to a new topic branch:

    git switch -c topic v2.50.0 # or origin/master
    git merge gitster/ua/t1517-short-help-tests

then apply this series.

This series enables --help-all outside of repository contexts, and
allows -h with other arguments (without breaking existing ls-remote/grep
usage).

It consists of preparatory steps (fixes for a dependency branch;
refactoring to make an internal helper's arguments clearer) followed by
the main commits.

v1: https://lore.kernel.org/git/20250726165320.4039-1-ben.knoble+github@gmail.com/
Published-as: https://github.com/benknoble/git/tree/help-all-tweaks

D. Ben Knoble (3):
  t1517: fixup for ua/t1517-short-help-tests
  parse-options: refactor flags for usage_with_options_internal
  builtin: also setup gently for --help-all

 builtin/merge-recursive.c     |  3 ++-
 git.c                         |  2 +-
 parse-options.c               | 30 +++++++++++++++++++++++-------
 t/t1517-outside-repo.sh       | 11 +++++++----
 t/t5200-update-server-info.sh |  2 +-
 usage.c                       |  3 ++-
 6 files changed, 36 insertions(+), 15 deletions(-)

Diff-intervalle contre v1 :
1:  852a4547af ! 1:  7a3e0a601d t1517: fixup for ua/t1517-short-help-tests
    @@ Commit message
     
         - drop spurious message during test
         - fix known breakages that actually work
    +    - fix instaweb marker for known failure
         - fix new t5200 test
     
     
    @@ Notes
     
      ## t/t1517-outside-repo.sh ##
     @@
    + 	case "$cmd" in
    + 	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
      	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
    - 	http-backend | http-fetch | http-push | init-db | instaweb.sh | \
    +-	http-backend | http-fetch | http-push | init-db | instaweb.sh | \
    ++	http-backend | http-fetch | http-push | init-db | \
      	merge-octopus | merge-one-file | merge-resolve | mergetool | \
     -	mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
     -	remote-http | remote-https | replay | request-pull | send-email | \
2:  56665594a8 ! 2:  db74b1eff7 parse-options: name flags passed to usage_with_options_internal
    @@ Metadata
     Author: D. Ben Knoble <ben.knoble+github@gmail.com>
     
      ## Commit message ##
    -    parse-options: name flags passed to usage_with_options_internal
    +    parse-options: refactor flags for usage_with_options_internal
     
         When reading or editing calls to usage_with_options_internal, it is
         difficult to tell what trailing "0, 0", "0, 1", "1, 0" arguments mean
         (NB there is never a "1, 1" case).
     
    -    Give the flags readable names to improve call-sites.
    +    Give the flags readable names to improve call-sites without changing any
    +    behavior.
     
      ## parse-options.c ##
     @@ parse-options.c: static void free_preprocessed_options(struct option *options)
      	free(options);
      }
      
    -+enum usage_style {
    -+	style_normal = 0,
    -+	style_full = 1,
    -+};
    -+
    -+enum usage_output {
    -+	to_out = 0,
    -+	to_err = 1,
    -+};
    ++#define USAGE_NORMAL 0
    ++#define USAGE_FULL 1
    ++#define USAGE_TO_STDOUT 0
    ++#define USAGE_TO_STDERR 1
     +
      static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
      							 const char * const *,
      							 const struct option *,
     -							 int, int);
    -+							 enum usage_style,
    -+							 enum usage_output);
    ++							 int full_usage,
    ++							 int usage_to_stderr);
      
      enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
      					 const struct option *options,
    @@ parse-options.c: enum parse_opt_result parse_options_step(struct parse_opt_ctx_t
      
      		if (internal_help && !strcmp(arg + 2, "help-all"))
     -			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
    -+			return usage_with_options_internal(ctx, usagestr, options, style_full, to_out);
    ++			return usage_with_options_internal(ctx, usagestr, options,
    ++							   USAGE_FULL, USAGE_TO_STDOUT);
      		if (internal_help && !strcmp(arg + 2, "help"))
      			goto show_usage;
      		switch (parse_long_opt(ctx, arg + 2, options)) {
    @@ parse-options.c: enum parse_opt_result parse_options_step(struct parse_opt_ctx_t
      
       show_usage:
     -	return usage_with_options_internal(ctx, usagestr, options, 0, 0);
    -+	return usage_with_options_internal(ctx, usagestr, options, style_normal, to_out);
    ++	return usage_with_options_internal(ctx, usagestr, options,
    ++					   USAGE_NORMAL, USAGE_TO_STDOUT);
      }
      
      int parse_options_end(struct parse_opt_ctx_t *ctx)
    -@@ parse-options.c: static const struct option *find_option_by_long_name(const struct option *opts,
    - static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *ctx,
    - 							 const char * const *usagestr,
    - 							 const struct option *opts,
    --							 int full, int err)
    -+							 enum usage_style help_style,
    -+							 enum usage_output to_where)
    - {
    - 	const struct option *all_opts = opts;
    --	FILE *outfile = err ? stderr : stdout;
    -+	FILE *outfile = to_where == to_err ? stderr : stdout;
    - 	int need_newline;
    - 
    - 	const char *usage_prefix = _("usage: %s");
    -@@ parse-options.c: static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
    - 	if (!usagestr)
    - 		return PARSE_OPT_HELP;
    - 
    --	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
    -+	if (to_where != to_err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
    - 		fprintf(outfile, "cat <<\\EOF\n");
    - 
    - 	while (*usagestr) {
    -@@ parse-options.c: static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
    - 				fprintf(outfile, "%s\n", _(opts->help));
    - 			continue;
    - 		}
    --		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
    -+		if (help_style != style_full && (opts->flags & PARSE_OPT_HIDDEN))
    - 			continue;
    - 
    - 		if (need_newline) {
    -@@ parse-options.c: static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
    - 	}
    - 	fputc('\n', outfile);
    - 
    --	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
    -+	if (to_where != to_err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
    - 		fputs("EOF\n", outfile);
    - 
    - 	return PARSE_OPT_HELP;
     @@ parse-options.c: static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
      void NORETURN usage_with_options(const char * const *usagestr,
      			const struct option *opts)
      {
     -	usage_with_options_internal(NULL, usagestr, opts, 0, 1);
    -+	usage_with_options_internal(NULL, usagestr, opts, style_normal, to_err);
    ++	usage_with_options_internal(NULL, usagestr, opts,
    ++				    USAGE_NORMAL, USAGE_TO_STDERR);
      	exit(129);
      }
      
    @@ parse-options.c: void show_usage_with_options_if_asked(int ac, const char **av,
      {
      	if (ac == 2 && !strcmp(av[1], "-h")) {
     -		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
    -+		usage_with_options_internal(NULL, usagestr, opts, style_normal, to_out);
    ++		usage_with_options_internal(NULL, usagestr, opts,
    ++					    USAGE_NORMAL, USAGE_TO_STDOUT);
      		exit(129);
      	}
      }
3:  352fe87c80 ! 3:  cb4113f77d builtin: also setup gently for --help-all
    @@ Commit message
         The exception is merge-recursive, whose help block doesn't use newer
         APIs.
     
    +    Best-viewed-with: --ignore-space-change
    +
     
      ## Notes ##
         Some usage.c callers, like check-ref-format, probably deserve to be
    @@ parse-options.c: void show_usage_with_options_if_asked(int ac, const char **av,
      				      const struct option *opts)
      {
     -	if (ac == 2 && !strcmp(av[1], "-h")) {
    --		usage_with_options_internal(NULL, usagestr, opts, style_normal, to_out);
    +-		usage_with_options_internal(NULL, usagestr, opts,
    +-					    USAGE_NORMAL, USAGE_TO_STDOUT);
     -		exit(129);
     +	if (ac == 2) {
     +		if (!strcmp(av[1], "-h")) {
    -+			usage_with_options_internal(NULL, usagestr, opts, style_normal, to_out);
    ++			usage_with_options_internal(NULL, usagestr, opts,
    ++						    USAGE_NORMAL, USAGE_TO_STDOUT);
     +			exit(129);
     +		} else if (!strcmp(av[1], "--help-all")) {
    -+			usage_with_options_internal(NULL, usagestr, opts, style_full, to_out);
    ++			usage_with_options_internal(NULL, usagestr, opts,
    ++						    USAGE_FULL, USAGE_TO_STDOUT);
     +			exit(129);
     +		}
      	}
4:  3099d83cdf < -:  ---------- builtins: show help on "-h"/"--help-all" with more than 2 arguments left

base-commit: e4ef0485fd78fcb05866ea78df35796b904e4a8e
prerequisite-patch-id: ffce2dd036e61c8d36485a17321f858e454db874
prerequisite-patch-id: 52539022c824997adfc1be0bed8de6b1851d2187
-- 
2.48.1

