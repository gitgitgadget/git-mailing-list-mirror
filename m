Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B02C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C59861175
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbhJGU1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbhJGU1O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91120C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s15so22807374wrv.11
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=S/z+/vW43jUVwNg/7kB3VOW6pFfoguxpPjbAcgBeMQNy7T2U/h0A6jk7phitanMb8r
         bMyYYpZp0g2XwVUaYzwWHjPlGPcLrmFnURIfUcBtDN6MphU+EHnDELPv38y6ZXGD/BXO
         tIR4dc2s61/+5DfC96opKMgzQx5rqwXlHRiVxGCRG4rod2YdO3rmQenZK73hiVVY4yoh
         I9LEqZLKeG8seRPPo2ecD5oz4Iy0WOoD9XLcGLn4YIUkSlZ1FvlMBjtN6Nzmmopj5v2k
         tQMTpHXQZfo9i9eUf2+FEqn+WRBhVZrxWcuvYnWRvkXgNVm9sq5Wi3jHvJNdCyYJGH2X
         RTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=kie0cT8JN98UPhV4vxmsgLPEZ1cZ+F0Q1xFNTnW/Rs/Rnr/8/WSXN32dGzAppf6cch
         4kvXjWeGKRm6MEhZdNMg4f0QOK5Q+etY/HP0EiIckwpygFJqfUGiJ/hASZ54/wwyW5Al
         rpLc9r2nKJE0HlSRLybJ5nyVLVe2ZX3TU/5hXPeh2YXxW9Hg9ABTEcTKffk9l3e/e+fi
         0pq0eZ3bJ/WOI5/KJkdKXthAeA68ewn5zccJ/i/9AHfZ81qWevGGdbTyseeWIWAqacL7
         bjqbaurk+G0C/18/ZmDxCmj1mlyRUUX8pMPlC+9koFkGmJQW/RylSGQM3F/AV6YgN5B4
         V2nw==
X-Gm-Message-State: AOAM531kWt5g4vSKPp6q7YNmsUgJpBgqeFPd8kkOSSRG/BV+YjetEyzB
        Shdbx1njGY5z4wDuyeEo7dlxatrJx6I=
X-Google-Smtp-Source: ABdhPJzlaSvmeCcyM3gCCMDfCviDu6C71M7HI36zjl+WSV/WUFe5RYBHiO1qAwO7ESEIGt0GddbX8w==
X-Received: by 2002:a05:6000:2af:: with SMTP id l15mr8155870wry.17.1633638319264;
        Thu, 07 Oct 2021 13:25:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm452321wry.95.2021.10.07.13.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:19 -0700 (PDT)
Message-Id: <6a5ee5db472ac33e8a113b348354e57cea6ec94d.1633638315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:24:58 +0000
Subject: [PATCH v4 02/19] reftable: add LICENSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The objective of this code is to be usable as a C library, so it can be reused
in libgit2.

This is currently using a BSD license as it is the liberal license I could find,
but this could be changed to whatever fits the stated goal above.

This code is currently imported from github.com/hanwen/reftable. Once this code
lands in git.git, the C code will be removed from github.com/hanwen/reftable,
and the git.git code will be the source of truth.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/LICENSE | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 reftable/LICENSE

diff --git a/reftable/LICENSE b/reftable/LICENSE
new file mode 100644
index 00000000000..402e0f9356b
--- /dev/null
+++ b/reftable/LICENSE
@@ -0,0 +1,31 @@
+BSD License
+
+Copyright (c) 2020, Google LLC
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are
+met:
+
+* Redistributions of source code must retain the above copyright notice,
+this list of conditions and the following disclaimer.
+
+* Redistributions in binary form must reproduce the above copyright
+notice, this list of conditions and the following disclaimer in the
+documentation and/or other materials provided with the distribution.
+
+* Neither the name of Google LLC nor the names of its contributors may
+be used to endorse or promote products derived from this software
+without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
gitgitgadget

