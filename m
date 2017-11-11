Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560A71F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 16:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbdKKQHx (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 11:07:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40461 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdKKQHw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 11:07:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so1011358wmd.5
        for <git@vger.kernel.org>; Sat, 11 Nov 2017 08:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NWYTxTZC/zKI5ck1Y/k8QYufXIRvTQAOamXGAs+83hU=;
        b=DnRJQRnx7t02lr8Jf1RwikRc48+koES3EJ1OTK9rOF+/3o5oI/8L/0g0sx97UVL57V
         NZVYJeTrR6lnQPe/Yr1JYNnTYFmmNH97ce/fM03dq8Eo6tqsmd45hkq4a7LnDLWYiJXK
         X/g55Cj0ZPq25Gtvedxgn9nbQCxlvpeAY+u14QptpTmTWtteuTTDHKkEb67g64j5YBe4
         DfpdbbN38f8nUoFWomOpKgBxRIwXni8u84uIg+jxyG0B+I96yeGabqTRJ+AxoLtNZcUV
         T8A9A7mguwqqeLtueqZuPzjPXhzN7RPvEpJCb9auTD4Sp2BCbUFok0kpxv2yhm61g6TJ
         tJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NWYTxTZC/zKI5ck1Y/k8QYufXIRvTQAOamXGAs+83hU=;
        b=X9oakPaL/T/mxitDj7Rt/rcQYEC5ejzKoKTs6fChZ37gkjUwkJT5kElpibfJNB+mpX
         xktl8fNCWHsh2qdEMzpPVPaH7NOAied78FE2ZYa4n1nehQs2Jy4X6rB3r+LtTuuHjQk4
         elbnCtVp9pcemwC9H4E7vIIdbjV7jHt7iJEdxH/vewTWYEayfZYhtDHchqjSk+lj8Yeg
         Ewnwx9altBBnHwzmC0RH18aqIyrjdjKBiSQlmmdEIReymcFoJ0jMogz8+RYV5f+TrRn6
         F0bWDruOGgchiEyyEda5SdANhMFgCCISMqRujSaHq5G9YbEJkyx+0mijcll1FcZib3z7
         8Rxw==
X-Gm-Message-State: AJaThX56h1fU7KcWf90fz0ljlv1m2+isVny3LUd3eUnUIDomHwLs5JED
        Ok6BMVC+sNuyKhJSL6LDvfNdUKFI
X-Google-Smtp-Source: AGs4zMZWQqBzQw3bZNHCRfIulipwJUDbhJtvviFz9kGA9UYBvlniQXx+LELKxp5ujheHt6X49HfAiQ==
X-Received: by 10.28.107.66 with SMTP id g63mr2645939wmc.38.1510416470993;
        Sat, 11 Nov 2017 08:07:50 -0800 (PST)
Received: from localhost.localdomain ([62.189.9.199])
        by smtp.gmail.com with ESMTPSA id o8sm33209734wrc.10.2017.11.11.08.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Nov 2017 08:07:50 -0800 (PST)
From:   Jerzy Kozera <jerzy.kozera@gmail.com>
To:     git@vger.kernel.org
Cc:     Jerzy Kozera <jerzy.kozera@gmail.com>
Subject: [PATCH] gpg-interface: Strip CR chars for Windows gpg2
Date:   Sat, 11 Nov 2017 16:06:57 +0000
Message-Id: <20171111160657.11016-1-jerzy.kozera@gmail.com>
X-Mailer: git-send-email 2.14.2.windows.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the issue with newlines reported at
https://github.com/git-for-windows/git/issues/1249

Issues with non-ASCII characters remain for further investigation.

Signed-off-by: Jerzy Kozera <jerzy.kozera@gmail.com>
---
The patch applies cleanly on top of maint as well as master.
 gpg-interface.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 4feacf16e5..a92fb2f3b9 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -145,6 +145,18 @@ const char *get_signing_key(void)
 	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
 }
 
+/* Strip CR from the line endings, in case we are on Windows. */
+static void strip_cr(struct strbuf *buffer, size_t bottom) {
+	size_t i, j;
+	for (i = j = bottom; i < buffer->len; i++)
+		if (buffer->buf[i] != '\r') {
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
@@ -155,7 +167,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	int ret;
-	size_t i, j, bottom;
+	size_t bottom;
 	struct strbuf gpg_status = STRBUF_INIT;
 
 	argv_array_pushl(&gpg.args,
@@ -180,14 +192,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
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
@@ -230,6 +235,8 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	sigchain_push(SIGPIPE, SIG_IGN);
 	ret = pipe_command(&gpg, payload, payload_size,
 			   gpg_status, 0, gpg_output, 0);
+	strip_cr(gpg_status, 0);
+	strip_cr(gpg_output, 0);
 	sigchain_pop(SIGPIPE);
 
 	delete_tempfile(&temp);
-- 
2.14.2.windows.3

