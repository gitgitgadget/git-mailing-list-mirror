Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2736EA93
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641943; cv=none; b=Fikj6pJS20lIOrJM1nAPiToCfJHNG4KoVpXn3oAlsTncgsBdWEXssYzdcqVZJxhn7WL23CV9uOU3SN78JEIWHHa4LeEPqyBR/f/9pvQ7y87Ab6lrFMqcjxy2APyzBCNPrucDi1TciDyrFM2pVnn1xGg86e28n4MM3rjC7euT6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641943; c=relaxed/simple;
	bh=jWaLbGB9kyBmrIAZECIyEYVW/wGe8+qegax7d7kMRFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6i5iH35qOsCMQx0lF18eYRM2m+W6+71QbiWP8EzimIUmcQS80qumJ9kRuq+GgzboLnvBzE6+WRI+19z6YDuk0XXAKVQemTVIb98IeP4aVXIJzdE3cm4go/xjI3laBNPC9nfbd0UigmFvjlEChEpQToETknAzxGtxUbE0AFgIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WQxYO0Cm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ubrk+Fa8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WQxYO0Cm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ubrk+Fa8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 45469EC0290;
	Thu, 13 Aug 2026 13:25:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 13 Aug 2026 13:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786641940;
	 x=1786728340; bh=1SFzry0BrjY4rLwKNnHwM3nHYn6Jw0UQXPkRd3ONXz4=; b=
	WQxYO0CmE6FbKneYgWBnYeLl+QWgtTELP/CpBbxLMgLImfDEnzteli+D0inRg9CQ
	ljvqb/Q45hYFK/OPI9H+ik8nnxk3S36Caimviakj1x3hMjLjekxR4GETayLcWo/B
	ys3bRau3KoANGZS1OeEVPqncIpkZ9/XWztrhURKE8F425jLOfiNvIKnkXL4f3ue2
	2AIGmgIjdQ9mfPhR/UFS4DoPFofRDnIZJW5KivkVp289Z2cyjDL32cNVVbSxJAPW
	LRq2QtHxvlI2bNQipyRBGWK2Xr7gozitDyuWcFbjB3OoUC7JqtugQ5o8Z+v+LBBZ
	disU8ODYMn6QcOeKLjeAYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786641940; x=
	1786728340; bh=1SFzry0BrjY4rLwKNnHwM3nHYn6Jw0UQXPkRd3ONXz4=; b=U
	brk+Fa8zqAsePSchO3JvqXTL4eteRv31IVJqMrzi0R26i+F189/8LJc0XPbluQy2
	Yf85CRzN0HsWf5Q5g7uSYoj4+OIDe8YoFQTBMebXZpOblK2N/YNpUAwOZm3MPkVi
	KksmnialxbwzaPhPtmaK7bDndRURrX3+VdabXx6Evh/9Z4oWu7cTPa84JypYRTOA
	nBkpaD4v0fkBi/00LtnRvrnVqgf3kmpKKloMYFzHabdAwlkHE75BjNa+16ASlwVz
	0czdO3GhclomX0Kc2ZvCWZnKTRHtbaBxH8QuwXv6C/+y31k7BX4aMouixvfIeCJ5
	9yfqH75YmMqHJk7NfYphg==
X-ME-Sender: <xms:FP59amOWNbBorItb7L4cesY1iMI_un0k8Vwye7qgKq2ndgy8eEQvSwU>
    <xme:FP59aq-ZxYGyizAvAluulS6rqej33oDjstkHYJTm6UpkK0ShIMd3ZNk4t-aD2wyXf
    cExzX92lVGcFbIFnB--LP1bVs03xIiCyWhND8C0gG9gPyTi7uQntQ>
