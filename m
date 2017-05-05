Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11FBD207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754224AbdEEP2r (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:28:47 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33965 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbdEEP2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:41 -0400
Received: by mail-qt0-f194.google.com with SMTP id l39so1237253qtb.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ai3UT0+Ssx0fcQdMqcKKwkiisOpPG5A7s0DnrYPttAI=;
        b=ktApeOUANzew9HgHe0lFprBZLjIWV7snf+p0H/Per8IuZOlbbj7LlALTF2cBduBU9Z
         eabx4QIwN9aLdvjQMCKakXolxopGgaOnsV3b4yexwlPyjbfjUvUs8MZl1gFEZJdtv+UW
         gC3aMzGSiEOy6gkRvS9SwwJgks4O8IQ+/deqQCUx1nl+GO7cmgjDC0Q/BhtIumaYWwH3
         1CU22hJI4PnUCeMcDyt6QBM7YafwNyov0ajKRvzE3TDpif/9QAE7gPsgwiy+Hw4cfjqJ
         HHnLcp5uLIwlRbemTXL72cN6ObMD/Gha+yFyfeU7Lv/iRwYgTecHxvKV42Wez9tc+3RG
         GaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ai3UT0+Ssx0fcQdMqcKKwkiisOpPG5A7s0DnrYPttAI=;
        b=dZMWNmaBsxIIdzYGRWka2UXjzaec7ainyxDhZnA35cd7b8NQuEhEuHMLbLjbm5gA+y
         i+ZyakOnEiF2r5LFqjEwVBwt6BW+HZP/WLiCuwXZGvjhFs+9rOHSGmHqEMPAOsPF4xYv
         us4vRZWL9O+CE8wykdUz03J2wVl25kq9qq8aHzf255tPewi6sv7mOkw8moN1nxpFSR50
         doXHP9zMTgDQSS8g7ol0RQrv3tFAm6c8Am1b+L8bpd74zSeOzVX2nimXxSF/gjuz3WX/
         Sz/2dHgIjSejwm32R8NAIV5VSA5kpq9SSA5R4qz7gKdV2nKAKIrDXwSGQyJL2sFYrhcY
         KoSQ==
X-Gm-Message-State: AN3rC/7vWAU4YCKLG4ou7XzNCwSsHhJzIlkbzMKBQG82TlqTcl0nxUxC
        5/Oe5cwpHg5iM+q6Gzc=
X-Received: by 10.200.56.216 with SMTP id g24mr8371411qtc.267.1493998120696;
        Fri, 05 May 2017 08:28:40 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:39 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 04/10] convert: move packet_write_line() into pkt-line as packet_writel()
Date:   Fri,  5 May 2017 11:27:56 -0400
Message-Id: <20170505152802.6724-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com>
References: <20170505152802.6724-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add packet_writel() which writes multiple lines in a single call and
then calls packet_flush_gently(). Update convert.c to use the new
packet_writel() function from pkt-line.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c  | 23 ++---------------------
 pkt-line.c | 19 +++++++++++++++++++
 pkt-line.h |  1 +
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/convert.c b/convert.c
index bdd528086f..1f18d947b9 100644
--- a/convert.c
+++ b/convert.c
@@ -521,25 +521,6 @@ static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap,
 	return hashmap_get(hashmap, &key, NULL);
 }
 
-static int packet_write_list(int fd, const char *line, ...)
-{
-	va_list args;
-	int err;
-	va_start(args, line);
-	for (;;) {
-		if (!line)
-			break;
-		if (strlen(line) > LARGE_PACKET_DATA_MAX)
-			return -1;
-		err = packet_write_fmt_gently(fd, "%s\n", line);
-		if (err)
-			return err;
-		line = va_arg(args, const char*);
-	}
-	va_end(args);
-	return packet_flush_gently(fd);
-}
-
 static void read_multi_file_filter_status(int fd, struct strbuf *status)
 {
 	struct strbuf **pair;
@@ -616,7 +597,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
+	err = packet_writel(process->in, "git-filter-client", "version=2", NULL);
 	if (err)
 		goto done;
 
@@ -632,7 +613,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	if (err)
 		goto done;
 
-	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);
+	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
 
 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
diff --git a/pkt-line.c b/pkt-line.c
index 7db9119573..9d845ecc3c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -171,6 +171,25 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
+int packet_writel(int fd, const char *line, ...)
+{
+	va_list args;
+	int err;
+	va_start(args, line);
+	for (;;) {
+		if (!line)
+			break;
+		if (strlen(line) > LARGE_PACKET_DATA_MAX)
+			return -1;
+		err = packet_write_fmt_gently(fd, "%s\n", line);
+		if (err)
+			return err;
+		line = va_arg(args, const char*);
+	}
+	va_end(args);
+	return packet_flush_gently(fd);
+}
+
 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
 	static char packet_write_buffer[LARGE_PACKET_MAX];
diff --git a/pkt-line.h b/pkt-line.h
index 66ef610fc4..b2965869ad 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,6 +25,7 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_writel(int fd, const char *line, ...);
 int write_packetized_from_fd(int fd_in, int fd_out);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 
-- 
2.12.2.gvfs.2.20.g3624a68d62.dirty

