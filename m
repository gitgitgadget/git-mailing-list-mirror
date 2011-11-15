From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] convert: don't mix enum with int
Date: Tue, 15 Nov 2011 22:29:37 +0530
Message-ID: <1321376379-31750-3-git-send-email-artagnon@gmail.com>
References: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 18:01:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQMNz-000256-Fi
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 18:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858Ab1KORBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 12:01:23 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42567 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab1KORBW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 12:01:22 -0500
Received: by eye27 with SMTP id 27so5918756eye.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7IQYV9mG+BEo0YweRF7Duudg2yj3tiCZ7BIUgI9nNHs=;
        b=DLOiYwaf/6EbttZktTGiwkdfzh0d5Krzc0bEu+mwSL7HI8DdX7smAhulHS+UFS356j
         3GgDjroRJCUXo33bTTseQV0OPk1T6CrFJzwL8ebFWHhvEUUV3lzgop7ZG6RJ3xwu4a+r
         EEygVYmX/w2IrRtQrEVjMX/4nJGBKvBtvQaZg=
Received: by 10.68.38.71 with SMTP id e7mr60108646pbk.88.1321376480424;
        Tue, 15 Nov 2011 09:01:20 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id f2sm37889376pbg.14.2011.11.15.09.01.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 09:01:19 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185468>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 convert.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index 3bb5a4d..038b0be 100644
--- a/convert.c
+++ b/convert.c
@@ -641,7 +641,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static int git_path_check_crlf(const char *path, struct git_attr_check *check)
+static enum crlf_action git_path_check_crlf(const char *path, struct git_attr_check *check)
 {
 	const char *value = check->value;
 
@@ -658,7 +658,7 @@ static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 	return CRLF_GUESS;
 }
 
-static int git_path_check_eol(const char *path, struct git_attr_check *check)
+static enum crlf_action git_path_check_eol(const char *path, struct git_attr_check *check)
 {
 	const char *value = check->value;
 
@@ -811,7 +811,7 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, 0);
+	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_FALSE);
 }
 
 /*****************************************************************
-- 
1.7.6.351.gb35ac.dirty
