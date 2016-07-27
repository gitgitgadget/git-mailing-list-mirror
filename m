Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD89203EA
	for <e@80x24.org>; Wed, 27 Jul 2016 00:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758306AbcG0AGS (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 20:06:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36498 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbcG0AGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 20:06:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so4017759wma.3
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 17:06:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IZwhAq/6xN/tKTq0g95EzhJ1UNhZsRh7rugi7LK5Vp8=;
        b=QKzPTI4BDy5taR2ArCEreAnY8BOdY669VTon6QEBPB0+6S2Y/khOBYOlT6nXf9m8T5
         3+Xq+f8Qf1AC8Ii4OdnjweFKDZ6j3kEvl4du1h+Y/arc4WCEr1tGkA0xM9YmLj8OWWAe
         61yg3Z7fzlSpecMKXTBWBO8HPm492136zvfbAlZ7RK/T1TaMG0KtCfZv3oW8AdYI08Lp
         GkNgZ6EIdX5hAffZRJCCkLpud1ftIIe6jce35ewAWUvLLoksH+IRrr05aoFVSuKHygt2
         dSlqJcPYRiPPtI+3VxVFfBf1xFaOE7ipemySBVbeO/MYdSIvoj5jyylWco25/gOea7iJ
         MJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IZwhAq/6xN/tKTq0g95EzhJ1UNhZsRh7rugi7LK5Vp8=;
        b=jRREAGHEVjH/7atssYpOgQQBQbpN90y1dOg1UPeBMFY0TB1dqYv28t6du6UgZNaG7v
         Gb/cWuJerublf8GV++G1Bwmk3bmFHeqpErZsh6ZfGyZRg5x0BP3q6WwuXxlbIWn0yAtB
         9LOfIdTRX49+pXZiiCjQgKeej+6lmJH+8g1/q8Cry1WBEpr/tthYq4zX6UpuwTRE34SF
         UURnqdwlUpz8dSt9EUafVvsNYpvoEqMEbRDM3LCpMDSntXO71+y3XryAHRPC6B4/hipN
         t0z/1RqyOx76Oxdv93DBQo69DgovMiIwOHmDwOzpTanZqQeFA4yTr5e92db38aVm8eSi
         92hg==
X-Gm-Message-State: ALyK8tIsVeCI9ONA7+ZstK3Qp7bAYsBwFIOVk/Vt2FQXl+z47QhUdAyXId+SBSdLK+83Tw==
X-Received: by 10.28.16.3 with SMTP id 3mr50211416wmq.58.1469577969523;
        Tue, 26 Jul 2016 17:06:09 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB772A.dip0.t-ipconnect.de. [93.219.119.42])
        by smtp.gmail.com with ESMTPSA id q137sm35330015wmd.19.2016.07.26.17.06.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jul 2016 17:06:08 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	pclouds@gmail.com, e@80x24.org, ramsay@ramsayjones.plus.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 1/5] convert: quote filter names in error messages
Date:	Wed, 27 Jul 2016 02:06:01 +0200
Message-Id: <20160727000605.49982-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160727000605.49982-1-larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git filter with spaces (e.g. `filter.sh foo`) are hard to read in
error messages. Quote them to improve the readability.

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

