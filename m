Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716231F404
	for <e@80x24.org>; Thu,  6 Sep 2018 18:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbeIFXAr (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 19:00:47 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:38237 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeIFXAr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 19:00:47 -0400
Received: by mail-yb1-f202.google.com with SMTP id o132-v6so1139445yba.5
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kgIG1vGU6AChnZXfrbsr6yJX7+EFUf+gHH5jVUTeYy0=;
        b=fTdyeieaLEKkDeQlvTIembFgTNyqums5Rdrnidl+vBZ+FJgsvoy7dpsm6efm+f3ns1
         AbxOMuiL4766BsYqSfUGkQdCzD9jzlWSuK1PiOSLf6On9xa8XnN4YLTNRhXkhgtc1/3p
         3IUXCHreJHd0fW3t99ELWIZuHPt1wUEYLrS+wze19isegIWeQ1U5AomXApvOvNEGNk9b
         T/m0wHFFbN+Bfhp1IttaLEtdpgO/gxpHHBCfAvEtUg8OxQixVjDyOwf/J6v25gCNlrUB
         uJmMU4dU/0AAJyN5boD6I3RQWyMFxmNeh0zDm0qlRnZudw8T0/BSJmSaKX9PIDNjuaZf
         jnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kgIG1vGU6AChnZXfrbsr6yJX7+EFUf+gHH5jVUTeYy0=;
        b=hRq0rWfI+8BSz8QPx8aU1XU8Syj7WP6zlS67hgWRFynDG+1p0N9GA3W+nQwjbCAVFL
         xpNB+kz3KxeqhWwxp977naBDUUzhTWoZnN0knHdIoQtf+aI/UkTvyu5HbsZT7k6HhjHc
         sWfiXCmYoNzoi1ul8S5vJamFeBSexMJNCdEGq6teU6Ph2wwQkQcCRco8pfSrelnn8M4Q
         /pY1mwvslsOzQ3JEMZKXkV/XLUm4Fz2Mj/m2V7nQT2g1RY4SQQh8DwnCG8CDvuylngIv
         yFDuC58igd5Kcr2xBXAGxDQielfoPTX4tTtVLAwHWcMCF2qpUMDZGJzzHeZQM1SHztaA
         c1yA==
X-Gm-Message-State: APzg51BULt0sC0ysYfVxIw3747BmolwAlKVGFpnagASxlbK/MQykyHJM
        W6ZwUeg2uBWOAEc2ZfRIasVGbcAJpw/axRkqRY/UxK+fMGmz3te6HidA6WBntM7ZLwRtr16u9W3
        gQCv2kSxXVob4Iwds6vkQiZokOHY/3KJoQvVZaSM3awL4JpzJZtPXbIBX0xQN
X-Google-Smtp-Source: ANB0VdYbMWtEDYLDx5y6qwOGhx7H4pXVynUrjJDTOcQ3s88Uk7TfAnPjbUhExcFTPxkqfX98FIoJZ8CjX6tk
X-Received: by 2002:a81:ac52:: with SMTP id z18-v6mr860643ywj.160.1536258246075;
 Thu, 06 Sep 2018 11:24:06 -0700 (PDT)
Date:   Thu,  6 Sep 2018 11:23:53 -0700
In-Reply-To: <CAN0heSpOG8c5En_YVvtkcwBmOrnS72cTXSw9YRJP4FG-M8dWag@mail.gmail.com>
Message-Id: <20180906182353.114453-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAN0heSpOG8c5En_YVvtkcwBmOrnS72cTXSw9YRJP4FG-M8dWag@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] diff: allow --recurse-submodules as an synonym for --submodule
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
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
 Documentation/diff-options.txt | 21 +++++++++++----------
 diff.c                         |  3 ++-
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0378cd574eb..28c6c7f939f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -226,17 +226,18 @@ linkgit:git-config[1]).
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.
 
---submodule[=<format>]::
+--recurse-submodules[=<format>]::
 	Specify how differences in submodules are shown.  When specifying
-	`--submodule=short` the 'short' format is used.  This format just
-	shows the names of the commits at the beginning and end of the range.
-	When `--submodule` or `--submodule=log` is specified, the 'log'
-	format is used.  This format lists the commits in the range like
-	linkgit:git-submodule[1] `summary` does.  When `--submodule=diff`
-	is specified, the 'diff' format is used.  This format shows an
-	inline diff of the changes in the submodule contents between the
-	commit range.  Defaults to `diff.submodule` or the 'short' format
-	if the config option is unset.
+	`--recurse-submodules=short` the 'short' format is used.  This format
+	just shows the names of the commits at the beginning and end of the
+	range. When `--recurse-submodules` or `--recurse-submodules=log` is
+	specified, the 'log' format is used.  This format lists the commits
+	in the range like linkgit:git-submodule[1] `summary` does.
+	When `--recurse-submodules=diff` is specified, the 'diff' format
+	is used. This format shows an inline diff of the changes in the
+	submodule contents between the commit range.  Defaults to
+	`diff.submodule` or the 'short' format if the config option is unset.
+	`--submodule[=<format>]` is a historic synonym for this option.
 
 --color[=<when>]::
 	Show colored diff.
diff --git a/diff.c b/diff.c
index 145cfbae592..b874f166c00 100644
--- a/diff.c
+++ b/diff.c
@@ -5021,7 +5021,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if (skip_to_optional_arg_default(arg, "--ignore-submodules", &arg, "all")) {
 		options->flags.override_submodule_config = 1;
 		handle_ignore_submodules_arg(options, arg);
-	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
+	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log") ||
+	    skip_to_optional_arg_default(arg, "--recurse-submodules", &arg, "log"))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
 		return parse_ws_error_highlight_opt(options, arg);
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

