Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E090220705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758812AbcIHSWE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:22:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35600 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758376AbcIHSVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:21:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id a6so9029916wmc.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LJvqX5QVonW6DijiZi04w1zKc3SHx641qvpqS1HwG4k=;
        b=R7uf6mm3ZNC1atvDwa/f4qjhiJJeuDmprOuySKZtpCpkpc/VBPTzfuw3Ovno8H2mkX
         etVVuQvDE63+wzVccT9Ub9ysnEjOz6XqzdKrtFLlnQInakhqUGWR+eSwIgmfnsaAj00o
         NvDkBJFVyGaSESaKz6twLdXY1iL1hyJAL7Ev1OPHtJgLjoZJ0KGzZnrp2S+E0w56AwNo
         GyqwjJo6CVgjZ3wYhQ2ebpXXnC61fwGn6s6FsiANFck4TVXMDHpJEyJ7Fp2hjB8e8u8a
         l0ateHyGoirkfG8c90HRq7gFHXLGx0O+SG4ZDr88HDVhqKnHV+V1bRncNN3f8jZrfbOM
         4q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LJvqX5QVonW6DijiZi04w1zKc3SHx641qvpqS1HwG4k=;
        b=L8AN9puEZ3YeBHp2J4cu4h5p/mW2mg31lXXuYgk2iMc7FWxNrNyXsf3dzStdN8kFVj
         0N0TVsw9NF0ufyR9NiabppyPpzc+3y4J0Q1IQLEij+6hQqS95ZTrTzcId4bXbM6x0xVL
         YnPyV54LfVsEYTeDIsk3Jw46nUIkUIw8mTBBW/XybDJPP9NHJkRsi8cDl1fb2Y0ST5io
         cjSWKWfI2CMQCclRe0lLYmWJsMQ/RfD2xBbnP0ued6RysNpAxYnsh9dDsUHqzMfq67ag
         4hiTKohaAzQk4DDXwmZPtpOjHvVamv28r8NuBRxzDlzAzSUNsATbZMyAEEjUCOONDj8n
         z7fw==
X-Gm-Message-State: AE9vXwNxJVX77J3AMb3NGa92/qLDh305EhuDcB2dwOEIWIt65Rppp1DftEKRZJyKOCt9DA==
X-Received: by 10.194.157.164 with SMTP id wn4mr932620wjb.142.1473358907552;
        Thu, 08 Sep 2016 11:21:47 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b128sm10967467wmb.21.2016.09.08.11.21.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 11:21:47 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 07/10] convert: quote filter names in error messages
Date:   Thu,  8 Sep 2016 20:21:29 +0200
Message-Id: <20160908182132.50788-8-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160908182132.50788-1-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git filter driver commands with spaces (e.g. `filter.sh foo`) are hard to
read in error messages. Quote them to improve the readability.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
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

