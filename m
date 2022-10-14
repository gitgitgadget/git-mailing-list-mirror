Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D0EC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJNVqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJNVqM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:46:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578FC94101
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so6541085wme.5
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeIJAFWxEsrz1YUq4p3vMlNyGEFg/vGTl2fx3fBK7IA=;
        b=idA8gMYns9xSnVs8jYZNh8nfTpbRGRWvkx6yJtgwWxZnZ/uqD07NT5h/ELzfHbtOru
         2OLiSFTLnF9Lo0Pwb7Fpp+bVOnsk5eSwrqxU7zszTx8Q2/QFgpvz0wVW5TOBa+FE40K6
         Dku+2VJb14KMJ41uatc/xJ7VOoh3lEgXKY7hY72Dde50FLhm/QZEOGtWOYr3ih5Ru4hy
         7Sqp4VXaao57jFAEv5BImWRmSemcZRwzx6TddK83BFVAvfcH20hbxLjhOYs6954xUJz3
         +uxI8g/UbePwVg76xEK0WCfkpCDH++Dm35ozJ9PDja/bj/lzN/lj49Te6OHiFBDx04QH
         zM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeIJAFWxEsrz1YUq4p3vMlNyGEFg/vGTl2fx3fBK7IA=;
        b=N1lJyQY56/Y/PwTdGmVQBQetRnRxdGrgKzOqoD14UURSL+gBpEOBy8mguuXYIfJuJA
         tbMeCayGLsH7hXpF4v+QTVcvq0+mdv6gccKsrY37gRtLMGS8wDnXtQMJ5Z7h9/rqQBf5
         S7euPMvv0eDmJ7RbiZ5v45/+NKWdvroSiEfAwBTfxpVinhmfdsCsogQkvQeimCD2ZvUB
         jT27kKWdRIZwBYIT61hHvI+cIKHDaJ3Xr1jMb0AqLKtk6U1cCZ34AvGSYsdWZ5G1hxDC
         SYYdD2tnD7ksQ74wQjfANWMKZMY9Dh8EFHtVnH9o0X4QVsFQlMjdlsXhFIvwQBiHF/gt
         M4MA==
X-Gm-Message-State: ACrzQf2OiXQjP9SdG4eDSFRW6/rNo/P9EtAeTCJTH4mqsqKiJzW3siNP
        p6jAYYV8qz62sVbvwhZy+oO7m3nQJLw=
X-Google-Smtp-Source: AMsMyM5Z/Jt1wm0aZDvfeYjbcA0/8DsLID507qtouqRAa55BXCz4Mlw1BDDNP5Ngrj86DZ7wZvU3rA==
X-Received: by 2002:a05:600c:490f:b0:3c6:2c21:97f6 with SMTP id f15-20020a05600c490f00b003c62c2197f6mr11581665wmp.177.1665783958000;
        Fri, 14 Oct 2022 14:45:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe307000000b0022cbf4cda62sm3435173wrj.27.2022.10.14.14.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:45:57 -0700 (PDT)
Message-Id: <07650ecd27b91d49a83427187a846c18424f9ab4.1665783945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 21:45:42 +0000
Subject: [PATCH v2 10/12] fsmonitor: enable fsmonitor for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Update build to enable fsmonitor for Linux.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 config.mak.uname | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 9f716cfba81..d8889f8570a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -68,6 +68,15 @@ ifeq ($(uname_S),Linux)
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
 	endif
+	# The builtin FSMonitor on Linux builds upon Simple-IPC.  Both require
+	# Unix domain sockets and PThreads.
+	ifndef NO_PTHREADS
+	ifndef NO_UNIX_SOCKETS
+	FSMONITOR_DAEMON_BACKEND = linux
+	FSMONITOR_OS_SETTINGS = linux
+	FSMONITOR_DAEMON_COMMON = unix
+	endif
+	endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
-- 
gitgitgadget

