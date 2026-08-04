Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE61448D09
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837876; cv=none; b=pn1uCh7lQuDbLsS8+UuMzGFzghovtXknVnLB4c4v7KFBAlSbvyLp0xI1loaJdxj0Q5QiRfK3xGcSMH7z25j7gPKf0rtrUlh8yMlwvu0K7gd9OaTwM+dXipzLcpPtLNIL61Rbdou/JOrjHQWao/g5SRFw8Eg9dCirXXgX82gM3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837876; c=relaxed/simple;
	bh=NEJArp5tgQdsbZnYoAlBpDdsJiZMi7aengGKXVvqB7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCI1AraSpHKUnq91NYOJU2wzjQU7nsap+4Qmj6OrPKiekB/5uTGbJ1y8XV6kB/Z+OtqD/ht7f8LWizXkusExcjitvf4c10SeoapaZ5qUCXL8N4NJONHzS4eccZMzTp8capnR17IcqElRsyl6+cNMaP5IDqKpfbuMuQCYooGGY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHDgD73B; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHDgD73B"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49557167508so27257815e9.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837873; x=1786442673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AaXVWWFtaX9SyAudS7ielq7eNpmvIJpF2QznY0JcrMA=;
        b=QHDgD73BJGNWIU8oz3w508LM4RsRuGRbXXyEM1NRPu++F9syOQVnMyQbvFH5RZOhse
         wNMC7BjVT3sIUWFNKEHDMlNQEoM+WNdQGhIxv6RsFbng9PZkGCuG07alHunCVZIGqSjx
         BFY17mXAbDmUv0D2Pa+tdcVdrvw7TWUST1gBQSmLJI0xCTJUKnlVYzpbUJvWDBblEXK4
         NmUDGNt9lNx2mVK02Cf+8AHlCU979St1AR0Pt00crbOiwrMo+cG8epO4zjTLY4QwQCXa
         DsSnV+5AhE7qI2k1v955JOevfFtFoxj7A/ToLsEE37F2W/W2IwpTji1qw3UviUgAVlEx
         l/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837873; x=1786442673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AaXVWWFtaX9SyAudS7ielq7eNpmvIJpF2QznY0JcrMA=;
        b=fvhDomUN022QkwTN6EGNIDzr1XfJ73AcysqLa3NIKf+/d7DQYbJdoxgZof3nFQyi9B
         YYDNKqXn4IiFANHdXfRwFXCoQHMexLwSCVfu2hAdUG2LrRfnF3a3Inv+z0G4oZ066Q1E
         H4mAdRFnPDgSPAtZodtXx5eleGg1o4oaMEJ6FzmkkMYGXdOjw8AZSCXl6EkCXZ2wGv01
         ps5nt8/KhJ45tshFNSvsLO950MgdOZLP8pp1WskPN4bGIw7bPieO2s07KdM8nTdTc5wN
         D5wohuL6shSyAzJolfI08XVRUogftfxqzhq/siOPX9vw4bgeQPJ8zl34uhCZkOz+huyP
         HHtA==
X-Gm-Message-State: AOJu0YxVCE47yCbnD+L3gIQjuCfa/BFGm27/040OTCCWsiqcH8q0FoD+
	ptB5R3+Q5KpNKn6L6HWDLKi0eiE6vFtDcn/8P9rGAYHMay2yKRYO2vEkkEVMOg==
X-Gm-Gg: AR+sD11YbQvV9N064ZbzcukDmKRuhEcF2QNpaQeeD9nPh2Or20lSrkx8Hvm6j4zAK8/
	9Jjeh9wh5u0CSh7JwXzlMy6tFZfi0AjGKzUp1BRTY4BgHSn1ofknc4HLGHCIS7fWlIcpXIhijda
	Cs++xLh44lFelHJTCf0CVjXODTf+IeXvx1w8FnD4PHoQFlv7p/Ms1TBWGumJiLyBax5xQV3CmNY
	HZIOcB4MScR5zZXv1QaslIj0pq99Qbw/ApJPBrL+Rj4d/RmhbzEGaK98sx5/R4TaCJR8H2E0W6W
	JCp3++tO66pVGRgf/He4N7LKFW/ogW+8YSLKQkLZ4Pf3m4NAA63uVoz5ASDpUOTx0MdQAbtxTdI
	0MPgHGZRanO1wHTFyrJxOEk8w+Ula0pVGTu4zxGE6fTD+QqgrORiPkooV4aCPlwNeRrEy51984r
	/WibR4Zoxfl80fZLrvSQDUdsw1TtM37YPTqDOuoLv0IdZvbWTSFv3SUIvpCczUpl7PLo/k26SSq
	L8RRgi5/4MH+STu490sm9x4UB/6aDavaxOnO0Yd/c/OGcoAyBKKtSjA6X50nFg8E6VWbHsNj2uO
