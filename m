From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] rebase: turn git-rebase--*.sh into separate programs
Date: Wed, 17 Feb 2016 20:36:41 +0700
Message-ID: <1455716201-29784-4-git-send-email-pclouds@gmail.com>
References: <vpqio1nsk0q.fsf@anie.imag.fr>
 <1455716201-29784-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu.Moy@grenoble-inp.fr, sbeller@google.com, peff@peff.net,
	christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 14:37:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW2II-0002so-Ab
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 14:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423042AbcBQNhS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2016 08:37:18 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34314 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423069AbcBQNgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 08:36:55 -0500
Received: by mail-pf0-f169.google.com with SMTP id x65so11711049pfb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 05:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lu59P/ccPvZvBSbwQkpDUtGhu2J4BRh0+Y0ErLP1cd8=;
        b=kXRtr0YGIlQM+T2lv05BGxsIpIFLtqYNGDY3LPL3B3lNTsMCyEAUIqmuv9Xex/5r4Y
         bPbI+dH31BUpsphPaI07l9XTAaRndHb1B2zkFQQo1QSd+WxAZw9t6aNZnnVnb/De6SwG
         X2VHRJBSf4TDa1DdEZxCeALLcidG29ieJpz2RN7LW+ICXbpy8/ULHPmLhRStNmHWYYwh
         RbTwBTlWMvfKD5gXPi09PE/RhZju6nyIqKojdCmMBvuEdVHYt4awJablVTxxU+NiKQYA
         QA1B1k+MNGzwT4SYWLp/ZGSK1V6C30pt7lG6ahmwDP3NlTfI65Ynwb9DTvOYzIdvPAMb
         +wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=lu59P/ccPvZvBSbwQkpDUtGhu2J4BRh0+Y0ErLP1cd8=;
        b=kqLcWjeS0MSOlpzvwtIWgShZtzcx+8HYyeZvm7M43GxZn5h4MbjHszhqE9WIDHilvA
         ulBF6b+7dHrKCknNst9ofMoH1ve4EY1x/wumEdAxgjWTEDOfQk77wOm78HBA425ZowNe
         Zhq47ov1om1D+8UFx+PYRMF22LnP33x5rIpPJowYJ7OLSy9eoFxrXLlvvJBSeFU+z4H8
         jmn+BrzAScB/Oh8v0coPW6goXmHLSIXfqBaTV0NwBSwNHMF7Qc1+MUul5VO+Xp9sqrtf
         2sJR5b/VFa/ePEaUP3HLlI6uEPIwjlpSa5j7SmnVitZxktxUfrC/JzpKfstjiWtHY5Uf
         OBXg==
X-Gm-Message-State: AG10YOREGwpGwDaY4tIP8w2rA6M2ynwmxfaFyRua2rlN5gTrLX15vUNmdthyts32sN6Aug==
X-Received: by 10.98.68.212 with SMTP id m81mr2093887pfi.135.1455716214779;
        Wed, 17 Feb 2016 05:36:54 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id xu1sm2871345pab.31.2016.02.17.05.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2016 05:36:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Feb 2016 20:37:17 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455716201-29784-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286501>

This is the first step of turning any of these scripts into C. We can
see now what variables are exchanged between git-rebase.sh and the
subscript (but we don't see all in this patch, variables may have been
exported earlier in git-rebase.sh)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile                             |  6 +++---
 git-rebase--am.sh (mode +x)          | 23 ++++++++++++++---------
 git-rebase--interactive.sh (mode +x) | 15 +++++++++++++++
 git-rebase--merge.sh (mode +x)       | 14 ++++++++++++++
 git-rebase.sh                        | 23 ++++++++++++++++-------
 5 files changed, 62 insertions(+), 19 deletions(-)
 mode change 100644 =3D> 100755 git-rebase--am.sh
 mode change 100644 =3D> 100755 git-rebase--interactive.sh
 mode change 100644 =3D> 100755 git-rebase--merge.sh

diff --git a/Makefile b/Makefile
index 1ee0ed3..ea636e6 100644
--- a/Makefile
+++ b/Makefile
@@ -486,6 +486,9 @@ SCRIPT_SH +=3D git-mergetool.sh
 SCRIPT_SH +=3D git-quiltimport.sh
 SCRIPT_SH +=3D git-rebase.sh
 SCRIPT_SH +=3D git-remote-testgit.sh
+SCRIPT_SH +=3D git-rebase--am.sh
+SCRIPT_SH +=3D git-rebase--interactive.sh
+SCRIPT_SH +=3D git-rebase--merge.sh
 SCRIPT_SH +=3D git-request-pull.sh
 SCRIPT_SH +=3D git-stash.sh
 SCRIPT_SH +=3D git-submodule.sh
