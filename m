Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDF2C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 17:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349922AbiDAR0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiDAR0V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 13:26:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4F1186F90
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 10:24:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x34so3727313ede.8
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7gl6bcJy4uOU/aI1CxFf48kvbp4DeUD5uvzANgvyIg4=;
        b=nRmzW0XihPTQs/B05m5zJWxGReq7SPZqgRCW8TGCP4rSuxLpwOgQpf6MqUFWOjPdJd
         2S11gHCkzIRWm1jmKKYgwmEFsBM65i67QkB1Po6RiHbSIe0u3jiFuSuSryn1FeHNqa3E
         3r4W9LOYeuk+olTAnc09mwHZD9d4HOrTnmB+DxPUp4dqMGcD26+L3oN5twSF9BkEaKwO
         mxD3E3LgqPk50HcIl0WbCNydjAcyh4D5KdYrq4q+6mj5cyjNtR9BlfiKCMyS+EXb0B1/
         gLGNmL0nrewVxA4vEPJOOiKvmWbRIuXUvLvKSYQDcq705CPVcOCG7EgvmfYzQDsKUbpc
         /oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7gl6bcJy4uOU/aI1CxFf48kvbp4DeUD5uvzANgvyIg4=;
        b=XEXijQI8XupoxOgHg5pCLE906MbFEEyPau3P9/4Z3Kgd6b5lig+4tBVyMI+OLQiHAc
         YIx4wN9GeC+6q6k11LZJLeBJUspCWbXSLhe5hnuPDdVSPkDKoxXJtv3m7qr4Hw+MNjKa
         5KpFPWgNlANiwOGbhhfUfx4JO/4LnC6gQVptbVDxqvHR9pztUi5MGELIKM9sSIZFNfGe
         N5eAdaami98I0zpmOkrwJxBAsGff/4OY4Cajcp3jE4tbLDDBK/yZVWIgSIw9wJHlDTfJ
         ByG1IgsOCdY+ym8Bo+Zspit7PklSbLT8CUKsFVoU2vYdyi91pNQ3T//aZ+G9+PnRH/ir
         0vUA==
X-Gm-Message-State: AOAM5325rzpsAKzAAgIkughENy6IiY/Gil34oQEWfqvaRGkudbcRlfz8
        trexubBsBb2v2CaAAzURZ3/6LnJjp1s=
X-Google-Smtp-Source: ABdhPJzW8BNpIVmLTzNe9p77xCJn/Sgxdaaa1NaOGfNyXRrGDq1Eon8avTxvlvlpUMWcM7TjCsv6PQ==
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id c17-20020a05640227d100b004191b024a04mr21827916ede.218.1648833869468;
        Fri, 01 Apr 2022 10:24:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b006a625c583b9sm1240007ejd.155.2022.04.01.10.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 10:24:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naL0e-001GR5-79;
        Fri, 01 Apr 2022 19:24:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 04/27] format-patch: don't leak "extra_headers" or
 "ref_message_ids"
Date:   Fri, 01 Apr 2022 19:16:38 +0200
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-04.27-69f0aabe38f-20220331T005325Z-avarab@gmail.com>
 <851584aa-a31d-7446-4994-e641f298f0cd@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <851584aa-a31d-7446-4994-e641f298f0cd@gmail.com>
Message-ID: <220401.868rsoogxf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 01 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 31/03/2022 02:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix two memory leaks in "struct rev_info" by freeing that memory in
>> cmd_format_patch(). These two are unusual special-cases in being in
>> the "struct rev_info", but not being "owned" by the code in
>> revision.c. I.e. they're members of the struct so that this code in
>> "builtin/log.c" can pass information code in log-tree.c.
>
> I'm not sure that I necessarily agree that these are owned by
> builtin/log.c. For rev.extra_headers it is set in builtin/log.c but=20
> never used there which makes me think we are transferring ownership to
> struct rev_info. For ref_message_ids it is less clear cut but having
> it owned by struct rev_info and freeing it in release_revisions()
> would make things clearer I think. Having some members owned by struct=20
> rev_info but others allocated and freed by other code is confusing and
> is likely to lead to memory errors. I don't think struct rev_info is=20
> borrowing a reference to these items as they are being allocated for
> it's exclusive use.

