Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F58C4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 19:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiLWTTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 14:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiLWTTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 14:19:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07093D11C
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:19:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i7so5326879wrv.8
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY7PAnHRvdf7iBa0HiQUJ5J2M+tYPTu4mU/yDR/BtrI=;
        b=icR5J3gBgU5wMch5QYP6UKTmczyNYBmho2zJMDFwOnKvsjjSaKdkG/upI7e31c5alO
         ER+OLwtJcyNaiF4f3BkTtfevpLYPYOTvbBTacZZ8B8U2jT9rO/I4DpPuG/3K3GGHq9M6
         8chUt+QJ5CZi+BFd6Rs1EkpV9ZfjKHRq/oPLuN8yHCk9EJmqKljs9ff91tlEAXrpJ8Ou
         WIPAVumPEveylyNgZi744WpWdpWtpEbc97MBwWFuqKZNWevOqy/T85yKXSJoqwc/9UPZ
         Sor16yKYeO/k18nM3nhZbavLZheYJxrQv97sd4hc9fbODkmOf7UO1hvz9tx5gXvACmEo
         kfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DY7PAnHRvdf7iBa0HiQUJ5J2M+tYPTu4mU/yDR/BtrI=;
        b=mjOJBQPWQBd4wedImoOPVGBPI84QNcViFArK/JeuOslwfeRNvE/uRay9ffFvIHIBBK
         XYRGj8E/D7V2gkFsUKpXeJqPLlQV/zjbRWkeKXHJMWRAeTFbqfMsG/qRHFwVikjfY3/5
         rcvt3FAgIOnI3g8IDR/zgp9MD9QBld0MXAvlAAMOil9cHwBgnJcIfJ0BHLI0olNt6Vug
         pnPZUAQwYb/fDneX+c+3u8Mhq0wUDFbZJ/2Jkn3K32ctqSiitwpEl2KOpeyTS/O4XJVv
         kd+OmO7cCbLSaBOHuqeK72BXfi8MbaNhIqq9P8JS8vToPZc3maJGRR6hh+3di51bB8ju
         gxGA==
X-Gm-Message-State: AFqh2kqbbIfscgNeIw+olHEjv1p3rgJaUQGPYTgGF9FTiiHcqZZe88UO
        zFjiH0jEvdVKOeYhtzARk3Fkc4praI8=
X-Google-Smtp-Source: AMrXdXvxoDFTSIphphQ3fan8w5NFp9PdMuP3GUJkBbEJpFPYMViAJZtrc0pvdeDNzn5j6o1VvXYWHA==
X-Received: by 2002:a5d:4e83:0:b0:25d:9954:32c9 with SMTP id e3-20020a5d4e83000000b0025d995432c9mr6344370wru.10.1671823179479;
        Fri, 23 Dec 2022 11:19:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s18-20020adfdb12000000b00241fde8fe04sm3892799wri.7.2022.12.23.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 11:19:39 -0800 (PST)
Message-Id: <c5d2ddad166165d1ac8975ce6d06c16eb3b6b6cb.1671823177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
References: <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
        <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Dec 2022 19:19:37 +0000
Subject: [PATCH v11 2/2] win32: close handles of threads that have been joined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

After the thread terminates, the handle to the
original thread should be closed.

This change makes win32_pthread_join POSIX compliant.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 65e15a560d5..f63f65c9dfe 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -41,11 +41,15 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 	case WAIT_OBJECT_0:
 		if (value_ptr)
 			*value_ptr = thread->arg;
+		CloseHandle(thread->handle);
 		return 0;
 	case WAIT_ABANDONED:
+		CloseHandle(thread->handle);
 		return EINVAL;
 	default:
-		return err_win_to_posix(GetLastError());
+		/* the wait failed, so do not detach */
+		errno = err_win_to_posix(GetLastError());
+		return errno;
 	}
 }
 
-- 
gitgitgadget
