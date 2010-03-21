From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] pull: use --quiet rather than 2>/dev/null
Date: Sat, 20 Mar 2010 23:33:30 -0500
Message-ID: <20100321043330.GA9803@progeny.tock>
References: <1269051518-25099-1-git-send-email-bmeyer@rim.com>
 <1269051518-25099-2-git-send-email-bmeyer@rim.com>
 <20100320123520.GA29041@progeny.tock>
 <818FE4EC-5AE9-4F05-B9AD-E1753F7ED9E6@meyerhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Benjamin Meyer <ben@meyerhome.net>
X-From: git-owner@vger.kernel.org Sun Mar 21 05:32:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtCqI-0005fS-Jy
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 05:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784Ab0CUEcd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 00:32:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49530 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0CUEcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 00:32:32 -0400
Received: by gyg8 with SMTP id 8so2160226gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5oAkISTImS/usaRkJIM6vt2ENd8/CbLPmUZZKtfhgew=;
        b=qn+DZwB0j1AUzrFQSfIs9cHRm+7634CC0X18sa6BFZnGJ9/fj+fyqqfIdLTkIT8R3l
         NL99mJeb4n1Kd/7AeYGSz26wTvft784+ubPWLISTOYOxsHCwrbCM3bCuJJ3pWzuXuzO2
         7tIXb8GTiy7+NtQqdVtOMKby7UJmZPpcfQaIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uLQYWzGBUSfkm6/LC4nYbrFmXKt5rzOBiqK/iA20fVOVhDSQGlFrz+GQ1aHxHP9qY0
         znN1hosFfUaecOfGSvKsrAfSzfFnEFGYnD+3P8Uo4pdE/wMzKSFKzLPDQu/rKUWXj9SW
         xkw8869NBbK2bc0BMPD96mLmRNa8wQDRLG8nU=
Received: by 10.150.236.2 with SMTP id j2mr9704193ybh.44.1269145950323;
        Sat, 20 Mar 2010 21:32:30 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1514099iwn.0.2010.03.20.21.32.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 21:32:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <818FE4EC-5AE9-4F05-B9AD-E1753F7ED9E6@meyerhome.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142788>

Hi again,

Benjamin Meyer wrote:

> re-checking the other patches I think they are correct in their
> usage.

Thanks for checking.

> I ran the matching tests, the rebase ones passed,
> 3903-stash.sh is already failing before my patch and
> t3904-stash-patch.sh continues passing with the patch.  Other then
> running the tests in t/ is there anything I should do to verify
> patches?

Regarding testing: the best thing to do IMHO is to explain in the commi=
t
message what effect the patch will have.  Then reviewers (including you=
)
can read it and try it out to make sure what you say is true.

The test suite is not very good for checking that a patch does what
it=E2=80=99s meant to do, but that=E2=80=99s okay, since it has a diffe=
rent purpose [1].

As an example of what I mean, here is your patch 1/4 again (untested,
though).  I didn=E2=80=99t add any tests since it would be kind of hard=
 to
provoke address space exhaustion at just the right moment.

[1] See http://thread.gmane.org/gmane.comp.version-control.git/142480/f=
ocus=3D142745

-- %< --
=46rom: Benjamin C Meyer <bmeyer@rim.com>
Subject: scripts: use rev-parse --verify -q rather than using 2>/dev/nu=
ll

b1b3596 (2008-04-26) taught rev-parse --verify a --quiet option to
suppress the =E2=80=9Cfatal: Needed a single revision=E2=80=9D message =
when its
argument is not a valid object.  Use it; this simplifies scripts
somewhat, and it allows other errors (such as address space exhaustion)
to be reported properly.

Since --quiet does not suppress warnings about ambiguous ref names
and inadequate reflogs, the redirection has been kept for call sites
that might involve either of these phenomena.

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
t3903-stash.sh fails for me with your original patch.  Maybe you
forgot to run 'make' before running tests?  I fixed it by putting
back in the 2>&1 on the ... || clear_stash line.

 contrib/completion/git-completion.bash |    2 +-
 contrib/examples/git-checkout.sh       |   10 +++++-----
 contrib/examples/git-commit.sh         |    2 +-
 contrib/examples/git-fetch.sh          |    4 ++--
 contrib/examples/git-merge.sh          |   10 +++++-----
 contrib/examples/git-reset.sh          |    2 +-
 contrib/examples/git-revert.sh         |    4 ++--
 git-cvsimport.perl                     |    2 +-
 git-stash.sh                           |   13 +++++++------
 templates/hooks--pre-commit.sample     |    2 +-
 10 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 733ac39..5b287e1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -151,7 +151,7 @@ __git_ps1 ()
 				fi
 			fi
 			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$=
