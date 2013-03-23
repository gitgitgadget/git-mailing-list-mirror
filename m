From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] status, branch: fix the misleading "bisecting" message
Date: Sat, 23 Mar 2013 10:52:44 +0700
Message-ID: <1364010764-972-1-git-send-email-pclouds@gmail.com>
References: <7vfvzqgms9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 04:53:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJFWO-0004G0-NK
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 04:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709Ab3CWDxD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 23:53:03 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:55646 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381Ab3CWDxC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 23:53:02 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so3387467pbc.16
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 20:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PsYZfpFfDU6UU5jFsX4plVZU8S+IQX7O3/vy7fFJZLE=;
        b=jU1Z6Y9UvfeTmj4lRW1tfhvS5DIS9WF6fGLefqxapz4MrRpeziWvV9UihhzFAKc7xV
         D6Zhd0gZvpWMJquk1CZXPB6fXJQE2hm/bE6anPSuLTVq4LS0EQwJRF/JchnG8jFCGPJw
         L9l9IvbQI/lNLNSGrimCWVCLpE3qPMf2IrjaG5ETo1easwzdXcULyXz9SbN77UM39xb1
         Te7EUOaONqhE8Gryl/KOHj9uxzHxEw+ZJQeTO8dSaS44AJ8niwskJEh0RiCO9zOEJnEW
         oeotG4Y6DtyekBhMKOTEeYi2uydrNxY9EZ7oGAMJhMYYJ5cHsfS/tTD/H7vgo8BKgY+r
         32Dw==
X-Received: by 10.68.9.67 with SMTP id x3mr6031497pba.219.1364010781958;
        Fri, 22 Mar 2013 20:53:01 -0700 (PDT)
Received: from lanh ([115.74.37.60])
        by mx.google.com with ESMTPS id gf1sm4600030pbc.24.2013.03.22.20.52.58
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 20:53:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 23 Mar 2013 10:53:00 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <7vfvzqgms9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218882>

The current message is "bisecting %s" (or "bisecting branch %s").
"%s" is the current branch when we started bisecting. Clarify that to
avoid confusion with good and bad refs passed to "bisect" command.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c            | 2 +-
 t/t6030-bisect-porcelain.sh | 2 +-
 t/t7512-status-help.sh      | 2 +-
 wt-status.c                 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 99105f8..8f00203 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -562,7 +562,7 @@ static char *get_head_description(void)
 		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
 			    state.branch);
 	else if (state.bisect_in_progress)
-		strbuf_addf(&desc, _("(no branch, bisecting %s)"),
+		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
 	else if (state.detached_from)
 		strbuf_addf(&desc, _("(detached from %s)"),
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9b6f0d0..2fce99a 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -164,7 +164,7 @@ test_expect_success 'bisect start: existing ".git/B=
ISECT_START" not modified if
 	cp .git/BISECT_START saved &&
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
-	test_i18ngrep "* (no branch, bisecting other)" branch.output > /dev/n=
ull &&
+	test_i18ngrep "* (no branch, bisect started on other)" branch.output =
> /dev/null &&
 	test_cmp saved .git/BISECT_START
 '
 test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken =
rev' '
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 5adba4f..c35d01d 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -578,7 +578,7 @@ test_expect_success 'status when bisecting' '
 	TGT=3D$(git rev-parse --short two_bisect) &&
 	cat >expected <<-EOF &&
 	# HEAD detached at $TGT
-	# You are currently bisecting branch '\''bisect'\''.
+	# You are currently bisecting, started from branch '\''bisect'\''.
 	#   (use "git bisect reset" to get back to the original branch)
 	#
 	nothing to commit (use -u to show untracked files)
diff --git a/wt-status.c b/wt-status.c
index 32a51e1..cf3d81a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -953,7 +953,7 @@ static void show_bisect_in_progress(struct wt_statu=
s *s,
 {
 	if (state->branch)
 		status_printf_ln(s, color,
-				 _("You are currently bisecting branch '%s'."),
+				 _("You are currently bisecting, started from branch '%s'."),
 				 state->branch);
 	else
 		status_printf_ln(s, color,
--=20
1.8.2.83.gc99314b
