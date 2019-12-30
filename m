Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2223C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46112071E
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc2KpvrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfL3SiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:38:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35869 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfL3SiR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 13:38:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so33495586edp.3
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q2odXonTwvV2FGimanevetD9OD/EQhu7Qe7A6gr5ZZQ=;
        b=lc2KpvrPQ7EByYAeEBKO5B6n7FsNPx0m7KqKkzHyvtZylBcTA8yPv/r4Qq+9ap5ozY
         gfmu9dWeOXYsaceknOUTspmgG1fKq8wgI9wYUkrgKig+TP1cvuYnnEuAVdYvk7ME2QgI
         SgjBatUPXws/2uv+gE8KwMwOyxE/IwHRc+CEovXcs3aucMCjtFi2eXR66XsELxn5lrAR
         C+WJ9uhmU29HOWItxljtM4Nk8XGq6pb4aORQaG6rDh27SCm4AduOA+pJoN1JSu7yopxK
         9RUoa1Zhiis8wIyueTH7YXT38lrp5+rofD5i3ZJ2t009PGpykQ4L2IUZFGVVRfz8fYRx
         0Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q2odXonTwvV2FGimanevetD9OD/EQhu7Qe7A6gr5ZZQ=;
        b=ApHnTmBOhlvjRL/V01ARHigSmWIgrRalTs7tj9MX7T0lSqndAWTTgOOtjgnpS7JR3+
         k1ZGoQ8H6zpM2YiQJFnBaIiodSlnDwX3Jcyq7niTfMNsAjkYqNo/kK2LdJYqUISJkgvA
         DIUoILEQZcpjilRhU7MDs9khfJgfebuM5b1wjEmXQIzx67+2Xt9cKQcEOyFgb8rSfjee
         YAwkaFX2t/CNB/0yeXpZ4CIp1ID86JP3IXStDKZSAfespOIwhU7e2lXT6itRWaKxIrx2
         ng+57icJ/eXUExfwUkp4gMnt065D3xio3vKFJzwNDDenax+INngY1IOu28DPvwJGoAqq
         67JQ==
X-Gm-Message-State: APjAAAWgGlHv415HNPbxVt+yF2TGKEP5ZFBTMw1wt/aFwiMOI28qkG+5
        J+9WRn4hA8JpsnLrxfexI4mjigTy
X-Google-Smtp-Source: APXvYqxnv6UQIlOxB7hDpec2t8F76MlmN4lIE0v9Osk7KAoNTc8F7acDW+jyXVLPcL+2P5x11YXD2w==
X-Received: by 2002:aa7:cf83:: with SMTP id z3mr73613073edx.166.1577731095184;
        Mon, 30 Dec 2019 10:38:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19sm5438054edy.46.2019.12.30.10.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 10:38:14 -0800 (PST)
Message-Id: <8ab243c2ccf81ded7a32155dde676a8d368ea567.1577731093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.504.git.1577731093.gitgitgadget@gmail.com>
References: <pull.504.git.1577731093.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 18:38:12 +0000
Subject: [PATCH 1/2] parse_branchname_arg(): extract part as new function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This is done for the next commit to avoid crazy 7x tab code padding.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b52c490c8f..f832040e94 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1115,6 +1115,22 @@ static void setup_new_branch_info_and_source_tree(
 	}
 }
 
+static const char *parse_remote_branch(const char *arg,
+				       struct object_id *rev,
+				       int could_be_checkout_paths,
+				       int *dwim_remotes_matched)
+{
+	const char *remote = unique_tracking_name(arg, rev, dwim_remotes_matched);
+
+	if (remote && could_be_checkout_paths) {
+		die(_("'%s' could be both a local file and a tracking branch.\n"
+			"Please use -- (and optionally --no-guess) to disambiguate"),
+		    arg);
+	}
+
+	return remote;
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
@@ -1225,13 +1241,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 			recover_with_dwim = 0;
 
 		if (recover_with_dwim) {
-			const char *remote = unique_tracking_name(arg, rev,
-								  dwim_remotes_matched);
+			const char *remote = parse_remote_branch(arg, rev,
+								 could_be_checkout_paths,
+								 dwim_remotes_matched);
 			if (remote) {
-				if (could_be_checkout_paths)
-					die(_("'%s' could be both a local file and a tracking branch.\n"
-					      "Please use -- (and optionally --no-guess) to disambiguate"),
-					    arg);
 				*new_branch = arg;
 				arg = remote;
 				/* DWIMmed to create local branch, case (3).(b) */
-- 
gitgitgadget

