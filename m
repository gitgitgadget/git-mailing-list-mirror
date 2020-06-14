Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92CEC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 09:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF4B206B7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 09:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQgv+HxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFNJIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNJIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 05:08:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63468C03E969
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 02:08:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w1so13028150qkw.5
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SOb6YgDATzq6goDUH2pxXiA9iHp2MyqNPEikAlT3WvU=;
        b=vQgv+HxJECPxlu2fTTSDGGFp6MauOIEAMiArUvzH7fzbKsShDqPKhTq61aDr/DI1yH
         i8+dh0F3tnJMWfqT+gFs7d5Pb8JysKoVyv/uV1yOi6NfZqLVIq8ib3tpy2/fI2F6Dx0L
         EXDRLbUR59tAcYjFvii4VIxy2nqUauxtlPg+NlZSkqkC2//r0kWC9JKB8rEXZa2Q7COx
         MzbYOIhHQdLPz/pv/phOZeo8DPJWcBPcOkx/bouTacHCqO1YDeuLC4iKnOChA88SHwhi
         E5i2Z+1+pubAolPgJbO3CvjTfrZmuXAoqMw3lOIZnhEMkrNZ6qRFaNYEYPt2ZO6VAPpT
         y5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SOb6YgDATzq6goDUH2pxXiA9iHp2MyqNPEikAlT3WvU=;
        b=X139v/WUDa+Fs2BpPtnE0UrIs2uu1beTXgaEDQ7+sCm8SsVvgTYdxEB4IT5pPCIs9C
         f3KwuWNy9Hf13Pjo5KaxRTSl/0D6WvQZanBlKjAW5epiKlAOem0Dfjh2FGeg4QGAo7uK
         EH/GmX5H9khPcTc17uvoSBXMmIYpPoKU79n7ruo0hNjXrTXc1JIXFXXnXYCsRcW/9BZH
         tl7DqBF6ZKKiPySw3uNFmFTbua+kpWErUOD9uv+lkz+deXFTdrokEbnqvXp8OAoQawZs
         P0EeEzCeyLQ0JfJRtT5RwfaeSb0KYHF0K6qsKm8TluourJqNNtpcdT34A9wv2ZOXU2gQ
         angg==
X-Gm-Message-State: AOAM532ice5MWdo54NM/viUVd1SCSKw2iK0GENWPOI+3fT9ImJ5Yp3tY
        3xAl60ctV7Wyp7CLr0F12LDQCgkB5Vg=
X-Google-Smtp-Source: ABdhPJxOMed0ouDf/wRjeIsSJMWNaw8lEqRVSLmZvHckAu8to+LtAdcVvYfAQbV9yt9Lq41Moa1ZBw==
X-Received: by 2002:a05:620a:90f:: with SMTP id v15mr10327882qkv.399.1592125694611;
        Sun, 14 Jun 2020 02:08:14 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c16sm8224557qko.100.2020.06.14.02.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 02:08:14 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2] pkt-line: use string versions of functions
Date:   Sun, 14 Jun 2020 05:07:54 -0400
Message-Id: <da9ba5fb2d0fb9481f81ce525cbabaedd722858d.1592125442.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <20200614083131.GD3405@danh.dev>
References: <20200614083131.GD3405@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have many cases where we are writing a control packet as a string
constant out and we need to specify the length of the string. Currently,
the length is specified as a magical `4` literal.

Change these instances to use a function that calls strlen() to
determine the length of the string removing the need to specify the
length at all. Since these functions are inline, the strlen()s should be
replaced with constants at compile-time so this should not result in any
performance penalty.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Hi Đoàn,

Perhaps something like this?

 pkt-line.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 8f9bc68ee2..022376f00f 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -81,49 +81,61 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_release(&out);
 }
 
+static inline void packet_trace_str(const char *buf, int write)
+{
+	packet_trace(buf, strlen(buf), write);
+}
+
+#define control_packet_write(fd, s, errstr) \
+	do { \
+		(void)s"is a string constant"; \
+		packet_trace_str((s), 1); \
+		if (write_str_in_full((fd), (s)) < 0) \
+			die_errno((errstr)); \
+	} while (0)
+
 /*
  * If we buffered things up above (we don't, but we should),
  * we'd flush it here
  */
 void packet_flush(int fd)
 {
-	packet_trace("0000", 4, 1);
-	if (write_in_full(fd, "0000", 4) < 0)
-		die_errno(_("unable to write flush packet"));
+	control_packet_write(fd, "0000", _("unable to write flush packet"));
 }
 
 void packet_delim(int fd)
 {
-	packet_trace("0001", 4, 1);
-	if (write_in_full(fd, "0001", 4) < 0)
-		die_errno(_("unable to write delim packet"));
+	control_packet_write(fd, "0001", _("unable to write delim packet"));
 }
 
 void packet_response_end(int fd)
 {
-	packet_trace("0002", 4, 1);
-	if (write_in_full(fd, "0002", 4) < 0)
-		die_errno(_("unable to write stateless separator packet"));
+	control_packet_write(fd, "0002", _("unable to write stateless separator packet"));
 }
 
 int packet_flush_gently(int fd)
 {
-	packet_trace("0000", 4, 1);
-	if (write_in_full(fd, "0000", 4) < 0)
+	packet_trace_str("0000", 1);
+	if (write_str_in_full(fd, "0000") < 0)
 		return error(_("flush packet write failed"));
 	return 0;
 }
 
+#define control_packet_buf_write(buf, s) \
+	do { \
+		(void)s"is a string constant"; \
+		packet_trace_str((s), 1); \
+		strbuf_addstr((buf), (s)); \
+	} while (0)
+
 void packet_buf_flush(struct strbuf *buf)
 {
-	packet_trace("0000", 4, 1);
-	strbuf_add(buf, "0000", 4);
+	control_packet_buf_write(buf, "0000");
 }
 
 void packet_buf_delim(struct strbuf *buf)
 {
-	packet_trace("0001", 4, 1);
-	strbuf_add(buf, "0001", 4);
+	control_packet_buf_write(buf, "0001");
 }
 
 void set_packet_header(char *buf, int size)
@@ -337,15 +349,15 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	if (len < 0) {
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
-		packet_trace("0000", 4, 0);
+		packet_trace_str("0000", 0);
 		*pktlen = 0;
 		return PACKET_READ_FLUSH;
 	} else if (len == 1) {
-		packet_trace("0001", 4, 0);
+		packet_trace_str("0001", 0);
 		*pktlen = 0;
 		return PACKET_READ_DELIM;
 	} else if (len == 2) {
-		packet_trace("0002", 4, 0);
+		packet_trace_str("0002", 0);
 		*pktlen = 0;
 		return PACKET_READ_RESPONSE_END;
 	} else if (len < 4) {
-- 
2.27.0.132.g321788e831

