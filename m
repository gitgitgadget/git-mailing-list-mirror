Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20471C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 02:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384116AbhLDC7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 21:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbhLDC7D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 21:59:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32201C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 18:55:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso5470854wmh.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gQ0ypipIOhDEidSqnzGSV2bK/YJ6VXsd7/PALHaW+mw=;
        b=OqOpHdoHNSxlQM2MuRRSk1912q5Z/nX/DwA9iiAk9Scn+jdp7800oDbdEDpvcivXTm
         L7/+qIqtupsr+N/7DrLIFPy/zhdvNS8lQ83Tt0rzte7k+08STL7Jp4fQXSpoMotwVzVy
         8TcwYeFY+9c7KbTkYgochjDKswRmQHcEnlZz/m0z2PJJoLfK25eP4uo8yQq38VEckwjm
         NR2YTyYzfm4EoY8UWmXLqQXQlIeRQX0SeK0sYbZxoTFZC6vIcy0tzXsj6/FpnRUZnoGc
         qzqXAvWExqgocIH9tmUvHTN8WYxBgErzHGtlOPEzKc41KnKM+EQMT9rkvhpgkvqZVQkC
         k6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gQ0ypipIOhDEidSqnzGSV2bK/YJ6VXsd7/PALHaW+mw=;
        b=VgKcOpEC0tD5Apz2fVHJGehUp7b+KuUJvbshHB1i8M2mb6c4u//KJgjIs0MogvcchK
         yBmPAkHS0y03mt2kCGH40qGDHxS6aSd6LXSIqtO/wsaRv6U18zBRDImKO+qzV6DBxCE3
         +2sfHBpjskzRNorPp/hQ9AL9PwDvG95DOk2It2uVRVM9n2BRQB2qH+B4ZOW6PiQkIGRv
         DE2a4LKB/Va/MQSE2SC2B4JWllg/LerY63llmr5nm6aR7nRyygHdi14o4X6ea4a5WW8d
         9Kp9DWUiuQofpE6Ad2BdjHxSQkJTwNANAVjGieKnCXfk3lEPBp61fpLryJW+eDX+Fglu
         td5g==
X-Gm-Message-State: AOAM531DOb8UvS2VdFeWuSIUmYfl2rwZYmPr+QehUcngfRO3kkh17fc2
        YMk47Ker1g0kCVaIkU8YIe0RD2fPSSE=
X-Google-Smtp-Source: ABdhPJwZmR8KZ2m9bTWdVIpZdnI1w2VeJT4GljsJqFVhP3spoYBQpPqNR3ytMar0bXX6CeMDmDPu4A==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr19809800wmh.140.1638586536616;
        Fri, 03 Dec 2021 18:55:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15sm7708185wmq.18.2021.12.03.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:55:36 -0800 (PST)
Message-Id: <ba05d7d4149bc4e9e931aa225cd1fc013796d7b3.1638586534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
References: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 02:55:33 +0000
Subject: [PATCH 1/2] t1092: add deeper changes during a checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, vdye@github.com, gitster@pobox.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Extend the repository data in the setup of t1092 to include more
directories within two parent directories. This reproduces a bug found
by users of the sparse index feature with suitably-complicated
sparse-checkout definitions.

Add a failing test that fails in its first 'git checkout deepest' run in
the sparse index case with this error:

  error: Your local changes to the following files would be overwritten by checkout:
          deep/deeper1/deepest2/a
          deep/deeper1/deepest3/a
  Please commit your changes or stash them before you switch branches.
  Aborting

The next change will fix this error, and that fix will make it clear why
the extra depth is necessary for revealing this bug. The assignment of
the sparse-checkout definition to include deep/deeper1/deepest as a
sibling directory is important to ensure that deep/deeper1 is not a
sparse directory entry, but deep/deeper1/deepest2 is.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 16fbd2c6db9..e6aef40e9b3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -19,6 +19,8 @@ test_expect_success 'setup' '
 		mkdir folder1 folder2 deep x &&
 		mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
 		mkdir deep/deeper1/deepest &&
+		mkdir deep/deeper1/deepest2 &&
+		mkdir deep/deeper1/deepest3 &&
 		echo "after deeper1" >deep/e &&
 		echo "after deepest" >deep/deeper1/e &&
 		cp a folder1 &&
@@ -30,7 +32,9 @@ test_expect_success 'setup' '
 		cp a deep/deeper2 &&
 		cp a deep/later &&
 		cp a deep/deeper1/deepest &&
-		cp -r deep/deeper1/deepest deep/deeper2 &&
+		cp a deep/deeper1/deepest2 &&
+		cp a deep/deeper1/deepest3 &&
+		cp -r deep/deeper1/ deep/deeper2 &&
 		mkdir deep/deeper1/0 &&
 		mkdir deep/deeper1/0/0 &&
 		touch deep/deeper1/0/1 &&
@@ -126,6 +130,8 @@ test_expect_success 'setup' '
 
 		git checkout -b deepest base &&
 		echo "updated deepest" >deep/deeper1/deepest/a &&
+		echo "updated deepest2" >deep/deeper1/deepest2/a &&
+		echo "updated deepest3" >deep/deeper1/deepest3/a &&
 		git commit -a -m "update deepest" &&
 
 		git checkout -f base &&
@@ -301,6 +307,14 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+test_expect_failure 'deep changes during checkout' '
+	init_repos &&
+
+	test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
+	test_all_match git checkout deepest &&
+	test_all_match git checkout base
+'
+
 test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
-- 
gitgitgadget

