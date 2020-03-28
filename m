Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927E8C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 15:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6615620748
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 15:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4fSE9GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgC1PTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 11:19:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34078 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgC1PTR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 11:19:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id i24so15243269eds.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XPNZKkOb5pkruHszKnNO/lWXKH6a+K/i/4aItYFNWG8=;
        b=t4fSE9GWQO2D+77znt24ZLn7M4PaonX0gu65L2HjGNx55bkNA54haNyuntVOOmPdeq
         7PlVZDxB3hTPNGGkC+OEbhUmIfzklt6BnXHzb6ujAlEmRt/0cg3ktNOUndsctObuN3SZ
         Fpx8SWrlb+RiS9gQNJ6ezdd8m+SgHqzbPYj5BjrRbFjvtpf1DlQGUTlT4YreO2WwRhEs
         fr6kEmubUEMUhuF9PM+VT1cZURXRwPfWlpIpgvzTOgCCUA8ISPYR/gnlNABfTPux4Spt
         KT9aMHC4r71nFmk/H1wYXIlzVRfEUrDDQn6Z0Ql0IWW+kXHNXri3StsW2iwD9LK3syxO
         +zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XPNZKkOb5pkruHszKnNO/lWXKH6a+K/i/4aItYFNWG8=;
        b=cJxAzJDOOmy2Z7eW1IbqLOmHa3ok4LJxSjg0fZ8aDlCIuH1MMES5gJ8koe/nyUbHNU
         3LaGMO+4D+c0cEZ7ihXSIpymVKjpPAjwGfSHVeXZY0btmtG9sP4uTdX66A8y+OqkU69f
         KrZIKguN46oHB8PtFVRr+ypJD7jA3VEvdbSTWObRP2I/hs0SoCwnYJr859AXa1fNZ9kw
         GhwYiDjayl4gGxVkKoC+TGzd7vH9L5qnarxpirSIrul1D77FUd9WSf+zXqaWFtchg7Ow
         6OvYsBu8az2X0c158wSYBisuqqp3r32Bef4Xna6B4DQNge/NmX3faRVkKr2Go6SyZQce
         lBtA==
X-Gm-Message-State: ANhLgQ19x2L9+1K3wGLVqRkPB6DWh1dxUMZT1OMY7ZfGsw1YNE7uSqOk
        D73ZRtDeP2dr9pEz1gzAfRTLUj0p
X-Google-Smtp-Source: ADFU+vsI6KzWX4Rw0oKe7fDIVU6FKS/rueeqlJ8plAokdsy0NSbytfEAFEmH33dPvWQfoyZ5uoUArg==
X-Received: by 2002:a17:906:3003:: with SMTP id 3mr4064148ejz.21.1585408754388;
        Sat, 28 Mar 2020 08:19:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm1212296edw.51.2020.03.28.08.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 08:19:13 -0700 (PDT)
Message-Id: <pull.589.git.1585408753519.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Mar 2020 15:19:13 +0000
Subject: [PATCH] MyFirstObjectWalk: remove unnecessary conditional statement
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the given example, `commit` cannot be `NULL` (because this is the
loop condition: if it was `NULL`, the loop body would not be entered at
all). It took this developer a moment or two to see that this is
therefore dead code.

Let's remove it, to avoid puzzling future readers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    MyFirstObjectWalk: remove unnecessary conditional statement
    
    Our introductory documentation made me scratch my head because our
    example contains dead code. I'd like to remove it lest we confuse future
    contributors.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-589%2Fdscho%2Fgit-walken-head-scratcher-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-589/dscho/git-walken-head-scratcher-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/589

 Documentation/MyFirstObjectWalk.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index aa828dfdc44..c3f2d1a831e 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -357,9 +357,6 @@ static void walken_commit_walk(struct rev_info *rev)
 	...
 
 	while ((commit = get_revision(rev))) {
-		if (!commit)
-			continue;
-
 		strbuf_reset(&prettybuf);
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &prettybuf);
 		puts(prettybuf.buf);

base-commit: 3bab5d56259722843359702bc27111475437ad2a
-- 
gitgitgadget
