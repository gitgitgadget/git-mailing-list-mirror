Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECDAA1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 22:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeIFDa4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 23:30:56 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:41218 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeIFDaz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 23:30:55 -0400
Received: by mail-io0-f201.google.com with SMTP id q24-v6so8986826iog.8
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 15:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mbix/R3baEUQxl3Cfbsk8R3SCgTTWkoNpZCf4Rn+NAo=;
        b=LFimznjdPZOwodO7vEOUFOSlU+YdRJsh8qtXxo3H+Rw+OOK8B3W9vOxfAWXC8rVxLu
         VFycE58D8y5O9EPp0FZHZdObkUhWl5DlS3hjJSci/QU7NA4/k6FEUUVdqAnXSOveSlcD
         CgA8QEPHU2CKUaWHjX2T6aVYpVWg2exJu34T/HpdyyB6OxKnUzNEEJZv4F1+3bJWOqcl
         tXh+BG1LTWais893lbtvZv6LH2FMYd2fgXIS/0dZ/t3P2xrmWDRCGZABmVKmdoRcAdVp
         PIz2zjVxOySeJnNvYWVMUFmuHB4pegNz08l8imBRgBRL6PoWIqGYVxdkHdtQBKBk79GA
         2Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mbix/R3baEUQxl3Cfbsk8R3SCgTTWkoNpZCf4Rn+NAo=;
        b=h0qPI4QdElzfmYoj4Wb7EC1M7Q7X6HiiiF5NE55+PJwos1vs2t4KToi9lwupWyxKNX
         /OjChdMOk9TrVSNubtHSNw6SWYalHmR4QUNb9lxBZFr4CKLn+DzziWuWeiOcAm9BGQIR
         OmzNX+p2wymzPfdSeBDcjVr1o1hCPky7x/fR1ZzbhY61zukuqFmNVcuOLQdhzoR0UqW0
         n+O+mDfKD4QPCkBJVBa0aYfxvLpJPH2IGpNOFNsfn6AKVkFShlOn29oFJFcGpfR4z9Hv
         gykdrFTjt89Z2m4nYD2fKRIQAMx9lUkNTkHC/KkJ6p1BOU0nicd0eX3FJ9xigRZjm1KB
         loVg==
X-Gm-Message-State: APzg51A49yXThHmEASwTfRQO4iS9M9SU6ftYe+DiGHfWYdYf2rhJpQxK
        q+RVTD7x1JBjrFgL9pPFpPY/oWtzXuEzCdRn07BATU9b+kH/hZzTVAAOWVotkiHJcX/Ns4MGLBt
        iIj3prV4g3zOpqhVZvhT1eKUw1OCsk/Tj3OGZdUEVMJx0MLnNHdXwgJ0dRUEB
X-Google-Smtp-Source: ANB0VdbpQoVhwJCczKfYw6gBeP1O2N+y7CB6GNh92MIEYqD1KNmvlVJdY+YCDegvFQ3yqXj49uxatZQw+mLL
X-Received: by 2002:a24:5687:: with SMTP id o129-v6mr563660itb.21.1536188312767;
 Wed, 05 Sep 2018 15:58:32 -0700 (PDT)
Date:   Wed,  5 Sep 2018 15:58:28 -0700
Message-Id: <20180905225828.17782-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] diff: allow --recurse-submodules as an synonym for --submodule
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many commands have flags to recurse into submodules, which is named
--recurse-submodules. The diff family also has a submodule recursion flag,
but that is named differently. Add a synonym --recurse-submodules, which
means the same as the --submodule flag, such that across all git commands
supporting submodules we have the --recurse-submodules flag available.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt | 1 +
 diff.c                         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0378cd574eb..694c97338c9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -227,6 +227,7 @@ linkgit:git-config[1]).
 	of the `--diff-filter` option on what the status letters mean.
 
 --submodule[=<format>]::
+--recurse-submodules[=<format>]::
 	Specify how differences in submodules are shown.  When specifying
 	`--submodule=short` the 'short' format is used.  This format just
 	shows the names of the commits at the beginning and end of the range.
diff --git a/diff.c b/diff.c
index 145cfbae592..d3d5a989bd1 100644
--- a/diff.c
+++ b/diff.c
@@ -5023,6 +5023,8 @@ int diff_opt_parse(struct diff_options *options,
 		handle_ignore_submodules_arg(options, arg);
 	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
 		return parse_submodule_opt(options, arg);
+	else if (skip_to_optional_arg_default(arg, "--recurse-submodules", &arg, "log"))
+		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
 		return parse_ws_error_highlight_opt(options, arg);
 	else if (!strcmp(arg, "--ita-invisible-in-index"))
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

