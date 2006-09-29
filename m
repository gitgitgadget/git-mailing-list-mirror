From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 3/5] fetch & co: Use short sha1 in the output
Date: Fri, 29 Sep 2006 20:06:40 +0200
Message-ID: <87ejtu1r9r.fsf@gmail.com>
References: <87r6xu1rci.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 29 20:06:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTMl4-0003kI-Rs
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 20:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161319AbWI2SGo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Sep 2006 14:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWI2SGo
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 14:06:44 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:5288 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751302AbWI2SGn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 14:06:43 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8TI6eQ03920
	for <git@vger.kernel.org>; Fri, 29 Sep 2006 20:06:41 +0200
To: git <git@vger.kernel.org>
In-Reply-To: <87r6xu1rci.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 29 Sep
	2006 20:05:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28120>


=2E.. for brevity.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-fetch.sh   |    6 +++---
 git-merge.sh   |    2 +-
 git-resolve.sh |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 08d86cd..32553f8 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -129,11 +129,11 @@ append_fetch_head () {
     then
 	headc_=3D$(git-rev-parse --verify "$head_^0") || exit
 	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	[ "$verbose" ] && echo >&2 "* committish: $head_"
+	[ "$verbose" ] && echo >&2 "* committish: $(git-rev-parse --short $he=
ad_)"
 	[ "$verbose" ] && echo >&2 "  $note_"
     else
 	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
-	[ "$verbose" ] && echo >&2 "* non-commit: $head_"
+	[ "$verbose" ] && echo >&2 "* non-commit: $(git-rev-parse --short $he=
ad_)"
 	[ "$verbose" ] && echo >&2 "  $note_"
     fi
     if test "$local_name_" !=3D ""
@@ -182,7 +182,7 @@ fast_forward_local () {
 		;;
 	    *,$local)
 		echo >&2 "* $1: fast forward to $3"
-		echo >&2 "  $local..$2"
+		echo >&2 "  $(git-rev-parse --short $local)..$(git-rev-parse --short=
 $2)"
 		git-update-ref -m "$rloga: fast-forward" "$1" "$2" "$local"
 		;;
 	    *)
diff --git a/git-merge.sh b/git-merge.sh
index fd587c5..49c46d5 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -197,7 +197,7 @@ f,*)
 	;;
 ?,1,"$head",*)
 	# Again the most common case of merging one remote.
-	echo "Updating $head..$1"
+	echo "Updating $(git-rev-parse --short $head)..$(git-rev-parse --shor=
t $1)"
 	git-update-index --refresh 2>/dev/null
 	new_head=3D$(git-rev-parse --verify "$1^0") &&
 	git-read-tree -u -v -m $head "$new_head" &&
diff --git a/git-resolve.sh b/git-resolve.sh
index 6e4fb02..36b90e3 100755
--- a/git-resolve.sh
+++ b/git-resolve.sh
@@ -46,7 +46,7 @@ case "$common" in
 	exit 0
 	;;
 "$head")
-	echo "Updating $head..$merge"
+	echo "Updating $(git-rev-parse --short $head)..$(git-rev-parse --shor=
t $merge)"
 	git-read-tree -u -m $head $merge || exit 1
 	git-update-ref -m "resolve $merge_name: Fast forward" \
 		HEAD "$merge" "$head"
--=20
1.4.2.1.g38049
