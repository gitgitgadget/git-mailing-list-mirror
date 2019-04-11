Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35CA20248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDKNM6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:12:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44083 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKNMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:12:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so3435471pfm.11
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KkQyO5eb4AKwhOJ9uomoCSIdxFg37E7RcrZxCRTTvyA=;
        b=k02DibT5W7TbM5l1ebRaPSw9w6cBbAXusmpG1c41VIoAXCaCbUB0SJEWmMl+UN4KGd
         QPMbyYA7QcZx7cjcpRPnUKcV/HXqKattLesYcSftrJO3F/Je6OK6qwPQ3Vp9jnIfWax1
         obj6UXp0lH68T0TAlywxPK2n5b1fX2N9pjFZUEirNoIJTo3qh2jZ3z5d3xuKhFyX8IRd
         yxcKNrqnv7mBeZBRqBNoUNd5q2xmjYoq64uF7kifrMF7DTWDiFJ8sqmJXMUFSV+AJF4f
         lp48r/8j9nVtNup910aPpwlkuWUbzzEReERBV5ZZ9ovzSRzBWkxMN1LV3nC3e7KzTHas
         X4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkQyO5eb4AKwhOJ9uomoCSIdxFg37E7RcrZxCRTTvyA=;
        b=TXy2ER5LF8u6vxlhvurOMAOefEd95FSBW542JGovSw5dNA53yu+B2b84hGYAXgGGi/
         EK8wjk3tZpCoc3oCk+cOq+wR7oRql2VbXjZASg484d/fqXalnIfK71sCk5HKErKbWN4X
         taFo/NIIqYS0zSFiWwEu9TrcfPhi/ScCBeB3QQ1/lHcEBCKEnXrRl1BEdlX7XkT9zQGa
         yoLlOa507uO3m1BKtlsOxBZMvZM23mz3FZSqhXAVLE7ZpdVdlWoLkh7nRK3n35enrS+u
         omLkAP/Tk0JnRS6iHQq87pSGmxpbllFsV3c+YGCxhFJUjpXDJ3hc9k+SPQR00TzBkR1x
         CVtQ==
X-Gm-Message-State: APjAAAUtmp/BaboQMdJIUYVcTJy9RIP80qAINcaNAeY73YcOo8t1kUGv
        ywyHTB3CWG6RU3+3m4zhd+PS7K91
X-Google-Smtp-Source: APXvYqwzOxQ7nHk2WsDLSWwq6g5BNXi+nEMD/PuZMrT9yEAog0ir/LSPTxnsQL8tohN6prdR1OdzLw==
X-Received: by 2002:aa7:9294:: with SMTP id j20mr49867865pfa.64.1554988374219;
        Thu, 11 Apr 2019 06:12:54 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id h65sm96982918pfd.108.2019.04.11.06.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:12:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:12:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 03/16] restore: make pathspec mandatory
Date:   Thu, 11 Apr 2019 20:12:05 +0700
Message-Id: <20190411131218.19195-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

