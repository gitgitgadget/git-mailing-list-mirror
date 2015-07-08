From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/9] grep: allow -F -i combination
Date: Wed,  8 Jul 2015 17:38:31 +0700
Message-ID: <1436351919-2520-2-git-send-email-pclouds@gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg, l.s.r@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 12:38:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCmkB-0006dn-Oa
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934911AbbGHKiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 06:38:12 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34542 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934356AbbGHKiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 06:38:09 -0400
Received: by pdbep18 with SMTP id ep18so143635799pdb.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VrHPehr4Ext1uf6eBIOLoPGMMdkktTF9sYiMqDUOuiY=;
        b=QBmVT97rGUkiyrFQoWjuRc4D9T26CFMcZMLT2N6a6UCQHEcBrRCU9pA/1cqYoQJylT
         OgaN3aejTw8NbT9o+HUgjkW209iWn+f6Dm1YfseBQdLntn6Zeqna3fn9ptKffVpgQ+G9
         GPghJYWAvHZAbzSPZC2/Qbh4cLyxw19hlSdNYb//t1ruCDCD4zHMrzxAZf6LhWvzBxZu
         hTfggSL+hfHF558T5sR9CMJhUffjLtebykggWg4sqeQdfR5KyrYumhjQXFqmAedwy+cA
         LhIz1XWrW6If3QcdMOnzvCmjjDQoWRBPwQz+tNNV2dL4oR4LET7hdZ4k+QX3Z5R89KBE
         lApg==
X-Received: by 10.66.164.106 with SMTP id yp10mr19062778pab.121.1436351888624;
        Wed, 08 Jul 2015 03:38:08 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id j2sm2060622pdk.21.2015.07.08.03.38.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 03:38:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 17:38:53 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273658>

-F means "no regex", not "case sensitive" so it should not override -i

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d04f440..2d392e9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -806,7 +806,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (!opt.pattern_list)
 		die(_("no pattern given."));
-	if (!opt.fixed && opt.ignore_case)
+	if (opt.ignore_case)
 		opt.regflags |=3D REG_ICASE;
=20
 	compile_grep_patterns(&opt);
--=20
2.3.0.rc1.137.g477eb31
