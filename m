Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268823B7746
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394887; cv=none; b=k9KwC3u+JEFRy3mNYcr7Dya0MVDpLtpD57myL1WFh/VSp99OQNCZUB7bJC7emdjAANjqDOVIX5KrRUTdfHISyYcxOF0qDcg8Gk62DUV8QDY350qb5bLVlJrxSKwp/xU/jZ0WDH5+ZFJIfvPQ0FGkdYm0ytji/UrHxXEEtuohseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394887; c=relaxed/simple;
	bh=PaxYz7h0RG2cmmY+Lo6Lv/5SFgYNZWAcJNlCjRr3PxI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=kfIloM6Gsqs25gGBp1trLoA0LjUxiHhR6I3jP44FrpSi6uFy74fVC4MAaHlcZyuy4ke71Y/uUAztbfPIDSlJadHfUeLN30t7Tjfq4NZzrhV7l6PdenFsv3VO0sjj9WCZS5LySTO3ARXSBlrM5jnnPIMOM31mF2lZvI7mRyrcID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehROKrqB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehROKrqB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso402553a91.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785394881; x=1785999681; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LCh6QNVot2UegMiCi319XxY7nB5GHE+jUPmr7KQB8VU=;
        b=ehROKrqBRWixZJTD7QhXp/gh75+qbr6JqPPNeTmHr31wUsAoeM67iV0GpzjaoGmC3a
         9IGLjKlsJ7PaWyG+GgAma+SRg+xe4XNotc+wiUX8XsagNo/acd/1qyuFQgxN/rpqryjO
         Z5vwF2WxpF9CUGAuAlRFgQOdKslB+JnFWSiRN/nh748EEC+rG3BeMv7shTpbpKdXjmNz
         dnq/7Dl6H8/Cd3Q+ZjnRWJmBYUnA4d4BvTel0/VMD7zAHXdv/alnogR1ZZ2IK7bgyDCd
         yImeBgT3lTaylZBD9UBUNZFRY/nb3/ZEkv4Uxn2tJG2NyIP7SeexBjHt/bRppDJc7HH0
         yRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394881; x=1785999681;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCh6QNVot2UegMiCi319XxY7nB5GHE+jUPmr7KQB8VU=;
        b=e8eoQ1AjCwAOz0erzFRwSZFAukAvzhNagzR9hxFlrBi2vo70sAGopH2VRbVIUGx5b6
         TQ1BqJKIt9bWZkMyO28CSxQ+e4D2rF2/n/PQzPmQEULCsEWKxlYa7LSc9mpa223kEQJU
         4BafUK8WPyVgBCnEcgUqnDgnRAwYkMrRZT3X5tKr25VnMew7Fnf9cLRHfa4vaH87gaSX
         4038ohkWfyIs4FT34QFLEahM8SEy3Rb6ZL1INKsn89uJvBT7buUbDLpY2pxwlflSAj6E
         DjQbcuEYwJVVfs5HEMMcaQWvJ2Qyc9rFzRngkzzXslDdkr5RSSCfy+WKCTFynuL2n8jd
         x7eg==
X-Gm-Message-State: AOJu0YxBm/z+k7VtYE2wL3vixCI+PLMyQnNU81qvA0OMVdEdabURHWqw
	ayLbDB1w7GzH4wyt9M8GxPh12l95U/wq+dnmb8h9IsFmz8TVJVUDIpihForP6Q==
X-Gm-Gg: AR+sD11lTOj+5x92GIzTcQ4pdvCvtEI31SBLYxQOZ2L8ojnVqJ4nEJp8AuNe06zQgK3
	NzpMVijo11e4MZ04Kcdb0b6R8RHf51PI/GdtKFxNZtHBWRsEUd35NJpiACByhn5DTt4GrHns8tF
	uVk49Gvv+tSidtf5mu3P5AMhenF3zhcUHziKIGZZ3bpWsC8SLLpXVqEhoxwmocncakNzluNYBz7
	XYZpRFBBwwXuBjlhuEQgRgF9L5E2ltHcRXUguXYoJ9Y9FxYtX9+TS/xeiQxJpjUOw3LRAWdXntb
	6A6NTKANJiZ2STD1TyHvmYdN91DDpezRxmAmdyxUmJ0NnxjEB2mQ3yGPw5+Y4skr3sQyuH4r+GM
	v7yzYKpwCU1OiHxS6Po4wslbVpF1uDCw+dlMuqrUWpUMo5oUbckGWkZSX0xDlPxApRCaMm3dqOh
	r0m08MyLpnU4x3vbCNAF5OGijdEtaoMPyf/KJdTwdk7Bjz7Zc+xNL2wnp5YcANhjE=
