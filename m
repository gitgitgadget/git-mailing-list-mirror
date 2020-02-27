Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68877C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 20:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BE62468F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 20:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq9fG8w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgB0UWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:22:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37445 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0UWg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 15:22:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id t7so605962edr.4
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 12:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=eR9SAiaX/BcNU8ovsQ607PLyuPpTZXlwxAUZ/LHRhyA=;
        b=Iq9fG8w1flTHAxf1rR0ZiHyQY/8mMZTBMiNTg/RfJP/CquF29DwwOtFIEVggluSlml
         qOhFZT9i7GogaCT8bWsuXD23jDAdKwyjMTXwAgZz7bXFO5AxLTiotxujNG6F2yo5nlgV
         SJn3ydFYwEagAGSzIuTziwRRAVSxAus/bysTlAWljvEIGXeA7m53yIJKTW2xpUxBQsQg
         aIM43ewFpVA3pdJber5p7/0nhClK0TRKVObMaUsG4+d+2y9yBsHCB3zCOjzfgY99Jaey
         rlZi5Vk3Qpjme037GIkD5gpe1THbWlrjnEKXcL4094ymqERGE2K0v7Teqj/RGcUmEaDm
         Mqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eR9SAiaX/BcNU8ovsQ607PLyuPpTZXlwxAUZ/LHRhyA=;
        b=oSXU8HTV+Sr9KVbkhAJtkNCuxWswpyNSJsvrmt0poe51ImUMTzHhK3zQHur7bDnrcd
         vu6mVmN+j58P8taS0e08XAmo+xqq0/NEXzR9C/+AZ12PypPPM2LPcpPMf9DEodUu7U6e
         nx725tTzUSXlxSc5aljwDXe97Jh1weYreQoaVfCzJ0BOoMcpWebcOR7eFb/ow+4AoF/0
         LRCtlVpSryWnDcLR0BWYwhMh95F2sA3o+VKwPjPH4FPomPMiNLp3Jxz0DKQbzvkV4ZpP
         aXp1746tEWmIUDE2chmZ/pNh5zt2OHvdZBNUHfM8LmCwwlsitNCS1yrqfFSxcxn3/Wb4
         In4w==
X-Gm-Message-State: APjAAAWhtk8LxQSsFgF2nQHEeQtjO0YrIq1s1DdDkxVswSJl5U9x0H7c
        cs39RFrzja1qkhmcjwTK50D4CurU
X-Google-Smtp-Source: APXvYqw+MzpK1EThyV0a9FUS/YyxF2PkyjNAw3sZ0zvAnD32NEd3jCHjm7y2KEAnRctaoloAQPhKDA==
X-Received: by 2002:a05:6402:1d28:: with SMTP id dh8mr244019edb.383.1582834952887;
        Thu, 27 Feb 2020 12:22:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16sm434117edt.8.2020.02.27.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 12:22:32 -0800 (PST)
Message-Id: <pull.717.git.git.1582834951742.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 20:22:31 +0000
Subject: [PATCH] t5537: adjust test_oid label
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We recently switched to using Perl instead of `sed` in the httpd-based
tests. Let's reflect that in the label we give the corresponding commit
hashes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Follow-up for "ci: upgrade to the latest Azure Pipelines agent pools"
    
    This is a companion patch for https://github.com/git/git/pull/714,
    adding a patch that would not apply to maint but applies to master. It
    is intended to be applied on top of the merge that pulls in the agent
    pool upgrade (which in turn is intended to be applied on top of maint).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-717%2Fdscho%2Fazure-pipelines-latest-pools-test_oid-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-717/dscho/azure-pipelines-latest-pools-test_oid-v1
Pull-Request: https://github.com/git/git/pull/717

 t/t5537-fetch-shallow.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 4f10057e9f1..4f681dbbe11 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -17,8 +17,8 @@ test_expect_success 'setup' '
 	commit 4 &&
 	git config --global transfer.fsckObjects true &&
 	test_oid_cache <<-EOF
-	sed sha1:s/0034shallow %s/0036unshallow %s/
-	sed sha256:s/004cshallow %s/004eunshallow %s/
+	perl sha1:s/0034shallow %s/0036unshallow %s/
+	perl sha256:s/004cshallow %s/004eunshallow %s/
 	EOF
 '
 
@@ -243,7 +243,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	# with an empty packfile. This is done by refetching with a shorter
 	# depth (to ensure that the packfile is empty), and overwriting the
 	# shallow line in the response with the unshallow line we want.
-	printf "$(test_oid sed)" \
+	printf "$(test_oid perl)" \
 	       "$(git -C "$REPO" rev-parse HEAD)" \
 	       "$(git -C "$REPO" rev-parse HEAD^)" \
 	       >"$HTTPD_ROOT_PATH/one-time-perl" &&

base-commit: 4ee93512ad4f5270d941006faa162586e2d45f7a
-- 
gitgitgadget
