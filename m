Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5017FC433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 10:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4542067C
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 10:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxtTHpp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgHPKBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 06:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgHPKBh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 06:01:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A05C061786
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 03:01:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j22so6903774lfm.2
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 03:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPz8ff6UI+ShuGf+iLVJBYsHh0pNmAiX6pSjwzLrpcU=;
        b=YxtTHpp13kO6ldLPjTYJ3GiKLmdJ7uGI7eZ+GJRYjvb9DZ7WxLJDxU/GY+HZ9yuATT
         2676r2IBtRnCnd0Oc4NeMg+grMezPi+w/zi8cJmSIlMhBqh/MEOqBysSuau3SU5LV4F7
         X8Z/9iPE2FVS+/5W6zN84x1ZpJO7biMGL8yJ0XXVBEGNfDoBv/hComZcsSxfTMHT0opn
         BGwniJwhBQw2MMiBVAlZrUPXbzk7vYVodEQQ+V7DqItnMU9x6ow+uJNjDFV5oFAv81Fq
         lPBpO85sq0fJIkNVwh9Ge5JFGftmhZsFNBefBtcGc3bm/PgPq2YK4XIRD7DLFqPzOnDf
         mWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPz8ff6UI+ShuGf+iLVJBYsHh0pNmAiX6pSjwzLrpcU=;
        b=b38v7+8QVXD4T+CnJZrJuS/lJsj/23bHENqdArYkwstY0QpKKoGzWBx+Jtqm5ubQ/7
         PgdF1qm6Hy69kfzZMf4DL1iYx4UuDxGDSwPhjUommx5rm7QfCLbnp5bD7OQhfKtwhg4W
         y3OCHbZzqEXmIRtwCx9YACi9kro4dI5DPeaTGudSnqZQgRRq4qM48vlmB+kkniVLQ+gM
         vBNHma58Z9dZYuuSE/PktGZhSZiP2ulKQUA4QVLKADEc3zIwTjMWjyMjsRy5U1mcsjNw
         sSTBXgeN2En78KgyYn8olM0yPEacopn+dLGWkgH7V72OUzGpZLK7hL7xs5+fWiuSFri8
         A19Q==
X-Gm-Message-State: AOAM532oPmYJUB2dFSuSgnzTK6hnMmEnqe2a/4teslRkZE3xxsst8BQo
        W+wvwB2Gyhg6xqbBT1yxHJEcd4IutY0=
X-Google-Smtp-Source: ABdhPJwP6UckiCpqGbqNxMB5RgwpWsUcKQlvtQGjwQVMXH93khzh0ankRjEZMhW5B6mjPgaMOZPdeQ==
X-Received: by 2002:a19:2388:: with SMTP id j130mr5020950lfj.190.1597572094167;
        Sun, 16 Aug 2020 03:01:34 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id h6sm3733497lfc.84.2020.08.16.03.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 03:01:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Documentation: mark `--object-format=sha256` as experimental
Date:   Sun, 16 Aug 2020 12:01:18 +0200
Message-Id: <20200816100118.30558-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200814005151.GI8085@camp.crustytoothpaste.net>
References: <20200814005151.GI8085@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After eff45daab8 ("repository: enable SHA-256 support by default",
2020-07-29), vanilla builds of Git enable the user to run, e.g.,

  git init --object-format=sha256

and hack away. This can be a good way to gain experience with the
SHA-256 world, e.g., to find bugs that

  GIT_TEST_DEFAULT_HASH=sha256 make test

doesn't spot.

But it really is a separate world: Such SHA-256 repos will live entirely
separate from the (by now fairly large) set of SHA-1 repos. Interacting
across the border is possible in principle, e.g., through "diff + apply"
(or "format-patch + am"), but even that has its limitations: Applying a
SHA-256 diff in a SHA-1 repo works in the simple case, but if you need
to resort to `-3`, you're out of luck.

Similarly, "push + pull" should work, but you really will be operating
mostly offset from the rest of the world. That might be ok by the time
you initialize your repository, and it might be ok for several months
after that, but there might come a day when you're starting to regret
your use of `git init --object-format=sha256` and have dug yourself into
a fairly deep hole.

There are currently topics in flight to document our data formats and
protocols regarding SHA-256 and in some cases (midx and commit-graph),
we're considering adjusting how the file formats indicate which object
format to use.

Wherever `--object-format` is mentioned in our documentation, let's make
it clear that using it with "sha256" is experimental. If we later need
to explain why we can't handle data we generated back in 2020, we can
always point to this paragraph we're adding here.

By "include::"-ing a small blurb, we should be able to be consistent
throughout the documentation and can eventually gradually tone down the
severity of this text. One day, we might even use it to start phasing
out `--object-format=sha1`, but let's not get ahead of ourselves...

There's also `extensions.objectFormat`, but it's only mentioned three
times. Twice where we're adding this new disclaimer and in the third
spot we already have a "do not edit" warning. From there, interested
readers should eventually find this new one that we're adding here.