X-Received: by 2002:a05:600c:8711:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-4980c652515mr373516205e9.11.1785837872924;
        Tue, 04 Aug 2026 03:04:32 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:32 -0700 (PDT)
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
Subject: [PATCH v2 11/12] fast-import: use parse_options() for command line options
Date: Tue,  4 Aug 2026 12:03:54 +0200
Message-ID: <20260804100355.1299498-12-christian.couder@gmail.com>
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

Previous commits have started to use the parse-options API to display
output from `git fast-import -h` and `git fast-import --help-all` and
to prepare for parsing the command line options using this API.

Let's now actually use the API to parse command line options.

This brings a number of changes that are mostly beneficial:

  - The `--alias`, `--get-mark`, `--cat-blob`, `--ls` and `--notes`
    options are no longer accepted on the command line. They were
    previously accepted as no-ops because parse_argv() fell through to
    parse_one_feature(). They are not documented in the OPTIONS section
    and are only meaningful as in-stream feature assertions, so
    accepting them on the command line was an accident of code sharing
    dating back to 9c8398f0c9 (fast-import: add option command,
    2009-12-04).

  - Abbreviated options like `--dep=5` now work since parse_options()
    allows unambiguous prefixes.

  - As `--cat-blob` is an abbreviation of `--cat-blob-fd`, using the
    former on the command line will fail with "option `cat-blob-fd'
    requires a value" unlike the other four options that are not
    accepted anymore on the command line (see above).

  - The error messages for some options might differ a bit.

  - The code is shorter and more standard.

Note that parse_one_feature() is now always called with its
`from_stream` argument set to 1, but the code simplifications that
can be made are left for a following clean-up commit.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c  | 33 ++++-----------------------------
 t/t9300-fast-import.sh |  7 +++++++
 2 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f3c46fb567..0df7a31014 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3945,31 +3945,11 @@ static const char *const fast_import_usage[] = {
 
 static void parse_argv(struct fast_import_state *state)
 {
-	unsigned int i;
-
-	for (i = 1; i < state->argc; i++) {
-		const char *a = state->argv[i];
-
-		if (*a != '-' || !strcmp(a, "--"))
-			break;
+	int argc = parse_options(state->argc, state->argv, state->prefix,
+				 state->option, fast_import_usage,
+				 PARSE_OPT_KEEP_ARGV0);
 
-		if (!skip_prefix(a, "--", &a))
-			die(_("unknown option %s"), a);
-
-		if (parse_one_option(state, a))
-			continue;
-
-		if (parse_one_feature(state, a, 0))
-			continue;
-
-		if (skip_prefix(a, "cat-blob-fd=", &a)) {
-			option_cat_blob_fd(state, a);
-			continue;
-		}
-
-		die(_("unknown option --%s"), a);
-	}
-	if (i != state->argc)
+	if (argc > 1)
 		usage_with_options(fast_import_usage, state->option);
 
 	state->seen_data_command = 1;
@@ -4105,11 +4085,6 @@ int cmd_fast_import(int argc,
 {
 	struct fast_import_state state;
 
-	/*
-	 * NEEDSWORK: For now this is used only to render
-	 * `-h`/`--help-all` usage messages. The actual parsing is
-	 * done by parse_one_option()/parse_one_feature().
-	 */
 	struct option fast_import_options[] = {
 		OPT_GROUP(N_("Common")),
 		OPT_CALLBACK_F(0, "date-format", NULL, N_("fmt"),
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index fe6c2617ac..d9de2ef0d8 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2827,6 +2827,13 @@ test_expect_success 'R: unknown commandline options are rejected' '\
 	test_must_fail git fast-import --non-existing-option < /dev/null
 '
 
+test_expect_success 'R: feature-only names are rejected on the command line' '
+	for opt in --alias --get-mark --ls --notes
+	do
+		test_must_fail git fast-import "$opt" </dev/null || return 1
+	done
+'
+
 test_expect_success 'R: die on invalid option argument' '
 	echo "option git active-branches=-5" |
 	test_must_fail git fast-import &&
-- 
2.55.0.492.g44bba30fd7.dirty

