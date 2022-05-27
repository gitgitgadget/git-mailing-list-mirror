Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B86C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352223AbiE0VJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbiE0VJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:09:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C13127196
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u3so7411634wrg.3
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dnD1P4ADjoBiyKOEyyalqXCKrH6TVI6Q+vaQo6UVDdU=;
        b=FSOuNhNQQvDRDjhqkptIkLaL8UghfF4ERVRpsLgElEFRsuw2UmOWRuOMuNi7Pajlso
         T7xzw1IGMEXyLEs+qP/zvlgRuSpZ/BstueHvXHSPnNWqexePRMwuo+SOGImMhgTM2Ida
         0lbd8r/XRwMU5DYUO3ejloaYFM5cG5iYr5EBI8gc1/JiTxP7BhZDba/MRw36IWKEM0LV
         MmK3gLUYonNE2ROza9alwvgcL7WmxjILs5b4DKFdc1wYTDcaQf2GgWmk3Wmc3PjZDbia
         /bKJsZjKiCfZUQt1+uaDGn+9im3/aQluNaE7LHaTWQRQV5LlsH2u2lVUbSygZqbGy5J0
         eCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dnD1P4ADjoBiyKOEyyalqXCKrH6TVI6Q+vaQo6UVDdU=;
        b=f33HnTJ9LOQtFMZBGJjfNkCntt7+BvosPzXofolPaPbmkNqB3IZqHLo41BYamJA3r1
         JC50Vb3bO/fEhEtIBvRhMNMy/N1YVaQBu94DaFR4jEM9yFuMmKw5Zlk0o22ydyCCxNHJ
         kSGABFQkjgbWUGlcQvd1Gqo7BWTutAgE3GQEop9cufPhG9Ste1whaZglzRogQtzJTTYY
         kjEU0aU2AJ2D8f7xsAIl2P26xTaw8X79ytHStIwDlCoikb53Rt3cIVO3fjx9RWfq7qSq
         x4gzlYR4XTWc4KtcWWDMM7oLi0P+FJdPv/ZuNRxUJPS/q0akQfY7WeK3U3PRBO3oXxlz
         PzPw==
X-Gm-Message-State: AOAM530MDa3Oc4ML0teRSgIra2YR6FOLTPtDX0ss7moU9O0jyb2wWOvk
        PVcuKvWjkJCqIWgzK+jjizuUQz1k+9w=
X-Google-Smtp-Source: ABdhPJyWFBy0qEJw9I/bH4AvWWT0LN4Uk/I267QC66wEhYPVyGV4RSXZ94Xb6PFWGMb+TDGQIeKBSw==
X-Received: by 2002:a5d:4ccc:0:b0:210:179c:e503 with SMTP id c12-20020a5d4ccc000000b00210179ce503mr4414689wrt.151.1653685764651;
        Fri, 27 May 2022 14:09:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b003949dbc3790sm3098462wmq.18.2022.05.27.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:09:24 -0700 (PDT)
Message-Id: <575676c760d9a2ce4a59d50e93aa0f45d54620ab.1653685761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 21:09:17 +0000
Subject: [PATCH v3 1/5] Documentation: define protected configuration
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

For security reasons, some config variables are only trusted when they
are specified in so-called 'protected configuration' [1]. A future
commit will introduce another such config variable, so this is a good
time to standardize the documentation and implementation of 'protected
configuration'.

Define 'protected configuration' as global and system-level config, and
mark `safe.directory` 'Protected config only'. In a future commit,
protected configuration will also include "-c".

The following variables are intentionally not marked 'Protected config
only':

- `uploadpack.packObjectsHook` has the same security concerns as
  `safe.directory`, but due to a different implementation, it also
  respects the "-c" option.

  When protected configuration includes "-c", `upload.packObjectsHook`
  will be marked 'Protected config only'.

- `trace2.*` happens to read the same config as `safe.directory` because
  they share an implementation. However, this is not for security
  reasons; it is because we want to start tracing so early that
  repository-level config and "-c" are not available [2].

  This requirement is unique to `trace2.*`, so it does not makes sense
  for protected configuration to be subject to the same constraints.

[1] For example,
https://lore.kernel.org/git/6af83767-576b-75c4-c778-0284344a8fe7@github.com/
[2] https://lore.kernel.org/git/a0c89d0d-669e-bf56-25d2-cbb09b012e70@jeffhostetler.com/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config.txt           |  6 ++++++
 Documentation/config/safe.txt      | 19 ++++++++-----------
 Documentation/glossary-content.txt | 18 ++++++++++++++++++
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e284b042f22..07832de1a6c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -369,6 +369,12 @@ inventing new variables for use in your own tool, make sure their
 names do not conflict with those that are used by Git itself and
 other popular tools, and describe them in your documentation.
 
+Variables marked with '(Protected config only)' are only respected when
+they are specified in protected configuration. This includes global and
+system-level config, and excludes repository config, the command line
+option `-c`, and environment variables. For more details, see the
+'protected configuration' entry in linkgit:gitglossary[7].
+
 include::config/advice.txt[]
 
 include::config/core.txt[]
diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index ae0e2e3bdb4..c1caec460e8 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -1,21 +1,18 @@
 safe.directory::
-	These config entries specify Git-tracked directories that are
-	considered safe even if they are owned by someone other than the
-	current user. By default, Git will refuse to even parse a Git
-	config of a repository owned by someone else, let alone run its
-	hooks, and this config setting allows users to specify exceptions,
-	e.g. for intentionally shared repositories (see the `--shared`
-	option in linkgit:git-init[1]).
+	'(Protected config only) ' These config entries specify
+	Git-tracked directories that are considered safe even if they
+	are owned by someone other than the current user. By default,
+	Git will refuse to even parse a Git config of a repository owned
+	by someone else, let alone run its hooks, and this config
+	setting allows users to specify exceptions, e.g. for
+	intentionally shared repositories (see the `--shared` option in
+	linkgit:git-init[1]).
 +
 This is a multi-valued setting, i.e. you can add more than one directory
 via `git config --add`. To reset the list of safe directories (e.g. to
 override any such directories specified in the system config), add a
 `safe.directory` entry with an empty value.
 +
-This config setting is only respected when specified in a system or global
-config, not when it is specified in a repository config, via the command
-line option `-c safe.directory=<path>`, or in environment variables.
-+
 The value of this setting is interpolated, i.e. `~/<path>` expands to a
 path relative to the home directory and `%(prefix)/<path>` expands to a
 path relative to Git's (runtime) prefix.
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index aa2f41f5e70..a669983abd6 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -483,6 +483,24 @@ exclude;;
 	head ref. If the remote <<def_head,head>> is not an
 	ancestor to the local head, the push fails.
 
+[[def_protected_config]]protected configuration::
+	Protected configuration is configuration that Git considers more
+	trustworthy because it is unlikely to be tampered with by an
+	attacker. For security reasons, some configuration variables are
+	only respected when they are defined in protected configuration.
++
+Protected configuration includes:
++
+- system-level config, e.g. `/etc/git/config`
+- global config, e.g. `$XDG_CONFIG_HOME/git/config` and
+  `$HOME/.gitconfig`
++
+Protected configuration excludes:
++
+- repository config, e.g. `$GIT_DIR/config` and
+  `$GIT_DIR/config.worktree`
+- the command line option `-c` and its equivalent environment variables
+
 [[def_reachable]]reachable::
 	All of the ancestors of a given <<def_commit,commit>> are said to be
 	"reachable" from that commit. More
-- 
gitgitgadget

