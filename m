From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] worktree.c: add clear_worktree()
Date: Tue, 10 May 2016 21:15:51 +0700
Message-ID: <20160510141553.22967-5-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160510141553.22967-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:17:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08TZ-0008TU-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbcEJOQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:16:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33821 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbcEJOQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:16:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so1074945pfz.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=muFtWTWLVjEqJlY9EuyGg2HrfNFbwsboNkmPTiBz5/o=;
        b=w2XVxF0Z5ZHA4tvN2oU8612shomOVh7vwAoWvPZmWCn+sq6ZF4JGqhtZ05HJpiA70+
         Qxpk6MY3ZreOkgCi8fAR5IlrkxZXLp7l9ZM/YkuXNuq5/Z6uvRy3r1FmN7ibzgUqqWdU
         pu4JKsDfXP5C/uTtCIABHKcI45/Op8JffTwoUFT+Tv4A43NU48q3gD+4Myko5wQq3Iog
         56U0xDMQinwkdiPvrPbbUaVtAYyXDnOB7fLAJ2ZEArHVzXOABN0PS9rkesy6jewj17qA
         E41SraTYoR3iqj0A5KWdZdxOpadDIFcBJZ8md62+lNrCgnwMcVU0LpU1apLCrgA6cuAS
         xo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=muFtWTWLVjEqJlY9EuyGg2HrfNFbwsboNkmPTiBz5/o=;
        b=U8ASwG6QfazA/8kmx/Zpv0W15hwbrvaBenbG1E6AgogGYyih2eTqRXqNEQrpNRZW/v
         My556IdUD2m9hIGMfD0Swa72CLWRe3fP1fo0dOUc4nsql9h2/d6HTjyDxMgjJXE6/73k
         DUxfdBNHiGavRT6TAI0u2BZzwv2yQNibKfAzxLPbchar+L3AYESOTxchatBHBn9pRoph
         dvqriaItYhdeYK7FmAYXry+gn5mp7nBtDBjPc14Vr4Ccb6+ca9YvhR++L4eICWu3rwr0
         4KMdIvptHfo1X1Kh61/E9R0YHx0RtlkLUHctvMerY3zVhqSpEJ/yBAqsMJQvFAISauXA
         og7Q==
X-Gm-Message-State: AOPr4FWP0j+nTLW07iY4yNhQPEsX9YPJyg5gic6PSjc1fVNFehehw3iWRg0nGmOIUmgyXA==
X-Received: by 10.98.84.2 with SMTP id i2mr58867406pfb.55.1462889804127;
        Tue, 10 May 2016 07:16:44 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id c2sm4985799pfc.40.2016.05.10.07.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:16:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:16:46 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141553.22967-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294142>

The use case is keep some worktree and discard the rest of the worktree
list.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 14 +++++++++++---
 worktree.h |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/worktree.c b/worktree.c
index f4a4f38..335c58f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,14 +5,22 @@
 #include "dir.h"
 #include "wt-status.h"
=20
+void clear_worktree(struct worktree *wt)
+{
+	if (!wt)
+		return;
+	free(wt->path);
+	free(wt->id);
+	free(wt->head_ref);
+	memset(wt, 0, sizeof(*wt));
+}
+
 void free_worktrees(struct worktree **worktrees)
 {
 	int i =3D 0;
=20
 	for (i =3D 0; worktrees[i]; i++) {
-		free(worktrees[i]->path);
-		free(worktrees[i]->id);
-		free(worktrees[i]->head_ref);
+		clear_worktree(worktrees[i]);
 		free(worktrees[i]);
 	}
 	free (worktrees);
diff --git a/worktree.h b/worktree.h
index 1394909..7430a4e 100644
--- a/worktree.h
+++ b/worktree.h
@@ -29,6 +29,11 @@ extern struct worktree **get_worktrees(void);
  */
 extern const char *get_worktree_git_dir(const struct worktree *wt);
=20
+/*
+ * Free up the memory for worktree
+ */
+extern void clear_worktree(struct worktree *);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.8.2.524.g6ff3d78
