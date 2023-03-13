Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF0C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 05:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCMFBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 01:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCMFBp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 01:01:45 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37466474D7
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 22:01:36 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id q15so8553651oiw.11
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 22:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678683695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1NVI54LEGUqtwT1VVrLDv5F6l6P2pXFua8SpPp4unI=;
        b=G5YH5i4lGhbyYq9U/PT19+xf5fc80l5qnh4y8EytIA0o620I1wS6qQLVOWMSUs4jj3
         IMP5ENDa2eoqQLB3TcDaD16rEOfOB/ND6w00ufWRC4IRqHG9qkeuPXYMQHd1jyinKGFH
         +p4uleg6elYL7iSZxFXk1xjSYLWxXLP5qK+lSlLAGtQ5OpgFxRwNHrwx1+OH9sV2XtHY
         SBosoMLJodVwZflfU3Wvh6PabcU1DP2aymZr7zlkGcTVo651R/4xqUEm2WvfBvrqurk7
         d5d02BdZinJLNtpvKBVPmJR5JXXVPxOYsyvPwNu/oJFYu1WNlzZpAKZ95Tzlo+B/oTey
         EvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678683695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1NVI54LEGUqtwT1VVrLDv5F6l6P2pXFua8SpPp4unI=;
        b=dcwp/K3T0ON+Cu7xzTX+uhXiyIPTi06A2BZLFt5dbnkJ7oXj2bKkMVL0WwgVQp/HAF
         NtcUpdGichkaXXHJ44VJg0qPhJJpU2Rv1eankW8j+ny7RlKJ8lr9PJe3o5FmrAK6SrGs
         FZEn0HIMXdL71vU+mIPP8gvlazerOmqMrMYjjSk7wNFM5xoLON62sGva22oTk4AU/bxh
         EOg6Msb72kMO4fABNGQVK73YOTFRvhtir+Y0bUKoQq3/MR7ezZfo+eJPBYxM53KH1iye
         JfwCW+7cS10fCFs+u9t96Y9Z3iIdEUIsGUMw6YL6+iZq+p5QCxd5OSzfxAOwRu4ZJ/Pj
         jfOA==
X-Gm-Message-State: AO0yUKVlEL6xTcJxoxQMmjdzZ3zQXOd99xbaFfgkXbJPuhqdL+bY1G/Z
        VKX3ikPMv8dxVmUAFhMjs61xsgBMhDs=
X-Google-Smtp-Source: AK7set+7nFaJVhVCBtfkK8VIzeZrDm1SekDiCNTH7i+5TCKIe4isj5L65ql6qAzLwip/sJDuRhG6dg==
X-Received: by 2002:a05:6808:497:b0:384:3518:df4f with SMTP id z23-20020a056808049700b003843518df4fmr13062352oid.8.1678683694791;
        Sun, 12 Mar 2023 22:01:34 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bm13-20020a0568081a8d00b00383b2b6f453sm2707277oib.35.2023.03.12.22.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 22:01:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] test: framework API cleanup
Date:   Sun, 12 Mar 2023 23:01:30 -0600
Message-Id: <20230313050132.3464802-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functions in the testing framework were supposed to be split between
test-lib.sh and test-lib-functions.sh, however some functions that
belong to the former are on the latter, and vice versa.

Move them back to where they belong.

Felipe Contreras (2):
  test: relocate test_expect_{success,failure}
  test: relocate yes

 t/test-lib-functions.sh | 63 ++++++++++++++---------------------------
 t/test-lib.sh           | 63 +++++++++++++++++++++++++++--------------
 2 files changed, 63 insertions(+), 63 deletions(-)

-- 
2.39.2.13.g1fb56cf030

