Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495A3081BB
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820116; cv=none; b=qKbeSoDNNpb5raLZUYqS1xo6o8ew9NYa5f6ja346HBF2oAs/8XGVJy6Uimb2BHXvfLILi1IjY8VzMmRl0mXYUFXic7l/f4XhJoYOYGNLesOET5rAnXuOvlxM2N6sWUDhxahp1DwXQDU2+s4mrYjDIOBVzq0TQJvQByt2PTZPiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820116; c=relaxed/simple;
	bh=sKgZ8G1JWWcsLL0F96heOW3Nz7oxy7hH8yoTlCmfJpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZSuwbatIXBfxjNBZyqsFpBOFrcQpEu53JXxzTPlb1QOPxsSgudiYg2LdbY5GD/UC0j+uf0zKV+WaMolvnZKdWImRoxHb5sb4i61Xxh20klEb/IKEbbpKxV3ognYAqEBjVZjQwT4tHkgP0CR8m6pPL6eFhwRuvyDlSh8q7Druz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tg6ojufr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hoN4kyGs; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tg6ojufr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hoN4kyGs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A176EC01E2;
	Thu, 25 Sep 2025 13:08:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 25 Sep 2025 13:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758820113;
	 x=1758906513; bh=2ALSPSD7bN7Ts+3/d+82SNIugoi83JaCku/JU611PR4=; b=
	Tg6ojufrU6GtRUpt10oQU7vQKy66LlKyvKGrq9SdG0wnEbp0BXtjPz6h0EMswjA5
	Qjjsq9ihYBsE+/+XNXtzPS2mePyhuP1d3Zm9x29Tuq40OZodziu8wf9FdixV/pLT
	TR3CSkdaLQD/mFxW8Amy1XDA+YCsiUA6vUvF7A114un233ZmMzd9L/Uo2CDUz65U
	yxRMS/hdHWUxa5Jdqg/+gycRxvAvKHdewsRVFfrW4aIvM5vhLtSHD9W1kp13lZet
	FO434cxv7QR8VUsEmPsiIO/xL4SeL1tXsbZbZ0lAnyAeFfopNOjizNTZPSh/MtJQ
	SHS6F9dCQxhSykAEnGEDOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758820113; x=
	1758906513; bh=2ALSPSD7bN7Ts+3/d+82SNIugoi83JaCku/JU611PR4=; b=h
	oN4kyGs/9UBOecB11YlbzKexYSRCxUuBSrunjghvlaf8TY76slGboKxcy9diFwn9
	9b9qsd45qK6EWyppw8YaUvZisoBygWQCu2rWJkYU7qANf8d4ljljsN13nZGviE/x
	UeYSf5W1haqK3sU2dBVVChGcC3Wm43n17nplPL0+CK0h8LHOuawn6FzGnyouyiiw
	yjOdrZEoKWwp2vqeOY3ulYb6QdWg/eiQuZcknDXaUAWv4G8yWKA4feXBXYNYuTra
	Sbm33c34eYjI+kF4p1oapz6LryIO4e/qge4JbEHKFbNC1OXlTXIYA2bvm18SpMgp
	1iSGNR0hYwKV42wmh9rqg==
X-ME-Sender: <xms:EXfVaGT7PYxHEw0LqUD8WA-4y29S2QYwlQogrVg2MyTPEw665yFwv3M>
    <xme:EXfVaCyinkGnCpGgUk9RdhMBN_KYYdmE0sanTuWIRKDN2Beei7yV5rN5vYZ2BHyYO
    4tfUwYm8rgoNPqNpeBAq86ZihmvPeFdLMQvH-_u_PvZvoerhZvj_A>
