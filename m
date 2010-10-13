From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t5560: use `X=Y && export X' not `export X=Y'
Date: Wed, 13 Oct 2010 11:36:21 -0700
Message-ID: <7vd3relz2y.fsf@alter.siamese.dyndns.org>
References: <1286437634-12593-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 20:36:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P66Bt-0004xd-9z
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 20:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab0JMSgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 14:36:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab0JMSge convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 14:36:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8048FDEFCB;
	Wed, 13 Oct 2010 14:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JRnwwMDU1k5C
	MiHWNhxq66N3h0A=; b=Xr/mgcfYc5V1ynwcdd5QhqN1gAFeQfHk7ryyg7CnDQcE
	I4SmFNK3xNesEbz37FSy/I1UYm+81Fvu7JhgTwPUnLbC2vNogkLST8yi3/ZYTrLR
	UlzyCddF9zJfn3LewvP+UV0LRvUzsJpzVpNoQS9UiUu/yEsxJAV3FQ4EWcK6qck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o9v97b
	EXE+kBKhnlCR3UXQY8kPHSFsIIHKAsK6HeMPcnuTuoiewLw1aXqDx8STvdOnfiXj
	nfox1LxpoeMHVw9u4IqEJ28uWHVup7XQsNgsLP0WapylwZntVopGQ4IAxXzwwXsF
	6XpgJQ+Rz756LZvZUnQ/rnoGijIvjmt5ht+Pk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E4B3DEFBF;
	Wed, 13 Oct 2010 14:36:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEF61DEFB9; Wed, 13 Oct
 2010 14:36:23 -0400 (EDT)
In-Reply-To: <1286437634-12593-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\,  7 Oct
 2010 07\:47\:14 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB1C6B6A-D6F8-11DF-AB3A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158958>

Let's do this instead.

 * One patch to clean things up in all of 'maint';
 * Another to clean the remainder that are in 'master'.

Here is the one for 'maint' to make the output from

    $ git grep '^[ 	]*export .*=3D' -- '*.sh'

empty.

-- >8 --
Subject: shell portability: no "export VAR=3DVAL"

It is more portable to say "VAR=3DVAL && export VAR" instead.

Noticed by =C3=86var.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh                        |    2 +-
 git-rebase.sh                    |    2 +-
 git-stash.sh                     |    2 +-
 t/t1509-root-worktree.sh         |   28 ++++++++++++++--------------
 t/t5560-http-backend-noserver.sh |    8 ++++----
 t/t556x_common                   |    4 ++--
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e7f008c..5f24948 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -137,7 +137,7 @@ It does not apply to blobs recorded in its index."
     export GITHEAD_$his_tree
     if test -n "$GIT_QUIET"
     then
