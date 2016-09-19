Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68C32070F
	for <e@80x24.org>; Mon, 19 Sep 2016 21:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbcISVJJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:09:09 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33098 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbcISVJI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:09:08 -0400
Received: by mail-pf0-f173.google.com with SMTP id 21so43929079pfy.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IAs15tqcrxyM/fb0/pH1biR5KVMBqHFQrgkFMpV+jDI=;
        b=ie0gGnSjeguPYKEXOWKjrtNXDiKuR3OPyQPonQpfvMkCjD3Np7SGgNW3FqT7djlQuH
         FQcSL9++ebJ4F4nd5WMwi5zAax18AZkShe7DZi0Miecu2X4SCwAcfzPtCf54GeVUe/fP
         kx4cJJaruccc+kH2Etby8K27ZUqd8SS+GhQ4RSdLVUEXVbt5QNSKWtQCjRcL2QbiBmQJ
         9vwbE7z7WnUWS8obN9CiGWp0dU71oOoMHVBPwtE8/6vB5vqXfbwNKfdHjkC1HrmySonP
         CjybOHZi9ThgZrU6CwUmPQga0UdysJFIkEsHzP2eD5ngvynH0b0EpIUCJRf2l+Yd+gML
         qJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IAs15tqcrxyM/fb0/pH1biR5KVMBqHFQrgkFMpV+jDI=;
        b=FI4WRG6VrWHo/8kcqcgAAWvVrpuK9AVMt3cUtmxRcvxNIzBLPFoVmrws2sJ2+MYNbu
         5mtr/Aiie0I4uc9PZW0BQB5R9mmN0aOauO5PgFV6RjJpkejWVuZY4aM1df7OmhpHhFfb
         pJ3XN9+75omHpcpwsh8LMMS+8rm8Ml/i1BZAPqfh9H56WC54apBsVWDRKP36Ee5/poFN
         k/LqCr01D5Z5SZQBLSwJkBVW0hLO9WZj1l25wdnP1vi43EMgR/xZi411ceJtJl4kIwqt
         PG7jLSYD9J0en3eidg8bSMGKTMNvlM8mrvtc5Z5rqum8sXO0LuLwPahrWoVl5h/51C5F
         lDYg==
X-Gm-Message-State: AE9vXwMHe9SRt8LvMAL7lsQ6pg3ma9M3LLPbeZA8/MwwzGu/zhJVbOIzsgnlqF4VSF3PCB79
X-Received: by 10.98.134.201 with SMTP id x192mr40969518pfd.21.1474319347795;
        Mon, 19 Sep 2016 14:09:07 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id q14sm54484171pfg.63.2016.09.19.14.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Sep 2016 14:09:06 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v2 3/4] mailinfo: make is_scissors_line take plain char *
Date:   Mon, 19 Sep 2016 14:08:52 -0700
Message-Id: <fe75e92ee7108ef410cb0edad81d1b464b7694eb.1474319086.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com>
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
index aadad09..1f487df 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -581,37 +581,35 @@ static inline int patchbreak(const struct strbuf *line)
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
@@ -626,7 +624,10 @@ static int is_scissors_line(const struct strbuf *line)
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
@@ -671,7 +672,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	if (convert_to_utf8(mi, line, mi->charset.buf))
 		return 0; /* mi->input_error already set */
 
-	if (mi->use_scissors && is_scissors_line(line)) {
+	if (mi->use_scissors && is_scissors_line(line->buf)) {
 		int i;
 
 		strbuf_setlen(&mi->log_message, 0);
-- 
2.10.0.rc2.20.g5b18e70

