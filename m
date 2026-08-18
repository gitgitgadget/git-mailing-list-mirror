Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB912EC0A2
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047165; cv=none; b=MYlLJcdWsdX6mZeQj6JOXnNJ1+WxScbKM+sl7m/iHAGid6Vgcq1SzP3/25kClL5u0rGsd5olmT3Gt4uPl1uyTmV3GQGdM+yvAd/GsHfHrxrMKeQigQmvfcbKCJnRE/0rAywQ4ur8ca7V6L6KK7xnWxEfExunfTZlVUbDcwXAd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047165; c=relaxed/simple;
	bh=ERwh4VGkedtqjfpNml5ms6vyYnkPJhbVURhCbpmiRpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dm4AqB7FFCoEtOguZYgd7gsiyTyocpXkpPYljwmLIfHOxNUn5r+OI3++nED6VtaHEscKTpE2AMVBXPwwJHR+4/WddEF1GnDyPkQdW2Q2MMitu5fIYZDaZx21GM2TrmocwGJ4/mVAfp6RjgVw6qGFrAf72uxeAK+jwm4vXe950+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FRT6+SU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJ3FOLI9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FRT6+SU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJ3FOLI9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FC9914000E2;
	Tue, 18 Aug 2026 05:59:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 18 Aug 2026 05:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787047163;
	 x=1787133563; bh=D2gPk0Z4oM5NDOE/6EvOtRZazWCuHTSWouK5ZxB0Nd8=; b=
	FRT6+SU+s58wLHis3T84fxH+k5gmQp0Z4Mc8LbOAszb39zIV9ckqWYr9vHkUzmC2
	2UAKNdJ9bt3/CT3XLgPLxTzUaynOtILPF9rmxWqhxdTpatdnd0ZxBgpNhenIdPuj
	D1XMPZMTOCGNtw7NHPIMTEGtt+8U8pXu61Lji+JzIvTdegRytqbsa/8KLGCZRhjE
	wnxL0GAmCQkteV/tU8OEEj5eqtiKPtHPA/fCyY6tHEQZy44JzetocBuE3jtmb5JA
	UZlX5/6MfLzPYuTzrjIrEXB9FY6z8+7yfUPkOfOqek1UBFl/maT2uSp+XQ+4XCib
	HcEYGOlgA9gFXO/HIheQ4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787047163; x=
	1787133563; bh=D2gPk0Z4oM5NDOE/6EvOtRZazWCuHTSWouK5ZxB0Nd8=; b=H
	J3FOLI9yYUZpJjbUGm1BMDY/FGW8GeAAhHzVVg/KjjDsnQijv3bRUTUAMZ9aW6PQ
	o0cBKTG+5ycfj/QcfHQgANcuJS3r6BNL6wEINQioPtjNBQ23U19EkomWtf7Uqxy/
	Hqk4F22GQ2k2hfMtpeRuZQCeDmYP86TzJeDXm0VIbAbH0PVaNK8OQJ9fBc/Mzbn4
	1M5lRno8Glh59m74GxAaPJVnjKymim/Ta8T2AEWk9jbqjM7uWpsvGPpuggX/Dbdt
	BKBxGcrvpA+GDIdOFwj1QvtFwgbVr06lSyUhIF6mUdBmIBLPyk/LUFgXpaED2NXW
	fbFCy4ugcOrtGUT9Mh2FA==
X-ME-Sender: <xms:-yyEak5Du9bgmhbqLPjXGXNBtH_WY3qD_TDju40r0CW-VpYQZLaQoMY>
    <xme:-yyEar5brzS2KRY1L-G-M-K5PwHAgUwGpECflRIkWDcUz5c9oAaSgGwu1oKPKLxQ0
    i5DZmwDtLTgvqnJ_AHGGN7vMVQwM7RU2_SGFDQzK63DYsWXKpyJ9vI>
