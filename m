Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B46C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiCYTnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiCYTnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:43:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0E3ED607
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:17:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pv16so17293556ejb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ytZGPKQBsgePTFk8nBNZCqEs9yPPwA8MYf3sa3pnTvQ=;
        b=XNQYwPODTukke8vD75zE8tb9Z8KnTEMgVs30Tm+KW6n6TbjDPo8C46Kn6D+bQeLPpb
         oeN3llg1IjQYNbATrIpx5o10tudQAmGNs3+rvdIU9CDbtsd+ytbZkr3sd/RXdLQCQo1L
         kwzKYzUKj5HF1A39osDdbKRQkvuMWrmkE2Z9gf5c7jpoOC6EtRTECDyz1rsifmVhzj7K
         aPzUW8CLxxHsj/wH3nP8eGoIFjjYKXQX1boxS1B8ZdR0wR8qj4KhIxpFXfkWtOA3oPtY
         H4086OQ4YBdCRFhGU29Ey3oBrJqZ0B0Fk4wA3fKmxWC0viap9olhJtemxR6YqXAoRlEP
         TYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ytZGPKQBsgePTFk8nBNZCqEs9yPPwA8MYf3sa3pnTvQ=;
        b=xICaMcbXu+rWj1CGQwM2IrV/Ci0WPKdqvzXzrJ1LCF2W5zSn6MetI2AdqFnxDARZp3
         VVm6GbfLIats8WkA7+SizIpUaBOcihwTPDxf4j5BifG1rfBLXwtaFPgm+PN+QCVSYnw5
         i9/1bQt0/1vzNziTITUBiDfxaqPSLaviuWvFt5QX5kdk8GIUBVLZ7fWFweNSJt1Oj+/0
         b72LJW4hPjcejpdZTGXDMUmgAZ7PIlfel1RtQsmxlkS8QCZa5IjQwZCC5suDfoAqKcxL
         5GSCccWQ1BLuTraUyDSBm1+ITXx14wK2iu4ddZ7WU4ANPj6bE06cqzqo0iS8iM/cHCj2
         8BRQ==
X-Gm-Message-State: AOAM532eeyQBPjW/3MdWCvz1sYVwgoJJydTFo1tpzpFhTOwgLHkpNHER
        DIsLIw+4AYIXhMTmgUDJY3tEyMHhP6U=
X-Google-Smtp-Source: ABdhPJwRY6tmTkoIBhvHLMTPCX4GuSlZa3gTyOrDlF1oJf8AODSOnZvnZPAK5V5yXYaCgx5L/qYjJQ==
X-Received: by 2002:adf:9581:0:b0:1ed:c341:4ed1 with SMTP id p1-20020adf9581000000b001edc3414ed1mr9846738wrp.299.1648231420242;
        Fri, 25 Mar 2022 11:03:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm5727942wrf.80.2022.03.25.11.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:39 -0700 (PDT)
Message-Id: <2dd021512781a25ca3b6bc0c4d035b4fd4fc0456.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:03:06 +0000
Subject: [PATCH v9 23/30] t/helper/test-chmtime: skip directories on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

