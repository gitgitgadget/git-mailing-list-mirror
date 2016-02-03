From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/20] worktree.c: add update_worktree_gitfile()
Date: Wed,  3 Feb 2016 16:35:43 +0700
Message-ID: <1454492150-10628-14-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtsG-0006DW-RG
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbcBCJhL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:37:11 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35488 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbcBCJhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:37:07 -0500
Received: by mail-pf0-f177.google.com with SMTP id 65so11065273pfd.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TOVm/SJseX/MqJKEsmcLvrVMS9lvpDw4pP6qDc29aQs=;
        b=MMCnNz6w9GetMGFtpatuh8LGx/gUFFDh65rYCxSq6PQMKOaKmFvEwbWIFFmqZSKFKV
         /35Pv9oNJfn6P8ZIyCkKUhCbCd2USX23OHqUKJ5KiBuM2zFCbs6xgRB5TyYL+bIfhw/p
         Xt1LbgrEjXiHa4/nibBEtz5pYNBH+iBrLOPbkLAdLKhlE7r+x/F4z6KugBIOQK/Z7pNC
         +bWnwnMScwYtyrXO69a9wyZRRbwVJ0L/dPlZGeUzsTtWjoi/FBucV2P4TomAgyfjRl+9
         bhPUTNPTc6ID/QIOtcVK4UfrW5KfxWeisrfxyfm84UBKOk3vb89EcRBc4WrC/RNPMH3H
         a6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=TOVm/SJseX/MqJKEsmcLvrVMS9lvpDw4pP6qDc29aQs=;
        b=QUPotWCG6It/O7WVZf776vGGkHlZUw4ylZ2SY9alVsfV+BULiz1lZ21doSk5QNv9nu
         Q+j63Wk4Z8Q354R/EPY9pZF0QHcHVGvGi8YCeQjx0iW1gWz+xO0Q4SyfNXxaOyV3g04T
         L+kj3xJdfKo7Dd5LpMuiR5niRaVK2jnFifM15l4EbmLdpEeWp0QUjOrmsoahKc7nDKPf
         9TqcYhaL3RzqhOvfHUpVAbKB0wlpQf66MgLEsNgW/6gPdMLkoaPZ1cMogiM0NVxmUDGa
         saQG+v9P7u9wH7Sp+umj4zSrAFbBYI+BIMEANgHkLqaSjKbi+jgRoNTRUqbf404WfPnf
         ms1Q==
X-Gm-Message-State: AG10YOSsPQel523Jk7UmvAB+GnqZBdcSOoJC+LT8zscpYcXXTetdyC4UicwuA8Q+uD3/NA==
X-Received: by 10.98.93.27 with SMTP id r27mr691601pfb.57.1454492226603;
        Wed, 03 Feb 2016 01:37:06 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id q16sm8333178pfi.80.2016.02.03.01.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:37:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:17 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285357>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 15 ++++++++++++++-
 worktree.h |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index a11c053..d4513b1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -237,13 +237,26 @@ int update_worktree_location(struct worktree *wt,=
 const char *path_)
 			wt->path =3D strbuf_detach(&path, NULL);
 			ret =3D 0;
 		} else
-			ret =3D sys_error(_("failed to update '%s' for update"),
+			ret =3D sys_error(_("failed to update '%s'"),
 					git_common_path("worktrees/%s/gitdir", wt->id));
 	}
 	strbuf_release(&path);
 	return ret;
 }
=20
+int update_worktree_gitfile(const char *gitfile,
+			    const char *repo_path,
+			    const char *id)
+{
+	if (!id)
+		return error(_("cannot update .git of main worktree"));
+
+	if (write_file_gently(gitfile, "gitdir: %s/worktrees/%s", real_path(r=
epo_path), id))
+		return sys_error(_("failed to update '%s'"), gitfile);
+
+	return 0;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index 4c0395a..55f3449 100644
--- a/worktree.h
+++ b/worktree.h
@@ -45,6 +45,13 @@ extern int update_worktree_location(struct worktree =
*wt,
 				    const char *path_);
=20
 /*
+ * Update .git file to point to the new repository's location.
+ */
+extern int update_worktree_gitfile(const char *gitfile,
+				   const char *repo_path,
+				   const char *id);
+
+/*
  * Free up the memory for worktree
  */
 extern void clear_worktree(struct worktree *);
--=20
2.7.0.377.g4cd97dd
