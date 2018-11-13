Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36DA1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 14:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbeKNAf3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 19:35:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34930 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbeKNAf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 19:35:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id n4-v6so6118346plp.2
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 06:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=byyLT+W91J3KaVBik+muoBjyllZrrynrHEHu8blfYI0=;
        b=moFiyeAhDijVcVobgo/O3Xbec/FGWttgrP38OAlWfvF46oI/wy6irZgCHghD9kLvmt
         yLbdDj/a0vtF5cgt0JUtQKSSHUubNTZzttyqdNgqVv2JWiF4T0grRIjFw5S7GCBqNjdZ
         pZGYHeHBwQwNRMmau3GyhBgrtcce0cER8uZevhDXB8drIBGnvg50+pioKzJ33uLWlRai
         ej6FzlmWlhugjcaZH/W2pgHGOsghmEL4/GQeU+NQtgULn5MT/IDjRkRZ907TypWmqFXu
         9FZC739vXeo4qWMvsNymdVem9PRR3+kbMylXWl8sboyWkmTsB637wRD4BOOnn7RRo8Oc
         fqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=byyLT+W91J3KaVBik+muoBjyllZrrynrHEHu8blfYI0=;
        b=UP+DxW2xwNkpYeFVxmEusN/JWL8ICBDAcp0cHK1KL12Cw/m+dKShSibQrw5RD1n2St
         Kg9g5zuY8NmJWjY7MkHESH9vGo0fkaN+24WffUkrbdNOT06Ka7tf4WiJ02WYRYJDEK5J
         Nzg2xZO0GhMZnBEMZUL4t4tgoLRXFnLIPrjubRP2B1L8mCltOcraXTzoYJjtcfDmjltA
         zrkDWDgzjmwq53FnyFYXRMqOTelb0u8GldQmiFzyU+GhPTdcWv8jm8xIyP2tXcr5AiRT
         67tcphsoMUZgr8M7ZVbw51KxRNtuJ7Bk51FfxyCkjf39DYsAoUn61AJZ1xfNPcTS6KQF
         uP3g==
X-Gm-Message-State: AGRZ1gJYqMacsXBlaM+WXfnX2OLL+qSVmQ9url/5fbhFUyo3PUbYoUnI
        7vT/Vmbfktn7oonL7nBtQU4wyhqm
X-Google-Smtp-Source: AJdET5cyhgXteuXqeMwBHPOk5tTKlW+aj6Squ43AxwfaWnas52s55iDqf6pedbifqS/JJ4Jb0uG09A==
X-Received: by 2002:a17:902:4683:: with SMTP id p3-v6mr5420642pld.215.1542119823170;
        Tue, 13 Nov 2018 06:37:03 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id a17sm24721472pgm.26.2018.11.13.06.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:37:02 -0800 (PST)
Date:   Tue, 13 Nov 2018 06:37:02 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 14:36:59 GMT
Message-Id: <b1fdce037c66b0dcfc36f7a8b0e231880962ccf4.1542119819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.77.git.gitgitgadget@gmail.com>
References: <pull.77.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: use `CreateHardLink()` directly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The function `CreateHardLink()` is available in all supported Windows
versions (even since Windows XP), so there is no more need to resolve it
at runtime.

Helped-by: Max Kirillov <max@max630.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3b44dd99d7..fdcf946275 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2084,24 +2084,12 @@ int mingw_raise(int sig)
 
 int link(const char *oldpath, const char *newpath)
 {
-	typedef BOOL (WINAPI *T)(LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
-	static T create_hard_link = NULL;
 	wchar_t woldpath[MAX_PATH], wnewpath[MAX_PATH];
 	if (xutftowcs_path(woldpath, oldpath) < 0 ||
 		xutftowcs_path(wnewpath, newpath) < 0)
 		return -1;
 
-	if (!create_hard_link) {
-		create_hard_link = (T) GetProcAddress(
-			GetModuleHandle("kernel32.dll"), "CreateHardLinkW");
-		if (!create_hard_link)
-			create_hard_link = (T)-1;
-	}
-	if (create_hard_link == (T)-1) {
-		errno = ENOSYS;
-		return -1;
-	}
-	if (!create_hard_link(wnewpath, woldpath, NULL)) {
+	if (!CreateHardLinkW(wnewpath, woldpath, NULL)) {
 		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
-- 
gitgitgadget
