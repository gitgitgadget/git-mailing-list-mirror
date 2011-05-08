From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 11/48] i18n: git-am core say messages
Date: Sun,  8 May 2011 12:20:43 +0000
Message-ID: <1304857280-14773-12-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31e-0004kb-OM
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab1EHMXl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab1EHMVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:41 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Jbqlz4XTTUZvDUBit2Xsf80hdecmyr75riSwx3CK8M8=;
        b=QxiYEztgjswuE7hyJUHdsISzRGwHWvFqNQDo0kkxJR0RCa3G1CBBA++GmcqAAQSOh0
         pWkRVS01Q5zDNkLY60BQUz/wtTQTvIHaQQ7Y5D058ajs3/agzz7se46jCS51QmlXUY7n
         NxAD/PtcfJ+ocL0muxkUCM+6H5fWJrcEIB4vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TiXitxb1s8UnYdOEytnV1Ohkx3LvJpXtTeavs09ZFKBqLIcGdZPeL0ujfa7Z6Qo57E
         uWFdu3OlMAOeIHHuyR8W9KcewxJCYhkhPGULmiHeQ+k+Uvj9A767SXZ3oXdEcbAVHyiO
         jMR24RjsFHLq0Cre8oe2MwvHBxIcZpyu72NbM=
Received: by 10.14.53.207 with SMTP id g55mr2882053eec.148.1304857301014;
        Sun, 08 May 2011 05:21:41 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.39
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173149>

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
index 903d1e3..77ecae7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -739,7 +739,7 @@ To restore the original branch and stop patching ru=
n \"\$cmdline --abort\"."; ec
 		stop_here $this
 	fi
=20
-	say "Applying: $FIRSTLINE"
+	say "$(eval_gettext "Applying: \$FIRSTLINE")"
=20
 	case "$resolved" in
 	'')
@@ -784,7 +784,7 @@ did you forget to use 'git add'?"; echo
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
 		    git diff-index --quiet --cached HEAD -- && {
-			say No changes -- Patch already applied.
+			say "$(gettext "No changes -- Patch already applied.")"
 			go_next
 			continue
 		    }
@@ -810,7 +810,7 @@ did you forget to use 'git add'?"; echo
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
1.7.4.4
