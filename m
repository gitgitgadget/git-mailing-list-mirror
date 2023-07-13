Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB21BC0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjGMVnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjGMVnA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:43:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF530E3
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:42:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573d70da2dcso9886707b3.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689284538; x=1691876538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DK0ao0Orh6lg7P6T5DVt24+SXVly2XykhJWYESLEgxw=;
        b=kt/6P6dFGOMr9JJ+g/U29rKUKjz3jvj9VXep5imBJT8TMM1jg4gPzVlEPgL4yrh8sR
         /FkWc5rJ4pg9eVBfcPfqJLaFw5kncxs78M2rZmOK/6mSo3gnJOZeM86z/Euw8h8FfhHE
         5nWMSkW3V09WuxlC5CHSCW6xo4p6DYLyYeI4s/7LcjAYUDAiqT7wrT537DK9tBS6tWoT
         QjhC1uS4gD8ZofGnl0d+hRFmtlFZzAR494S/3m18ttZpQaCsA29bCgopaulEvB8u52Is
         PXnjxrfChk3ShkY5jh3CD1DKg96/xrbimFk29yL3AVN56POROkYIbjeAgdKV3g/6JoPT
         Fr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284538; x=1691876538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DK0ao0Orh6lg7P6T5DVt24+SXVly2XykhJWYESLEgxw=;
        b=UEXUV8+9tEYqjjKYkpka8+FpEjjIPZYue4jjIEU1JcSBDH7z+6euNubLTZrB1cw/08
         JDy7nU+6KPtFzdrZIRizfTrXXeRaH8Q9dpmxm4UMDSGmYMLtk92w0YcHbLeLm9lZ8Y1Z
         ZZ4gAedSaY+o0asDm13iVKuwqgUxMlF7zbav/6LAU5bCk24zXhI3EHhPPRMsDkYeN0kT
         bhgxHiZCPdwNUj8akhey3b87DXxwKiPXl1a9m6oZEI668sH4ClqiPN7NV9gp8H0Biq2M
         wGQy5uuKmUpeM78PMt0v8wNVpG/XPR6+LmxhvkWbhVtffXw0vgLuA6ML6LO/ipTi4CqY
         8Ghw==
X-Gm-Message-State: ABy/qLaokBffnCOVSeyQWYTQPU8nAepnqVuuLIZtsiPgWEsmoKhK2pwY
        ykcifdrOiU6lteU0w8cVUz+ZCEJj8ofPJS/eFZM2gnOSrHsTab4/IK+fmqIVa7nv3f160sAbA0X
        FGAywWZxV0G3n8mFOeMfI6h/jeKsyAOQx8W3yO7Ta5Y2glVxDemRBUd3PnZXRTC8axiCPNOCu1H
        fT
X-Google-Smtp-Source: APBJJlHef1SCFNqdJGqQQapP7s+9QCrdDJSGnJezWp76GttvtkfXqnc5vZ0nvtRCEtz1gaLmuffPnNQlxe3VMkZfC1xD
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:8bde:aac2:2aa0:da1a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ae5b:0:b0:56d:2a88:49e5 with
 SMTP id g27-20020a81ae5b000000b0056d2a8849e5mr21048ywk.2.1689284538561; Thu,
 13 Jul 2023 14:42:18 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:42:09 -0700
In-Reply-To: <cover.1689283789.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689283789.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <94a4c7af38525d04f3effc035084e661fe382dcd.1689283789.git.jonathantanmy@google.com>
Subject: [PATCH v5 2/4] t4216: test changed path filters with high bit paths
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4216-log-bloom.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..0cf208fdf5 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -404,4 +404,51 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+get_bdat_offset () {
+	perl -0777 -ne \
+		'print unpack("N", "$1") if /BDAT\0\0\0\0(....)/ or exit 1' \
+		.git/objects/info/commit-graph
+}
+
+get_first_changed_path_filter () {
+	BDAT_OFFSET=$(get_bdat_offset) &&
+	perl -0777 -ne \
+		'print unpack("H*", substr($_, '$BDAT_OFFSET' + 12, 2))' \
+		.git/objects/info/commit-graph
+}
+
+# chosen to be the same under all Unicode normalization forms
+CENT=$(printf "\302\242")
+
+test_expect_success 'set up repo with high bit path, version 1 changed-path' '
+	git init highbit1 &&
+	test_commit -C highbit1 c1 "$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'setup check value of version 1 changed-path' '
+	(cd highbit1 &&
+		printf "52a9" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual)
+'
+
+# expect will not match actual if char is unsigned by default. Write the test
+# in this way, so that a user running this test script can still see if the two
+# files match. (It will appear as an ordinary success if they match, and a skip
+# if not.)
+if test_cmp highbit1/expect highbit1/actual
+then
+	test_set_prereq SIGNED_CHAR_BY_DEFAULT
+fi
+test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
+	# Only the prereq matters for this test.
+	true
+'
+
+test_expect_success 'version 1 changed-path used when version 1 requested' '
+	(cd highbit1 &&
+		test_bloom_filters_used "-- $CENT")
+'
+
 test_done
-- 
2.41.0.255.g8b1d071c50-goog

