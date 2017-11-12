Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C49201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 13:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdKLNHd (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 08:07:33 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:56213 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbdKLNHc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 08:07:32 -0500
Received: by mail-wr0-f195.google.com with SMTP id l8so12155155wre.12
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 05:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hO/e7bxxfSco4HCPNUGHMeBf3Fmt7HhKYRh8eGkOACA=;
        b=ZW3dEclVewxa/CtO0RaCWGg4m6najQEwXPBZwcPNWyco5+QYikXvn4mQwI0PXV7Ce9
         JZjnXMVgAxJAx0gV300aksge2w0WtYTLh/qw9ljZR7yY2A8j3tlS7WUEUAQN0TArUz/O
         tkyJOalMoxtn9zncuVf/DmoaluRrL+C0lwzuk/4RuRW3Amu9Bg7hJ0DA7IMJd30U+VYZ
         A+WJGtRd9NcElrIHjAs2wUhc2Nblw6swqfvJ+wY+r/m24q4q3z8GtvxAl9rZoKSHS7x1
         Yu7Z9z2G/0AaGEysb6ldQ1HuB+qDPuskuHCBHdngwyR6uihwj/pwO26/2TypbxBb26Nr
         +pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hO/e7bxxfSco4HCPNUGHMeBf3Fmt7HhKYRh8eGkOACA=;
        b=KDo6YceXXS/MszkKJ+1ckuPKAZX/SxWNq3d6cKq5mlQ0b475LZ5meP0pZXZw1GNGhV
         hmbCOJ+0DC4S4MzR7WF5CVo4VMfnNO+ESiaJG0XFAnQ1EvFE8c52VkOvUlP1z1uMTdXb
         tuFxvbudaHZ2x9JMWu9uuqm3hvvFbl8Myq/UJpeGa0L+6b/rVEOpAHdzi/vFC6ap3zfp
         1YncX22rQkD95BKsnAkBh6W8qoVhOJfe7P4krv4Gg6MDvgbZaq8pKckUXjL9fRh1p3Hr
         fNswxb9kvcXtx/MK1V4K+F5zdB2seB9N+GDaWtIpzrPfXpflkEHo9+aG45h6zwgPOLIM
         qZTg==
X-Gm-Message-State: AJaThX5XBlOVmVI11imzCUwxdSZSMBnoRiMUWQTvGX5d82EE5krpiEDX
        kJeNVfi22gOzofVj2LzkSWNLIJTW
X-Google-Smtp-Source: AGs4zMb2hX3YW8TTRMZh5/+bfFGhDtxNu7r6529C0JvFsO6PCh6J06LmNCiM8qq2CSZFKMC2bktZ/w==
X-Received: by 10.223.138.246 with SMTP id z51mr4733749wrz.152.1510492050795;
        Sun, 12 Nov 2017 05:07:30 -0800 (PST)
Received: from localhost.localdomain (cpc1-camd17-2-0-cust175.know.cable.virginm.net. [82.32.224.176])
        by smtp.gmail.com with ESMTPSA id 185sm5999588wmj.33.2017.11.12.05.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Nov 2017 05:07:29 -0800 (PST)
From:   Jerzy Kozera <jerzy.kozera@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Jerzy Kozera <jerzy.kozera@gmail.com>
Subject: [PATCH v2] gpg-interface: strip CR chars for Windows gpg2
Date:   Sun, 12 Nov 2017 13:07:10 +0000
Message-Id: <20171112130710.16000-1-jerzy.kozera@gmail.com>
X-Mailer: git-send-email 2.14.2.windows.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the issue with newlines being \r\n and not being displayed
correctly when using gpg2 for Windows, as reported at
https://github.com/git-for-windows/git/issues/1249

Issues with non-ASCII characters remain for further investigation.

Signed-off-by: Jerzy Kozera <jerzy.kozera@gmail.com>
---

Addressed comments by Junio C Hamano (check for following \n, and
updated the commit description).

 gpg-interface.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 4feacf16e5..ab592af7f2 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -145,6 +145,20 @@ const char *get_signing_key(void)
 	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
 }
 
+/* Strip CR from the CRLF line endings, in case we are on Windows. */
+static void strip_cr(struct strbuf *buffer, size_t bottom) {
+	size_t i, j;
+	for (i = j = bottom; i < buffer->len; i++)
+		if (!(i < buffer->len - 1 &&
+				buffer->buf[i] == '\r' &&
+				buffer->buf[i + 1] == '\n')) {
+			if (i != j)
+				buffer->buf[j] = buffer->buf[i];
+			j++;
+		}
+	strbuf_setlen(buffer, j);
+}
+
 /*
  * Create a detached signature for the contents of "buffer" and append
  * it after "signature"; "buffer" and "signature" can be the same
@@ -155,7 +169,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	int ret;
-	size_t i, j, bottom;
+	size_t bottom;
 	struct strbuf gpg_status = STRBUF_INIT;
 
 	argv_array_pushl(&gpg.args,
@@ -180,14 +194,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	if (ret)
 		return error(_("gpg failed to sign the data"));
 
-	/* Strip CR from the line endings, in case we are on Windows. */
-	for (i = j = bottom; i < signature->len; i++)
-		if (signature->buf[i] != '\r') {
-			if (i != j)
-				signature->buf[j] = signature->buf[i];
-			j++;
-		}
-	strbuf_setlen(signature, j);
+	strip_cr(signature, bottom);
 
 	return 0;
 }
@@ -230,6 +237,8 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	sigchain_push(SIGPIPE, SIG_IGN);
 	ret = pipe_command(&gpg, payload, payload_size,
 			   gpg_status, 0, gpg_output, 0);
+	strip_cr(gpg_status, 0);
+	strip_cr(gpg_output, 0);
 	sigchain_pop(SIGPIPE);
 
 	delete_tempfile(&temp);
-- 
2.14.2.windows.3

