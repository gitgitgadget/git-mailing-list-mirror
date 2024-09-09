Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5DE1BA263
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891094; cv=none; b=WVmOisaEz8YoRFtCF3W9Wck+ynyRtdT/jbNBLAoG3e6rt9KQrXvMw5mLIAeuwIZtOc2c38pN5JEQj1G54vIrUKTsjNSOjnKrLf5xIi+T0HfuneIUnZw5Lqq9N8nUQNYmt198ueQL1D9f9KHwVB0m/8vF0oZrTdiAANPq9288WX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891094; c=relaxed/simple;
	bh=Nyq0vF216EnBTdN9na7+LKm5F7rTsUX4RuromvtLoA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEBvN0PLSL1fmyIMQlpLQDne1dY3xW11PbxK23KWRoLamqo5riD3Czo2EKsGOunXXBDrR16nd/Z0IgY6U3PkCRIeh0gHViBzqXDVmWrqxKiivZBjbb1MMIlBxBIZa3FY+SJFHGbL/dX5OJVBUuhjyyZWK3L7kUCV4Hr6CzmBS64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJAUdwIg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJAUdwIg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20688fbaeafso42998965ad.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725891092; x=1726495892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NxyLI+6aKiOAmHnfYleXx+chC01AB18/i6MEwM7ZL0=;
        b=hJAUdwIgG373xElHlwfuQfZW5rmJuELt7eCbnzFn+TNmvRLMDcNDG/XBKCy1lwsK/B
         fKgJIKQ68RNmn2vQsLeGe299J1zVUIvb8UDhM7OoSKcjZjSY/cNcTOXapIMyknKrQoti
         0LcDKl8a65F0U3v5p5q3wd52bZezG1Uw2/RZYsmL4SQBE/GVKgAFx1TlSZl5h+hdquYf
         ui25jqUy8NUoUucUVE0sXMG768rDiCp5RZMbN4iOFpgeELyoYBKFkn07ITjiCS53fiEU
         cIJev0vgFqGYtzZ+bJFyB8ric4JpfTjItHqVT3zG3COu1WXFNk2dK9WHW8CtKzjebQmz
         uLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725891092; x=1726495892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NxyLI+6aKiOAmHnfYleXx+chC01AB18/i6MEwM7ZL0=;
        b=NL37tLTDR23cO+FO581LnnLt2A8+V7ujWwllTqnuSi5ukNcLz5HCNHS+Im4A7Rdev2
         n54tIH1kJji950svtYAQSKZrl7+wctBg8nkLvstcHCPnwi1D7Oh7k0Xq9H/aFDrgehO6
         Mg78echLUIIWm06aXS4rBVXJF/mlr4CluSHClD7nRSgiSuoM/yde3b6dveapjPJ1WWEG
         +0UbenoowQY5G2izVDRKcAZWpgIRQ2rZOF8x9zodREUEe7PID0py96UZcyE2Y2SjMXpv
         XDOT6TSMVS85/mz7zi/9M2Ke6rigDO0UUWOF+eI8h/7FWfCqJi7CnPC4ME9mpCykSJfV
         Wzcw==
X-Gm-Message-State: AOJu0YzOCuQIa/yIe4yfu0lEmiLNxe647dHfhz0/dH5EE2aeXuZ1L9Qt
	Sd+LMG6ck3DO0YQ3MAvEr2zSm5LhOISl6nN3CjcQn7nUMkO4VjzAWN1PyA==
X-Google-Smtp-Source: AGHT+IEngev2jPmx56s34kjiHczlatYu5vpyQ2S0sF2vOInBSzZOaSwFq3TqiWu3tRs/KOnzNKlLvw==
X-Received: by 2002:a17:902:cec1:b0:205:8407:6321 with SMTP id d9443c01a7336-206f04a01fcmr127636765ad.9.1725891092024;
        Mon, 09 Sep 2024 07:11:32 -0700 (PDT)
