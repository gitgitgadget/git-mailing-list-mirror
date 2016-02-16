From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/26] worktree.c: add is_main_worktree()
Date: Tue, 16 Feb 2016 20:29:17 +0700
Message-ID: <1455629367-26193-17-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiV-0003Sz-BY
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbcBPNaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:30:52 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36264 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391AbcBPNat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:30:49 -0500
Received: by mail-pa0-f46.google.com with SMTP id yy13so103488513pab.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bImtPBBuFIHPpZG+WQ2e+lBjTTU4Y7VITKKnkFRVG6w=;
        b=Wa8QVPDRRdpypZinfl6i9LZJCsgi0fYdS2BnxlaosAkWQyBW5f4nS6XM8eN9QYbQDs
         2u3c+zYqN6wk8CbXfS8q7wx12Xcg2ZdP1c1d496stv1YSERkD7oCXDq4BgAKIcF6mHOz
         mYX0A8e4A3QN/fUqvyA713xcJVlfeS217STheaiLGHW7Wq8ciZEJS+H8WAcjX5kRtq7z
         vlAaIqv9DI/Sr1kykmx06H/bVULXsEm1cBTPpCjazFZcNT7FVCmmij5KIihfJrSaD10X
         9Y8lfg3VaVriQRZfCp7sP7Cs11bUxUEvSnZVqvGyVpcuwlnqwWFQb06iRBJG0EFCyRi3
         JPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=bImtPBBuFIHPpZG+WQ2e+lBjTTU4Y7VITKKnkFRVG6w=;
        b=nFSH0YQCMH0GuJSnvUQSo9tGJ63JCQCholG9VxHDozbhZJKidLOD1m5jUQ6TAmfXhn
         MSxfy6wI+3ggsJFOC/Ih6Pf5eG8R4W0WbwO/fSlAn5dt4P18d49H9i62twAtM7XuM+ny
         P290+Im7RFem05fwMntRzpInI239w89rmgy5gqD5BBBL9hOXfwyIx/uB+3Rlfx1K/DW3
         7NqKXHKtwQYMcXjXZhOjbgIVeAnu52apvbfREGV8JiGajyrWhGl5fXvT+wgkNbUAChPp
         C6/4UwlfZ4371+aCfVy7O9es1a5nhL2lEABDJbPUnMTWdLLAGo/5dQX2qIL9UXVJZ1ET
         +djQ==
X-Gm-Message-State: AG10YORRbmeoXGmU8YW9pWBsrqy38vtD+HdQkKP0rP5oJWk9sN3zxsAAwIjGKsexkDqnBw==
X-Received: by 10.66.145.68 with SMTP id ss4mr31007884pab.79.1455629449406;
        Tue, 16 Feb 2016 05:30:49 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id ey2sm46062057pab.2.2016.02.16.05.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:12 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286383>

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
