Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DED412099D
	for <e@80x24.org>; Tue, 20 Sep 2016 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbcITRSG (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 13:18:06 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35310 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755290AbcITRSE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 13:18:04 -0400
Received: by mail-pf0-f171.google.com with SMTP id z123so9421206pfz.2
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+0HbMEUInbNopKBo+JMz759SYN58Ki8gMxwqJFsssMc=;
        b=GVZCPjujLgt7wRLn50t+VW8GPene+h17LhFysE6MoDHz3g5gmKF0iMTPX7vA27P+rI
         aKgEaUELnM2E79yGRkmlWKYbm69tW4qyCuX7HLmEiwreWEjfAn46q7wYODbwnsTSUQO6
         Q7HDXNPzhwpb++5xj/0ipexRQ4kmiFA/n7V4FUhq2JY+B81PGjn0VvNqFn49BnP+FrTC
         spxsYPFSg/mYKRzcbGXfIUhA0A6E3r/EKK0oiXGaU4Xto8oXXLiV7LwkwFz/YstgIFh/
         PgA06zGGzk9DYbwlXaxxkqtd5/NqC8pfDPeRf0pFetoY2H/ONEr5O/Z/H0L4M/mXbv/a
         geeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+0HbMEUInbNopKBo+JMz759SYN58Ki8gMxwqJFsssMc=;
        b=BHD4xOZ92ThxMldjCX+1rFGKUHLdLYmkGbcItAhAoZKJ6fhpmkwDHaNzNOsLEwIYdN
         Auc/DTT4JXdgnq13DWKFHXG+KQuUtp3GHWFuoQ6DHuuo8Kf/8ig6MfvNCaXgJiprvvks
         3x7xfUn3IMzeDJqwRcAx4VFiyzRvzCLUC6PxfTVuyR9ZruO2A0dzfoi4A+a9X0gQZHat
         U2Y3SlruTwwIBmNeoEwDUpvbcQzYtTA05eVzKQFvK5kMpcX/SlldXwjqEfQebuTkTrAQ
         MmYz4XFQhuvlJAUi8io4lhVgkVOOa78lc+j07n1XvbFgWLkacLcU5Xcineb8dZR2Fx9o
         DTdg==
X-Gm-Message-State: AE9vXwOHOuw68QxZpaH2lwNgxqrrNBwwWsoI4rrnfr4v7mcL8pg5SzUTi//BTiJF//GO0LAH
X-Received: by 10.98.64.93 with SMTP id n90mr56969808pfa.29.1474391883108;
        Tue, 20 Sep 2016 10:18:03 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id x9sm80586932pfd.70.2016.09.20.10.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 10:18:02 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 2/3] mailinfo: make is_scissors_line take plain char *
Date:   Tue, 20 Sep 2016 10:17:52 -0700
Message-Id: <820980e95ee640013b2cf9c30b616ced39af67fa.1474391594.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474391594.git.jonathantanmy@google.com>
References: <cover.1474391594.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474391594.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com> <cover.1474391594.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_scissors_line takes a struct strbuf * when a char * would
suffice. Make it take char *.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 mailinfo.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 0c4738a..69391aa 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -557,37 +557,35 @@ static inline int patchbreak(const struct strbuf *line)
 	return 0;
 }
 
-static int is_scissors_line(const struct strbuf *line)
+static int is_scissors_line(const char *line)
 {
-	size_t i, len = line->len;
+	const char *c;
 	int scissors = 0, gap = 0;
-	int first_nonblank = -1;
-	int last_nonblank = 0, visible, perforation = 0, in_perforation = 0;
-	const char *buf = line->buf;
+	const char *first_nonblank = NULL, *last_nonblank = NULL;
+	int visible, perforation = 0, in_perforation = 0;
 
-	for (i = 0; i < len; i++) {
-		if (isspace(buf[i])) {
+	for (c = line; *c; c++) {
+		if (isspace(*c)) {
 			if (in_perforation) {
 				perforation++;
 				gap++;
 			}
 			continue;
 		}
-		last_nonblank = i;
-		if (first_nonblank < 0)
-			first_nonblank = i;
-		if (buf[i] == '-') {
+		last_nonblank = c;
+		if (first_nonblank == NULL)
+			first_nonblank = c;
+		if (*c == '-') {
 			in_perforation = 1;
 			perforation++;
 			continue;
 		}
-		if (i + 1 < len &&
-		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2) ||
-		     !memcmp(buf + i, ">%", 2) || !memcmp(buf + i, "%<", 2))) {
+		if ((!memcmp(c, ">8", 2) || !memcmp(c, "8<", 2) ||
+		     !memcmp(c, ">%", 2) || !memcmp(c, "%<", 2))) {
 			in_perforation = 1;
 			perforation += 2;
 			scissors += 2;
-			i++;
+			c++;
 			continue;
 		}
 		in_perforation = 0;
@@ -602,7 +600,10 @@ static int is_scissors_line(const struct strbuf *line)
 	 * than half of the perforation.
 	 */
 
-	visible = last_nonblank - first_nonblank + 1;
+	if (first_nonblank && last_nonblank)
+		visible = last_nonblank - first_nonblank + 1;
+	else
+		visible = 0;
 	return (scissors && 8 <= visible &&
 		visible < perforation * 3 &&
 		gap * 2 < perforation);
@@ -647,7 +648,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	if (convert_to_utf8(mi, line, mi->charset.buf))
 		return 0; /* mi->input_error already set */
 
-	if (mi->use_scissors && is_scissors_line(line)) {
+	if (mi->use_scissors && is_scissors_line(line->buf)) {
 		int i;
 
 		strbuf_setlen(&mi->log_message, 0);
-- 
2.10.0.rc2.20.g5b18e70

