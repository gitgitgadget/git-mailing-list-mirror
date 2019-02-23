Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A123C20248
	for <e@80x24.org>; Sat, 23 Feb 2019 19:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfBWTD1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 14:03:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42234 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfBWTD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 14:03:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so6259367qtr.9
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 11:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLzpTkGGuuz2c9KHoEMBVbriZveRTPqJsE9UiePug6g=;
        b=hP9XIkjjR5/teyGYBQzF1JxkmqjE1EhHnsn5C6/E6ZMXFlAwaw6T8TeAV1o0vsXZjw
         8vGjD0AxSutE7onpxNBW6EWumbsTAptrVuYkZPTIYP8q7Fo0oO7DGIBhb1GtZJcL97Zh
         0nrvbtyoqX+HAhq1tmRjCl/2C6tarqMXUOv81XxEheAChl9wuRO/4GRAShYwBUkmpDWt
         cJbOxQaAmUOg9J850I24Xc6udcx5qzQmCLzmy2H/juGgRXwwC9E5CEt3IxsaLUwferq8
         FxB2lRkXoP1kA2HZnD8j3RIc531KCGe6WqUJGYmAaEzzYLktLHQO3VJ5O8xh68qqUZMx
         wE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLzpTkGGuuz2c9KHoEMBVbriZveRTPqJsE9UiePug6g=;
        b=Obl7mp6QlmRNSmoMo6VRdCZtMob5TNWDOFt34ktLa1Sb00huIWAhXGyhzW2IMKbyuX
         SSA1wpMlcqn4iMYDEjL13JgZhAA5bNY4xWncwbfzvvoCEqN0Ag6SzjFrfkoSXCPmrSJt
         9nkY/gVNHh+9HV1MSfjhnX0gma2SRHI5eJ0UGyqBnm2A4cubPwbXcSEWWL9zaAp7WaEk
         zh0yNj8UD5st+GabcFasj1mBc1KWFvwpVmByE2Iu4ZvtN8mxKo3DeuwP1kegy/58B79S
         GMomSnVKvN1y1Ld/bQVRIHRnjCceEcz7c/KVpqfdXcV16qYUMZabjEcwoN4I1VsSatXI
         Io6Q==
X-Gm-Message-State: AHQUAuaIW705ukYWeUnw7L5k2yrSc/rq7jn+Oygqkghqpq2evak4C1iL
        i88Ms0VamZsmWk17M4rdKxsiohxBGUc=
X-Google-Smtp-Source: AHgI3IbSC/zA4npwlqkPxXhxVrydyTwdUa7X3O+7PrABnJhsjg3DBPFr//dfMjOw6MUOcCAuFedF8w==
X-Received: by 2002:a0c:d01c:: with SMTP id u28mr8130352qvg.157.1550948606159;
        Sat, 23 Feb 2019 11:03:26 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id j9sm1028064qtb.30.2019.02.23.11.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 11:03:25 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH 2/3] clone: extract function from copy_or_link_directory
Date:   Sat, 23 Feb 2019 16:03:08 -0300
Message-Id: <20190223190309.6728-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190223190309.6728-1-matheus.bernardino@usp.br>
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract dir creation code snippet from copy_or_link_directory to its own
function named mkdir_if_missing. This change will help removing
copy_or_link_directory's explicit recursion, which will be done in a
following patch. Also makes code more readable.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - Replaced explicit reference to a following patch at patch message to
   a more generic reference.
 - Changed struct stat variable name to st, which is the most common
   name for such variables in git's code.

 builtin/clone.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..862d2ea69c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -392,6 +392,24 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	fclose(in);
 }
 
+static void mkdir_if_missing(const char *pathname, mode_t mode)
+{
+	/*
+	 * Create a dir at pathname unless there's already one.
+	 */
+	struct stat st;
+
+	if (mkdir(pathname, mode)) {
+		if (errno != EEXIST)
+			die_errno(_("failed to create directory '%s'"),
+				  pathname);
+		else if (stat(pathname, &st))
+			die_errno(_("failed to stat '%s'"), pathname);
+		else if (!S_ISDIR(st.st_mode))
+			die(_("%s exists and is not a directory"), pathname);
+	}
+}
+
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				   const char *src_repo, int src_baselen)
 {
@@ -404,14 +422,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	if (!dir)
 		die_errno(_("failed to open '%s'"), src->buf);
 
-	if (mkdir(dest->buf, 0777)) {
-		if (errno != EEXIST)
-			die_errno(_("failed to create directory '%s'"), dest->buf);
-		else if (stat(dest->buf, &buf))
-			die_errno(_("failed to stat '%s'"), dest->buf);
-		else if (!S_ISDIR(buf.st_mode))
-			die(_("%s exists and is not a directory"), dest->buf);
-	}
+	mkdir_if_missing(dest->buf, 0777);
 
 	strbuf_addch(src, '/');
 	src_len = src->len;
-- 
2.20.1

