Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CD6C2D0D4
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956A5206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLV25kNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLUWmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:42:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37880 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfLUWmK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:42:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so12071563edb.4
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4cuuYCdN4/fosmUNkvRvDGtVDvhAgt1WB2ENylRXtIM=;
        b=MLV25kNCylZyb4dOTXgYvpp3C93obvz6twIeyhUvUilI1Ug7+PhC+D65HwIp+7byOX
         nRGoMAmQ4P6LKzMoC1u5jouCm7YxCvvRp8v30nReJfZHzF+58IWna31thPiK/cpupyQ1
         ctYmWlHVNSq1jndTukCqwqH9pIR373Aq74TfXGu3tL5hzw4x7z8AKcvRkvrAX3oTL5gR
         sK1Nrb4mZXjLlHVZ4qOmelqKg2nL0z71ZSCwiThd6sNSkgQMmaK3OHXsq12Vlf5omCCT
         3njxx2ckd0gYI87DLI8TPITBlWuLCsQMnxlYmK0bbcqJR5KNztO4A0Y3QruWyoj+aeX5
         ncow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4cuuYCdN4/fosmUNkvRvDGtVDvhAgt1WB2ENylRXtIM=;
        b=WVUopUdnWcaKZyEj+MNr3z+VY2st7s+Hs3yvsAMl/w/3FDi2/DFNk7b5DiK3UFMv1q
         8l8Nv71hAw9vCvsbuRX5OAhJiTcC7uPRhgGbxiLfLpreG2flsvtNCr6DJ5y3P6rr3vlx
         OhODTwY+CaR9PGCKdUaTPkBTJ0iyk9UDZMS1Sy5LUnemX0EKyeMjUKNS8LR/vS9UFyMC
         W73njnc0v6FRrC3C6h/qlzPbkKVXhWspS4vcxsCy/9uDV5Ob112qbhhJ+qdqhTdw63G2
         YPnrA2ZOkeeoJKwHtAaKRrzEr482eI3OKsGzTnuX7PO/ZbYngDyBYVIYAQQdWG+nO7x9
         wGEw==
X-Gm-Message-State: APjAAAW/2ig69trZNmtbMeUsEoSDIaIOONIrNO/CDWOT4gu27iowESxy
        //cScnMxZ/S+tw85V6fY9bWeGT+9
X-Google-Smtp-Source: APXvYqxRij/ejUVd3N15/FDeq2l5bCb9ee7U5IzPZEXYDVkG4RKk4fgxjoZOzzP1lrXiEOcad44tYw==
X-Received: by 2002:a50:fb96:: with SMTP id e22mr24353740edq.18.1576968128594;
        Sat, 21 Dec 2019 14:42:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm1639206ejp.50.2019.12.21.14.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:42:08 -0800 (PST)
Message-Id: <9719604a1fb6ec4cf1b1297875cae86c076c9cdd.1576968120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:42:00 +0000
Subject: [PATCH 9/9] ci: include the built-in `git add -i` in the `linux-gcc`
 job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This job runs the test suite twice, once in regular mode, and once with
a whole slew of `GIT_TEST_*` variables set.

Now that the built-in version of `git add --interactive` is
feature-complete, let's also throw `GIT_TEST_MULTI_PACK_INDEX` into that
fray.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index ff0ef7f08e..4df54c4efe 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -20,6 +20,7 @@ linux-gcc)
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
+	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	make test
 	;;
 linux-gcc-4.8)
-- 
gitgitgadget
