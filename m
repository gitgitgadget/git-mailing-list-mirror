Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463AEC77B7F
	for <git@archiver.kernel.org>; Fri, 19 May 2023 04:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjESESX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 00:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjESESH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 00:18:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E224010F0
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:17:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f42c865535so27627615e9.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684469878; x=1687061878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIPYq4PA1KX0c36qFM5WGLdC7UVemm99SyJXwA01oT0=;
        b=UWkkqokdTKjer5GWgcNenoHcbHAexf9/Adf3XDI+aY7Dq7zm4xlf2ch1/UUn0kcS16
         hg2tPsyoy2cMYlS3iwJaDXM10hFz0iEG0kSBqPIAnwFr9Gvyc+Q6r8j+C648F9X/cZBv
         sJRjx2h2puvoqtA9oUMWX7oOIeI13e5IRHigEq74mkBsdkfG4QNgENyyb84IZP7VKV9E
         KXViwUe1Yxk2WxFn0E0D01NnWrp25uR+ZIYteolm36xbdcJx/sE/1WHBPtCSh9+c+jo1
         YLEVBfxrYAUsGr2K8W5c3ZmGcXpeLiCMjUQdEHJdv+ZeszdiIMIk3J47lsK8zpGM/DKe
         zmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469878; x=1687061878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIPYq4PA1KX0c36qFM5WGLdC7UVemm99SyJXwA01oT0=;
        b=O7kLqlx/q1kELxPsQ5N4Owu+iu28h3fRmDNk6/CBgSo8VcmIhG2pv7Kj6RbHiMOwUt
         B563BtUKqsnQwWDu/Vjls8zzvcCVNQlpFB3c/j54p6CNs1p0J+nxBpSIPvWdzi9dR375
         +OjOkkiLHfc84xgWpcgWH8YQLS2iWQCUOW8yGDMBrbutqRvvn97QaHRl25Fm1MQoOMge
         q+PP72wBe3SKopmO/bEb2RGEJxk+FCcsd9annqThmMHi83OLNIdSLxiIfotUQ51Xkthf
         SQU6btbAXoauSD3gYmLg5uaFA6D9v/oGOlzKIhxjhaGEwGxm1qtOeHu4wk9afUlkA+pu
         PsBg==
X-Gm-Message-State: AC+VfDyzEu5Z6ru9HmZbhSOhhPglEv2zWyGN4VLgr2qvQTQoziHBuuam
        aR2CN3cObg2MZlwCte3iQHAPxtt6Kgw=
X-Google-Smtp-Source: ACHHUZ7/ZHlgdwaHsKX3N9J6JbPvQPwcrODki6TT531NXwArAvJ4xEeob4taSw/O9r6oZBM4s44t/g==
X-Received: by 2002:adf:fc85:0:b0:309:4165:f733 with SMTP id g5-20020adffc85000000b003094165f733mr549481wrr.17.1684469877935;
        Thu, 18 May 2023 21:17:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d5269000000b002fefe2edb72sm3923266wrc.17.2023.05.18.21.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:17:57 -0700 (PDT)
Message-Id: <cdd933e6fc3756194e8bf5aad36bca343e1096dd.1684469874.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
References: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 May 2023 04:17:51 +0000
Subject: [PATCH v4 3/6] ls-remote doc: remove redundant --tags example
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

