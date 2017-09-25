Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C767E202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 15:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935948AbdIYP7q (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 11:59:46 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:43223 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935931AbdIYP7p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 11:59:45 -0400
Received: by mail-qt0-f170.google.com with SMTP id i50so7369008qtf.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Hr2pB68vb3pvT8rEfpLKGHMD4Ouvc+IU633Gk+Oi2U=;
        b=CmjqA0J5ce5h0qGyqE1ZlyR/GZj/+UDHnuYoe458BJNCXLs6GZcCgtkt4rNDjSoBpX
         7+AYG3J9vSirkpU8iAhq31l4/h6TWWcCB67WuDx5Ex0ktR34eRqR7HF8vQ9WOXGVvPck
         8I5CsVAx9dyRrAn9H6gpa8W8Vc4xmp1e9PPr2m/PwQh6q+VwYcsvBi+o7uY30BoNXeuE
         xIcRwS/JmyY/o/T/FtEqrXfEZ0Ofka8xlJHFqSn8TmhZBqnwRzR9ljQqUMzDPmkJ5FkY
         gap4DfsT+LEIUmwPEoU0tPEBeVwsiuCBnWHKGM/0Pn+Zu6uA30dm0hCEXwPXx2KB6jbi
         UEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Hr2pB68vb3pvT8rEfpLKGHMD4Ouvc+IU633Gk+Oi2U=;
        b=iPuTDx1e4Ih12Hql2A1tR5Or1+Jv+tcYi25K91rRFFMavsUd2fnN74AmvebxwvYS5A
         1GX6Pvj0mT6AcWWFIy503RucFu0Ml4CxI0GRMnkojvWEL6ZV9lbG+mz0BqGa8w2IFlGx
         b46G3vOkMI1Z7GIfu0N23afbKYTrm/uC9oEm7Xt4dXKRFVmb3QYm1qaVr7PpxjCkZUVS
         rvmoWzKXso4JSyDlcsLcuOaAJhwnDd/CkbV9EhXx2n6ho7h+aI9VsvXcn0DxQS9hPeaV
         VsJXAkSjzbHz5674GWuKpRhA9Y5m/AHYsD/23abJZiei4z6uwAL5ZvioJN2u7TPAKKt9
         VMhg==
X-Gm-Message-State: AHPjjUjiKkC9CL8gIV3X5ZM3rsINBzBH7bcC/69tVm1J6WMOww8HWDay
        kyQ3SNWOAHLZcOygUL0KWHt6Xquv2q8=
X-Google-Smtp-Source: AOwi7QCZAkfxYpT212YQ1N3dEN6P02J5k6jxUZfSZYm7isZUDkgpX+dzhd2uQk6en8W9XPo1AEuBCw==
X-Received: by 10.200.41.38 with SMTP id y35mr11414441qty.216.1506355180346;
        Mon, 25 Sep 2017 08:59:40 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id h19sm1439510qta.26.2017.09.25.08.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 08:59:39 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, bmwill@google.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 2/4] Clarify return value ownership of real_path and read_gitfile_gently
Date:   Mon, 25 Sep 2017 17:59:25 +0200
Message-Id: <20170925155927.32328-3-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170925155927.32328-1-hanwen@google.com>
References: <20170925155927.32328-1-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 abspath.c | 3 +++
 setup.c   | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index 708aff8d4..792a2d533 100644
--- a/abspath.c
+++ b/abspath.c
@@ -202,6 +202,9 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	return retval;
 }
 
+/* Resolve `path` into an absolute, cleaned-up path. The return value
+ * comes from a global shared buffer and should not be freed.
+ */
 const char *real_path(const char *path)
 {
 	static struct strbuf realpath = STRBUF_INIT;
diff --git a/setup.c b/setup.c
index 6d8380acd..31853724c 100644
--- a/setup.c
+++ b/setup.c
@@ -541,7 +541,8 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 
 /*
  * Try to read the location of the git directory from the .git file,
- * return path to git directory if found.
+ * return path to git directory if found. The return value comes from
+ * a shared pool and should not be freed.
  *
  * On failure, if return_error_code is not NULL, return_error_code
  * will be set to an error code and NULL will be returned. If
-- 
2.14.1.821.g8fa685d3b7-goog

