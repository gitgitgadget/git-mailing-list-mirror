Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0FAECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiIEI1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiIEI04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:26:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80116247
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:26:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c11so6043495wrp.11
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Nca9cQSjQjhiB0HPg2qugvvNPWg1ZlGvn25uR3weN1Q=;
        b=SYBSEvqU0t6ns9Lt8ls2aieey5mjUHS2gEM42Fw9QSEzHkd0iFTEi1YG6sFLLmZkod
         U8aW7G5Xj54t/ABOlxN9CUymmqrZWf9BdxgsRYx2vXLNAu55dg9qLYQCVSmolU5H9tvT
         VqiI2944t1Xt2ZK69g/AAdL3Y93HPH0GzyB7EFHvqfg0esTg6NME8R6u8b1xbv/h3xys
         OS4vLes6b3YiOW4ExgkzO3rinzZjItfdCCZCx0Zy/IyKQY5h0M41EqcPhjPjFsGSzBKk
         x++hlBASqDSRPN7OnBurUxHW4HlOXQoJYMRPQilxeOGtVmgKIahVwkqPQa/TYbLGVKYg
         8UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Nca9cQSjQjhiB0HPg2qugvvNPWg1ZlGvn25uR3weN1Q=;
        b=PYH21dH6trwetU5OztINK5cm6o/ytRym0swoOFKcJU0EOWVUhkr7AAcOOJyRQ50wyk
         XVOOTXp/Kc1IHr6P3Vt8J1PIKIh5pzHkqYJNJ9ZhrSRwdyX27ttYNVQIqYCkGlKwNnYS
         92snAVfjpRmDDJGtf7pJRzaSZdcu5MMFHzC1pqNTe9krG8unaTV9/k8kBFl0tYol7kt8
         Za6xJtP88Fm+hJ/1ZP5HOC8EJv7k5v/fDj+PuoWwC0OYo7Oqgpx5no3TyqPfThpObro+
         GEXKdKs1dD3SOA4OT7jim2yOL6vsVCL9E77TsGgqmKeWV3txCL2xStGlbmmjXi20L3Y1
         S95g==
X-Gm-Message-State: ACgBeo23pCyYAdLZCPRchnrVAtk7NayVQ+zLZEXrZ6kzSWXISiw7L1DR
        epCibL9wGUCgGFU1aIaO/eS9QZf9E1hteA==
X-Google-Smtp-Source: AA6agR64u0MiNSZw8U2zN/PGaod3AuySMKBOpjfFhuXmmWc9JVXE6uytrO+99akUFm1MwzNZ6FDkvQ==
X-Received: by 2002:a05:6000:2c1:b0:226:e7d0:f098 with SMTP id o1-20020a05600002c100b00226e7d0f098mr15564432wry.578.1662366414184;
        Mon, 05 Sep 2022 01:26:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:53 -0700 (PDT)
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
Subject: [PATCH 03/34] bundle: define subcommand -h in terms of command -h
Date:   Mon,  5 Sep 2022 10:26:14 +0200
Message-Id: <patch-03.34-b49268615c3-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid repeating the "-h" output for the "git bundle" command, and
instead define the usage of each subcommand with macros, so that the
"-h" output for the command itself can re-use those definitions. See
[1], [2] and [3] for prior art using the same pattern.

1. b25b727494f (builtin/multi-pack-index.c: define common usage with a
   macro, 2021-03-30)
2. 8757b35d443 (commit-graph: define common usage with a macro,
   2021-08-23)
3. 1e91d3faf6c (reflog: move "usage" variables and use macros,
   2022-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5c78894afd5..1b08700bf9e 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -11,31 +11,40 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char * const builtin_bundle_usage[] = {
-	N_("git bundle create [<options>] <file> <git-rev-list args>"),
-	N_("git bundle verify [<options>] <file>"),
-	N_("git bundle list-heads <file> [<refname>...]"),
-	N_("git bundle unbundle <file> [<refname>...]"),
-	NULL
+#define BUILTIN_BUNDLE_CREATE_USAGE \
+	N_("git bundle create [<options>] <file> <git-rev-list args>")
+#define BUILTIN_BUNDLE_VERIFY_USAGE \
+	N_("git bundle verify [<options>] <file>")
+#define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
+	N_("git bundle list-heads <file> [<refname>...]")
+#define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
+	N_("git bundle unbundle <file> [<refname>...]")
+
+static char const * const builtin_bundle_usage[] = {
+	BUILTIN_BUNDLE_CREATE_USAGE,
+	BUILTIN_BUNDLE_VERIFY_USAGE,
+	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
+	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
+	NULL,
 };
 
 static const char * const builtin_bundle_create_usage[] = {
-	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	BUILTIN_BUNDLE_CREATE_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_verify_usage[] = {
-	N_("git bundle verify [<options>] <file>"),
+	BUILTIN_BUNDLE_VERIFY_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_list_heads_usage[] = {
-	N_("git bundle list-heads <file> [<refname>...]"),
+	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_unbundle_usage[] = {
-	N_("git bundle unbundle <file> [<refname>...]"),
+	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
 	NULL
 };
 
-- 
2.37.3.1425.g73df845bcb2