X-ME-Received: <xmr:FP59aq6f0mw4H-KdAz9X2PMP3vfryYTy1PJHCaLwLh7yjf9gbOA-kPXBX6gZAf37CZiNKvpmq8V-iS-7c4h-ISZlPmg7mPuabpC_LftHo0BtxaskwDrzUY4>
X-ME-Proxy-Cause: dmFkZTExzudN44kNOyfX/IUM0Z+YVMFjEVdrCpQ2Q/2nVbYiX7Akb/B+1KSQQbtB4IaOO7
    A88aHSeWmy6LXUZsH/IPe/7TRmJfITmZvCGMx+egk7l/IDnaskhyab8KR2ydxZLWEQNb2O
    rn3ky5p2tthxzNYT8oYMb8gdIvhA/DtLO99Smavf5GJTcJ2FQZXSabFvl6vltlphbm/aRP
    YOK+KB/ox7GDh8n5pBuvQpUZJrEHvaYbx1YGlYYSh2q18iyvYzEgXmDaXuYLZ8CwgxAdoA
    nVlmL1BQFUwBuwLRAWCsuXPn3vlJkAAPGO5d/AydE6fInm0jfQaKjJj+gK7tWl0xehrMO5
    2F2PZXjLfKTJ4U5dX65Raysin1vKVf87Gu9M/jufQ3o8GRIrJFIGnTYI2nCEtxJ/k3sbjY
    Budn0FYBQOAOnQYFUtZkMF8Vb4N448MnX6Ww8Mnt3BlZsBdbaHjmrCJ93btI4Kyl2o9dzN
    2SivWpuSzo8fVMhj/5fEEAr5gmhPor4u7XDHFbPcVrrN26z8uAmer7H0DNe+OCwF2PJNps
    tXYsUZmj3lp/SDi3iUBlWBLichFFDcL9906EZhVQXWxDtH7kA2vfmxClS+tinIqmgWkphI
    4DxDApA5UVafb+LI7c2BQmsLKauc4k29DVGnzAbBCArHFPFrON9qz4gXWfQw
X-ME-Proxy: <xmx:FP59ah2aZtGquaUqfqgM-iI96KvX9tqyd8f-Izf5zzhrlPk3bBdOtQ>
    <xmx:FP59ahAqqHlM5zgACBwjV-D7oTrGuZP33uumSBYyrwDpnJXiLf6f4g>
    <xmx:FP59aj00vCas_gDHErFsojhw5jbZ6LOa7JkdQcK4CRv7Z1b7oeiEhg>
    <xmx:FP59aru-4X7HBBdVFNuJGjFSYqF76gqaux_AxEyKSxev3HfhJtAwJg>
    <xmx:FP59ahmSvPiPHnu6fakmt4U5sEuxq2dqWKyfsMuWfKoiPZtwE6OF0zcu>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:25:39 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 4/4] format-rev: learn --abbrev, --color, and --date
Date: Thu, 13 Aug 2026 19:24:00 +0200
Message-ID: <format-rev_three_more_opts.b84@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_format-rev_three_more_opts.b80@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
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
    > We can see which are missing by taking a look at
    
    Or am I missing some?

 Documentation/git-format-rev.adoc | 44 ++++++++++++++++++++++++++++---
 builtin/name-rev.c                | 42 ++++++++++++++++++++---------
 t/t6120-describe.sh               | 44 +++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 15 deletions(-)

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
index 7d824aa1c5d..0c9014ca594 100644
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
+	parse_date_format(arg, &data->date_mode);
+	data->date_mode_explicit = 1;
+	BUG_ON_OPT_NEG(unset);
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
 
@@ -817,13 +830,13 @@ int cmd_format_rev(int argc,
 		   struct repository *repo UNUSED)
 {
 	struct format_rev_data data = {
-		NULL, NULL, 0, 0, STRING_LIST_INIT_NODUP
+		NULL, NULL, 0, 0, STRING_LIST_INIT_NODUP,
+		REV_INFO_INIT, GIT_COLOR_AUTO
 	};
 	enum stdin_mode stdin_mode;
 	char output_terminator;
 	strbuf_getline_fn getline_fn;
 	struct display_notes_opt format_notes_opt;
-	struct rev_info format_rev = REV_INFO_INIT;
 	struct pretty_format format_pp = { 0 };
 	struct strbuf scratch_buf = STRBUF_INIT;
 	struct command cmd;
@@ -834,6 +847,11 @@ int cmd_format_rev(int argc,
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
@@ -862,13 +880,13 @@ int cmd_format_rev(int argc,
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
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 7a7c46658a3..2621edb5937 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -1017,4 +1017,48 @@ do
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
+		"$opts" --format="$format" >expect <input &&
+	git -C repo-format format-rev "$opts" \
+		--stdin-mode=revs --format="$format" >actual <input &&
+	test_cmp expect actual
+}
+
+format_rev_err_cmp_log () {
+	opts="$1"
+	format=reference
+	# No input since we ought to fail while parsing options
+	test_must_fail git -C repo-format log --stdin --no-walk \
+		"$opts" --format="$format" 2>expect &&
+	test_must_fail git -C repo-format format-rev "$opts" \
+		--stdin-mode=revs --format="$format" 2>actual &&
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
+	format_rev_cmp_log --abbrev=31 &&
+	format_rev_cmp_log --no-abbrev
+'
+
+test_expect_success 'format-rev --date' '
+	format_rev_cmp_log --date=relative &&
+	format_rev_cmp_log --date=iso-strict &&
+	format_rev_err_cmp_log --date=not-valid
+'
+
 test_done
-- 
2.54.0.22.g9e26862b904

