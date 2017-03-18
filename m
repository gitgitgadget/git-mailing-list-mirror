Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B5720323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdCRKOP (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:14:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36083 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdCRKOO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:14:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id r137so7477454pfr.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1DhD71KR9VyPS1L92gWhKFYTnTUGCm3oAWe01M4h0w=;
        b=OSXn/5yrElXViETFrFwC1etdW9Ubr/5RzUWknWCJegwJrKNYa3gxflAJbUwBI6R20P
         QgkFFZkjiH/3Mhr/mMts9T/aPQdvrcpRbRHZgWoJTrnqyZtfzWchJI2tDM5fStdQbxpC
         V2GRf3EZZOcC6h5XfBEn2NJmTgYqAZNYsTsjOMtxyeYrNTFpIRU0ztDssR+TFFRaMOiI
         j4q0+QTqhL1VFEiEwYKUQ8ZZBrjoKaNkeKyjmUz5ATZ5MyzlYxs+dY5xFguffvHllWdG
         cxy+/7kgbHhPkSJWNwE1FQMa7SBaXCzfvcCMOA1bcVC2N5fIzy1u20cTD4xNJZh2pIXL
         o+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1DhD71KR9VyPS1L92gWhKFYTnTUGCm3oAWe01M4h0w=;
        b=cMfBByMEiSK7fu1DtgZJEa1TGnD2C1BrxivpdPBS1/c3Shx/+reAHcQ1KWXboTHsvX
         V7Rlz2bUmBW0+fBZUOnWtK2UKeifb3MqersDb8d1z3ePeNqxMWOEmspxznPvkKtU0lxF
         vdZf3UmAoeKbdVYXFgAqqIjoaTzgbq45u6ZOxPZrj/tQzMbWi9ooaRqv3pM5E39ZSJMw
         DQ1e/HejSG2YxJ9HjcgP7ZN8yFFE5gurL1CdzqF3hTzPNvm1F3alxMeYDKw8hRISxqbH
         ehRzerjttacMeuMZpk8rP1RAs3ZXFD3gXGQGERNkPHgQ927Ybg4HVDUxIo/5w1YrrWHn
         rZjA==
X-Gm-Message-State: AFeK/H2juqvlY52jDmHOZqLdfqT2zeQOzLks1YHB9u9utF3Mo2/Sb7B/P4xsGSi47Qp8bQ==
X-Received: by 10.98.214.4 with SMTP id r4mr21281401pfg.185.1489831989149;
        Sat, 18 Mar 2017 03:13:09 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id z27sm21866178pfg.38.2017.03.18.03.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:13:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:13:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 12/12] rev-list: expose and document --single-worktree
Date:   Sat, 18 Mar 2017 17:11:53 +0700
Message-Id: <20170318101153.6901-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/rev-list-options.txt | 8 ++++++++
 revision.c                         | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a02f7324c0..c71e94b2d0 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -179,6 +179,14 @@ explicitly.
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
index fcf165bd76..dc32e99c54 100644
--- a/revision.c
+++ b/revision.c
@@ -2222,6 +2222,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
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