This really isn't for the use of revision.[ch] at all, but just
something that's used as ad-hoc message passing between builtin/log.c
and log-tree.c. It just so happens that it's done by ferrying it via the
struct rev_info.

The below patch fails tests, it's just a quick (and obviously flawed)
search/replacement that I hacked up to get the removal of these from
revision.h to compile, which shows that it's just something between
log.c and log-tree.c, pretty much.

Anyway, while I'm 100% in agreement with you that this *should* be fixed
I'd really like to do the bare minimum to address leaks in this initial
iteration.

I.e. you're right that this relatively fragile, and I'm also concern
about catching memory errors.

But being able to run (most of) the format-patch tests tests as a result
of this more isolated leak will leave us much better position to
validate any subsequent larger fixes, such as (something like) the
below.

diff --git a/builtin/log.c b/builtin/log.c
index c211d66d1d0..dc1acd730d1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1192,7 +1192,8 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
-			      int quiet)
+			      int quiet, const char *extra_headers,
+			      struct string_list *ref_message_ids)
 {
 	const char *committer;
 	struct shortlog log;
@@ -1212,7 +1213,9 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev=
, quiet))
 		die(_("failed to create cover-letter file"));
=20
-	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte, 0);
+	log_write_email_headers(rev, head, pp.after_subject, ref_message_ids,
+				&need_8bit_cte, 0);
+	pp.after_subject =3D extra_headers;
=20
 	for (i =3D 0; !need_8bit_cte && i < nr; i++) {
 		const char *buf =3D get_commit_buffer(list[i], NULL);
@@ -1777,6 +1780,8 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	struct strbuf rdiff2 =3D STRBUF_INIT;
 	struct strbuf rdiff_title =3D STRBUF_INIT;
 	int creation_factor =3D -1;
+	char *extra_headers;
+	struct string_list *ref_message_ids;
=20
 	const struct option builtin_format_patch_options[] =3D {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1946,7 +1951,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 		strbuf_addch(&buf, '\n');
 	}
=20
-	rev.extra_headers =3D strbuf_detach(&buf, NULL);
+	extra_headers =3D strbuf_detach(&buf, NULL);
=20
 	if (from) {
 		if (split_ident_line(&rev.from_ident, from, strlen(from)))
@@ -2174,10 +2179,10 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	}
=20
 	if (in_reply_to || thread || cover_letter)
-		rev.ref_message_ids =3D xcalloc(1, sizeof(struct string_list));
+		ref_message_ids =3D xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
 		const char *msgid =3D clean_message_id(in_reply_to);
-		string_list_append(rev.ref_message_ids, msgid);
+		string_list_append(ref_message_ids, msgid);
 	}
 	rev.numbered_files =3D just_numbers;
 	rev.patch_suffix =3D fmt_patch_suffix;
@@ -2185,7 +2190,8 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, branch_name, quiet,
+				  extra_headers, ref_message_ids);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
@@ -2229,11 +2235,11 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 				 * --in-reply-to, if specified.
 				 */
 				if (thread =3D=3D THREAD_SHALLOW
-				    && rev.ref_message_ids->nr > 0
+				    && ref_message_ids->nr > 0
 				    && (!cover_letter || rev.nr > 1))
 					free(rev.message_id);
 				else
-					string_list_append(rev.ref_message_ids,
+					string_list_append(ref_message_ids,
 							   rev.message_id);
 			}
 			gen_message_id(&rev, oid_to_hex(&commit->object.oid));
diff --git a/log-tree.c b/log-tree.c
index 38e5cccc1a1..66170b75254 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -419,11 +419,11 @@ void fmt_output_email_subject(struct strbuf *sb, stru=
ct rev_info *opt)
 }
