Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723F81F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfAQNJR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43545 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so4425976pgk.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGdqMmClpay4bkFolrlOvKKhtmBNEfWWf4n0sSoTNmI=;
        b=ZbGQPqmdqWbdVN+OFVq3eeqcl5i8j1+mX24gEb1k/DYkiYIcQ2Abn10P16U42kRNYe
         TxHzD9kvM16rhJYagEASU0H4RvxYbgy1OsSzyZjNpvv9zv46WuhmD2lQ7abvf2jtyfF3
         PTRb1vTCurWHbT/PNGMngVvCnS9CnBvVOSmJ73s8pPrQBHg2DLkxBPBWZbSpMqJbI53Q
         ILIq13C4CfJK7lR4EnQk6d+1cYHeaRqWzGKV3ybKqNHPp9qzmMjmR2UTDEHQjp7F4K55
         8BpFN0UKJy5PKRg+Prlo3jgT2B91ZNWiCVo+wz789cGZDIqmxBcXqwnjm4+EAwCtBs7p
         aSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGdqMmClpay4bkFolrlOvKKhtmBNEfWWf4n0sSoTNmI=;
        b=ZayXumlR2QOhzb+ZKa8hM0b64gNEgcWRSOjE3qR4LWX6Vd2eg5FSKcuytSMXpURg9K
         vYUBDtHeg6v28J4nkOZt31kPQzueNjkrcZTUTQWiM7QzGv5MBTz1djNCsxAbHEnUVaY1
         R4WmJqtIOMgf22yO8KCXsnqAl1ZHf4KJg+762lONd/KyfQ6+RXwNO3Y9q1/0qxV5ngKt
         R8mPhAzCER7YAuN/lM5LKV85za8WlZqZIqFewS0YboTMGxi2doVNHSB0kgju/Q+4zU5i
         brqV4suzHFOfUICCypdw8mdPa6oXSk2Nopwf/JeaiNFk32rPhb02l+aovyJVw1ZOIGF7
         Hknw==
X-Gm-Message-State: AJcUukfN8HQFZQEvFOAsm9r3/X0OgTRgdiRgJOz2viDMffVRSCE80Hj3
        ASlSlXxuYSxzTS/baKzn4lOiXmzd
X-Google-Smtp-Source: ALg8bN6MfBic6Bn1C+4BacLaP3faQ6E0T6XKq8IA2H5vw1Bzk0JLRee4YzmmNTvZSls40o/9Cy4P3A==
X-Received: by 2002:a62:509b:: with SMTP id g27mr14991931pfj.48.1547730556000;
        Thu, 17 Jan 2019 05:09:16 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d80sm5698859pfm.146.2019.01.17.05.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 33/76] diff.c: convert --no-renames|--[no--rename-empty
Date:   Thu, 17 Jan 2019 20:05:32 +0700
Message-Id: <20190117130615.18732-34-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For --rename-empty, see 90d43b0768 (teach diffcore-rename to
optionally ignore empty content - 2012-03-22) for more information.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt |  3 +++
 diff.c                         | 13 ++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index d3e8d634b2..4c0d40881b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -392,6 +392,9 @@ endif::git-format-patch[]
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
+--[no-]rename-empty::
+	Whether to use empty blobs as rename source.
+
 ifndef::git-format-patch[]
 --check::
 	Warn if changes introduce conflict markers or whitespace errors.
diff --git a/diff.c b/diff.c
index 0756612eb0..fa666ced61 100644
--- a/diff.c
+++ b/diff.c
@@ -5091,6 +5091,11 @@ static void prep_parse_options(struct diff_options *options)
 			       diff_opt_find_copies),
 		OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_harder,
 			 N_("use unmodified files as source to find copies")),
+		OPT_SET_INT_F(0, "no-renames", &options->detect_rename,
+			      N_("disable rename detection"),
+			      0, PARSE_OPT_NONEG),
+		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
+			 N_("use empty blobs as rename source")),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5125,13 +5130,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (!strcmp(arg, "--no-renames"))
-		options->detect_rename = 0;
-	else if (!strcmp(arg, "--rename-empty"))
-		options->flags.rename_empty = 1;
-	else if (!strcmp(arg, "--no-rename-empty"))
-		options->flags.rename_empty = 0;
-	else if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
+	if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
 		options->flags.relative_name = 1;
 		if (arg)
 			options->prefix = arg;
-- 
2.20.0.482.g66447595a7

