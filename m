From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Sun, 17 Jan 2010 20:02:25 -0800
Message-ID: <7v3a24ukku.fsf@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
 <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
 <20100116011512.GA27082@coredump.intra.peff.net>
 <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
 <20100118015140.GB6831@coredump.intra.peff.net>
 <7v8wbwultw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 05:02:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWip8-0000DG-Ur
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 05:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab0ARECj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 23:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961Ab0ARECj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 23:02:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab0ARECi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 23:02:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F4FF91560;
	Sun, 17 Jan 2010 23:02:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pbEm1D+OOQUtPYeaNxN9SvXx+tk=; b=CYMImI
	ojIq1RpVPt3HSzzqfgPG2/UvdG5O+OgJ+VkTXvrt64Zmwr4nwdylSSXLTym7N+Z3
	HnazZyPiWI48sqcO63P1XmCfp0OaBhgd4CdE9SHejp/pP66A7+T9FZhQF5fLLIcf
	thsQdrdbreI4hf7GWlKeNfwRiND+OlE2ye0sI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x0/c23+Dt11Q1paJVF0s6OnWDsletPNa
	v9SlFmwC8ThtDYU8tQR+bemO4zcwLJnARyAqmNIqqXs+H/r/Na5xdw1a6HZW5rTv
	ASesaFCWsjdZhTGtILSK2IZzyMVr46KU9QosEfDL1xdFTYPSVNqi4MNaas9clra+
	291Q+W/DDqk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18C9D9155F;
	Sun, 17 Jan 2010 23:02:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B95B9155E; Sun, 17 Jan
 2010 23:02:26 -0500 (EST)
In-Reply-To: <7v8wbwultw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 17 Jan 2010 19\:35\:23 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4D6CB840-03E6-11DF-A886-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137367>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Agreed. That is the most common log grep pattern for me (author + grep),
>> and I always want all-match. I see from later in the thread, though,
>> that implementing it is not as straightforward as we might hope.
>
> I haven't looked at the codepath for quite some time but I have a feeling
> that it probably won't be too bad.
>
> It just won't be as simple as flipping the all_match bit with a one-liner.

Perhaps something like this.

-- >8 --
Subject: "log --author=me --grep=it" should find intersection, not union

Historically, any grep filter in "git log" family of commands were taken
as restricting to commits with any of the words in the commit log message.
However, the user almost always want to find commits "done by this person
on that topic".  With "--all-match" option, a series of grep patterns can
be turned into a requirement that all of them must produce a match, but
that makes it impossible to ask for "done by me, on either this or that"
with:

	log --author=me --grep=this --grep=that

because it will require both "this" and "that" to appear.

Change the "header" parser of grep library to treat the headers specially.
When parsing the above, behave as if it was specified like this on the
command line:

	--all-match --author=me '(' --grep=this --grep=that ')'

Even though the "log" command line parser doesn't give direct access to
the extended grep syntax to group terms with parentheses, this change will
cover the majority of the case the users would want.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-grep.c |    1 +
 grep.c         |   20 ++++++++++++++++++--
 grep.h         |    2 ++
 revision.c     |    1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 529461f..d57c4d9 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -820,6 +820,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	opt.relative = 1;
 	opt.pathname = 1;
 	opt.pattern_tail = &opt.pattern_list;
+	opt.header_tail = &opt.header_list;
 	opt.regflags = REG_NEWLINE;
 	opt.max_depth = -1;
 
diff --git a/grep.c b/grep.c
index bdadf2c..f51fa4a 100644
--- a/grep.c
+++ b/grep.c
@@ -11,8 +11,8 @@ void append_header_grep_pattern(struct grep_opt *opt, enum grep_header_field fie
 	p->no = 0;
 	p->token = GREP_PATTERN_HEAD;
 	p->field = field;
-	*opt->pattern_tail = p;
-	opt->pattern_tail = &p->next;
+	*opt->header_tail = p;
+	opt->header_tail = &p->next;
 	p->next = NULL;
 }
 
@@ -173,6 +173,22 @@ void compile_grep_patterns(struct grep_opt *opt)
 {
 	struct grep_pat *p;
 
+	if (opt->header_list && !opt->all_match) {
+		struct grep_pat *p = opt->pattern_list;
+		opt->pattern_list = opt->header_list;
+		opt->pattern_tail = opt->header_tail;
+		opt->header_list = NULL;
+		opt->header_tail = NULL;
+
+		append_grep_pattern(opt, "(", "internal", 0, GREP_OPEN_PAREN);
+		while (p) {
+			*opt->pattern_tail = p;
+			opt->pattern_tail = &p->next;
+			p = p->next;
+		}
+		append_grep_pattern(opt, ")", "internal", 0, GREP_CLOSE_PAREN);
+		opt->all_match = 1;
+	}
 	if (opt->all_match)
 		opt->extended = 1;
 
diff --git a/grep.h b/grep.h
index 75370f6..e39e514 100644
--- a/grep.h
+++ b/grep.h
@@ -59,6 +59,8 @@ struct grep_expr {
 struct grep_opt {
 	struct grep_pat *pattern_list;
 	struct grep_pat **pattern_tail;
+	struct grep_pat *header_list;
+	struct grep_pat **header_tail;
 	struct grep_expr *pattern_expression;
 	const char *prefix;
 	int prefix_length;
diff --git a/revision.c b/revision.c
index 25fa14d..18a3658 100644
--- a/revision.c
+++ b/revision.c
@@ -806,6 +806,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 
 	revs->grep_filter.status_only = 1;
 	revs->grep_filter.pattern_tail = &(revs->grep_filter.pattern_list);
+	revs->grep_filter.header_tail = &(revs->grep_filter.header_list);
 	revs->grep_filter.regflags = REG_NEWLINE;
 
 	diff_setup(&revs->diffopt);
