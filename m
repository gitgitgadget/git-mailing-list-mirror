Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E542079D
	for <e@80x24.org>; Sat, 12 Nov 2016 02:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965361AbcKLCZC (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:25:02 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33614 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938605AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pg0-f67.google.com with SMTP id 3so3163846pgd.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mq1kwiBRFYCq6ytJCq3YyW9YHR1p1bm1MjvmHUFg9Dk=;
        b=U9A0z7M8OQG4ODLNjdkw5Y7HSzaG6GMKnIuAiPEoEP0mRwKgPub+bM0gvHOINndjCb
         T3a4bXEkY3k/hIbx9In8m8RIontWC0GqDkG33Mx/DhZsoMur8nbt84wom/weseb/FJoX
         EHop3CtP2Dj7lX4vMG5f06B5SieCpyz5/2b0V0vusVsDgVKZTdGRYZymAxiDPt+gTMVs
         rJeXwSPz+NzWy0lzq6/oLpEBu9fx1HO8YAypk4K7ZUyD1jvcNWLLMi75MwYW0eQugf7d
         3CQsSawRNwG6Be4EwCTYGXNB7q0UxwepbZ3I68iWJdxSJHkYeyewJqM5f+TpmMCyEFjj
         OVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq1kwiBRFYCq6ytJCq3YyW9YHR1p1bm1MjvmHUFg9Dk=;
        b=AKEGOwp/mjpiFdjg5zeAmZ/aBeVrFGKY9rfIPsq1K/dllmUoF/tu/RERHa7pxNUVgw
         bK5WOM+07zFHulSE9WKyJXEF75VNrrBX7PN4Tlq5Hrw3V/FwA2gQ0NDcX7wSA1VLy22n
         7p89QiOUdQFvSydMnE4PzjbkNhl0sDVGFnoOSC1iH7/75O2iUbv/GTn5jLeO7KPhw9QL
         OhY+D14WPJgstlFYo2VEjU0fbUB+PYX0RqZ9dtRBUFwO79I08Zf9fFwG2TXrErVxu+LF
         1KHcZZoovj+FAm6HnJNjXgLbjTG8rVktwa3+ViaH5ic1xa33rRqm+nsN1yLUo6gbOpv6
         YxlQ==
X-Gm-Message-State: ABUngvdXNTeTjEitbiX/esd7nlUZsEX5F3TZ/2M/Le7iUXJUg4JjvfmbATgiuS1WFyhHGg==
X-Received: by 10.98.28.79 with SMTP id c76mr12888782pfc.8.1478917465957;
        Fri, 11 Nov 2016 18:24:25 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id c15sm18034669pfd.36.2016.11.11.18.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:24:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:24:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/11] worktree move: accept destination as directory
Date:   Sat, 12 Nov 2016 09:23:35 +0700
Message-Id: <20161112022337.13317-10-pclouds@gmail.com>
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

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c0d4a73..307019c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -539,7 +539,13 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	strbuf_addstr(&dst, prefix_filename(prefix,
 					    strlen(prefix),
 					    av[1]));
-	if (file_exists(dst.buf))
+	if (is_directory(dst.buf))
+		/*
+		 * keep going, dst will be appended after we get the
+		 * source's absolute path
+		 */
+		;
+	else if (file_exists(dst.buf))
 		die(_("target '%s' already exists"), av[1]);
 
 	worktrees = get_worktrees();
@@ -556,6 +562,17 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
 
+	if (is_directory(dst.buf)) {
+		const char *sep = find_last_dir_sep(wt->path);
+
+		if (!sep)
+			die(_("could not figure out destination name from '%s'"),
+			    wt->path);
+		strbuf_addstr(&dst, sep);
+		if (file_exists(dst.buf))
+			die(_("target '%s' already exists"), dst.buf);
+	}
+
 	/*
 	 * First try. Atomically move, and probably cheaper, if both
 	 * source and target are on the same file system.
-- 
2.8.2.524.g6ff3d78

