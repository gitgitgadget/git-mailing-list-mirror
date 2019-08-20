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
	by dcvr.yhbt.net (Postfix) with ESMTP id 120351F461
	for <e@80x24.org>; Tue, 20 Aug 2019 03:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfHTDqM (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 23:46:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36971 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfHTDqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 23:46:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so2386156pgp.4
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 20:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5jJ1BJOSZJsi+CFl0UYyjyIEo71xb+zp0e5iflw64M=;
        b=WOOsQ7BgDd01KyFvK3Bhk+iugO5iSU11PgD49AW2kHiIoavrKIri13rLYLCoV5tqyb
         1zn7mz+d+W6CoJU9OXYsor5SCXjRDze26/TWdhUZ7g+RmPuq6Fmv6Vk392QiWr8guMgL
         zGnmgYzKRnlpCGc2BDxxC+hXMUrzjdl6VPhqYC7O9Og68N2kSZ7SAnSs9DcVEA+SKW40
         ul49TWEliP0p3tJ4eCd2Pi7q+fht5FYQaKxOgyY8lZiXggt95XeCiYfo0YndPDIDGun4
         tjCNIB+aY5uXW3GCaTg/2bHWhe7hjy5a3/Um4c0Cxrhn7iaK1DMgxDJv13rcYRDPIb9b
         pobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5jJ1BJOSZJsi+CFl0UYyjyIEo71xb+zp0e5iflw64M=;
        b=qrn6evWKGPhWVsqzj8HlveMGnzoJfyjE2ANgUpyU9OZpuXyCkBVYtIo4WDBE3rkXbD
         6p+nI/f2XDIDaZgXP/5o6S7VqnjqL1oQ/Qu4BinJVV0o+sWX051piTsE7f/JHb0x3fpK
         2BqtKx+YoHdBJB9h7vqU7YQ70uf0Eevu4FE/YGDZMBKH/lekb1TSSp3gD7F7wla0+jG9
         6r2FSqLX6hqw/XLGnmOREh8vw3Jhb7dLVm2Ii1UIU4XovVmUcZwOOUP6CfjurXhDFAwI
         hd7m88b9DXBQk3zy6csqMwLzsTYIbghLfDAhOL5S7GQnyN9eTrAnfcrXkV3bFTM/sK1r
         4e5Q==
X-Gm-Message-State: APjAAAWzW9jHfXc4+DibsB4dCco0Rf+OP/sf7qqcyGioawTGp4rqib7H
        yfAWMQWS5TKQs9SYKDXS5JE=
X-Google-Smtp-Source: APXvYqxcLgkKGpIM8Qoex+lMrUwdQmQnb4TL+bWIu2tVqZFVkIPTwRxR9+tJQX/yb3nWh8ItYy5C5g==
X-Received: by 2002:a17:90a:32a3:: with SMTP id l32mr24753404pjb.14.1566272770752;
        Mon, 19 Aug 2019 20:46:10 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id v67sm30115686pfb.45.2019.08.19.20.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:46:10 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v3 6/6] rebase: add --reset-author-date
Date:   Tue, 20 Aug 2019 09:15:36 +0530
Message-Id: <20190820034536.13071-8-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
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
index e7ac9fae0b..ec62ba36b8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -391,6 +391,7 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
+--reset-author-date::
 	Instead of using the given author date, reset it to the value
 	same as the current time. This implies --force-rebase.
 +
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a63531ee90..dcf758845b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1431,6 +1431,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
+		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
+			 "ignore author date and use current date"),
 		OPT_BOOL(0, "ignore-date", &options.ignore_date,
 			 "ignore author date and use current date"),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
-- 
2.21.0

