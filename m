Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A054C7EE24
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjEHR2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjEHR16 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:27:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391F5FEE
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso22879975e9.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566876; x=1686158876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClvK8BtvBIYgzKlMNMEQsfsEDf4ORu1leESkTTN86EI=;
        b=gczAP4y2fhGImE4nIQIY4aeU9rOfv9LulWiMjTe5DvBxjemHoTBDdtzojh9Z+eET9N
         M50FdMqlWz3awwcDENXgRDO6F31pXegQmc99dNUg11YJnVIuCT8NpHTKFm7hCSEa0YIW
         LUnc27Qu8tx6ySe2WGUczy8YILc5eATt8pIY9GqtQIRFnyOy6uhS1W5TOVQ/Zrs4LJBf
         /HnF1in323u9iQmCEjywMeWNXHkH29NKuJjvdBhRs38ZaHd7dEi/sl/Pu0v5gkP8eu2X
         OpyftZJ85n5o7DDbQCBRNtpJ9826Gw2gFtNqiCNtvZsLitlMNFi+APIrHN6QiPKG8Zi1
         yO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566876; x=1686158876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClvK8BtvBIYgzKlMNMEQsfsEDf4ORu1leESkTTN86EI=;
        b=I/bJJFlNgApoO1Rsp7J8bT21pH121G+tpSW2or6L/B8RJC+OrHQn2qugZP1Y/MMH6p
         2rSC+LazT6h1dsN4rDvQV0RlH5dZHG7qGnhrXGasR0qKkh6eGLsEnADZqkHZQmipsO/p
         rlWrSaYpYFZYSoduOo1ggDF30ac88FZARF8rZP3JfpdmvF/HMfqMh5YCWTIPU19thW/F
         tARfysBfslRZfD6RXH/4qOik9q9gEiy4gc3G+vFyviNVT2sVWeU9lcBqME7Jw217XrcI
         MTX4E2oF7oykOErCxg/M25mc6yRnPsDuE6lBDHcscJxkSLJwxCOpVe73OzykbnuuZddk
         qYBA==
X-Gm-Message-State: AC+VfDz1s4YCqV6HPxSP01aeaXApmUA8HKGG9wl3epmdJiOsjDwRmvGX
        ztuDm4zpb4ofqlLIa4EKQuGYDoMdgJk=
X-Google-Smtp-Source: ACHHUZ5OlFeAOIGUXql2wyKT+mk6Cu/vcaSg1UXRIfIRFJsFfDgYsTwvrBvx9d7z5W7UVK9hPHjaNw==
X-Received: by 2002:a1c:ed03:0:b0:3f3:468d:d00f with SMTP id l3-20020a1ced03000000b003f3468dd00fmr7306280wmh.20.1683566876590;
        Mon, 08 May 2023 10:27:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f33f8f0a05sm17487979wmi.9.2023.05.08.10.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:56 -0700 (PDT)
Message-Id: <ab11527ca58a7c3f0da657393088919acba78b00.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:46 +0000
Subject: [PATCH 07/11] doc: trailer: use angle brackets for <token> and
 <value>
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

We already use angle brackets elsewhere, so this makes things more
consistent.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index c4675d9d3bb..ac448fd732e 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -62,9 +62,9 @@ space or the end of the line). Such three minus signs start the patch
 part of the message. See also `--no-divider` below.
 
 When reading trailers, there can be no whitespace before or inside the
-token, but any number of regular space and tab characters are allowed
-between the token and the separator. There can be whitespaces before,
-inside or after the value. The value may be split over multiple lines
+<token>, but any number of regular space and tab characters are allowed
+between the <token> and the separator. There can be whitespaces before,
+inside or after the <value>. The <value> may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
 the "folding" in RFC 822.
 
-- 
gitgitgadget

