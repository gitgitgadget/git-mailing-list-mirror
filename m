Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F86C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9490220857
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 10:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJsxM02F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDIKYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:24:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36184 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIKYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 06:24:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id i7so12675926edq.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TUOphkvACUQS/ive9zpiNsH0FG7oz7ZAM87A+FmTQjM=;
        b=kJsxM02FFbef/IG/0l+bP/50miY/gorf6annhQBQeY+MmCrYO4puyRTkotZAy7WoxL
         6e2p4rAy7/xxODwec1tbwhlECfna0iSbGt0BIM8wcLdu/SHHIpRlPLeyI5w3iCFR9RBp
         2wI35x99SG6sNSqbifwhEvF/69EkMDP4DZSZLUSvwZe8N4EbGDtWq7fhVnkgzlvy1y5+
         mZq57443hhMovE/SEJkt+9O1l26oD7Dp85Rb8Vi7hY1yG81qdRPbUzZzelVc5e5eZQJz
         eujfFpw1/Lvw/akxIMXODA8xLKXJ6NgDCsLenyx2d8s3Ce+8oUhRs9Nxs9fsLNAdTbW0
         yAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TUOphkvACUQS/ive9zpiNsH0FG7oz7ZAM87A+FmTQjM=;
        b=hfKvVgTKmsWuAEH1BT31wQG1qSnu/A+JxZgS+Zzo/5Emh7QTyNkxenU++ssmmV6SBu
         4eraz4qlkDfewZSxE/I0JaKE3Nubh/1SLOuwq00SAgV82Bq63g49mxJbSFXTpHvi3izh
         MP1nNA1BGsB2ldn+58dz/C3E+0WLGutAQsfy4NVncVYlQZQ1pJ3IU/SdJ6BDJwUtCZGp
         9+R10nzchMW6VEn9Ywwdw3NdSunKftK17iHjpTBRwrV/STbFEIVDlXMnEoHn38eIqTTA
         vXW37YuFFh8Npv5rHIWaiG38DSftWPnkHGrzyBWlYkNQ7VIXWGu/zaO4FkvJvja9VoMx
         jYSw==
X-Gm-Message-State: AGi0Pub42xq2WTZhA8LS+fyLA7fBYEi6d48459Utobjkf1zN3HyOOotA
        uDfZi4/MGQIyVD3+BD01jqWKvOa7
X-Google-Smtp-Source: APiQypK8Yc9SPz6ncht5uqfp1aGxewNpkRafLiGSbq0J8IkQes90rCrf7AeHGvmgB7C/QWUsdZgjMw==
X-Received: by 2002:a50:d783:: with SMTP id w3mr1784379edi.166.1586427854294;
        Thu, 09 Apr 2020 03:24:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dj1sm3118908edb.70.2020.04.09.03.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 03:24:13 -0700 (PDT)
Message-Id: <pull.756.git.git.1586427853403.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 10:24:13 +0000
Subject: [PATCH] mingw: cope with the Isilon network file system
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nathan Sanders <spekbukkem@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nathan Sanders <spekbukkem@gmail.com>

On certain network filesystems (currently encounterd with Isilon, but in
theory more network storage solutions could be causing the same issue),
when the directory in question is missing, `raceproof_create_file()`
fails with an `ERROR_INVALID_PARAMETER` instead of an
`ERROR_PATH_NOT_FOUND`.

Since it is highly unlikely that we produce such an error by mistake
(the parameters we pass are fairly benign), we can be relatively certain
that the directory is missing in this instance. So let's just translate
that error automagically.

This fixes https://github.com/git-for-windows/git/issues/1345.

Signed-off-by: Nathan Sanders <spekbukkem@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: cope with the Isilon network file system
    
    Yet another patch that has lived in Git for Windows for a while. In
    contrast to the other patches I submitted today, it is younger than a
    year, but not by much: its author date is Independence Day 2019.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-756%2Fdscho%2Fwork-around-isilon-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-756/dscho/work-around-isilon-v1
Pull-Request: https://github.com/git/git/pull/756

 compat/mingw.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d14065d60ec..201e99292fd 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -460,8 +460,19 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	handle = CreateFileW(wfilename, FILE_APPEND_DATA,
 			FILE_SHARE_WRITE | FILE_SHARE_READ,
 			NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
-	if (handle == INVALID_HANDLE_VALUE)
-		return errno = err_win_to_posix(GetLastError()), -1;
+	if (handle == INVALID_HANDLE_VALUE) {
+		DWORD err = GetLastError();
+		/*
+		 * Some network storage solutions (e.g. Isilon) might return
+		 * ERROR_INVALID_PARAMETER instead of expected error
+		 * ERROR_PATH_NOT_FOUND, which results in a unknow error. If
+		 * so, the error is now forced to be an ERROR_PATH_NOT_FOUND
+		 * error instead.
+		 */
+		if (err == ERROR_INVALID_PARAMETER)
+			err = ERROR_PATH_NOT_FOUND;
+		return errno = err_win_to_posix(err), -1;
+	}
 
 	/*
 	 * No O_APPEND here, because the CRT uses it only to reset the

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
