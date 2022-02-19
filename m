Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86034C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 17:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbiBSRaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 12:30:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiBSRae (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 12:30:34 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F5670060
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 09:30:15 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id e22so21333641qvf.9
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 09:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ud0z6bdKTsPBFazh0kBc6lQu5riblHz+yqtxreGQT2Q=;
        b=G5IfKSiiAfe3d6tGnBjomV2h3Cb1VRTjG0IPAwGdLHF9kIO078dfty7eru9d31Yiy+
         0oP01HIK9ZG557Fm/YpiCbU5jT4BGMQm6MihYlxf0B08VJNX6qYdvZWvRPPNcDGuqjOq
         00VWA97VbQkoO8/BYodmHmCt6L6G/M5vypyXMJ7TwcICO70wz/9lu2WxcW5UwCqdcTrL
         v0TUHKBGwGmuQit71JjP33hYCdB0S91ZN2bQMrfbU+wP3d7b9EPmhqiptJqviGOZdLCe
         daQSuTilvgIAyhAL+XuNJmsxhakOzXpoNktu078RVuNtwzlFdwtAOioFe0/AJEcIUKcv
         ++cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ud0z6bdKTsPBFazh0kBc6lQu5riblHz+yqtxreGQT2Q=;
        b=jMSL2Pxm//Gan6PLgeGClgaqYWmC3NdFqsjKEZYN5L+GCHFBnv5eEfoCzfhYnkQqHs
         BOO77UxEfxFVLoD+0v9cqgLVRAr6L5vgSPyXV9FmPSfB+H0plgSSXeYPBRehIZz04Vwi
         gDBlS2khJFgeQ6dCd37rTe5eI7DvXRiUvzwHIJzGK2iarFNU28p6prMJq+MLt3Bq74GB
         sbJj63kjcUUMh1Iko0C6qsf1MZDi0JfmA0LdQLK4zYlvI70Pymk/bv2MAqVilCDLlpor
         +DJKpMX46lM3hu12ZDMNhFncmoVfpSO3HFNyh3B949fqXgzC6pjWQqAALtKAZdJcV0tJ
         oVgg==
X-Gm-Message-State: AOAM530jtzG+22Kz2JzIGB2LyEyb5XBW7ce5OVBQ2CDFCWlk0k1+K79F
        Q5CQc8+HZHmj2cC8mOKsxqUqcYE0QXw=
X-Google-Smtp-Source: ABdhPJxntZdj/+3MTlhMZ7StroA2XbZT3+jLFksiaeojyCDqha7g3wzMfv0fSoysghbkHiNKhOjQZg==
X-Received: by 2002:a05:622a:1a8c:b0:2b4:b4e7:69f4 with SMTP id s12-20020a05622a1a8c00b002b4b4e769f4mr11716204qtc.642.1645291813800;
        Sat, 19 Feb 2022 09:30:13 -0800 (PST)
Received: from localhost.localdomain (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id b8sm27091132qtx.79.2022.02.19.09.30.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 19 Feb 2022 09:30:13 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] t5617,t7814: remove unnecessary 'uploadpack.allowanysha1inwant'
Date:   Sat, 19 Feb 2022 12:30:10 -0500
Message-Id: <20220219173010.2859-1-levraiphilippeblain@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <690d2316ad518ea4551821b2b3aa652996858475.1644034886.git.steadmon@google.com>
References: <690d2316ad518ea4551821b2b3aa652996858475.1644034886.git.steadmon@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in the previous commit configure the "server"
repository with 'uploadpack.allowfilter', in order for it to act as a
promisor remote, and also with 'uploadpack.allowanysha1inwant'.

This second setting is unnecessary as it only affects protocol v0
operations; protocol v2, the default since eb049759fb (protocol:
re-enable v2 protocol by default, 2020-09-25), allows any OID in want
without any configuration needed.

Remove this config from both tests.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---

Notes:
    This is based on the version in next: f05da2b48b (clone, submodule: pass
    partial clone filters to submodules, 2022-02-04).
    
    Both tests still pass.
    
    I wondered if it would be best to add '-c protocol.version=2' later on in the
    tests, to allow runnning these tests with GIT_TEST_PROTOCOL_VERSION, but I was
    not sure.
    
    Note that as I remarked in [1] last summer, the fact that
    'allow{Tip,Reachable,Any}Sha1InWant' have no effect under protocol v2 is still
    missing from the documentation...
    
    [1] https://lore.kernel.org/git/1a98c659-e7db-50a6-faf3-b3b4c15df679@gmail.com/

 t/t5617-clone-submodules-remote.sh | 3 +--
 t/t7814-grep-recurse-submodules.sh | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index ca8f80083a..3fc93b1f8d 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -31,8 +31,7 @@ test_expect_success 'setup' '
 # bare clone giving "srv.bare" for use as our server.
 test_expect_success 'setup bare clone for server' '
 	git clone --bare "file://$(pwd)/." srv.bare &&
-	git -C srv.bare config --local uploadpack.allowfilter 1 &&
-	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
+	git -C srv.bare config --local uploadpack.allowfilter 1
 '
 
 test_expect_success 'clone with --no-remote-submodules' '
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index a4476dc492..1c9aec06a3 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -563,9 +563,7 @@ test_expect_success 'grep partially-cloned submodule' '
 		git commit -m "Update submodule" &&
 		test_tick &&
 		git config --local uploadpack.allowfilter 1 &&
-		git config --local uploadpack.allowanysha1inwant 1 &&
-		git -C sub config --local uploadpack.allowfilter 1 &&
-		git -C sub config --local uploadpack.allowanysha1inwant 1
+		git -C sub config --local uploadpack.allowfilter 1
 	) &&
 	# Clone the superproject & submodule, then make sure we can lazy-fetch submodule objects.
 	git clone --filter=blob:none --also-filter-submodules \

base-commit: f05da2b48b48a46db65fc768b3ffecaf996dd655
-- 
2.29.2

