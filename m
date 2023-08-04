Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585EC04A94
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 04:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjHDEJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 00:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjHDEIu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 00:08:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D8B1BF6
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 21:08:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so16661865e9.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 21:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691122127; x=1691726927;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUi6jFQp8L/llj4/EsTykhKwkXSIppO/CWNsJgzWcqw=;
        b=d6c8Ft8r+XPBHqyKpUuQgPgovPkKMyct8v6RrAFbmgu1+qlgwn5IER9wtsqpY8rN/J
         wg4A0ak7+IL4tKlgevHQCSP3N2eZUfhQ1ve3b0CHNwdGXuzgJEbAzujnsyj6SlMUizR1
         91SYbI3eXKEnL5KrFd7Z8yDdLkmgra8fB+NAraVUh6upfkFEYDjT6P2V5LPzF9Xg3/Z3
         yf4miwKvctDUSucejdWs8PymuEvu+5QKGiImCF2Q3UdgjVLmNAcfpjz1dAyAs/FhbTMn
         uU08uJdq3y/IiqpA7uX7BMJ8ok9h6azRqor4miyGnd/oisBdQSd9SpyGs6w9fZ1y2yFY
         oOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691122127; x=1691726927;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUi6jFQp8L/llj4/EsTykhKwkXSIppO/CWNsJgzWcqw=;
        b=gk8Cwc6MrsRJHPAWez2NIczADKO7LrtgHkZm/4Ks8ybjtFTL6sCKXR5LcjiyswpHo6
         LO9d/Lijf9FvbletCe8TnE3gPklSfaIQnUzoqLu/fmyWuJrL/ih7FcbacrW4h2SUME85
         GhNsv4tgU8NZfr0nCrU0Lcp/jdXGOjuzWX84oIDZfaggQpZJyOeMXxVv6AjmwfN5jpfa
         tOrcAmD083wYQ38DPIS8zGKuyVPg/FBzW12xD/EHXOu0zSQn6cCCE2IryZ3OPbF+YdSm
         TqzbACGHEf4WBd+QBwE5Mf+XTdHd3zq7JRgmoduhzbjGCUtdJmZCGQzFzGP3ufNfouY1
         2Lgw==
X-Gm-Message-State: AOJu0YwfWBEfLPgrP+GhHdzr5cj2AkKa0E04ouqQrsDb4PrRLDSulQo8
        u+WlpZqNRrIO1tAwd6Hs3MdIj8amtLY=
X-Google-Smtp-Source: AGHT+IE3JFbv4UYx60PyIAUJXmhWud7jys9r8v8zESHdtAXm+eNJXgNM92iCWQU6otEEL36n/jk+Ww==
X-Received: by 2002:adf:e652:0:b0:313:ef24:6feb with SMTP id b18-20020adfe652000000b00313ef246febmr329526wrn.3.1691122127469;
        Thu, 03 Aug 2023 21:08:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d66ca000000b00317731a6e07sm1382364wrw.62.2023.08.03.21.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 21:08:46 -0700 (PDT)
Message-ID: <8b8c8c3f70a25f198335e36dfd501ffcb9d411c3.1691122124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 04 Aug 2023 04:08:43 +0000
Subject: [PATCH v2 2/3] compat/mingw: implement a native locate_in_PATH()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

since 5e1f28d (bisect--helper: reimplement `bisect_visualize()` shell
 function in C, 2021-09-13) `git bisect visualize` uses exists_in_PATH()
to check wether it should call `gitk`, but exists_in_PATH() relies on
locate_in_PATH() which currently only understands POSIX-ish PATH variables
(a list of paths, separated by colons) on native Windows executables
we encounter Windows PATH variables (a list of paths that often contain
drive letters (and thus colons), separated by semicolons). Luckily we do
already have a function that can lookup executables on windows PATHs:
path_lookup(). Implement a small replacement for the existing
locate_in_PATH() based on path_lookup().

Reported-by: Louis Strous <Louis.Strous@intellimagic.com>
Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 compat/mingw.c | 5 +++++
 compat/mingw.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index d06cdc6254f..bc3669d2986 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1347,6 +1347,11 @@ static char *path_lookup(const char *cmd, int exe_only)
 	return prog;
 }
 
+char *mingw_locate_in_PATH(const char *cmd)
+{
+	return path_lookup(cmd, 0);
+}
+
 static const wchar_t *wcschrnul(const wchar_t *s, wchar_t c)
 {
 	while (*s && *s != c)
diff --git a/compat/mingw.h b/compat/mingw.h
index 209cf7cebad..b5262205965 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -175,6 +175,9 @@ pid_t waitpid(pid_t pid, int *status, int options);
 #define kill mingw_kill
 int mingw_kill(pid_t pid, int sig);
 
+#define locate_in_PATH mingw_locate_in_PATH
+char *mingw_locate_in_PATH(const char *cmd);
+
 #ifndef NO_OPENSSL
 #include <openssl/ssl.h>
 static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
-- 
gitgitgadget