X-ME-Received: <xmr:EXfVaI2iuIwkC5dPeAKsJV1gIzuAYqFgQySGLEaXflMKDHl0eYbm5PYdfeHzpF29Ih5tLEuCVxewg_groQ5MDK0ioQNBXfhg2UrXCpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekgidtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepffevffdtudefueefudeiheetieelvedtueeffeefgfffffdutdegffeihfelvdfg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehlihhurd
    guvghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:EXfVaA7yw8UkS1gzsDmeWvPEU1aXXr28hzW_prOd76_PJe6LjKA-dg>
    <xmx:EXfVaLXZDzb-zYWUYpl1pY4wT0BRwa4YGoagRAeE7cTkHX_HwdlZ4w>
    <xmx:EXfVaPCdyjm1Vq58d0mxbSH7ceOHLQHp4sUxx7Wa-5-C8VEzSL8MNA>
    <xmx:EXfVaK7yVeY_u_7SdiDIoAaG3KpBGBZblojaMIzMnDlFLnL85QL71Q>
    <xmx:EXfVaAWb3pKTsN4vllavDDK1-ltNgQCSz6c4XqurY8hv-8lJjCyHnHve>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 13:08:32 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] range-diff: rename other_arg to log_arg
Date: Thu, 25 Sep 2025 19:07:34 +0200
Message-ID: <bd037df14f5.1758819879.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.311.g9b2318464ce
In-Reply-To: <v2-cover.1758819879.git.code@khaugsbakk.name>
References: <cover.1758574974.git.code@khaugsbakk.name> <v2-cover.1758819879.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Rename `other_arg` to `log_arg` in `range_diff_options` and
related places.

“Other argument” comes from bd361918 (range-diff: pass through --notes
to `git log`, 2019-11-20) which introduced Git notes handling to
git-range-diff(1) by passing that option on to git-log(1). And that kind
of name might be fine in a local context. However, it was initially
spread among multiple files, and is now[1] part of the
`range_diff_options` struct. It is, prima facie, difficult to guess what
“other” means, especially when just looking at the struct.

But with a little reading we find out that it is used for `--[no-]notes`
and `--diff-merges`, which are both passed on to git-log(1). We should
just rename it to reflect this role; `log_arg` suggests, along with the
`strvec` type, that it is used to pass extra arguments to git-log(1).

† 1: since f1ce6c19 (range-diff: combine all options in a single data
     structure, 2021-02-05)

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2 (new):
    
    Add a preliminary commit after discussing the `other_arg` name with
    Junio.
    
      “ Back when it was a random one-shot variable in range-diff, it might
        not have mattered all that much, but now we have it as a proper
        member of the struct, can we give it a name better than 'other_arg"?
    
    Link: https://lore.kernel.org/git/xmqqikharvyl.fsf@gitster.g/
    
    Later:
    
      “ My personal preference is to name arrays singular so that you can
        name its 0th element by saying dog[0], not dogs[0].  "dog[1] and
        dog[2] are friends" not dogs[1] and dogs[2].  An exception is when
        most of the time you use the array as a single unit as a collection,
        passing it around in the call chain, rarely addressing each individual
        element.  I am OK to see such an array called plural (but of course,
        singular names are always fine)..
    
    And I chose singular to personal preference in this context (the use
    etc. for this kind of variable).

 builtin/log.c        |  8 ++++----
 builtin/range-diff.c | 16 ++++++++--------
 range-diff.c         | 10 +++++-----
 range-diff.h         |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5f552d14c0f..131512ac1af 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1400,13 +1400,13 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		 * can be added later if deemed desirable.
 		 */
 		struct diff_options opts;
-		struct strvec other_arg = STRVEC_INIT;
+		struct strvec log_arg = STRVEC_INIT;
 		struct range_diff_options range_diff_opts = {
 			.creation_factor = rev->creation_factor,
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
-			.other_arg = &other_arg
+			.log_arg = &log_arg
 		};
 
 		repo_diff_setup(the_repository, &opts);
@@ -1414,9 +1414,9 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		opts.use_color = rev->diffopt.use_color;
 		diff_setup_done(&opts);
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
-		get_notes_args(&other_arg, rev);
+		get_notes_args(&log_arg, rev);
 		show_range_diff(rev->rdiff1, rev->rdiff2, &range_diff_opts);
