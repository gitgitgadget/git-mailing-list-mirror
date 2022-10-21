Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFA9C4167D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJUPOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiJUPNx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:13:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADA2244729
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so5265731wms.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8nq8zpDnmWdA5GhrfzRibGRGzRLGdBhJfz5SbOmGdc=;
        b=osn/P6MQiFdJ/znUfOJ58jx2dU0QrApn14TUYqC2feVYGNaMPQbQWABL3ZBF3PUAnW
         oR4BTAjA9dFLwachJ/0YT7efX/U0VRpnVC4FZ1wV5S8UFo34H06dxvr/UJ4T8QukFtxa
         S/w6xIyXmK3nWbV5h7YMYMFvvGNkdeiZPcyraWeOECFQzGM4ud8psDWr4f3mxT0hw148
         ZiSOcjwjFSqpq9urooatvM9H8PjD0i/iNPFigg32jS5kDnmmshHqDPf9nqx21L1BXSrq
         ASusjwACj0dZ4hESH3OybCCvG0tjVMM8UhbfQmmTAHJqZgLN3/DzQmXvFGboBF51OAx8
         gS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8nq8zpDnmWdA5GhrfzRibGRGzRLGdBhJfz5SbOmGdc=;
        b=VcrpjYp/QSfZEeqJdcUGflhEXnRUygSZ3TRfS2fmzwlNvgoMsYNNRhQI/StlhErp1Y
         xal16iDTXOQzKqgu9VcrFeyvsnQV1XpTrXEKbCv7TWvU4g7h6ltayt0eZs0rLRPwUMXj
         gt5Yutr1LHrlQILT5Cq6nKRJUkziMTpbMKdA/zKU1chxoCfhNg6cStNPB2kTA31UnYxL
         0NDptAnuHhjSDSDjUpPzEB450PQSJiVRWy+8agL4yXcPRIM1IeBitLBzpkFe9RVNM4S8
         y9caWAaajJOVPalz2EDtAUyO85k/ggGyI9SQt9wesq7Zc8KpDBiZpiaPUTAyJu4U1eq7
         /lOA==
X-Gm-Message-State: ACrzQf2Xqu9B6Qu3yb2Cl6kvWaIO1OiMLCtWDSyy7Nq2FcPYyZhmK/LR
        vnQGEw6rlkxPkdDAsgtCueBx+94bRUU=
X-Google-Smtp-Source: AMsMyM5ZuavNa0sh6vSjU33KuQHJudFxiwoJ1VHJ9g+8/xEkEYujEWHAUm8TXfQauZ9l8KUkpp0ITA==
X-Received: by 2002:a05:600c:a08:b0:3bc:eb4c:b90 with SMTP id z8-20020a05600c0a0800b003bceb4c0b90mr13615489wmp.184.1666365230199;
        Fri, 21 Oct 2022 08:13:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b0022ca921dc67sm18678918wra.88.2022.10.21.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:49 -0700 (PDT)
Message-Id: <200f7341c91df2cd616cbc4bdcd8025bed3af7ea.1666365220.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:35 +0000
Subject: [PATCH 5/9] subtree: define a variable before its first use in
 'find_latest_squash'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The function 'find_latest_squash' takes a single argument, 'dir', but a
debug statement uses this variable before it takes its value from $1.

This statement thus gets the value of 'dir' from the calling function,
which currently is the same as the 'dir' argument, so it works but it
is confusing.

Move the definition of 'dir' before its first use.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 89f1eb756f0..d91a9679075 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -374,10 +374,10 @@ try_remove_previous () {
 # Usage: find_latest_squash DIR
 find_latest_squash () {
 	assert test $# = 1
+	dir="$1"
 	debug "Looking for latest squash ($dir)..."
 	local indent=$(($indent + 1))
 
-	dir="$1"
 	sq=
 	main=
 	sub=
-- 
gitgitgadget

