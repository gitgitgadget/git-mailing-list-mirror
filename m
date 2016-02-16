From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/26] worktree.c: add clear_worktree()
Date: Tue, 16 Feb 2016 20:29:15 +0700
Message-ID: <1455629367-26193-15-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjX-0004Ji-UG
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbcBPNby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:54 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33280 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932220AbcBPNai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:30:38 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so105333294pfb.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0C1rAbxrOqcX/Idy3O9tBS872gz8sOx58byfXT0xg4c=;
        b=oldLCKMKYu+yTHiSg9MAG9eAnxp/4eSWIkBs/xWDK13QTh/KGlRXGAlKKYqQvwUwV2
         Eha3yVA6od9Wf9pi68ntjWszQaOFrppluhkPtk6TbLzjRJOvL6M4RarJ7Y7J4+W/Gmys
         pFZ9PCmiH+AhrdGPaGSx6vclGX7azIZ3d9FOc+V7o0YWA7hCPaeZ9fv9LC7VAMRkiuDB
         ST9Wsxn4R0JFL/bVAHRGiYBWpycPEizyeMs1Uk/SJ+Ckpr35qyEyVt2LkJcTHwz/vSEB
         r5Pm1M4ZGbr41gPvBU7AXxvct0VgFLLddobE3jr0MTGIFpqfmp86F47KU/p2tCWDiY4z
         ejig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=0C1rAbxrOqcX/Idy3O9tBS872gz8sOx58byfXT0xg4c=;
        b=DrATLTW+xu6Nt6qRrqYZIJe5kNfHanOCLNPxSUPt0WHkY+dV7eDetE166Ai+VVrasV
         8N4UiRXpUAqt0IUoO+8xyhh74dUYXne1/i+pPvHoALG5HVgHABgOtRy3UMTNGi46aW5j
         W4n2/me3qFOXgr7Gn3jN3RINhen/dnU3aubMcrRWfrfuY0xPfPQ+kPwHxB2eK/TIC5kF
         nHrG7gYFsEGrXzn4p2DQHaf6bXqThLncb5UBd+u/+oBt3DTetarfMdiJHqEdOUORTTEE
         6G/MJYjM4JJagMfCvGYcyVuDk4V7+PJRKyZQDd6cJrJqLehWXFGCj23MbH8WO2t3GOlg
         oPsw==
X-Gm-Message-State: AG10YORlIUg6O5yH31pwtn/OpIGaCcl0RQDrEfsdbk+0e5aANSNjam6YebMhU3pjQK+O7Q==
X-Received: by 10.98.31.221 with SMTP id l90mr31162357pfj.92.1455629437836;
        Tue, 16 Feb 2016 05:30:37 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id cf6sm46053260pad.41.2016.02.16.05.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:01 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286395>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 14 +++++++++++---
 worktree.h |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/worktree.c b/worktree.c
index 4c38414..b4e4b57 100644
--- a/worktree.c
+++ b/worktree.c
@@ -4,14 +4,22 @@
 #include "worktree.h"
 #include "dir.h"
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
index e89d423..0ba07ab 100644
--- a/worktree.h
+++ b/worktree.h
@@ -28,6 +28,11 @@ extern struct worktree **get_worktrees(void);
 extern const char *get_worktree_git_dir(const struct worktree *wt);
=20
 /*
+ * Free up the memory for worktree
+ */
+extern void clear_worktree(struct worktree *);
+
+/*
  * Free up the memory for worktree(s)
  */
 extern void free_worktrees(struct worktree **);
--=20
2.7.0.377.g4cd97dd
