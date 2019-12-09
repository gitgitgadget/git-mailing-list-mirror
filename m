Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2902C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759BE206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FexKu1kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLIUrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:47:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56019 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIUrv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:47:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so801720wmj.5
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 12:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IM8NXGxG48ELrMvEtU27DdAjZm+S48DBs3jTcX5uhok=;
        b=FexKu1kh5EOWKCtFetoafPI9P3zmdigVvkBPykfF0x5bv8DKkJYnZX9psE2PLZ2yv+
         +7f2Zt7Not7N6W2NCVYRPAx1ZFm6+IftIHNihkFAIuMV4v1jZ9lfPIy0JqbDwXEDNKF/
         p8V0K/NR4E3gJOWdYtYSYeXjmAkZYHLrOSMl/m3kip37lQ+RquHD98uWybHD/nqz22Qj
         sILo8EARj4Sp5h7rNW1LApIGo1hHMHb8/3nZnNAnDG1ut1Vs4fe4NuJi9Fh/XnqegXTS
         AVrdeZ4If5b3opevNY5yIkuRfdX+OrqET/KQg+pncIoZ8k3i47dWUYK5XgEI0MYiNDIO
         HPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IM8NXGxG48ELrMvEtU27DdAjZm+S48DBs3jTcX5uhok=;
        b=m9xjz3iFUs2Jud+idMzD1HUvI8eHGIpK3izJO9B1uInLYtrNAUq1JgQdcKFJSXKElQ
         Uf1LgcC+JdusgrT1bxrfTWjmumPUOtKzfRs6Hh3Sxf+yl4ZlwY7ZlJrM8yDAE593WNag
         JLXepVQ+Aggx2dLARHnzE48kqBdzr/kJT3YW21L1euPlgMvsk2qP5rBlEzgNIetkzAds
         ODi9In54PYokx5sHhlnIClWgKdUQeRbwhu08IAt5W5VR60W3khI82THKkvwpL5lpRlCd
         lQ/LoUneRvtTieClCyRfPsZNREdY0FfBnCgUBTFhyUBMVy7CdCJnq78c9BzjKe5CLxyz
         U2kw==
X-Gm-Message-State: APjAAAUimGh54uTyp7e+MLsaftrDHwvGBcN/kzpnRxxbiC+5CBrHFj25
        Cii27UzXdUHXMwZVtR3TNp7rrFsg
X-Google-Smtp-Source: APXvYqwJsAnjDksU8IE5hXpyu7PgwI1kSIvUyrYxxrSkuze69GNPQh/gABS03zLRVYkcuD+4wjfTXw==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr966609wmm.143.1575924469810;
        Mon, 09 Dec 2019 12:47:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm745901wrw.12.2019.12.09.12.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:47:49 -0800 (PST)
Message-Id: <c3220758ab2393ea07f403de04951e32404408b2.1575924465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 20:47:41 +0000
Subject: [PATCH 4/8] dir: exit before wildcard fall-through if there is no
 wildcard
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The DO_MATCH_LEADING_PATHSPEC had a fall-through case for if there was a
wildcard, noting that we don't yet have enough information to determine
if a further paths under the current directory might match due to the
presence of wildcards.  But if we have no wildcards in our pathspec,
then we shouldn't get to that fall-through case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                                              | 7 +++++++
 t/t3011-common-prefixes-and-directory-traversal.sh | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 5dacacd469..517a569e10 100644
--- a/dir.c
+++ b/dir.c
@@ -379,6 +379,13 @@ static int match_pathspec_item(const struct index_state *istate,
 			       item->nowildcard_len - prefix))
 			return 0;
 
+		/*
+		 * name has no wildcard, and it didn't match as a leading
+		 * pathspec so return.
+		 */
+		if (item->nowildcard_len == item->len)
+			return 0;
+
 		/*
 		 * Here is where we would perform a wildmatch to check if
 		 * "name" can be matched as a directory (or a prefix) against
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 773d6038d1..d4c06fcd76 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -90,7 +90,7 @@ test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
+test_expect_success 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
 	echo untracked_dir/empty >expect &&
 	echo untracked_repo/ >>expect &&
 	git ls-files -o untracked_dir untracked_repo >actual &&
@@ -104,7 +104,7 @@ test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses int
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
+test_expect_success 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
 	echo untracked_dir/ >expect &&
 	echo untracked_repo/ >>expect &&
 	git ls-files -o --directory untracked_dir untracked_repo >actual &&
-- 
gitgitgadget

