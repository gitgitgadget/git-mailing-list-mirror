Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FDB11FAF4
	for <e@80x24.org>; Mon, 13 Feb 2017 09:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdBMJ1O (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 04:27:14 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33555 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdBMJ1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 04:27:13 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so7258403pfg.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 01:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmjkESklPd+xlhMFYIHUEC13UQ/Af7tSc6LttaJJv/M=;
        b=NeVQL9xAqVUX1yA326xG/WvzoM8XAJnKbuk1JDWktrv6WlM5u01RG5PEFXtPA5LJB1
         JxZSSQlcVPU/eOGvNfe9PTAnulHju3zD6H1TwTQwWbAd5GOerVvhDkowVUVJteW9Yqzk
         75znVP2Gh33kUsmuMOT4QSL/9hf7SkWKhMEd9Jw6PgHVxSREjDC4P5/Op6DIQddbMZmE
         38I8LIpRemcNXGMwP9ylkubIsFQ3RvPWo73VMIm72szoADHI6fLMOEXVJqGFyZlIwAUE
         alNPOPDV8KeCqbNFrSoIOMwKPq03HJM+TsrhKCUDcU/tejjfWr5uBUIx4kvsQ7Qm6Z/r
         MzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmjkESklPd+xlhMFYIHUEC13UQ/Af7tSc6LttaJJv/M=;
        b=r7gkwXSLt/dqXnJsmWb/E4vu+Hz3f1LOppGmOlhBnTWbtwvaWslOeu4p+7neLRT9ri
         ZcoNPtYVmkFuYhj0aTwuvyKk3/AOw0e8shMbGiViRK/zE5lD3Ws90Rot4zBRxq2OzSRu
         gzP+T6/Xsgyv+yUWyzfbbBGc5rvDEi2j6Y+LIrN4pD9L41vUjrz7nxBphbu4aoSdDJfV
         nsOnlg68t53YC6ZvWmUZ1cTTPHuYRboDo/A0ee3nl8o8Z8624SXtu+SqwtZ9hPemFWc6
         kmAJMdvfNDLufxwgGjW2qHgr2UuyRIlMdVRYyP5PWFQsFNBE+mmJ2+DG7M4tDZnodEc3
         wP7Q==
X-Gm-Message-State: AMke39nnhhxF7SZOYqP4F/+dqRje7OJmn0d3SRzclrTnWJ7OHTcleSDjjW/gTcRqzjeq+Q==
X-Received: by 10.99.226.83 with SMTP id y19mr25585597pgj.34.1486978032762;
        Mon, 13 Feb 2017 01:27:12 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id l3sm19709481pgn.10.2017.02.13.01.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 01:27:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 16:27:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] clean: use warning_errno() when appropriate
Date:   Mon, 13 Feb 2017 16:27:02 +0700
Message-Id: <20170213092702.10462-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All these warning() calls are preceded by a system call. Report the
actual error to help the user understand why we fail to remove
something.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clean.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index d6bc3aaaea..dc1168747e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -175,7 +175,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		res = dry_run ? 0 : rmdir(path->buf);
 		if (res) {
 			quote_path_relative(path->buf, prefix, &quoted);
-			warning(_(msg_warn_remove_failed), quoted.buf);
+			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 		}
 		return res;
@@ -209,7 +209,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 				string_list_append(&dels, quoted.buf);
 			} else {
 				quote_path_relative(path->buf, prefix, &quoted);
-				warning(_(msg_warn_remove_failed), quoted.buf);
+				warning_errno(_(msg_warn_remove_failed), quoted.buf);
 				*dir_gone = 0;
 				ret = 1;
 			}
@@ -231,7 +231,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			*dir_gone = 1;
 		else {
 			quote_path_relative(path->buf, prefix, &quoted);
-			warning(_(msg_warn_remove_failed), quoted.buf);
+			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 			ret = 1;
 		}
@@ -982,7 +982,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			res = dry_run ? 0 : unlink(abs_path.buf);
 			if (res) {
 				qname = quote_path_relative(item->string, NULL, &buf);
-				warning(_(msg_warn_remove_failed), qname);
+				warning_errno(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
 				qname = quote_path_relative(item->string, NULL, &buf);
-- 
2.11.0.157.gd943d85