-		strvec_clear(&other_arg);
+		strvec_clear(&log_arg);
 	}
 }
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index aafcc99b962..f88b40e3607 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -37,13 +37,13 @@ int cmd_range_diff(int argc,
 		   struct repository *repo UNUSED)
 {
 	struct diff_options diffopt = { NULL };
-	struct strvec other_arg = STRVEC_INIT;
+	struct strvec log_arg = STRVEC_INIT;
 	struct strvec diff_merges_arg = STRVEC_INIT;
 	struct range_diff_options range_diff_opts = {
 		.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT,
 		.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 		.diffopt = &diffopt,
-		.other_arg = &other_arg
+		.log_arg = &log_arg
 	};
 	int simple_color = -1, left_only = 0, right_only = 0;
 	struct option range_diff_options[] = {
@@ -52,7 +52,7 @@ int cmd_range_diff(int argc,
 			    N_("percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
-		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
+		OPT_PASSTHRU_ARGV(0, "notes", &log_arg,
 				  N_("notes"), N_("passed to 'git log'"),
 				  PARSE_OPT_OPTARG),
 		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
@@ -92,7 +92,7 @@ int cmd_range_diff(int argc,
 	/* If `--diff-merges` was specified, imply `--merges` */
 	if (diff_merges_arg.nr) {
 		range_diff_opts.include_merges = 1;
-		strvec_pushv(&other_arg, diff_merges_arg.v);
+		strvec_pushv(&log_arg, diff_merges_arg.v);
 	}
 
 	for (i = 0; i < argc; i++)
@@ -124,7 +124,7 @@ int cmd_range_diff(int argc,
 		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
 		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
 
-		strvec_pushv(&other_arg, argv +
+		strvec_pushv(&log_arg, argv +
 			     (dash_dash < 0 ? 3 : dash_dash));
 	} else if (dash_dash == 2 ||
 		   (dash_dash < 0 && argc > 1 &&
@@ -144,7 +144,7 @@ int cmd_range_diff(int argc,
 		strbuf_addstr(&range1, argv[0]);
 		strbuf_addstr(&range2, argv[1]);
 
-		strvec_pushv(&other_arg, argv +
+		strvec_pushv(&log_arg, argv +
 			     (dash_dash < 0 ? 2 : dash_dash));
 	} else if (dash_dash == 1 ||
 		   (dash_dash < 0 && argc > 0 &&
@@ -175,7 +175,7 @@ int cmd_range_diff(int argc,
 		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
 		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
 
-		strvec_pushv(&other_arg, argv +
+		strvec_pushv(&log_arg, argv +
 			     (dash_dash < 0 ? 1 : dash_dash));
 	} else
 		usage_msg_opt(_("need two commit ranges"),
@@ -187,7 +187,7 @@ int cmd_range_diff(int argc,
 	range_diff_opts.right_only = right_only;
 	res = show_range_diff(range1.buf, range2.buf, &range_diff_opts);
 
-	strvec_clear(&other_arg);
+	strvec_clear(&log_arg);
 	strvec_clear(&diff_merges_arg);
 	strbuf_release(&range1);
 	strbuf_release(&range2);
diff --git a/range-diff.c b/range-diff.c
index ca449a07693..57edff40a85 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -39,7 +39,7 @@ struct patch_util {
  * as struct object_id (will need to be free()d).
  */
 static int read_patches(const char *range, struct string_list *list,
-			const struct strvec *other_arg,
+			const struct strvec *log_arg,
 			unsigned int include_merges)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -69,8 +69,8 @@ static int read_patches(const char *range, struct string_list *list,
 	if (!include_merges)
 		strvec_push(&cp.args, "--no-merges");
 	strvec_push(&cp.args, range);
-	if (other_arg)
-		strvec_pushv(&cp.args, other_arg->v);
+	if (log_arg)
+		strvec_pushv(&cp.args, log_arg->v);
 	cp.out = -1;
 	cp.no_stdin = 1;
 	cp.git_cmd = 1;
@@ -594,9 +594,9 @@ int show_range_diff(const char *range1, const char *range2,
 	if (range_diff_opts->left_only && range_diff_opts->right_only)
 		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
 
-	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg, include_merges))
+	if (!res && read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range1);
-	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg, include_merges))
+	if (!res && read_patches(range2, &branch2, range_diff_opts->log_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range2);
 
 	if (!res) {
diff --git a/range-diff.h b/range-diff.h
index 9d39818e349..9b70a80009e 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -23,7 +23,7 @@ struct range_diff_options {
 	unsigned include_merges:1;
 	size_t max_memory;
 	const struct diff_options *diffopt; /* may be NULL */
-	const struct strvec *other_arg; /* may be NULL */
+	const struct strvec *log_arg; /* may be NULL */
 };
 
 /*
-- 
2.51.0.311.g9b2318464ce

