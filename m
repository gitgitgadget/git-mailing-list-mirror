Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4711F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfAQNIX (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46817 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNIX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so4715569ply.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zupA++7no0UrJDDcLzCYJIOjEd0u8uxTkfkYOMmSo1I=;
        b=lJkuKeewfQN0zzKHgV6jxnePQK/oeXs73o+7lwbYAmMWo21E8wLp/HoErbgIuH54Ts
         YAu8mzLNkkZjiibZVYBAf0DM9+u/JSwMNqOrf38ecEJH1XopG5rHY4kqv5GTMiBrg3vl
         oIM47eEEIYsEg8gosL1AGzHSddCIN3jwxANCvrglu0VNucZmYpauBVisYVdUCjJoDMyi
         2wcwfUzQCYOrQNXzJnxW12vSBrA+VpDkgKBmvXEv6vYxIR/seZGk/e54j7mL5yurHGYG
         VeHYzs+r2Omkrr8VoytBVrw8N17n/rn98g4alXxD65bnOf/xR1jqxZThXBfZsjP6FtVU
         swKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zupA++7no0UrJDDcLzCYJIOjEd0u8uxTkfkYOMmSo1I=;
        b=RtIgTIYNbGYkpLizCy4i1WeHRNriSww7XR1/eUf+QrrAonjg99U0wYaZ0QgecWgb8u
         NVZNpvkvjK0hAemE8uWgdVrnZOqjM15JrvWI2nKaSeuFHz7Ti1nvQnejfRQqCE26DHjr
         NDrrqLO9WV1S2uZmcpSdxd2kMyWjZMRMpoqGW1Tsnsv1DR2wbf0JPspkXBxM6dI0HAdA
         nVZs8XUnQPPQgVrGJU4LjKUZTV5PelW93+i1KMQXRvZmp/TC4rH1Zi/oRlmC6YIpL2Xu
         bHxLRCIfg56Wua6E4o9xXGOob/gcw4+Mgi0zFMC7PztJKozOQVzSqyqmRue8IqFovxSi
         ZhKQ==
X-Gm-Message-State: AJcUukcgKE4mxUil3khTMvFhWBrZVWXpVNwaJbJG8hv6EDehjPwKo5Hc
        GjeZFfpbNEGxzeS95Iv+mRf1iDyU
X-Google-Smtp-Source: ALg8bN7YH6oEc+uy/I87xh2v+9rFTVLibbGo4pCrxWwMGgqcizDsoMVXdoM28zIe+4B1WMPatP0eyw==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr15089391plb.107.1547730503039;
        Thu, 17 Jan 2019 05:08:23 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b27sm2799296pfh.113.2019.01.17.05.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/76] diff.c: convert --name-only
Date:   Thu, 17 Jan 2019 20:05:21 +0700
Message-Id: <20190117130615.18732-23-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 2ab3d68d9c..056b766264 100644
--- a/diff.c
+++ b/diff.c
@@ -4947,6 +4947,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "summary", &options->output_format,
 			  N_("condensed summary such as creations, renames and mode changes"),
 			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "name-only", &options->output_format,
+			  N_("show only names of changed files"),
+			  DIFF_FORMAT_NAME, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4975,9 +4978,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--name-only"))
-		options->output_format |= DIFF_FORMAT_NAME;
-	else if (!strcmp(arg, "--name-status"))
+	if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
 	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-- 
2.20.0.482.g66447595a7