"
+				git rev-parse --verify -q refs/stash >/dev/null && s=3D"$"
 			fi
=20
 			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
diff --git a/contrib/examples/git-checkout.sh b/contrib/examples/git-ch=
eckout.sh
index 1a7689a..f735209 100755
--- a/contrib/examples/git-checkout.sh
+++ b/contrib/examples/git-checkout.sh
@@ -16,7 +16,7 @@ SUBDIRECTORY_OK=3DSometimes
 require_work_tree
=20
 old_name=3DHEAD
-old=3D$(git rev-parse --verify $old_name 2>/dev/null)
+old=3D$(git rev-parse --verify -q $old_name)
 oldbranch=3D$(git symbolic-ref $old_name 2>/dev/null)
 new=3D
 new_name=3D
@@ -71,8 +71,8 @@ while test $# !=3D 0; do
 done
=20
 arg=3D"$1"
-rev=3D$(git rev-parse --verify "$arg" 2>/dev/null)
-if rev=3D$(git rev-parse --verify "$rev^0" 2>/dev/null)
+rev=3D$(git rev-parse --verify -q "$arg" 2>/dev/null)
+if rev=3D$(git rev-parse --verify -q "$rev^0" 2>/dev/null)
 then
 	[ -z "$rev" ] && die "unknown flag $arg"
 	new_name=3D"$arg"
@@ -83,7 +83,7 @@ then
 	fi
 	new=3D"$rev"
 	shift
-elif rev=3D$(git rev-parse --verify "$rev^{tree}" 2>/dev/null)
+elif rev=3D$(git rev-parse --verify -q "$rev^{tree}" 2>/dev/null)
 then
 	# checking out selected paths from a tree-ish.
 	new=3D"$rev"
@@ -151,7 +151,7 @@ else
 	# but switching branches.
 	if test '' !=3D "$new"
 	then
-		git rev-parse --verify "$new^{commit}" >/dev/null 2>&1 ||
+		git rev-parse --verify -q "$new^{commit}" >/dev/null 2>&1 ||
 		die "Cannot switch branch to a non-commit."
 	fi
 fi
diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-comm=
it.sh
index 5c72f65..35626c5 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -9,7 +9,7 @@ OPTIONS_SPEC=3D
 . git-sh-setup
 require_work_tree
=20
-git rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=3Dt
+git rev-parse --verify -q HEAD >/dev/null || initial_commit=3Dt
=20
 case "$0" in
 *status)
diff --git a/contrib/examples/git-fetch.sh b/contrib/examples/git-fetch=
=2Esh
index e44af2c..a35f997 100755
--- a/contrib/examples/git-fetch.sh
+++ b/contrib/examples/git-fetch.sh
@@ -124,7 +124,7 @@ append_fetch_head () {
 # repository is always fine.
 if test -z "$update_head_ok" && test $(is_bare_repository) =3D false
 then
-	orig_head=3D$(git rev-parse --verify HEAD 2>/dev/null)
+	orig_head=3D$(git rev-parse --verify -q HEAD)
 fi
=20
 # Allow --notags from remote.$1.tagopt
@@ -365,7 +365,7 @@ case "$orig_head" in
 '')
 	;;
 ?*)
-	curr_head=3D$(git rev-parse --verify HEAD 2>/dev/null)
+	curr_head=3D$(git rev-parse --verify -q HEAD)
 	if test "$curr_head" !=3D "$orig_head"
 	then
 	    git update-ref \
diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge=
=2Esh
index 8f617fc..5ff2999 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -130,7 +130,7 @@ finish () {
=20
 merge_name () {
 	remote=3D"$1"
-	rh=3D$(git rev-parse --verify "$remote^0" 2>/dev/null) || return
+	rh=3D$(git rev-parse --verify -q "$remote^0" 2>/dev/null) || return
 	bh=3D$(git show-ref -s --verify "refs/heads/$remote" 2>/dev/null)
 	if test "$rh" =3D "$bh"
 	then
@@ -226,15 +226,15 @@ fi
 # have "-m" so it is an additional safety measure to check for it.
=20
 if test -z "$have_message" &&
-	second_token=3D$(git rev-parse --verify "$2^0" 2>/dev/null) &&
-	head_commit=3D$(git rev-parse --verify "HEAD" 2>/dev/null) &&
+	second_token=3D$(git rev-parse --verify -q "$2^0" 2>/dev/null) &&
+	head_commit=3D$(git rev-parse --verify -q "HEAD") &&
 	test "$second_token" =3D "$head_commit"
 then
 	merge_msg=3D"$1"
 	shift
 	head_arg=3D"$1"
 	shift
-elif ! git rev-parse --verify HEAD >/dev/null 2>&1
+elif ! git rev-parse --verify -q HEAD >/dev/null
 then
 	# If the merged head is a valid one there is no reason to
 	# forbid "git merge" into a branch yet to be born.  We do
@@ -277,7 +277,7 @@ set_reflog_action "merge $*"
 remoteheads=3D
 for remote
 do
-	remotehead=3D$(git rev-parse --verify "$remote"^0 2>/dev/null) ||
+	remotehead=3D$(git rev-parse --verify -q "$remote"^0 2>/dev/null) ||
 	    die "$remote - not something we can merge"
 	remoteheads=3D"${remoteheads}$remotehead "
 	eval GITHEAD_$remotehead=3D'"$remote"'
diff --git a/contrib/examples/git-reset.sh b/contrib/examples/git-reset=
=2Esh
index bafeb52..e09a9c4 100755
--- a/contrib/examples/git-reset.sh
+++ b/contrib/examples/git-reset.sh
@@ -75,7 +75,7 @@ else
 fi
=20
 # Any resets update HEAD to the head being switched to.
-if orig=3D$(git rev-parse --verify HEAD 2>/dev/null)
+if orig=3D$(git rev-parse --verify -q HEAD)
 then
 	echo "$orig" >"$GIT_DIR/ORIG_HEAD"
 else
diff --git a/contrib/examples/git-revert.sh b/contrib/examples/git-reve=
rt.sh
index 49f0032..5672b4f 100755
--- a/contrib/examples/git-revert.sh
+++ b/contrib/examples/git-revert.sh
@@ -78,9 +78,9 @@ esac
 rev=3D$(git-rev-parse --verify "$@") &&
 commit=3D$(git-rev-parse --verify "$rev^0") ||
 	die "Not a single commit $@"
-prev=3D$(git-rev-parse --verify "$commit^1" 2>/dev/null) ||
+prev=3D$(git rev-parse --verify -q "$commit^1") ||
 	die "Cannot run $me a root commit"
-git-rev-parse --verify "$commit^2" >/dev/null 2>&1 &&
+git rev-parse --verify -q "$commit^2" >/dev/null &&
 	die "Cannot run $me a multi-parent commit."
=20
 encoding=3D$(git config i18n.commitencoding || echo UTF-8)
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 9e03eee..0b13d23 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -573,7 +573,7 @@ sub is_sha1 {
=20
 sub get_headref ($) {
 	my $name =3D shift;
-	my $r =3D `git rev-parse --verify '$name' 2>/dev/null`;
+	my $r =3D `git rev-parse --verify -q '$name' 2>/dev/null`;
 	return undef unless $? =3D=3D 0;
 	chomp $r;
 	return $r;
diff --git a/git-stash.sh b/git-stash.sh
index aa47e54..f6bd623 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -39,7 +39,7 @@ clear_stash () {
 	then
 		die "git stash clear with parameters is unimplemented"
 	fi
-	if current=3D$(git rev-parse --verify $ref_stash 2>/dev/null)
+	if current=3D$(git rev-parse --verify -q $ref_stash)
 	then
 		git update-ref -d $ref_stash $current
 	fi
@@ -201,7 +201,7 @@ save_stash () {
 }
=20
 have_stash () {
-	git rev-parse --verify $ref_stash >/dev/null 2>&1
+	git rev-parse --verify -q $ref_stash >/dev/null
 }
=20
 list_stash () {
@@ -342,16 +342,17 @@ drop_stash () {
 	fi
 	# Verify supplied argument looks like a stash entry
 	s=3D$(git rev-parse --verify "$@") &&
-	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
+	git rev-parse --verify -q "$s:"   > /dev/null &&
+	git rev-parse --verify -q "$s^1:" > /dev/null &&
+	git rev-parse --verify -q "$s^2:" > /dev/null ||
 		die "$*: not a valid stashed state"
=20
 	git reflog delete --updateref --rewrite "$@" &&
 		say "Dropped $* ($s)" || die "$*: Could not drop stash entry"
=20
 	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_sta=
sh
+	git rev-parse --verify -q "$ref_stash@{0}" > /dev/null 2>&1 ||
+		clear_stash
 }
=20
 apply_to_branch () {
diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-=
commit.sample
index 439eefd..a1ebe75 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,7 +7,7 @@
 #
 # To enable this hook, rename this file to "pre-commit".
=20
-if git-rev-parse --verify HEAD >/dev/null 2>&1
+if git rev-parse --verify -q HEAD >/dev/null
 then
 	against=3DHEAD
 else
--=20
1.7.0.2