X-Received: by 2002:a17:90b:58a8:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-38f9d0c579amr565917a91.0.1785394881017;
        Thu, 30 Jul 2026 00:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.160.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b960ceasm510310a91.6.2026.07.30.00.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:01:20 -0700 (PDT)
Message-Id: <pull.2368.git.git.1785394879459.gitgitgadget@gmail.com>
From: "Israel Roldan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 07:01:19 +0000
Subject: [PATCH] date: add --date=elapsed and %aX/%cX placeholders
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Israel Roldan <israel.alberto.rv@gmail.com>,
    Israel Roldan <israel.alberto.rv@gmail.com>

From: Israel Roldan <israel.alberto.rv@gmail.com>

The --date=human format and the %cr/%ch placeholders both produce
a localized English phrase that hides the precise amount of time
that has passed. A commit shown as "2 days ago" may in reality be
1 day 3 hours, or 1 day 23 hours. Switching to %ct and a calculator
solves the problem but is not glance-friendly.

Add an uptime(1)-style elapsed-time format:
  --date=elapsed          --date=elapsed-pad
  39s                     39s
  8h 7m 48s               08h 07m 48s
  1y 11M 5d 13h 5m 13s    01y 11M 05d 13h 05m 13s

The placeholder letter is X because the obvious choice E is already
used for the mailmap-respecting email variants (%aE, %cE, %gE).

Signed-off-by: Israel Roldan <israel.alberto.rv@gmail.com>
---
    [RFC PATCH] date: add --date=elapsed and %aX/%cX placeholders
    
    
    Motivation
    ==========
    
    The --date=human format and the %cr/%ch placeholders both produce a
    localized English phrase that hides the precise amount of time that has
    passed. A commit shown as "2 days ago" may in reality be 1 day 3 hours,
    or 1 day 23 hours. Switching to %ct and a calculator solves the problem
    but is not glance-friendly.
    
    The closest external tool that solves the same problem is
    git-log-compact by Kyle J. McKay (2016), which the maintainer declined
    to merge into Git core because it was a heavyweight change to the
    oneline output rather than a date format.
    
    
    What this patch adds
    ====================
    
    A new date format --date=elapsed and --date=elapsed-pad modelled on
    uptime(1):
    
      seconds   --date=elapsed          --date=elapsed-pad
          39    "39s"                   "39s"
         984    "16m 24s"               "16m 24s"
       29268    "8h 7m 48s"             "08h 07m 48s"
     3024000    "1M 5d 0s"              "01M 05d 00h 00m 00s"
    60527113    "1y 11M 5d 13h 5m 13s"  "01y 11M 05d 13h 05m 13s"
    
    
    The padded variant zero-pads every emitted unit to at least two digits.
    
    A commit timestamp that is in the future is reported as "0s", not the
    localized phrase "in the future" that show_date_relative() emits.
    
    Months are fixed at 30 days and years at 365 days, matching the
    uptime(1) convention. They are consistent, and the same approximations
    are already in use by Git's own show_date_relative() for the
    relative-time format.
    
    Two new pretty-format placeholders, %aX (author) and %cX (committer):
    
    git log --format='%h (%aX) %s'
    13c7afec21 (1d 2h 9s) The 8th batch
    8c7817c361 (1y 3d 19h 5m 10s) Merge branch 'rj/meson-libexecdir-fix'
    0e521a41b5 (11y 17d 21h 8m 40s) Merge branch 'et/http-proxyauth'
    
    
    The placeholders mirror %ch and %cr, which also ignore the caller's
    --date= and emit a fixed shape.
    
    
    Open questions
    ==============
    
    Q1. The placeholder letter. The natural mnemonic is E (Elapsed), but
    %aE, %cE and %gE are already taken (mailmap-respecting email variants).
    This patch uses X as a free letter. Would the maintainer prefer a
    different letter? I am not attached to X.
    
    Q2. Should --date=elapsed-pad be its own format name, or a separate
    --date=elapsed plus a flag? Which mirrors --date=human /
    --date=human-local / --date=iso / --date=iso-local.
    
    Q3. The "future timestamp" behaviour. This patch clamps a future
    timestamp to "0s". An alternative would be to keep the relative format's
    "in the future" wording.
    
    Q4. %aX/%cX are hard-coded compact; padded output requires %ad/%cd
    together with --date=elapsed-pad. Should a paired %aY/%cY for padded
    also exist, or is the asymmetry acceptable?
    
    
    Patch
    =====
    
    The patch modifies the existing date_mode_type enum, adds a new
    show_date_elapsed() helper in date.c, wires it through show_date() and
    parse_date_format(), exposes two placeholders via format_person_part()
    in pretty.c, handles the new format in builtin/blame.c for column width,
    updates the documentation, and adds tests for both the date helper and
    the pretty-format placeholder equivalence.
    
    The full patch is attached below.
    
    
    Testing
    =======
    
    $ make DEVELOPER=1 && cd t &&
    prove --no-color ./t0006-date.sh ./t4205-log-pretty-formats.sh
    ./t0006-date.sh ................ ok ./t4205-log-pretty-formats.sh .. ok
    All tests successful.
    
    The full test suite (1054 test files, 33832 tests) also passes on this
    machine.
    
    Thanks for your time. I am happy to iterate on any of the open questions
    before posting a non-RFC version.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2368%2Fairvzxf%2Ffeature%2Fdate-elapsed-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2368/airvzxf/feature/date-elapsed-v1
