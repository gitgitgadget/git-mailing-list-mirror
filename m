Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165F2C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjEHR2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEHR15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:27:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAA05FCC
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315735514so178735755e9.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566875; x=1686158875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI0JwmXyecySSFZHMiWWb+1w73bvXr09fOJe/nA8TFc=;
        b=jTwHNz5e8z57+sedy9GPLoZeEcwtRK3hLjJeG4E52CFBvocDInd8s5k5XCylFATDDd
         PWGbKzE+lMPesUmFhzo9sBOTE47aLeW/PDXg28bEnlLJD3JkhRH3rbHkvC1oFA6pn5OD
         ZSAwB4iEmWz/yY2H1vUUrg7P/XSxKYFCvHxfkfPMlXGC0G0IAEROwgSmDpB758k8lulz
         eAt1uxN66XHA3r/u5aCdo/if+4iqD8+6as2JYkaCsISS+/F6fA9vKgzbln2BPLJwfpy9
         Vje5h1YhQbEXAcAdkRoBDylrjUog0xap8duBu10eamPomwhF2MbMHxrfR8FYWAQZRS9k
         MPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566875; x=1686158875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LI0JwmXyecySSFZHMiWWb+1w73bvXr09fOJe/nA8TFc=;
        b=GfV4It9hqgEmqZlXCR7VTK5FPDeQhG28wzMZqbhhyf1gZKXECyh4A887FDk5fdWO7O
         rG+n2DtSZCAnktz4Ps7M6S5jsYwUNmGi3eLh5Fk8lqWQrfpIgIHTh5+3nIxrkyuN8mPi
         7vePVrFSrnztvHjCcDswaq9c2N+JYKqAAWuYOpssVKtqoZl8NjHswWLfun9CWDDAH+sy
         l0MI87Q1XuV+f8Mt7dJiXmUxT/IVFD2qrw98xZdTZ7gWSIr3BF8SsbFaBhOcU0G/Ba5u
         wh1hhj/G1cYvF5+T+u79YvopKxYqxlHVW2jXIZ9zIyBk5dTmbHrZQ0hbgfOuz1fIthVI
         UG+A==
X-Gm-Message-State: AC+VfDyrZ5R7Oflnfqh7lBBgu6ZY4pARlfXK8FLoxMMzuEMxRbdseGw3
        odODNWUri/7ZuGscm1f+YPQZSoqOO08=
X-Google-Smtp-Source: ACHHUZ4X67zkOOEfY/Atp/0BgOLiTMt4IUzq8kmCam2W09ptNZyvIK/zpuLnndtLPZzEqtdBAAPEjg==
X-Received: by 2002:a7b:cbc1:0:b0:3f1:89de:7e51 with SMTP id n1-20020a7bcbc1000000b003f189de7e51mr7070192wmi.12.1683566875091;
        Mon, 08 May 2023 10:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b003f429d59e37sm304099wma.34.2023.05.08.10.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:54 -0700 (PDT)
Message-Id: <5bad365c78673d3f5b58e4cb3713a9bf718d1fb8.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:44 +0000
Subject: [PATCH 05/11] doc: trailer: remove redundant phrasing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The phrase "many rules" gets essentially repeated again with "many other
rules", so remove this repetition.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 7d6e250f37e..e80a9cd161b 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -68,9 +68,8 @@ inside or after the value. The value may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
 the "folding" in RFC 822.
 
-Note that 'trailers' do not follow and are not intended to follow many
-rules for RFC 822 headers. For example they do not follow
-the encoding rules and probably many other rules.
+Note that trailers do not follow (nor are they intended to follow) many of the
+rules for RFC 822 headers. For example they do not follow the encoding rule.
 
 OPTIONS
 -------
-- 
gitgitgadget