=20
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **extra_headers_p,
+			     const char *extra_headers,
+			     struct string_list *ref_message_ids,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart)
 {
-	const char *extra_headers =3D opt->extra_headers;
 	const char *name =3D oid_to_hex(opt->zero_commit ?
 				      null_oid() : &commit->object.oid);
=20
@@ -435,13 +435,13 @@ void log_write_email_headers(struct rev_info *opt, st=
ruct commit *commit,
 		fprintf(opt->diffopt.file, "Message-Id: <%s>\n", opt->message_id);
 		graph_show_oneline(opt->graph);
 	}
-	if (opt->ref_message_ids && opt->ref_message_ids->nr > 0) {
+	if (ref_message_ids && ref_message_ids->nr > 0) {
 		int i, n;
-		n =3D opt->ref_message_ids->nr;
-		fprintf(opt->diffopt.file, "In-Reply-To: <%s>\n", opt->ref_message_ids->=
items[n-1].string);
+		n =3D ref_message_ids->nr;
+		fprintf(opt->diffopt.file, "In-Reply-To: <%s>\n", ref_message_ids->items=
[n-1].string);
 		for (i =3D 0; i < n; i++)
 			fprintf(opt->diffopt.file, "%s<%s>\n", (i > 0 ? "\t" : "References: "),
-			       opt->ref_message_ids->items[i].string);
+			       ref_message_ids->items[i].string);
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary && maybe_multipart) {
@@ -488,7 +488,6 @@ void log_write_email_headers(struct rev_info *opt, stru=
ct commit *commit,
 		opt->diffopt.stat_sep =3D buffer.buf;
 		strbuf_release(&filename);
 	}
-	*extra_headers_p =3D extra_headers;
 }
=20
 static void show_sig_lines(struct rev_info *opt, int status, const char *b=
ol)
@@ -621,13 +620,12 @@ static void next_commentary_block(struct rev_info *op=
t, struct strbuf *sb)
 	opt->shown_dashes =3D 1;
 }
=20
-void show_log(struct rev_info *opt)
+void show_log_extra_headers(struct rev_info *opt, const char *extra_header=
s)
 {
 	struct strbuf msgbuf =3D STRBUF_INIT;
 	struct log_info *log =3D opt->loginfo;
 	struct commit *commit =3D log->commit, *parent =3D log->parent;
 	int abbrev_commit =3D opt->abbrev_commit ? opt->abbrev : the_hash_algo->h=
exsz;
-	const char *extra_headers =3D opt->extra_headers;
 	struct pretty_print_context ctx =3D {0};
=20
 	opt->loginfo =3D NULL;
@@ -687,7 +685,7 @@ void show_log(struct rev_info *opt)
 	 */
=20
 	if (cmit_fmt_is_mail(opt->commit_format)) {
-		log_write_email_headers(opt, commit, &extra_headers,
+		log_write_email_headers(opt, commit, extra_headers, NULL,
 					&ctx.need_8bit_cte, 1);
 		ctx.rev =3D opt;
 		ctx.print_email_subject =3D 1;
@@ -848,6 +846,11 @@ void show_log(struct rev_info *opt)
 	}
 }
=20
+void show_log(struct rev_info *opt)
+{
+	show_log_extra_headers(opt, NULL);
+}
+
 int log_tree_diff_flush(struct rev_info *opt)
 {
 	opt->shown_dashes =3D 0;
diff --git a/log-tree.h b/log-tree.h
index e7e4641cf83..32ae026f6fb 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -16,6 +16,7 @@ struct decoration_filter {
 int parse_decorate_color_config(const char *var, const char *slot_name, co=
nst char *value);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
+void show_log_extra_headers(struct rev_info *opt, const char *extra_header=
s);
 void show_log(struct rev_info *opt);
 void format_decorations_extended(struct strbuf *sb, const struct commit *c=
ommit,
 			     int use_color,
@@ -26,7 +27,8 @@ void format_decorations_extended(struct strbuf *sb, const=
 struct commit *commit,
 			     format_decorations_extended((strbuf), (commit), (color), " (", ", =
", ")")
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **extra_headers_p,
+			     const char *extra_headers,
+			     struct string_list *ref_message_ids,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart);
 void load_ref_decorations(struct decoration_filter *filter, int flags);
diff --git a/revision.h b/revision.h
index 5bc59c7bfe1..e2e08673bba 100644
--- a/revision.h
+++ b/revision.h
@@ -243,9 +243,7 @@ struct rev_info {
 	const char	*reroll_count;
 	char		*message_id;
 	struct ident_split from_ident;
-	struct string_list *ref_message_ids;
 	int		add_signoff;
-	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
 	int		patch_name_max;
