Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13BB31F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfDYJqY (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36114 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDYJqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so10935129pgc.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Hk89vHlfBrtCBWXcTP2MbexAXK5XBHhBUxRY8F3xfw=;
        b=EGxqDvm8dHctuEN8i3a/vD1unBiQTt/yr7izuKkkk+zE9umLU46ePmcrzvdMmgPSo+
         PMTGxtzNUAaO+DFT0KLTsrli+LUYjtLoMr+OaUfRiirIPUfvhUwkVJGSYxADKFjkvE0O
         e7WgaBgMn/qFl6hUcvx1t+8WVJQD+yyipSFBnn4waotdai7dLjQjpJ0649mCb7eNUoQw
         2Pt8ZjVKviBvvrXFcPnXO5ingUxMrcu9G9XVp81k79+5XA3uT1BoYV6Of2+SO9oCniUQ
         GKvxczGqQECLG6IqSUnJkMbBhZx4DRvU10RlESunqJQ5ohE92y1c/r/xl/0rlkiopLk3
         z9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Hk89vHlfBrtCBWXcTP2MbexAXK5XBHhBUxRY8F3xfw=;
        b=R5N1G/eegJRo2TDgh0CO/BS/KcVpf2jAK0wRqpUByFYRMgrIu+r1qd4WZ2qf49eqlx
         UuUZy0XtuuM2NDW5ymMzsUQ0UPPXycR2uuUibAfPOFfiMPrCUGMQUcM6saOOGm2ifBi5
         zowElKY91DxQhCChQyuL/0Tif6oLj9a5SEsjX4xywJKtIjiqF4jokwVe3cqSmnD4Fp0P
         lvDAAZb5iTqZyHSPEKFbbu+AvnA+d4Xv+Vk7CVWU/4ZNustZcZF2nQqU4yomvwzfz+sK
         oByw/RmqjeqzrJqKqbU8v/rwP+6FZ4/RJ9hPNcHkN4XvdfPj7b4kaUIZmsoBOAmWXMNw
         ewGA==
X-Gm-Message-State: APjAAAWGhZ6GvNBVUyefNpK5D4Qb7NnCPPc6HKDdi3J9cOXwcnuBv9Yx
        WbMqFLU5YBK5BQwrLwBMCe4=
X-Google-Smtp-Source: APXvYqwgp9VBOwvWJoz8fka4cOMG2u7FRlXjtxNKbF9PdEx8t7endhzGVxyIyYBH6WRBPlqsBjBtmQ==
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr37986165pfv.10.1556185583217;
        Thu, 25 Apr 2019 02:46:23 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id x66sm54135073pfb.78.2019.04.25.02.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 03/16] restore: make pathspec mandatory
Date:   Thu, 25 Apr 2019 16:45:47 +0700
Message-Id: <20190425094600.15673-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git restore" without arguments does not make much sense when
it's about restoring files (what files now?). We could default to
either

    git restore .

or

    git restore :/

Neither is intuitive. Make the user always give pathspec, force the
user to think the scope of restore they want because this is a
destructive operation.

"git restore -p" without pathspec is an exception to this
because it really is a separate mode. It will be treated as running
patch mode on the whole worktree.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5aba345712..77db5236f0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -65,6 +65,7 @@ struct checkout_opts {
 	int only_merge_on_switching_branches;
 	int can_switch_when_in_progress;
 	int orphan_from_empty_tree;
+	int empty_pathspec_ok;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -1515,6 +1516,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("reference is not a tree: %s"), opts->from_treeish);
 	}
 
+	if (opts->accept_pathspec && !opts->empty_pathspec_ok && !argc &&
+	    !opts->patch_mode)	/* patch mode is special */
+		die(_("you must specify path(s) to restore"));
+
 	if (argc) {
 		parse_pathspec(&opts->pathspec, 0,
 			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
@@ -1601,6 +1606,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.implicit_detach = 1;
 	opts.can_switch_when_in_progress = 1;
 	opts.orphan_from_empty_tree = 0;
+	opts.empty_pathspec_ok = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1664,6 +1670,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
+	opts.empty_pathspec_ok = 0;
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.854.ge34a79f761

