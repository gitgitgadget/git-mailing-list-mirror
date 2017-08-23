Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD47920899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbdHWMiq (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36656 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbdHWMip (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id c15so1354376pfm.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wV9c+9OYYU29Azr7RmWPnKaBV/oUt9xO6oJnJ1gVikk=;
        b=uR2c52YMKIrzySf1og9fy/oWddzo3Nr+/YqNfHMUcqqENdBCDglytvEXXTd7s1uFJi
         ZRFXElImIpdf6MgCfdGuZMyHVuDjGTrQBflB69dBGlCviC+Cqz/mzYL3NfbSKaZa4MX+
         r8sCPfhT1J9RHwWjjxEAOQdqoaYA1nR8JbID5RobszVnYZBakKP7PyAIpEOrhHxXCkQz
         TZLBh01+Q2O6zWmbFWcDxIqSZoNGPjQG6nbafjwa6AxmOYu+8UGh9yj4ztwc3rlEUMw9
         grkmHXo26jC+mYxV/14uRh39KSflCvoy+HxI2pYlgjIsvI/csSFU2UN26VjP4yfCATe+
         yxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wV9c+9OYYU29Azr7RmWPnKaBV/oUt9xO6oJnJ1gVikk=;
        b=sy/EkwwUAc3EeiFWIViG+zfJyfMGDRUE1AUpX9R8w7U5ZZcaoBArn/usZSGFsm6KfD
         VqTe3anMFWsHrCIM8OgDW3TTgOl3xCCTJZ27ayZlWdOivhLRXFKSBMSHQjGlvotQa7yZ
         P69jNvCxY6KDFfjQyuxuCLh7JRRLCmeBhF04dQ59Omw9nVGTgCRPnSvWaj8hOHYAc3Xd
         x/wKjqq4uBg7GWuDDXVbYlO9kXnqy1zUqwToFFIDEshG2zoDhYLI3YjHASVN+OMMH7qF
         3h6Kv4HCYZ6nGGx8IXa9pe3KJhKG9fhsj3fFNLuMGIi2zg6Wca3DbX8mGwnY6FO9Lgvy
         ua0g==
X-Gm-Message-State: AHYfb5g815BJMeb7PI0BGKxZarvZKsR589uz52HesCnUd3TwlhDJYnfh
        qiEvT8Hof4XYqF6V
X-Received: by 10.99.47.66 with SMTP id v63mr2679754pgv.4.1503491925315;
        Wed, 23 Aug 2017 05:38:45 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id b1sm2791355pgn.1.2017.08.23.05.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:38:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 14/16] rev-list: expose and document --single-worktree
Date:   Wed, 23 Aug 2017 19:37:02 +0700
Message-Id: <20170823123704.16518-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/rev-list-options.txt | 8 ++++++++
 revision.c                         | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a6cf9eb380..7d860bfca1 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -184,6 +184,14 @@ explicitly.
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
 
+--single-worktree::
+	By default, all working trees will be examined by the
+	following options when there are more than one (see
+	linkgit:git-worktree[1]): `--all`, `--reflog` and
+	`--indexed-objects`.
+	This option forces them to examine the current working tree
+	only.
+
 --ignore-missing::
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
diff --git a/revision.c b/revision.c
index d100b3a3be..6eba4131b4 100644
--- a/revision.c
+++ b/revision.c
@@ -2251,6 +2251,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 			return error("invalid argument to --no-walk");
 	} else if (!strcmp(arg, "--do-walk")) {
 		revs->no_walk = 0;
+	} else if (!strcmp(arg, "--single-worktree")) {
+		revs->single_worktree = 1;
 	} else {
 		return 0;
 	}
-- 
2.11.0.157.gd943d85

