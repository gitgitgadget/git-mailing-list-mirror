Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681CF20248
	for <e@80x24.org>; Thu,  7 Mar 2019 15:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfCGP3i (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 10:29:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34664 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGP3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 10:29:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id a16so13824829edn.1
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 07:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OtPzacZEjWNwoQSECuh/B3fJGeYirN/gaWA0giiF204=;
        b=Ovy6sAy8Wg9x9Tdxuuh3OagURcMTKsIIbel5YhO+igoUIXvV/6DupoBrRl85mnsvw3
         vFJ1UOzrkmQRgPmceyyE9b5kXfLWEePNo4IavGLvnVUdraw6F7okLVYbNNT8aBdxaybc
         zEOaUqBo3z1pxOD7UjSwrfHr2ssz3GZB7J9kVSivWOrx1jS0oKcAlA+6FW275AyomqHB
         ROXHv0p7kFqcF4ZOmxJ4+DqPyjBLxobB5+nTSZKgEl0DJY4KQDK/6bYdf6HLt7IkOhKj
         8W5thKjF5XY+yxQJw8NQlnshoBqzGQAOwjtyTKqt/DeSE1iQ73MUJEDxzX7OJQcMjd70
         xbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OtPzacZEjWNwoQSECuh/B3fJGeYirN/gaWA0giiF204=;
        b=ICVjjGLvhjieOsQeadszkXTTz3YQb3QbuGsCpw2r90Z8KPl0pCYjV9k2aLlgWKVNl5
         oviS7bHpytvLa3UlSnYtpCv9lNbpYd2POxHF4ww4LPQ1lBUJXXjuBshRcdbZxyceYRJW
         zwZS7mKpdng25Id78LFlFQ2z1p3ha5gLvM4y1nyyw0742cGPAP+Zk9RXjgYE5c5XH15F
         xazfXUuV9w/Tkh1HBSkh9fRH08qqx+c+gGL42oQ0fYneYm/UnUuzVorc8/bZhavzZGrn
         AlXBdUPDbRUdQoV7QknotoLd4AxxJZ1ksG7gCQs+pj/0Yw7NzkiWK+rNH1LENqorgKlr
         /ywA==
X-Gm-Message-State: APjAAAXuKmshN3IAoW8B7QzXjDZydboCDHrJaBosr1ZMrcKpV4ys1tf2
        LJ0Y8ZziWIlJiWnDio1/j5ZcoDOj
X-Google-Smtp-Source: APXvYqyjdwfAez5Mwk1H0xDb2ulVHFBXLxrLgTgOXA16ZwjDbgb4HhGHsZeLo17pZu7hi6EYgbg67g==
X-Received: by 2002:a17:906:90da:: with SMTP id v26mr8402893ejw.146.1551972574324;
        Thu, 07 Mar 2019 07:29:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm941151ejf.25.2019.03.07.07.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 07:29:33 -0800 (PST)
Date:   Thu, 07 Mar 2019 07:29:33 -0800 (PST)
X-Google-Original-Date: Thu, 07 Mar 2019 15:29:31 GMT
Message-Id: <7b5cca61dea4f01f9bcdcb6d5d2a913d58a341d3.1551972571.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.159.git.gitgitgadget@gmail.com>
References: <pull.159.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] built-in stash: handle :(glob) pathspecs again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When passing a list of pathspecs to, say, `git add`, we need to be
careful to use the original form, not the parsed form of the pathspecs.

This makes a difference e.g. when calling

	git stash -- ':(glob)**/*.txt'

where the original form includes the `:(glob)` prefix while the parsed
form does not.

However, in the built-in `git stash`, we passed the parsed (i.e.
incorrect) form, and `git add` would fail with the error message:

	fatal: pathspec '**/*.txt' did not match any files

at the stage where `git stash` drops the changes from the worktree, even
if `refs/stash` has been actually updated successfully.

This fixes https://github.com/git-for-windows/git/issues/2037

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c                    | 5 +++--
 t/t3905-stash-include-untracked.sh | 6 ++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1bfa24030c..2f29d037c8 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -830,7 +830,7 @@ static void add_pathspecs(struct argv_array *args,
 	int i;
 
 	for (i = 0; i < ps.nr; i++)
-		argv_array_push(args, ps.items[i].match);
+		argv_array_push(args, ps.items[i].original);
 }
 
 /*
@@ -1466,7 +1466,8 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 				     git_stash_push_usage,
 				     0);
 
-	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
+	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
+		       prefix, argv);
 	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
 			     include_untracked);
 }
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index cc1c8a7bb2..29ca76f2fb 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -283,4 +283,10 @@ test_expect_success 'stash -u -- <non-existant> shows no changes when there are
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'stash -u with globs' '
+	>untracked.txt &&
+	git stash -u -- ":(glob)**/*.txt" &&
+	test_path_is_missing untracked.txt
+'
+
 test_done
-- 
gitgitgadget
