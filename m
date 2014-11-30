From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] ls-tree: disable negative pathspec because it's not supported
Date: Sun, 30 Nov 2014 16:05:02 +0700
Message-ID: <1417338302-8208-4-git-send-email-pclouds@gmail.com>
References: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 10:05:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0Rr-0006FB-Sm
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 10:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbaK3JFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 04:05:37 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47810 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbaK3JFd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 04:05:33 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so8933647pde.19
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 01:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=geOcaPPunXC6NzjkpWwvUKFfilHVRKZBROxcHYTyhq4=;
        b=lSv7pOrA52M7divgHoky5J0dNSMTiYby6Np/SCjeIikigHRXkw/vs4KbYy06CP/Mm8
         vOfVkmb2uOKl66Hu/2lIrTp53tmfXybJWRG1Wl+j+79CVQ9wEjlrG+/OCtiF11+LatcJ
         z4gSi5A7no58SN2zvE6d7DpiP1SuhNTCC865nNMdViiqMr5GiG5xVEkSu39rMk/bPF3n
         yyjs76J4WxB1xcfNeZ2ZCUBRAOvrJm1t/3eLcs42C2yuyj0wW5mEt2CP0fwFuOawRFTC
         jaEQVZXBhbuBBGIbB/32rPx/0x+TkgehpcOIhp/zRUgsJxJR04C7hRc1zeeC5BmeCsLr
         pD+A==
X-Received: by 10.67.22.162 with SMTP id ht2mr70831836pad.49.1417338333289;
        Sun, 30 Nov 2014 01:05:33 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ml5sm14467080pab.32.2014.11.30.01.05.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 01:05:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 16:05:30 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260446>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 053edb2..3b04a0f 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -174,7 +174,8 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE,
+	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE |
+				  PATHSPEC_EXCLUDE,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
--=20
2.2.0.60.gb7b3c64