Pull-Request: https://github.com/git/git/pull/2368

 Documentation/pretty-formats.adoc      |  4 ++
 Documentation/rev-list-options.adoc    | 13 ++++
 builtin/blame.c                        |  8 +++
 contrib/completion/git-completion.bash |  2 +-
 date.c                                 | 88 +++++++++++++++++++++++++-
 date.h                                 |  4 +-
 pretty.c                               |  3 +
 t/helper/test-date.c                   | 19 +++++-
 t/t0006-date.sh                        | 43 +++++++++++++
 t/t4205-log-pretty-formats.sh          |  6 ++
 10 files changed, 186 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 2ae0eb11a9..9ae882b160 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -233,6 +233,8 @@ The placeholders are:
 +%as+:: author date, short format (`YYYY-MM-DD`)
 +%ah+:: author date, human style (like the `--date=human` option of
 	linkgit:git-rev-list[1])
++%aX+:: author date, elapsed (like the `--date=elapsed` option of
+	linkgit:git-rev-list[1])
 +%cn+:: committer name
 +%cN+:: committer name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -251,6 +253,8 @@ The placeholders are:
 +%cs+:: committer date, short format (`YYYY-MM-DD`)
 +%ch+:: committer date, human style (like the `--date=human` option of
 	linkgit:git-rev-list[1])
++%cX+:: committer date, elapsed (like the `--date=elapsed` option of
+	linkgit:git-rev-list[1])
 +%d+:: ref names, like the --decorate option of linkgit:git-log[1]
 +%D+:: ref names without the " (", ")" wrapping.
 +%(count)+:: the number of a patch within a patch series. Used only in
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index fd831f0ec6..937c6096c5 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1174,6 +1174,19 @@ omitted.
 1970).  As with `--raw`, this is always in UTC and therefore `-local`
 has no effect.
 
+`--date=elapsed` shows the elapsed time between the commit and now,
+in a compact, script-friendly, `uptime(1)`-style format. Only the
+non-zero leading units are emitted, separated by single spaces. For
+example "39s", "16m 24s", "8h 7m 48s", "12M 30d 13h 25m 43s",
+"1y 11M 5d 13h 5m 13s". A commit timestamp that is in the future
+is reported as "0s". Months are fixed at 30 days and years at 365
+days, matching the `uptime(1)` convention.
+
+`--date=elapsed-pad` is like `--date=elapsed`, but every emitted
+unit is at least two digits wide, zero-padded on the left, so
+that columns line up across rows.  For example "16m 24s",
+"08h 07m 48s", "01M 05d 00h 00m 00s", "01y 11M 05d 13h 05m 13s".
+
 `--date=format:<format>` feeds the _<format>_ to your system `strftime`,
 except for `%s`, `%z`, and `%Z`, which are handled internally.
 Use `--date=format:%c` to show the date in your system locale's
diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251c6d..f3fd866e82 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1123,6 +1123,14 @@ parse_done:
 		/* If the year is shown, no time is shown */
 		blame_date_width = sizeof("Thu Oct 19 16:00");
 		break;
+	case DATE_ELAPSED:
+	case DATE_ELAPSED_PAD:
+		/*
+		 * Maximum display width of the elapsed time format,
+		 * e.g. "99y 99M 99d 99h 99m 99s" -- a safe upper bound.
+		 */
+		blame_date_width = sizeof("99y 99M 99d 99h 99m 99s");
+		break;
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..4db014c7c0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2231,7 +2231,7 @@ __git_log_show_options="
 __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
 
 __git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
-__git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
+__git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix elapsed auto: format:"
 
 # Complete porcelain (i.e. not git-rev-list) options and at least some
 # option arguments accepted by git-log.  Note that this same set of options
diff --git a/date.c b/date.c
index 014065b419..566da2fd21 100644
--- a/date.c
+++ b/date.c
@@ -209,6 +209,79 @@ void show_date_relative(timestamp_t time, struct strbuf *timebuf)
 		 (diff + 183) / 365);
 }
 
+/*
+ * Print the elapsed time between `time` and now in a compact, script-friendly
+ * "uptime(1)"-style format: only non-zero units are emitted, left to right,
+ * separated by single spaces.  With `pad` set, every emitted unit is at least
+ * two digits wide, zero-padded on the left.
+ *
+ *   diff < 60s          -> "39s"
+ *   diff < 60m          -> "16m 24s"
+ *   diff < 24h          -> "08h 07m 48s" (pad) / "8h 7m 48s" (compact)
+ *   diff < 1y           -> "12M 30d 13h 25m 43s"
+ *   diff >= 1y          -> "01y 11M 05d 13h 05m 13s" (pad) / "1y 11M 5d ..." (compact)
+ *
+ * A negative diff (commit timestamp is in the future) clamps to "0s" so the
+ * output stays script-parseable instead of producing a localized phrase like
+ * "in the future" as `show_date_relative()` does.
+ */
+static void show_date_elapsed(timestamp_t time, struct strbuf *timebuf, int pad)
+{
+	struct timeval now;
+	timestamp_t diff, y, M, d, h, m, s;
+	const char *sp = " ";
+
+	get_time(&now);
+	if (now.tv_sec < time)
+		diff = 0;
+	else
+		diff = now.tv_sec - time;
+
+#define ELAPSED_SECS_PER_MIN  (60L)
+#define ELAPSED_SECS_PER_HOUR (60L * 60L)
+#define ELAPSED_SECS_PER_DAY  (24L * 60L * 60L)
+#define ELAPSED_SECS_PER_MON  (30L * 24L * 60L * 60L)        /* uptime(1) convention */
+#define ELAPSED_SECS_PER_YEAR (365L * 24L * 60L * 60L)       /* uptime(1) convention */
+
+	y  = diff / ELAPSED_SECS_PER_YEAR;
+	diff %= ELAPSED_SECS_PER_YEAR;
+	M  = diff / ELAPSED_SECS_PER_MON;
+	diff %= ELAPSED_SECS_PER_MON;
+	d  = diff / ELAPSED_SECS_PER_DAY;
+	diff %= ELAPSED_SECS_PER_DAY;
+	h  = diff / ELAPSED_SECS_PER_HOUR;
+	diff %= ELAPSED_SECS_PER_HOUR;
+	m  = diff / ELAPSED_SECS_PER_MIN;
+	s  = diff % ELAPSED_SECS_PER_MIN;
+
+#undef ELAPSED_SECS_PER_MIN
+#undef ELAPSED_SECS_PER_HOUR
+#undef ELAPSED_SECS_PER_DAY
+#undef ELAPSED_SECS_PER_MON
+#undef ELAPSED_SECS_PER_YEAR
+
+	if (!pad && !y && !M && !d && !h && !m) {
+		strbuf_addf(timebuf, "%"PRItime"s", s);
+		return;
+	}
+
+	if (pad) {
+		if (y) strbuf_addf(timebuf, "%02"PRItime"y%c", y, *sp);
+		if (y || M) strbuf_addf(timebuf, "%02"PRItime"M%c", M, *sp);
+		if (y || M || d) strbuf_addf(timebuf, "%02"PRItime"d%c", d, *sp);
+		if (y || M || d || h) strbuf_addf(timebuf, "%02"PRItime"h%c", h, *sp);
+		if (y || M || d || h || m) strbuf_addf(timebuf, "%02"PRItime"m%c", m, *sp);
+		strbuf_addf(timebuf, "%02"PRItime"s", s);
+	} else {
+		if (y) strbuf_addf(timebuf, "%"PRItime"y%c", y, *sp);
+		if (M) strbuf_addf(timebuf, "%"PRItime"M%c", M, *sp);
+		if (d) strbuf_addf(timebuf, "%"PRItime"d%c", d, *sp);
+		if (h) strbuf_addf(timebuf, "%"PRItime"h%c", h, *sp);
+		if (m) strbuf_addf(timebuf, "%"PRItime"m%c", m, *sp);
+		strbuf_addf(timebuf, "%"PRItime"s", s);
+	}
+}
+
 struct date_mode date_mode_from_type(enum date_mode_type type)
 {
 	struct date_mode mode = DATE_MODE_INIT;
@@ -323,6 +396,12 @@ const char *show_date(timestamp_t time, int tz, struct date_mode mode)
 		return timebuf.buf;
 	}
 