Received: from panther.lan ([2607:fa18:92fe:92b::47f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eef1e7sm34251735ad.120.2024.09.09.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:11:31 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org,
	gitster@pobox.com,
	bert.wesarg@googlemail.com
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 0/1] apply: support --ours, --theirs, and --union for three-way merges
Date: Mon,  9 Sep 2024 08:10:57 -0600
Message-ID: <20240909141109.3102-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906044222.4881-1-alexhenrie24@gmail.com>
References: <20240906044222.4881-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1:
- Use OPT_SET_INT_F instead of OPT_CALLBACK_F
- Remove the special message and instead always say that the patch
  applied cleanly when these options are used

Thanks to Junio for your feedback.

Alex Henrie (1):
  apply: support --ours, --theirs, and --union for three-way merges

 Documentation/git-apply.txt |  9 ++++++++-
 apply.c                     | 20 +++++++++++++++++--
 apply.h                     |  1 +
 t/t4108-apply-threeway.sh   | 40 +++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  e0e4000d47 ! 1:  9307dc5a1b apply: support --ours, --theirs, and --union for three-way merges
    @@ Documentation/git-apply.txt: OPTIONS
      	for each blob to help identify the original version that
     
      ## apply.c ##
    -@@ apply.c: int init_apply_state(struct apply_state *state,
    - 	state->prefix = prefix;
    - 	state->repo = repo;
    - 	state->apply = 1;
    -+	state->merge_opts.conflict_style = -1;
    - 	state->line_termination = '\n';
    - 	state->p_value = 1;
    - 	state->p_context = UINT_MAX;
     @@ apply.c: static int three_way_merge(struct apply_state *state,
    + 			   const struct object_id *theirs)
    + {
    + 	mmfile_t base_file, our_file, their_file;
    ++	struct ll_merge_options merge_opts = LL_MERGE_OPTIONS_INIT;
    + 	mmbuffer_t result = { NULL };
    + 	enum ll_merge_result status;
    + 
    +@@ apply.c: static int three_way_merge(struct apply_state *state,
    + 	read_mmblob(&base_file, base);
    + 	read_mmblob(&our_file, ours);
    + 	read_mmblob(&their_file, theirs);
    ++	merge_opts.variant = state->merge_variant;
    + 	status = ll_merge(&result, path,
    + 			  &base_file, "base",
      			  &our_file, "ours",
      			  &their_file, "theirs",
      			  state->repo->index,
     -			  NULL);
    -+			  &state->merge_opts);
    ++			  &merge_opts);
      	if (status == LL_MERGE_BINARY_CONFLICT)
      		warning("Cannot merge binary files: %s (%s vs. %s)",
      			path, "ours", "theirs");
    -@@ apply.c: static int try_threeway(struct apply_state *state,
    - 		return status;
    - 	}
    - 
    --	if (status) {
    -+	if (state->merge_opts.variant) {
    -+		/*
    -+		 * XDL_MERGE_FAVOR_(OURS|THEIRS|UNION) automatically resolves
    -+		 * conflicts, but the ll_merge function is not yet smart enough
    -+		 * to report whether or not there were conflicts, so just print
    -+		 * a generic message.
    -+		 */
    -+		fprintf(stderr, _("Applied patch to '%s'.\n"), patch->new_name);
    -+	} else if (status) {
    - 		patch->conflicted_threeway = 1;
    - 		if (patch->is_new)
    - 			oidclr(&patch->threeway_stage[0], the_repository->hash_algo);
    -@@ apply.c: static int apply_option_parse_space_change(const struct option *opt,
    - 	return 0;
    - }
    - 
    -+static int apply_option_parse_favorite(const struct option *opt,
    -+				       const char *arg, int unset)
    -+{
    -+	struct apply_state *state = opt->value;
    -+
    -+	BUG_ON_OPT_ARG(arg);
    -+	BUG_ON_OPT_NEG(unset);
    -+
    -+	if (!strcmp(opt->long_name, "ours"))
    -+		state->merge_opts.variant = XDL_MERGE_FAVOR_OURS;
    -+	else if (!strcmp(opt->long_name, "theirs"))
    -+		state->merge_opts.variant = XDL_MERGE_FAVOR_THEIRS;
    -+	else
    -+		state->merge_opts.variant = XDL_MERGE_FAVOR_UNION;
    -+	return 0;
    -+}
    -+
    - static int apply_option_parse_whitespace(const struct option *opt,
    - 					 const char *arg, int unset)
    - {
     @@ apply.c: int apply_parse_options(int argc, const char **argv,
      			N_("also apply the patch (use with --stat/--summary/--check)")),
      		OPT_BOOL('3', "3way", &state->threeway,
      			 N_( "attempt three-way merge, fall back on normal patch if that fails")),
    -+		OPT_CALLBACK_F(0, "ours", state, NULL,
    ++		OPT_SET_INT_F(0, "ours", &state->merge_variant,
     +			N_("for conflicts, use our version"),
    -+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
    -+			apply_option_parse_favorite),
    -+		OPT_CALLBACK_F(0, "theirs", state, NULL,
    ++			XDL_MERGE_FAVOR_OURS, PARSE_OPT_NONEG),
    ++		OPT_SET_INT_F(0, "theirs", &state->merge_variant,
     +			N_("for conflicts, use their version"),
    -+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
    -+			apply_option_parse_favorite),
    -+		OPT_CALLBACK_F(0, "union", state, NULL,
    ++			XDL_MERGE_FAVOR_THEIRS, PARSE_OPT_NONEG),
    ++		OPT_SET_INT_F(0, "union", &state->merge_variant,
     +			N_("for conflicts, use a union version"),
    -+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
    -+			apply_option_parse_favorite),
    ++			XDL_MERGE_FAVOR_UNION, PARSE_OPT_NONEG),
      		OPT_FILENAME(0, "build-fake-ancestor", &state->fake_ancestor,
      			N_("build a temporary index based on embedded index information")),
      		/* Think twice before adding "--nul" synonym to this */
    @@ apply.c: int apply_parse_options(int argc, const char **argv,
     -	return parse_options(argc, argv, state->prefix, builtin_apply_options, apply_usage, 0);
     +	argc = parse_options(argc, argv, state->prefix, builtin_apply_options, apply_usage, 0);
     +
    -+	if (state->merge_opts.variant && !state->threeway)
    ++	if (state->merge_variant && !state->threeway)
     +		die(_("--ours, --theirs, and --union require --3way"));
     +
     +	return argc;
      }
     
      ## apply.h ##
    -@@
    - 
    - #include "hash.h"
    - #include "lockfile.h"
    -+#include "merge-ll.h"
    - #include "string-list.h"
    - #include "strmap.h"
    - 
     @@ apply.h: struct apply_state {
      	struct repository *repo;
      	const char *index_file;
      	enum apply_verbosity apply_verbosity;
    -+	struct ll_merge_options merge_opts;
    ++	int merge_variant;
      	char *fake_ancestor;
      	const char *patch_input_file;
      	int line_termination;
-- 
2.46.0

