Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD24207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935046AbcJHLZj (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:25:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34551 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbcJHLZg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id b201so6641811wmb.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrzgIBvtvrHCvICiQYnRQrYeRbiyutEjyFUkgwqd5sI=;
        b=y7fooW18lTea6Vs+p3wmJs/FcXZTnMWp7paDqfAvQs6VPd2o1hVY4s8EEsupvLgmpK
         5XXCCFgi7N4O3oy+rmylUwn+TYKwNVteJCBbSl1WviwCUscQ78T3HwlNOWx+uB7bce2I
         eYOJqyZ3nQ8He7EUjk5xF6v6OSL4FGrpOoSRshOQ6ZyJdWVBechhqVahB4wlG4Uu3ZBp
         +X3HdRyK93Zyz2DC3bvtuI1KPEKm7zizQNqBm+0UOG6AtgX4ALNU2gkO+YLrNJPTvRsq
         s88kZ8wjHhNKvMmRT8XkXJjZ4mJuYnhiQQY3oVoqb4r4ef52wAOa0HjviloJv/BVznKT
         elRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrzgIBvtvrHCvICiQYnRQrYeRbiyutEjyFUkgwqd5sI=;
        b=TrWNlK7yBPmfOXR8x32bf3nBaD6lfADC2NbgM98FjS+GddVd4M03Q5YYOBkaR/XTap
         RLgleyEuQsAEtj5Wc5DxVxFzw65FsPo4tkV7RICjP7Pnv9y+nVsuAFAGeVJvzRcfkJRZ
         2yzRhc36SB4B2DkD2yAvIvkzSEU+/RzAxMSIVBlea9UzdzrGOows3rHIeVp3w90/PQHQ
         9fMP+SlSfO8Mx/d8pWY4J93i46+RH2NgzLadpy8bnlGaG08vqUcBArOKllVu2GpJToz0
         eUNPPPx9W1LJlW9r7/AW3H5a7K3JXanb3P9G3zc4yWDbZXqzYaD5atUCdlh4eKO2htfX
         QHWQ==
X-Gm-Message-State: AA6/9Rl9BbbHDsOVPCiSyFpE2T1CPBpvEQZ4rEhzFmpEQD3kFpym3bi1BrAxF1+vaCUv7Q==
X-Received: by 10.28.210.21 with SMTP id j21mr2888098wmg.74.1475925934902;
        Sat, 08 Oct 2016 04:25:34 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:34 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 01/14] convert: quote filter names in error messages
Date:   Sat,  8 Oct 2016 13:25:17 +0200
Message-Id: <20161008112530.15506-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
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

