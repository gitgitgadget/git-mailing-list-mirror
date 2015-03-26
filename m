From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge: drop 'git merge <message> HEAD <commit>' syntax
Date: Wed, 25 Mar 2015 22:00:48 -0700
Message-ID: <xmqqr3scz727.fsf@gitster.dls.corp.google.com>
References: <xmqqvbhoz75m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 06:00:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YazuZ-0000cw-Vz
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 06:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbbCZFAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 01:00:51 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751673AbbCZFAv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 01:00:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 983ED44ADD;
	Thu, 26 Mar 2015 01:00:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mDfCKQKzgqLG+g0IWCojAO//rVo=; b=WzJO15
	Rw4d+XpSTkwp/8Z4exoh50KvYzROEhQe1zfvHIM/MIlyr63oEQZKXqhQgDq0+8AJ
	AkDTzNe8Z+7qH5uQwY25J6XhVM27+HQfr1NXtvZFQWBqS6Z1uLcM7mkvbmp0LStz
	KJpjhbLAC2LB0s6UluJDbe5JBF82TCbFB+Qxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PgSuXxbLi6AIjPYsn2OpfuPsqq7Xp4Zv
	VSqV6jEh3L6XW3S76A4ndU47D/eobrd//t1LPoc9tOrHTcC0MZhufb+dqj/7m5jl
	+ssnlolDSjQ5ApphI3oSI2lOAQkmYC8BfltNfhcdfkC8lyl6ht+qs6Q7UmYTKCpp
	jfUh/Ynbd7U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9144D44ADC;
	Thu, 26 Mar 2015 01:00:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C36144ADB;
	Thu, 26 Mar 2015 01:00:49 -0400 (EDT)
In-Reply-To: <xmqqvbhoz75m.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 25 Mar 2015 21:58:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 125C59FE-D375-11E4-8733-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266311>

And then if we and our users survived the previous "start warning if
the old syntax is used" patch for a few years, we could apply this
to actually drop the support for the ancient syntax.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-merge.txt |  7 +------
 builtin/merge.c             | 38 +-------------------------------------
 2 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 1f94908..4a2f519 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -12,7 +12,6 @@ SYNOPSIS
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[-s <strategy>] [-X <strategy-option>] [-S[<key-id>]]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
-'git merge' <msg> HEAD <commit>...
 'git merge' --abort
 
 DESCRIPTION
@@ -44,11 +43,7 @@ a log message from the user describing the changes.
     D---E---F---G---H master
 ------------
 
-The second syntax (<msg> `HEAD` <commit>...) is supported for
-historical reasons.  Do not use it from the command line or in
-new scripts.  It is the same as `git merge -m <msg> <commit>...`.
-
-The third syntax ("`git merge --abort`") can only be run after the
+The second syntax ("`git merge --abort`") can only be run after the
 merge has resulted in conflicts. 'git merge --abort' will abort the
 merge process and try to reconstruct the pre-merge state. However,
 if there were uncommitted changes when the merge started (and
diff --git a/builtin/merge.c b/builtin/merge.c
index 0795358..a4ddd31 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -43,7 +43,6 @@ struct strategy {
 
 static const char * const builtin_merge_usage[] = {
 	N_("git merge [<options>] [<commit>...]"),
-	N_("git merge [<options>] <msg> HEAD <commit>"),
 	N_("git merge --abort"),
 	NULL
 };
@@ -902,24 +901,6 @@ static int suggest_conflicts(void)
 	return 1;
 }
 
-static struct commit *is_old_style_invocation(int argc, const char **argv,
-					      const unsigned char *head)
-{
-	struct commit *second_token = NULL;
-	if (argc > 2) {
-		unsigned char second_sha1[20];
-
-		if (get_sha1(argv[1], second_sha1))
-			return NULL;
-		second_token = lookup_commit_reference_gently(second_sha1, 0);
-		if (!second_token)
-			die(_("'%s' is not a commit"), argv[1]);
-		if (hashcmp(second_token->object.sha1, head))
-			return NULL;
-	}
-	return second_token;
-}
-
 static int evaluate_result(void)
 {
 	int cnt = 0;
@@ -1171,24 +1152,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
 
-	/*
-	 * This could be traditional "merge <msg> HEAD <commit>..."  and
-	 * the way we can tell it is to see if the second token is HEAD,
-	 * but some people might have misused the interface and used a
-	 * commit-ish that is the same as HEAD there instead.
-	 * Traditional format never would have "-m" so it is an
-	 * additional safety measure to check for it.
-	 */
-
-	if (!have_message && head_commit &&
-	    is_old_style_invocation(argc, argv, head_commit->object.sha1)) {
-		warning("old-style 'git merge <msg> HEAD <commit>' is deprecated.");
-		strbuf_addstr(&merge_msg, argv[0]);
-		head_arg = argv[1];
-		argv += 2;
-		argc -= 2;
-		remoteheads = collect_parents(head_commit, &head_subsumed, argc, argv);
-	} else if (!head_commit) {
+	if (!head_commit) {
 		struct commit *remote_head;
 		/*
 		 * If the merged head is a valid one there is no reason
-- 
2.3.4-475-g3180e2e
