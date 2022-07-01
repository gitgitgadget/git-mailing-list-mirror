Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A14C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 16:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiGAQYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiGAQYK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 12:24:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9D403D0
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 09:24:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k22so3943926wrd.6
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=C/Ty6AO7tEaVabgw5dm0Ep2FwRW6QV98p22KFYMYbPg=;
        b=LZMElswIUpaEw4KPFYkWeHYmKgnNUIxlIMe1zmpXUOX6DG21BwqntbKfkc/oMgSFQf
         iegvoPfHErqAGKNVvxqydIY4aV8ELG/9h4oJYFQQGoP+x9soFKiDMDPTOcV4we+dts54
         7ocWHjwaT7GJLPhjPC3j2ICc+9oxXHTX/DeCSZmGBqQ0SwLQdvIq2Yf4/awNL+OkLfRM
         GVGP5Y+DFaQYX3mCVK0Rh4YRDBW7+57Y9Q0OrQ2qRV8z3kvwI7pHkV0rxZPQCJiknpJS
         NQanIAmDoXGPBpOJFQr+LDTQbpAt64wvvv/UA9TX1I1enRj1uL4Axm8Xqb1RYXOPiLp4
         NjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C/Ty6AO7tEaVabgw5dm0Ep2FwRW6QV98p22KFYMYbPg=;
        b=DwZHMlK9EFJ2IgDf4c+r1NMlzwtob2U2wCFH07eRZ8nyl0UEX++CwNaPU2cLq+DcMf
         I6XXvb+/FbpKlDaYmQpwoJKXfh49ZteWr0rUTHsZy/ndZl2zutH6S6lUxALk4u7pezL3
         8tpfFOZCR5BWHCyWXqcoW5mW8V+CsKYllNeSXBSXMa7xQCcXc5qK4enCEE+HWMoVhaYD
         Upw4bjWc88ITZe8WvvOFU5CK4rC3531lte0c9rPS5yJeQoXgbz6C4j2sxWPCMuuHvM4K
         i+DROSaVpcDDcRf9PemxxGoIZiMFaHyD4aC45jaKFQ+lgme8SLmYJ2nr7wu6aK22ZK6C
         s8RA==
X-Gm-Message-State: AJIora+XuiPtwGP24Aj+7MA5P5GrUUQfAzLVX312RSBQTWwK4zBhIYUA
        CXZ5jSHQ8BArFXFbJtmP4ksnKvIFtUk=
X-Google-Smtp-Source: AGRyM1sgB+sWZZxqy4bd6oWgk8gIUU9nPmxuKMgv54hsrHiQ2q1YUCIhqVwHz4tfba0nWdb/37sdvA==
X-Received: by 2002:adf:e4c9:0:b0:21b:9336:16b9 with SMTP id v9-20020adfe4c9000000b0021b933616b9mr14806403wrm.696.1656692647429;
        Fri, 01 Jul 2022 09:24:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a05600c140300b0039c96b97359sm11030720wmi.37.2022.07.01.09.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:24:06 -0700 (PDT)
Message-Id: <pull.1277.git.1656692646303.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 16:24:06 +0000
Subject: [PATCH] http: support building on RHEL6
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There was a bug report attached to the copy of 511cfd3bffa (http: add
custom hostname to IP address resolutions, 2022-05-16) in the `git/git`
repository on GitHub, claiming that that commit broke the build on
RedHat Enterprise Linux 6. The most likely explanation is that the
available cURL version does not support the `CURLOPT_RESOLVE` feature.

Let's work around this by warning the user if they configure
`http.curloptResolve` if compiled against a too-old cURL version.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    http: support building on RHEL6
    
    This came in via the awkward venue of a commit comment at
    https://github.com/git/git/commit/511cfd3bffa685fda0e7c25bfa08082aa0de3a30#commitcomment-77360864.
    
    I looked here [https://curl.se/libcurl/c/CURLOPT_RESOLVE.html] to find
    out since when cURL supports CURLOPT_RESOLVE.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1277%2Fdscho%2Fcurlopt_resolve-in-rhel6-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1277/dscho/curlopt_resolve-in-rhel6-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1277

 git-curl-compat.h | 7 +++++++
 http.c            | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 56a83b6bbd8..80315e731d7 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,6 +28,13 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
+/**
+ ** CURLOPT_RESOLVE was added in 7.21.3, released in December 2010.
+ */
+#if LIBCURL_VERSION_NUM >= 0x071503
+#define GIT_CURL_HAVE_CURLOPT_RESOLVE 1
+#endif
+
 /**
  * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
  */
diff --git a/http.c b/http.c
index 168ca30c558..4c7a2311ec8 100644
--- a/http.c
+++ b/http.c
@@ -1228,7 +1228,12 @@ struct active_request_slot *get_active_slot(void)
 	if (curl_save_cookies)
 		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
+#ifdef GIT_CURL_HAVE_CURLOPT_RESOLVE
 	curl_easy_setopt(slot->curl, CURLOPT_RESOLVE, host_resolutions);
+#else
+	if (host_resolutions)
+		warning(_("lacking support for `http.curloptResolve`"));
+#endif
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
gitgitgadget
