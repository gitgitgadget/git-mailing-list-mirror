Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD13F39EE
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837873; cv=none; b=m1MTXz+Tyf7C/XU/FUbgv15maANSS7kYYHx/SUWNwjhaSCZ3QNXDEn8tT6SMoKIDTB9VNrbGEEMR8Sqfr4QhQjAomI+tKNliP2/onyjgoKJDIAhh8YaKXSqE6Qj9yCWLVdxtIjElnwM9Nchh6LiAaLQ/NXAykmZMizgohzIPIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837873; c=relaxed/simple;
	bh=Kc4VcTyjUwx4hIIbZl7QT6S0ihjcBZI6szPrKNchHCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldRTxVGtiYgZytqpYsOzL4Mo7gK70uq/ydkWpmKcLhwiD8pmhJIDDEM6mDbkdO9SCaCjMXE1WS2T1LXzZDCQSQi2Rl3V2TxC8x1IgCrUn2jpJZZJRjK1JxnlOtR6siXubHySnS7Xw7KtTUNquO7JyGWzjhaVyucUufEeafsw/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUzPBGz8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUzPBGz8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495437bb891so6709945e9.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837870; x=1786442670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oW7m0mIPhewdpn8ovmMm2cTZ6yEUuShZBDOaMpu+ZnM=;
        b=EUzPBGz80pVF8/57xONOhSoil91dVSX8dU8DwBcaDU6a25182nkUrnyfbwFJqzsjx3
         v+to018uGY45Q9mCwflU5SGMF8T6ZLLBFDuNCXXaNqaAYnW1sGdQmj88jJlIiCtKj/cY
         6Tdp+WU1kBcunNVSuNmaIVkfdMl67qtuPUDQijcY15s9fXflt7ntpyiCvRwHvqgVENen
         /zSIK688MAIKjR5BeJPNr96IiA4YcEfa+ZkwlslQ2jqk82XqzDH8xbFCZB/wbxReLF4K
         9NrVb4Kk0yMcMQCZkvhXrNJpSngfbner15SmZQoOqo1WSCfZpi4HL2gxfVoZelclm0GK
         XvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837870; x=1786442670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oW7m0mIPhewdpn8ovmMm2cTZ6yEUuShZBDOaMpu+ZnM=;
        b=k9wstO3jZ/DrKpHRod6Wf/+oKpOmui1XwK7jwJfC4/9jqwACkcgkGqfgi37Kob1b7q
         ZxMN/+QspCoNBDsWp/R3cSNo9CihFUksJqLuwFDbo0GmKhtHKDo0VhC49dSpFuSZ9CGV
         eyH7P575WNKRYB9utlH1n8Rc+oXjb2zXZtyHjRbGDJ37iUGOniHPNmltw/Zh+Rh+9PNh
         Tda5PNzbumFMSQgKORJn0LeHbypnqRpQF7pqa6aC9kl/6GbamB5svGLFK6kYU0Q5CIdJ
         +4uQvj5QqchLvlbzEa8zH0XF/Hb2aV8h1oPrwGPequ9HdID0kodQqyp3wB+77KAW+UT1
         8Cjw==
X-Gm-Message-State: AOJu0YweEpuiLCP+oy8drnZrovcB8c8OUcbwVrxzTF0cP8TfKhyiyx3F
	fxkxLMcA7nGsCyLo+OGGiEjGk4Mqx++ORwRgTvpK+Gx2y4OhLgjcr7DymTP3VA==
X-Gm-Gg: AR+sD11lpfFMnNDhMMlyw83aHFMi7/WI22R7mxogeGk6OjPT7nPBQZxfg3Zf1jr2HDZ
	H+4DD9NeQflgbvY/mmKOSOWmNtR+R68OYxaTuHjFReyQJaqV0YbcOqw5zmdDjiJUtkvLIV1OAiw
	YihLM+V30iBPwg1jwK6FQuDkmEcT7YaSpTE7MbkNsC5O2Tge4hOkYwO1SztfkjUAtep313wV3n1
	vpc213nD9+3HIiMNVddnWay6OWy0hztHLkbMQ/6d6PbKVr6chkiEvkg787iy1+JVqqkBS+EAwyC
	Gc5QeOthWHzscnzXs+lz6p7+lap6BE7s0FrsXYOC4znPzK5p4eqsRz9RAjYmgBCxRuhXSXUgE8T
	t1u54zAF7+f9SbbPun4/WStcyQbZtjxvRXfdvOVzYyLUWuWOkJpqqduD72FWnuIKnbUb5qoO5b0
	EYaKol8AiRsZ5V4Q1UhxNRbkLBymgTINm1MwXrm3CoiptZP7Fwib88kX6O7uo5ZMeD6lDUumJhs
	7GFn/qUU/gLNF3IFzdGYOVYRBVl+aCIa9jw66879cGGkMSDRTmvjKs+Sgx7NOjPc31ijsEpSG9p
