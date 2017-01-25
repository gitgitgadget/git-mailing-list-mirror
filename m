Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1811F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 12:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbdAYMvo (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 07:51:44 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36636 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdAYMvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 07:51:41 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so19657899pgf.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 04:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ELKdEYOrlEAdDakds9AOHci90Qt3eAgJb9k85A/6Ks=;
        b=nxSCw7r/Rn7GdnV0Pohx6LtROgqGX06izgGs9O/fU6Kwijs4s3kb03MPMT2BHY3rOl
         bSZnI3Wggz+YciTtuS6CsFrd6Bs8GM2s1KnXGSqAcpX31Omh7FUXnNkI34EMurhyIOzS
         X5GPIlMhIHmJC5PO1CHD1A8C1AMQvfZeFHW52IeTQHXHv8tmSFbsICUzUKNYScFMNv3U
         E6IelUR+xLF+ihicrRsmc0XAqTZ3DD4PO7cS/L97tEI1Eozb5G/3pfxNi+X7lh3OTWqg
         s7ToSP36+aZVCv3xoGE5BvoKJUDhMX20RhdJuUcYfjXJUXmSoXA/T2QV6MjGKouhvt7J
         aZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ELKdEYOrlEAdDakds9AOHci90Qt3eAgJb9k85A/6Ks=;
        b=ILL9dG+1OSL92M/QRdeLGh2mSNJN2v42+JozaX5AKN+L7f5MBPj8LYrrOLsnquReBF
         xW6LHrWTG1SEnUTyGohJji2ays371xqBec2hXqepxx3nPG3/RJHa89h/zk1+zyYpVnkv
         /LfZVm78Br0xKFIuSSmXEGHT9dq/49/vCGzg62GdbFeGBs7qD3fN7/g7n+tQV+SJIPIL
         JqLGr5CbPjNOLEwl7u1LYEuHgaRWNCbQz2XPVlV1bnTB7ss/Zyvz4/4Z0Ixf6lJBDcby
         mqkGcR8nVHDEkuSxoew8fuaZ5BOrzo40NiOQUuK0opzCRFidk82qRjZ+l3RpF15ZSI3J
         0eeA==
X-Gm-Message-State: AIkVDXIcJJhfL0BiD2J22rttAZECTeX1isb6/v1kxw0jOG5S7TmTjUwpgnFk/eE8Umfbxg==
X-Received: by 10.84.245.1 with SMTP id i1mr3447968pll.131.1485348695594;
        Wed, 25 Jan 2017 04:51:35 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id b67sm1147076pfj.81.2017.01.25.04.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 04:51:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 25 Jan 2017 19:51:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, jacob.keller@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/5] revision.c: allow to change pseudo opt parsing function
Date:   Wed, 25 Jan 2017 19:50:52 +0700
Message-Id: <20170125125054.7422-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170125125054.7422-1-pclouds@gmail.com>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 11 ++++++++---
 revision.h |  4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 6ebd38d1c8..cda2606c66 100644
--- a/revision.c
+++ b/revision.c
@@ -2273,10 +2273,15 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		const char *arg = argv[i];
 		if (*arg == '-') {
 			int opts;
+			handle_pseudo_opt_cb handle_pseudo_opt =
+				handle_revision_pseudo_opt;
 
-			opts = handle_revision_pseudo_opt(submodule,
-						revs, argc - i, argv + i,
-						&flags);
+			if (revs->handle_pseudo_opt)
+				handle_pseudo_opt = revs->handle_pseudo_opt;
+
+			opts = handle_pseudo_opt(submodule,
+						 revs, argc - i, argv + i,
+						 &flags);
 			if (opts > 0) {
 				i += opts - 1;
 				continue;
diff --git a/revision.h b/revision.h
index 9fac1a607d..9080eaf381 100644
--- a/revision.h
+++ b/revision.h
@@ -52,6 +52,8 @@ struct rev_cmdline_info {
 #define REVISION_WALK_NO_WALK_SORTED 1
 #define REVISION_WALK_NO_WALK_UNSORTED 2
 
+typedef int (*handle_pseudo_opt_cb)(const char *, struct rev_info *, int, const char **, int *);
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -213,6 +215,8 @@ struct rev_info {
 
 	struct commit_list *previous_parents;
 	const char *break_bar;
+
+	handle_pseudo_opt_cb handle_pseudo_opt;
 };
 
 extern int ref_excluded(struct string_list *, const char *path);
-- 
2.11.0.157.gd943d85

