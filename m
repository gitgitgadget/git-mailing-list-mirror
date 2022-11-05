Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1FCC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiKERIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKERIT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40575DFF8
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so6979901pjd.4
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2qu9jcjV9kYpZCVJHVc9+1r5Adeb/nE6EFzmYw+6Xo=;
        b=P9Efpie/zHpma2X4uxcFUraWrOxAiLe6NwMruupuQDRF+7a+5dmzWDm+ZkipExJMz2
         1rqTg+rnyrq+2NbvqaQlS1Ri5+tv2SmPlLk1fP8vwkDxCgzC9cRPe2V5hsA6RTaiGARy
         HqxZJY94H1zTWgd6X8COl10+TuDd2+nN8wpOCNBz0BkR6Y0aQNsF7X5T4lEBFsSicGGk
         qd4eUMPMok3UPZoH5qsOyKAEhyU6EajTNCjSzd9phV6FdrANAm4fU4LMEllW+RGoDmFy
         USYQ3/OPQGaXaGf2You4DHYDbHG5JRgdNYIS3nWQ39kyl30bR/APAHRV4Pq7na4oL6lV
         g9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2qu9jcjV9kYpZCVJHVc9+1r5Adeb/nE6EFzmYw+6Xo=;
        b=VLKy4GCTv/z/G81V2+FaTcbYeA/jrnYLNhHXFl6ls8t3DVcNKi5PEJA2C4qwWwiRy5
         QmUooLavTWWiY1x/gUJPBzmZfU8y3h4Ixt4Xqa3+rWWm7pRxzKv+DFtSBxez35OMOXq6
         noZ7POwy8Qic3sX0eRBVASVMdr+YUO5FF76igCVd/nvAi7H92c+vEDOdRvk2LtBldl+Y
         nW7SWFLHmoq94NL0tuwMF/WFD4xnR8SaHNheIbHvlMqyYy5YMuwFq+x5eDrVbDglAizc
         0st+VmyEiXXN3XEHpfQxZ4qu6TrIRqXKBIVRMY9Z3oCPt9fCQzTaltQnyU+djch/SxaU
         ZGtQ==
X-Gm-Message-State: ACrzQf2TriuUf5/b9r4pjkNVcYJCUfeMjra5w8U/Apmw7WfORwciZGDu
        bWaU20ZGnhGtyezsWXtcc/fCTvpgX1U=
X-Google-Smtp-Source: AMsMyM5SKKOsmUUOHn985GXc31yS/dP06QNsI50Nqc2YycoZ4Q9evymNh/PxJ3IxA/rd+7I32ELjiQ==
X-Received: by 2002:a17:902:ec81:b0:187:1dbd:b85b with SMTP id x1-20020a170902ec8100b001871dbdb85bmr33281680plg.78.1667668096661;
        Sat, 05 Nov 2022 10:08:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:16 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 08/13] bisect test: test exit codes on bad usage
Date:   Sun,  6 Nov 2022 00:07:39 +0700
Message-Id: <4c1beb8bf8e4237c3c03fc3298bb3e5979740e1b.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Address a test blindspot, the "log" command is the odd one out because
"git-bisect.sh" ignores any arguments it receives. Let's test both the
exit codes we expect, and the stderr and stdout we're emitting.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9e14e1e836..01eaa368d9 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -34,6 +34,36 @@ HASH2=
 HASH3=
 HASH4=
 
+test_bisect_usage () {
+	local code="$1" &&
+	shift &&
+	cat >expect &&
+	test_expect_code $code "$@" >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+}
+
+test_expect_success 'bisect usage' "
+	test_bisect_usage 1 git bisect reset extra1 extra2 <<-\EOF &&
+	error: 'git bisect reset' requires either no argument or a commit
+	EOF
+	test_bisect_usage 1 git bisect terms extra1 extra2 <<-\EOF &&
+	error: 'git bisect terms' requires 0 or 1 argument
+	EOF
+	test_bisect_usage 1 git bisect next extra1 <<-\EOF &&
+	error: 'git bisect next' requires 0 arguments
+	EOF
+	test_bisect_usage 1 git bisect log extra1 <<-\EOF &&
+	error: We are not bisecting.
+	EOF
+	test_bisect_usage 1 git bisect replay <<-\EOF &&
+	error: no logfile given
+	EOF
+	test_bisect_usage 1 git bisect run <<-\EOF
+	error: 'git bisect run' failed: no command provided.
+	EOF
+"
+
 test_expect_success 'set up basic repo with 1 file (hello) and 4 commits' '
      add_line_into_file "1: Hello World" hello &&
      HASH1=$(git rev-parse --verify HEAD) &&
-- 
2.38.1.157.gedabe22e0a

