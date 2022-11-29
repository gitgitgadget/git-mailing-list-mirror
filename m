Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1B3C46467
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiK2MBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiK2MAm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:00:42 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8745D6B1
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:00:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso877362wmb.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfXSKYN4uD2trQZt63cQVCoom/ppbvhSP7aA5/V63WY=;
        b=fTNCuv4pj2Z2s0ohsCRTZdW9nHR9BxVOlBbDoQbANDDEE+8XSrEUYZoPuBsXMyjqLt
         6ehIll0MoDBHlfTNSNJ16ej2i98p62ZjV0z/i2bVZhSli6kkdUNdVJZVT4xjl9TOcLBF
         J+CD3WqTzh+YjS+7oTWkE/zEMJ4e62d/Pu06ViNRxTnPpwu9WH8Nzy9Z/j1TT0taj9RV
         eiifaMfrI3a2y/8akBfijqnRXfLOtpoDU0n8eIhEdYxIiLnTQkfZooFDoChmh+VaJo0k
         +OnLfxV2pyRxXPNhL3MjdMtOUBJ4/ue3mbDi4NuHmv6xk+S4V7Jtl9Qk+3bTOVRozNJU
         t0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfXSKYN4uD2trQZt63cQVCoom/ppbvhSP7aA5/V63WY=;
        b=UXz4DChqC8qtggnT9Zoeu1MTQP3C1+Hnzid0fd58ulaPu2cz9SdX7xtHh3NmfuUof7
         9agyVe8KHf+GFiAj1Q2CafBFeSJGLV2jeD25yKJ7rSw2FfXUcb8EnXfp1HHJktg5exNC
         n0lCXIh436F7XfsBU79qR2+T3qWb49M5MfYyrIFj4lc2mlCVaA7T20Y5VP0sOS6QvkzS
         smOQ23F4Mvos+yQ3qeZp/a+IcgZQB62keZznUf/fs0nBtpnN4GGaQpCQ0HGNFKWRZIYr
         wZEkfR4dU8BOM5KK3hIqFQQthJLs1Kcr5mNlnl2+At4BiDHFuYQ+iAnWhDzQ9qBHhbSh
         Sd0w==
X-Gm-Message-State: ANoB5pnwCdi6or37YVAvntVrtg66QeuNhxfx1d6qGchgqfqpsJv7+trL
        g75Rfum3i2+mBq2CGpuSWjd8fThYhQE=
X-Google-Smtp-Source: AA0mqf4qYaI0hPuehchfnZjJBGfO1Ypnyioc+LVDsyIBEi5ESYD8M9lnKNiF4xAAtlbkIUu3t51TdQ==
X-Received: by 2002:a7b:c4d8:0:b0:3cf:b0ed:de9d with SMTP id g24-20020a7bc4d8000000b003cfb0edde9dmr27820251wmk.188.1669723224893;
        Tue, 29 Nov 2022 04:00:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003c6c182bef9sm2493868wmq.36.2022.11.29.04.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 04:00:24 -0800 (PST)
Message-Id: <1d1b66188f5c221ecdc165e0dae82932a65a3fbb.1669723221.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1398.v3.git.1669723221.gitgitgadget@gmail.com>
References: <pull.1398.v2.git.1669344333627.gitgitgadget@gmail.com>
        <pull.1398.v3.git.1669723221.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Nov 2022 12:00:21 +0000
Subject: [PATCH v3 2/2] [RPC] grep: introduce --scope option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Because we may want to restrict grep's file scope
to sparse specification, Apply the --scope option
we implemented in diff to grep as well.

`--scope=sparse` mean that the search file scope
restrict to sparse specification when we grep
something in commit history, and `--scope=all`
mean that the search file scope will be full-tree.

Note that `--scope` option only oly takes effect
when "git grep <tree>" is specified.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-grep.txt       | 24 ++++++++++++++++++++++++
 builtin/grep.c                   | 10 ++++++++++
 grep.h                           |  2 ++
 t/t1090-sparse-checkout-scope.sh | 27 +++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index dabdbe8471d..b556f657306 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -28,6 +28,7 @@ SYNOPSIS
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [--recurse-submodules] [--parent-basename <basename>]
+	   [--scope=(sparse|all)]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
@@ -296,6 +297,29 @@ question doesn't support them.
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
+--scope=(sparse|all)::
+	Restrict or not restrict grep path scope in sparse specification.
+	The variants are as follows:
+
++
+--
+`sparse`;;
+	When grep in commit history, restrict the scope of file path
+	to the sparse specification. See sparse specification in
+	link:technical/sparse-checkout.html [the sparse-checkout design
+	document] for more information.
+`all`;;
+	When grep in commit history, the file path scope is full-tree.
+	This is consistent with the current default behavior.
+--
++
+
+Note that `--scope` option only take effect if git command specify `<tree>`.
+
+The behavior of this `--scope` option is experimental and may change
+in the future. See link:technical/sparse-checkout.html [the sparse-checkout
+design document] for more information.
+
 <tree>...::
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.
diff --git a/builtin/grep.c b/builtin/grep.c
index f7821c5fbba..8f7944fb924 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -640,6 +640,15 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		}
 
 		strbuf_add(base, entry.path, te_len);
+		if (opt->scope == SPARSE_SCOPE_SPARSE &&
+			base->len != tn_len &&
+			!path_in_sparse_patterns(base->buf + tn_len,
+					S_ISDIR(entry.mode) ||
+					S_ISGITLINK(entry.mode))) {
+			strbuf_setlen(base, old_baselen);
+			continue;
+		}
+
 
 		if (S_ISREG(entry.mode)) {
 			hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
@@ -999,6 +1008,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_INTEGER('m', "max-count", &opt.max_count,
 			N_("maximum number of results per file")),
+		OPT_SPARSE_SCOPE(&opt.scope),
 		OPT_END()
 	};
 	grep_prefix = prefix;
diff --git a/grep.h b/grep.h
index 6075f997e68..05010d4b166 100644
--- a/grep.h
+++ b/grep.h
@@ -22,6 +22,7 @@ typedef int pcre2_general_context;
 #endif
 #include "thread-utils.h"
 #include "userdiff.h"
+#include "cache.h"
 
 struct repository;
 
@@ -175,6 +176,7 @@ struct grep_opt {
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
 	void *output_priv;
+	enum sparse_scope scope;
 };
 
 #define GREP_OPT_INIT { \
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index e6ec8e8c1e4..c8f68fc7afa 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -382,4 +382,31 @@ M	in
 	test_cmp expected actual
 '
 
+# git grep TREE
+
+test_expect_success 'git grep --scope=all' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+HEAD~:in/1
+HEAD~:out1/1
+HEAD~:out1/2
+HEAD~:out1/3
+HEAD~:out1/4
+HEAD~:out1/5
+HEAD~:out1/6
+HEAD~:out2/1
+	EOF
+	git -C repo grep --name-only --scope=all 1 HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git grep --scope=sparse' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+HEAD~:in/1
+	EOF
+	git -C repo grep --name-only --scope=sparse 1 HEAD~ >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
gitgitgadget
