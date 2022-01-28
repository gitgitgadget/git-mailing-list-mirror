Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B7C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbiA1ANr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344533AbiA1AMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:45 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95750C06174A
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:42 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k18so7628740wrg.11
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IhRGnF3vALkFNHEgMh8q1KvnYK5d8RbyupwCS7Cy+5s=;
        b=bIk8Eft81znFBha/ZXFhisYK6huoEk6+ioq78MR5xngOpp+nVqbu81vuDpGnwnUt/F
         P1zBTaZd7IDoiDUK3BCWYj7yjQOFIj0iRLnL6+6YMNA5jW5yuIWqcIqfooc7NhsrKYKs
         hlBCJFQNx3P3XBrbrH6yzu32Omut3HkOliHIiOXRo9QqYYkXi+MFlp85M/f7xYDFc0KG
         y7Z/lx3t35WAY3diJYajwq7duduWI3HcQ95xnPTsjcuSmbNd++7PJjQpF3yyh2iYEJwH
         EP3VyFSBuxwpoHFYd4enWejQaPqnUy2wr0rOzeWz9dhQp5Sosv1zVo24m8DYhnkI0PeO
         8FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IhRGnF3vALkFNHEgMh8q1KvnYK5d8RbyupwCS7Cy+5s=;
        b=CHtNPpkwefU85Az6peQ0W8t6pRzW5jCYO89s3Bw+ipMIPgPshUsmuL6pZUi3uheVsG
         JFZJG4XDZtMfO/5lxUsqH6hyYu7EsG68QrXlt+Om0SE6Cqa+twdbJv2IZCXfzvzPsm8L
         aiG1I3YCKMPhd0SQ2rks+8lzRJkZrOyoD4u5dw//fKnCPOiMo4G0JxJhCEDb7pbiJ1Vc
         WKy2+Ij552NIwqBWiNJ7baoHg44WDfsW4nGVHgXxH51tPJSD2eQ5A3dc6HRgvIgpcFHI
         50lXtAtV4HhxR3cPl8LqvR4m4vRxQcW9DPIohcdMXX9qaguZboO8BfQahYVp+TZ73j7M
         P0uQ==
X-Gm-Message-State: AOAM531ov/BTNuRuJc9SPfILz6NgPSmZCgHauK+nicEZOH7i0JNZzDX5
        4st5bIKx1Po5uNZyVKJKh4WlTADNAgQ=
X-Google-Smtp-Source: ABdhPJw4pc6VhAV2pScpWTJcp9l9+OH7bQK6otrmbgQpeOHKmDEu1b4o220fzdObJ0Z7HFZ2B6puww==
X-Received: by 2002:adf:f291:: with SMTP id k17mr4745434wro.623.1643328761098;
        Thu, 27 Jan 2022 16:12:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm3493016wri.80.2022.01.27.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:40 -0800 (PST)
Message-Id: <cce533486db27e0c906c91b37f30b2ef12b2ee7c.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:31 +0000
Subject: [PATCH 10/11] bisect: remove Cogito-related code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Once upon a time, there was this idea that Git would not actually be a
single coherent program, but rather a set of low-level programs that
users cobble together via shell scripts, or develop high-level user
interfaces for Git, or both.

Cogito was such a high-level user interface, incidentally implemented
via shell scripts that cobble together Git calls.

It did turn out relatively quickly that Git would much rather provide a
useful high-level user interface itself.

As of April 19th, 2007, Cogito was therefore discontinued (see
https://lore.kernel.org/git/20070419124648.GL4489@pasky.or.cz/).

Nevertheless, for almost 15 years after that announcement, Git carried
special code in `git bisect` to accommodate Cogito.

Since it is beyond doubt that there are no more Cogito users, let's
remove the last remnant of Cogito-accommodating code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 189aca9dd22..479d68dd3b5 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -15,7 +15,6 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
@@ -756,13 +755,6 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
 		} else if (!get_oid(head, &head_oid) &&
 			   skip_prefix(head, "refs/heads/", &head)) {
-			/*
-			 * This error message should only be triggered by
-			 * cogito usage, and cogito users should understand
-			 * it relates to cg-seek.
-			 */
-			if (!is_empty_or_missing_file(git_path_head_name()))
-				return error(_("won't bisect on cg-seek'ed tree"));
 			strbuf_addstr(&start_head, head);
 		} else {
 			return error(_("bad HEAD - strange symbolic ref"));
-- 
gitgitgadget

