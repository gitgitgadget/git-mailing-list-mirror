Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF630C6FA83
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 14:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiIKOD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiIKODW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7D533E12
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 07:03:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e16so11341472wrx.7
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=nJrPcrw4J5uZ/uidGY4Nc5Uyj1ys80Xs6SCOZR+cjKo=;
        b=Bpt/R7LiwBzrgfsxrbaL012QO8rirkDV9EFRh8ItABNyTqCHCWHAqvqJ8ay2qeDfCA
         Xpy2BpeUYZ9x5NpgVYQeZ9gLLdAXmlo1YNa9kz81ZmvvHcJ97o/fyE2JpXsL2V2W+cOV
         /HwOnRTkGlgb6EmlYW0pMjhuaRxKRhvkRp64OObqKVHAvyqK66Lj3Tiy9bi2z7r843Eo
         L6Dtd/dWx6m/KXkDglwz1HWVQ7523iZV1dGDwBLkxnkC67/JmnKeWOd90Y/OyvVCoBLX
         4No0MIB2pPf0lbDivcp6mFZGME5irvdHpEvdHkASqW1sjgMVsJWm2reVucfrxXXP/gDA
         BbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=nJrPcrw4J5uZ/uidGY4Nc5Uyj1ys80Xs6SCOZR+cjKo=;
        b=CJEObcPcocCBtnzDgUdZp9OhjPDRf7bWjqAWtvGHRGmd5fuD/6R+K2HyUW+Gof4zYf
         1AZ6uFrWQ/Pn9fO7c+F5/849IYnEZWb47euRYkLM+AaoM0r6fy+zGiMs6PRrXbzbVuiA
         CIz0JZ5J5TkL95kvA67CDTZgwvazh1gmOLxixIASSNQkYLshjY1c6Hsm+UYaESNdsKWH
         PkESMmZFmuisXbHR7O56y2LJZuvGvEVMmqUFnMWQug0MtsVIqGlLeWo50+azIZOygwsk
         F6EXDzwy4YhzjXQURlXf+vdOy9ZKLnHAQmbVXhfK5jC3OH7bneY3+r0cjgaIo58GZ4jF
         D+4Q==
X-Gm-Message-State: ACgBeo0HWWn3r+79RvbClG22mkbPzPbgR7tLJnlrop4ANGqgolKQXtOW
        Gi0RemjAMVxFKFY01Y/uh4UB8PcQwLc=
X-Google-Smtp-Source: AA6agR7iOy6K+oiA+7TPChykVIxwdGIQgdo0jJZ2tkMtVrAqs70FUsHIKYSdoLVojTUUmOG7mZmQUg==
X-Received: by 2002:a5d:54c5:0:b0:22a:845b:d6fd with SMTP id x5-20020a5d54c5000000b0022a845bd6fdmr935054wrv.591.1662904999012;
        Sun, 11 Sep 2022 07:03:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5-20020a1c4405000000b003a2e92edeccsm6602635wma.46.2022.09.11.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 07:03:18 -0700 (PDT)
Message-Id: <pull.1350.git.1662904997760.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Sep 2022 14:03:17 +0000
Subject: [PATCH] ls-files: fix black space in error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

ce74de9(ls-files: introduce "--format" option) miss
a space between two words incorrectly, it leads to
wrong i10n messages. So fix it by adding a space at
the end of the error message.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files: fix black space in error message
    
    This patch want fix a little typo error in builtin/ls-files.c, which
    pointed out by Jiang Xin in [1].
    
    [1]:
    https://lore.kernel.org/git/CANYiYbFGSfg+iFV1ovhCSxW0YQSpemKUN-sS+F0BHee7KD5arA@mail.gmail.com/.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1350%2Fadlternative%2Fzh%2Fls-file-format-error-mesage-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1350/adlternative/zh/ls-file-format-error-mesage-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1350

 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 779dc18e59d..4cf8a236483 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -257,7 +257,7 @@ static size_t expand_show_index(struct strbuf *sb, const char *start,
 
 	end = strchr(start + 1, ')');
 	if (!end)
-		die(_("bad ls-files format: element '%s'"
+		die(_("bad ls-files format: element '%s' "
 		      "does not end in ')'"), start);
 
 	len = end - start + 1;

base-commit: dd3f6c4cae7e3b15ce984dce8593ff7569650e24
-- 
gitgitgadget
