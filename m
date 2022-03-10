Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1513C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343926AbiCJWod (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiCJWoc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:44:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA380240B5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso5184530wms.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SYP+Yn4mhTuFFgy93xPQfv8JKnrUaPWyCv8xZy29qmc=;
        b=njYVStTW40gs9X36MxwmLZW7k8mCH87PS791rfYi6RVadHnKGgiLIjRE1Bcilqqfmc
         yAJOzLFQIKsneI4qtS0LxgAdAPIRFoiEx+021haNGpLUUukfhaVaQtSgdIeH+koR8Hfv
         Qc187jpRiQBnsa07Y+ca+o6ISqYLncoNM2NJuvQIdZU5ih7vVvW4AlagI6BAjSll9hMc
         cAWTjDH1jVhxRSxetZ1XepweyYVHrRAuCSQblBxMjuXCENKot7PJYzQtEKSzknhKZgdh
         l1J5Es48LmMl9bno1XiRSz2vwFSVcdGncya9+IJIh9eqM93ysLZVw+7kOZ6p4Ai8A6a1
         MiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SYP+Yn4mhTuFFgy93xPQfv8JKnrUaPWyCv8xZy29qmc=;
        b=L9EtMesdev5UG3hytfQwwWltw3ISGV+KJg9mJ8G09Jy+adbg9vZatya3D5jT60fTcP
         x/pmswYSGYcvIv35L7PrKSUhpe5DvL1cHZDEauNJl/CuHJv8r38DjD85NTLFdTVQaLJo
         7gP4/iYfkXHVFITwyDj3xSetoTTVe0jS6DQbjkTtLJznR/lUlcbo17DJP0nGZLsIm5rY
         PEM/b1F6P9EUHMHdad2zZB0aUtqr+k7EJxaHL8w3j0+mbtAPNfk5+u5tHT1AjadNP42T
         tgszHlsAyOJ3Lf/FpWFG1ywAnJz4thUtVjdCDAx5v+855uJq5NbShUJ9STIenkwVcwsk
         Llgg==
X-Gm-Message-State: AOAM532iBMcjpkt1q58D0OH4rz+Pp0yHGOQiSN1Dlp8Ew0UfNdpq04jS
        FllOODrhvRinm5abNMp7FaYR2ehc0TE=
X-Google-Smtp-Source: ABdhPJxGu64CL9vTQsaiEcCWLqHQQAzcfFcX3wEbKtZj8VFoZFsa9KarihVw3b7NBSr4kktbUCqTcQ==
X-Received: by 2002:a05:600c:4f09:b0:389:cf43:da62 with SMTP id l9-20020a05600c4f0900b00389cf43da62mr9008496wmq.204.1646952208051;
        Thu, 10 Mar 2022 14:43:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b00389d2ca24c9sm5542361wms.30.2022.03.10.14.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:43:27 -0800 (PST)
Message-Id: <825079b6aa14c3975254a336e0e313b963bc9ab4.1646952205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 22:43:19 +0000
Subject: [PATCH v6 1/6] wrapper: make inclusion of Windows csprng header
 tightly scoped
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Including NTSecAPI.h in git-compat-util.h causes build errors in any
other file that includes winternl.h. NTSecAPI.h was included in order to
get access to the RtlGenRandom cryptographically secure PRNG. This
change scopes the inclusion of ntsecapi.h to wrapper.c, which is the only
place that it's actually needed.

The build breakage is due to the definition of UNICODE_STRING in
NtSecApi.h:
    #ifndef _NTDEF_
    typedef LSA_UNICODE_STRING UNICODE_STRING, *PUNICODE_STRING;
    typedef LSA_STRING STRING, *PSTRING ;
    #endif

LsaLookup.h:
    typedef struct _LSA_UNICODE_STRING {
        USHORT Length;
        USHORT MaximumLength;
    #ifdef MIDL_PASS
        [size_is(MaximumLength/2), length_is(Length/2)]
    #endif // MIDL_PASS
        PWSTR  Buffer;
    } LSA_UNICODE_STRING, *PLSA_UNICODE_STRING;

winternl.h also defines UNICODE_STRING:
    typedef struct _UNICODE_STRING {
        USHORT Length;
        USHORT MaximumLength;
        PWSTR  Buffer;
    } UNICODE_STRING;
    typedef UNICODE_STRING *PUNICODE_STRING;

Both definitions have equivalent layouts. Apparently these internal
Windows headers aren't designed to be included together. This is
an oversight in the headers and does not represent an incompatibility
between the APIs.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 compat/winansi.c  | 5 -----
 git-compat-util.h | 6 ------
 wrapper.c         | 7 +++++++
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 936a80a5f00..3abe8dd5a27 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -4,11 +4,6 @@
 
 #undef NOGDI
 
-/*
- * Including the appropriate header file for RtlGenRandom causes MSVC to see a
- * redefinition of types in an incompatible way when including headers below.
- */
-#undef HAVE_RTLGENRANDOM
 #include "../git-compat-util.h"
 #include <wingdi.h>
 #include <winreg.h>
diff --git a/git-compat-util.h b/git-compat-util.h
index 876907b9df4..d210cff058c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -197,12 +197,6 @@
 #endif
 #include <windows.h>
 #define GIT_WINDOWS_NATIVE
-#ifdef HAVE_RTLGENRANDOM
-/* This is required to get access to RtlGenRandom. */
-#define SystemFunction036 NTAPI SystemFunction036
-#include <NTSecAPI.h>
-#undef SystemFunction036
-#endif
 #endif
 
 #include <unistd.h>
diff --git a/wrapper.c b/wrapper.c
index 3258cdb171f..1108e4840a4 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -4,6 +4,13 @@
 #include "cache.h"
 #include "config.h"
 
+#ifdef HAVE_RTLGENRANDOM
+/* This is required to get access to RtlGenRandom. */
+#define SystemFunction036 NTAPI SystemFunction036
+#include <NTSecAPI.h>
+#undef SystemFunction036
+#endif
+
 static int memory_limit_check(size_t size, int gentle)
 {
 	static size_t limit = 0;
-- 
gitgitgadget

