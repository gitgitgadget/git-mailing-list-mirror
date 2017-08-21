Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4FE208D0
	for <e@80x24.org>; Mon, 21 Aug 2017 14:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbdHUOEv (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 10:04:51 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35841 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbdHUOEt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 10:04:49 -0400
Received: by mail-pg0-f66.google.com with SMTP id y129so23963946pgy.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXsXM3S/TLIZ0jX9hH/RWNhyGShsHqrwXN5UXRkJ7vw=;
        b=CG/MfBoa9xuO0GTRZAIBpPRhLJhrC/GMVdglQeheDIJAaLDI7Cwg/859ZJIqSOx6XJ
         6ppFWI11hTIQn2Q5AHM54f3mzu8k6lAH3OyYbLb7vuJIulJAIppK04ifw+KMPWOEtE8g
         grmPcItgSMzrYTsQXJ61kNqCy5f13JCE6mz4ZYxjZUVBDvg/O2jYneeJg6R1zlhCKFlp
         lWjycthibwL+lI+50Ch45JYcP6JTZfRtH5DB0aZGECTlE+6lxxaZazClYRZJzTKy0B+i
         jTSmV+bQQxfMQ/cTQu8du7gEH97Y0DG0dsF29zgwHiSBv0S7bv6UXL+U80/6rlwgsdne
         KOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXsXM3S/TLIZ0jX9hH/RWNhyGShsHqrwXN5UXRkJ7vw=;
        b=eePEF/nCOFCddchiSQNTe2aTpk8/MzlloDpj0GRfKJ4ThRqnOrcugRV0E/j4yGgB8k
         q9Oh1j8KVm1REKeN3kQ1QgsuWpMTjazudaOSaUu4zOggrzAGPJofQP/Vqq1mNSYw09i7
         Ke2+lUQbl9KbLNOiScOxyLXnSK8EU8aC72W7CBYMEz5ORnfiMaIB/XClU05hLSRHsG1o
         eO2ktEAI5FKL1TEeSZ1Z5hr/RKD8t8hJxskE9LyggbKmgcoNGCe1ymiitY+Tll+Fi1RP
         QO4v2f9s8WnYw/FiY+Kjd4FIyFOayUbZHNbF1kOegQNh2iX6rkOTmP7Oc0HizUqutdHr
         PIIg==
X-Gm-Message-State: AHYfb5hzO2cMG8sOTKRFMaCcuR5wqf202W5vTG2vrU9wu1apf8xMP+Hw
        qQWNNc2o6Eofo0cU+spHlg==
X-Received: by 10.98.80.69 with SMTP id e66mr17004251pfb.60.1503324288651;
        Mon, 21 Aug 2017 07:04:48 -0700 (PDT)
Received: from localhost.localdomain ([117.246.137.117])
        by smtp.gmail.com with ESMTPSA id u69sm22970140pfa.70.2017.08.21.07.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2017 07:04:48 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH v2/RFC] commit: change the meaning of an empty commit message
Date:   Mon, 21 Aug 2017 19:35:28 +0530
Message-Id: <20170821140528.7212-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.656.g66e7d6d0f
In-Reply-To: <1500107583.1850.4.camel@gmail.com>
References: <1500107583.1850.4.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An "empty commit message" according to 'commit' has long been,

    A message that contains only empty lines and/or whitespaces
    and/or 'Signed-off-by' lines

This is biased as a commit message that contains only other trailers like
'Helped-by: ', 'Tested-by: ' etc., could equally be considered empty but
such messages are considered valid. Detecting *all* possible trailers
and aborting when a commit message contains only those trailers is not
an easy thing as the meaning of a 'trailer' is not universal.

Further, leaving the meaning unchanged has the issue that it isn't
consistent with the meaning of an empty "merge" message which is,

    A message that contains only empty lines and/or whitespaces

In order to keep the implementation simple and to be consistent with
the meaning of an "empty merge message"and  to remain unbiased redefine
the meaning of an "empty commit message" as,

    A message that contains only empty lines and/or whitespaces

Users who would like to have a different notion of an "empty commit message"
can do so using the 'commit-msg' hook.

As a result of this change, the following commit message which was rejected
as empty before this change is considered to be valid as a consequence
of this change.

            ----   START : COMMIT MESSAGE ----

    Signed-off-by: Random J Developer <developer@example.org>

    # Please enter the commit message for your changes. Lines starting
    # with '#' will be ignored, and an empty message aborts the commit.
    # ...
            ----   END : COMMIT MESSAGE   ----

With the default cleanup, the above message would produce a commit with the
'Signed-off-by:' line as it's subject. Eg,

    [master 4a34e74] Signed-off-by: Random J Developer <developer@example.org>

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---

 As has been noted by Junio, 

     "It would be a backward incompatible tightening of the established
     rule, but it may not be a bad change."

 The "It" above refers to this change. Expecting comments from people to ensure
 this change isn't a bad one.

 Changes in v2:

    Unlike the previous patch this one "doesn't add much". Only the meaning of
    the empty commit message has been changed.

    Unlike the previous patch, this one doesn't touch on 'merge' because after
    this patch has been applied both commit and merge seem to reject the same set
    of messages as an empty message.

    I couldn't find the meaning of an empty commit message in any part of the
    documentation. Let me know if there's some doc to update.

 builtin/commit.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8e9380251..26636aac1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -981,7 +981,7 @@ static int rest_is_empty(struct strbuf *sb, int start)
 	int i, eol;
 	const char *nl;
 
-	/* Check if the rest is just whitespace and Signed-off-by's. */
+	/* Check if the rest is just whitespace */
 	for (i = start; i < sb->len; i++) {
 		nl = memchr(sb->buf + i, '\n', sb->len - i);
 		if (nl)
@@ -989,11 +989,6 @@ static int rest_is_empty(struct strbuf *sb, int start)
 		else
 			eol = sb->len;
 
-		if (strlen(sign_off_header) <= eol - i &&
-		    starts_with(sb->buf + i, sign_off_header)) {
-			i = eol;
-			continue;
-		}
 		while (i < eol)
 			if (!isspace(sb->buf[i++]))
 				return 0;
@@ -1003,8 +998,7 @@ static int rest_is_empty(struct strbuf *sb, int start)
 }
 
 /*
- * Find out if the message in the strbuf contains only whitespace and
- * Signed-off-by lines.
+ * Find out if the message in the strbuf contains only whitespace
  */
 static int message_is_empty(struct strbuf *sb)
 {
-- 
2.14.1.656.g66e7d6d0f

