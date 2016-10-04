Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E584F20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbcJDM75 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 08:59:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34369 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbcJDM7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 08:59:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so14420895wmb.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrzgIBvtvrHCvICiQYnRQrYeRbiyutEjyFUkgwqd5sI=;
        b=n4oIXWcZ0k1TiNCH1jRX8vy9u69DwrJbO2OR7PBmHN4h2Hg4BAcbqb2lsWplIbDAr+
         7hOOmy0AZfc50TPPPDQScr+AGqE6A9WAssCTyrTDkvKsDdsjaFcmL3PBjquyVBvp/+HR
         bKqYImGuhgK8igbNp56sNsRMg0xAekJLYIlYIraArFTdtxyrXdr6VIM6JzHSB5RSBm2p
         LvkitN6z/5nKw9ojGyoeb76nekRe9BUKm5mMbPSHb3leF6tWxkbB9iI4kMcrljwu8fE4
         1kfQ+kR1uyZQP2EZlzZCgTzJWRANwh7nLmX9JQO7m7oCksxSSLV3V43vv5lTYIUSQBOm
         DCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrzgIBvtvrHCvICiQYnRQrYeRbiyutEjyFUkgwqd5sI=;
        b=BtMFw8Wwq6ClY/7k64k0pMgjBpT0G31SLUNzZKetQyQZfjAwcsAqKsMbT2t+aPjBr8
         3bVx1KtbEbLwt0KNfZyYQwkhnfrCobWfrb9+VLBH4px5nlec4Laz/Di6EfthzGaQs0m3
         UawIoovOQv0h7DupPrBSN9sI0Q17H3r07qviPtrGWjZ7neLIMdmBOEQyhElQdtzGT0Cl
         Je+O+vrLCLDt7VGhGefldD75jbzTqNZlqCz6l1TMUHtbscHE/ouP+0/xImcUv/gOWZS4
         D8+XFxLX7Rgu3ehyN/d8/+rEO0kB1MFPfcIKJ/QO9XYGY99o7wstK3qI3f1wHisZ6/Zd
         k1Ww==
X-Gm-Message-State: AA6/9RnyaH6txPbL/YpXj7mi7XHsiqcPV+SPSn/GOM0ck1mH2kq0/ddsW/RPIEEgN8IHuw==
X-Received: by 10.194.35.170 with SMTP id i10mr3699239wjj.232.1475585992605;
        Tue, 04 Oct 2016 05:59:52 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.05.59.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 05:59:52 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 01/14] convert: quote filter names in error messages
Date:   Tue,  4 Oct 2016 14:59:34 +0200
Message-Id: <20161004125947.67104-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git filter driver commands with spaces (e.g. `filter.sh foo`) are hard
to read in error messages. Quote them to improve the readability.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 077f5e6..986c239 100644
--- a/convert.c
+++ b/convert.c
@@ -412,7 +412,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	child_process.out = out;
 
 	if (start_command(&child_process))
-		return error("cannot fork to run external filter %s", params->cmd);
+		return error("cannot fork to run external filter '%s'", params->cmd);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -430,13 +430,13 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
-		error("cannot feed the input to external filter %s", params->cmd);
+		error("cannot feed the input to external filter '%s'", params->cmd);
 
 	sigchain_pop(SIGPIPE);
 
 	status = finish_command(&child_process);
 	if (status)
-		error("external filter %s failed %d", params->cmd, status);
+		error("external filter '%s' failed %d", params->cmd, status);
 
 	strbuf_release(&cmd);
 	return (write_err || status);
@@ -477,15 +477,15 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 		return 0;	/* error was already reported */
 
 	if (strbuf_read(&nbuf, async.out, len) < 0) {
-		error("read from external filter %s failed", cmd);
+		error("read from external filter '%s' failed", cmd);
 		ret = 0;
 	}
 	if (close(async.out)) {
-		error("read from external filter %s failed", cmd);
+		error("read from external filter '%s' failed", cmd);
 		ret = 0;
 	}
 	if (finish_async(&async)) {
-		error("external filter %s failed", cmd);
+		error("external filter '%s' failed", cmd);
 		ret = 0;
 	}
 
-- 
2.10.0

