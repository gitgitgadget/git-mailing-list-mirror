Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAECBC35242
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 00:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7A020709
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 00:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH2DHUeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAZA6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 19:58:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44049 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAZA6W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 19:58:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so6729898wrm.11
        for <git@vger.kernel.org>; Sat, 25 Jan 2020 16:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xMd2jRE1z1JxW+XtKaJZzb4Gx4wrAQLNfYeMXKtnSco=;
        b=MH2DHUeDCNtb6vgBt5ig9nC8in61JagcPyDorXbPNEsz6pIAsT1Bta2NJNYsplCsdp
         uzt5rt+uyt9AEnQGXAZ+tJkcJCZHUIF7DmrNXYXqPJNfKZIsGnAWUzfkzbj/76d06V0/
         Ut8e9nVI4YwjZpbO+/qsmf1Y3S8171u1DWd+r7diA+1RuhncivR9AJf2/nGUj46Dczgw
         Y3fcakcZKIFN46432guAm+HNGBylQ8tmSpt4nCqmDcQ2UOm5m9GorSlFv3xWTT/9sxn8
         hXyAoCToBtku9G+IEE/VjKadHFjdt8p9Qq+JOYXPVpWmxcquy8oL7WZxUR1XWTsGKnEN
         AfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xMd2jRE1z1JxW+XtKaJZzb4Gx4wrAQLNfYeMXKtnSco=;
        b=iiEpKibcegvcAWeaMkdKhA2luVbAzCQwpQBFuTqBfTSS0mzdRkOOZmzd/1dISvn4m/
         t9UG6M3UMKitMO6WirZorcMpmP1AOY3mUvtt678w10VAv53hgBBSaLc6exr6T1AwmQ9b
         aS/ZNqJTns8da5NlRfcFpELpjQOpDtaTzPOYqxMLtU+TWYTEEfD+GvUdYy7SQId8btmB
         Xj/6IZLiPNjLjnSGzv3wMoBJy5lAC8hz/vEo5wOHOriN5Mkp/I0oF48oJ36H+BmcJEIJ
         kaISy+Yf+naqtTZO4RmGGmOydv2Xyty1ORDk1D4GkWfH84IkskVi9sp3N6eRsM9ahbPE
         hPGg==
X-Gm-Message-State: APjAAAUqw/jkIL4+oLkI+rgy5B8oTm1c/I4PYV/WrouDSSQ4sP3V+GEa
        2f+OJ1CviRQ39+D5aEBeQiZoezyC
X-Google-Smtp-Source: APXvYqz9cCfus0Ac0VOtdoDtYYoetFEai5Oz825OxyGovZ9XMQAxOx5K2CwTpKZ/ZSyucjn+jD24LA==
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr13275337wrx.164.1580000299275;
        Sat, 25 Jan 2020 16:58:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13sm14300584wru.38.2020.01.25.16.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 16:58:18 -0800 (PST)
Message-Id: <pull.540.git.1580000298097.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Jan 2020 00:58:17 +0000
Subject: [PATCH] grep: ignore --recurse-submodules if --no-index is given
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
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

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    grep: ignore --recurse-submodules if --no-index is given
    
    Since grep learned to recurse into submodules in 0281e487fd (grep:
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-540%2Fphil-blain%2Fgrep-no-index-ignore-recurse-submodule-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-540/phil-blain/grep-no-index-ignore-recurse-submodule-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/540

 Documentation/git-grep.txt         |  3 ++-
 builtin/grep.c                     |  4 ++--
 t/t7814-grep-recurse-submodules.sh | 11 ++++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

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
index 50ce8d9461..d5f089dd41 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1115,8 +1115,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
