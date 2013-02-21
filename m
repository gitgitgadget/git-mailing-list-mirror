From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] format-patch: --inline-single
Date: Thu, 21 Feb 2013 12:26:22 -0800
Message-ID: <7v4nh5v2fl.fsf_-_@alter.siamese.dyndns.org>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
 <20130220104720.GD7860@pacific.linksys.moosehall>
 <7vehg9v2xj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:27:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8cjP-0006RP-Aw
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab3BUU0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 15:26:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46736 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754666Ab3BUU00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 15:26:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A511BA53;
	Thu, 21 Feb 2013 15:26:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fCX6AGDeXmgSTaKuJbSYa7B4EbM=; b=RMmVeU
	PAxxFK08rLwAkidPMrk/kpJak/ep8Vdu+CseSBHGPKLn7Jj8kkTdHF8L2LBaYFbr
	hJ3IU70ZL2tWWcTeimPO1QajrveVHkCuTSWCEvJwszTAQbVg363NeWdjFCpBY5fj
	MTL5NE4FRnzkE3RPuo3oOXOvm2ZZUwugn3VvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=slCbfY4UnBKz/kwuQ0bpeJ+bUeAGGeJg
	YJMFURwSbWGE4EuD984dRnVzeCvKm1yAQVLb104lVwdcGbJ0hxCydVrDlxttMrYt
	VZcvR+DSNXwv1TVWSEJVaiOnSjkV6GiWpEOqguU2u8DAvGXG30uAl+KDhz3/tqY+
	u4W+kiqH9tU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E68BBA52;
	Thu, 21 Feb 2013 15:26:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61E4FBA4E; Thu, 21 Feb 2013
 15:26:24 -0500 (EST)
In-Reply-To: <7vehg9v2xj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Feb 2013 12:15:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F639A0F6-7C64-11E2-9AAB-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216794>

Some people may find it convenient to append a simple patch at the
bottom of a discussion e-mail separated by a "scissors" mark, ready
to be applied with "git am -c".  Introduce "--inline-single" option
to format-patch to do so.  A typical usage example might be to start
'F'ollow-up to a discussion, write your message, conclude with "a
patch to do so may look like this.", and 

    \C-u M-! git format-patch --inline-single -1 HEAD <ENTER>

if you are an Emacs user.  Users of other MUA's may want to consult
their manuals to find equivalent command to append output from an
external command to the message being composed.

It does not make any sense to use this mode when formatting multiple
patches, or to combine this with options such as --attach, --inline,
and --cover-letter, so some of such uses are forbidden.  There may
be more insane combination the check in this patch may not even
bother to reject.  Caveat emptor.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I did this as a lunch-time hack, but I'll leave it to interested
   readers as an exercise to find corner case "bugs", e.g. some
   insane combinations of options may not be diagnosed as usage
   errors, and to update the tests and documentation.

   Personally, "git format-patch --stdout -1 HEAD" with manual
   editing is more flexible, so I am not interested in spending
   cycles to polish this further myself.

   The preliminary patch 1/2 I sent earlier is worth doing, though.

 builtin/log.c | 32 ++++++++++++++++++++++++++++++++
 commit.h      |  1 +
 log-tree.c    |  7 ++++++-
 pretty.c      | 27 ++++++++++++++++++++++++++-
 revision.h    |  1 +
 5 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 30265d8..5ad0837 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1000,6 +1000,19 @@ static int inline_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int inline_single_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct rev_info *rev = (struct rev_info *)opt->value;
