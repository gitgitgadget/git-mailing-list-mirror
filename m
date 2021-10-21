Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93148C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C66121E
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhJUO2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhJUO1n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6399EC061220
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i12so1386508wrb.7
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h+Ll16drRrZ0MQ3JZUEyAlGPlME6mRvqakNQhG3XdjE=;
        b=S7zbLCMdLQs9DTlaYOvR5bXG3AGZ4Q9vY25D24EZ8Lmj+Exo/XiMxot0/8fgj6iCTi
         qEfsdE/uV3Ja/Emoi3GecCnN3PCZRvlulbxEVZs41cQRk5cnZIbKSvlSdbfyeTOWuYOc
         SnhYeHUtNO2jJC9k6KOMWU75pubdT9R2Qj6rxxa1bzGR/X4iOYCzQqpZPQvE9NVEyGxi
         zwcYHUwG7z01M4k7WESh92PsYpKRTDhOi56IynqsbjNS+FCLRi1K921po34cs9xQfLWy
         qdUG8ZyYosBvDcD0/cdgTSjqgXWquzxwsiDLzBIJ7/EjdDMHyTmfW4O1jzMXNiW6tLy3
         yYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h+Ll16drRrZ0MQ3JZUEyAlGPlME6mRvqakNQhG3XdjE=;
        b=ff9he5gCbGdqtr1ufSlhfPyfUwy58eXwf+z70Pe8I26MXFoTQ3iN8ZmmdWHOnhkIll
         i7CEioKuwPJGPg3Sss7+QxoMEcMy34OCtGgH8/uWWUsb83Lm5kPekcOlOVYAwl2ETRet
         Y4yl7osdseC5SS30hlWFbDUgw7gqnsqMMmmHfgjQ4IfwxZr8ZOgBBAlOrpcPGn4oYYiz
         IMs4180VyX/pa+zSZipIPc3NSX0QEvfoiIUtlWrmCi8Kk8sEfSR5ATOTtjX5Zmt/ZPkF
         N4FGWRhafjZsSZthMC/1rs7jVLsT6CjGb1mjWymqPKxeOh0LrJMGCsYAnk2LUL/TPRVv
         3CPQ==
X-Gm-Message-State: AOAM532LjRXZT1l/e6qYCc44yOPE3EJtYkapkJBQ08rAKVMhvPRpmhpw
        UDmmMP4mYRqPTkfVw1EPX7rnn+7dbfI=
X-Google-Smtp-Source: ABdhPJyvqd+liGun6OTlGi7WI2h+o7/DSlp56t5sLKFl8VjIFQOf+dYm3aayrgwgNUTCPM+gXgqpPA==
X-Received: by 2002:a05:6000:188e:: with SMTP id a14mr7406699wri.223.1634826325026;
        Thu, 21 Oct 2021 07:25:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm4914159wrr.35.2021.10.21.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:24 -0700 (PDT)
Message-Id: <de9c015d78c3ad87e84a1d424ebeacaf2491d1db.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:25:03 +0000
Subject: [PATCH v4 23/29] t/helper/test-chmtime: skip directories on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach `test-tool.exe chmtime` to ignore errors when setting the mtime
on a directory on Windows.

NEEDSWORK: The Windows version of `utime()` (aka `mingw_utime()`) does
not properly handle directories because it uses `_wopen()`.  It should
be converted to using `CreateFileW()` and backup semantics at a minimum.
Since I'm already in the middle of a large patch series, I did not want
to destabilize other callers of `utime()` right now.  The problem has
only been observed in the t/perf/p7519 test when the test repo contains
an empty directory on disk.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/helper/test-chmtime.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index 524b55ca496..dc28890a183 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -134,6 +134,21 @@ int cmd__chmtime(int argc, const char **argv)
 		}
 
 		if (utb.modtime != sb.st_mtime && utime(argv[i], &utb) < 0) {
+#ifdef GIT_WINDOWS_NATIVE
+			if (S_ISDIR(sb.st_mode)) {
+				/*
+				 * NEEDSWORK: The Windows version of `utime()`
+				 * (aka `mingw_utime()`) does not correctly
+				 * handle directory arguments, since it uses
+				 * `_wopen()`.  Ignore it for now since this
+				 * is just a test.
+				 */
+				fprintf(stderr,
+					("Failed to modify time on directory %s. "
+					 "Skipping\n"), argv[i]);
+				continue;
+			}
+#endif
 			fprintf(stderr, "Failed to modify time on %s: %s\n",
 			        argv[i], strerror(errno));
 			return 1;
-- 
gitgitgadget

