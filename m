From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/25] worktree.c: use is_dot_or_dotdot()
Date: Wed, 13 Apr 2016 20:15:32 +0700
Message-ID: <1460553346-12985-12-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKf6-0004IG-Ey
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760650AbcDMNQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:48 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32769 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760633AbcDMNQr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:47 -0400
Received: by mail-pa0-f68.google.com with SMTP id vv3so3900808pab.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86a5GqvTvlff3veWdkEQr/3kOeOruktylhsGu5yPmuk=;
        b=jJsFQYytzaD0Tjnpg4SIWi95QXaq9WaVHZf3dLOGNi36Gzun4GnxgwtpHsrw3fbS/e
         VFFyb/0OJ8gq643R8mGL5uxkkUKvyw3gB2u7aHFLDMWqmvEc2WXktzVKNfLpBRHxsY/J
         KT3VGXEYIQ3/tQqKFMymUfknIZpBEQdpdbdBZpdlsr2FTlZuw4Mqej/ef6IOc/uzDhT8
         H/d8YuI8y4NH3kAkgwjHxONdgObj8ECrsdYp90a6JOGpBexThL0cyT9+3iCkxH+a20NB
         jkmErZHPK4rrRtwK3SwBABIBwzgBH+QrgHIk3yRe30rX5TWBH5VZi+p+R1faNYa90jhl
         6beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86a5GqvTvlff3veWdkEQr/3kOeOruktylhsGu5yPmuk=;
        b=ctw5N7ZaDPZUiMe/f42d/SC/ZMv1MhGH5uARKhI2hRGMxN4J8LSrPiPW4lWlMNqzY4
         Qun/T/utr9CZW+BRe4NOcTwRruOhfVbydW+k9vZniooS4dRzpG4oKPP1IXJGQFpgEn3r
         mvVNx4q6y5U9i61iO0GEg9iEqS6kSrrx4KZWJzo6SF1q6eucYvyy/xZMActXqk8ggIi5
         WoRvbfTWoto1S2lBDbbHZPKMJr1/n34ee2TT6fSvH8dfjjn5o1nNy+nfmVYx/KSvGDqm
         /1xuAZAFsUeEdkp5sVoQf83Ib/JNdPo05+VZNoExMAkia1v0AQRy/fVV8G2HenVuRJJe
         e8hQ==
X-Gm-Message-State: AOPr4FV3/bYSo+6eOD2RCiWfhzRCxW6EDa72muFCJBF0rTbatu3oKd/aHWxu2jXYzaZeYw==
X-Received: by 10.67.14.98 with SMTP id ff2mr12790834pad.105.1460553407077;
        Wed, 13 Apr 2016 06:16:47 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id 88sm51207830pfj.20.2016.04.13.06.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:53 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291431>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 worktree.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 575f899..7ff66fa 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -94,7 +94,7 @@ static void prune_worktrees(void)
 	if (!dir)
 		return;
 	while ((d =3D readdir(dir)) !=3D NULL) {
-		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
 		if (!prune_worktree(d->d_name, &reason))
diff --git a/worktree.c b/worktree.c
index 6181a66..ddb8cb7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
+#include "dir.h"
=20
 void free_worktrees(struct worktree **worktrees)
 {
@@ -173,7 +174,7 @@ struct worktree **get_worktrees(void)
 	if (dir) {
 		while ((d =3D readdir(dir)) !=3D NULL) {
 			struct worktree *linked =3D NULL;
-			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			if (is_dot_or_dotdot(d->d_name))
 				continue;
=20
 			if ((linked =3D get_linked_worktree(d->d_name))) {
--=20
2.8.0.rc0.210.gd302cd2
