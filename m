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
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E061F461
	for <e@80x24.org>; Tue,  9 Jul 2019 23:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGIXF7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 19:05:59 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46506 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIXF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 19:05:57 -0400
Received: by mail-pf1-f202.google.com with SMTP id g21so132817pfb.13
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 16:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=tsFeOsdJLwKrgVd7r4XPCeNal7PifK6CpiAuVCrBZYM=;
        b=IJH356Ufloz5Un81/6D/9VZbErLBIi1SqaFoOU/S11WX3MuWx6m5tCooFAqjhPek1U
         +e9Ra+uQbPHeg2u2goKINbbINEByBULAMJBdM+/yuw8ST8QPsycg/YbBWDUWINJcwO2e
         57fRI3cpVBMBtTnAKJEf//uVGzgBrkzXxb/O3qBO73JES1729n5XL66DLJNhlOBnmyI/
         QUJQ6dlQAGMViBaNmQhVHRsir2RSA81SPPhbAWRcvBX8edlvAoDOtBZYPMy5KmExdK2h
         6WcSLS1O+tEJzoeCJKvZCHE0Jx70vS8aceFoIw2VKH0Llv54mfQMeR1+92RZkqJ/PTf3
         ACEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=tsFeOsdJLwKrgVd7r4XPCeNal7PifK6CpiAuVCrBZYM=;
        b=sAlyIKNSiGl9pOb6UUF0KVYMGNMAYvADdF23P3YpB6A2k40zV+LuJYiSBcTcSP45vU
         hZiRD6fIooLPfFob3fFfjfE/i+xH1vugWQd4mxBhajljA3W20qcQIyXCcQ516/+HAiAF
         1JVQk8HN/LEUNk9oF16T7ufoFcM1syiW4jPP/wDb9cte1hYd2kNQ/8efCuWhNPiNprCP
         RwGD+u0l3eRg63ApAkTbua6PzrSRofdsEhnbWjmc8ZO85uu6wxbRq4D4x8OowsOKq97d
         D3/1Ah6tjbPTk3kEVVPaDvpftzofAJwJVlSMf/Sabxigp3qdQ8fstTX6ygrJgdD2bFZs
         VXWw==
X-Gm-Message-State: APjAAAWpcEdDLy3LhceJobihQDW9AmABFHlM9jCj14gRSFAIxocwov8K
        sX3XcakRJjCRwpXg6+m2KT4smZoVo+3RmeVFG0rpQkDaMzcsqJ+PsiMmPMlz48DRjw+wLrXo6I4
        XXXy0tcUMf8JLVAthJsXryOuXiiTtQB/QLLMT3HaDV7276ToRvmldlqwUy1wZAtc=
X-Google-Smtp-Source: APXvYqxnl3XF4cHHpZb3HxXCe3bGApdGT63gKAKw4VmwjN6tE2aKFL5xRTq9HEyuNPZK2rZ/mpdK5SRyNoQacA==
X-Received: by 2002:a63:1310:: with SMTP id i16mr32832475pgl.187.1562713556543;
 Tue, 09 Jul 2019 16:05:56 -0700 (PDT)
Date:   Tue,  9 Jul 2019 16:05:45 -0700
In-Reply-To: <cover.1562712943.git.steadmon@google.com>
Message-Id: <acf3aebcaa60270ef3bc94547a3aec50f39038fe.1562712943.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1560295286.git.steadmon@google.com> <cover.1562712943.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [RFC PATCH v2 3/3] ci: run trace2 schema validation in the CI suite
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
 ci/run-build-and-tests.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cdd2913440..0707c90549 100755
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
@@ -21,6 +23,9 @@ then
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	make test
+	t/trace_schema_validator/trace_schema_validator \
+		--trace2_event_file=${GIT_TRACE2_EVENT} \
+		--schema_file=t/trace_schema_validator/strict_schema.json
 fi
 
 check_unignored_build_artifacts
-- 
2.22.0.510.g264f2c817a-goog

