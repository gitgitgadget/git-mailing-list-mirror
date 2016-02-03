From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/20] worktree.c: add is_main_worktree()
Date: Wed,  3 Feb 2016 16:35:40 +0700
Message-ID: <1454492150-10628-11-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtru-0005wT-DT
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbcBCJgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:53 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34365 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbcBCJgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:50 -0500
Received: by mail-pf0-f172.google.com with SMTP id o185so11070936pfb.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bImtPBBuFIHPpZG+WQ2e+lBjTTU4Y7VITKKnkFRVG6w=;
        b=GO5wrlbem/VclNPlYi9txcvXgPBDUnyyKCCn49bM+Z6rMBJBnoK1gseGBJVUm6OAKr
         Pa0OqBK3CzEJKn06yEGaTg+IvVpeCuGqJtLY76QBds7qialVDL/H9OerTAXQENJkYJ1r
         3XdqdRhyFtoqa6CUjCSRnU8lpMJGA3hHxMVwfL4cn0SP62mIreEGkfkhxOHF7NFibree
         bVuknlkBTeILzSeI02UoN4waxZIKGjDNARV0E6EfCbfz1RWXMgSXKXd2QOxzkTgZOHyr
         5GOBgtfIrgwxg4scQYE8pYFY3E/Jn+mfgMXkN/d1bNNA3po/qKPWujgn0KXX+8US2Ri4
         NfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=bImtPBBuFIHPpZG+WQ2e+lBjTTU4Y7VITKKnkFRVG6w=;
        b=CoHEiWP00YTZsZYigP9/6step606zn2JJOjcVmXOyRxBnqZaGtkHqQ0YibPZmaZ4Pt
         07kf/LmZUSY6utC51Y7QxZSubQKIW/WLOEwSFHFgstmfXW6A++lsoI1/h+5+6VbHQpUw
         OAcAYXXFfhEKpYzsjmC4F9kcbdudLz03jPULrVuSRY1ueTMlSdhjkOjVfQmHvKuW+y2t
         bFxGPRkhHpIkuQNHix+bxijRxDK520WxBjBz1ycmX2o8c97pPLuEmL0hRAG12UzNM4TV
         UB7KkPkPlwrp2ReQmTAAygNn8o4h8im1xFi5F+07if70OtzqWb7HLE1QtyjdaWPTJKvG
         AkSA==
X-Gm-Message-State: AG10YOSx6isQE3v4EY83WxiIidlUSsDNs8L1lZGOYf8Bc4mroij+5fUahZ+GDK3UJWtJIQ==
X-Received: by 10.98.8.153 with SMTP id 25mr703565pfi.51.1454492209664;
        Wed, 03 Feb 2016 01:36:49 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id xz6sm8290116pab.42.2016.02.03.01.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:01 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285354>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 5 +++++
 worktree.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/worktree.c b/worktree.c
index e444ad1..e878f49 100644
--- a/worktree.c
+++ b/worktree.c
@@ -214,6 +214,11 @@ struct worktree *find_worktree_by_path(struct work=
tree **list,
 	return wt;
 }
=20
+int is_main_worktree(const struct worktree *wt)
+{
+	return wt && !wt->id;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index c163b6b..c7a4d20 100644
--- a/worktree.h
+++ b/worktree.h
@@ -34,6 +34,11 @@ extern struct worktree *find_worktree_by_path(struct=
 worktree **list,
 					      const char *path_);
=20
 /*
+ * Return true if the given worktree is the main one.
+ */
+extern int is_main_worktree(const struct worktree *wt);
+
+/*
  * Free up the memory for worktree
  */
 extern void clear_worktree(struct worktree *);
--=20
2.7.0.377.g4cd97dd
