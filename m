Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7F2C7619F
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C9E20725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3h228AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgBQIl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:27 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33845 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgBQIl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:26 -0500
Received: by mail-wr1-f44.google.com with SMTP id n10so16604976wrm.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yo7QEzRHNTsTu/TwkDBC91rjNACXUcRl6cHU+LuRfj4=;
        b=t3h228AU02RsUkYCtOfcVAip+sgrZ5HXzkLhyPvVBg/amhUWexA4z0oAn9phzMv4xv
         hTvcwGZE6Zol+Llh3iopHScis7VElPX9idNDX3WiCR72j+nB5PW45YmLNGfK7sb9gt+X
         UlZrLH1OsvbKK/UfnssMpByGpa4nciuajtzdSWovCWMvULbQgQwYsFFPYkmwmxmsrmit
         D/iSo8CpRP32MlDgyxkq5lNhpcgm07g68Wqbw1TQtmcwAt8sDlI2HfG9jvAEjdHM4zq4
         t4T6aH9bHzh983UWPmuLubz4oIJTqRS3o8mzq5bpKcq1brTFBRkDXsQGq67E5dta7WzU
         WR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yo7QEzRHNTsTu/TwkDBC91rjNACXUcRl6cHU+LuRfj4=;
        b=b8i5MwopG+Ii8cWajk1w2e4BoJ2fVAdEtUXZmzaMEpM8SOTJCden+/jcTojJbQAXD9
         vs6JdDqD2GR9XBqj3QZdZzTUoTj3fSZ3VQiSKI6Mgs9kkXu/X6K/L1dfz/zVpJJf+Kzo
         7RHnRP+nyvAG7ql+J3CaX4ARC3mPLzEPGfhGA1gyE0Iph67+zRHe5TZh3aFXhCsNPm7H
         V1Alt1pLESJ5feHi+ZjPtticMR5Ft3Neio21rrGkd0Gv5JXtLnl6xf+bWdvc7Q7hWxs3
         vYi2alDZlRq1rPJ0fTBEAPmfM6uEJ4aY03jljj15OivprKT1z7OOG/wmmA9n8XnOjFam
         Gw0A==
X-Gm-Message-State: APjAAAU/pLo73KzlVgPEeYWL7xsH2zMBRY/424aQ7uRrOaiwRjCyhTw0
        FzQCVq1PUF4J88wEf96hOCZ5qH7n
X-Google-Smtp-Source: APXvYqwSNjw+oHqLFBzthTpLlj1ZfHxbXrPYNuCzN65NwM8gtTt+n1fYoxug5fZLv4W7aFq7NK0Upw==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr21567397wrp.2.1581928884353;
        Mon, 17 Feb 2020 00:41:24 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:23 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 05/12] bisect: add enum to represent bisect returning codes
Date:   Mon, 17 Feb 2020 09:40:32 +0100
Message-Id: <20200217084039.78215-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we want to get rid of git-bisect.sh, it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Create an enum called `bisect_error` with the bisecting return codes
to use in `bisect.c` libification process.

Change bisect_next_all() to make it return this enum.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c |  2 +-
 bisect.h | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 83cb5b3a98..e4573c7ba1 100644
--- a/bisect.c
+++ b/bisect.c
@@ -945,7 +945,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
-int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
+enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
diff --git a/bisect.h b/bisect.h
index 4e69a11ea8..c921ead02c 100644
--- a/bisect.h
+++ b/bisect.h
@@ -31,7 +31,19 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-int bisect_next_all(struct repository *r,
+/*
+ * enum bisect_error represents the following return codes:
+ * BISECT_OK: success code. Internally, it means that next
+ * commit has been found (and possibly checked out) and it
+ * should be tested.
+ * BISECT_FAILED error code: default error code.
+ */
+enum bisect_error {
+	BISECT_OK = 0,
+	BISECT_FAILED = -1
+};
+
+enum bisect_error bisect_next_all(struct repository *r,
 		    const char *prefix,
 		    int no_checkout);
 
-- 
2.25.0