@@ -493,9 +496,6 @@ SCRIPT_SH +=3D git-web--browse.sh
=20
 SCRIPT_LIB +=3D git-mergetool--lib
 SCRIPT_LIB +=3D git-parse-remote
-SCRIPT_LIB +=3D git-rebase--am
-SCRIPT_LIB +=3D git-rebase--interactive
-SCRIPT_LIB +=3D git-rebase--merge
 SCRIPT_LIB +=3D git-rebase--lib
 SCRIPT_LIB +=3D git-sh-setup
 SCRIPT_LIB +=3D git-sh-i18n
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
old mode 100644
new mode 100755
index 9ae898b..3837f53
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -4,15 +4,19 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
=20
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
-#
-# However, FreeBSD /bin/sh misbehaves on such a construct and
-# continues to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
+. git-sh-setup
+. git-sh-i18n
+. git-rebase--lib
+require_work_tree_exists
+
+GIT_QUIET=3D$git_quiet
+GIT_REFLOG_ACTION=3D$git_reflog_action
+resolvemsg=3D"
+$(gettext 'When you have resolved this problem, run "git rebase --cont=
inue".
+If you prefer to skip this patch, run "git rebase --skip" instead.
+To check out the original branch and stop rebasing, run "git rebase --=
abort".')
+"
+
 git_rebase__am () {
=20
 case "$action" in
@@ -99,3 +103,4 @@ move_to_original_branch
 }
 # ... and then we call the whole thing.
 git_rebase__am
+exit_rebase $?
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
old mode 100644
new mode 100755
index c0cfe88..1169920
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -7,6 +7,20 @@
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
 #
+
+. git-sh-setup
+. git-sh-i18n
+. git-rebase--lib
+require_work_tree_exists
+
+GIT_QUIET=3D$git_quiet
+GIT_REFLOG_ACTION=3D$git_reflog_action
+resolvemsg=3D"
+$(gettext 'When you have resolved this problem, run "git rebase --cont=
inue".
+If you prefer to skip this patch, run "git rebase --skip" instead.
+To check out the original branch and stop rebasing, run "git rebase --=
abort".')
+"
+
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
 # the lines are processed, they are removed from the front of this
@@ -1294,3 +1308,4 @@ do_rest
 }
 # ... and then we call the whole thing.
 git_rebase__interactive
+exit_rebase $?
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
old mode 100644
new mode 100755
index 2cc2a6d..f453d15
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -5,6 +5,19 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
=20
+. git-sh-setup
+. git-sh-i18n
+. git-rebase--lib
+require_work_tree_exists
+
+GIT_QUIET=3D$git_quiet
+GIT_REFLOG_ACTION=3D$git_reflog_action
+resolvemsg=3D"
+$(gettext 'When you have resolved this problem, run "git rebase --cont=
inue".
+If you prefer to skip this patch, run "git rebase --skip" instead.
+To check out the original branch and stop rebasing, run "git rebase --=
abort".')
+"
+
 prec=3D4
=20
 read_state () {
@@ -165,3 +178,4 @@ finish_rb_merge
 }
 # ... and then we call the whole thing.
 git_rebase__merge
+exit_rebase $?
diff --git a/git-rebase.sh b/git-rebase.sh
index 0c70381..67b847f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -54,11 +54,6 @@ cd_to_toplevel
 LF=3D'
 '
 ok_to_skip_pre_rebase=3D
-resolvemsg=3D"
-$(gettext 'When you have resolved this problem, run "git rebase --cont=
inue".
-If you prefer to skip this patch, run "git rebase --skip" instead.
-To check out the original branch and stop rebasing, run "git rebase --=
abort".')
-"
 unset onto
 unset restrict_revision
 cmd=3D
@@ -121,8 +116,22 @@ run_specific_rebase () {
 		export GIT_EDITOR
 		autosquash=3D
 	fi
-	. git-rebase--$type
-	exit_rebase $?
+	git_quiet=3D$GIT_QUIET
+	git_reflog_action=3D$GIT_REFLOG_ACTION
+	export GIT_PAGER
+	# these are for write_basic_state()
+	export allow_rerere_autoupdate gpg_sign_opt head_name onto
+	export orig_head state_dir strategy strategy_opts verbose
+	# common variables
+	export action git_reflog_action git_quiet keep_empty
+	export rebase_root restrict_revision revisions upstream
+	# git-rebase--am specific
+	export git_am_opt
+	# git-rebase--interactive specific
+	export autosquash cmd force_rebase onto_name preserve_merges
+	export squash_onto switch_to
+
+	exec git-rebase--$type
 }
=20
 run_pre_rebase_hook () {
--=20
2.7.0.377.g4cd97dd
