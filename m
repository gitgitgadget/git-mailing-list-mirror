From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 7/7] i18n: mark checkout plural warning for translation
Date: Sun, 10 Apr 2011 19:34:08 +0000
Message-ID: <1302464048-21806-8-git-send-email-avarab@gmail.com>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 21:34:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90PJ-0003I2-Os
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055Ab1DJTef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:34:35 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58609 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757876Ab1DJTea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:34:30 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1534099eyx.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Y7DdEcVwX5QDP/4yvwECaWgSzzB5j0e0x7CExUsBmHk=;
        b=So6F2BqEFtH7fefjf//LBM/O9CrkPp8nnM64YOkNjWmnYvoDdL6xjDWG1fwT+2M5P6
         dw86CLaI1YDFLuahntgf5ay8Kb3X1FxCy2Pvr4wrolJfuj+yMn7bjMzS/nVj9hMjZ2bn
         cWG1PL59Ln9M4clAxj5d7n/8SM/xJTVT4VyKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=parWUZPxP5BV2VPutRJ5YKMJgbpzn97tGPYQXvbPAr2oaJB5aDhPuHafFIoWfWGHrj
         Vp+Z5cv748g0Q9H+qaKzVvlQdHC3bORR7FeoEPlg/G5bDx9Gj9Kwa9TVkaT7nvUIu3h6
         7QzmMF1+BVXDwUiQD9/uhlwaccUD2S81uTczs=
Received: by 10.213.26.214 with SMTP id f22mr734059ebc.38.1302464070204;
        Sun, 10 Apr 2011 12:34:30 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id m55sm1147236eei.8.2011.04.10.12.34.28
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:34:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171281>

Mark the "Warning: you are leaving %d commit(s) behind" message added
in v1.7.5-rc0~74^2 (commit: give final warning when reattaching HEAD
to leave commits behind) by Junio C Hamano for translation.

This message requires the use of ngettext() features, and is the first
message to use the Q_() wrapper around ngettext().

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c         |   18 +++++++++++++++---
 t/t2020-checkout-detach.sh |   15 ++++++++++++---
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0b65edd..5e94720 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -648,18 +648,30 @@ static void suggest_reattach(struct commit *commi=
t, struct rev_info *revs)
 		if (more =3D=3D 1)
 			describe_one_orphan(&sb, last);
 		else
-			strbuf_addf(&sb, " ... and %d more.\n", more);
+			strbuf_addf(&sb, _(" ... and %d more.\n"), more);
 	}
=20
 	fprintf(stderr,
-		"Warning: you are leaving %d commit%s behind, "
+		Q_(
+		/* The singular version */
+		"Warning: you are leaving %d commit behind, "
 		"not connected to\n"
 		"any of your branches:\n\n"
 		"%s\n"
 		"If you want to keep them by creating a new branch, "
 		"this may be a good time\nto do so with:\n\n"
 		" git branch new_branch_name %s\n\n",
-		lost, ((1 < lost) ? "s" : ""),
+		/* The plural version */
+		"Warning: you are leaving %d commits behind, "
+		"not connected to\n"
+		"any of your branches:\n\n"
+		"%s\n"
+		"If you want to keep them by creating a new branch, "
+		"this may be a good time\nto do so with:\n\n"
+		" git branch new_branch_name %s\n\n",
+		/* Give ngettext() the count */
+		lost),
+		lost,
 		sb.buf,
 		sha1_to_hex(commit->object.sha1));
 	strbuf_release(&sb);
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 569b27f..ab782e2 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -108,21 +108,30 @@ test_expect_success 'checkout warns on orphan com=
mits' '
 	echo content >orphan &&
 	git add orphan &&
 	git commit -a -m orphan &&
-	git checkout master 2>stderr &&
+	git checkout master 2>stderr
+'
+
+test_expect_success C_LOCALE_OUTPUT 'checkout warns on orphan commits:=
 output' '
 	check_orphan_warning stderr
 '
=20
 test_expect_success 'checkout does not warn leaving ref tip' '
 	reset &&
 	git checkout --detach two &&
-	git checkout master 2>stderr &&
+	git checkout master 2>stderr
+'
+
+test_expect_success C_LOCALE_OUTPUT 'checkout does not warn leaving re=
f tip' '
 	check_no_orphan_warning stderr
 '
=20
 test_expect_success 'checkout does not warn leaving reachable commit' =
'
 	reset &&
 	git checkout --detach HEAD^ &&
-	git checkout master 2>stderr &&
+	git checkout master 2>stderr
+'
+
+test_expect_success C_LOCALE_OUTPUT 'checkout does not warn leaving re=
achable commit' '
 	check_no_orphan_warning stderr
 '
=20
--=20
1.7.4.1
