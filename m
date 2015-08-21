From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 01/10] grep: allow -F -i combination
Date: Fri, 21 Aug 2015 19:47:11 +0700
Message-ID: <1440161240-28554-2-git-send-email-pclouds@gmail.com>
References: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
 <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 14:58:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSltx-0003nk-FU
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 14:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbbHUM6Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 08:58:24 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35243 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbbHUM6X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 08:58:23 -0400
Received: by pacdd16 with SMTP id dd16so44128720pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VrHPehr4Ext1uf6eBIOLoPGMMdkktTF9sYiMqDUOuiY=;
        b=wTz5CgoYycO+txFFZwNlNl+LYMTANcK1UGR98zm2GT+cSYWX3vsBXeTBlqSThWI0VK
         yZNjkngRt6uYG5FEFsGoN2caxfxRw1z9IpmEfJwpiphfWy2DeL+cbAVkHlhSv4DTA273
         ERi8zIFCOhRDefp7lk+tioWnWKYupOaYw9LpU3QjK+BMlvcAQvw+SqQz3mrAXWMtcohK
         p5EFS/B8vNakh2MGtsp7JGo7NciJthfhoZXsQrZKfyOeRSEAYTdK2hsAXPupb0oipj3t
         7+kXvvGMC/u2xeYt1jstpRoq9V4Q5IqxDA0Y7GflxHuIzpGibGD9ivibtFmQ4cBCFydj
         teJw==
X-Received: by 10.68.111.228 with SMTP id il4mr17314109pbb.44.1440161902853;
        Fri, 21 Aug 2015 05:58:22 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id hg3sm7795922pbb.52.2015.08.21.05.58.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 05:58:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Aug 2015 19:58:19 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276290>

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
