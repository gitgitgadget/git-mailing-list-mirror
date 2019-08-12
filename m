Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5FF1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfHLTqc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:46:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41525 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:46:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so3046875pfz.8
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNYGeO5ODNaXeY8aFA2IpaDSTCOV+n7rztBxatQy0eg=;
        b=tYF8TXSPM7g4lvX1pe5vQphhx0jIEYwmN8Y5dyuwOf4ekUBhZnJcY8HrRCakM6vj8G
         H6Qf7Z9Qcybly3BSY+nZmC9M61kYP0GwrJDmMpXcHCfVe0h3HZFlaGFbimt78eMYR4jr
         y8aL3ZiqjKgQSI/FoBjpwLujaBjo0rEr154VyXP011SVnwmOa9z1cm/bv9Bd8Fg3h1li
         GHtAE8pgfZ+cBTgL4bKbeBpGz9WC9mCVP7cJvynnoNMuubknNNOjYQU/Sh2sp0REHTuD
         9tSA8I58ZMpIAN/KIutp2zTFtxHYeolgg3rWUzpUMxS/GuMzmAfx4Rz1JoKWDxR5HsIV
         3s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNYGeO5ODNaXeY8aFA2IpaDSTCOV+n7rztBxatQy0eg=;
        b=pmBk/GVAyxgECBotpYPPGH2ZddX6/WUTkOQwxaEUVDq8uZq7mhdT1JOGnyKT9iOyaH
         lk9Y9A+eu93RY7m15iYEXWB7Z6fRskkKUzFCV7BUJ/dUv3NfShxdsAN29fE0hwmSuUBr
         za5HHzxr/NeW0Mknh3RT8O6sVCeBUYe0RRyRbnkgY5P6Lu24IHWB4zdyXosdHtD+Eq0d
         qEutSDIoKPJCRTykVU1q3xMUee2Z9CljEcFhNO8oEi2FhYGhKma38wm29vHrlmvL5qCb
         AiE4KopV+vPtlv0FodmQDfasfEh4cD9vdwPhpds3QCvkF4wto8j0eiuX93eq9d6wb5PI
         14Ew==
X-Gm-Message-State: APjAAAUNum1TyGGZcu1dsHm1lowStN6/3dviEjjY4HnK/PqD7vvHMaEW
        Xn+o4MJwv/2iy/6tL2lbPZNdBIT0qmU=
X-Google-Smtp-Source: APXvYqy5vzV2OZk7WkO5SIZ1ScDkbA/oj98ChP4F0f9gK/mxHhcKz8LpVgrXCnbDlRlyWiK8il6i9w==
X-Received: by 2002:a63:7c0d:: with SMTP id x13mr31302702pgc.360.1565639191023;
        Mon, 12 Aug 2019 12:46:31 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.228])
        by smtp.gmail.com with ESMTPSA id j187sm13275947pfg.178.2019.08.12.12.46.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:46:30 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 6/6] rebase: add --author-date-is-committer-date
Date:   Tue, 13 Aug 2019 01:13:00 +0530
Message-Id: <20190812194301.5655-7-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit introduced --ignore-date flag to interactive
rebase, but the name is actually very vague in context of rebase -i
since there are two dates we can work with. Add an alias to convey
the precise purpose.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt | 1 +
 builtin/rebase.c             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 24ad2dda0b..6a52d721e2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -388,6 +388,7 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
+--author-date-is-committer-date::
 	Instead of using the given author date, re-set it to the value
 	same as committer (current) date. This implies --force-rebase.
 +
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ed58ca8e5a..19b1fc0f3a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1442,6 +1442,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
+		OPT_BOOL(0, "author-date-is-committer-date", &options.ignore_date,
+			 "ignore author date and use current date"),
 		OPT_BOOL(0, "ignore-date", &options.ignore_date,
 			 "ignore author date and use current date"),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
-- 
2.21.0

