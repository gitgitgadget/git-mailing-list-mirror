Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B051F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfBPLhQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35689 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so6094226pgs.2
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1L6nnZ0CQOEd8nqEx0K4c9mVLDHGNdTtVO2eemjkX9A=;
        b=XomIp+KVHkWw5TZ0mJBe9oBM/JJZef/Npq9iouge5847d3rjdrz2ISD/H0kOmv7Siv
         KveVWjeMkhEgYNkimG2sCSpBzbP63Jx5pMrYyMOOqwcR0ajVqd90nXFbfO/tsccAobTo
         RI5Sly3ANpYyyBmiqQzUHsxe+grmmzphhw/tLMNcevKqCXH0Sk3znMHSk/d2ba1cA19O
         bb2NKMMTdfmOlWGXcxuv7q8AuU9AmeD9vge5gKDeUiWfeKzi3ebUzXvGC2ABedO6o9ta
         wmBTmIYFcP2B7v/uX14vtgRWwv/Ya5wMNKjD8ZAeN53Pk+j9QP92Y2C9fpXoZh+W7Smx
         MPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1L6nnZ0CQOEd8nqEx0K4c9mVLDHGNdTtVO2eemjkX9A=;
        b=Ewb1/rvmrG5cpPpwU6jEEXFzEopcfcF6FuUT+8RutuhKpkfCJ4DG/+mLjQ3Vm4PvxQ
         TK1Z4duSwJ9ejR14FAvU+EU1RiJbr7VJ7Z94CMeCuZsOcuKRhMwZtL+Al93QzWO/bzQk
         wVBvct/PuThZTm1HBbFQd152ve53TXMSgfMqdTDEmgNdPEZNXP5jbEmYiyVkkIdpoy9r
         LAxQni17Tc6bMq56p9VLjG7v6cfRGKnO8ia8jIpHjeBbTYNRtmy72SNbJN2KzzFSivZS
         5o+iyyFwf99APYJDPtvM3yHP6raPnjNoHunV+/h36HdAKNxz8DFiBpPSf6czP2wFE0fV
         C7GQ==
X-Gm-Message-State: AHQUAuZLSHxEHUaQ4aZIMUjNK6EaU5vtmAbgzvOXhEwPztwfDIa0k3Bi
        KcaTGcOkk8EkQXaHkLlOWY0=
X-Google-Smtp-Source: AHgI3IaTae7s25NEEzaDc+YvgKLrk5XrFQNcMr4YYAL8ghVQZDvrju3RE2TVnPFXUfu+BDZuHhR21w==
X-Received: by 2002:a63:5153:: with SMTP id r19mr9775255pgl.281.1550317035818;
        Sat, 16 Feb 2019 03:37:15 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id w10sm12717473pge.8.2019.02.16.03.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 01/21] diff-parseopt: convert --patch-with-raw
Date:   Sat, 16 Feb 2019 18:36:35 +0700
Message-Id: <20190216113655.25728-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 4bc9df7362..12e333c67f 100644
--- a/diff.c
+++ b/diff.c
@@ -4901,6 +4901,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "raw", &options->output_format,
 			  N_("generate the diff in raw format"),
 			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
+		OPT_BITOP(0, "patch-with-raw", &options->output_format,
+			  N_("synonym for '-p --raw'"),
+			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
+			  DIFF_FORMAT_NO_OUTPUT),
 		OPT_END()
 	};
 
@@ -4929,10 +4933,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--patch-with-raw")) {
-		enable_patch_output(&options->output_format);
-		options->output_format |= DIFF_FORMAT_RAW;
-	} else if (!strcmp(arg, "--numstat"))
+	if (!strcmp(arg, "--numstat"))
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-- 
2.21.0.rc0.328.g0e39304f8d

