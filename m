From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/26] worktree.c: add find_worktree_by_path()
Date: Tue, 16 Feb 2016 20:29:16 +0700
Message-ID: <1455629367-26193-16-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiM-0003Ac-1q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbcBPNaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:30:46 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34367 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbcBPNao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:30:44 -0500
Received: by mail-pa0-f48.google.com with SMTP id fy10so64108896pac.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qtq4+Y2fp6R3nuQ331g4y1HMLVqPkccGAgunpUh08fM=;
        b=x90UgMVcdrLXCt9+nbjZm3X+9A5/ZdidQppVDMCZN0G6ueg3MhrLqU0NvfAoizFHY3
         dKE6rtOG4ipCTDejYNXbnB85byimTMiIRfEgMn1lsAIukRkN5eJ4AtOLGswi6Ew4aCj1
         1RJTFTgSTDlA9oUdK7jYTrueOAMheE+QYFIANZca4/+yvi/OyLifjIHKPr9IJrOdGL8A
         BZHZ/8tyjNvOdSxXTr9Y60PvRFTJyQhWev6sPGaHu/rv+8RZ8KB93ZvREYwfzPAVGQ6M
         UqkadGN7Jzle1lOpKbRgImU3TtjccHQQuIRerVaXc/9quu0+Pwk9Mf6A/oKjRniBVO7k
         ZWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=qtq4+Y2fp6R3nuQ331g4y1HMLVqPkccGAgunpUh08fM=;
        b=iKICT+VdR55MyXzLpJ7s2BeP2FRz61MJoc2TT6LyoHyFbXP4aUaZ2oEAc6rqez318l
         8jc9tzpE/nb+9DZBQhEQd0PrWgDKffoDQH6r3JT6M+8tievp6xyIy55EQdA/3LpiUBm1
         jeeG3ybEyubmBMdShkBBbNeJ7fukYzSgrds7fM1TIQmetNp2YK4W2VwunvbtNHPOfDTg
         fnWtEfVujh7XO8XlI/24jz0M1UM0jaKJfuXpvj8MywehTfUKSJh5a5mrWNgdUVhVHjBo
         KopSfVQa7qjtMzN4LiVgDk9GKBtdd5afZD+sgQZjsWK9YF0m1FHNaOUdJTRzoaiPxulM
         J1+w==
X-Gm-Message-State: AG10YOScJdekv+wiPkfhYpwYN/sgBXEa0y9xAvahAh3NWuwAb4Q45We4l1UdwJcpIu/iFw==
X-Received: by 10.66.167.237 with SMTP id zr13mr439170pab.85.1455629443904;
        Tue, 16 Feb 2016 05:30:43 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id n78sm45977897pfb.53.2016.02.16.05.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:06 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286381>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 16 ++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/worktree.c b/worktree.c
index b4e4b57..e444ad1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -198,6 +198,22 @@ const char *get_worktree_git_dir(const struct work=
tree *wt)
 		return get_git_common_dir();
 }
=20
+struct worktree *find_worktree_by_path(struct worktree **list,
+				       const char *path_)
+{
+	char *path =3D xstrdup(real_path(path_));
+	struct worktree *wt =3D NULL;
+
+	while (*list) {
+		wt =3D *list++;
+		if (!strcmp_icase(path, real_path(wt->path)))
+			break;
+		wt =3D NULL;
+	}
+	free(path);
+	return wt;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index 0ba07ab..c163b6b 100644
--- a/worktree.h
+++ b/worktree.h
@@ -28,6 +28,12 @@ extern struct worktree **get_worktrees(void);
 extern const char *get_worktree_git_dir(const struct worktree *wt);
=20
 /*
+ * Search a worktree by its path. Paths are normalized internally.
+ */
+extern struct worktree *find_worktree_by_path(struct worktree **list,
+					      const char *path_);
+
+/*
  * Free up the memory for worktree
  */
 extern void clear_worktree(struct worktree *);
--=20
2.7.0.377.g4cd97dd
