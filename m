From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/9] grep: allow -F -i combination
Date: Tue, 14 Jul 2015 20:24:32 +0700
Message-ID: <1436880280-18194-2-git-send-email-pclouds@gmail.com>
References: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
 <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 15:24:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF0Bu-0006IB-Gh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 15:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbbGNNYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 09:24:05 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33987 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbGNNYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 09:24:04 -0400
Received: by pacan13 with SMTP id an13so5913266pac.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VrHPehr4Ext1uf6eBIOLoPGMMdkktTF9sYiMqDUOuiY=;
        b=XB8/HydT01xPMhCij8xtboEgGcMFUHjmPMvCFDelRYXDGMslke2mUvi+ogKH2t+G7/
         aTo9xlljFmrsrABXvgF00R6L6WQ3fHJjIeFFm8lhJNtMgEm8R4iXuVkeeoh56PHsZC1A
         SlDeRob7h0R+GpCxzAUd8wI1z2Dc7GY3e2LN95c5p5aAlHuLnRy0oOA+8x8LUsav2YYm
         YVxFIXjJdowNAkpRn/0fz3bCt2kvSZFDdfZdZFe5Xkore6DoAZ2WW7yeRth4EUIHM1m0
         nCSu/4TDR37zIwofuRuUAA2Zrxwdv6bgzfzqKoV/8IM/6s91JLxyltmWjqkH1jUCHnx5
         kAuQ==
X-Received: by 10.68.238.39 with SMTP id vh7mr80924591pbc.12.1436880243944;
        Tue, 14 Jul 2015 06:24:03 -0700 (PDT)
Received: from lanh ([115.73.59.196])
        by smtp.gmail.com with ESMTPSA id sh2sm1397614pbc.62.2015.07.14.06.23.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:24:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 14 Jul 2015 20:24:53 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273953>

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
