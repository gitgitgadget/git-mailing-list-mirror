From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Fri, 21 Jan 2011 14:02:55 -0800
Message-ID: <7vtyh1oqy8.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino> <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino>
 <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
 <20110119193116.GB30618@burratino> <7vpqrssl5d.fsf@alter.siamese.dyndns.org>
 <7v39omotxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Maaartin <grajcar1@seznam.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 23:03:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgP4g-0001o2-0D
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 23:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab1AUWDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 17:03:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab1AUWDK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 17:03:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B2842DF9;
	Fri, 21 Jan 2011 17:03:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ThbfbHZnPbddtahGEni6Q0zF7oE=; b=a8fOM+
	Ps7EjYkL2SkRyCp07fhVZqrfCy1gyDi1Z5LA71enAjxksz06tZWI5x2HoQDt/3Rx
	7rd7PsbcPFfbnjilFSnPP7M90sJ72RX+7cejVkGletHkspzV/6PKBDtpkyXT8YJd
	ToE3OLSJSRZWSEbUyE6S65lHV6yC96CgY6OR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XVbxBG6njTBCpmYIz756KcTqGIIBXeB4
	Sp6oCVvhJyR8TDsAdXj/IRvaGmKo38c+eXqynyZRjrvl1rfdYRo3LE8uP+lCNJkE
	JllRM2cluAcWtgGpxqWdIdYOOo8PLLSQWYQcis4UX9Czsu8/H672+62DRrfGndSg
	8502kfN6hXo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 056292DF8;
	Fri, 21 Jan 2011 17:03:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E0922DF6; Fri, 21 Jan 2011
 17:03:43 -0500 (EST)
In-Reply-To: <7v39omotxg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 21 Jan 2011 12\:58\:35 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53B01A3A-25AA-11E0-BEF8-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165396>

Junio C Hamano <gitster@pobox.com> writes:

> I was re-reading this thread, and changed my mind; I think we should have
> this series to avoid unnecessary regression, with or without clarifying
> (5), before 1.7.4 final.
>
> Even if some scripts you had trouble with started using GIT_WORK_TREE
> without specifying GIT_DIR because they misunderstood what these are
> designed to do, as long as the combination has been working consistently
> with the expectation of these scripts, ans as long as we can keep the same
> behaviour, I don't see a reason to change it.

... and that leads me to suggest that we may not even want to issue a
warning in these cases.

Perhaps squash this into, or apply on top of, your 3/3?

-- >8 --
Subject: setup: officially support --work-tree without --git-dir

The original intention of --work-tree was to allow people to work in a
subdirectory of their working tree that does not have an embedded .git
directory.  Because their working tree, which their $cwd was in, did not
have an embedded .git, they needed to use $GIT_DIR to specify where it is,
and because this meant there was no way to discover where the root level
of the working tree was, so we needed to add $GIT_WORK_TREE to tell git
where it was.

However, this facility has long been (mis)used by people's scripts to
start git from a working tree _with_ an embedded .git directory, let git
find .git directory, and then pretend as if an unrelated directory were
the associated working tree of the .git directory found by the discovery
process.  It happens to work in simple cases, and is not worth causing
"regression" to these scripts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c               |    8 +-----
 t/t1510-repo-setup.sh |   59 +++++++++++++++++++++++++-----------------------
 2 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/setup.c b/setup.c
index e08cdf2..dadc666 100644
--- a/setup.c
+++ b/setup.c
@@ -411,9 +411,8 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	if (check_repository_format_gently(gitdir, nongit_ok))
 		return NULL;
 
-	/* Accept --work-tree to support old scripts that played with fire. */
+	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
-		warning("pretending GIT_DIR was supplied alongside GIT_WORK_TREE");
 		if (offset != len && !is_absolute_path(gitdir))
 			gitdir = xstrdup(make_absolute_path(gitdir));
 		if (chdir(cwd))
@@ -453,13 +452,10 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
 	if (check_repository_format_gently(".", nongit_ok))
 		return NULL;
 
-	/*
-	 * Accept --work-tree, reluctantly.
-	 */
+	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		const char *gitdir;
 
-		warning("pretending GIT_DIR was supplied alongside GIT_WORK_TREE");
 		gitdir = offset == len ? "." : xmemdupz(cwd, offset);
 		if (chdir(cwd))
 			die_errno("Could not come back to cwd");
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index b8a1b02..dcc0f86 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -16,9 +16,12 @@ A few rules for repo setup:
 4. GIT_WORK_TREE is relative to user's cwd. --work-tree is
    equivalent to GIT_WORK_TREE.
 
