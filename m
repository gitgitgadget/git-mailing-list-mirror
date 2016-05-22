From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/5] worktree.c: add find_worktree_by_path()
Date: Sun, 22 May 2016 17:43:37 +0700
Message-ID: <20160522104341.656-2-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160522104341.656-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 12:44:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Qrr-0001ot-Go
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 12:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbcEVKoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 06:44:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34764 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbcEVKoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 06:44:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so15924634pfz.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6yPKs1K+16dTGFP5xKuZKKQ5TiIOVB72bOhQkC+lPtk=;
        b=HWYYY2uTTbmJGNwe1L+FMS8zvNBOHxnTzwq6fYpDiXwh4GnyZRb2QKY52wTY9S5hOx
         fNJVrFSjvtkpKZ06Xr+dox0iOP93+P2gySMSXkvuWETE8o9/q7C+cfTqrUB2eq+7s3GA
         F/ZCjf0lYjcjwXy6rU+p/hCnFBGMXUBmpdjVQIXAYhX5Ed8cHllXq0LBFL3033XdVvZb
         UHcJgVMYklqw7uwAOtARSv04Vt2ElWEG9mlcq+WFUM/u//+S7hd7U6FpGY3W4sp/cHqL
         QWYR8ZSb3UAJAdKTUFENtq0z25evlhRfqme/S8TrEJvHWMxZuFCMzwzgX4GxdqDT0f/M
         /vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6yPKs1K+16dTGFP5xKuZKKQ5TiIOVB72bOhQkC+lPtk=;
        b=l1WTy5QKLe4MRgiq+GizrxIqi5WweZVKlG2iuhChZxSu/6YjazA4mTAth63UaD43B4
         QTAVCBZn6WQwMMg5o346bf1a+UgLis0VIUBLQdG0zmK6Rko93Nw3NH0AqBrZvsn148w3
         IgacibtrvMyz01AknWkptk1201ibL4s8sZqzup8auHbgn+kH7DWfPRPI5lMX81+LkUrP
         KBjEfKjznV+SZxku2qIxVf9rB8yEBNmI8c9vFmsRxVnnT3O6D3+E0E1DrkTGIh0Lu7G0
         U8d4UzZ9GpKhvfFumcjDK5bkdbHzP5dykiXqpvN8AlkgJzP+ZF3/bSGbNKEC20z1wGUi
         qA4g==
X-Gm-Message-State: AOPr4FU57Fjh3kCZgX47SQu61DW0AeQjCbU3vAiGAz/IUJPr8UuGb1j+YwKsmeKwyEV5/g==
X-Received: by 10.98.75.154 with SMTP id d26mr18775244pfj.72.1463913853594;
        Sun, 22 May 2016 03:44:13 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id f187sm38992607pfb.60.2016.05.22.03.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 03:44:12 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 17:44:08 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522104341.656-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295271>

So far we haven't needed to identify an existing worktree from command
line. Future commands such as lock or move will need it. There are of
course other options for identifying a worktree, for example by branch
or even by internal id. They may be added later if proved useful.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 12 ++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/worktree.c b/worktree.c
index f4a4f38..c5d45a6 100644
--- a/worktree.c
+++ b/worktree.c
@@ -214,6 +214,18 @@ const char *get_worktree_git_dir(const struct work=
tree *wt)
 		return git_common_path("worktrees/%s", wt->id);
 }
=20
+struct worktree *find_worktree_by_path(struct worktree **list,
+				       const char *path_)
+{
+	char *path =3D xstrdup(real_path(path_));
+
+	for (; *list; list++)
+		if (!fspathcmp(path, real_path((*list)->path)))
+			break;
+	free(path);
+	return *list;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 1394909..91627fd 100644
--- a/worktree.h
+++ b/worktree.h
@@ -29,6 +29,12 @@ extern struct worktree **get_worktrees(void);
  */
 extern const char *get_worktree_git_dir(const struct worktree *wt);
=20
+/*
+ * Search a worktree by its path. Paths are normalized internally.
+ */
+extern struct worktree *find_worktree_by_path(struct worktree **list,
+					      const char *path_);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.8.2.524.g6ff3d78
