Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9C31F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120AbcHCQnm (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36548 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757476AbcHCQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so37153342wma.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbMtHEKLIvWOy0KAJuKXxxmBlJn0dnG1K5xmZ7aBAwo=;
        b=jrmhoxJNWah9xW0OIRTgUnkU+JNkiGGkeubKhpgzxUpuesR5UJg31Z92/D4+4DYyu8
         Ku0dyG3lxDI7L2KPZQgsoFIfm7d1llihFpR1A0d86yeF83YtUeNopON01KXH47XwDXyS
         1/rmYXq/njUuzyntn2yiRdxTpZyLVopR/B5rWcIDXkSA7lGEyIP9b0bK5xf/IqVqiObj
         tG2RihzwCtZLlqlIZqoZvYwJVzBRlVzP37uY/uACBFkcBKk4xP53YvukUCbWe+G04LYK
         KjI4X41kuoyqYNggDqHJ4cMQvqUZ+XB4+MYhLivsgBwNfqRbmNWx50FAz/58U65ALG23
         FW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbMtHEKLIvWOy0KAJuKXxxmBlJn0dnG1K5xmZ7aBAwo=;
        b=Gl9ovfqTr8VkQYPtpLHsmitl+clh+UrQgndLie9bUnkV7/lpRIlYlD5wUrY8hw6BTy
         tgKgESE1XvPqI2EONG22iIkEc85wowQrBqOvMQo+id1Bsmzhxau42aMdjws4EIKtE8ZE
         cqkl1tWsc4BoWdvAz7uD3ctX7RJ9169WDSvg+/lYhR7wlBV3xZC/LjxRHUie6fwb8Wga
         v34sKd3jh7m7mVT13v9jfn3ehhlppZBXAzkIyNGPRykEPPGKvivZtukHQO/f57qMRJ2S
         yRJXzotagz08uQowcXNkW7mRFuvceeWGOYNMFU/dJb1OdctA+zmzR2TKh9LKeyidHO9F
         tTUg==
X-Gm-Message-State: AEkoouvfxNJc/ypjT4ocwF0f5kZ0WSizPqZ0zrIQ5FrpPbjDDpY+pLuPO9e/dseE2qGPNA==
X-Received: by 10.28.100.70 with SMTP id y67mr25918448wmb.23.1470242556074;
        Wed, 03 Aug 2016 09:42:36 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:35 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 08/12] convert: quote filter names in error messages
Date:	Wed,  3 Aug 2016 18:42:21 +0200
Message-Id: <20160803164225.46355-9-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
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

