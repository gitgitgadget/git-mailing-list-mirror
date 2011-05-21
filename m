From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 11/48] i18n: git-am core say messages
Date: Sat, 21 May 2011 18:43:52 +0000
Message-ID: <1306003469-22939-12-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCs-0001Bj-OJ
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab1EUSrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42788 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab1EUSpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:13 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444603eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=vvCnzxpXyy0hhgktQhVmXgZQqgTq/PpXfFz7vZyJxUY=;
        b=jmriPo7NaGFnJKOsn10FiWCK3mahU+lgnlyK+cbtpMUmgOV++Dvk9cKFsAnIuUTEaX
         qMUSRrq9ye2UBKamNIUR+G5Mt5iHkcctI9bB9G1hr+KnDd0W+Ndm4dtEU7Si2YOVeVWL
         5yBG0n626/Qljs4PiXqT6L1aqFJuFEnkemLqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SCPygi34+mLTZRMkk/nN5hdOBOjTa7VlldqQkmZ7II83PUHhx0TA9gw2/BAXO+z7k7
         c7b8lJIX/f8JyDNqC61paWxddRb4gl28vb/B2gRYFDVKPb3f9b/jDpnnMRZHCma12kcB
         SQMGPD9aLd00y+x2R/KbYWYklG40WA2d4wgUw=
Received: by 10.14.126.137 with SMTP id b9mr282521eei.238.1306003512312;
        Sat, 21 May 2011 11:45:12 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.11
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174162>

Make the core git-am messages that use say() translatable. These are
visible on almost every git am invocation.

There are tests that depend on the "Applying" output that need to be
changed to use the test_i18* functions along with this translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh           |    6 +++---
 t/t4150-am.sh       |    2 +-
 t/t4151-am-abort.sh |    5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index aa52b51..99032ca 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -742,7 +742,7 @@ To restore the original branch and stop patching ru=
n \"\$cmdline --abort\"."; ec
 		stop_here $this
 	fi
=20
-	say "Applying: $FIRSTLINE"
+	say "$(eval_gettext "Applying: \$FIRSTLINE")"
=20
 	case "$resolved" in
 	'')
@@ -787,7 +787,7 @@ did you forget to use 'git add'?"; echo
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
 		    git diff-index --quiet --cached HEAD -- && {
-			say No changes -- Patch already applied.
+			say "$(gettext "No changes -- Patch already applied.")"
 			go_next
 			continue
 		    }
@@ -813,7 +813,7 @@ did you forget to use 'git add'?"; echo
 			GIT_AUTHOR_DATE=3D
 		fi
 		parent=3D$(git rev-parse --verify -q HEAD) ||
-		say >&2 "applying to an empty history"
+		say >&2 "$(gettext "applying to an empty history")"
=20
 		if test -n "$committer_date_is_author_date"
 		then
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 850fc96..151404e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -465,7 +465,7 @@ test_expect_success 'am newline in subject' '
 	test_tick &&
 	sed -e "s/second/second \\\n foo/" patch1 >patchnl &&
 	git am <patchnl >output.out 2>&1 &&
-	grep "^Applying: second \\\n foo$" output.out
+	test_i18ngrep "^Applying: second \\\n foo$" output.out
 '
=20
 test_expect_success 'am -q is quiet' '
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index c95c4cc..1176bcc 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -45,8 +45,9 @@ do
=20
 	test_expect_success "am$with3 --skip continue after failed am$with3" =
'
 		test_must_fail git am$with3 --skip >output &&
-		test "$(grep "^Applying" output)" =3D "Applying: 6" &&
-		test_cmp file-2-expect file-2 &&
+		test_i18ngrep "^Applying" output >output.applying &&
+		test_i18ngrep "^Applying: 6$" output.applying &&
+		test_i18ncmp file-2-expect file-2 &&
 		test ! -f .git/MERGE_RR
 	'
=20
--=20
1.7.5.1
