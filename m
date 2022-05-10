Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60AFC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 19:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiEJT1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 15:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbiEJT1R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 15:27:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A924091
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i5so25143700wrc.13
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=e+yaCp2AWVyPT9Qwax0nNgC6nDMBTNHjoL7sx7vWZucrpMtXMmBj3aMTH/yUNyMAqt
         XGUCJgCNpAke6HHcovapI8quOEy40l/GfZ2ogs1OT0yQJNpv1kdLYunBdCuTHFZtgHWK
         v9HhBiWmey0kjqtjwOqg8zjJjpkeoCd8gphYcGDVYMtluNN73k3Qisrlqa1nd9IoLEE+
         UNp9J37cbLK2cs8kMu+OQWAVg9NlzClDbTn/jtuDKLuIjxY05fLE1mOygRhNdsHgZWcL
         VpC3iPv9xx8PWLw8GTaJe2viDpbiKLhAGZKWf/sDHvnrT9datXHxWXnH+Zi7TcW7Bd9L
         ynAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=jPPJWdDWjCCjgKF8ekN2WjRrKr0/vDwW2nkDP9UvTFgUgwHO3SWYAqGw0H7OaVUjNJ
         Wg8ZogLMWISk/9B3/2lxlCqcBulN9Lz+VggzIurmFsAJa1Cb6g51Tqr0R6h3YGTe1l0K
         r7LNLE01mVkJloT9vc3iaz1NEa4fFkE77lmJPm3lpt1Rl6E5MyHFjCKCQ6LB0Y9/PJcs
         9zozHPwoOpxJid4Jk/pAU2tG6d3bHUnRk1KhPiTsYkiiR4c3QXb7y4ILQKn5HywVx/ao
         sVSUqXzkf7s4GKS9pZxlzca5/5Fxt7C4nSLtK+zsQoSNHwV+gofLvm+K4fE9Rwi+RrpG
         JhFg==
X-Gm-Message-State: AOAM5301zxULN5MLQ5XIc1iQ4TCkhEuJSs9nhDUZG05sMIsR6njyLkF9
        w1jrIAmnh9FrnHQR7TDLspycyKvf5N0=
X-Google-Smtp-Source: ABdhPJwiWiuS5Sfj8W38NgVSFxtq49VAH18r36TjjPtQ+qBc0ef2dxd37ENgcyPaFr5XzI+qDl2dUg==
X-Received: by 2002:a05:6000:707:b0:20c:4fd8:1d61 with SMTP id bs7-20020a056000070700b0020c4fd81d61mr20421118wrb.407.1652210830875;
        Tue, 10 May 2022 12:27:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12-20020adffd8c000000b0020c5253d8f2sm14324436wrr.62.2022.05.10.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:27:09 -0700 (PDT)
Message-Id: <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 19:27:00 +0000
Subject: [PATCH v4 3/7] scalar: validate the optional enlistment argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `scalar` command needs a Scalar enlistment for many subcommands, and
looks in the current directory for such an enlistment (traversing the
parent directories until it finds one).

These is subcommands can also be called with an optional argument
specifying the enlistment. Here, too, we traverse parent directories as
needed, until we find an enlistment.

However, if the specified directory does not even exist, or is not a
directory, we should stop right there, with an error message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 6 ++++--
 contrib/scalar/t/t9099-scalar.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 1ce9c2b00e8..00dcd4b50ef 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -43,9 +43,11 @@ static void setup_enlistment_directory(int argc, const char **argv,
 		usage_with_options(usagestr, options);
 
 	/* find the worktree, determine its corresponding root */
-	if (argc == 1)
+	if (argc == 1) {
 		strbuf_add_absolute_path(&path, argv[0]);
-	else if (strbuf_getcwd(&path) < 0)
+		if (!is_directory(path.buf))
+			die(_("'%s' does not exist"), path.buf);
+	} else if (strbuf_getcwd(&path) < 0)
 		die(_("need a working directory"));
 
 	strbuf_trim_trailing_dir_sep(&path);
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 2e1502ad45e..9d83fdf25e8 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -85,4 +85,9 @@ test_expect_success 'scalar delete with enlistment' '
 	test_path_is_missing cloned
 '
 
+test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
+	! scalar run config cloned 2>err &&
+	grep "cloned. does not exist" err
+'
+
 test_done
-- 
gitgitgadget

