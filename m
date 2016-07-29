Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F761F855
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbcG2XiZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32973 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbcG2XiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so17701137wme.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbMtHEKLIvWOy0KAJuKXxxmBlJn0dnG1K5xmZ7aBAwo=;
        b=cMj5mCMdjoni6tQEOFmCz3pjgAb3TC3f9d9W7JXIAtnhNiWGw6wONap5w0z7pcPqZh
         WIhG59X92FwzqY7Xx9UGjax1NZCANjLpJ0GOhDhXJOnVYOOlCLbCsSegA0octwRWokzP
         jUdbCSdpQ49D/j9iI+0Eikt/XbE5TcEu5BhF7ld5MqUHBsyIz1O9DgikZf4ts7UOJWbR
         Tyd1hIWZ4i42FtT5SVQ4O9qZq8TxBTpYyPhrFKpYzraUtwXDRFyu7sCwJy0fAcZRWBCz
         uOcdSxQQI1SEOzRuavPKQbxikq/8E7Otb9Mm74MeIfGELAVVOk3ZmwzH6p4YBjnnd2cp
         7o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbMtHEKLIvWOy0KAJuKXxxmBlJn0dnG1K5xmZ7aBAwo=;
        b=Mq54s9QAXR4SH5+9d8832USFBNYkk/xgX3jhO+5ZNWG469bFmz0mvBjLQlBoNl5mwn
         uUayL+IaI6klWRESDrxk2AwrmwtMv4eGCV8QajIxC6TFKZ69U+tJukzFwGG2v975Pldu
         U7EnMVZ6IAz1ehAhXTZqjhQXUiAc7/dpNsA9LA/P6ovAYv4PFZ4FTLpVBF/tUAscLBen
         n2YLEvKEgJIJMSFrBzin5f7LMHVHJ/LBzxtTJgQ+GEW5aAA0A0kT+RCMXqxDJF+qgIsl
         mD351dLOjIP9Jr2JBKScnuBRArp6C/yDSlVLy9MSLzC4ZgkFj1Plx6SU08P+TQjAfwTX
         lH7Q==
X-Gm-Message-State: AEkooutR9PihimcKJKq2l/a3c5lQaSo7rS2yUuOBUgiJO4cZjje83jUw/K1hpk/PRsDv/Q==
X-Received: by 10.28.25.135 with SMTP id 129mr3140927wmz.59.1469835493666;
        Fri, 29 Jul 2016 16:38:13 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:13 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 07/10] convert: quote filter names in error messages
Date:	Sat, 30 Jul 2016 01:37:58 +0200
Message-Id: <20160729233801.82844-8-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git filter driver commands with spaces (e.g. `filter.sh foo`) are hard to
read in error messages. Quote them to improve the readability.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index b1614bf..522e2c5 100644
--- a/convert.c
+++ b/convert.c
@@ -397,7 +397,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	child_process.out = out;
 
 	if (start_command(&child_process))
-		return error("cannot fork to run external filter %s", params->cmd);
+		return error("cannot fork to run external filter '%s'", params->cmd);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -415,13 +415,13 @@ static int filter_buffer_or_fd(int in, int out, void *data)
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
@@ -462,15 +462,15 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
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
2.9.0

