Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653D920357
	for <e@80x24.org>; Thu, 13 Jul 2017 06:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbdGMGvM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 02:51:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35581 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdGMGvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 02:51:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id y28so3840297wrd.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 23:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZOJHdsYaU6ZmhErQloK8HrdNP/KfzxgcUKqUtd0pdhY=;
        b=L+4A4rMdcA5QI8+3kVHxjy9M+pf962gMy8ekg6B23ri9+3OVtvuoaVRjz/rPOGz4DH
         lBiYKzatZId812e1WKQhKq9etM6/i4O0UoVljqqEviils1/OjQPNctaOOYF3pwpVP7ZV
         0eNtuHZP2KlR660lhiipXssESFGQRgeDuIYm94ndydO10YmiuF5qvsoPmwJ4/n8WK3J6
         LPak8IYftbxE0K5/2AB01y0gWjDSoRXFF/k8/zU0YYhSef088sLkP2j2MFPq0Q+h7JbV
         6SDvKD0/bZtcAYUrqVTIZH7URu0XCHuTNaiDXOJLLf2Y4/WrtAPSTHNgM8haCB9o7Sj3
         B1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZOJHdsYaU6ZmhErQloK8HrdNP/KfzxgcUKqUtd0pdhY=;
        b=TT3FbJ7WCWW6aog3nYiIsHjYu7eLwCDht7s3O0ZEpw17erLVAic6TNCqakvt+mbogX
         Zr4zoKTjwgvyu8KPEG5bgrM7W1efXf5ViZKiIvyEFw+x3SBL9kHJT9fwR3klB8z0ED9U
         mApUUFG2krMYLe4D+RgWtc5WQvfYINwF3Ica5qB9NvLOg8xpFVH5VbKeIaDJak/K448b
         UtcYtq0Am6XKklNpfYsHYuO6xg8hzSYtCumh9yD1gOfW6s2yeTtwzCLoX3ekFlDIrbyf
         n+rtjBkgGz+Ap66GQIzuDZ4u1UGacmPEnc8gv6Zhc38Zsoz1opVVZFLUU1EcJdSPzivf
         zOUA==
X-Gm-Message-State: AIVw112fXAacBhOEGmfbe9EFvXR7KH8MJpuswdyXeaOzmJ38VpJahuZ3
        dAx9nhHxaAdF7KxK
X-Received: by 10.223.148.129 with SMTP id 1mr695926wrr.28.1499928665340;
        Wed, 12 Jul 2017 23:51:05 -0700 (PDT)
Received: from localhost.localdomain (43.40.120.78.rev.sfr.net. [78.120.40.43])
        by smtp.gmail.com with ESMTPSA id l20sm3332564wre.25.2017.07.12.23.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 23:51:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 3/4] perf/run: add GIT_PERF_DIRS_OR_REVS
Date:   Thu, 13 Jul 2017 08:50:49 +0200
Message-Id: <20170713065050.19215-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.2.647.g8b2efe2a0f
In-Reply-To: <20170713065050.19215-1-chriscool@tuxfamily.org>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This environment variable can be set to some revisions or
directories whose Git versions should be tested, in addition
to the revisions or directories passed as arguments to the
'run' script.

This enables a "perf.dirsOrRevs" configuration variable to
be used to set revisions or directories whose Git versions
should be tested.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index 41580ac6df..ad442fe64a 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -113,6 +113,9 @@ get_var_from_env_or_config () {
 get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf.repeatCount" 3
 export GIT_PERF_REPEAT_COUNT
 
+get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf.dirsOrRevs"
+set -- $GIT_PERF_DIRS_OR_REVS "$@"
+
 GIT_PERF_AGGREGATING_LATER=t
 export GIT_PERF_AGGREGATING_LATER
 
-- 
2.13.2.647.g8b2efe2a0f

