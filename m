Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7060EEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjFZQZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjFZQZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73CC198A
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4739538e87.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796703; x=1690388703;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C4+Z+JYxHOHgPNO9HRTisJPCa1ZLhtMUtS+8PzVvZc=;
        b=XUM16RlF+lhU8hccbszBBhgNfurETnFjvCnXeAiW+HEh9e7j4JoYDtmFkOhtWN4ACZ
         oD1u2eYPPHHx4kYbcG2Pmh3pfyHmucrGVOJfKQOn4aanRdU3MsSYnCgEj893W0oZEdma
         p23GcgrYoa94DxPn5oqR0bXP97ilzsttDrf7VH3N4Mtsq/28QaXRL/L5koSWFOBE6EKF
         CxpHBfthUni06/LXcZ7nC46n8DZM75ezT5R5Ktmoxa3nzK/GBbaj0l/pHJf7k0TLLu2L
         H0XFtLnysQpfJvq+mVVHEbg5shhIfdgdHwXWNmtGBSHfz1DjkEyH+Xhxrci7Y3JtO4Jk
         o4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796703; x=1690388703;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C4+Z+JYxHOHgPNO9HRTisJPCa1ZLhtMUtS+8PzVvZc=;
        b=QEefWsg1rTrccZqrzdVb9cxT/JEN89WwiWYy9DNnBm0TuPqKHP7j08gXxivl8tzvB9
         /VKvqQw/QOJjA9T8UlVaUVI8cJatQLy6FsiPHvhVJ10OAYyOhHQCxx89yWwI7magpN+Y
         SN03jtnA0n5qu3WsZ/m23GIdfj3q90MuQM+iEq+5P0CiHWkyS9aTRKhD+zPlUvxAxazQ
         UeuFnqghFbftgPFIn/WxnGP9luqCNqIzpOe/NhUSN8ryvJKrfaF/MyRODPc7pa8UfGxx
         QT2d5ITkzmO3MjADJk8AFWH2l8HZGggH2+ab09EXyv4F3GtISaamhfyY7jcIk8OeZZDY
         a9NA==
X-Gm-Message-State: AC+VfDyCEf9DurrIHqxzv5nboTbk1VZd9Dv8jNMeYBLAg6Opq4wuaboq
        pQXaFWeITnPSMy1o2Xd2V+TQHGUu3LY=
X-Google-Smtp-Source: ACHHUZ5NdJ4+hgEA9kc1aWUutVkZ3b2CSfNznjncL0QcVpVWYDLUdwrrv4GW8KwIalQUqRmJ9vkUdw==
X-Received: by 2002:a19:5f1c:0:b0:4f4:d83e:4141 with SMTP id t28-20020a195f1c000000b004f4d83e4141mr16170579lfb.50.1687796703128;
        Mon, 26 Jun 2023 09:25:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l25-20020a1c7919000000b003f9b29ba838sm8146768wme.35.2023.06.26.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:02 -0700 (PDT)
Message-Id: <0f16a466fd9bdafe0365ee9cf1bce81fc11767d1.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:40 +0000
Subject: [PATCH v3 16/24] completion: complete --no-stat
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
index f4e773cb997..ec2e4c9e711 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1758,7 +1758,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
-			--irreversible-delete --line-prefix
+			--irreversible-delete --line-prefix --no-stat
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

