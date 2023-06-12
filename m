Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFE3C7EE45
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjFLMxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjFLMxP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C110F7
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:52:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30fba11b1ceso1528921f8f.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574377; x=1689166377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGhLXXBoQ6UI1vHMOyV7YwVlIGSV+5Rfv8inY3ASxdE=;
        b=K4rHEZw/UyCV2MYbLK+84cL+nlciA+1dHQs/NVxs0PtHDUBIIW1Y9E2l485ctV5+Xo
         N/wZCeFQb1dYMpdfZGnSdOGYzUS/K8yh5abBte6ENf0snuD7B6qHAa1Gn3TZOsZkUSoA
         Tuk3MiaFs9+j4rDJuke8bDzE2q1GmhtfF/PL1yYB1lO4tX5NVZoeWfTTXz2pxrokWIZd
         7s9KOUnAVhImYECu9LLGLonQIFlu/6Eeu0MFj0xyThWe82s3UxKj4mPzSuQr424KQlcM
         WFqpRt+4/viwwvH7H3UhUTckUR8gKTeSR2d7RsrBiiDHcw6TQeZSouMBayvnAmLQYLpJ
         0Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574377; x=1689166377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGhLXXBoQ6UI1vHMOyV7YwVlIGSV+5Rfv8inY3ASxdE=;
        b=M/sIVba0+fgMm/SfKMVLyQpoH14TdNc6XXsN53O6c7148ihZtxaX4dsDYIb57y3937
         r8wmr/lQuzr+48fbcHatOm79xocufaRPaArSEz6J0zc1I7Z6rrrlUebSbTfQR79APeBB
         JoAdEzoEFy/V0Gx/Dm19zyCq9g59nZ6cV+h/W9zYypU7kVG9NdSzNlWhC6gqHfEI4oid
         eBL+7diObGouX8AzJqtoSmWDzLf1vx7gavOaGTNHe6gk08F/cNHRSP1k5behEzND7hAc
         NrbqwvVgAEj7+tWFuNnl+zn87oQdXOYuzy/8nk9yf5I6TcQ3ZY4HSSRRzydz0cg71FmQ
         Jxig==
X-Gm-Message-State: AC+VfDziFNEfWZtqeqjH4Qm19WCI3gh0vdQnj1UW5fT6DZuiSWhdp/Zz
        eUM7eempOZNWmD4obApCS88TPt0ktrg=
X-Google-Smtp-Source: ACHHUZ4LZUb/U+NxRdK/GyBBqAXtd4pElxin0Tm8j0AV3UXAQgBOW9ptLs98CPPQ1h6ZQZ/iQNkt2w==
X-Received: by 2002:a5d:594b:0:b0:30e:59a2:3d70 with SMTP id e11-20020a5d594b000000b0030e59a23d70mr5416980wri.43.1686574377123;
        Mon, 12 Jun 2023 05:52:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cs6-20020a056000088600b0030ae849c70csm12454611wrb.37.2023.06.12.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:52:56 -0700 (PDT)
Message-Id: <1f3c9e8d417d2c9f16583da7609e8f322059f1f1.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:30 +0000
Subject: [PATCH v2 02/25] completion: complete --break-rewrites
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 90fe292459b..f07b00b9c68 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1753,7 +1753,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--diff-algorithm=
 			--submodule --submodule= --ignore-submodules
 			--indent-heuristic --no-indent-heuristic
-			--textconv --no-textconv
+			--textconv --no-textconv --break-rewrites
 			--patch --no-patch
 			--anchored=
 "
-- 
gitgitgadget

