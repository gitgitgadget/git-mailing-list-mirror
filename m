From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Thu, 08 Sep 2011 14:17:24 -0700
Message-ID: <7vmxeewx7f.fsf@alter.siamese.dyndns.org>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net> <7vfwkodq5s.fsf@alter.siamese.dyndns.org> <4E5A5290.4050005@drmicha.warpmail.net> <20110907195611.GD13364@sigill.intra.peff.net> <4E6889DF.7030404@drmicha.warpmail.net> <7vr53qwxtz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:11:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nlD-0003FO-26
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab1IHXLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:11:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab1IHXLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:11:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4313455DE;
	Thu,  8 Sep 2011 17:17:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1RxVlJqrpfw08hKw+NgfBO7VBDY=; b=WF8ee3
	Nv+VxrxNXnmo0YXSuszGyEwb9Wfifg/vDB4DC/JFXT1N4JTBA+2Yo+qgq1ZknUMf
	EGECHH0UBiaEvqtPbbZHDvSQQMXc9L3jlvEEXmtyME5bTq4tbaIVUeiOeB3QyGKD
	rKs3ijq0ktHhsaK1rSDmS6NHJup7f5V1tjSD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xSIA/163mZ90+AD0xvGKSwxKY5R8zkOT
	6gK+igyLvYczFdNGyEO+rLrbNOaZl2R+E1mMoED/8BpwkrcTRTOyl4agDkD4AfLA
	dHsLOj+Yvhbtw+hgbIkKTgmC8kAUR/xZyonfXroPBQS2nilZwWNThQJEox8JXDzb
	R+8x0JVoInI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A70355DC;
	Thu,  8 Sep 2011 17:17:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FECB55DA; Thu,  8 Sep 2011
 17:17:25 -0400 (EDT)
In-Reply-To: <7vr53qwxtz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 08 Sep 2011 14:03:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F31391FA-DA5F-11E0-9490-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181000>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> Jeff King venit, vidit, dixit 07.09.2011 21:56:
>> ...
>>> It does make me a little nervous about the "'git branch -v'
>>> automatically means 'git branch --list -v'" patch, though. It closes the
>>> door in the future to us being more or less verbose about branch
>>> creation details (and while helpful, it creates a slight inconsistency
>>> in the interface).
>
> Hasn't 'git branch -v' meant listing in verbose mode for a long enough
> time that changing it now would mean a moderately major regression?
>
> At least my copy of v1.7.0 seems to list with "git branch -v".

Ah, nevermind.

As the series is already in 'next', here is what I came up with.

-- >8 --
From: Michael J Gruber <git@drmicha.warpmail.net>
Date: Thu, 8 Sep 2011 14:09:50 -0700
Subject: [PATCH] branch: -v does not automatically imply --list

"branch -v" without other options or parameters still works in the list
mode, but that is not because there is "-v" but because there is no
parameter nor option.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt |    6 +++---
 builtin/branch.c             |    3 +--
 t/t3203-branch-output.sh     |    8 ++++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 2b8bc84..f46013c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -21,7 +21,7 @@ DESCRIPTION
 With no arguments, existing branches are listed and the current branch will
 be highlighted with an asterisk.  Option `-r` causes the remote-tracking
 branches to be listed, and option `-a` shows both. This list mode is also
-activated by the `--list` and `-v` options (see below).
+activated by the `--list` option (see below).
 <pattern> restricts the output to matching branches, the pattern is a shell
 wildcard (i.e., matched using fnmatch(3))
 Multiple patterns may be given; if any of them matches, the tag is shown.
@@ -120,10 +120,10 @@ OPTIONS
 
 -v::
 --verbose::
-	Show sha1 and commit subject line for each head, along with
+	When in list mode,
+	show sha1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
 	the name of the upstream branch, as well.
-	`--list` is implied by all verbosity options.
 
 --abbrev=<length>::
 	Alter the sha1's minimum display length in the output listing.
diff --git a/builtin/branch.c b/builtin/branch.c
index 98a420f..099c75c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -712,8 +712,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !force_create &&
-	    (argc == 0 || (verbose && argc)))
+	if (!delete && !rename && !force_create && argc == 0)
 		list = 1;
 
 	if (!!delete + !!rename + !!force_create + !!list > 1)
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index f2b294b..76fe7e0 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -84,12 +84,16 @@ cat >expect <<'EOF'
 two
 one
 EOF
-test_expect_success 'git branch -v pattern shows branch summaries' '
-	git branch -v branch* >tmp &&
+test_expect_success 'git branch --list -v pattern shows branch summaries' '
+	git branch --list -v branch* >tmp &&
 	awk "{print \$NF}" <tmp >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch -v pattern does not show branch summaries' '
+	test_must_fail git branch -v branch*
+'
+
 cat >expect <<'EOF'
 * (no branch)
   branch-one
-- 
1.7.7.rc0.188.g3793ac
