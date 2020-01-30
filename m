Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1887C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9250120707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qpnci/UO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgA3Nhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:37:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52710 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3Nhd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 08:37:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so3812075wmc.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 05:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8sCYPJG4X6+iL9ufe2kmJ40eE/ErqiQrJ2sBLyXzngE=;
        b=Qpnci/UOHRGhpb2S5LLRZNqzKk17nDvby+P13doJGNDlchJ5X7d89tbQukU1+tKwKT
         6pRaKQ5EU3jPGXFdwUkVJyQbSPUD0juj7Ja1ZQh6GhRmSbV/Pl+5XnXHdslu0yUzEDx0
         7Z0E2ylV43M9rYX9fZSHMsarE0RvLXBgWbS5wKkH9iYI7ODdy05g+uREszWIHUbKGz4y
         hoOCsbLWvIM8RAC2trHFk1atxRytE7zhHl3VZgP2HLPbF/acZJ6SvUznzqC5uejKLwRT
         t9rwICfPIXYykgrBOgfIoShkcxKHmXLfWmNWeobSiyHA6vhzXySpU7XhY9Xitn8TjrZB
         DAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8sCYPJG4X6+iL9ufe2kmJ40eE/ErqiQrJ2sBLyXzngE=;
        b=CYErBR1s7srT1gMiwGWRTWeKfwk4P1bocHXcfytrl4+HXCvCg/oyLsIZ86Y1dzcscJ
         G+taWdd8oRIstkqRul3BIKZ0/kZHvnRCadab2hXgE221711xlhCRgi1PP9S540ZTnoHj
         ziUiAeabNXEsaWVUql/b7BEu+YjyPciyRbF9r9kZxq6MyKoDdD/gcxy4AYvoJH427NOr
         M5GJrtEHu2QAH6ttaav/RQamSjujOxPPYmQ/dIYzrXIyKoGGM+3q9keB+ZVuef/Gl3E/
         gRvzwzr+a6ncWKsG1TBjI0iCMAQvC+t/t64oS5oAt+03nLOUzNKHAuZmALe39262Dlbt
         pdVA==
X-Gm-Message-State: APjAAAVChyP7j4ZhmloBzHxUbkuROEPeWKlrymJQOrdon+YB+Or/H6KC
        +8iBm1KbqOf5Do06MlAx3omz/0U4
X-Google-Smtp-Source: APXvYqzjXW5PNI7c3PxEm3BSEsExtba6yJTYZdwmqQVIThocPhpKyC0C2zG7/SjqN+Xos+1yz4yqdA==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr5930252wmd.102.1580391449913;
        Thu, 30 Jan 2020 05:37:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm7315133wra.83.2020.01.30.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 05:37:29 -0800 (PST)
Message-Id: <pull.540.v2.git.1580391448318.gitgitgadget@gmail.com>
In-Reply-To: <pull.540.git.1580000298097.gitgitgadget@gmail.com>
References: <pull.540.git.1580000298097.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jan 2020 13:37:28 +0000
Subject: [PATCH v2] grep: ignore --recurse-submodules if --no-index is given
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since grep learned to recurse into submodules in 0281e487fd
(grep: optionally recurse into submodules, 2016-12-16),
using --recurse-submodules along with --no-index makes Git
die().

This is unfortunate because if submodule.recurse is set in a user's
~/.gitconfig, invoking `git grep --no-index` either inside or outside
a Git repository results in

    fatal: option not supported with --recurse-submodules

Let's allow using these options together, so that setting submodule.recurse
globally does not prevent using `git grep --no-index`.

Using `--recurse-submodules` should not have any effect if `--no-index`
is used inside a repository, as Git will recurse into the checked out
submodule directories just like into regular directories.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    grep: ignore --recurse-submodules if --no-index is given
    
    Changes since v1:
    
     * set recurse_submodules to 0 early in cmd_grep if !use_index. This
       makes more sense, and eliminates an incompatibility with topic
       mt/threaded-grep-in-object-store.
    
    v1: Since grep learned to recurse into submodules in 0281e487fd (grep:
    optionally recurse into submodules, 2016-12-16), using
    --recurse-submodules along with --no-index makes Git die().
    
    This is unfortunate because if submodule.recurse is set in a user's
    ~/.gitconfig, invoking git grep --no-index either inside or outside a
    Git repository results in
    
    fatal: option not supported with --recurse-submodules
    
    Let's allow using these options together, so that setting
    submodule.recurse globally does not prevent using git grep --no-index.
    
    Using --recurse-submodules should not have any effect if --no-indexis
    used inside a repository, as Git will recurse into the checked out
    submodule directories just like into regular directories.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-540%2Fphil-blain%2Fgrep-no-index-ignore-recurse-submodule-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-540/phil-blain/grep-no-index-ignore-recurse-submodule-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/540

Range-diff vs v1:

 1:  6634266b01 ! 1:  6fc8bf788a grep: ignore --recurse-submodules if --no-index is given
     @@ -20,6 +20,7 @@
          is used inside a repository, as Git will recurse into the checked out
          submodule directories just like into regular directories.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
     @@ -39,6 +40,16 @@
       diff --git a/builtin/grep.c b/builtin/grep.c
       --- a/builtin/grep.c
       +++ b/builtin/grep.c
     +@@
     + 			/* die the same way as if we did it at the beginning */
     + 			setup_git_directory();
     + 	}
     ++	/* Ignore --recurse-submodules if --no-index is given or implied */
     ++	if (!use_index)
     ++		recurse_submodules = 0;
     + 
     + 	/*
     + 	 * skip a -- separator; we know it cannot be
      @@
       		}
       	}


 Documentation/git-grep.txt         |  3 ++-
 builtin/grep.c                     |  7 +++++--
 t/t7814-grep-recurse-submodules.sh | 11 ++++++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c89fb569e3..ffc3a6efdc 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -96,7 +96,8 @@ OPTIONS
 	Recursively search in each submodule that has been initialized and
 	checked out in the repository.  When used in combination with the
 	<tree> option the prefix of all submodule output will be the name of
-	the parent project's <tree> object.
+	the parent project's <tree> object. This option has no effect
+	if `--no-index` is given.
 
 -a::
 --text::
diff --git a/builtin/grep.c b/builtin/grep.c
index 50ce8d9461..ae2d5bbafc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -958,6 +958,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			/* die the same way as if we did it at the beginning */
 			setup_git_directory();
 	}
+	/* Ignore --recurse-submodules if --no-index is given or implied */
+	if (!use_index)
+		recurse_submodules = 0;
 
 	/*
 	 * skip a -- separator; we know it cannot be
@@ -1115,8 +1118,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (recurse_submodules && (!use_index || untracked))
-		die(_("option not supported with --recurse-submodules"));
+	if (recurse_submodules && untracked)
+		die(_("--untracked not supported with --recurse-submodules"));
 
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 946f91fa57..828cb3ba58 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -345,7 +345,16 @@ test_incompatible_with_recurse_submodules ()
 }
 
 test_incompatible_with_recurse_submodules --untracked
-test_incompatible_with_recurse_submodules --no-index
+
+test_expect_success 'grep --recurse-submodules --no-index ignores --recurse-submodules' '
+	git grep --recurse-submodules --no-index -e "^(.|.)[\d]" >actual &&
+	cat >expect <<-\EOF &&
+	a:(1|2)d(3|4)
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
+	EOF
+	test_cmp expect actual
+'
 
 test_expect_success 'grep --recurse-submodules should pass the pattern type along' '
 	# Fixed

base-commit: bc7a3d4dc04dd719e7c8c35ebd7a6e6651c5c5b6
-- 
gitgitgadget
