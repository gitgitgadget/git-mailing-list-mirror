Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EFBC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2BA61050
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhKBPtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbhKBPs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:48:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668CC06120E
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:46:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v127so15931249wme.5
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MfWB6/O/XDWVBgnDBb7J+s3FjcbAOYL7y65rKAWAVTU=;
        b=TXR0arSRK9aFg4J8cTZcYaDYF3SjhQdYInT0tFQKqHGHGPtuM4dp6xQeyn7BLpwvfW
         Z7ydksBYaOUyWl6zV/Clue19opfeKHRbwX/WglcpZj2H5YHFvYCADAPq3yNMkJ66fAcM
         5gOP62gJUQEqNuYr3QqTknpH7v4ZLcepBQhFKvdPoDbm+QRTJuWdx+1dxW9dcHkZbSeZ
         hlPaPUR34Dnmtef//EUl2G8w+OGpjKglx0aXLOG9MSFhYv+N8T8LbajeBDbBckRTBgN1
         fcQd1ADeXitlc/lb8LqwXpIHArUr7yR9ThLliQR4e4EGCTu1wD6EFRW4+xpbithKI7A9
         +Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MfWB6/O/XDWVBgnDBb7J+s3FjcbAOYL7y65rKAWAVTU=;
        b=iUNy2WviAwv1PeLf1+i/ao4+JT1Anywjb4j+BtOVoRYtNIelRtLSWjbnVCnhBApenv
         0ZbXvq7IwZ+rZcYD3dul2VmZnW28EhFAHgnjJl60i1JZpPH3UOSv+a3msAevwqu4gMdX
         Cjv/PZwdJH4i//iVY/NJkfIYCpdbPNpuPKn0SqnDEYUuz+6pFr+yUgEgQhV5wI1Y02Y8
         VuAUTINYdh8pg11c04NX2sp0qHyr45fog46ZgJoULyyJlwAVVE0tl98YkealKjbg54f2
         MLyVPx29Nl94Pqo4hnGMw64vCMkiOau5OyPAOjGWC/Pw8YUrB8PyzOZK9Oe7/+2oeKcG
         b+ig==
X-Gm-Message-State: AOAM5334mCKP39cFK78CSyQhWx2+Gcp7BU1/cRGBFniUAqwnhPcFgGGV
        LZwU4uotRiSrL/oAN3dG30X0OKBK1Hs=
X-Google-Smtp-Source: ABdhPJwpV+R7wna4pZgBvMg2t4IS6UBlNerU4s9yv4fqn8vDgryAPBo1sV5QZyB8CtKqPIu1SrmNEg==
X-Received: by 2002:a1c:a904:: with SMTP id s4mr7738903wme.163.1635867979175;
        Tue, 02 Nov 2021 08:46:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3sm17993076wrg.23.2021.11.02.08.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:46:18 -0700 (PDT)
Message-Id: <41fda423982d99847d3879f5ea1eb3570ae9eab6.1635867971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 15:46:11 +0000
Subject: [PATCH v4 8/8] clean/smudge: allow clean filters to process extremely
 large files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

The filter system allows for alterations to file contents when they're
moved between the database and the worktree. We already made sure that
it is possible for smudge filters to produce contents that are larger
than `unsigned long` can represent (which matters on systems where
`unsigned long` is narrower than `size_t`, most notably 64-bit Windows).
Now we make sure that clean filters can _consume_ contents that are
larger than that.

Note that this commit only allows clean filters' _input_ to be larger
than can be represented by `unsigned long`.

This change makes only a very minute dent into the much larger project
to teach Git to use `size_t` instead of `unsigned long` wherever
appropriate.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 convert.c                   |  2 +-
 t/t1051-large-conversion.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index fd9c84b0257..5ad6dfc08a0 100644
--- a/convert.c
+++ b/convert.c
@@ -613,7 +613,7 @@ static int crlf_to_worktree(const char *src, size_t len, struct strbuf *buf,
 
 struct filter_params {
 	const char *src;
-	unsigned long size;
+	size_t size;
 	int fd;
 	const char *cmd;
 	const char *path;
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index e6d52f98b15..042b0e44292 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -98,4 +98,15 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 	test "$size" -eq $((5 * 1024 * 1024 * 1024 + $small_size))
 '
 
+# This clean filter writes down the size of input it receives. By checking against
+# the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+		'files over 4GB convert on input' '
+	test-tool genzeros $((5*1024*1024*1024)) >big &&
+	test_config filter.checklarge.clean "wc -c >big.size" &&
+	echo "big filter=checklarge" >.gitattributes &&
+	git add big &&
+	test $(test_file_size big) -eq $(cat big.size)
+'
+
 test_done
-- 
gitgitgadget
