Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E44ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJ1UPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ1UPF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 16:15:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E2B520BD
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y16so7940229wrt.12
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+HssYl2LLbJYOQvNh3qEP9sTGLgHERbvBGu9EZ2czU=;
        b=IIK8XCsyTUPD+NkjqybWB0gs/dAWzTgXm6gheuD/+9FakC9V2dmN8x3yXEPim2FuJR
         0zxEmAduBEw++yLPhnEVvOqVoqNoVwYV/sawBt0ngqjP8qQcT+QpnOmbLRU9TPkrSLTa
         Ds2iUWQHT1j4lNCeXB8JtV32waAdGSnvn11VCC3PR2YNcVIn9+OUfsQWsQZSMBJStoZM
         nYkECpb+6WhXJapRmygZpylg2wwP9CuR8bHUlpPNyGiAYuI4O6Z5p1iCUu+NYOX75xj0
         Fp7HC5Oef0pvRFVps/U2VRJ2buz12t+tv8a8VCxaSZScG6jX8zwRXV95FZcEtlmb7E27
         +IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+HssYl2LLbJYOQvNh3qEP9sTGLgHERbvBGu9EZ2czU=;
        b=AaYPFg3U6okhv5iClS44+RDv5/23Gf8+1cclGXKHchmsLtrrw2N4gO002pTgfPHVIu
         ypMgddvpRWKVYoPIxX1ukCBPNP8vhB2faJkkEcV7mA/kQMmDQMiot/klUmuGzAxymkpS
         gfp/e4FlG3AEYW9s1cWuRzs5NwRCqToPI2aWLU+d5FuApIrRRtLgfD56GB9HfVSybXDt
         COjWFv5XJzVu/k9qcKmHeNX838pFvW0+tAl3UTv1z3qi4su1KDsy6bPI2e9V/UqXkre9
         7COsAsGSPXfMO0cIZ6GY5Vjr3LikuP0J/0DoTbZV4jMguceFgSCftJ1kYhsDf2VeqfSQ
         s0nA==
X-Gm-Message-State: ACrzQf0ro+qfhU1lsue6lLQnswFwtsP98z9zLP2lvhNli/x5o+33OQqI
        UumnyPenVUO0Yzy39AteVGPTBD/OznU=
X-Google-Smtp-Source: AMsMyM4IxLHgaR7sbPs0ksJYh1PCI7cszzN+SjMcRl89PyTIaUWFikNvWiPHZaHwxeDrdBeSpcdWvg==
X-Received: by 2002:a05:6000:71d:b0:22e:71d1:8c50 with SMTP id bs29-20020a056000071d00b0022e71d18c50mr584006wrb.239.1666988101937;
        Fri, 28 Oct 2022 13:15:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q65-20020a1c4344000000b003c71358a42dsm9369157wma.18.2022.10.28.13.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:15:01 -0700 (PDT)
Message-Id: <3a08f2ab776b037e00a47fb7ed63a3f50056350b.1666988096.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 20:14:52 +0000
Subject: [PATCH v3 4/8] t5617: drop references to remote-tracking branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

It has included submodule cloning tests without remote-tracking branches
tests since f05da2b48b (clone, submodule: pass partial clone filters to
submodules, 2022-02-04) at least. Rename it accordingly so that we can
put future submodule cloning tests there.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 ...617-clone-submodules-remote.sh => t5617-clone-submodules.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t5617-clone-submodules-remote.sh => t5617-clone-submodules.sh} (97%)

diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules.sh
similarity index 97%
rename from t/t5617-clone-submodules-remote.sh
rename to t/t5617-clone-submodules.sh
index 68843382493..c43a5b26fab 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test cloning repos with submodules using remote-tracking branches'
+test_description='Test cloning repos with submodules'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-- 
gitgitgadget

