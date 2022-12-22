Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F82C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 20:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLVUWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 15:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVUWf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 15:22:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A7523BFA
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 12:22:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o15so2252289wmr.4
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 12:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BW50M4YzghVZpHUWI6iCRlyOvKi/PTe+W8qSXJF4AMY=;
        b=Q9u0Ea0ovwZA0MDatRElA/s5b341URDu2219LM4YpGW9HEjf1M8SZFYZNC82IOMT2f
         2iS5tYJLaw6sFlxJT7bv4AmZkecjkaF6hVfqPqPMiQrEWlMpqG0i1PQKfAtPexOAQmmQ
         u0Lg4EWnun9wzuCRTXgfrTE6uLT9D6B1UHb6YVbm/CnF3Bs7Jp0fkYJAKIXMu36c9agh
         t82dH2AaV1Hh/zzxU2x8H3s1qHPJZZOyK3xl4JLfeZjTioKeZ2f0Tm0tX6Tt1A0LRtBr
         DNIBvpZbYUyaxHQLY6WDdgmrzalrbjwVbJwP2E1knCX39/Q9yJC+EERQ2Rv3br5fTshg
         qLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BW50M4YzghVZpHUWI6iCRlyOvKi/PTe+W8qSXJF4AMY=;
        b=Nxyu+ySWLCD2Xgrgb1GZ7kWEemxc/Wa4h/UBC0UwaW2QMDgyOkfvh5SXZOGbsO8Bhg
         tp3Ep0Y6yZQh41voAZ4QcpZnZUNFMMOEp2R45VYgZKg2nVtCCuclxg70aHqa/H9UTTZl
         zxvH+ezwTsDMiCQSdkVdnYHgW13qCd43vUAD9rQybELaU9MujYmBVdmkNp6LnolEclXc
         4u/I+5lT1J0kctJrtET5QWUwdeY0qmMjbk5yTVDWR1DHG8hCFMNuEmECE7Ow8ho3zCxw
         A7hJLkSBAd0SDwrwRfSXnC8pBakO6CMDKOeiSGfFbq91x+qOEVxcUimz1dNIeQ7uzlQL
         /hNg==
X-Gm-Message-State: AFqh2kpiaGJsPqJCzkk6qY7sPSAeDWhFktsJD7BE1HaugFmwyhi6/6Li
        UAKPgO2FspfhUmi+6wH/cNEw9LexTGU=
X-Google-Smtp-Source: AMrXdXvdziKRpVwq3Wu19DF020wX6DYMCUeHVqe2RT8D7Dox/sbHpgf+ZFns+OMnYtnUjlbErN1Mbg==
X-Received: by 2002:a05:600c:34d3:b0:3c6:e61e:ae74 with SMTP id d19-20020a05600c34d300b003c6e61eae74mr6234438wmq.4.1671740552442;
        Thu, 22 Dec 2022 12:22:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bca41000000b003d1de805de5sm2079782wml.16.2022.12.22.12.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:22:32 -0800 (PST)
Message-Id: <pull.1413.git.git.1671740551466.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 20:22:31 +0000
Subject: [PATCH] mingw: check that the file attributes are valid
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

If the attributes are invalid, return an error.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    mingw: check that the file attributes are valid

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1413%2FAtariDreams%2Fset-hidden-flag-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1413/AtariDreams/set-hidden-flag-v1
Pull-Request: https://github.com/git/git/pull/1413

 compat/mingw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index d614f156df1..71a039cdd7c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -435,6 +435,11 @@ static inline int needs_hiding(const char *path)
 static int set_hidden_flag(const wchar_t *path, int set)
 {
 	DWORD original = GetFileAttributesW(path), modified;
+	if (original == INVALID_FILE_ATTRIBUTES) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+
 	if (set)
 		modified = original | FILE_ATTRIBUTE_HIDDEN;
 	else

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
