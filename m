Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF3BC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjEHR16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjEHR1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:27:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1345FCC
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso22879395e9.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566872; x=1686158872;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Jqn/9IBQlxbkcFDFbbYMKi20gslE2mM16gToC7N0F0=;
        b=N7u1ANPi8O3s4sD8iqicPUlalStoG36MMAaDM95N5mS1R/E2mwZPtiHWlps+90SzWW
         +57/1RZvssWV63vPrMWyCQzZGIABcoXy4AwKi1pLhGe+ysygC7XIf5RFdN6sfeRL6kpJ
         g2Q+1mguuKuAnvZnHzhuagop5o89oyFyIhHCt8XI4/GHTYIfg78E7rJ1nuEOAAZ1e4/j
         us8LYYF8APKjyQtlN50gCqgORdSdt6s4EAsvEOuJQDL8tWBdsm+omFp8qaldgn4SQYFH
         jJKvjbNTt1/sOVrDHCzyAyyJjhUXHrCcRhTnqNWAvnHoseIu1FDW2cRBlLwJa9kYZS37
         RNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566872; x=1686158872;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Jqn/9IBQlxbkcFDFbbYMKi20gslE2mM16gToC7N0F0=;
        b=JCpF56Lm73X5PxVKbgVTaFtWTq0G7mwqtXQIYyjAr/h6x/H0DFa371HxUxWVkNoewI
         RbrjdJunkjoOx+WVuNpfUbOd56YUbRrKwhmIYlwCVc77Y69nj1snURdRRM/QTN2/45tt
         348xSwdoREZgIAfcxXJxgxyKVGHKDrDKi0hTh56KNmmiYmh/kixjGoki3FwE4TIUAif0
         X2oQnAxvJzjdtonRjM0H0RkVBTDYx4gMxWicbyb7/B34hNWA2k6lSdIcWC2KyvIx1L2p
         EPxQ/xwPW+u1R9g1e+Vk11QgGVEeuJF2K0L8Rd4NZtA/6ut051Bn+u4JkVEvj3ckf1cn
         zlTg==
X-Gm-Message-State: AC+VfDz54321jlXVnJNR5+HUssnz/HknH8oR1yVe6dTLoUwBuodGRiiG
        H0amgt0shjiCNwsVj+PT4vf9PJ4ntwc=
X-Google-Smtp-Source: ACHHUZ4aV85TqS9FIx3RP42aDuFnwXiq7VHMD9zvp33oKxBuc1gmpGxpul0mlKLLNF4GNR8gvGnRCw==
X-Received: by 2002:a05:600c:ac6:b0:3f4:2770:f7e9 with SMTP id c6-20020a05600c0ac600b003f42770f7e9mr1714949wmr.17.1683566871945;
        Mon, 08 May 2023 10:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9-20020adfe5c9000000b0030632110586sm12140532wrn.3.2023.05.08.10.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:51 -0700 (PDT)
Message-Id: <12d4850a9ab8659c40fcb6470caf8f98d7f6e486.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:40 +0000
Subject: [PATCH 01/11] doc: trailer: fix grammar
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

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 22ff3a603e0..e695977fbfa 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Help parsing or adding 'trailers' lines, that look similar to RFC 822 e-mail
+Parse or add 'trailer' lines, that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
-- 
gitgitgadget

