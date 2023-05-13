Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F49C77B7D
	for <git@archiver.kernel.org>; Sat, 13 May 2023 09:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjEMJLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 05:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjEMJLq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 05:11:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204841FDD
        for <git@vger.kernel.org>; Sat, 13 May 2023 02:11:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1221716f8f.0
        for <git@vger.kernel.org>; Sat, 13 May 2023 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683969102; x=1686561102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuqcVTwG+or9NCqjWa4tDgN0c7ypIb1OL15SAObaJVw=;
        b=UNmDQdLAK45rn8yr2fvaD3qTQgE9osTb8eOJCj5l9oOeZTCJzm1SO8sUuFpEffa1Y3
         xZn9erbM8VVS+l350IH7eDFW8qUt+kpDnsGXyPsw3nMKot5B+izOnNNvf8pWFda8cImQ
         WWev74tnSf/cPNDE1PNDSrGxZnJrkZ6jqEBS0WgrqvTsIgcjScUg9ie4XZYt3M1JT/g5
         nmfQ25ZoA0VoNCSgnmTlA/PNXdQnXnvsB5J6t0TBvB+YXdABpMXGxqqaOSw3f/BS08Gu
         LGwYe5dZo7nnHZraqwInzxLOoHTQNfudS3pXaQrfOtGblPUKpK2k9i5Ol/8B9/QIx+/D
         u5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683969102; x=1686561102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuqcVTwG+or9NCqjWa4tDgN0c7ypIb1OL15SAObaJVw=;
        b=Cl5kLqrQaDyRhrHg7vlv9Yt6t3uRBH6snyRPRHH0QQKfUa+vG8bxuHbaPnrd9Gxsez
         duDYIrSEf9pispwGA2+NRZFDPnp2f3kYUVJ2W0Gqk8i7i60fhukv/1k7x9MOFMzc2t9r
         /Ir8PzbmPoeh+Io29ix8IykuZoRvzuzYUYIRuxzR3Ljs0fG6Jhs7txqze/JXs1hH82oR
         kFrPGH+eS7Zg358Ajp3luU+rC//OktSNn8RMsq+WBJS9oqUrL/Xmbx5Aq/Tptt26dWpY
         fdUkp3hxwgtFTtE0X++tHftl0kb49YQfs5aILpH9JJShvO1XuMCtdLkZaCij5ZeZ+PNp
         vFyg==
X-Gm-Message-State: AC+VfDw00yKY2UxKLKYMOr+mdJkprwcLYUO3V9PSH42mmMBNUUbG9+fN
        rZLY3xbyMc2R5xmVjkuVD198lnls6BQ=
X-Google-Smtp-Source: ACHHUZ4PV9Rp9/MlwF6wQSVdvUHwOC009E3PRN7lrY8G1lK5ofC7ouHgvQ0dfXmEAR2fR6dq0Gr1QA==
X-Received: by 2002:adf:e6cd:0:b0:307:886f:fac1 with SMTP id y13-20020adfe6cd000000b00307886ffac1mr18167737wrm.35.1683969101860;
        Sat, 13 May 2023 02:11:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15-20020adff7cf000000b002f6176cc6desm25736680wrq.110.2023.05.13.02.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 02:11:41 -0700 (PDT)
Message-Id: <3f8884457d3628439aa9e6800c976f5a597cdda3.1683969100.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
References: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 May 2023 09:11:38 +0000
Subject: [PATCH 1/2] ls-files: add %(objecttype) atom to format option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Martin Monperrus <martin.monperrus@gnieh.org>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Sometimes users may want to align the feature of
`git ls-files --format` with that of `git ls-tree --format`,
but the %(objecttype) atom is missing in the format option
of git ls-files compared to git ls-tree.

Therefore, the %(objecttype) atom is added to the format option
of git ls-files, which can be used to obtain the object type
of the file which is recorded in the index.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-ls-files.txt | 2 ++
 builtin/ls-files.c             | 2 ++
 t/t3013-ls-files-format.sh     | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 1abdd3c21c5..4356c094cec 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -270,6 +270,8 @@ interpolated.  The following "fieldname" are understood:
 
 objectmode::
 	The mode of the file which is recorded in the index.
+objecttype::
+	The object type of the file which is recorded in the index.
 objectname::
 	The name of the file which is recorded in the index.
 stage::
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 625f48f0d61..6ff764cda18 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -272,6 +272,8 @@ static size_t expand_show_index(struct strbuf *sb, const char *start,
 		strbuf_addf(sb, "%06o", data->ce->ce_mode);
 	else if (skip_prefix(start, "(objectname)", &p))
 		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
+	else if (skip_prefix(start, "(objecttype)", &p))
+		strbuf_addstr(sb, type_name(object_type(data->ce->ce_mode)));
 	else if (skip_prefix(start, "(stage)", &p))
 		strbuf_addf(sb, "%d", ce_stage(data->ce));
 	else if (skip_prefix(start, "(eolinfo:index)", &p))
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index ef6fb53f7f1..3a1da3d6697 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -38,6 +38,13 @@ test_expect_success 'git ls-files --format objectname v.s. -s' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git ls-files --format objecttype' '
+	git ls-files --format="%(objectname)" o1.txt o4.txt o6.txt >objectname &&
+	git cat-file --batch-check="%(objecttype)" >expect <objectname &&
+	git ls-files --format="%(objecttype)" o1.txt o4.txt o6.txt >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git ls-files --format v.s. --eol' '
 	git ls-files --eol >tmp &&
 	sed -e "s/	/ /g" -e "s/  */ /g" tmp >expect 2>err &&
-- 
gitgitgadget

