Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B49C433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E11961209
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbhI1PMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbhI1PMB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 11:12:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A228DC061746
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t16-20020a1c7710000000b003049690d882so2545622wmi.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=kQtD+G3v+uOjnKFx70XCFvfaToVeLjiM2XfHaIyghVmo6jAKtA/0EVcRpd1yFGQcSk
         cqWop5s+YNojj3Js1HlubuDwlkDdHTwhm7Ut00tNm43gwLH/WbffCRplsqNVhPZAImw5
         nLG49PC0FQGQMwxIL7byrMuF2EAp0KUPV0pL3vmlih+g810k/omqaM/U+uOq5le3JKjM
         7xBG/2TWz9KrFjhF+y0xp8ruu6JUzqlUzk/WFDYfhKDCiR+y5VwiLr2NpukFXwEAlBKe
         WLWK60Rzq81be6BfjTWyeSvDWY/6kZUO6USwFmd5plYp7qJdK0TeOu9/i5DmqWxkRQ7L
         0uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yj9tx1HJN1gjVb7BbFdzwGzB8sZO/EgnY23zy/aVzOc=;
        b=Geiq/hyGfV7f84BOJmAGciofEmARjMEbuIFZrv5O4sN1JA4wspQtGSGczeOHMQNgmt
         Zg41dDYd2L80DMxHj0HylxoU1biapsqCKtExNtEdXCbf+4WPOxriIm39he1gp+jeCs0y
         HN2dmhem6g5M4emS1Wv0+Og3NQzuY7diJSc21vV2OARZQgMo7LBpOjjHxQTLFKHxfHE1
         nr/LAqsI40YmvTKqfyLEu+Wa2LchRqfz5AlH6K1JvI9U4NQUaYdg0nC7eReYD78L0Tvf
         UM+jXZWVG7dpVAoSL4Se6kAkktOFEt//eIBZDHHaOOB0AbxNdZo29KQobrES4H9u4MkH
         6KRA==
X-Gm-Message-State: AOAM530CVLcLtODe5P8Gur7YkArBcnwHoHbFQW3vwPdZr/GbYUzfbET4
        V03IxrCShpTIWeKlX40tmT2TPK5w9/0=
X-Google-Smtp-Source: ABdhPJyTvzidlD23uUyCEoyNGtjpnrj16UAqv+8oox9C1qMECVUwnxks8P2tTWBqs3CX0rXLIlegew==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr5315053wmk.51.1632841820194;
        Tue, 28 Sep 2021 08:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c30sm20045757wrb.74.2021.09.28.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:10:19 -0700 (PDT)
Message-Id: <2597ddfeae1d9da8695151f62379c85621ad0fcb.1632841817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
References: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
        <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 15:09:59 +0000
Subject: [PATCH v3 02/19] reftable: RFC: add LICENSE
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

