Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70F11F462
	for <e@80x24.org>; Wed, 24 Jul 2019 23:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfGXXHG (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 19:07:06 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56374 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfGXXHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 19:07:06 -0400
Received: by mail-pg1-f201.google.com with SMTP id h5so29313998pgq.23
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 16:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=epdg1RkjPfSeOFnpJAwwZ+NvLq1FWWjtkuy12AzRRYk=;
        b=WamYz3mOYY6E8ETIxAotJRQQzzb1jDnlqvuR/lUeeDhVkKzRZP8hG2O0XD9RDcRC3B
         Zn4CSSmVM2Pga0n7DrDhyz6M1Yv2yv7Ya8WT3ACu7vgJrJ1NQQ9GYtSm3ZVIV7Fy7c52
         /dAiUDytnvEVP2HDgenNILqMM+vrEGJKx+4JYAWf0t5K8dRMTJNCEaszK5B8lL0nqQbB
         bhDGHwONn2XR563YboMsyxqa2EeSDeN6jWtSwGFECs1cfObBpfANljxEK0pOgpaJZaog
         zpsxelK3HnC4obpQy1jcb254AB6CL9CzOMF1bRuGgIHyPtY1pn+6qNcUsOIesYYvagbn
         dTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=epdg1RkjPfSeOFnpJAwwZ+NvLq1FWWjtkuy12AzRRYk=;
        b=EYWB4WOLU3Pw2WsPRzKdXbAhAJT/z5JcWS2nR7nl2b2Wh1oOpBeDEyaAqCuq+NmPJ+
         s+1P5bSQYZ7TviSsxZQSmJi3SleWnugnDLHCEKMGa/FxFt8RWSImy9nxWqWPXLmrADtB
         OVgl5UqPc6qt0ftEfJPXcwCXKmuq0CPREhUK2MpOUtrdkapCbHITxqOlxBZLX79w+x0U
         bfxoix4+oWQDPFkhkTihQWjM0eG7yk0G470Jnv3W+EKkiIIJ46120ef94HmnvuVWzPbF
         Ky2HOUokvUFe8vCeHfIbd8q4QDy10k8ao62OUqBJr6XlbjEDlirFU9O22AfYz/P+MdHW
         gzcg==
X-Gm-Message-State: APjAAAU5ctPWrWzzr0G/11GpFvTIhk7Xp2p0m9DaUbCQ5dX4EygNjajl
        Z4T9ap0+6PybOBCqoSvuTIHFwOttyu2XK7KId27kx/hsQctLG0IETb3/HL3m3v5dBo5G7Vhig3m
        deWroh9vW41o7KFMxghtR3gdhPoeIMqAzE3RGN6LPooH4uj/SKzrp0bcLPuoJP/o=
X-Google-Smtp-Source: APXvYqwrLI0dYRuwiednhiLp637z5MvM7yGlhBSO9HFz17sh53ob2RJvvaQO9Rr5+rigd8u6Zj4HKy9t4zZZew==
X-Received: by 2002:a65:6102:: with SMTP id z2mr82763955pgu.391.1564009625082;
 Wed, 24 Jul 2019 16:07:05 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:06:53 -0700
In-Reply-To: <cover.1564009259.git.steadmon@google.com>
Message-Id: <a07458b2e4d6bb128ca8480d4233bfd03d73c8d6.1564009259.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1560295286.git.steadmon@google.com> <cover.1564009259.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v3 3/3] ci: run trace2 schema validation in the CI suite
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 ci/run-build-and-tests.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cdd2913440..ec38bf379a 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -14,6 +14,8 @@ make
 make test
 if test "$jobname" = "linux-gcc"
 then
+	make -C t/trace_schema_validator
+	export GIT_TRACE2_EVENT=$(mktemp)
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
 	export GIT_TEST_OE_SIZE=10
@@ -21,6 +23,10 @@ then
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	make test
+	t/trace_schema_validator/trace_schema_validator \
+		--trace2_event_file=${GIT_TRACE2_EVENT} \
+		--schema_file=t/trace_schema_validator/strict_schema.json \
+		--progress=10000
 fi
 
 check_unignored_build_artifacts
-- 
2.22.0.709.g102302147b-goog

