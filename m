Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D062C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 19:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjAGTj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjAGTjY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 14:39:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE2F40C1D
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 11:39:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso504161wmb.3
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 11:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHxC13MyFotC5MxLeE4I4+HCHPqO4Q1rk2RPC0DEs7o=;
        b=NNcCBTnfS/sfnMn7hlGVKR0a4S1wwV2+SRh1/u40mlKXIAqWvzLjSVIafP6I5OHE14
         85pABazT31xL5NyZpKfEDcFEw687cdOVo0IH/1+VvUyxuZf4aXZm9QzIaZKo5yEMM7ga
         D1J1wk0sZTNTtK8eJeRPj1+T8ecRzUBn2d7HST+IPPaWrSRdAkXfITeZaN/4XGb+8DsM
         MEgaGzvDxZyHCSpvI+uO8jhh9X18qYkkfsE9ZkjcX+5Gbt13CXWvFUqkklZcsojk9Yi4
         i8ICnNlU8XZO/DtV8NBQwuGBs1EIysZwf9ikhmMvnA3T9hzt9Gozn5ksjUWfGzkf5C77
         gK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHxC13MyFotC5MxLeE4I4+HCHPqO4Q1rk2RPC0DEs7o=;
        b=iDcVkwFfVYm9U+Y46OP7sDfjVCwZiVeG+egxmNKmhXE+e0oQ9D7NAOtSM9B4hSWkLG
         f5Bi3MyjT1JpIFx3jgFB5KfdFmlBYV8x5z7bN8r/B0wCrCQMPlW8M6WnIf3SafJc+Cmg
         YiRCvB3NKwcZSVuDRlzxdtzppoFubkRp2FAc8eY0qsom58Ggq3w9czt6HPEVQo0UDtNr
         sZiBGCieE4mTSXsol9/E2SiBCde9APujzz5B7j6TKww3gK0LkTR4LKFnOZWSsU54xp4r
         PuK5RluMeNN3GfSGpwEo6YpUAyR8UJhR5e6iSTSgOZ3sAAm09AS7vkG1yZiFVVLjzzMX
         wbyQ==
X-Gm-Message-State: AFqh2koL1i1EmsnY0cwTw/MJFHqPmswolnVIQr8KTeZYXQbj+5VeSJn8
        LMQ8EqNOwACqIN6ctz4/rqWFdvRomG4=
X-Google-Smtp-Source: AMrXdXsdnc9hnv4ChIgLe3fqzxaDKfIhc5opIUIPGBF+Zf+tfDnnnL+nCVGHQj1Robwu3e4XaGXGiQ==
X-Received: by 2002:a05:600c:4b0f:b0:3d2:2651:64bd with SMTP id i15-20020a05600c4b0f00b003d2265164bdmr42583508wmp.10.1673120362029;
        Sat, 07 Jan 2023 11:39:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003d358beab9dsm6076989wmb.47.2023.01.07.11.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:39:21 -0800 (PST)
Message-Id: <f25c71fd4c31b5c08974b275b3ab23b6c8048fce.1673120359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Jan 2023 19:39:16 +0000
Subject: [PATCH 2/5] git-reset.txt: mention 'ORIG_HEAD' in the Description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The fact that 'git reset' writes 'ORIG_HEAD' before changing HEAD is
mentioned in an example, but is missing from the 'Description' section.

Mention it in the discussion of the "'git reset' [<mode>] [<commit>]"
form of the command.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-reset.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 01cb4c9b9c5..79ad5643eed 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -49,7 +49,8 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 'git reset' [<mode>] [<commit>]::
 	This form resets the current branch head to `<commit>` and
 	possibly updates the index (resetting it to the tree of `<commit>`) and
-	the working tree depending on `<mode>`. If `<mode>` is omitted,
+	the working tree depending on `<mode>`. Before the operation, `ORIG_HEAD`
+	is set to the tip of the current branch. If `<mode>` is omitted,
 	defaults to `--mixed`. The `<mode>` must be one of the following:
 +
 --
-- 
gitgitgadget

