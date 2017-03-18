Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 000FB20323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbdCRKee (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:34:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36369 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdCRKeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:34:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id x124so6815798wmf.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gp6zAbnITL18zM0tZBmxOaNlLE+nNlRZ3p4rcmjjfjQ=;
        b=QL68KcrhK/K9JYBFMkFo2WiqF18C9sA9E3Zkvw9jHlAZ7GweaYFStMxqkCy+zOlb/k
         +ru6o+6saptlZqxamJwHkEikVTQ2W42vdumhvkhFmHSJEmWPXIdq8GtyVRdxfRo9PrPr
         zJjZhIlaJwmxIJveT6ypBFHqJzyw0CCN1sNVk9+Sq17z6o+V59HH4vlqp9IIsQeMlOET
         yVIbtXWnhFYiTGPu8TPUQBHGznxbCN71LSE0+6mk3Wde4qgwiKFzvIN60FGVRiN56fnb
         Cifl7TkEcAY/Ew+X8/LTvHh4qe+O4+5GeqN8O92ojnhWvJOhwFbGCccX9Xu7gEXglTLU
         0HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gp6zAbnITL18zM0tZBmxOaNlLE+nNlRZ3p4rcmjjfjQ=;
        b=LIMOGSSn5JSWMOLQCek9FneDFIhfb9LnJgoRtZj0MV9/LWZLJKkLajvMADXXQFjP5o
         vlIiE/pEU2/VWze3JyRKLUTE4/+xAOZ/PTv1QyzBL1up/XZE4VjW0No66DxQmcxjJDir
         vgWmzgXvaTCiE14YqJ1069bUrsNZkz5Xk8Wjm3D3HGLTeWrlB1S+ZAXpnfUVoI7O169n
         uN1BRgQCnLzJ+nddPSwvAqWyyfw8fUIn18JPnvOW43z9EtSYa+bqkVHbCh7honrtI5/l
         1kokEM1OKx5WkXrbfPSG+J/JTLaAcrw2RU9E4sQz7AwVP2/QJi7h8UTNfgSvZPfyLnlu
         7dGw==
X-Gm-Message-State: AFeK/H1zGqWY+84lE79LIGm+szbxkEqq9V4P875hKeTDpQ9AJ2S2uI9qkmcDU6JmayZoIg==
X-Received: by 10.28.88.2 with SMTP id m2mr2209116wmb.12.1489833233522;
        Sat, 18 Mar 2017 03:33:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j34sm13007928wre.7.2017.03.18.03.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 03:33:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/8] tag: Add tests for --with and --without
Date:   Sat, 18 Mar 2017 10:32:55 +0000
Message-Id: <20170318103256.27141-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318103256.27141-1-avarab@gmail.com>
References: <20170318103256.27141-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test suite to test for these options. Before this change
there were no tests for this at all. This change doesn't exhaustively
test for them as well as their --contains and --no-contains aliases,
but at least it's something.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 428e21c369..f7ff4e034b 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1592,7 +1592,7 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag --contains --no-contains
 '
 
-for option in --contains --no-contains --merged --no-merged --points-at
+for option in --contains --with --no-contains --without --merged --no-merged --points-at
 do
 	test_expect_success "mixing incompatible modes with $option is forbidden" "
 		test_must_fail git tag -d $option HEAD &&
-- 
2.11.0

