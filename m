Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C4C761A6
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 04:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDCEKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 00:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjDCEJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 00:09:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF487B75D
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 21:09:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id ja10so26763544plb.5
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 21:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680494984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sABgSt4mReQDUcFhh/CJVO0TxXLEN9xio8nVxOJf3Ro=;
        b=G3zb5GzIgOJwhx94GBg6bGxFL/qPa7dwF3lnUlS72cO+JTOYKCHKNJ3fPflHF5OeQg
         pqKD2+JtnytvicVLGjSG8Xk9M5fNKf9cxSua6OlaD1BXWmQ0bVelN0vmeu7ObDylzhzz
         viv1S7qOHZsCraI9Gx/FMXnwdF8NgX+YqRfRrikise64KuseLV//qpz4w58QCU5pt1c0
         PDdflBgAuyLXeFm5Hf5wltkW8YFtuIq2Dd8JcRUZ9vLaxGz7u9sy4L9JqAS8arXd2Vwk
         S9zihNi3BQvR3/L6/VX0EWR/VGkTbeqHHdgHUui9mpuOC9L+7opo82EQAPP7rOwSIRI8
         HkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680494984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sABgSt4mReQDUcFhh/CJVO0TxXLEN9xio8nVxOJf3Ro=;
        b=yG7mxyFgS3kHTqgtBfxJvtv/DoDrHwvV0qi8CVtrlbGCWUvUnDWcy+uflaERyWm577
         mx5nTAvZUMxcxGKUq9gxm0u7yaWrrgclco3ApLAjQMMwDbWz6GSazZGtCZqng9YU5sLa
         NcWNLGo5TujV3yLGFYiDozVIQILf+nkc5wyFUb+6GUaUMQVIXgv6Ql5kXc0QE4ojG9W8
         62r4FzsJ/ku7KjRPOrT4Rv0EMUTwQgwtfPh/XaH7yxDUDzZCI2DjWPFoUA6ouOQAsEeM
         CDeHaIrrRYUxCECs28+9a8z6TkyC+oGvaKD8OfVODwNF9l8TH/s27lVLNOZRdvRAgDAi
         YFUw==
X-Gm-Message-State: AAQBX9cvdsFSLqwxjnYBvf8tZiOUDkaXC0OueXboDhS79ewxr39JQwLV
        lS70SltRqa1D9sWQdbrYWBU2khaTU7s=
X-Google-Smtp-Source: AKy350a9pey5fSlrkpVCw5U4yvp6f0EiYQ8iH+Pn5M3+4vR4JOL9txF0IyL5HECRnQkoEbpeszLoiA==
X-Received: by 2002:a17:902:da90:b0:1a2:8c7e:f310 with SMTP id j16-20020a170902da9000b001a28c7ef310mr17266774plx.35.1680494984125;
        Sun, 02 Apr 2023 21:09:44 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902694b00b001a076568da9sm5456313plt.216.2023.04.02.21.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:09:43 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, phillip.wood123@gmail.com, chooglen@google.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] format-patch: correct documentation of --thread without an argument
Date:   Sun,  2 Apr 2023 22:07:24 -0600
Message-Id: <20230403040724.642513-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git, almost all command line flags unconditionally override the
corresponding config option.[1] Add a test to confirm that this is the
case for `git format-patch --thread`.

[1] https://lore.kernel.org/git/CAMMLpeS3+NUQa2oqpHKVo3yWQNVMgkEXrs4U5_ggvk31yQbezQ@mail.gmail.com/

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-format-patch.txt | 3 +--
 t/t4014-format-patch.sh            | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index dfcc7da4c2..ed299e077d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -173,8 +173,7 @@ series, where the head is chosen from the cover letter, the
 threading makes every mail a reply to the previous one.
 +
 The default is `--no-thread`, unless the `format.thread` configuration
-is set.  If `--thread` is specified without a style, it defaults to the
-style specified by `format.thread` if any, or else `shallow`.
+is set.  `--thread` without an argument is equivalent to `--thread=shallow`.
 +
 Beware that the default for 'git send-email' is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 8c3d06622a..b27a72f78a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -470,6 +470,11 @@ test_expect_success 'thread' '
 	check_threading expect.thread --thread main
 '
 
+test_expect_success '--thread overrides format.thread=deep' '
+	test_config format.thread deep &&
+	check_threading expect.thread --thread main
+'
+
 cat >expect.in-reply-to <<EOF
 ---
 Message-Id: <0>
-- 
2.40.0

