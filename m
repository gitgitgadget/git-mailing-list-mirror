Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7052079C
	for <e@80x24.org>; Sat, 12 Nov 2016 02:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966330AbcKLCYj (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:24:39 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33507 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938556AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pf0-f193.google.com with SMTP id 144so3145524pfv.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TxRf9Id03jVmMKlT4Mtfm5l/p2DOucfFMyyHIXN2a4=;
        b=MkrYGbIwvR17bjQz+7Owlkj4P2i4Jy5OsL/oxk/EsiLX4cOaTRy8eZMvRNEaziQgYw
         /ZznYsWJ9jTfzGGVm8I3xv4XEIMQ2h0eGH67KyP5oLduEvN/ngzIRPauQdUvZcO4Y+Uf
         dz0WUaVy2hdlwr3PEJlWcmzHCRECEsdlAAADrT3MzNVI0BXO+1arsJYR8ci2hjvz5Ie7
         EVJ86M27tSJdh1D96aqQbQjJ2jFrrrSoLathXdVbmQxYK1QZE/pwFFL7HmlVy2Bx/WXL
         CLd4806T2fhYL53DrCYwBPcicx4HA/vMihafZ246+m+DrmLO/gR6y11E+vubTtpgv4AV
         e81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TxRf9Id03jVmMKlT4Mtfm5l/p2DOucfFMyyHIXN2a4=;
        b=kq9QsDAmoadYwnwcx+ktbXHlYraEjAovd5Y39Dmtj+1CErUs7ym/mZOKdmAcelPKdJ
         X8wb9j9iuezznbbySkg8tSAANMVVnmawTMdfwL6ebyPz1gmuWAMvtbVBw3rwUmPZcbdq
         5rR3V634M4ZUtSs26i0XEodk1HitCmCvGvg6thiqpqPsKNbr2FpoMD3OSscfdhd86Ga5
         Z550nRn90YDZNdQVzqNTpdA9p2AAFpJMRARgC47DnAbirk5g7tAgzyqpigVJr6JYZ/U6
         jeJEz1r48ehUmhjG3EKrKWuoBhpvGWj1ZDkGT7A20MCSLPZpNhKDNZXpVGg7/YlkEcBT
         8bkw==
X-Gm-Message-State: ABUngvdgaCoeJpbY4WLw6cbYgasF0MvPVwqtw7vAU9H2KrDFrAFpzqu/z6cwHTeO3KTpDg==
X-Received: by 10.99.62.13 with SMTP id l13mr9701613pga.112.1478917452354;
        Fri, 11 Nov 2016 18:24:12 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id l11sm18052404pfb.28.2016.11.11.18.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:24:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:24:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/11] worktree.c: add validate_worktree()
Date:   Sat, 12 Nov 2016 09:23:32 +0700
Message-Id: <20161112022337.13317-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161112022337.13317-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is later used by "worktree move" and "worktree remove"
to ensure that we have a good connection between the repository and
the worktree. For example, if a worktree is moved manually, the
worktree location recorded in $GIT_DIR/worktrees/.../gitdir is
incorrect and we should not move that one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h |  5 +++++
 2 files changed, 68 insertions(+)

diff --git a/worktree.c b/worktree.c
index f7869f8..7e15ec7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -291,6 +291,69 @@ const char *is_worktree_locked(struct worktree *wt)
 	return wt->lock_reason;
 }
 
+static int report(int quiet, const char *fmt, ...)
+{
+	va_list params;
+
+	if (quiet)
+		return -1;
+
+	va_start(params, fmt);
+	vfprintf(stderr, fmt, params);
+	fputc('\n', stderr);
+	va_end(params);
+	return -1;
+}
+
+int validate_worktree(const struct worktree *wt, int quiet)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *path;
+	int err;
+
+	if (is_main_worktree(wt)) {
+		/*
+		 * Main worktree using .git file to point to the
+		 * repository would make it impossible to know where
+		 * the actual worktree is if this function is executed
+		 * from another worktree. No .git file support for now.
+		 */
+		strbuf_addf(&sb, "%s/.git", wt->path);
+		if (!is_directory(sb.buf)) {
+			strbuf_release(&sb);
+			return report(quiet, _("'%s/.git' at main worktree is not the repository directory"),
+				      wt->path);
+		}
+		return 0;
+	}
+
+	/*
+	 * Make sure "gitdir" file points to a real .git file and that
+	 * file points back here.
+	 */
+	if (!is_absolute_path(wt->path))
+		return report(quiet, _("'%s' file does not contain absolute path to the worktree location"),
+			      git_common_path("worktrees/%s/gitdir", wt->id));
+
+	strbuf_addf(&sb, "%s/.git", wt->path);
+	if (!file_exists(sb.buf)) {
+		strbuf_release(&sb);
+		return report(quiet, _("'%s/.git' does not exist"), wt->path);
+	}
+
+	path = read_gitfile_gently(sb.buf, &err);
+	strbuf_release(&sb);
+	if (!path)
+		return report(quiet, _("'%s/.git' is not a .git file, error code %d"),
+			      wt->path, err);
+
+	if (fspathcmp(path, real_path(git_common_path("worktrees/%s", wt->id))))
+		return report(quiet, _("'%s' does not point back to"),
+			      wt->path, git_common_path("worktrees/%s", wt->id));
+
+	return 0;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 90e1311..e782ae5 100644
--- a/worktree.h
+++ b/worktree.h
@@ -50,6 +50,11 @@ extern int is_main_worktree(const struct worktree *wt);
  */
 extern const char *is_worktree_locked(struct worktree *wt);
 
+/*
+ * Return zero if the worktree is in good condition.
+ */
+extern int validate_worktree(const struct worktree *wt, int quiet);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.8.2.524.g6ff3d78