-5. GIT_WORK_TREE/core.worktree is only meant to work if GIT_DIR is set.
-   Otherwise there is a warning and a best effort is made to follow
-   historical behavior.
+5. GIT_WORK_TREE/core.worktree was originally meant to work only if
+   GIT_DIR is set, but earlier git didn't enforce it, and some scripts
+   depend on the implementation that happened to first discover .git by
+   going up from the users $cwd and then using the specified working tree
+   that may or may not have any relation to where .git was found in.  This
+   historical behaviour must be kept.
 
 6. Effective GIT_WORK_TREE overrides core.worktree and core.bare
 
@@ -225,16 +228,16 @@ try_repo () {
 test_expect_success '#0: nonbare repo, no explicit configuration' '
 	try_repo 0 unset unset unset "" unset \
 		.git "$here/0" "$here/0" "(null)" \
-		.git "$here/0" "$here/0" sub/ 2>messages &&
-	! grep "warning:.*GIT_DIR.*GIT_WORK_TREE" messages
+		.git "$here/0" "$here/0" sub/ 2>message &&
+	! test -s message
 '
 
-test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is reluctantly accepted' '
+test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is accepted' '
 	mkdir -p wt &&
 	try_repo 1 "$here" unset unset "" unset \
 		"$here/1/.git" "$here" "$here" 1/ \
 		"$here/1/.git" "$here" "$here" 1/sub/ 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 
 test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
@@ -255,16 +258,16 @@ test_expect_success '#3: setup' '
 '
 run_wt_tests 3
 
-test_expect_success '#4: core.worktree without GIT_DIR set is reluctantly accepted' '
+test_expect_success '#4: core.worktree without GIT_DIR set is accepted' '
 	setup_repo 4 ../sub "" unset &&
 	mkdir -p 4/sub sub &&
 	try_case 4 unset unset \
 		.git "$here/4/sub" "$here/4" "(null)" \
 		"$here/4/.git" "$here/4/sub" "$here/4/sub" "(null)" 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 
-test_expect_success '#5: core.worktree + GIT_WORK_TREE is reluctantly accepted' '
+test_expect_success '#5: core.worktree + GIT_WORK_TREE is accepted' '
 	# or: you cannot intimidate away the lack of GIT_DIR setting
 	try_repo 5 "$here" unset "$here/5" "" unset \
 		"$here/5/.git" "$here" "$here" 5/ \
@@ -272,7 +275,7 @@ test_expect_success '#5: core.worktree + GIT_WORK_TREE is reluctantly accepted'
 	try_repo 5a .. unset "$here/5a" "" unset \
 		"$here/5a/.git" "$here" "$here" 5a/ \
 		"$here/5a/.git" "$here/5a" "$here/5a" sub/ &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 
 test_expect_success '#6: setting GIT_DIR brings core.worktree to life' '
@@ -364,12 +367,12 @@ test_expect_success '#8: gitfile, easy case' '
 		"$here/8.git" "$here/8" "$here/8" sub/
 '
 
-test_expect_success '#9: GIT_WORK_TREE reluctantly accepted with gitfile' '
+test_expect_success '#9: GIT_WORK_TREE accepted with gitfile' '
 	mkdir -p 9/wt &&
 	try_repo 9 wt unset unset gitfile unset \
 		"$here/9.git" "$here/9/wt" "$here/9" "(null)" \
 		"$here/9.git" "$here/9/sub/wt" "$here/9/sub" "(null)" 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 
 test_expect_success '#10: GIT_DIR can point to gitfile' '
@@ -391,19 +394,19 @@ test_expect_success '#11: setup' '
 '
 run_wt_tests 11 gitfile
 
-test_expect_success '#12: core.worktree with gitfile is reluctantly accepted' '
+test_expect_success '#12: core.worktree with gitfile is accepted' '
 	try_repo 12 unset unset "$here/12" gitfile unset \
 		"$here/12.git" "$here/12" "$here/12" "(null)" \
 		"$here/12.git" "$here/12" "$here/12" sub/ 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 
-test_expect_success '#13: core.worktree+GIT_WORK_TREE relucantly accepted (with gitfile)' '
+test_expect_success '#13: core.worktree+GIT_WORK_TREE accepted (with gitfile)' '
 	# or: you cannot intimidate away the lack of GIT_DIR setting
 	try_repo 13 non-existent-too unset non-existent gitfile unset \
 		"$here/13.git" "$here/13/non-existent-too" "$here/13" "(null)" \
 		"$here/13.git" "$here/13/sub/non-existent-too" "$here/13/sub" "(null)" 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 
 # case #14.
@@ -514,7 +517,7 @@ test_expect_success '#16c: bare .git has no worktree' '
 		"$here/16c/.git" "(null)" "$here/16c/sub" "(null)"
 '
 
-test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is reluctantly accepted (bare case)' '
+test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (bare case)' '
 	# Just like #16.
 	setup_repo 17a unset "" true &&
 	setup_repo 17b unset "" true &&
@@ -539,7 +542,7 @@ test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is reluctantly
 	try_repo 17c "$here/17c" unset unset "" true \
 		.git "$here/17c" "$here/17c" "(null)" \
 		"$here/17c/.git" "$here/17c" "$here/17c" sub/ 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 
 test_expect_success '#18: bare .git named by GIT_DIR has no worktree' '
@@ -558,7 +561,7 @@ test_expect_success '#19: setup' '
 '
 run_wt_tests 19
 
-test_expect_success '#20a: core.worktree without GIT_DIR reluctantly accepted (inside .git)' '
+test_expect_success '#20a: core.worktree without GIT_DIR accepted (inside .git)' '
 	# Unlike case #16a.
 	setup_repo 20a "$here/20a" "" unset &&
 	mkdir -p 20a/.git/wt/sub &&
@@ -568,7 +571,7 @@ test_expect_success '#20a: core.worktree without GIT_DIR reluctantly accepted (i
 		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/ &&
 	try_case 20a/.git/wt/sub unset unset \
 		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/sub/ &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 
 test_expect_success '#20b/c: core.worktree and core.bare conflict' '
@@ -581,7 +584,7 @@ test_expect_success '#20b/c: core.worktree and core.bare conflict' '
 	grep "core.bare and core.worktree" message
 '
 
-# Case #21: core.worktree/GIT_WORK_TREE reluctantly overrides core.bare' '
+# Case #21: core.worktree/GIT_WORK_TREE overrides core.bare' '
 test_expect_success '#21: setup, core.worktree warns before overriding core.bare' '
 	setup_repo 21 non-existent "" unset &&
 	mkdir -p 21/.git/wt/sub &&
@@ -591,7 +594,7 @@ test_expect_success '#21: setup, core.worktree warns before overriding core.bare
 		export GIT_WORK_TREE &&
 		git symbolic-ref HEAD >/dev/null
 	) 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 
 '
 run_wt_tests 21
