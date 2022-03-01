Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C910C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiCAU0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238379AbiCAU0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:26:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF058C7F3
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p4so8169707wmg.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GS3guX4JeL6g22B1VqhKzTS5zc/tR36UdzmLu842dCU=;
        b=nQswpv6/xBEilzFMmt0yKwKdYpTpaR/9DenzuK7JBtV54hg4aWSHwBibx692O/eCCf
         J49zOt81dlFYqWY476YBEGNUsPey3sEjaIRqWY8hB78bpTj4SChAQxKeKcrseIA9ju//
         5UKOVbtoa98w8oH0O5t1AmBoh/hs2G54Il+UR3IdKizcWJfT8QaTJodtOiKD/NEO8S64
         Dcdfv1GiYnhgvaYaeSMaatlKNisFSwqieUH+owBiosXHwrLfW6wKG6Bw8tuBkpIlrhTl
         HhYFxxiMyT21z9dK3U/m/WWYb17u/wbUBwdybQgWNL9eHN3rW6OIxGX7Nas5jMBtnh/E
         CYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GS3guX4JeL6g22B1VqhKzTS5zc/tR36UdzmLu842dCU=;
        b=mvoZMkw5IbubG+h7EpsFkZmxlA5ya+kl8GHhCTfIH6FpoG8HNJ0yoYwS6aGfNex7U4
         dh6cEBXHSqYMO6BeW2Gl209HR5NUy45RfJ3V38bC7LbSemOpUwGx+utZRg2XRO/6+JG4
         fxOoxot4Ve95VBCgi5pl/2ZX/jkBQqnAEM2+/EKT/1VzmtbjXhVo7gXmqhH1P8frbmuO
         xPuBxflnf9Gul+Tyt4kwcRe5/6HK5gNYPk4RXIxDfyae9kiPBumdZC1GdLqnSCD5UQl8
         LRWwp4CYXCH/x+bSI/UWmjmCd5AJLjJOVaYimTiOOu2zbMQpITmrRw5HUfbrrSUGCffq
         hHhA==
X-Gm-Message-State: AOAM533f6vGaFpcxT47zi++PndzrVFPxqs28IKGjyYfNMa+3/WXIkboz
        Z0mjMersKiUjPEwr84rF35GwaAeFt5o=
X-Google-Smtp-Source: ABdhPJykBPzp3Awg/54bcno/yiTOeM98PVOR3ROjnjS+qKMHoTw8fARkTm+LdThyfZVfB5KeDwnUWg==
X-Received: by 2002:a1c:f719:0:b0:381:ba:5247 with SMTP id v25-20020a1cf719000000b0038100ba5247mr18016024wmh.183.1646166273357;
        Tue, 01 Mar 2022 12:24:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020adff590000000b001f0122f63e1sm2979031wro.85.2022.03.01.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:24:32 -0800 (PST)
Message-Id: <744668eeece68a8cfe98b91c50d1cadb6988b993.1646166271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
        <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 20:24:24 +0000
Subject: [PATCH v3 1/8] sparse-index: prevent repo root from becoming sparse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Prevent the repository root from being collapsed into a sparse directory by
treating an empty path as "inside the sparse-checkout". When collapsing a
sparse index (e.g. in 'git sparse-checkout reapply'), the root directory
typically could not become a sparse directory due to the presence of in-cone
root-level files and directories. However, if no such in-cone files or
directories were present, there was no explicit check signaling that the
"repository root path" (an empty string, in the case of
'convert_to_sparse(...)') was in-cone, and a sparse directory index entry
would be created from the repository root directory.

The documentation in Documentation/git-sparse-checkout.txt explicitly states
that the files in the root directory are expected to be in-cone for a
cone-mode sparse-checkout. Collapsing the root into a sparse directory entry
violates that assumption, as sparse directory entries are expected to be
outside the sparse cone and have SKIP_WORKTREE enabled. This invalid state
in turn causes issues with commands that interact with the index, e.g.
'git status'.

Treating an empty (root) path as in-cone prevents the creation of a root
sparse directory in 'convert_to_sparse(...)'. Because the repository root is
otherwise never compared with sparse patterns (in both cone-mode and
non-cone sparse-checkouts), the new check does not cause additional changes
to how sparse patterns are applied.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 dir.c                                    |  7 ++++---
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index d91295f2bcd..a136377eb49 100644
--- a/dir.c
+++ b/dir.c
@@ -1463,10 +1463,11 @@ static int path_in_sparse_checkout_1(const char *path,
 	const char *end, *slash;
 
 	/*
-	 * We default to accepting a path if there are no patterns or
-	 * they are of the wrong type.
+	 * We default to accepting a path if the path is empty, there are no
+	 * patterns, or the patterns are of the wrong type.
 	 */
-	if (init_sparse_checkout_patterns(istate) ||
+	if (!*path ||
+	    init_sparse_checkout_patterns(istate) ||
 	    (require_cone_mode &&
 	     !istate->sparse_checkout_patterns->use_cone_patterns))
 		return 1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f3a059e5af5..9ef7cd80885 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -244,6 +244,24 @@ test_expect_success 'expanded in-memory index matches full index' '
 	test_sparse_match git ls-files --stage
 '
 
+test_expect_success 'root directory cannot be sparse' '
+	init_repos &&
+
+	# Remove all in-cone files and directories from the index, collapse index
+	# with `git sparse-checkout reapply`
+	git -C sparse-index rm -r . &&
+	git -C sparse-index sparse-checkout reapply &&
+
+	# Verify sparse directories still present, root directory is not sparse
+	cat >expect <<-EOF &&
+	folder1/
+	folder2/
+	x/
+	EOF
+	git -C sparse-index ls-files --sparse >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'status with options' '
 	init_repos &&
 	test_sparse_match ls &&
-- 
gitgitgadget