X-Received: by 2002:a05:600c:1987:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-4994a101e6cmr50474315e9.8.1785837869056;
        Tue, 04 Aug 2026 03:04:29 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:28 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 08/12] fast-import: move command state globals into 'struct fast_import_state'
Date: Tue,  4 Aug 2026 12:03:51 +0200
Message-ID: <20260804100355.1299498-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit introduced 'struct fast_import_state' to hold some
command state, and reduce the need for global variables.

Let's continue in the same direction and move two more global variables
that describe the command state into it: 'seen_data_command' and
'allow_unsafe_features'.

All the sites accessing these variables are already in functions that
receive the 'state' parameter (or in cmd_fast_import() which owns the
struct), so no additional threading is needed.

As 'state->allow_unsafe_features' is now dereferenced in
check_unsafe_feature(), its 'state' parameter is no longer unused, so
the UNUSED marker is removed.

The fast_import_state_init() call is moved up before the early
command-line scan for '--allow-unsafe-features', so that this option
can be recorded directly into the struct without being clobbered by
the memset() in fast_import_state_init().

This is a mechanical refactoring with no intended behavior change.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index cb0c856e41..926afde954 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -257,9 +257,7 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
-static int seen_data_command;
 static int require_explicit_termination;
-static int allow_unsafe_features;
 
 /* Signal handling */
 static volatile sig_atomic_t checkpoint_requested;
@@ -277,6 +275,8 @@ struct fast_import_state {
 	int argc;
 	const char **argv;
 	const char *prefix;
+	int seen_data_command;
+	int allow_unsafe_features;
 };
 
 static void fast_import_state_init(struct fast_import_state *state,
@@ -1877,7 +1877,7 @@ static int read_next_command(struct fast_import_state *state)
 			if (stdin_eof)
 				return EOF;
 
-			if (!seen_data_command
+			if (!state->seen_data_command
 				&& !starts_with(command_buf.buf, "feature ")
 				&& !starts_with(command_buf.buf, "option ")) {
 				parse_argv(state);
@@ -3837,9 +3837,9 @@ static int parse_one_option(struct fast_import_state *state, const char *option)
 	return 1;
 }
 
-static void check_unsafe_feature(struct fast_import_state *state UNUSED, const char *feature, int from_stream)
+static void check_unsafe_feature(struct fast_import_state *state, const char *feature, int from_stream)
 {
-	if (from_stream && !allow_unsafe_features)
+	if (from_stream && !state->allow_unsafe_features)
 		die(_("feature '%s' forbidden in input without --allow-unsafe-features"),
 		    feature);
 }
@@ -3888,7 +3888,7 @@ static int parse_one_feature(struct fast_import_state *state, const char *featur
 
 static void parse_feature(struct fast_import_state *state, const char *feature)
 {
-	if (seen_data_command)
+	if (state->seen_data_command)
 		die(_("got feature command '%s' after data command"), feature);
 
 	if (parse_one_feature(state, feature, 1))
@@ -3899,7 +3899,7 @@ static void parse_feature(struct fast_import_state *state, const char *feature)
 
 static void parse_option(struct fast_import_state *state, const char *option)
 {
-	if (seen_data_command)
+	if (state->seen_data_command)
 		die(_("got option command '%s' after data command"), option);
 
 	if (parse_one_option(state, option))
@@ -3967,7 +3967,7 @@ static void parse_argv(struct fast_import_state *state)
 	if (i != state->argc)
 		usage(fast_import_usage);
 
-	seen_data_command = 1;
+	state->seen_data_command = 1;
 	if (import_marks_file)
 		read_marks();
 	build_mark_map(&sub_marks_from, &sub_marks_to);
@@ -3982,6 +3982,8 @@ int cmd_fast_import(int argc,
 
 	show_usage_if_asked(argc, argv, fast_import_usage);
 
+	fast_import_state_init(&state, argc, argv, prefix);
+
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
 
@@ -4005,11 +4007,9 @@ int cmd_fast_import(int argc,
 		if (*arg != '-' || !strcmp(arg, "--"))
 			break;
 		if (!strcmp(arg, "--allow-unsafe-features"))
-			allow_unsafe_features = 1;
+			state.allow_unsafe_features = 1;
 	}
 
-	fast_import_state_init(&state, argc, argv, prefix);
-
 	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
 	for (unsigned int i = 0; i < (cmd_save - 1); i++)
 		rc_free[i].next = &rc_free[i + 1];
@@ -4056,7 +4056,7 @@ int cmd_fast_import(int argc,
 	}
 
 	/* argv hasn't been parsed yet, do so */
-	if (!seen_data_command)
+	if (!state.seen_data_command)
 		parse_argv(&state);
 
 	if (require_explicit_termination && feof(stdin))
-- 
2.55.0.492.g44bba30fd7.dirty

