Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842EBC35242
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5773120725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlLxjSlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgBQExM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:53:12 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38930 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgBQExL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 23:53:11 -0500
Received: by mail-wr1-f45.google.com with SMTP id y11so17967540wrt.6
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 20:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aEkIEkwcD6BlECel7broWtl05by19Dvm49kA57KiyGc=;
        b=rlLxjSlKp8huRSlzD2BYqob/+Mq3dGtoJYyo+CXn8FgJfbS8s390cgh4YF1XLSYLs0
         yCIrp1+0aJ9ExZ/hTxU1oZCv1ar8QjGkRQ5mQWjFcMd11kVc5A/1WBdykLJYhe2oiAoc
         0BeVqosLVYMSoVelv+/G7tH+TTavsH6BOs/dWLS1khYFnoXNsnXrNaw6IS7/8kyGWwj7
         gXRnJeH9b47/2Nxo9SHPRfT1uxUyJkEe6K2GUoFCRL6gNDPTEVjOhaYaMAG0zEWSTjse
         9jLhaWajsp9b+/NFwE9XiAUc11LfR/yl7xVHTCo+wl0+vrrc6bCB3ZRnU6OdcM3z401t
         +41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aEkIEkwcD6BlECel7broWtl05by19Dvm49kA57KiyGc=;
        b=olknLuy/fVPwnc6l2T0Yg8KU+m4WFa0TcENixWe929VZfL+WfOxm5UMaiDOyVe6bBV
         1BCFbYgy8/LfoNFjlUOzAwutm6uADRrPGxL6a1ob2cYoYbBBd04TizVhU/3SX/RL5x+n
         x+x5zXkS4+tiuHodpnrGQRBdU5p7rGUZb4970uJ3PmEICaaTF8ubrnQBDC0rqHgDYDvI
         AM+64YB+vwrsDuI0Oiy669QY/hx136KtGku/nxYFGiwNxNYLiIGMXR0YazyQcDoumHgY
         vacLqQWET+4ZTRffjOhRy4pRj/tQTzEwmR7iJDtqDKVQwX+abLyIBciNnFrIEnN2Tfe/
         xmeA==
X-Gm-Message-State: APjAAAUFlNcdKM37uRxpndbbs+qSHsNfZAyoqNzFbsBRTNuzG90EdMUv
        i/2udYK/BleJ3Kou3bM15Hm2137W
X-Google-Smtp-Source: APXvYqx8aG3KHPzFlBi+mXFFfZu3iuc+f5AdKPIzjWwaLR4w0b3jvl9wdmnWzqXW100WlTwLaRajcw==
X-Received: by 2002:adf:e906:: with SMTP id f6mr19319500wrm.258.1581915188023;
        Sun, 16 Feb 2020 20:53:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13sm19437045wmd.21.2020.02.16.20.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 20:53:07 -0800 (PST)
Message-Id: <5a271857a1176ede2ac9c894dcb436758e28a79f.1581915186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.555.git.1581915186.gitgitgadget@gmail.com>
References: <pull.555.git.1581915186.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 04:53:01 +0000
Subject: [PATCH 1/6] t7112: remove mention of
 KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The known failure mode KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED was
removed from lib-submodule-update.sh in 218c883783 (submodule: properly
recurse for read-tree and checkout, 2017-05-02) but at that time this
change was not ported over to topic sb/reset-recurse-submodules, such
that when this topic was merged in 5f074ca7e8 (Merge branch
'sb/reset-recurse-submodules', 2017-05-29), t7112-reset-submodules.sh
kept a mention of this removed failure mode.

Remove it now, as it does not mean anything anymore.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t7112-reset-submodule.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index a1cb9ff858e..67346424a53 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -5,7 +5,6 @@ test_description='reset can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
-- 
gitgitgadget

