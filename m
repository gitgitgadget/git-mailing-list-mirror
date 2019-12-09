Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF118C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD8220692
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0dsVUyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLIQKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:10:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43393 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfLIQKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:10:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so16796046wre.10
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8+b2TZljW1nJNaPhxqNuAwAOAmDbaiK/LSojADStCD4=;
        b=J0dsVUyg2jghFV47cbkisqZjesum7lz3z+SwUssLqYbydlVDwbQCxf4cv/RJGYKDkB
         5bKpSypw48pbZLzHNuvpDWjAPYDoAWjCpQNVbgutADaNnhh8Syl+ahTBSVndmxYD00fM
         DsbCiaTxnwSP8i5r2kI8SjHk9kaktVCV9CjzC4hFcogzlYEOgSul9eXO6NSbAZhYLzrb
         lbT55+bm6MYymWdZVu8o6aZrdwJOs/ICxJx3qOtI/XbTgNcW42n11Qjl91EVcoEi5iog
         yLqL8udSJc4XpCJk57e1RnXTNVdwY2a51fhve8KuteUslY6aMDA6XVedAhEbEunhYwYz
         18NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8+b2TZljW1nJNaPhxqNuAwAOAmDbaiK/LSojADStCD4=;
        b=XrI3LUTwZEB8V5T25U7SNcjPbW4cp3mCcBhpw3AK4qtt4QS/5dbzBKWM8oibc4+BIH
         G8p6FJaaoyrvC/UmKjv4giYZgZmMKHHLjB55NhQr3/XlDf27ycjav4S55+ZIoMTfzDYp
         y+H5LERlERUtsSp0yKZtCkHmoVP/oJNBrC/ReTGbzfwYw7vauVdmb3WLrXDCIxEYSy8+
         9Hv7ciwG0uBLhDikUPK7aCpJNSIpnusJxl8U0WCNXIVZV6vFXYiHms1gy6qUa48Wucmj
         apxr1rd9VvxHLPDZF7zQfiNhWuit61AsS+LnJDNVpsnAmzxNpHCOEFvRljxpb29FnF1y
         ik6Q==
X-Gm-Message-State: APjAAAWUNMIeJi1Yx7eEEiWEz0YZtrF0uvOMteGCfOJY3s9YMDgeifrP
        MJwJKFqSJ0gKBJsOsaTrRSCEH0IO
X-Google-Smtp-Source: APXvYqx6FGi66ZbKmgf5P0V/5QDAU1MTRQFazJJYhA0XaSgPO1xB77fk9qhgty+hmKc7yVkkp994ZA==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr1538070wrm.248.1575907810606;
        Mon, 09 Dec 2019 08:10:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o189sm223724wme.29.2019.12.09.08.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:10:09 -0800 (PST)
Message-Id: <9cd4a08d82521082f0ee13ebea353708fada3403.1575907804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 16:10:02 +0000
Subject: [PATCH v2 6/8] t7063: disable fsmonitor with status cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The fsmonitor feature allows an external tool such as watchman to
monitor the working directory. The direct test
t7619-status-fsmonitor.sh provides some coverage, but it would be
better to run the entire test suite with watchman enabled. This
would provide more confidence that the feature is working as
intended.

The status cache tests use GIT_TRACE_UNTRACKED_STATS to check very
detailed statistics related to how much Git actually checked for
untracked files. The fsmonitor feature changes the expected behavior
here, so disable the GIT_TEST_FSMONITOR environment variable.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7063-status-untracked-cache.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf..c433738a3a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -4,6 +4,9 @@ test_description='test untracked cache'
 
 . ./test-lib.sh
 
+# fsmonitor changes the expected behvaior of GIT_TRACE_UNTRACKED_STATS
+GIT_TEST_FSMONITOR=""
+
 # On some filesystems (e.g. FreeBSD's ext2 and ufs) directory mtime
 # is updated lazily after contents in the directory changes, which
 # forces the untracked cache code to take the slow path.  A test
-- 
gitgitgadget

