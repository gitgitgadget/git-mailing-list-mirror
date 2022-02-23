Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2B2C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbiBWScj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbiBWScL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339C425D5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p4so4084018wmg.1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pr1J/M+tHmy/8C/jRdXK2EcRs94uaKQs2Im82L5XVtQ=;
        b=Mb9YODnUK+dPkVVQemW51XBXvFsZ9WeZ3zJ70wohOji9e7oNpXmJ/cDsMbUZoZbE3V
         FcMbceldGfvfsnIycH0fKS5XBcTZbincduq8Q+XE4bWSwtkqwPNC/f9UZwe2yoqM4h/E
         lDoGpkN0c7bUjvmZL/BiXmpaIpigXgx8OEii9TQe4Q4trsLoondPJsz2NaiI+X583Syh
         Yi3chNUFDFmg+ubK6RqKJcx6yYiy+8duj3Nnd8j2n57I5HCYOZN8Q+kIOvyYE7TLFDET
         DESYi0+9lA7a89LrhPf7g0qo7co1Kvi4BefOqzRzgxXNHx/UGodyWswPgGrsl2QpOrPG
         I3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pr1J/M+tHmy/8C/jRdXK2EcRs94uaKQs2Im82L5XVtQ=;
        b=VTNARBMG1YzAyjS3Ld3x3yiG0yKNdKKNyvkGpaZJoFxg+njmrJi9InRdhKJGo4vCha
         lAMMBqHUZ2oSOSi+6Dsg6Di5QAkLfvaMCrldzbS4nnkYFY95+T+NRbJ+ML2bH1br7oKI
         g3HEqDrla1i88y/Q8HiUU+D9e6T6mqOscICsg1NIDtEtFZ3IrT+NLh+zwr8uioXWlO54
         Dbcx+8oclN3PBS7323A66vRExUyQESBhx/UPRm0F3Pr/1jiZ+nZPKcIL2hKYGcJ0xoIM
         a4mZ9xnX+9FXQ/11xrpDipARU5DBNZ+B2x/LmztZw2i3yGwyVmJx/ZevRIfBMqB9KhHc
         WmZg==
X-Gm-Message-State: AOAM533sQXPYYPrVGk2SoETXSDLtxj7jsASWC/r8itdlTDV2BOHITh9/
        KwTEgu0Tye5zCTdzec5gyjb7yYTwfJI=
X-Google-Smtp-Source: ABdhPJwr6VvutOhrSmSmvsE+aHNxGHzFq//CldCJ8G/SFoHFF9vjvea5RgSOBVZ9U+Gqp640hAZMCQ==
X-Received: by 2002:a1c:7311:0:b0:37c:3ceb:71c3 with SMTP id d17-20020a1c7311000000b0037c3ceb71c3mr8451856wmb.154.1645641091445;
        Wed, 23 Feb 2022 10:31:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a05600c2d4900b0038100a95903sm446527wmg.41.2022.02.23.10.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:31 -0800 (PST)
Message-Id: <a2d64f369d0f00208574a8ff67e04c08e54c4317.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:31:03 +0000
Subject: [PATCH 25/25] t5601: basic bundle URI test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This test demonstrates an end-to-end form of the bundle URI feature
given by an HTTP server advertising the 'features' capability with a
bundle URI that is a bundle file on that same HTTP server. We verify
that we unbundled a bundle, which could only have happened if we
successfully downloaded that file.

RFC-TODO: Create similar tests throughout the series that perform
similar tests, including examples with table of contents and partial
clones.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5601-clone.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 83c24fc97a7..b2409a4c04c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -769,6 +769,18 @@ test_expect_success 'reject cloning shallow repository using HTTP' '
 	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
 '
 
+test_expect_success 'auto-discover bundle URI from HTTP clone' '
+	test_when_finished rm -rf repo "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/everything.bundle" --all &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
+		serve.bundleuri $HTTPD_URL/everything.bundle &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git -c protocol.version=2 clone \
+		$HTTPD_URL/smart/repo2.git repo &&
+	test_subcommand_inexact git bundle unbundle <trace.txt
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
gitgitgadget
