Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A317C25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 04:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbiHSE20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 00:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiHSE2S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 00:28:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E6DF6A
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:28:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so459813wmk.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=OqJCfJhGuq0BefAM6Qj6jVSrSgA3CFSRThSVKJ+r1YU=;
        b=fhzaEUmHxSodEWr0LbQ6qYDHh1aUU2RWOzWW9QoAvIti4wlPpuDBlkB7OgF/Xeu2s+
         8LuwhOuIUysme+gONNTjj7Sv9WF9dyKLHGChXF0epSyws2sdpAw4kc8W8w7/8hdt54gJ
         gXQb/gVICWIoPqPLOhukYvrdFkj6OM19pl8SxThbDLK1VKX6cmXknyEobue5UH03Jh6w
         c6R1Lw+tk4Lr19TROJ/3xoAzaP/qk3zdWusTRPCe77cqy022WTAtNcikKapzC6nFeM5Y
         SglHMauel94+O+Mbef7prCsXEVSKCQuq6y2ttTImvSAyaHVjtvBk19Y8xMqji1cXGlFc
         WZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=OqJCfJhGuq0BefAM6Qj6jVSrSgA3CFSRThSVKJ+r1YU=;
        b=Eb8xAPJUjDU8U24eff01oIPv20MRMO2F8fb7T+2dV2D7tAyBX3POqPj3cXoMWLXeLv
         MAB7+lW5BBx9JWbeksTVvzEbxG8SDmg0SR/ki+yG8fU0od8QASJJ1zPh7W1YIQaPl7+r
         V5Lt4TwIR8pn3zUcbg9jBfgpk4EJOKVVv3C8onD/fm6iU5ESunVIhdiehh1pz7D2to+/
         DXEwcGyeAgJvmrYfbC6uOtrsFqME1X5fqa3UPpxUOrFTlREro70IIhCZH4BEDuZ+YY6v
         FlgOO1Y3r8QZmZZcn3J1HUwYyWIwf/QbQNInPGlXlbwLZOjgFp5wE51hTf8Hbcz1mfHp
         vdYQ==
X-Gm-Message-State: ACgBeo04U4s3jUqB35lXKbJTFX6GSUdHjz5wLTvYtdI3hBFLo9G91PsA
        WI5dJ89l9CAIEjItuxz0nmU/aMrswCQ=
X-Google-Smtp-Source: AA6agR78ihK5xazI/jp8S3Vca+p4uDG2aqvv4o8G3wRjFnnXxdMBdKNrLW1Z8QIlEhemQtcNLgRwTg==
X-Received: by 2002:a05:600c:1d08:b0:3a5:b7ee:91c9 with SMTP id l8-20020a05600c1d0800b003a5b7ee91c9mr3735643wms.114.1660883294767;
        Thu, 18 Aug 2022 21:28:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2-20020adfffc2000000b0021e5bec14basm2916362wrs.5.2022.08.18.21.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 21:28:14 -0700 (PDT)
Message-Id: <5226da2123ee58992b0e723665c8d9c52d3a9544.1660883290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
References: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
        <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 04:28:09 +0000
Subject: [PATCH v3 2/3] t6019: modernize tests with helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The tests in t6019 are repetitive, so create a helper that greatly
simplifies the test script.

In addition, update the common pattern that places 'git rev-list' on the
left side of a pipe, which can hide some exit codes. Send the output to
a 'raw' file that is then consumed by other tools so the Git exit code
is verified as zero.  And since we're using --format anyway, switch to
`git log`, so that we get the desired format and can avoid using sed.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6019-rev-list-ancestry-path.sh | 87 +++++++++----------------------
 1 file changed, 25 insertions(+), 62 deletions(-)

diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index af57a04b7ff..5bd787a3c0a 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -50,73 +50,36 @@ test_expect_success setup '
 	test_commit M
 '
 
-test_expect_success 'rev-list D..M' '
-	test_write_lines E F G H I J K L M >expect &&
-	git rev-list --format=%s D..M |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'rev-list --ancestry-path D..M' '
-	test_write_lines E F H I J L M >expect &&
-	git rev-list --ancestry-path --format=%s D..M |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'rev-list D..M -- M.t' '
-	echo M >expect &&
-	git rev-list --format=%s D..M -- M.t |
-	sed -e "/^commit /d" >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'rev-list --ancestry-path D..M -- M.t' '
-	echo M >expect &&
-	git rev-list --ancestry-path --format=%s D..M -- M.t |
-	sed -e "/^commit /d" >actual &&
-	test_cmp expect actual
-'
+test_ancestry () {
+	args=$1
+	expected=$2
+	test_expect_success "log $args" "
+		test_write_lines $expected >expect &&
+		git log --format=%s $args >raw &&
+
+		if test -n \"$expected\"
+		then
+			sort raw >actual &&
+			test_cmp expect actual
+		else
+			test_must_be_empty raw
+		fi
+	"
+}
 
-test_expect_success 'rev-list F...I' '
-	test_write_lines F G H I >expect &&
-	git rev-list --format=%s F...I |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
+test_ancestry "D..M" "E F G H I J K L M"
 
-test_expect_success 'rev-list --ancestry-path F...I' '
-	test_write_lines F H I >expect &&
-	git rev-list --ancestry-path --format=%s F...I |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
+test_ancestry "--ancestry-path D..M" "E F H I J L M"
 
-# G.t is dropped in an "-s ours" merge
-test_expect_success 'rev-list G..M -- G.t' '
-	git rev-list --format=%s G..M -- G.t |
-	sed -e "/^commit /d" >actual &&
-	test_must_be_empty actual
-'
+test_ancestry "D..M -- M.t" "M"
+test_ancestry "--ancestry-path D..M -- M.t" "M"
 
-test_expect_success 'rev-list --ancestry-path G..M -- G.t' '
-	echo L >expect &&
-	git rev-list --ancestry-path --format=%s G..M -- G.t |
-	sed -e "/^commit /d" >actual &&
-	test_cmp expect actual
-'
+test_ancestry "F...I" "F G H I"
+test_ancestry "--ancestry-path F...I" "F H I"
 
-test_expect_success 'rev-list --ancestry-path --simplify-merges G^..M -- G.t' '
-	test_write_lines G L >expect &&
-	git rev-list --ancestry-path --simplify-merges --format=%s G^..M -- G.t |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
+test_ancestry "G..M -- G.t" ""
+test_ancestry "--ancestry-path G..M -- G.t" "L"
+test_ancestry "--ancestry-path --simplify-merges G^..M -- G.t" "G L"
 
 #   b---bc
 #  / \ /
-- 
gitgitgadget

