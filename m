Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585A1C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbiFOKxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347357AbiFOKxm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:53:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE0C51E6D
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v14so14832137wra.5
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6c0OWQMiNBPiEJn6VF6ub43lsgxXQeqJh7hOpRyNTc=;
        b=h6JEs8YV4lmioHNL2PABNAwB4OXiHDugN1AeJzCpNjgm+hXQuQfUdrhgvim8iAWpls
         a1uEPJNoCVs8Y2J+k8vwhcKtrd9EW4/N5CTZ/CUanHV/lH6U8Kgt5/D41BpVQRin7NLm
         8try1SOhbqnbUkLp+w0app/u3oxjmFD4oGUQRnDE0imsqNcluUEEwzqqhDhox9n2yySl
         hPX2H++dqXZAaTdogI/BRLJR5Ubm1aI19GRwfPgNs8Vw4Q2p5kkOtUEegoo546Qk/FVs
         +kxdR8LfjosFApMhXqJ2LrRPr5eKF0Jhd4FYIH06128nu91KU+oA8yD6Cl9nsskXCQ/Z
         b4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6c0OWQMiNBPiEJn6VF6ub43lsgxXQeqJh7hOpRyNTc=;
        b=GzviODtnJ3bRhp84ohPeNByjwADf8nVXzhABzTwykQU9YfxQlG0We79eF8hlOCjZ8G
         FRmkBwy5dSA+LbRuXiV4KT/NSYk5UlNOyz6/friLSz3U3IfZoIi3Y881kAf1h0yccIFQ
         5udqLRnL2f53oLPyHnl2C7WTiBCaib/1+fj/QVJ8zcoTer6g3qRlErbpf895FrhRilvn
         JbtpwMvZYgkQFRXfP71AU0JwTvIKomby4W3+h9vqo8+ANLvPB457adgQp2wofP0k1cHI
         ZQh5AU8y8G8pkU0lnQylwQAduPRtJvohnGB9q+8vgUunlgTHD3dC8rQ8Rny/VkTkikSh
         t4vw==
X-Gm-Message-State: AJIora8rW4ssjjkwMMxEo/qWIRWbTm0u6Md1CnAWqd1x/9jqIAXNWjtj
        CPQYJyBC2Yi4NqTlJjlOOLR8mXHP0I3sNA==
X-Google-Smtp-Source: AGRyM1uqtRcriu/0kO0eI0LWkan6reVB6zP4TY7Ho1kI6e450DgkVHek8v0ca/XAutsiQ1ipaQE0Nw==
X-Received: by 2002:a5d:64a3:0:b0:218:4a35:dd89 with SMTP id m3-20020a5d64a3000000b002184a35dd89mr9466247wrp.209.1655290418786;
        Wed, 15 Jun 2022 03:53:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b0039bc95cf4b2sm1786747wmk.11.2022.06.15.03.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:53:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/5] fetch+push tests: add missing coverage for 6dcbdc0d661
Date:   Wed, 15 Jun 2022 12:53:29 +0200
Message-Id: <RFC-patch-2.5-38af32c5b96-20220615T104503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
References: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests that were missing from 6dcbdc0d661 (remote: create
fetch.credentialsInUrl config, 2022-06-06), we want to test how we
handle cases where the config comes from a file, and that we handle
"pushURL" correctly.

Currently the "pushURL" case isn't handled at all, i.e. URLs aren't
warned about in "remote.*pushurl" , only for "remote.*.url".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4b32ae39a39..51d695e475a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1852,6 +1852,26 @@ test_expect_success 'fetch warns or fails when using username:password' '
 	test_line_count = 1 warnings
 '
 
+test_expect_success CURL 'fetch warns or fails when using username:password in config' '
+	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
+
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+	git -C repo remote add pwd-url https://username:password@localhost &&
+	test_must_fail git -C repo -c transfer.credentialsInUrl=allow fetch pwd-url 2>err &&
+	! grep "$message" err &&
+
+	test_must_fail git -C repo -c transfer.credentialsInUrl=warn fetch pwd-url 2>err &&
+	grep "warning: $message" err >warnings &&
+	test_line_count = 3 warnings &&
+
+	git -C repo remote set-url --push pwd-url https://username:password@localhost &&
+	git -C repo remote set-url pwd-url https://localhost &&
+
+	test_must_fail git -C repo -c transfer.credentialsInUrl=warn fetch pwd-url 2>err &&
+	! grep "fatal: $message" err
+'
 
 test_expect_success 'push warns or fails when using username:password' '
 	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
@@ -1867,4 +1887,25 @@ test_expect_success 'push warns or fails when using username:password' '
 	test_line_count = 1 warnings
 '
 
+test_expect_success CURL 'push warns or fails when using username:password in config' '
+	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
+
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+	git -C repo remote add pwd-url https://username:password@localhost &&
+	test_must_fail git -C repo -c transfer.credentialsInUrl=allow push pwd-url HEAD:refs/heads/branch 2>err &&
+	! grep "$message" err &&
+
+	test_must_fail git -C repo -c transfer.credentialsInUrl=warn push pwd-url HEAD:refs/heads/branch 2>err &&
+	grep "warning: $message" err >warnings &&
+	test_line_count = 2 warnings &&
+
+	git -C repo remote set-url --push pwd-url https://username:password@localhost &&
+	git -C repo remote set-url pwd-url https://localhost &&
+
+	test_must_fail git -C repo -c transfer.credentialsInUrl=warn push pwd-url HEAD:refs/heads/branch 2>err &&
+	! grep "warning: $message" err
+'
+
 test_done
-- 
2.36.1.1239.gfba91521d90

