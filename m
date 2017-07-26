Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504E72047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdGZXaI (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:30:08 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33687 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdGZXaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 19:30:07 -0400
Received: by mail-pf0-f181.google.com with SMTP id d67so8502527pfc.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WqpEQ9Dl8wgY/oojrgGoxWoR8FaXAGQv1qhA+zSUbd4=;
        b=YBTcrskcXio9DU4CXOFoPj5HPSnirMDtkOj2xZMZfuSRzAshp2ABrnAmyz8beSPbmj
         72niX/GAv50eStf5Lf+w0ZDvCfoFCEDrQYEKWtj+BOMmdVegWR4pOBz164lH+457U3xb
         HwxQBsCQ4lHojS92gbqfGNYc8U3MlubwgAhGN8HRcT/MiuZzq3evciYRtuus/YjYLUVG
         R+4LwMDl3eEKKpqe1nfwGagaOKSFH0MRvcZ8XMbaR06wSosaTUeWBbMfJ1UoqvDVz2T2
         uoKRyor1i+b6JUou6hjh9oGnoMhYoiVfs4k94SVaEdwCgMVnclcYzHkZDBKjsULkw2V5
         W/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WqpEQ9Dl8wgY/oojrgGoxWoR8FaXAGQv1qhA+zSUbd4=;
        b=Hp2IWHl7XNHJD+38N3gMDCyHGvnoMEapDuaIyclH2kTdMsSNuV8MSbNFEmfxbKWfkt
         WKj2l4bmE1hJLU/wBaaRSJgkLdC4oiENOQzuxxuDr3SkjncT+jHe7hukRRD42HQtmBvV
         ipLfM19buyhGbLLlD3yzExeZjBAsM0kJN5nURNb02U2I5d7TMX5yfSLFWGf43Y/OUqxL
         sY39/r4MTOVD9P0Lyu6Ao0cibFU6UphLZ/kAue4g41NxfMDx/RUWIxFAN3CNxE3cdF51
         nknRmGJzVzCNOpa6XyyYyxBogBePQUUvz8Fvpx0Z2aon0HfP5pkhtRWycWcGIGq86wJB
         yW6A==
X-Gm-Message-State: AIVw113vGduwUrQI4y6F1Ns6r3fm0pN3BK4hPtSJdjr7dYXrNEFMy/YK
        WIF6Y8pp8LyOrIC7DeMv8w==
X-Received: by 10.99.36.70 with SMTP id k67mr2259905pgk.326.1501111805770;
        Wed, 26 Jul 2017 16:30:05 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e131sm299668pfc.93.2017.07.26.16.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 16:30:04 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [RFC PATCH 0/4] Some patches for fsck for missing objects
Date:   Wed, 26 Jul 2017 16:29:58 -0700
Message-Id: <cover.1501111615.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an updated version of my previous patch [1], but without the
list of promises. It is somewhat different now because fsck cannot just
mark all promised objects as HAS_OBJ.

This could be adapted and incorporated into patch sets that have objects
missing from the local repo.

I split this up into 4 patches so that you can see how the changes in
fsck are being tested, but eventually these should probably be combined
into 1 patch.

[1] https://public-inbox.org/git/3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com/

Jonathan Tan (4):
  environment, fsck: introduce lazyobject extension
  fsck: support refs pointing to lazy objects
  fsck: support referenced lazy objects
  fsck: support lazy objects as CLI argument

 Documentation/technical/repository-version.txt |  7 ++
 builtin/fsck.c                                 | 23 ++++++-
 cache.h                                        |  2 +
 environment.c                                  |  1 +
 setup.c                                        |  7 +-
 t/t0410-lazy-object.sh                         | 95 ++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100755 t/t0410-lazy-object.sh

-- 
2.14.0.rc0.400.g1c36432dff-goog