X-ME-Received: <xmr:-yyEahG6h4bvjmLN6xo_EEvrFlcbPEwquaf7YcyeJfePYuerlK8hnLUfrKFoeC1XBPe7u_5ISyl01f_xMhHE9Jl-pOXnqn235ZIH5DU>
X-ME-Proxy-Cause: dmFkZTFHcWio8FuVqgNqNUgfENUcQ9fvZuK+bI1IctabD2kVe+Bqwy/OEni/14H2C8mwvF
    kHk9Td0Ev6IQ2ziQZbUTklK7QoA0r8k2BGif2X9kg6C+pl57Ttyp4IhWofNlHaFmvTVqgh
    tVjXGZmJPrfp3TtEEEBu4ozEJNUxuHJCSbb/2PGCEN7/+Z9KpbC29vTMW5vnyUT5RPsvoL
    thACopxkT6jdLogN30ULq1NGcrz4atWTPZ6OkDZWmmG5pYPdUR7aAu+dy5dMwxeyxq7VXg
    4lhQfxQBqBZ3BeL/iCpmAZDb0uWAjZOtIlgqp9TmiTPhnPEDgcj69jNHf9Lpgt/OQ05Cjw
    CrLV5+3uAPlP7EKzR8KeaMZNnLYtQLAX6tHp2j8rheb5gHw/rKFdhENUY1zGDXToTFe+ev
    qypz5sWn7jDL5345Jf3FUtZ2TnzP4bJNhAB/ScH+7V7bCkEkvE2anFPYyH/sC2TENs8JdN
    KbczYwk9vVfjojGXN4RtvstI/f1SYrHo99vKT9fe0/Fy402bTqauh31RKH9hwceegP2FPq
    0prKsJwo+v1+PmI5V2njcFDD01nEusorNnsdxwYb7p3XwpQ70LkKbiPTO6QXLB7N0CrTMu
    S2rmhUbTCDSJbNEN32ah8fhhqJasfmjhNgwXRpjTIUMf55rrKQz98CyUm7/g
X-ME-Proxy: <xmx:-yyEakTIe6b5TNnGAfWhy1xphumBb3RoxiLdJbHtNvFbbk16RRP-5g>
    <xmx:-yyEaqvaF5k4ajcBUABdXO2R8YHnTsYUdhhijvnb6jsCKu-a8ZWcfw>
    <xmx:-yyEajyo2Rp8yOVHxux1jRo7mlh1Gy-fISK3BjoLRRfNRCOHGD5urg>
    <xmx:-yyEak48t_bHPFiW-ec96yTN_mfm0jCvo_M9lRPvT9ImlLR2g9l5SQ>
    <xmx:-yyEaoQQKlc-S017RguvFIyXhy4rvrlJvMy72biDe9jVXfEZf6arc_3e>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 05:59:22 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 5/5] format-rev: learn --abbrev, --color, and --date
Date: Tue, 18 Aug 2026 11:57:34 +0200
Message-ID: <V2_format-rev_three_more_opts.bd8@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz> <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Add three more options for controlling the formatting.

This does not complete all the pretty formatting knobs for this command
relative to e.g. git-log(1), but it does add the most important ones, in
my opinion. We can see which are missing by taking a look at
`Documentation/pretty-options.adoc`:

• `--encoding=<encoding>`
• `--show-signature`
• `--expand-tabs=<n>`

***

We could add these options to the command synopsis, but let’s instead
simplify the synopsis to just mention the mandatory options and stuff
the other ones into `[<options>]`. I don’t think a long command synopsis
line is useful. And this way the two mandatory options stand out more.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Designated initializers: https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/
    • Fix useless `BUG` placements https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/
    • Add a few more tests for different option arguments (or no args)
    • And the new tests revealed that I needed to change the helper
      functions so that the option (`opts`) goes last. Or else we
      couldn’t test bare `--date` (no arg, error) because of
      inconsistent ordering between log/format-rev and this:
    
          $ git format-rev --date --stdin-mode=revs
          fatal: unknown date format --stdin-mode=revs
    • Release `date_mode`: https://lore.kernel.org/git/3a55c58f-1ada-414c-a35d-40590c635b82@app.fastmail.com/
    
      I wondered if I would need a `goto cleanup` in order to deal with cases
      like this:
    
          ... --date=format:%c --format
    
      In other words, the command fails because we are missing an
      argument to `--format` but we have at that point already called
      the parse function. But my leakcheck setup didn’t call out any
      errors:
    
          CC = clang
          SANITIZE = address
          CFLAGS = -O1 -g3 -fno-omit-frame-pointer
          NO_GETTEXT = 1
    ---
    v1:
    > We can see which are missing by taking a look at
    
    Or am I missing some?

 Documentation/git-format-rev.adoc | 44 +++++++++++++++++++++--
 builtin/name-rev.c                | 42 ++++++++++++++++------
 t/t6120-describe.sh               | 58 +++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 505a52feccd..1a06ccbf9b8 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -9,7 +9,7 @@ git-format-rev - EXPERIMENTAL: Pretty format revisions on demand
 SYNOPSIS
 --------
 [synopsis]