+	if (mode.type == DATE_ELAPSED || mode.type == DATE_ELAPSED_PAD) {
+		strbuf_reset(&timebuf);
+		show_date_elapsed(time, &timebuf, mode.type == DATE_ELAPSED_PAD);
+		return timebuf.buf;
+	}
+
 	if (mode.local)
 		tm = time_to_tm_local(time, &tmbuf);
 	else
@@ -1009,6 +1088,8 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
 		return DATE_RAW;
 	if (skip_prefix(format, "unix", end))
 		return DATE_UNIX;
+	if (skip_prefix(format, "elapsed", end))
+		return DATE_ELAPSED;
 	if (skip_prefix(format, "format", end))
 		return DATE_STRFTIME;
 	/*
@@ -1038,7 +1119,12 @@ void parse_date_format(const char *format, struct date_mode *mode)
 	mode->type = parse_date_type(format, &p);
 	mode->local = 0;
 
-	if (skip_prefix(p, "-local", &p))
+	if (mode->type == DATE_ELAPSED) {
+		if (skip_prefix(p, "-pad", &p))
+			mode->type = DATE_ELAPSED_PAD;
+		if (*p)
+			die("unknown date format %s", format);
+	} else if (skip_prefix(p, "-local", &p))
 		mode->local = 1;
 
 	if (mode->type == DATE_STRFTIME) {
diff --git a/date.h b/date.h
index 0747864fd7..eb7f1fb6ad 100644
--- a/date.h
+++ b/date.h
@@ -17,7 +17,9 @@ enum date_mode_type {
 	DATE_RFC2822,
 	DATE_STRFTIME,
 	DATE_RAW,
-	DATE_UNIX
+	DATE_UNIX,
+	DATE_ELAPSED,
+	DATE_ELAPSED_PAD
 };
 
 struct date_mode {
diff --git a/pretty.c b/pretty.c
index d8a9f370f6..9ba274c64a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -848,6 +848,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	case 'h':	/* date, human */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(HUMAN)));
 		return placeholder_len;
+	case 'X':	/* date, elapsed */
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ELAPSED)));
+		return placeholder_len;
 	case 's':
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
 		return placeholder_len;
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 87d2ad6fca..13101201d0 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -11,7 +11,9 @@ static const char *const usage_msg = "\n"
 "  test-tool date timestamp [date]...\n"
 "  test-tool date getnanos [start-nanos]\n"
 "  test-tool date is64bit\n"
-"  test-tool date time_t-is64bit\n";
+"  test-tool date time_t-is64bit\n"
+"  test-tool date elapsed [time_t]...\n"
+"  test-tool date elapsed-pad [time_t]...\n";
 
 static void show_relative_dates(const char **argv)
 {
@@ -33,6 +35,17 @@ static void show_human_dates(const char **argv)
 	}
 }
 
