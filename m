Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509C2C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE90C20853
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ivrfZQ5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgKFUu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 15:50:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64052 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgKFUu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 15:50:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 993A3EB0E1;
        Fri,  6 Nov 2020 15:50:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ba0T8Rm99l6E1CFrRjJOQJW0Ro=; b=ivrfZQ
        5VbJJj+olLd7Z8twt+I8aa0cY/CHr2El4hDCcWfZYUczOkTULmGKCsLbdb96q9Qp
        UJX9POvpEAhCqfvDM+fv84npJUfs2H/ZsUzkbGZGZ5Qwle8PY/BM7f9XD0NPJybV
        lfNsKIaG/NdQMPR7KpyRy8sDrkNTMvjiTlmYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FQHPK0u3H4K6TMPBIVNGn7tH9JJ553Qh
        SVNfCOt+2DyppbD7Q+XdWyZzpfR+aiWC/qeTm/psDSdFOMBcOGad468LqFxxEmFz
        gth1H6dD7Zk2X6LJIErvULXLgIk89b+jswKpM3U3U4vEjEHdRiSdEcb8zI5fc8Vm
        ORdcJcisr7A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FEB1EB0E0;
        Fri,  6 Nov 2020 15:50:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8599CEB0DF;
        Fri,  6 Nov 2020 15:50:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Hu Keping <hukeping@huawei.com>, git@vger.kernel.org,
        zhengjunling@huawei.com, zhuangbiaowei@huawei.com,
        git@stormcloud9.net, rafa.almas@gmail.com, l.s.r@web.de
Subject: Re: [PATCH] Lengthening FORMAT_PATCH_NAME_MAX to 80
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
        <xmqqimajijwa.fsf@gitster.c.googlers.com>
Date:   Fri, 06 Nov 2020 12:50:47 -0800
In-Reply-To: <xmqqimajijwa.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 05 Nov 2020 13:16:53 -0800")
Message-ID: <xmqqwnyydxaw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C05CB78E-2071-11EB-8178-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> A devil's advocate thinks that we should shorten it (and rename it
> to format-patch-subject-prefix-length or something) instead.  That
> way, "ls" output can show more than one files on a single line even
> on a 80-column terminal.  The leading digits already guarantee the
> uniqueness anyway.
>
> I do not mind getting rid of the "FORMAT_PATCH_NAME_MAX" constant
> and replacing it with a variable that defaults to 64 and can be
> tweaked by a command line option and/or a configuration variable.
> It does not feel it is worth the effort to replace one hardcoded
> constant with another hardcoded constant.

So here is my lunch-time hack for the day.  Totally untested beyond
"it comiples and links".

A new configuration variable format.patchnamemax and a new command
line option --filename-max-length=<n> overrides the hardcoded
constant 64, which is the default.  A value that is unreasonably
small is corrected to a hardcoded floor value of 8.

No new tests added nor documentation updated.




 builtin/log.c | 21 ++++++++++++++-------
 log-tree.c    |  2 +-
 log-tree.h    |  1 -
 revision.h    |  1 +
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git c/builtin/log.c w/builtin/log.c
index 0a7ed4bef9..d938fba27e 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -37,6 +37,8 @@
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
+#define FORMAT_PATCH_NAME_MIN 8
+#define FORMAT_PATCH_NAME_MAX 64
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -50,6 +52,7 @@ static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
+static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX;
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
@@ -150,6 +153,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
+	rev->patch_name_max = fmt_patch_name_max;
 	rev->show_signature = default_show_signature;
 	rev->encode_email_headers = default_encode_email_headers;
 	rev->diffopt.flags.allow_textconv = 1;
@@ -454,6 +458,12 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
+	if (!strcmp(var, "format.patchnamemax")) {
+		fmt_patch_name_max = git_config_int(var, value);
+		if (fmt_patch_name_max < FORMAT_PATCH_NAME_MIN)
+			fmt_patch_name_max = FORMAT_PATCH_NAME_MIN;
+		return 0;
+	}
 	if (!strcmp(var, "format.encodeemailheaders")) {
 		default_encode_email_headers = git_config_bool(var, value);
 		return 0;
@@ -955,15 +965,9 @@ static int open_next_file(struct commit *commit, const char *subject,
 			 struct rev_info *rev, int quiet)
 {
 	struct strbuf filename = STRBUF_INIT;
-	int suffix_len = strlen(rev->patch_suffix) + 1;
 
 	if (output_directory) {
 		strbuf_addstr(&filename, output_directory);
-		if (filename.len >=
-		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len) {
-			strbuf_release(&filename);
-			return error(_("name of output directory is too long"));
-		}
 		strbuf_complete(&filename, '/');
 	}
 
@@ -1751,6 +1755,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("start numbering patches at <n> instead of 1")),
 		OPT_INTEGER('v', "reroll-count", &reroll_count,
 			    N_("mark the series as Nth re-roll")),
+		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
+			    N_("max length of output filename")),
 		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
 			    N_("Use [RFC PATCH] instead of [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback),
@@ -1822,6 +1828,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	init_display_notes(&notes_opt);
 	git_config(git_format_config, NULL);
 	repo_init_revisions(the_repository, &rev, prefix);
+	rev.subject_prefix = fmt_patch_subject_prefix;
 	rev.show_notes = show_notes;
 	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
 	rev.commit_format = CMIT_FMT_EMAIL;
@@ -1831,7 +1838,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
-	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
@@ -1935,6 +1941,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
 	rev.zero_commit = zero_commit;
+	rev.patch_name_max = fmt_patch_name_max;
 
 	if (!rev.diffopt.flags.text && !no_binary_diff)
 		rev.diffopt.flags.binary = 1;
diff --git c/log-tree.c w/log-tree.c
index 1927f917ce..fd0dde97ec 100644
--- c/log-tree.c
+++ w/log-tree.c
@@ -367,7 +367,7 @@ void fmt_output_subject(struct strbuf *filename,
 	const char *suffix = info->patch_suffix;
 	int nr = info->nr;
 	int start_len = filename->len;
-	int max_len = start_len + FORMAT_PATCH_NAME_MAX - (strlen(suffix) + 1);
+	int max_len = start_len + info->patch_name_max - (strlen(suffix) + 1);
 
 	if (0 < info->reroll_count)
 		strbuf_addf(filename, "v%d-", info->reroll_count);
diff --git c/log-tree.h w/log-tree.h
index 8fa79289ec..1e8c91dbf2 100644
--- c/log-tree.h
+++ w/log-tree.h
@@ -33,7 +33,6 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     int maybe_multipart);
 void load_ref_decorations(struct decoration_filter *filter, int flags);
 
-#define FORMAT_PATCH_NAME_MAX 64
 void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
 void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
 void fmt_output_email_subject(struct strbuf *, struct rev_info *);
diff --git c/revision.h w/revision.h
index f6bf860d19..086ff10280 100644
--- c/revision.h
+++ w/revision.h
@@ -238,6 +238,7 @@ struct rev_info {
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
+	int		patch_name_max;
 	int		no_inline;
 	int		show_log_size;
 	struct string_list *mailmap;