+	rev->mime_boundary = NULL;
+	rev->inline_single = 1;
+
+	/* defeat configured format.attach, format.thread, etc. */
+	free(default_attach);
+	default_attach = NULL;
+	thread = 0;
+	return 0;
+}
+
 static int header_callback(const struct option *opt, const char *arg, int unset)
 {
 	if (unset) {
@@ -1149,6 +1162,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		{ OPTION_CALLBACK, 0, "inline-single", &rev, NULL,
+		  N_("single patch appendable to the end of an e-mail body"),
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+		  inline_single_callback },
 		OPT_BOOLEAN(0, "quiet", &quiet,
 			    N_("don't print the patch filenames")),
 		OPT_END()
@@ -1185,6 +1202,17 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	/* Set defaults and check incompatible options */
+	if (rev.inline_single) {
+		use_stdout = 1;
+		if (cover_letter)
+			die(_("inline-single and cover-letter are incompatible."));
+		if (thread)
+			die(_("inline-single and thread are incompatible."));
+		if (output_directory)
+			die(_("inline-single and output-directory are incompatible."));
+	}
+
 	if (0 < reroll_count) {
 		struct strbuf sprefix = STRBUF_INIT;
 		strbuf_addf(&sprefix, "%s v%d",
@@ -1373,6 +1401,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list[nr - 1] = commit;
 	}
 	total = nr;
+
+	if (rev.inline_single && total != 1)
+		die(_("inline-single is only for a single commit"));
+
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
 	if (numbered)
diff --git a/commit.h b/commit.h
index 4138bb4..f3d9959 100644
--- a/commit.h
+++ b/commit.h
@@ -85,6 +85,7 @@ struct pretty_print_context {
 	int preserve_subject;
 	enum date_mode date_mode;
 	unsigned date_mode_explicit:1;
+	unsigned inline_single:1;
 	int need_8bit_cte;
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
diff --git a/log-tree.c b/log-tree.c
index 34ec20d..15c9749 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -358,7 +358,11 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		subject = "Subject: ";
 	}
 
-	printf("From %s Mon Sep 17 00:00:00 2001\n", name);
+	if (opt->inline_single)
+		printf("-- >8 --\n");
+	else
+		printf("From %s Mon Sep 17 00:00:00 2001\n", name);
+
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
 		printf("Message-Id: <%s>\n", opt->message_id);
@@ -683,6 +687,7 @@ void show_log(struct rev_info *opt)
 	ctx.fmt = opt->commit_format;
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
+	ctx.inline_single = opt->inline_single;
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index eae57ad..363b3d9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -383,6 +383,29 @@ static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 	strbuf_addstr(sb, "?=");
 }
 
+static int is_current_user(const struct pretty_print_context *pp,
+			   const char *email, size_t emaillen,
+			   const char *name, size_t namelen)
+{
+	const char *me = git_committer_info(0);
+	const char *myname, *mymail;
+	size_t mynamelen, mymaillen;
+	struct ident_split ident;
+
+	if (split_ident_line(&ident, me, strlen(me)))
+		return 0; /* play safe, as we do not know */
+	mymail = ident.mail_begin;
+	mymaillen = ident.mail_end - ident.mail_begin;
+	myname = ident.name_begin;
+	mynamelen = ident.name_end - ident.name_begin;
+	if (pp->mailmap)
+		map_user(pp->mailmap, &mymail, &mymaillen, &myname, &mynamelen);
+	return (mymaillen == emaillen &&
+		mynamelen == namelen &&
+		!memcmp(mymail, email, emaillen) &&
+		!memcmp(myname, name, namelen));
+}
+
 void pp_user_info(const struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
@@ -412,7 +435,6 @@ void pp_user_info(const struct pretty_print_context *pp,
 	if (split_ident_line(&ident, line, linelen))
 		return;
 
-
 	mailbuf = ident.mail_begin;
 	maillen = ident.mail_end - ident.mail_begin;
 	namebuf = ident.name_begin;
@@ -421,6 +443,9 @@ void pp_user_info(const struct pretty_print_context *pp,
 	if (pp->mailmap)
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 
+	if (pp->inline_single && is_current_user(pp, mailbuf, maillen, namebuf, namelen))
+		return;
+
 	strbuf_init(&mail, 0);
 	strbuf_init(&name, 0);
 
diff --git a/revision.h b/revision.h
index 90813dd..0c6d955 100644
--- a/revision.h
+++ b/revision.h
@@ -143,6 +143,7 @@ struct rev_info {
 	const char	*log_reencode;
 	const char	*subject_prefix;
 	int		disposition_attachment;
+	int		inline_single;
 	int		show_log_size;
 	struct string_list *mailmap;
 
-- 
1.8.2.rc0.129.gcce6fe7
