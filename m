Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D0C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 21:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596A220848
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 21:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjrkwBMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBMVvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:51:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38931 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMVvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 16:51:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so8574589wrt.6
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 13:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KPz44w6ofExe7OrNu5xWGlZ+Wluf9RmfY3HpochVutk=;
        b=IjrkwBMY+EzgtDW8lz1Chy8pyv/SI0KuRhYbcgdnxPQQL5XPv9wFFny2uG/bCjdkE1
         0VtdEpz8CbQNNrZgKzlOZa8zHmygbQQxFsdIOnuZQVCybl0tsKSmTKFGzsZeyQQxGgnr
         Z4kxqtDdbqwAW5JkIlCSPFWoGW4RwIM1MFdgespzLLObym+ezFxVYY9C+VL17ku+Eduw
         2WveqFFz2XItkxIV5x0jDxpMrBQzn8DSfZ+JlHHB93Smyy93hHoHgMZ+uUHj1yXI6u9q
         fiS2sXsm0J/ymeq5NapGo43toUj+/cAxqxEKHUtqlVLVeZNNh2Nf22DWIO03wdoSoEdX
         E/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KPz44w6ofExe7OrNu5xWGlZ+Wluf9RmfY3HpochVutk=;
        b=lbot/p32tk/2OFSl1ZVq3l0UK2cnccELQfYf0nAIRO2m+iEZOcmFE+LHJ4rbkK1VMQ
         R+AwLyhpF014oLk9bkTvBl+5kULvkju+8i47jkqTYVrXB7Qr7nIUSwiZnhDqcIUaK2sl
         hSyFPJdOpoRFnokKOxpaD0srtyC/qlqvXGjh+Z3jP26vHi8YsgzEURixCxv1MFfMJb9v
         m1QqEjLOrhFjZyPzsC3U3LZIzqXNAwiF56SosfBhKGRILZPcpob7UChcncVkLQmmNP/m
         A0jd5cliLeHJgjg/O6rYqeBnK090MVUuyQjhXgy6ZIWtnEvVtk6dWaCGBgvBRTxbt2Ls
         iapw==
X-Gm-Message-State: APjAAAU2bxxFEixgTmXt/DtwXicPZroByte+MwVcK4hMFqBlXI9QMohQ
        tdAAWbNrVZS2m5BofIkDYbrqZvPo
X-Google-Smtp-Source: APXvYqwAv9ZC8y4udUVRB680tQ2KjO7YSk1If+KYaDgJeP7GEs8gPQElpxENxRXAK0V0qMVksSmESA==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr23273978wrm.248.1581630705468;
        Thu, 13 Feb 2020 13:51:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm4574606wrx.89.2020.02.13.13.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 13:51:45 -0800 (PST)
Message-Id: <pull.143.git.1581630704704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Feb 2020 21:51:44 +0000
Subject: [PATCH] t5580: test cloning without file://, test fetching via UNC
 paths
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

On Windows, it is quite common to work with network drives. The format
of the paths to network drives (or "network shares", or UNC paths) is:

	\\<server>\<share>\...

We already have a couple regression tests revolving around those types
of paths, but we missed cloning and fetching from UNC paths without
leading `file://` (and with backslashes instead of forward slashes).
This lil' patch closes that gap.

It gets a bit silly to add the commands to the name of the test script,
so let's just rename it while we're testing more UNC stuff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Add more regression tests around fetching/cloning from UNC paths
    
    On Windows, we want to make sure that we can fetch and clone from
    network drives. Let's add regression tests to make sure about that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-143%2Fdscho%2Ftest-unc-fetch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-143/dscho/test-unc-fetch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/143

 t/{t5580-clone-push-unc.sh => t5580-unc-paths.sh} | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 rename t/{t5580-clone-push-unc.sh => t5580-unc-paths.sh} (89%)

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-unc-paths.sh
similarity index 89%
rename from t/t5580-clone-push-unc.sh
rename to t/t5580-unc-paths.sh
index 01b52c195a..cf768b3a27 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-unc-paths.sh
@@ -40,11 +40,23 @@ test_expect_success clone '
 	git clone "file://$UNCPATH" clone
 '
 
+test_expect_success 'clone without file://' '
+	git clone "$UNCPATH" clone-without-file
+'
+
 test_expect_success 'clone with backslashed path' '
 	BACKSLASHED="$(echo "$UNCPATH" | tr / \\\\)" &&
 	git clone "$BACKSLASHED" backslashed
 '
 
+test_expect_success fetch '
+	git init to-fetch &&
+	(
+		cd to-fetch &&
+		git fetch "$UNCPATH" master
+	)
+'
+
 test_expect_success push '
 	(
 		cd clone &&

base-commit: d8437c57fa0752716dde2d3747e7c22bf7ce2e41
-- 
gitgitgadget
