Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288FFC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387217AbiFHAaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842631AbiFHAJx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 20:09:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3973A0E6B
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:57:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so2311608wmq.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I7AINGUmprrzHHeSmhIZA7ZqetYf9w5xegoq8SYlNaA=;
        b=TT/V1exS3weEF7B0CeXiv8QjQcJQDQHQlgTfwu4Q9O4Sw+rOIlv7TO5B9t6I6moSBl
         RFVT7+X9cM9rFSjC7UCq1rTYxtYIpkaUiYa8mFX3syRHsTr+oFQCupEsER2aNoB0b0yF
         xS0p4nLHkVWO+InsbiTWGgcbcM2tmXZ7dYLYbBhAXxl2W9hc0B9reYjyF6E5MTChgWID
         OXIm7QLdVIKZBn8KTPndLJoMp0TiEQ3wz6QrCdtVb7+7Bx9IwK50TZ/T66l3rdhSrat3
         jFxqzmf0n1IQ7u5oop33r0FARdR188Qv+c+C9lzPK1CtkGOveq/WGYsVp4r2slINb0Tm
         uO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I7AINGUmprrzHHeSmhIZA7ZqetYf9w5xegoq8SYlNaA=;
        b=w39RRO+iQcErfazkxOV4fyxoUpCu1NReXST/Dtb0M/nrFK7p7kk30PK4vfPhjCuHiC
         kQ9ttuU6uCp3NMsxdsVHee558YqOVMcIhF7AZgmqKeVgKZPPDJfWUe5br5lqAt1W+rDl
         vMSbgandbloDYidZjiobd9gxdQgmhizccBAxPAItTKAcZC/bKMXwGmLpWFbkvsqCviUX
         p3pU6+0OgyN/KHShPwrGD80kjO0XXoH1/C8HjlyJRHXRvEOl0vZ8KxbgdAJ5Lgnjen4u
         fy103XB61NY9wXpBTHogmbKVqrYDkLsfJr9gfam4gaQNvP48g5oy4zEesUr8pkMlAX4H
         hhGw==
X-Gm-Message-State: AOAM530d9quMbFQHj4MlzcS4j/ozRwOL6rkIIB8KGbgmkMdCeYezjptw
        F2Q6RhnPXwfKu546sUc3MPTpu8FKdU2V4Wui
X-Google-Smtp-Source: ABdhPJytoDNFN1dKPMJE46hL9uCybrMLCHVv4UAb5NKq+bij+mBMf+pIQXG8x80uk9IIh4rSJpVRGQ==
X-Received: by 2002:a05:600c:4f96:b0:397:652a:69d0 with SMTP id n22-20020a05600c4f9600b00397652a69d0mr59151196wmq.16.1654635435440;
        Tue, 07 Jun 2022 13:57:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e40-20020a5d5968000000b00213ba0cab3asm14271187wri.44.2022.06.07.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:57:14 -0700 (PDT)
Message-Id: <c0e27ab3b3e7344336580a2f5f34574a08a35a1f.1654635432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
References: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:57:08 +0000
Subject: [PATCH v4 1/5] Documentation/git-config.txt: add SCOPES section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

In a subsequent commit, we will introduce "protected config", which is
easiest to describe in terms of configuration scopes (i.e. it's the
union of the 'system', 'global', and 'command' scopes). This description
is fine for ML discussions, but it's inadequate for end users because we
don't provide a good description of "config scopes" in the public docs.

145d59f482 (config: add '--show-scope' to print the scope of a config
value, 2020-02-10) introduced the word "scope" to our public docs, but
that only enumerates the scopes and assumes the user can figure out
those values mean.

Add a SCOPES section to Documentation/git-config.txt that describes the
config scopes, their corresponding CLI options, and mentions that some
configuration options are only respected in certain scopes. Then,
use the word "scope" to simplify the FILES section and change some
confusing wording.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/git-config.txt | 64 ++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index bdcfd94b642..5e4c95f2423 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -297,8 +297,8 @@ The default is to use a pager.
 FILES
 -----
 
-If not set explicitly with `--file`, there are four files where
-'git config' will search for configuration options:
+By default, 'git config' will read configuration options from multiple
+files:
 
 $(prefix)/etc/gitconfig::
 	System-wide configuration file.
@@ -322,27 +322,63 @@ $GIT_DIR/config.worktree::
 	This is optional and is only searched when
 	`extensions.worktreeConfig` is present in $GIT_DIR/config.
 
-If no further options are given, all reading options will read all of these
-files that are available. If the global or the system-wide configuration
-file are not available they will be ignored. If the repository configuration
-file is not available or readable, 'git config' will exit with a non-zero
-error code. However, in neither case will an error message be issued.
+You may also provide additional configuration parameters when running any
+git command by using the `-c` option. See linkgit:git[1] for details.
+
+Options will be read from all of these files that are available. If the
+global or the system-wide configuration file are not available they will be
+ignored. If the repository configuration file is not available or readable,
+'git config' will exit with a non-zero error code. However, in neither case
+will an error message be issued.
 
 The files are read in the order given above, with last value found taking
 precedence over values read earlier.  When multiple values are taken then all
 values of a key from all files will be used.
 
-You may override individual configuration parameters when running any git
-command by using the `-c` option. See linkgit:git[1] for details.
-
-All writing options will per default write to the repository specific
+By default, options are only written to the repository specific
 configuration file. Note that this also affects options like `--replace-all`
 and `--unset`. *'git config' will only ever change one file at a time*.
 
-You can override these rules using the `--global`, `--system`,
-`--local`, `--worktree`, and `--file` command-line options; see
-<<OPTIONS>> above.
+You can change the way options are read/written by specifying the path to a
+file (`--file`), or by specifying a configuration scope (`--system`,
+`--global`, `--local`, `--worktree`); see <<OPTIONS>> above.
+
+SCOPES
+------
+
+Each configuration source falls within a configuration scope. The scopes
+are:
+
+system::
+	$(prefix)/etc/gitconfig
+
+global::
+	$XDG_CONFIG_HOME/git/config
++
+~/.gitconfig
+
+local::
+	$GIT_DIR/config
+
+worktree::
+	$GIT_DIR/config.worktree
+
+command::
+	environment variables
++
+the `-c` option
+
+With the exception of 'command', each scope corresponds to a command line
+option - `--system`, `--global`, `--local`, `--worktree`.
+
+When reading options, specifying a scope will only read options from the
+files within that scope. When writing options, specifying a scope will write
+to the files within that scope (instead of the repository specific
+configuration file). See <<OPTIONS>> above for a complete description.
 
+Most configuration options are respected regardless of the scope it is
+defined in, but some options are only respected in certain scopes. See the
+option's documentation for the full details.
 
 ENVIRONMENT
 -----------
-- 
gitgitgadget

