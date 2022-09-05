Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A5AC6FA86
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiIEI1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiIEI1S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2362712775
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b16so10278231wru.7
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=otZe8EhGhPEh/fzuhcfw6OHOoCIKrQBIiYv1nc4qb7k=;
        b=WGylKSQ1LGwbJshnAxrOtVjxpI1ikA9v60Pg860YmKMx5c6pqodwKSA47AcLODwtBC
         BiBLV8dL5OQQNkF6VMLqogYFTU4CMNxyDvo7WqVo5CysUg7aP0Ypgp3ldqZdblIVy4IO
         tZrRP37gHFM/Eb9UGCHSafqLfaDnc8xcpkSb0voAudKaipN/T5Sz2WTY1hOP4OGHiJww
         dx2naIyYCLuipRDlcci8YRKu3fxURU+eQTQJDr/Wjt6rDAqdoeKh+vs1dKwLxazU42sy
         ZZ8eYYW8B4Gn9FednlPTiGwKbydi9U6UwManYXx8MS14uRFRDXdUc5RczvMi3T6OK/PC
         lUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=otZe8EhGhPEh/fzuhcfw6OHOoCIKrQBIiYv1nc4qb7k=;
        b=lVIptJG6Barlv6tZkOnj0qw2/N3PflIKE939SaCazyLp/1oiKRD3mQpOcvFyvnSAZn
         AyUkIE/GOYt4/FmHgTPrr0t+dRKShHfhS1aEkBLVG/TLYjR19jAtO4D6EFDCZsdOe3HN
         /onbTggEiTcXvQqM3dz3FXqQg80gvcnU5mAU7+zYEczq6eGcuvdmQz4aM7WktNk3dpq+
         3dfgZHE7/WPUZ1UpU2Ij35Yi/x/mKxYQ/MPgG5dXec13JjwTqhRr/eWUQKJNRz2bqyhg
         vn3reYzB1cLIDAfo9n/JH6ZmbpDLRnrTPs1uzBxgwp/HVDNYURtIR5ewRsotLXIagvX3
         qHEQ==
X-Gm-Message-State: ACgBeo1VZyLH6nvoxD/4iLS2RQFo2esXh6VRAh1ij+cAbJAXCjI9PUQt
        nro5MhwUfCk4GY6C7uvE26p62NYb+BvsPA==
X-Google-Smtp-Source: AA6agR5f7PTSGRNRCEn0p8qvrV7oiFHgGvNVNgJhmMxf1On7MQM6cEtjKhb3T/FUYFSGFFS8+30vrg==
X-Received: by 2002:a5d:4882:0:b0:225:3148:9f85 with SMTP id g2-20020a5d4882000000b0022531489f85mr23277592wrq.224.1662366424957;
        Mon, 05 Sep 2022 01:27:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/34] stash doc SYNOPSIS & -h: correct padding around "[]()"
Date:   Mon,  5 Sep 2022 10:26:25 +0200
Message-Id: <patch-14.34-12ec2627504-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The whitespace padding of alternatives should be of the form "[-f |
--force]" not "[-f|--force]". Likewise we should not have padding
before the first option, so "(--all | <pack-filename>...)" is correct,
not "( --all | <pack-filename>... )".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-stash.txt | 12 ++++++------
 builtin/stash.c             | 28 ++++++++++++++--------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 0df21321e50..379bea645db 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,17 +9,17 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<log-options>]
-'git stash' show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
-'git stash' drop [-q|--quiet] [<stash>]
-'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
+'git stash' show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
+'git stash' drop [-q | --quiet] [<stash>]
+'git stash' (pop | apply) [--index] [-q | --quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]
+'git stash' [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
+	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
 'git stash' clear
 'git stash' create [<message>]
-'git stash' store [(-m|--message) <message>] [-q|--quiet] <commit>
+'git stash' store [(-m | --message) <message>] [-q | --quiet] <commit>
 
 DESCRIPTION
 -----------
diff --git a/builtin/stash.c b/builtin/stash.c
index 0fc359e9d39..7d82ead6760 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -24,16 +24,16 @@
 static const char * const git_stash_usage[] = {
 	N_("git stash list [<options>]"),
 	N_("git stash show [<options>] [<stash>]"),
-	N_("git stash drop [-q|--quiet] [<stash>]"),
-	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash drop [-q | --quiet] [<stash>]"),
+	N_("git stash (pop | apply) [--index] [-q | --quiet] [<stash>]"),
 	N_("git stash branch <branchname> [<stash>]"),
 	"git stash clear",
-	N_("git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]\n"
+	N_("git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n"
+	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n"
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "          [--] [<pathspec>...]]"),
-	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
+	N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n"
+	   "          [-u | --include-untracked] [-a | --all] [<message>]"),
 	NULL
 };
 
@@ -48,17 +48,17 @@ static const char * const git_stash_show_usage[] = {
 };
 
 static const char * const git_stash_drop_usage[] = {
-	N_("git stash drop [-q|--quiet] [<stash>]"),
+	N_("git stash drop [-q | --quiet] [<stash>]"),
 	NULL
 };
 
 static const char * const git_stash_pop_usage[] = {
-	N_("git stash pop [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash pop [--index] [-q | --quiet] [<stash>]"),
 	NULL
 };
 
 static const char * const git_stash_apply_usage[] = {
-	N_("git stash apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash apply [--index] [-q | --quiet] [<stash>]"),
 	NULL
 };
 
@@ -73,20 +73,20 @@ static const char * const git_stash_clear_usage[] = {
 };
 
 static const char * const git_stash_store_usage[] = {
-	N_("git stash store [(-m|--message) <message>] [-q|--quiet] <commit>"),
+	N_("git stash store [(-m | --message) <message>] [-q | --quiet] <commit>"),
 	NULL
 };
 
 static const char * const git_stash_push_usage[] = {
-	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]\n"
+	N_("git stash [push [-p | --patch] [-k | --[no-]keep-index] [-q | --quiet]\n"
+	   "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n"
 	   "          [--] [<pathspec>...]]"),
 	NULL
 };
 
 static const char * const git_stash_save_usage[] = {
-	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "               [-u|--include-untracked] [-a|--all] [<message>]"),
+	N_("git stash save [-p | --patch] [-k | --[no-]keep-index] [-q | --quiet]\n"
+	   "               [-u | --include-untracked] [-a | --all] [<message>]"),
 	NULL
 };
 
-- 
2.37.3.1425.g73df845bcb2

