Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6111DC433FE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E722610A2
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbhJZWiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbhJZWh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 18:37:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693BEC0613B9
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:35:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 136-20020a1c008e000000b0032ccae3b331so727714wma.0
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4ZT2JLUdNEcjrhJV6TVRcwBGw2uyZfrSxNINrBK83Rg=;
        b=PonYw2gE2Ud2mOInJwXGJVBeSJsy90rljQfsTTeFK7FGFFULC2uWLTR10YvNWU46Tp
         x69V8jOxKsFB60W3YvPWpbv9Rht5eRJWyhBO4DtABM9nJo59WdZE9yT4/i8s45B49dGv
         hPDTMe8FK/ZieTk/yu52XFkudov89ufXuP1ZqZq7N37gmLWzlfwvd3W3+JCjf7KIYjE/
         ELMFvImxIXxeK1s0LToUWkNpZsPQOTrsFahThcuhBQTE+hgd5dygJldpmsXKwSkISpqQ
         U0dStSaun3ErVARVWs7Q+5jy9oG55PPQeCITFbjtXJKfB8X2KHMvpIOBgtr/UWsiivDD
         fT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4ZT2JLUdNEcjrhJV6TVRcwBGw2uyZfrSxNINrBK83Rg=;
        b=VfJdxvbalJfA7oyBB3+WtO3KtmA/rtESFy5pIR4Ddu9qVe4nItDW3QbJbO+qAKyE7R
         +9n5RnAm1b7m9mN9Jt5gkxckALCl2zpUYTmk+xikkeH0lzYsBgXq7wRoeqjAQiyX9QyR
         Hxw8SDes117QTcT4H5wbUecyA5hlUmPa0it/SLG5XaWfwJSzSFqakcg3YpnIwnxn5nnt
         3m9NgxipRFIbazd5S3i/9EF+/sx+gyuUntY3PX1f0f3Bwj1ExrP2xLTWDM/38duZmTkr
         Xv7QvR8kvhyQ1BJm/eZXPFgMS5pDPhZuXeLw9epqFF1UqXTH711+2hEa7I4iL5mi+HNm
         51yw==
X-Gm-Message-State: AOAM5305SEQRn5RDgM/oGuX8fKmh8p6evnTJOBeO2hY7r/Ksa5tauU23
        CAzn32oOMqvNjlwWZGblq7W6dP0vptw=
X-Google-Smtp-Source: ABdhPJyhu3KOAAh7/EHcmbDNw/oQL+8uqcDE17t5VfgTWw1TOWHXUfRE6+HA507957nTKYBWvj4Chw==
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr1676407wmj.114.1635287732019;
        Tue, 26 Oct 2021 15:35:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm23346461wre.32.2021.10.26.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:35:31 -0700 (PDT)
Message-Id: <d244cc4bb60959b8f3d8711a7aeb434efcc9d2a2.1635287730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
References: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Oct 2021 22:35:29 +0000
Subject: [PATCH 1/2] fixup! tmp-objdir: new API for creating temporary
 writable databases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Fix prune code to be able to delete multiple object directories. I
wasn't properly resetting the strbuf with the path.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/prune.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/prune.c b/builtin/prune.c
index 9c72ecf5a58..6b6b0c7b011 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -31,6 +31,7 @@ static int prune_tmp_file(const char *fullpath)
 		if (show_only || verbose)
 			printf("Removing stale temporary directory %s\n", fullpath);
 		if (!show_only) {
+			strbuf_reset(&remove_dir_buf);
 			strbuf_addstr(&remove_dir_buf, fullpath);
 			remove_dir_recursively(&remove_dir_buf, 0);
 		}
-- 
gitgitgadget

