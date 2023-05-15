Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE2C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 12:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbjEOMNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 08:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbjEOMNk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 08:13:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE731730
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f4271185daso83881715e9.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684152796; x=1686744796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIPYq4PA1KX0c36qFM5WGLdC7UVemm99SyJXwA01oT0=;
        b=KxAZ7unPRDnDJV9VyjD7SQvmhs6z7bGGE5vIIc5jZIuggv5LgTWiWxl+jfP8IDQlIR
         UtP+B3qAKTND5YFbHXt52G005lZRdONOHQkxHdbOQHf5JZDSem6dG/yUMvjgJCWVJn+R
         qQxN05etx15LUR5gZNTxJiBLGu5M96EkETKJ9HlOrTdEPdp/hY5qFzqJYdMEC5CinAwL
         /3AXkVzuud6Nk8jn+1VBny0yF/Un6uIiTzut3ajaFwXE2cPzDqZ8K09kWIT+3wUFWVSs
         RU9e+iWKsYk064Z8IQhGzn/wX2uukhOdYCvog5xdZI2BqHjMf1K8/QXKiykGsqUSaXHk
         LcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152796; x=1686744796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIPYq4PA1KX0c36qFM5WGLdC7UVemm99SyJXwA01oT0=;
        b=NjTM4DKz69UfLhhNl1ZDED09qOGn88gzKNd7pWGv8gr9I+p8s/BnjxVGZiOL4mmqVz
         FRxBL5jMOfnq0J/Gy/MK5g6grmcaoKP4I02B81025U94xB4JBc4vRJBxlfq5/QpJklb1
         FCgtwPJTYl0kIbZxV2gzyxOW8TC7ZEj2cuy09SXUfiiDILsZMOL4Om8gFT1ROHSIYmRN
         vrYD7lEINwmK+5rDPsQ+CGKBsAy7TopRNSrFtQBnwwGVeQCRTw0yPMT1YfBAuXA9+P0t
         eGAyq7XT9sKskM1Sff0UEp6BqoXkdArRqsjdu82QpQ7g8ISLIlsarVFbkzNy4uvqyyDg
         nj2g==
X-Gm-Message-State: AC+VfDwBu3lvsvGeWN5aKJMxmx9Jb92hm3b9gBC8wdnmy8CuGT67C7jy
        wDB5bBQfNrUJ6/IG5hf3SmK6Z1CV/i8=
X-Google-Smtp-Source: ACHHUZ5DZv2SBsIhxDggzxdrABldbGUKfWpCY7yCFBTRXFIsbUDPHufGfQMFMnAm+pnTF/elOLlIDA==
X-Received: by 2002:a7b:c316:0:b0:3f1:93c2:4df7 with SMTP id k22-20020a7bc316000000b003f193c24df7mr23512096wmj.5.1684152796513;
        Mon, 15 May 2023 05:13:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b003f4e8530696sm13204280wml.46.2023.05.15.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:13:16 -0700 (PDT)
Message-Id: <8b644fb12038ccaf8967fb04d73c0fe94bd004bb.1684152793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:13:10 +0000
Subject: [PATCH v3 3/6] ls-remote doc: remove redundant --tags example
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

The --tags option is already demonstrated in the later example that
lists version-patterned tags. As it doesn't appear to add anything to
the documentation, it ought to be removed to keep the documentation
easier to read.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-ls-remote.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index ff3da547ddb..af71cf4a92d 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -100,13 +100,6 @@ EXAMPLES
 --------
 
 ----
-$ git ls-remote --tags .
-d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
-f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
-7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
-c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
-0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
-
 $ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc
 5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
 c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
-- 
gitgitgadget

