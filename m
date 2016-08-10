Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025531FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941352AbcHJTUX (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:20:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34407 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934758AbcHJTUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:20:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so11453288wma.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:20:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l2iQKCt2Zpya/LFK9OCZVoIyF3QQ2XMFUaLD4ngOXLY=;
        b=u9/wOS7xUyfhgMPI59OE1cTxjjoOvOQbvkKvkplM/LZVrqi1tWnwpp5BGU/P24+ykJ
         bSolLw0Ikv8aec7P70NFd4iRe9R/d/MvIKTwHl+KamcAYRaWmRg79UCG8o7XDnUKn+sK
         rGtx89w+bBjMR1DZ4UnfhViUU9XN+m7Ewebfwi4tngXPzwCY1PWjkbjWGIhjCEtDMF7r
         0cJ3zpeDkh7Zov2t7tdCuZWiJxgxk7zaerYLoGt0PZdTE7J2i53Wha2RFmz6q3PLeA71
         GVU1jh55iUIXbQOyzs+sAVDOL8rZRHynubFV/t8S9ryR1ntvcNCEfTmRF3v7Sdq5+CJL
         0ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l2iQKCt2Zpya/LFK9OCZVoIyF3QQ2XMFUaLD4ngOXLY=;
        b=iYAh+uDEFhrfw9l6Sxj4AJhJKl9L51zNQhMqvpnf2q3rYnsBfuqtd+T2O9EUlgk1F8
         PtaXYGCHm9Yev7+6qnTODa/YDoWvGoe8eyAFJgrNdZ8PTBfYQG9bZDqZfMceLghb+0rF
         kep07vSqAKvST+dKUgKSMRPcZRGmSn/GXNbk2HU+Tof52D2w9DH9eCf/kXnFbfS3ZjTa
         IWs0T137c8xNV2ntSnIk1eDzDTT/ZnEkVeAQ1rHVok29eQPpVRYgkXmzkXjH8rriyxK/
         0cbj+6Yp8bIftVz7KLLMMFRk+mGljiaiN07rqfqABCHa0hhyv9Bs16/eoGOTmGr00gVj
         o1yw==
X-Gm-Message-State: AEkoousIbTNKowwYOaxIMM0b3UfqeKai3ISvfq6+RPxB8CPL9CW2VrKk01x+IsFW/9jdbQ==
X-Received: by 10.194.29.102 with SMTP id j6mr3741787wjh.99.1470834263182;
        Wed, 10 Aug 2016 06:04:23 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:22 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 10/15] convert: quote filter names in error messages
Date:	Wed, 10 Aug 2016 15:04:06 +0200
Message-Id: <20160810130411.12419-11-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
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
2.9.2

