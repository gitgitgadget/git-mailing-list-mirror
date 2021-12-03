Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DEAC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 03:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378361AbhLCDwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 22:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378323AbhLCDwA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 22:52:00 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8350FC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 19:48:37 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id b187so2115870iof.11
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 19:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnA9ZtqenEmyIgN/ZJhLhCHOLPyCaRmkQ+sGVgq2AZs=;
        b=Gx8f2aDCuvBO7hVadg4I3n8Wjw8dGzY7N95DFa5Tk6C3w8OYkMkSjOF4rYjEWB04Wz
         YZaPnwBZJCDeiaXnB18mywfDx556TipJFsStmHcKUADd6FxbcaKl8CkFiWgskeuvOX91
         ee8gsLCJ5BjHm/DARGTtWwhK3CbphWzyTOzHfTK1wyMu7e6RCbNKtxe86f2iN48piVGr
         JEbDNoCepzcoeDJPqeotk1IWGQljS6i0vXYc/N58hwBGHV4vwFVx2j62kLwiF4eOzi4l
         vjQHq2yhR/sPdMYRDMUceBb4rG4JpSSwRIS21zce7IZDkiwd9oqhodddod8vYc8DcJej
         A9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xnA9ZtqenEmyIgN/ZJhLhCHOLPyCaRmkQ+sGVgq2AZs=;
        b=zqRw86APPpT4xF/xuUO4ev+Ij4AtacIxYUPzusi1KGzGeRmSfpUcJbSKLE8/LyY/zp
         r/oHp6lRxP2lpzkOrxUM9wTUxxojQCWQiQ/iXPGj5WMSQXn/hEK/WfgEtiaeBEl1nGZX
         A+MZPpurXtqlOUf3ZnwjTaPUOz06rK5PuJFhVJYBNLBYoiNnjSuXhoOvTeAWj22lBaQx
         fEf3/sXwz94wtSlLvScWgt472QGcGN8jc1S/1kG10qy6LTdy7eFMcqT9kZC7PRriWdzo
         Mp+r4wjuqvSf5LVYbwpx1Rvs3O59JmPgFjtX3z/z09YE7CqfBXWoa3AaVUBL26HAEyRb
         c7Qg==
X-Gm-Message-State: AOAM532JuRZfw6vAKPz6xbhieNja2q7WR6WRTt8REtl35JcyhgIau+bY
        I5w0d5XaBQvk9OwNLDHQKmnIMgGWgaU64Q==
X-Google-Smtp-Source: ABdhPJyYGQyXTIT+pYkwI63txg7GmYSuMaXnr9d14531SWyMGIGVJlj51wRLDUxuhfwXhhQRNxog8w==
X-Received: by 2002:a5d:9492:: with SMTP id v18mr17573431ioj.158.1638503316751;
        Thu, 02 Dec 2021 19:48:36 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id x2sm975639ilv.65.2021.12.02.19.48.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 19:48:36 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for `worktree list`
Date:   Thu,  2 Dec 2021 22:44:20 -0500
Message-Id: <20211203034420.47447-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0
In-Reply-To: <20211203034420.47447-1-sunshine@sunshineco.com>
References: <20211203034420.47447-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When verbose mode was added to `git worktree list` by 076b444a62
(worktree: teach `list` verbose mode, 2021-01-27), although the
documentation was updated to reflect the new functionality, the
synopsis was overlooked. Correct this minor oversight.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 8a7cbdd19c..9e862fbcf7 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
-'git worktree list' [--porcelain]
+'git worktree list' [-v | --porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
-- 
2.34.1.173.g76aa8bc2d0