-(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--[no-]notes=<ref>] [-z] [--[no-]null-output] [--[no-]null-input]
+(EXPERIMENTAL!) git format-rev [<options>] --stdin-mode=<mode> --format=<pretty>
 
 DESCRIPTION
 -----------
@@ -33,8 +33,8 @@ OPTIONS
 The argument `rev` is also accepted.
 
 `text`;; Formats all commit object names found in freeform text. These
-	must be full object names, i.e. abbreviated hexadecimal object
-	names will not be interpreted.
+	must be full object names, i.e. abbreviated hexadecimal (_hex_)
+	object names will not be interpreted.
 +
 Anything that is parsed as an object name but that is not found to be a
 commit object name is left alone (echoed).
@@ -76,6 +76,44 @@ This is useful if the output could contain newlines, for example if the
 +
 This is useful if the input revision expressions could contain newlines.
 
+`--color[=<when>]`::
+`--no-color`::
+	Respect color formatting. The default color behavior is
+	`auto`. Bare `--color` is the same as `--color=always`.
++
+Giving `--no-color` is the same as `--color=never`.
++
+_<when>_ must be one of:
++
+--
+`always`;;
+	Always use color, even if the output is something like a file.
+`never`;;
+	Never use color.
+`auto`;;
+	Use color when the output is a terminal but not when the output
+	is something like a file.
+--
+
+`--abbrev[=<n>]`::
+`--no-abbrev`::
+	Abbreviate the commit hex output. Without _<n>_ it will find the
+	minimum length which can describe the commit uniquely, with some
+	extra slack. Giving _<n>_ specifies the minimum length; a longer
+	length will be used if needed.
++
+Giving `--no-abbrev` will turn off abbreviation, showing the full commit
+hex output.
++
+Note that some pretty formats use `--abbrev`. This behavior can be
+controlled with these two options.
+
+`--date=<format>`::
+	Date format for pretty formats. Note that date atoms like `%aI`
+	are not affected. This option cannot be negated.
++
+include::rev-list-option-date-alternatives.adoc[]
+
 [[io]]
 INPUT AND OUTPUT FORMAT
 -----------------------
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c8cb2f2d520..fa20a2774be 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -21,6 +21,7 @@
 #include "revision.h"
 #include "notes.h"
 #include "write-or-die.h"
+#include "date.h"
 
 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
