Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF54209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932987AbcITTDS (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:03:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36514 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932933AbcITTDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:03:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id b184so4913474wma.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w5JTII9Cch1JZSmMCaMI98mX6ENRQdQ+ECxCbdlsA0Y=;
        b=03UEDnWnTRYhKV0U4bmQZA8orWFFkw2/4ZCJcL63lg8oxi5MRMV8Byue5z21JL+EMw
         7UsdcPZO2X7fwFq8imjwWyQqUJ2BiMOUWZn+YXH7PIPAJnwodz9mHQz/+VBEof8R3OoH
         vhi3VQ0T/4lXuygLo7C4xDECXK3GlQDgGddnpBSl7zJPi1Kyc2skwy7sUgalC8MVbiht
         8FfNXMA/tz+rXTVSVwUNj+6N8+vpt8bRBIbmtIczy/beus5Yh0V86xGcDpBszNln3mfS
         eWe6tirz8hkHLqyTQZcg8jpggzH1AnzrwD1v+mRsEbVehfriZAttTgjJZHp2JRBMdhde
         fTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w5JTII9Cch1JZSmMCaMI98mX6ENRQdQ+ECxCbdlsA0Y=;
        b=dnN6DrC3RFuje2Eq7folf65Sj9WzDLuFKPJ31i3iNUhYlhsNqSCxmAOuZ3JUbDAHWM
         AbShuv4GxWxKa1HpGbCxcfGeaSFARzu/RQfcBxEFlUFP4u7euzBqRqLsKGlFMPTXfMho
         Eqf0Z+p26MO1S3lq4ngEiIDp5yCaVP26j4g5j4WPQMkTrZECauMHip9/0sQmSnUP6/Qx
         9WbHQ6z5hMFmUAjtTqL9Dz4EjdhwEj3nkRITR2bAaKgtI5hu1OBCmuz6LyO5gGg+RAZ3
         1U2ZWlYaZuWZFharDFe4ayrBmBD72L2fBmRum3UgSJQG9O13fsDO50chxJ/L0adDmEpe
         I7Yw==
X-Gm-Message-State: AE9vXwMZY8IMuv1w/QIhkkYifIodKVKkLxuZXN/mH8LehKE0/RobX0sY2ulVdfyS1b63Nw==
X-Received: by 10.194.72.133 with SMTP id d5mr28558256wjv.96.1474398180384;
        Tue, 20 Sep 2016 12:03:00 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.02.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:02:59 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 08/11] convert: quote filter names in error messages
Date:   Tue, 20 Sep 2016 21:02:44 +0200
Message-Id: <20160920190247.82189-9-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git filter driver commands with spaces (e.g. `filter.sh foo`) are hard
to read in error messages. Quote them to improve the readability.

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