+static void show_elapsed_dates(const char **argv, int pad)
+{
+	for (; *argv; argv++) {
+		time_t t = atoi(*argv);
+		struct date_mode mode = DATE_MODE(ELAPSED);
+		if (pad)
+			mode = DATE_MODE(ELAPSED_PAD);
+		printf("%s -> %s\n", *argv, show_date(t, 0, mode));
+	}
+}
+
 static void show_dates(const char **argv, const char *format)
 {
 	struct date_mode mode = DATE_MODE_INIT;
@@ -115,6 +128,10 @@ int cmd__date(int argc UNUSED, const char **argv)
 		show_relative_dates(argv+1);
 	else if (!strcmp(*argv, "human"))
 		show_human_dates(argv+1);
+	else if (!strcmp(*argv, "elapsed"))
+		show_elapsed_dates(argv+1, 0);
+	else if (!strcmp(*argv, "elapsed-pad"))
+		show_elapsed_dates(argv+1, 1);
 	else if (skip_prefix(*argv, "show:", &x))
 		show_dates(argv+1, x);
 	else if (!strcmp(*argv, "parse"))
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 6e63130ea2..7b2bc2178b 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -266,4 +266,47 @@ check_date_format_human 37500000 "Jun 22 2008" # 1 year, 2 months ago
 check_date_format_human 55188000 "Dec 1 2007" # 1 year, 9 months ago
 check_date_format_human 630000000 "Sep 13 1989" # 20 years ago
 
+check_date_format_elapsed() {
+	t=$(($GIT_TEST_DATE_NOW - $1))
+	pad=$2
+	expect=$3
+	if test -n "$pad"
+	then
+		desc="elapsed-pad $t"
+		cmd="elapsed-pad"
+	else
+		desc="elapsed $t"
+		cmd="elapsed"
+	fi
+	echo "$t -> $expect" >expect
+	test_expect_success "$desc" '
+		GIT_TEST_DATE_NOW=$GIT_TEST_DATE_NOW test-tool date '"$cmd"' $t >actual &&
+		test_cmp expect actual
+	'
+}
+
+# seconds-only
+check_date_format_elapsed       5  '' "5s"
+check_date_format_elapsed      39  '' "39s"
+# minutes + seconds
+check_date_format_elapsed      60  '' "1m 0s"
+check_date_format_elapsed     984  '' "16m 24s"
+# hours + minutes + seconds
+check_date_format_elapsed    29268 '' "8h 7m 48s"
+# months + days + hours + minutes + seconds (no year)
+check_date_format_elapsed  3024000 '' "1M 5d 0s"
+# years + everything
+check_date_format_elapsed 37890313 '' "1y 2M 13d 13h 5m 13s"
+check_date_format_elapsed 60527113 '' "1y 11M 5d 13h 5m 13s"
+
+# padded variant: same units but zero-padded to at least 2 digits
+check_date_format_elapsed       5 1 "05s"
+check_date_format_elapsed      39 1 "39s"
+check_date_format_elapsed      60 1 "01m 00s"
+check_date_format_elapsed     984 1 "16m 24s"
+check_date_format_elapsed    29268 1 "08h 07m 48s"
+check_date_format_elapsed  3024000 1 "01M 05d 00h 00m 00s"
+check_date_format_elapsed 37890313 1 "01y 02M 13d 13h 05m 13s"
+check_date_format_elapsed 60527113 1 "01y 11M 05d 13h 05m 13s"
+
 test_done
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4be5c51489..307be52b8f 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -557,6 +557,12 @@ test_expect_success '--date=human %ad%cd is the same as %ah%ch' '
 	test_cmp expected actual
 '
 
+test_expect_success '--date=elapsed %ad%cd is the same as %aX%cX' '
+	git log --format=%ad%n%cd --date=elapsed >expected &&
+	git log --format=%aX%n%cX >actual &&
+	test_cmp expected actual
+'
+
 # get new digests (with no abbreviations)
 test_expect_success 'set up log decoration tests' '
 	head1=$(git rev-parse --verify HEAD~0) &&

base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
-- 
gitgitgadget