Because `GIT_DEFAULT_HASH` provides another entry point to this
functionality, document the experimental nature of it too.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Given the in-flight topics to document various SHA-256 details, I think
 it makes sense to simplify the commit message a bit. The diff is the
 same as in the original submission of this patch [1].

 [1] https://lore.kernel.org/git/20200806202358.2265705-1-martin.agren@gmail.com/

Range-diff against v1:
1:  19d5bb5028 ! 1:  0c2b124cfd Documentation: mark `--object-format=sha256` as experimental
    @@ Commit message
         your use of `git init --object-format=sha256` and have dug yourself into
         a fairly deep hole.
     
    -    Workflows aside, let's consider a more technical aspect. Pack index
    -    files (pack-*.idx) exist in two flavours: v1 and v2. The hash transition
    -    document foresees a v3, which we do not yet support (and for all we
    -    know, the final v3 might end up different from the one sketched in the
    -    hash transition document).
    -
    -    When the test suite is run with SHA-1 as the default hash algo, it
    -    creates and consumes v2 pack files. But with SHA-256, we use an
    -    undocumented, hybrid format where the header looks like v2, but where
    -    the payload is not only "not correct SHA1", but where even the data
    -    sizes are different. The trailing checksum is different, meaning no-one
    -    (except us!) should/would try to interpret this file as a proper v2 pack
    -    index.
    -
    -    We could certainly (re)define v2 to match our SHA-256 behavior, but we
    -    do foresee v3 for a reason. And that would still just fix this specific
    -    issue. And even when everything around SHA-256 is well-defined and we
    -    have SHA-1--SHA-256 interoperability, there's a risk, at least
    -    initially, that somewhere we'd be permeating buggy data that we'd then
    -    feel responsible for and need to be able to handle for a long time to
    -    come.
    -
    -    In short: we need some time and leeway.
    +    There are currently topics in flight to document our data formats and
    +    protocols regarding SHA-256 and in some cases (midx and commit-graph),
    +    we're considering adjusting how the file formats indicate which object
    +    format to use.
     
         Wherever `--object-format` is mentioned in our documentation, let's make
         it clear that using it with "sha256" is experimental. If we later need
    @@ Commit message
         functionality, document the experimental nature of it too.
     
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/git-index-pack.txt ##
     @@ Documentation/git-index-pack.txt: OPTIONS

 Documentation/git-index-pack.txt           | 2 ++
 Documentation/git-init.txt                 | 2 ++
 Documentation/git-show-index.txt           | 2 ++
 Documentation/git.txt                      | 3 ++-
 Documentation/object-format-disclaimer.txt | 6 ++++++
 5 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/object-format-disclaimer.txt

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index ac74d058e0..af0c26232c 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -100,6 +100,8 @@ OPTIONS
 	value is set or outside a repository.
 +
 This option cannot be used with --stdin.
++
+include::object-format-disclaimer.txt[]
 
 NOTES
 -----
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index ddfe265da5..f35f70f13d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -53,6 +53,8 @@ current working directory.
 
 Specify the given object format (hash algorithm) for the repository.  The valid
 values are 'sha1' and (if enabled) 'sha256'.  'sha1' is the default.
++
+include::object-format-disclaimer.txt[]
 
 --template=<template_directory>::
 
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index 39b1d8eaa1..e49318a5a0 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -44,6 +44,8 @@ OPTIONS
 	valid values are 'sha1' and (if enabled) 'sha256'.  The default is the
 	algorithm for the current repository (set by `extensions.objectFormat`), or
 	'sha1' if no value is set or outside a repository..
++
+include::object-format-disclaimer.txt[]
 
 GIT
 ---
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3e50065198..e0a2690ba2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -497,7 +497,8 @@ double-quotes and respecting backslash escapes. E.g., the value
 	If this variable is set, the default hash algorithm for new
 	repositories will be set to this value. This value is currently
 	ignored when cloning; the setting of the remote repository
-	is used instead. The default is "sha1".
+	is used instead. The default is "sha1". THIS VARIABLE IS
+	EXPERIMENTAL! See `--object-format` in linkgit:git-init[1].
 
 Git Commits
 ~~~~~~~~~~~
diff --git a/Documentation/object-format-disclaimer.txt b/Documentation/object-format-disclaimer.txt
new file mode 100644
index 0000000000..4cb106f0d1
--- /dev/null
+++ b/Documentation/object-format-disclaimer.txt
@@ -0,0 +1,6 @@
+THIS OPTION IS EXPERIMENTAL! SHA-256 support is experimental and still
+in an early stage.  A SHA-256 repository will in general not be able to
+share work with "regular" SHA-1 repositories.  It should be assumed
+that, e.g., Git internal file formats in relation to SHA-256
+repositories may change in backwards-incompatible ways.  Only use
+`--object-format=sha256` for testing purposes.
-- 
2.28.0.297.g1956fa8f8d

