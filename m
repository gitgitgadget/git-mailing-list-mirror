From: Greg Price <price@MIT.EDU>
Subject: [PATCH 1/6] rebase -i: Add the "ref" command
Date: Fri, 9 Oct 2009 22:52:00 -0400
Message-ID: <186680ca6febeb231e9a4fb44cee1e6aff58db6c.1309133817.git.greg@quora.com>
References: <cover.1309133817.git.greg@quora.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 02:42:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QazuN-0006H7-Vh
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 02:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab1F0Afq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 20:35:46 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:62071 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755989Ab1F0Aei (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2011 20:34:38 -0400
X-AuditID: 12074422-b7b0eae000007f48-2c-4e07d018cb7b
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.52.32584.810D70E4; Sun, 26 Jun 2011 20:34:32 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p5R0YbxB027235;
	Sun, 26 Jun 2011 20:34:37 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5R0YaPe018996;
	Sun, 26 Jun 2011 20:34:36 -0400 (EDT)
In-Reply-To: <cover.1309133817.git.greg@quora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixG6nritxgd3PYM8DRYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSujbd5K5oLvYhUP3jSyNjAuEupi5OSQEDCR+PXq
	IBOELSZx4d56ti5GLg4hgX2MEnP7jrBDOBsYJWZs+AzlfGGUmPP2IAtIi5CAusTNtkOMELaO
	xJMr/6HiVhL3/n9jg7ANJZ4cvcMOYvMKhEice90LVM/BwSlgJPGyUQGm5P6FJrByNgEFiR/z
	1zGD2CICahIT2w6BjWQWEJdYN/c82BgWARWJ9euWgq0VFjCVmHDqIuMERsEFjAyrGGVTcqt0
	cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxgoPORWkH48+DSocYBTgYlXh4Hyaw+wmxJpYV
	V+YeYpTkYFIS5RU9DxTiS8pPqcxILM6ILyrNSS0+xCjBwawkwvsuDCjHm5JYWZValA+TkuZg
	URLnLfH+7yskkJ5YkpqdmlqQWgSTleHgUJLgDQIZKliUmp5akZaZU4KQZuLgBBnOAzQ8FKSG
	t7ggMbc4Mx0if4pRUUqcNxMkIQCSyCjNg+uFJYVXjOJArwjzeoJU8QATClz3K6DBTECD+y6z
	gQwuSURISTUwVlsL3Hx+7jU3281dXO46hr5Ti+/P8/B9Z1x2/eBTyaAnXRND7mRXRIdNuKV2
	4l6Q6bYeJQmGiJwtBwK3GUq8/fA0+2CZjeh9tSPHN1r5b0x9cvTGNw+Ok/Z2575Gc8qVpxw+
	zqyzlS/sy1ShS+0TGTfYtP5kkmT+rXvoGUPGn57nSuu07V4EKbEUZyQaajEXFScC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176338>

This is useful for, e.g., rewriting a branch that has ancestor
branches along the way.

Signed-off-by: Greg Price <price@mit.edu>
---
 Documentation/git-rebase.txt |    4 ++++
 git-rebase--interactive.sh   |   12 ++++++++++++
 git-rebase.sh                |   11 +++++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a075bc..74fda58 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -455,6 +455,10 @@ message for the folded commit is the concatenation of the commit
 messages of the first commit and of those with the "squash" command,
 but omits the commit messages of commits with the "fixup" command.
 
+If you want to update a ref to point to a rewritten commit, add a
+command "ref <refname>" after the "pick", "edit", or other command
+that produces the commit.
+
 'git rebase' will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
 and/or resolving conflicts you can continue with `git rebase --continue`.
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 65690af..cec9cab 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -418,6 +418,17 @@ do_next () {
 		warn
 		exit 0
 		;;
+	ref)
+		mark_action_done
+		refname=$sha1
+		sha1=$(git rev-parse --quiet --verify "$refname" \
+			|| echo "(null)")
+		if ! grep -Fq " $refname" "$state_dir"/oldrefs 2>/dev/null
+		then
+			echo "$sha1 $refname" >> "$state_dir"/oldrefs
+		fi
+		git update-ref $refname HEAD
+		;;
 	squash|s|fixup|f)
 		case "$command" in
 		squash|s)
@@ -801,6 +812,7 @@ cat >> "$todo" << EOF
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
 #  x, exec = run command (the rest of the line) using shell
+#  ref <refname> = update ref
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/git-rebase.sh b/git-rebase.sh
index d7855ea..1bfe6a8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -118,6 +118,8 @@ read_basic_state () {
 		strategy_opts="$(cat "$state_dir"/strategy_opts)"
 	test -f "$state_dir"/allow_rerere_autoupdate &&
 		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
+	test -f "$state_dir"/oldrefs &&
+		oldrefs="$(cat "$state_dir"/oldrefs)"
 }
 
 write_basic_state () {
@@ -332,6 +334,15 @@ skip)
 abort)
 	git rerere clear
 	read_basic_state
+	[ -n "$oldrefs" ] && echo "$oldrefs" | while read sha1 ref
+	do
+		if test "(null)" = $sha1
+		then
+			git update-ref -d "$ref"
+		else
+			git update-ref "$ref" $sha1
+		fi
+	done
 	case "$head_name" in
 	refs/*)
 		git symbolic-ref -m "rebase: aborting" HEAD $head_name ||
-- 
1.7.5.4
