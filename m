Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8961F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfAWUCM (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:02:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36717 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAWUCM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:02:12 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so3892953qtn.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BOh8Scxv0MctDAmOYdhZrvsP2q4fqm3SZGu6H7YbkF0=;
        b=rmPu7e6Vyb9jnPUxVnM6K/gBO8y8J+FdZOPs41g+4Yja7zX0oGjZaTVN2B63dUcAoT
         eEU/0tEjPZqtRAQm3l9yKnE6IqX6d7HZcAYMvPuVfNGGlw1/90QQkS4B3cn638SvJkiV
         NJGfVK+oihxkfTlnLe5W5xxIjbaUx/3/mmHNnbKL/ft5+pEFYeq2LhlBQ0/JsHJlcN+M
         CBubtnl24A0X6cYBIr4imSJcWS0K/LhJYzHlLaGKue/baXrKVBT1+eLVcgtnL5ZZZ6Yf
         KdXEb0kwuR/c/9qiQGvgxhTvl84eUzGb+ry+cvSAoaDVMLG8MuodsotyJ0NzgHKdreWT
         QySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BOh8Scxv0MctDAmOYdhZrvsP2q4fqm3SZGu6H7YbkF0=;
        b=QVwjW9bIojOiaACFTdwABd12X5AyUndaWT4g2Csv12n9mlMwPZXya3CC8PaoPxVWp+
         4PntQR0AevWILIMxlYsEjwRL1x0zWd1vHdcayC2MJ3iz8IWgUtcazzpiHqWeUyGNLV8S
         SZulFLrKKq96r9tJ7E2QDagcg6+jNr5bXOZNs5SBAlcXnwHT/G3kCeXOz232zvDN4CF6
         3P3cP9XvrkNIrCnY/dCQacyPyCxOfMNzwN5/8gLox3U0ZZx7CRjhSiljG/oD73YZPN4i
         k/izyHwYkDdIHC5IForNMkL2iuJI8rt2vOJ4iX2k6kWWKCOtSJyGPQL1pxicnLaNuHVs
         IHxQ==
X-Gm-Message-State: AJcUukdcrmDKs+8sSLfa1JwikoxhXGia6Ry86xys/rqsrKRIa/1OoPw0
        oNh+zQ0nxccBYKKSLgCyroIUdqRM8ZY=
X-Google-Smtp-Source: ALg8bN6DVouLNSPDpiHdAERJjC+f+fmLEufz8lEj7QD75m5wZ/gYeefTQf4l2SFuG4MLGrhnISxn8g==
X-Received: by 2002:a0c:e509:: with SMTP id l9mr3248976qvm.34.1548273730456;
        Wed, 23 Jan 2019 12:02:10 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o2sm55252042qtp.48.2019.01.23.12.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:02:09 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     asottile@umich.edu, benpeart@microsoft.com, gitster@pobox.com,
        pclouds@gmail.com, peartben@gmail.com
Subject: [PATCH v3 0/2] Fix regression in checkout -b
Date:   Wed, 23 Jan 2019 15:01:59 -0500
Message-Id: <20190123200201.7396-1-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <20190118185558.17688-1-peartben@gmail.com>
References: <20190118185558.17688-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Minor update to comment from V2.  Also wrapped commit messages to be <80
chars wide.

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/fef76edbdc
Checkout: git fetch https://github.com/benpeart/git initial-checkout-v3 && git checkout fef76edbdc


### Interdiff (v2..v3):

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9c6e94319e..9f8f3466f6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -593,8 +593,9 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	 */
 
 	 /*
-	  * Do the merge if this is the initial checkout
-	  *
+	  * Do the merge if this is the initial checkout. We cannot use
+	  * is_cache_unborn() here because the index hasn't been loaded yet
+	  * so cache_nr and timestamp.sec are always zero.
 	  */
 	if (!file_exists(get_index_file()))
 		return 0;


### Patches

Ben Peart (2):
  checkout: add test demonstrating regression with checkout -b on
    initial commit
  checkout: fix regression in checkout -b on intitial checkout

 builtin/checkout.c         | 8 ++++++++
 t/t2018-checkout-branch.sh | 9 +++++++++
 2 files changed, 17 insertions(+)


base-commit: 77556354bb7ac50450e3b28999e3576969869068
-- 
2.19.1.gvfs.1.16.g9d1374d


