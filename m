Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49518EE3F08
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjILRaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbjILRah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:30:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07CF10E9
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:30:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so62607185e9.0
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694539831; x=1695144631; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCEE7bxn8DL/IYEyVMPx1uPofEtxbqkzxdOTcvbruZI=;
        b=Nrd0RT9RQ7q3Q7M7fr7YNFwU9mhOqeybjcfKC9dyekv8vXhmacDqa+v/HChrrCdYvt
         E/oX/2KoEETr7/+9W5PzHrmvKTLpd+h2JxmTBHOvvLM5YrnH2GzvVMGpvOh79aFJjoHC
         4nUIgFkInFTT+2RCpu4GE4DhrYQ7vGOSL5Fj6KUFiejyojrlzteEqm269TLaZpfbSHeL
         u4IvU1TYeyQzc52lxqkKeKwRzPmify+PnAv5g9hLJPXlLCxnQrwitcOXcBVBN7KFs/ur
         yAko/jngFckxzBVAlLySaR/+318/kvp980ZT5tZGIEW3gc2HzIzgiBpaT9BZTQiSiOTa
         va3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539831; x=1695144631;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCEE7bxn8DL/IYEyVMPx1uPofEtxbqkzxdOTcvbruZI=;
        b=jsDYuWxQO/kb8/6OD1h1ioR1EUHrzlscXIvvyciXasYIGZKk7lc3zTal+baymjbi7E
         4Z+tHFJVvKwt4oXdRiOHjPyEHw/IxCY2XFHx8AerN3pEvQRIy89cUaU2r9VL43nSD8+9
         BmRDQHwsJ2Z9VEW9aJCzqKWootlux7pnVROi6jIqhboXRlagnCwZes07+U52OIbNm8+K
         vtpk0NLOnRRMptyWQo61ocbvzpK20KMIHR0huyk5dY6AFmU6PI94ccjfY4yrjdafTtRB
         RAvGAjW8Z1sROiVUSn9HZaQevTA5zZ/I9q61kbi6TkfFA22ZpitIq6liIN2kwwU6yuDa
         ipPA==
X-Gm-Message-State: AOJu0YwKtv8Ews01hp4t4orUclmxvO3EZXnjEW/A5j9iOjCg88D5dS2P
        fUwyUUXssY/GLKOsMsEGHFmrkhiP0ZY=
X-Google-Smtp-Source: AGHT+IH81WVZUgVHtWfQwT0SDDzp5AdVF0NvXpECXNKkd6rhbKMPDzi/NRL4fwliZqzF6eI4fhk1jA==
X-Received: by 2002:a7b:cd1a:0:b0:402:f5c4:2e5a with SMTP id f26-20020a7bcd1a000000b00402f5c42e5amr68652wmj.37.1694539830722;
        Tue, 12 Sep 2023 10:30:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a1c7211000000b003fe1630a8f0sm16550247wmc.24.2023.09.12.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:30:30 -0700 (PDT)
Message-ID: <9cb33c20294e096f5345fb1ea9d80a23e899ae6f.1694539827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>
References: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
        <pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Sep 2023 17:30:27 +0000
Subject: [PATCH v2 2/2] completion: commit: complete trailers tokens more
 robustly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

In the previous commit, we added support for completing configured
trailer tokens in 'git commit --trailer'.

Make the implementation more robust by:

- using '__git' instead of plain 'git', as the rest of the completion
  script does
- using a stricter pattern for --get-regexp to avoid false hits
- using 'cut' and 'rev' instead of 'awk' to account for tokens including
  dots.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b5eb75aadc5..c23465886e0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1679,7 +1679,7 @@ __git_untracked_file_modes="all no normal"
 
 __git_trailer_tokens ()
 {
-	git config --name-only --get-regexp trailer.\*.key | awk -F. '{print $2}'
+	__git config --name-only --get-regexp '^trailer\..*\.key$' | cut -d. -f 2- | rev | cut -d. -f2- | rev
 }
 
 _git_commit ()
-- 
gitgitgadget
