From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 18/26] worktree.c: add update_worktree_location()
Date: Tue, 16 Feb 2016 20:29:19 +0700
Message-ID: <1455629367-26193-19-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjQ-00049f-DB
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbcBPNbx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:53 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35366 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392AbcBPNbB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:31:01 -0500
Received: by mail-pa0-f52.google.com with SMTP id ho8so104963391pac.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sBX29HgXPSSX0CF3gDWVjOIoe/el61AY4SL0jYy5wxc=;
        b=ildimYnfUrk2/Yf1ADHqkqRXyC94Tz4dCdag9lWHWyb1bk8BGKoMNhM8Ba5VwPM8wT
         KL3+rz1R6O7uBeCVqByv0MZoP/lFfSXjVvHaLRhvXnMUTXBPfUIloMvK6WKKviEcgz6M
         5EO28J+M5o38l8VUC4RiIrPAelHkJGk/OJEIq5i3ccDhEf+FcVPl5355yBgpHpZHjzRK
         5Fi1DUyWR2F+B8yDKnhYJHVETWPxAUi1dwC9A6RRdFvFTxh6bdxhr/uh9ZZ9UVHVT+Mw
         vjcynt+ZCXTiWmuHJnsjv+XHKmGdb7uRbkVl644Da1UKQnjWwCrURsKExBySWXd0H3Vh
         W0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=sBX29HgXPSSX0CF3gDWVjOIoe/el61AY4SL0jYy5wxc=;
        b=UIqM5lGycrAccevT5KGM7Z02akuDcW2717olIBityFhY2k8zn85X+15eGU7wdGvAEQ
         sikVuDYusQkN/Vs22xFhqVxlK4/l2HbJhp/nYRQa6FZ72sqW0zm9dXsoJwHRaZ0vN1KE
         R2K4nvrRG1iQJh0immyGtZ56ZqfFowiGvxkAI3f/WvixF00TnMwLam6iqrSp5dB9b/er
         oZw+AQ5eP4GsrlziUwMU/BBdaPdhylpJo/nChNf0ZoLm7av62Z0dFLBs+zhHfiRE/avA
         ZfYAZ5BEHIZqkTOiAR+2ce3zoo9+eGQNIQJ4kkqIW8OP6mcsxr+76lUvRHEqtNFbs9e8
         5xug==
X-Gm-Message-State: AG10YOQAWNBd48av2v180MJkHhQcrhQnOguTuaLZnvsfFoKrUpy50fo23D36h8FhgM8/fQ==
X-Received: by 10.66.97.40 with SMTP id dx8mr30941018pab.29.1455629461302;
        Tue, 16 Feb 2016 05:31:01 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id mk3sm46090612pab.20.2016.02.16.05.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:23 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286393>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 25 +++++++++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/worktree.c b/worktree.c
index 28195b1..04aac73 100644
--- a/worktree.c
+++ b/worktree.c
@@ -282,6 +282,31 @@ int validate_worktree(const struct worktree *wt, i=
nt quiet)
 	return 0;
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
+		if (!write_file_gently(git_common_path("worktrees/%s/gitdir",
+						       wt->id),
+				       "%s/.git", real_path(path.buf))) {
+			free(wt->path);
+			wt->path =3D strbuf_detach(&path, NULL);
+			ret =3D 0;
+		} else
+			ret =3D sys_error(_("failed to update '%s'"),
+					git_common_path("worktrees/%s/gitdir",
+							wt->id));
+	}
+	strbuf_release(&path);
+	return ret;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index 0d6be18..bbe40ef 100644
--- a/worktree.h
+++ b/worktree.h
@@ -44,6 +44,12 @@ extern int is_main_worktree(const struct worktree *w=
t);
 extern int validate_worktree(const struct worktree *wt, int quiet);
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
