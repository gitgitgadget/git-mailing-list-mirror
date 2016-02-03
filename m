From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/20] worktree.c: add update_worktree_location()
Date: Wed,  3 Feb 2016 16:35:42 +0700
Message-ID: <1454492150-10628-13-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQts5-00060Z-28
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbcBCJhF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:37:05 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35435 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbcBCJhB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:37:01 -0500
Received: by mail-pf0-f170.google.com with SMTP id 65so11063846pfd.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=omaF+rE5+Xi1S7XwAX2uhPo5YrBxUBQnPWT07HkgiT8=;
        b=izK3+4UDXTPuwo4oXBij38Wj0X0XJBKf7LSXfYmzWF1hCfh8Fe7++NDV3pqdC2gowT
         ceQi1q4fUqzPKA/CSoIflHfEvHcqAOC2VvYbhBcK2cUyesdAEb1sRT/hqAcbqKB+NGxP
         UiMQKm3MLD7kJime8hciFxBRXYwNbYF4j7otIcScC2UiMjIBhsblwIaGnfK+Rbq9hlK1
         fjjFwYW6LC2ghx+IX4yzIq4o6mc4AmZGxIsmHUW5bQaqZ9B5+dbWwwPq9YXcXQl0+ove
         XxpUCHtb/7se067m8PGmzAKsbWz5U76+SzyC+/xwXoujsacmJJ7TCF/WyRrlA5IboTBo
         ElPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=omaF+rE5+Xi1S7XwAX2uhPo5YrBxUBQnPWT07HkgiT8=;
        b=U+m9y/Z+4rlgcMpkAnjUHpc7SWhXwTKnoUsEZD9QXNzEUCodimWRlaRJOi/ys0NQ3K
         6uAYLzyHClR081o19ySoNKs0Izeb4I9ZWG14ogojZyJw/3vKw037zeIOUrB/28vaoDv3
         m+21JG2fol3MUT4IAF1pEBNGIhU+SZFf/CYZ5vk4k3xAESq8gdN4/Z9E/kvrCi7pC0xB
         RtJ07D/f8mY69ZNoswpwSHwWXX3uZG//DmCCwjXcO6C70Vfgb1HPes2zU8UsZF8CZy5v
         fFFbFKb8pfyDUYEewPu5j46oaM6ptowchOX7d9noUlze5kQU8VVfJ6N0zZVVU5TdLnud
         8kAw==
X-Gm-Message-State: AG10YOT91YnYLeQbGXyQfQBU6uhGIvW+v6ehie4SBSs9U4qvTIspwKTbPlKasLpBMa0k/g==
X-Received: by 10.98.86.8 with SMTP id k8mr760027pfb.28.1454492220689;
        Wed, 03 Feb 2016 01:37:00 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id ud8sm1431717pac.11.2016.02.03.01.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:12 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285355>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 23 +++++++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/worktree.c b/worktree.c
index 80c525b..a11c053 100644
--- a/worktree.c
+++ b/worktree.c
@@ -221,6 +221,29 @@ int is_main_worktree(const struct worktree *wt)
 	return wt && !wt->id;
 }
=20
+int update_worktree_location(struct worktree *wt, const char *path_)
+{
+	struct strbuf path =3D STRBUF_INIT;
+	int ret;
+
+	if (is_main_worktree(wt))
+		return 0;
+
+	strbuf_add_absolute_path(&path, path_);
+	if (strcmp_icase(wt->path, path.buf)) {
+		if (!write_file_gently(git_common_path("worktrees/%s/gitdir", wt->id=
),
+				       "%s/.git", path.buf)) {
+			free(wt->path);
+			wt->path =3D strbuf_detach(&path, NULL);
+			ret =3D 0;
+		} else
+			ret =3D sys_error(_("failed to update '%s' for update"),
+					git_common_path("worktrees/%s/gitdir", wt->id));
+	}
+	strbuf_release(&path);
+	return ret;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index c7a4d20..4c0395a 100644
--- a/worktree.h
+++ b/worktree.h
@@ -39,6 +39,12 @@ extern struct worktree *find_worktree_by_path(struct=
 worktree **list,
 extern int is_main_worktree(const struct worktree *wt);
=20
 /*
+ * Update worktrees/xxx/gitdir with the new path.
+ */
+extern int update_worktree_location(struct worktree *wt,
+				    const char *path_);
+
+/*
  * Free up the memory for worktree
  */
 extern void clear_worktree(struct worktree *);
--=20
2.7.0.377.g4cd97dd
