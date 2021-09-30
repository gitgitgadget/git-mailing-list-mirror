Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA53BC433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF9C61881
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352482AbhI3RDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352478AbhI3RDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 13:03:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C73C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:01:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r7so4636724pjo.3
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqWBem/sC0ubBy22X5nYFj2VzyRwmznXXHCFxvbtNbc=;
        b=qIYJcCz2xsrQbIgmRpNJ+LeEQ3wfYYzqGS6R7+cFEvDzFTStz2BYAHTKuS8ONHlITZ
         w3oPKJvozsEHdwOSeVZUM6v7pQmTYtcKov1LdibXtem4f94AFGkxmb1UYZ4hJoZUwazk
         zlenshtYDrQz19qk1+5HJIbMvKMM5KlYq5V7qM3d96dIzKp1FvTLI+mMXuBnlmuAUOto
         c1rXvYlX+1NCgsxFz9GaIT55NsnDExn3ah/mygJv47b3pbi/bf4gLEdDV1VrZokFQ8dM
         TSBDRwpCk3IfVnQ4GFnd8fNs6DLhK9v0hBQxxAyqg4iOStPwyYf0CwHSvT0USzkR5Zno
         cmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqWBem/sC0ubBy22X5nYFj2VzyRwmznXXHCFxvbtNbc=;
        b=ktWWyCiyWZT6fwS+Ae3ofDSnM9wUIRV7r5d9oVhytWLj6CRjSptCdFKkCesaCCAV0x
         Pyjb7VhcNs/T9VXCwbjm/m0rBpjGuL0mM+ndxBMKiS/RjJ4GZVqMxzdFvNbDyPM1iA+b
         k9dKXLId54jbWUOndFeEd7BKLTrNSfYgfG1L0toBr4Zp8JvWRHrJDZIb1eD7lAQiG5Ax
         fo4+VXdXKXjTh7HZRdZhqD6mrJncwO45CfPsx3nMf+XzMVvSX32w27mz889UV93dctMp
         0PVM2/W6ankpcTrMmF1qa17Gn8h1hdWaY4XPaG9wc56yhTAdXDjAm7KmONdKh3Nu5zDt
         Bp5A==
X-Gm-Message-State: AOAM530scxpJ7bXU3A3l1uqfCZG+pNwGTC8ZFG7EtAVCDl3wjzLoKVmE
        WDa6RJH2TTv9tUHHtgb0ldWi8smKvF8=
X-Google-Smtp-Source: ABdhPJx7rLAXKRhyLW/6DS8auZ08wMFXdk3LTdb48wqse1RwI/bX0BBF8ezKKTTf2RpGoWr0Gc64XA==
X-Received: by 2002:a17:90a:351:: with SMTP id 17mr7771817pjf.145.1633021314491;
        Thu, 30 Sep 2021 10:01:54 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id p4sm2740678pjo.0.2021.09.30.10.01.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 10:01:54 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 4/5] difftool: refactor dir-diff to write files using a helper function
Date:   Thu, 30 Sep 2021 10:01:45 -0700
Message-Id: <20210930170146.61489-4-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.887.g8db6ae3373
In-Reply-To: <20210930170146.61489-1-davvid@gmail.com>
References: <20210930170146.61489-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a write_entry() helper function to handle the unlinking and writing
of the dir-diff submodule and symlink stand-in files.

Use write_entry() inside of the hashmap loops to eliminate duplicate
code and to safeguard the submodules hashmap loop against the
symlink-chasing behavior that 5bafb3576a (difftool: fix symlink-file
writing in dir-diff mode, 2021-09-22) addressed.

The submodules loop should not strictly require the unlink() call that
this is introducing to them, but it does not necessarily hurt them
either beyond the cost of the extra unlink().

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is cleanup refactoring that Junio suggested when
5bafb3576a (difftool: fix symlink-file writing in dir-diff mode, 2021-09-22)
touched this area of the code.

 builtin/difftool.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index e419bd3cd1..bbb8b399c2 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -320,6 +320,17 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	return ret;
 }
 
+static void write_entry(const char *path, const char *content,
+			struct strbuf *buf, size_t len)
+{
+	if (!*content)
+		return;
+	add_path(buf, len, path);
+	ensure_leading_directories(buf->buf);
+	unlink(buf->buf);
+	write_file(buf->buf, "%s", content);
+}
+
 static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			struct child_process *child)
 {
@@ -533,16 +544,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 */
 	hashmap_for_each_entry(&submodules, &iter, entry,
 				entry /* member name */) {
-		if (*entry->left) {
-			add_path(&ldir, ldir_len, entry->path);
-			ensure_leading_directories(ldir.buf);
-			write_file(ldir.buf, "%s", entry->left);
-		}
-		if (*entry->right) {
-			add_path(&rdir, rdir_len, entry->path);
-			ensure_leading_directories(rdir.buf);
-			write_file(rdir.buf, "%s", entry->right);
-		}
+		write_entry(entry->path, entry->left, &ldir, ldir_len);
+		write_entry(entry->path, entry->right, &rdir, rdir_len);
 	}
 
 	/*
@@ -552,18 +555,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 */
 	hashmap_for_each_entry(&symlinks2, &iter, entry,
 				entry /* member name */) {
-		if (*entry->left) {
-			add_path(&ldir, ldir_len, entry->path);
-			ensure_leading_directories(ldir.buf);
-			unlink(ldir.buf);
-			write_file(ldir.buf, "%s", entry->left);
-		}
-		if (*entry->right) {
-			add_path(&rdir, rdir_len, entry->path);
-			ensure_leading_directories(rdir.buf);
-			unlink(rdir.buf);
-			write_file(rdir.buf, "%s", entry->right);
-		}
+
+		write_entry(entry->path, entry->left, &ldir, ldir_len);
+		write_entry(entry->path, entry->right, &rdir, rdir_len);
 	}
 
 	strbuf_release(&buf);
-- 
2.33.0.887.g8db6ae3373

