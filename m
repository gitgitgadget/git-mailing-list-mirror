Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FCFC30654
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGCSqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjGCSqG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE46DE6A
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso5308065f8f.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409964; x=1691001964;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXzNT5uvQPO6s8OTfbn842wPgmRMCq3gZFwmNWgvqFA=;
        b=I0j4SqGXB9i/jNlYQcVtzkoOj+gmigKF8MRnS7snDRZVUGHFWLcCVAhHfgqhtMTLrt
         DTP6M4l+mffqVkqhnUlJaNyIgmidKIZw242VVSpBLo+lZoSHwOngwQk2uWhKM3aPjsjA
         RHvVHSkcs+d4soas8qQz8mAjvBznqwshwhQGEjCidmtZ7HBiSIElx9ut2wkDYLNUnzm0
         7vsjP6qNxDr84vx2ikkmTUAP5bJpajW1u3pIcKfR+rP+nXz9uZIYl+lbqrXIx0tsqIBu
         kz3J1cif8RywicOof7SkG89BxhooWDB2GgEGceHtLqvOolwNixPQIt6M720k3eqcVfjD
         V4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409964; x=1691001964;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXzNT5uvQPO6s8OTfbn842wPgmRMCq3gZFwmNWgvqFA=;
        b=IA5zcNx1GLLpcMsQ2h8WcHzft8gulXvFroqN9LR6eMVAtHw4nAr6yXY3yIy4Iqmcog
         VJejfyKZEWzon1O9B1y/r1bZXTS0xwZTIp3dNxDNXktEVRSwMhaNCPLCyNXEF5GiZoh6
         sj2hdujSXri7oxwOAySDhMamLnRsMmELmNe/0gjErJqxvZ/ziIJA8bqjKpc/IIDmwbMU
         /Hl1ldOK3dcygHgy7cRPayObIr5Av79ha1Vy4Zu92PhUoCq9u7bqORQ7aqqiZIt1tGc2
         APgi6I/8nHh4PUDCcMPkxtzci6+sx9bO8TB3lFieuw4YsCxmWw/02UOgdFfplwXuX9UT
         cWtQ==
X-Gm-Message-State: ABy/qLZGIsNF/07i5wRPW/REAjLRmRC0nO8RqDk/vG7NFKuHBmlGitj2
        G6+ciG5zLPB155qudeNq2SOOU0/xDks=
X-Google-Smtp-Source: APBJJlGIdhbawo0prXasdZxprxL2aT+llksbEQyQHj7q4QUUg+ou+PbdjiqdCvRNNoZCszJIlu7pBw==
X-Received: by 2002:adf:e9c2:0:b0:313:e9d7:108f with SMTP id l2-20020adfe9c2000000b00313e9d7108fmr8544113wrn.33.1688409963781;
        Mon, 03 Jul 2023 11:46:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdd4b000000b003143765e207sm3348256wrm.49.2023.07.03.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:02 -0700 (PDT)
Message-Id: <f4ec77c1586528dbe1a3197e38b2417a356c6759.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:50 +0000
Subject: [PATCH v2 02/10] gitk: use term "current branch" in gui
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom <jens@lidestrom.se>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jens Lidestrom <jens@lidestrom.se>

This is the term that is used in the official documentation. Instead of
"HEAD branch" which in not standard.

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 6d12e04ca64..fab21d8cfbc 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2693,7 +2693,7 @@ proc makewindow {} {
         {mc "Write commit to file" command writecommit}
         {mc "Create new branch" command mkbranch}
         {mc "Cherry-pick this commit" command cherrypick}
-        {mc "Reset HEAD branch to here" command resethead}
+        {mc "Reset current branch to here" command resethead}
         {mc "Mark this commit" command markhere}
         {mc "Return to mark" command gotomark}
         {mc "Find descendant of this and mark" command find_common_desc}
-- 
gitgitgadget

