Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3EAC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5089C610FB
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhDOV61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbhDOV60 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 17:58:26 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F9C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 14:58:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id i6so9795012qti.10
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbmvUyNDAYQKxpwIvEp503jJVUgQZqDck+yhsHezW3g=;
        b=ZGNho8FrwR1naiI4r5lzKnexNIXjjAN1rpIx/Sy9gvRjGthuVNJlK29dl5uo6MKQRN
         zQhMPaIDfHOf6PcCVONzUB+U9YCG0lpWb0l2VSWA1myj2h5j+M7za5njVybrA77K5Ski
         wkBjjUOgXQ96w0DNxhEFPO1/OTgJIq0/BbHqD24BZi+w0kHbZQyLfxTMjDDqN4AyjHlr
         2EqkQ2oTjUr9jzd1zm84wiZ1VqekKchB1nDrJ/L/kk+IJv54HsqhUQM/9UnWYv3e1/dV
         Y3QPWTdYxEgedwF81NNDgn/mcNVOXntmQabtEh9UpzoJdZEhGBe2LXbrrTt8n7wxSeAY
         VCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbmvUyNDAYQKxpwIvEp503jJVUgQZqDck+yhsHezW3g=;
        b=H906LlOXOo3vJOQtiaN0Rs1BmUjun+JXSsmM7MDVg6odNEnF2bD7UpKDdHk0bbce2d
         vQPQ6cfIIk/yesCTh7uVJj0h+ryJbMiO3TU++anFWkm7xUQIktg3DP5MfX/g8nOMnfyN
         etaPZZG9MEEaFvsyII3FSoIyM/d9fCNuilfyxCUEGQxgCnK4vSz/DpnU7v5KrFikzNo2
         cYl8k7Ir+wQlk31/l+Y+C+p/992B3uBJ/6I4AgGTDvmGhut/4GnRqeUMJxi/coNmTIyh
         hIffZyOLJx8jou79AKFUBa5o3c8oIxZMx+qL1ey+yvpFHfPto7WThJl81w8L37ZeITwe
         VOSg==
X-Gm-Message-State: AOAM53259s/GoiYHlsPSqLknc4fbKc5WelbILc76K/G+bCFpjAkeVsHm
        9lxQVW7YL9a8WwUrXCYiGW1D9FOJnFNymA==
X-Google-Smtp-Source: ABdhPJzlh+5jKMr51xUzowWBK3FiCb4mFXDQo9M/B/WPi34i+fOOLzrgOQfVyDhzlt5DhLJndt6zag==
X-Received: by 2002:a05:622a:18b:: with SMTP id s11mr5169325qtw.26.1618523880223;
        Thu, 15 Apr 2021 14:58:00 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id w67sm2986129qkc.79.2021.04.15.14.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:57:59 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: [PATCH v2] pkt-line: do not report packet write errors twice
Date:   Thu, 15 Apr 2021 18:57:52 -0300
Message-Id: <d477a069eed1cfa10ebe68991caed6c2b0ebb43b.1618522570.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <64b81865fdfcc505b6aa3e6ebaebf3b9ccb36eb1.1618513583.git.matheus.bernardino@usp.br>
References: <64b81865fdfcc505b6aa3e6ebaebf3b9ccb36eb1.1618513583.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On write() errors, packet_write() dies with the same error message that
is already printed by its callee, packet_write_gently(). This produces
an unnecessarily verbose and repetitive output:

error: packet write failed
fatal: packet write failed: <strerror() message>

In addition to that, packet_write_gently() does not always fulfill its
caller expectation that errno will be properly set before a non-zero
return. In particular, that is not the case for a "data exceeds max
packet size" error. So, in this case, packet_write() will call
die_errno() and print an strerror(errno) message that might be totally
unrelated to the actual error.

Fix both those issues by turning packet_write() and
packet_write_gently() into wrappers to a common lower level function
that doesn't print the error message, but instead returns it on a buffer
for the caller to die() or error() as appropriate.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 pkt-line.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 0194137528..98304ce374 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -194,13 +194,16 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
-static int packet_write_gently(const int fd_out, const char *buf, size_t size)
+static int do_packet_write(const int fd_out, const char *buf, size_t size,
+			   struct strbuf *err)
 {
 	char header[4];
 	size_t packet_size;
 
-	if (size > LARGE_PACKET_DATA_MAX)
-		return error(_("packet write failed - data exceeds max packet size"));
+	if (size > LARGE_PACKET_DATA_MAX) {
+		strbuf_addstr(err, _("packet write failed - data exceeds max packet size"));
+		return -1;
+	}
 
 	packet_trace(buf, size, 1);
 	packet_size = size + 4;
@@ -215,15 +218,29 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	 */
 
 	if (write_in_full(fd_out, header, 4) < 0 ||
-	    write_in_full(fd_out, buf, size) < 0)
-		return error(_("packet write failed"));
+	    write_in_full(fd_out, buf, size) < 0) {
+		strbuf_addf(err, _("packet write failed: %s"), strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+static int packet_write_gently(const int fd_out, const char *buf, size_t size)
+{
+	struct strbuf err = STRBUF_INIT;
+	if (do_packet_write(fd_out, buf, size, &err)) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
 	return 0;
 }
 
 void packet_write(int fd_out, const char *buf, size_t size)
 {
-	if (packet_write_gently(fd_out, buf, size))
-		die_errno(_("packet write failed"));
+	struct strbuf err = STRBUF_INIT;
+	if (do_packet_write(fd_out, buf, size, &err))
+		die("%s", err.buf);
 }
 
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
-- 
2.30.1

