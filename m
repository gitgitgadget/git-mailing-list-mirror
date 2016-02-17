From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] rebase: move common functions to rebase--lib.sh
Date: Wed, 17 Feb 2016 20:36:39 +0700
Message-ID: <1455716201-29784-2-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Feb 17 14:36:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW2Hf-0002PG-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 14:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422982AbcBQNgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2016 08:36:43 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34216 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422802AbcBQNgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 08:36:42 -0500
Received: by mail-pf0-f170.google.com with SMTP id x65so11708485pfb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 05:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EUoRuW4uagn1+8aTpZOgUxAK1w6YCI0QzAjZ82JoqJo=;
        b=JwJuLGC4bxwieu9OZrkAImDqoJHORGIFPEnUEy1ij4lVvI3YAdG+T/ttT6h+2EZD7m
         mFt5rrbiGfwd8lIBNdfdCP5V9Sp/YZT0quJ6bvRImvJOc2Y23+ZBrt1Iftv1Oy3YCNNg
         Irf1VSrefVhIoEBmq4/GHUAZ1W4UGkRC+g4YMOndJoFsmGsNGNIecR7Ck66Kb5q4If9v
         tWnmk7DSiT9umO3yVbCBx0oaz81GJmfZRw7+KaIbRhtZEqF8WcJDKLEn4ftQp/5tB9TN
         5IbU5K6Xo9vyzFnIzTHoc4YkQ2qAZdKPJlt/rrz5oA9vMQUwEGiSua+ZeO2pDfawDFuP
         tSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=EUoRuW4uagn1+8aTpZOgUxAK1w6YCI0QzAjZ82JoqJo=;
        b=T2LkmObfiYiviJ2naS3Pv3+UXg4lfCGesKyK9D56jrXC/nXJVcimF3iJMbJdo1txlV
         +B7b8zyBUWA5p5AEedCLUCO8Hslm0myC6BW2eDBTal5Xf9xZYh01D+X73L2blbfd0b/q
         wCfv+ALf+v1s1kAEPW08xje3c1D8yMIfgVMQssDcBPIp50NuyESaWNzC1m5v8eD+fXmH
         pldogEPpvboqpJlAD++LH2Vo5fLPqxXxMr7MiSCArbjUmg+qyYXFCEg0xJ3uhu2ZHCCd
         v3BFeEqg8I/pgrMWSWRTDLPjA8Wdr9h/LJitO7iYOxRxpH6v2YKCrSfJ8e8EQsvMzaYR
         zcWw==
X-Gm-Message-State: AG10YOT5OdNuoM+fnZL8AihYx7pPXW/ymxUSgeMKxk3X9ct7eqgterBj+2tpI7EW9P+g6g==
X-Received: by 10.98.0.11 with SMTP id 11mr2134778pfa.5.1455716202007;
        Wed, 17 Feb 2016 05:36:42 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id k14sm3018977pfj.0.2016.02.17.05.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2016 05:36:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Feb 2016 20:37:04 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455716201-29784-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286499>

These functions are used by git-rebase--*.sh, which will be made
separate programs later. At that point, we can reinclude rebase--lib.sh
to provide the functions without duplicating code.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile                 |  1 +
 git-rebase--lib.sh (new) | 41 ++++++++++++++++++++++++++++++++++++++++=
+
 git-rebase.sh            | 42 +---------------------------------------=
--
 3 files changed, 43 insertions(+), 41 deletions(-)
 create mode 100644 git-rebase--lib.sh

diff --git a/Makefile b/Makefile
index fc2f1ab..1ee0ed3 100644
--- a/Makefile
+++ b/Makefile
@@ -496,6 +496,7 @@ SCRIPT_LIB +=3D git-parse-remote
 SCRIPT_LIB +=3D git-rebase--am
 SCRIPT_LIB +=3D git-rebase--interactive
 SCRIPT_LIB +=3D git-rebase--merge
+SCRIPT_LIB +=3D git-rebase--lib
 SCRIPT_LIB +=3D git-sh-setup
 SCRIPT_LIB +=3D git-sh-i18n
=20
diff --git a/git-rebase--lib.sh b/git-rebase--lib.sh
new file mode 100644
index 0000000..8bec516
--- /dev/null
+++ b/git-rebase--lib.sh
@@ -0,0 +1,41 @@
+write_basic_state () {
+	echo "$head_name" > "$state_dir"/head-name &&
+	echo "$onto" > "$state_dir"/onto &&
+	echo "$orig_head" > "$state_dir"/orig-head &&
+	echo "$GIT_QUIET" > "$state_dir"/quiet &&
+	test t =3D "$verbose" && : > "$state_dir"/verbose
+	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
+	test -n "$strategy_opts" && echo "$strategy_opts" > \
+		"$state_dir"/strategy_opts
+	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate"=
 > \
+		"$state_dir"/allow_rerere_autoupdate
+	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_si=
gn_opt
+}
+
+output () {
+	case "$verbose" in
+	'')
+		output=3D$("$@" 2>&1 )
+		status=3D$?
+		test $status !=3D 0 && printf "%s\n" "$output"
+		return $status
+		;;
+	*)
+		"$@"
+		;;
+	esac
+}
+
+move_to_original_branch () {
+	case "$head_name" in
+	refs/*)
+		message=3D"rebase finished: $head_name onto $onto"
+		git update-ref -m "$message" \
+			$head_name $(git rev-parse HEAD) $orig_head &&
+		git symbolic-ref \
+			-m "rebase finished: returning to $head_name" \
+			HEAD $head_name ||
+		die "$(gettext "Could not move back to $head_name")"
+		;;
+	esac
+}
diff --git a/git-rebase.sh b/git-rebase.sh
index cf60c43..dc29474 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -46,6 +46,7 @@ edit-todo!         edit the todo list during an inter=
active rebase
 "
 . git-sh-setup
 . git-sh-i18n
+. git-rebase--lib
 set_reflog_action rebase
 require_work_tree_exists
 cd_to_toplevel
@@ -114,47 +115,6 @@ read_basic_state () {
 		gpg_sign_opt=3D"$(cat "$state_dir"/gpg_sign_opt)"
 }
=20
-write_basic_state () {
-	echo "$head_name" > "$state_dir"/head-name &&
-	echo "$onto" > "$state_dir"/onto &&
-	echo "$orig_head" > "$state_dir"/orig-head &&
-	echo "$GIT_QUIET" > "$state_dir"/quiet &&
-	test t =3D "$verbose" && : > "$state_dir"/verbose
-	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
-	test -n "$strategy_opts" && echo "$strategy_opts" > \
-		"$state_dir"/strategy_opts
-	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate"=
 > \
-		"$state_dir"/allow_rerere_autoupdate
-	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_si=
gn_opt
-}
-
-output () {
-	case "$verbose" in
-	'')
-		output=3D$("$@" 2>&1 )
-		status=3D$?
-		test $status !=3D 0 && printf "%s\n" "$output"
-		return $status
-		;;
-	*)
-		"$@"
-		;;
-	esac
-}
-
-move_to_original_branch () {
-	case "$head_name" in
-	refs/*)
-		message=3D"rebase finished: $head_name onto $onto"
-		git update-ref -m "$message" \
-			$head_name $(git rev-parse HEAD) $orig_head &&
-		git symbolic-ref \
-			-m "rebase finished: returning to $head_name" \
-			HEAD $head_name ||
-		die "$(gettext "Could not move back to $head_name")"
-		;;
-	esac
-}
=20
 apply_autostash () {
 	if test -f "$state_dir/autostash"
--=20
2.7.0.377.g4cd97dd
