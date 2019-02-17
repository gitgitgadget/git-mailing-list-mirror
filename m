Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA111F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfBQKLK (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:11:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:11:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id s1so7255573plp.9
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PclaGV/Xa57QcCtWmo0rioaHLxjaR9j2vjhs6nBR3+o=;
        b=aFH3p4TLNUp2DPHNN3O8FJmu01/2TkR2ns4VgwGbgVssHJF+usykc0uq+5XPh9DTwE
         oRQ8judgd1OpPJgDrtErxSZUUsBMwt1dMTgJFTvu4jdlkk0rGmWc8b8TGnEbl4Pc/L6f
         46GPXIEUeZgr8LcNO6xtj/3C3PnqHHBAROTMWVBWNws0drWTufIcoHOqHGdgft6g+Bll
         f/VZQP0dfXrrB5mOdcbyQQpU66kW6dNmdQtoGAEs9RuVVb6xEQAZG5L5ttsQ1w4xhu/y
         655RZK6n/+/tdRYKrRh6c/KATtm5r5enGmjwA+6ACmlHM6RNig5wtf2PAYWozDEA74sQ
         XJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PclaGV/Xa57QcCtWmo0rioaHLxjaR9j2vjhs6nBR3+o=;
        b=RCORjtQX36tzg3jRN/M2jbepAcw+M1r+fVx2slpAPQZCkB+I2EkX9YLoKcx6ooYv3W
         rrATj6fhRLKr6Kh/ydXkU+7rhzkPJjzuZ3sPwa2pykMtqm8cjkmBYcZE1Tu4z1DwuI27
         oirib7nvkI79ZF8/QyEV1zeN41mZaOLMOA4kyLcCl8FE9ZXwAYLVZLCIU/RpVa7aWEmG
         w7gjhge6AJIJreXcD8UZuemSDROyeCK0adpYmKoef6UZmTDwaanjCZx2Eili8FnHN98+
         yiOwM6m76Yo9jC9pQtaS6px9lc5JJhN1Eqg+MNzztpLoNc8ToC+ntfKJKU+BGKfr9ufK
         b6IA==
X-Gm-Message-State: AHQUAubGyjzL5sxgH6cCFFEQx68/iPpdPDxtj6yS0TlZ0FZG8t9jlbKx
        E2LsqD7NkFlgvugbB/2w4rY1tWTJ
X-Google-Smtp-Source: AHgI3Ib2YJZuBJCfT6cKYwhldbbpjJNrM/mwMAGt2sec9hwreS3lo53XVuVcF3J2V6MlKDVOtYGH1g==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr19719370plb.332.1550398268808;
        Sun, 17 Feb 2019 02:11:08 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id p20sm14765858pfj.112.2019.02.17.02.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:11:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:11:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 25/31] sha1-name.c: remove the_repo from resolve_relative_path()
Date:   Sun, 17 Feb 2019 17:09:07 +0700
Message-Id: <20190217100913.4127-26-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"remove" is not entirely correct. But at least the function is aware
that if the given repo is not the_repository, then $CWD and
is_inside_work_tree() means nothing.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6caf3f4e3a..6b53ea2eeb 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1719,12 +1719,12 @@ static void diagnose_invalid_index_path(struct repository *r,
 }
 
 
-static char *resolve_relative_path(const char *rel)
+static char *resolve_relative_path(struct repository *r, const char *rel)
 {
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (!is_inside_work_tree())
+	if (r != the_repository || !is_inside_work_tree())
 		die("relative path syntax can't be used outside working tree.");
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
@@ -1785,7 +1785,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			stage = name[1] - '0';
 			cp = name + 3;
 		}
-		new_path = resolve_relative_path(cp);
+		new_path = resolve_relative_path(repo, cp);
 		if (!new_path) {
 			namelen = namelen - (cp - name);
 		} else {
@@ -1839,7 +1839,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
-			new_filename = resolve_relative_path(filename);
+			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
-- 
2.21.0.rc0.328.g0e39304f8d

