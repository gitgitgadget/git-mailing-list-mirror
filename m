Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D901F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfAQNIn (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37266 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so4819361pfb.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vb1V6ov/xilXaHIISjL2f4LhZXf5pLfqjJuLnWkyMPU=;
        b=UWXhDH28fu5vxZ67IW9F91h4nCPDGAmRNQfRumeropvnk1UVNgM50KzLfKYLgUNb/p
         OFKVrIopY2iRCuy3ywZ+kfmr9HeolnjxIh4CSwh6AWncXDnXlFY6puQJnU9vyWQogxz2
         qRxobFh+iCQHBDSzIFeXoQHQpLkibX5+OkPk5FsHdfCKMWYSKDnvicwA3v7APctBl7rh
         KvVIdlUifP8qNC0KApqf5ksxZQ6DJ9AopkLdYh/+7sYy6+SBRkGdPBB3h/EK0HkiCZSq
         +2nUQEsC+deS25VC5dgmAMhtz9KpG5JWFhSvo1NOvZWFoTi18ON1PpQNVdIuoA5pA7xk
         uG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vb1V6ov/xilXaHIISjL2f4LhZXf5pLfqjJuLnWkyMPU=;
        b=tkpkNohUEdf48ZQdZnO1i1ENDBy0/ZZSLsItZ71vk/jibQPXAOWi9x3BZ6sBMdtN+H
         h2do+P8vmo9PoDqOfij5IijP+XLBEKGgvtRXb0zbkqIiC6f0L5+PHL5XkZYFcx4o604Y
         BUYCrAEO7qUKhPzL5u9kOv2DCT7XOJyFPT+cWlya5w2unRIcIpv5y2gLd8xEZO4CL8yL
         tIGprsFWZYoig0ir/e/k9TMrVah5AnicmYNisdPtFn7pxtaJA/dm2JKPzsXRdNNxGbiw
         QVNWveXwoj/dT4lrXWza/K97QeAC9S0SKszmYBN35qMpUaKyfuypJVaInHioYK9pvxWP
         lg9w==
X-Gm-Message-State: AJcUukdBFg/Zgw7xJqQ/bLps/OQaKPC+OT7NBA94ezGe9QpnFgcaG8nO
        lJKBdghZzya+x8qhYJo5H33BzofT
X-Google-Smtp-Source: ALg8bN4uXRCFdvaVowZVlNi/E4vAGWipJqBDGlkUXluvsuRNQLgHkjxbjUwrcujFJK5Pzvya137bCQ==
X-Received: by 2002:a63:ff62:: with SMTP id s34mr13452399pgk.325.1547730522270;
        Thu, 17 Jan 2019 05:08:42 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x26sm2879264pfn.50.2019.01.17.05.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:41 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 26/76] diff.c: convert --[no-]compact-summary
Date:   Thu, 17 Jan 2019 20:05:25 +0700
Message-Id: <20190117130615.18732-27-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 1b01b36507..48659a10c0 100644
--- a/diff.c
+++ b/diff.c
@@ -4844,6 +4844,21 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_compact_summary(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	if (unset) {
+		options->flags.stat_with_summary = 0;
+	} else {
+		options->flags.stat_with_summary = 1;
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
+	return 0;
+}
+
 static int diff_opt_dirstat(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -4950,6 +4965,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "stat-count", options, N_("<count>"),
 			       N_("generate diffstat with limited lines"),
 			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
+			       N_("generate compact summary in diffstat"),
+			       PARSE_OPT_NOARG, diff_opt_compact_summary),
 		OPT_END()
 	};
 
@@ -4978,12 +4996,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--compact-summary")) {
-		 options->flags.stat_with_summary = 1;
-		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	} else if (!strcmp(arg, "--no-compact-summary"))
-		 options->flags.stat_with_summary = 0;
-	else if (skip_prefix(arg, "--output-indicator-new=", &arg))
+	if (skip_prefix(arg, "--output-indicator-new=", &arg))
 		options->output_indicators[OUTPUT_INDICATOR_NEW] = arg[0];
 	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
 		options->output_indicators[OUTPUT_INDICATOR_OLD] = arg[0];
-- 
2.20.0.482.g66447595a7