-	    export GIT_MERGE_VERBOSITY=3D0
+	    GIT_MERGE_VERBOSITY=3D0 && export GIT_MERGE_VERBOSITY
     fi
     git-merge-recursive $orig_tree -- HEAD $his_tree || {
 	    git rerere $allow_rerere_autoupdate
diff --git a/git-rebase.sh b/git-rebase.sh
index 3335cee..e5df23b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -111,7 +111,7 @@ call_merge () {
 	export GITHEAD_$cmt GITHEAD_$hd
 	if test -n "$GIT_QUIET"
 	then
-		export GIT_MERGE_VERBOSITY=3D1
+		GIT_MERGE_VERBOSITY=3D1 && export GIT_MERGE_VERBOSITY
 	fi
 	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
 	rv=3D$?
diff --git a/git-stash.sh b/git-stash.sh
index 5fb1245..7561b37 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -373,7 +373,7 @@ apply_stash () {
=20
 	if test -n "$GIT_QUIET"
 	then
-		export GIT_MERGE_VERBOSITY=3D0
+		GIT_MERGE_VERBOSITY=3D0 && export GIT_MERGE_VERBOSITY
 	fi
 	if git merge-recursive $b_tree -- $c_tree $w_tree
 	then
diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index 7f60fd0..335420f 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -134,8 +134,8 @@ cat >ls.expected <<EOF
 100644 $ONE_SHA1 0	me
 EOF
=20
-export GIT_DIR=3D"$TRASH_DIRECTORY/.git"
-export GIT_WORK_TREE=3D/
+GIT_DIR=3D"$TRASH_DIRECTORY/.git" && export GIT_DIR
+GIT_WORK_TREE=3D/ && export GIT_WORK_TREE
=20
 test_vars 'abs gitdir, root' "$GIT_DIR" "/" ""
 test_foobar_root
@@ -154,24 +154,24 @@ say "GIT_DIR relative, GIT_WORK_TREE set"
=20
 test_expect_success 'go to /' 'cd /'
=20
-export GIT_DIR=3D"$(echo $TRASH_DIRECTORY|sed 's,^/,,')/.git"
-export GIT_WORK_TREE=3D/
+GIT_DIR=3D"$(echo $TRASH_DIRECTORY|sed 's,^/,,')/.git" && export GIT_D=
IR
+GIT_WORK_TREE=3D/ && export GIT_WORK_TREE
=20
 test_vars 'rel gitdir, root' "$GIT_DIR" "/" ""
 test_foobar_root
=20
 test_expect_success 'go to /foo' 'cd /foo'
=20
-export GIT_DIR=3D"../$TRASH_DIRECTORY/.git"
-export GIT_WORK_TREE=3D/
+GIT_DIR=3D"../$TRASH_DIRECTORY/.git" && export GIT_DIR
+GIT_WORK_TREE=3D/ && export GIT_WORK_TREE
=20
 test_vars 'rel gitdir, foo' "$TRASH_DIRECTORY/.git" "/" "foo/"
 test_foobar_foo
=20
 test_expect_success 'go to /foo/bar' 'cd /foo/bar'
=20
-export GIT_DIR=3D"../../$TRASH_DIRECTORY/.git"
-export GIT_WORK_TREE=3D/
+GIT_DIR=3D"../../$TRASH_DIRECTORY/.git" && export GIT_DIR
+GIT_WORK_TREE=3D/ && export GIT_WORK_TREE
=20
 test_vars 'rel gitdir, foo/bar' "$TRASH_DIRECTORY/.git" "/" "foo/bar/"
 test_foobar_foobar
@@ -180,24 +180,24 @@ say "GIT_DIR relative, GIT_WORK_TREE relative"
=20
 test_expect_success 'go to /' 'cd /'
=20
-export GIT_DIR=3D"$(echo $TRASH_DIRECTORY|sed 's,^/,,')/.git"
-export GIT_WORK_TREE=3D.
+GIT_DIR=3D"$(echo $TRASH_DIRECTORY|sed 's,^/,,')/.git" && export GIT_D=
IR
+GIT_WORK_TREE=3D. && export GIT_WORK_TREE
=20
 test_vars 'rel gitdir, root' "$GIT_DIR" "/" ""
 test_foobar_root
=20
 test_expect_success 'go to /' 'cd /foo'
=20
-export GIT_DIR=3D"../$TRASH_DIRECTORY/.git"
-export GIT_WORK_TREE=3D..
+GIT_DIR=3D"../$TRASH_DIRECTORY/.git" && export GIT_DIR
+GIT_WORK_TREE=3D.. && export GIT_WORK_TREE
=20
 test_vars 'rel gitdir, foo' "$TRASH_DIRECTORY/.git" "/" "foo/"
 test_foobar_foo
=20
 test_expect_success 'go to /foo/bar' 'cd /foo/bar'
=20
-export GIT_DIR=3D"../../$TRASH_DIRECTORY/.git"
-export GIT_WORK_TREE=3D../..
+GIT_DIR=3D"../../$TRASH_DIRECTORY/.git" && export GIT_DIR
+GIT_WORK_TREE=3D../.. && export GIT_WORK_TREE
=20
 test_vars 'rel gitdir, foo/bar' "$TRASH_DIRECTORY/.git" "/" "foo/bar/"
 test_foobar_foobar
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-no=
server.sh
index 44885b8..94f9d2e 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -14,7 +14,7 @@ run_backend() {
 }
=20
 GET() {
-	export REQUEST_METHOD=3D"GET" &&
+	REQUEST_METHOD=3D"GET" && export REQUEST_METHOD &&
 	run_backend "/repo.git/$1" &&
 	unset REQUEST_METHOD &&
 	if ! grep "Status" act.out >act
@@ -26,8 +26,8 @@ GET() {
 }
=20
 POST() {
-	export REQUEST_METHOD=3D"POST" &&
-	export CONTENT_TYPE=3D"application/x-$1-request" &&
+	REQUEST_METHOD=3D"POST" && export REQUEST_METHOD &&
+	CONTENT_TYPE=3D"application/x-$1-request" && export CONTENT_TYPE &&
 	run_backend "/repo.git/$1" "$2" &&
 	unset REQUEST_METHOD &&
 	unset CONTENT_TYPE &&
@@ -46,7 +46,7 @@ log_div() {
 . "$TEST_DIRECTORY"/t556x_common
=20
 expect_aliased() {
-	export REQUEST_METHOD=3D"GET" &&
+	REQUEST_METHOD=3D"GET" && export REQUEST_METHOD &&
 	if test $1 =3D 0; then
 		run_backend "$2"
 	else
diff --git a/t/t556x_common b/t/t556x_common
index be024e5..51287d8 100755
--- a/t/t556x_common
+++ b/t/t556x_common
@@ -50,7 +50,7 @@ get_static_files() {
 }
=20
 SMART=3Dsmart
-export GIT_HTTP_EXPORT_ALL=3D1
+GIT_HTTP_EXPORT_ALL=3D1 && export GIT_HTTP_EXPORT_ALL
 test_expect_success 'direct refs/heads/master not found' '
 	log_div "refs/heads/master"
 	GET refs/heads/master "404 Not Found"
@@ -73,7 +73,7 @@ test_expect_success 'export if git-daemon-export-ok' =
'
         get_static_files "200 OK"
 '
 SMART=3Dsmart
-export GIT_HTTP_EXPORT_ALL=3D1
+GIT_HTTP_EXPORT_ALL=3D1 && export GIT_HTTP_EXPORT_ALL
 test_expect_success 'static file if http.getanyfile true is ok' '
 	log_div "getanyfile true"
 	config http.getanyfile true &&
