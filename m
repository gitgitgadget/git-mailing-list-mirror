Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00032C4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70B120838
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFvZx5x8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgBZKQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37620 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgBZKQK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id a141so1585365wme.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UIytmC7GTXrVPhI65c5jfqi3j18nq3mt6BWslGwoi34=;
        b=ZFvZx5x8fpcd3kJOf7PNUSfiCCfE5WRTLx7Q3CjqpdQwlWX7mca5yxut2hAmyY2ZMj
         +4nfSMSjuaXoJbok5f10Y5YwG0U3cnOa0t16XO0ClDlihTcFD7f31kc3Z1PmHneZyciB
         1Db6nB4mlU1mVUz1f3wFoRxddcxp7tX9a/AL5LaIvGqpBgzHFFJrNLdOL6oElIdietX4
         tqfc18Z5eaLWQlZwsyQjuXJgVrOuPE5W3+vdXiIZpLi3HlsVf0rCNlkYxuE2FG+YpNtk
         2g2lMtHnY6XCzAo/+lc+dGUdHsJ3Ra+qjD/iDzdh79HJufU/obLgo7OPUOBqWmuBEsCp
         7zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UIytmC7GTXrVPhI65c5jfqi3j18nq3mt6BWslGwoi34=;
        b=lp50yt7FXpgttbYcsnPduzkOgi6bFP1au/ra2E8c3kKLVPnrxfneJ2X/PaeYArQkFi
         HF53RaGM04qrJGaylIpREuCSQx6zjD+MXi3ij0n0H5UsMh/gZI9I0Lnv2aC0EyCDh4et
         8zN1LKEBkE+IcXNkp/3KNXZzBSGcznfd15I5z4DxhbbV9fUpjx7AipUpMjFFcoh83Ubk
         sXYy9KFhfAxy9xqp/YjmVT/Y3/fZUx1wsOA9tPXVhNwGfx3CJ+Q7Q6wXqYJZQAP5Kuwi
         Jyz5dfycYsNtGxZ01ASe7ERPxxnmjuWs1H+x3X2tPRSqyIEBvY+dFmjg4j2Z4DFVqY1Q
         TaZQ==
X-Gm-Message-State: APjAAAUtOm4jxpA0Rq5f8s6knaf/AJ3fLZLOtihDP8mIKgkW+tjk1fnD
        i3cZApY2ex8qYD7EzsPPsTNLHpiP
X-Google-Smtp-Source: APXvYqxtTlbwGmdLG8PM5YCAV+JEcowWEwACcD+HLEEgtk6Qtrh1WjRgNlW/v2lAO6vNuJugebjTIw==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr4760934wmi.116.1582712166861;
        Wed, 26 Feb 2020 02:16:06 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:06 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 01/10] bisect--helper: introduce new `write_in_file()` function
Date:   Wed, 26 Feb 2020 11:14:20 +0100
Message-Id: <20200226101429.81327-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101429.81327-1-mirucam@gmail.com>
References: <20200226101429.81327-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's refactor code adding a new `write_in_file()` function
that opens a file for writing a message and closes it.

This removes some duplicated code and makes the code simpler,
clearer and easier to understand.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c1c40b516d..ee1be630da 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -74,6 +74,19 @@ static int one_of(const char *term, ...)
 	return res;
 }
 
+static int write_in_file(const char *filepath, const char *content, int append)
+{
+	FILE *fp = NULL;
+	const char *mode = append ? "a" : "w";
+
+	fp = fopen(filepath, mode);
+	if (!fp)
+		return error_errno(_("could not open the file '%s'"), filepath);
+	if (!fprintf(fp, "%s\n", content))
+		return error_errno(_("could not write in file '%s'"), filepath);
+	return fclose(fp);
+}
+
 static int check_term_format(const char *term, const char *orig_term)
 {
 	int res;
@@ -104,7 +117,7 @@ static int check_term_format(const char *term, const char *orig_term)
 
 static int write_terms(const char *bad, const char *good)
 {
-	FILE *fp = NULL;
+	char *content = xstrfmt("%s\n%s", bad, good);
 	int res;
 
 	if (!strcmp(bad, good))
@@ -113,12 +126,9 @@ static int write_terms(const char *bad, const char *good)
 	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
 		return -1;
 
-	fp = fopen(git_path_bisect_terms(), "w");
-	if (!fp)
-		return error_errno(_("could not open the file BISECT_TERMS"));
+	res = write_in_file(git_path_bisect_terms(), content, 0);
+	free(content);
 
-	res = fprintf(fp, "%s\n%s\n", bad, good);
-	res |= fclose(fp);
 	return (res < 0) ? -1 : 0;
 }
 
-- 
2.25.0