@@ -778,6 +779,8 @@ struct format_rev_data {
 	bool nul_input;
 	bool nul_output;
 	struct string_list notes;
+	struct rev_info rev;
+	int color;
 };
 
 static int format_nul_cb(const struct option *option,
@@ -792,6 +795,17 @@ static int format_nul_cb(const struct option *option,
 	return 0;
 }
 
+static int date_cb(const struct option *option,
+		   const char *arg,
+		   int unset)
+{
+	struct rev_info *data = option->value;
+	BUG_ON_OPT_NEG(unset);
+	parse_date_format(arg, &data->date_mode);
+	data->date_mode_explicit = 1;
+	return 0;
+}
+
 static enum stdin_mode parse_stdin_mode(const char *stdin_mode)
 {
 	if (!strcmp(stdin_mode, "text"))
@@ -805,9 +819,8 @@ static enum stdin_mode parse_stdin_mode(const char *stdin_mode)
 }
 
 static char const *const format_rev_usage[] = {
-	N_("(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> "
-	   "--format=<pretty> [--[no-]notes=<ref>] "
-	   "[-z] [--[no-]null-output] [--[no-]null-input]"),
+	N_("(EXPERIMENTAL!) git format-rev [<options>] "
+	   "--stdin-mode=<mode> --format=<pretty>"),
 	NULL
 };
 
@@ -818,12 +831,13 @@ int cmd_format_rev(int argc,
 {
 	struct format_rev_data data = {
 		.notes = STRING_LIST_INIT_NODUP,
+		.rev = REV_INFO_INIT,
+		.color = GIT_COLOR_AUTO,
 	};
 	enum stdin_mode stdin_mode;
 	char output_terminator;
 	strbuf_getline_fn getline_fn;
 	struct display_notes_opt format_notes_opt;
-	struct rev_info format_rev = REV_INFO_INIT;
 	struct pretty_format format_pp = { 0 };
 	struct strbuf scratch_buf = STRBUF_INIT;
 	struct command cmd;
@@ -834,6 +848,11 @@ int cmd_format_rev(int argc,
 			   N_("how revs are processed")),
 		OPT_STRING_LIST(0, "notes", &data.notes, N_("notes"),
 				N_("display notes for pretty format")),
+		OPT__ABBREV(&data.rev.abbrev),
+		OPT__COLOR(&data.color, N_("use colored output")),
+		OPT_CALLBACK_F(0, "date", &data.rev, N_("date"),
+			       N_("date format"),
+			       PARSE_OPT_NONEG, date_cb),
 		OPT_CALLBACK_F('z', "null", &data, N_("z"),
 			       N_("use NUL for input and output termination"),
 			       PARSE_OPT_NOARG | PARSE_OPT_NONEG, format_nul_cb),
@@ -862,13 +881,13 @@ int cmd_format_rev(int argc,
 	init_display_notes(&format_notes_opt);
 	stdin_mode = parse_stdin_mode(data.stdin_mode);
 
-	get_commit_format(data.format, &format_rev);
-	format_pp.ctx.rev = &format_rev;
-	format_pp.ctx.fmt = format_rev.commit_format;
-	format_pp.ctx.abbrev = format_rev.abbrev;
-	format_pp.ctx.date_mode_explicit = format_rev.date_mode_explicit;
-	format_pp.ctx.date_mode = format_rev.date_mode;
-	format_pp.ctx.color = GIT_COLOR_AUTO;
+	get_commit_format(data.format, &data.rev);
+	format_pp.ctx.rev = &data.rev;
+	format_pp.ctx.fmt = data.rev.commit_format;
+	format_pp.ctx.abbrev = data.rev.abbrev;
+	format_pp.ctx.date_mode_explicit = data.rev.date_mode_explicit;
+	format_pp.ctx.date_mode = data.rev.date_mode;
+	format_pp.ctx.color = data.color;
 
 	userformat_find_requirements(data.format,
 				     &format_pp.want);
@@ -935,6 +954,7 @@ int cmd_format_rev(int argc,
 		BUG("uncovered case: %d", stdin_mode);
 	}
 
+	date_mode_release(&data.rev.date_mode);
 	strbuf_release(&scratch_buf);
 	string_list_clear(&data.notes, 0);
 	release_display_notes(&format_notes_opt);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 7a7c46658a3..a15da979abf 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -1017,4 +1017,62 @@ do
 	'
 done <stdin-modes
 
+format_rev_cmp_log () {
+	opts="$1"
+	format=reference
+	cat >input <<-\EOF &&
+	third
+	second
+	first
+	EOF
+	git -C repo-format log --stdin --no-walk \
+		--format="$format" "$opts" >expect <input &&
+	git -C repo-format format-rev --stdin-mode=revs \
+		--format="$format" "$opts" >actual <input &&
+	test_cmp expect actual
+}
+
+format_rev_err_cmp_log () {
+	opts="$1"
+	format=reference
+	# No input since we ought to fail while parsing options
+	test_must_fail git -C repo-format log --stdin --no-walk \
+		--format="$format" "$opts" 2>expect &&
+	test_must_fail git -C repo-format format-rev \
+		--stdin-mode=revs --format="$format" "$opts" 2>actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'format-rev --color' '
+	format_rev_cmp_log --color=always &&
+	format_rev_cmp_log --color &&
+	format_rev_cmp_log --no-color &&
+	format_rev_err_cmp_log --color=not-valid
+'
+
+test_expect_success 'format-rev --abbrev' '
+	format_rev_cmp_log --abbrev &&
+	format_rev_cmp_log --abbrev=31 &&
+	format_rev_cmp_log --no-abbrev
+'
+
+test_expect_success 'format-rev --date' '
+	format_rev_cmp_log --date=relative &&
+	format_rev_cmp_log --date=iso-strict &&
+	# This also tests the only case where we need to release
+	# the data for the parsed format
+	format_rev_cmp_log --date="format:%c" &&
+	format_rev_err_cmp_log --date=not-valid &&
+	# Test --date (no arg) next
+	# We cannot compare the output to git-log(1)
+	# because that command uses a slightly different
+	# error message (different library)
+	cat >expect <<-EOF &&
+	error: option \`date${SQ} requires a value
+	EOF
+	test_must_fail git -C repo-format format-rev \
+		--stdin-mode=revs --format="$format" --date 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.55.0.13.g85d2d65e389