@@ -703,11 +706,11 @@ test_expect_success '#24: bare repo has no worktree (gitfile case)' '
 		"$here/24.git" "(null)" "$here/24/sub" "(null)"
 '
 
-test_expect_success '#25: GIT_WORK_TREE accepted reluctantly if GIT_DIR unset (bare gitfile case)' '
+test_expect_success '#25: GIT_WORK_TREE accepted if GIT_DIR unset (bare gitfile case)' '
 	try_repo 25 "$here/25" unset unset gitfile true \
 		"$here/25.git" "$here/25" "$here/25" "(null)"  \
 		"$here/25.git" "$here/25" "$here/25" "sub/" 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 
 test_expect_success '#26: bare repo has no worktree (GIT_DIR -> gitfile case)' '
@@ -732,11 +735,11 @@ test_expect_success '#28: core.worktree and core.bare conflict (gitfile case)' '
 		cd 28 &&
 		test_must_fail git symbolic-ref HEAD
 	) 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message &&
+	! grep "^warning:" message &&
 	grep "core.bare and core.worktree" message
 '
 
-# Case #29: GIT_WORK_TREE(+core.worktree) reluctantly overries core.bare (gitfile case).
+# Case #29: GIT_WORK_TREE(+core.worktree) overries core.bare (gitfile case).
 test_expect_success '#29: setup' '
 	setup_repo 29 non-existent gitfile true &&
 	mkdir -p 29/sub/sub 29/wt/sub
@@ -746,7 +749,7 @@ test_expect_success '#29: setup' '
 		export GIT_WORK_TREE &&
 		git symbolic-ref HEAD >/dev/null
 	) 2>message &&
-	grep "warning:.*GIT_DIR.*GIT_WORK_TREE" message
+	! test -s message
 '
 run_wt_tests 29 gitfile
 
