Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A284E207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 10:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031198AbdDTKLg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:11:36 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34577 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031175AbdDTKLe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:11:34 -0400
Received: by mail-oi0-f68.google.com with SMTP id y11so5654708oie.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VG3YSRYwB6HYDXo+VguAoNAt5KfvJnU6m/GYbORyOKU=;
        b=eowMUEECjRZGDAhxQqZJnf+H4PGG0rSA5AlVzOgKHM9x6jJnz9pjLNNfw8ySOkQvSQ
         qrF5852nltfc8GRZaUAq7R73HrIobN2pio4QA6BJ9acl+RXc9z/K5df0hayLRpo6OJu/
         rZWAs4pRzqhKK5W0L+j4oZGnLed6BsKnmdLJMt1Ebrv+JCLFBDw6xoGz9QiwivRLQ+x4
         h3o+aRd7LtCD7oEJSWpWwky5KOg6nNu5+eY9B27QL8TvqLRSFTFntWopHRbAmIDq2pW1
         fgtMRQGAjJT0fg5wg3p5S5rC8sUPFilbWsrRGbz9U70Vk00f7JYxuKPP+951Kg5G8MNe
         xEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VG3YSRYwB6HYDXo+VguAoNAt5KfvJnU6m/GYbORyOKU=;
        b=sAphN87K8NFDLg2Z0/g3pblH4Wn/0YHdEKCWMKURll1vaCByrHJFVnzZ/ZgBixTdZr
         sjxAMjw156Rv6XzkaiOdisO+7TcxnrliOHvRo7I2z43YY4bZcZkVcQo1WEI+zsOv5zCN
         Stkr6xue/GXKOLR785881DF5DeAMyGqg3ltTiJvHYdGs1JvEAN7gv/bCWmKzISF9wz5H
         KQzdcdXyw7bye4h8lUCc04khFit9m1wwqNC/8uCFE7phS3WM80BxR0pcOws34UcnjkHm
         /qybxCreeur+gvrp38RNAcbk5ETi8enspVO2F/7fH0dA7lP2ie+8ypDBRRQalQqnGJAj
         +hlA==
X-Gm-Message-State: AN3rC/675SV8oPw68H1X9VMiUr9m85l68mecDa3jO/5zsJCXH3j/9EVU
        SbgqCR0yZ9UECw==
X-Received: by 10.98.34.212 with SMTP id p81mr7430101pfj.118.1492683093052;
        Thu, 20 Apr 2017 03:11:33 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id a21sm9545044pfc.60.2017.04.20.03.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 03:11:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:11:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/6] worktree move: accept destination as directory
Date:   Thu, 20 Apr 2017 17:10:22 +0700
Message-Id: <20170420101024.7593-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420101024.7593-1-pclouds@gmail.com>
References: <20170420101024.7593-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e3fbfe2a71..116507e47e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -540,7 +540,13 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 		usage_with_options(worktree_usage, options);
 
 	strbuf_addstr(&dst, prefix_filename(prefix, av[1]));
-	if (file_exists(dst.buf))
+	if (is_directory(dst.buf))
+		/*
+		 * keep going, dst will be appended after we get the
+		 * source's absolute path
+		 */
+		;
+	else if (file_exists(dst.buf))
 		die(_("target '%s' already exists"), av[1]);
 
 	worktrees = get_worktrees(0);
@@ -558,6 +564,17 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
 
+	if (is_directory(dst.buf)) {
+		const char *sep = find_last_dir_sep(wt->path);
+
+		if (!sep)
+			die(_("could not figure out destination name from '%s'"),
+			    wt->path);
+		strbuf_addstr(&dst, sep);
+		if (file_exists(dst.buf))
+			die(_("target '%s' already exists"), dst.buf);
+	}
+
 	if (rename(wt->path, dst.buf) == -1)
 		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
 
-- 
2.11.0.157.gd943d85

