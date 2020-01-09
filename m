Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF0EC47409
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CAE2072A
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX+Ey7Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAIKQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:16:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45053 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbgAIKQs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 05:16:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so6717526wrm.11
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 02:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ep6BgXY97d/k/RaCUBzI+q+YFgW8dWJXGxjJn8yUxaM=;
        b=FX+Ey7Fz/g9QPtByfeGugX21DI1ti7hr5+UQjKZr/6vYk8z+0LUPAklPumgrQ+Cd1W
         vaqyIHmEeHBSF+Kv8SR2a95qic+MvVYLBKujq/bc8fDVsWn3T+8IJUUL7pcs/Kw0cnXk
         +ceTKLEeiYsUToM/eBa8E5hQQcjVdHhEyjtEt/p9xfoQooHhmpkG4yv8PVuKTgUT666g
         CZxWe5gc50khLMCCfw1EP99vsq4WWZCZAT1OjpuOjiKoz30vLbkJ0hwYJnsw5twDgAIS
         XnP4PzDAYNjRFMa2No7vp6LdK+e3b0iWPouDUU+Kqi+Euv7jW5XMOfLha9D7YsAQWC81
         gBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ep6BgXY97d/k/RaCUBzI+q+YFgW8dWJXGxjJn8yUxaM=;
        b=UNciuRKdgRP7O9eKy18O/5+91mT2sDgjkIL0phv7L1STtkwE57lkLjxXGqouzNTYdm
         HnYgA7GvUNMxYhUjmQ2udd+6iL2lN3bi2FIvbIMp1xavpQIZQB+pNSirELUOg0Gikm8j
         ojLctndZoe/FpWlGPZfbdO7Catu7fcwl3JtkFaZ4wnRYwNGnXmGDL4zenJeQImEEXeCH
         p+XCV9wCRFEptxRvh0+2znrJuBZnUPfji90mTmhmxtTfJ0ER9ntpWpWtYdL1Mu0ryLG0
         Isg/vjCKcqD2uLrgqduWtcpN/SPG8P1oBVnLFcOW1NmaDJsFHQt3gHTxtpbkDtqyDO8D
         NXww==
X-Gm-Message-State: APjAAAXy7EGBWVklQmsEzB0zvJ1XFgSUGTZOcyTPLQFK0up8NAtB8zxH
        Pbg3YuD6XrjHqzay6a+F/5b62662
X-Google-Smtp-Source: APXvYqxtlgLoFzk8mNd9Y4TUW2EDnWrh2zF/8hWLsirIdlZhIjDeS6rRPnwERhCStDtxYAFQsVbbWQ==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr9753990wrn.386.1578565005804;
        Thu, 09 Jan 2020 02:16:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm7884938wro.67.2020.01.09.02.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:16:45 -0800 (PST)
Message-Id: <82252735467d876b4726f512a02cc44d271696ca.1578565001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jan 2020 10:16:40 +0000
Subject: [PATCH v2 3/4] config: clarify meaning of command line scoping
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

CONFIG_SCOPE_CMDLINE is generally used in the code to refer to config
values passed in via the -c option.  This is a little bit too specific
as there are other methods to pass config values so that the last for a
single command (namely --file and --blob).  As the "visibility" of config
values passed by these situations is common, we unify them as having a
scope of "command" rather than "command line".

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 config.c               | 2 +-
 config.h               | 2 +-
 t/helper/test-config.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 447a013a15..f319a3d6a0 100644
--- a/config.c
+++ b/config.c
@@ -1737,7 +1737,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 		free(path);
 	}
 
-	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
+	current_parsing_scope = CONFIG_SCOPE_COMMAND;
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
diff --git a/config.h b/config.h
index 284d92fb0e..f383a71404 100644
--- a/config.h
+++ b/config.h
@@ -300,7 +300,7 @@ enum config_scope {
 	CONFIG_SCOPE_GLOBAL,
 	CONFIG_SCOPE_LOCAL,
 	CONFIG_SCOPE_WORKTREE,
-	CONFIG_SCOPE_CMDLINE,
+	CONFIG_SCOPE_COMMAND,
 };
 
 enum config_scope current_config_scope(void);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 6695e463eb..78bbb9eb98 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -48,8 +48,8 @@ static const char *scope_name(enum config_scope scope)
 		return "repo";
 	case CONFIG_SCOPE_WORKTREE:
 		return "worktree";
-	case CONFIG_SCOPE_CMDLINE:
-		return "cmdline";
+	case CONFIG_SCOPE_COMMAND:
+		return "command";
 	default:
 		return "unknown";
 	}
-- 
gitgitgadget

