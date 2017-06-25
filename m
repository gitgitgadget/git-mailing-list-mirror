Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3191D20401
	for <e@80x24.org>; Sun, 25 Jun 2017 04:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdFYEeu (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 00:34:50 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33219 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdFYEes (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 00:34:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so22607907wrb.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 21:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fe7qVVgMq9semfve0G2oqRr2ENrr0JBrxfVodFLCxYY=;
        b=jJwiJiKk5Etgjh3dUFGpDg6LbGm5c5O1kXcFoHg0vaewUrdmN9Ptuyi5ARYYKdn69X
         pOOBgIYjdQja+/ZoVHmkkAlHsxYC0+hKPnHrPv24j0btkwkeHFAHpPSGmDaCL0BKQyQ5
         NH+87MMUQ85eWTwXVooQ8596xrMj5o17WGsFv/GVlHwz1J8ysXoHtlussPNiPt1ICrOh
         hbZOQK1MiwhEzIO7q9i0X7Br+bGWYfeenMUMJ9I9WVSEBNetoe25e3oVe3J1vZJRtKi/
         CHGjCCZD/hDGFmMjPFJ400guZSfnmplk05Ptah3j5xLRQm4PdAykcVgjMbLXUs1z9h2t
         vLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fe7qVVgMq9semfve0G2oqRr2ENrr0JBrxfVodFLCxYY=;
        b=ezYpM7mkwHWEU2yp5TJ52vy++yRifoVel+EK+JSjo1Z+nEdX/NsakhBQPBsUfJ3ynj
         kEc+7ubJ/h/GiZbuVr1wvwzLAAioIhbGk8XNKlsOQOrfB/8uqyFzJnOAdBgmiVJehD/2
         LIgj1Lnbm/NHNirs+ZAzh16tjq19ZIpesyEbLIgN/Vqoyyb5X/TA6jgIGh2hayawPdk3
         6zpxBTa6lQqXJAaASDNYa6IyH+Iyqc1Gtz7dBeaAT0bM0+5zw+mca0acvVjFLXtc2T+G
         UQDzhs48y+L+9ZzcM2lRh+IE/TEq7EnNcN9tn2OMQgFsFaZkFfJLfQ5Ga2RhhTKFPFzb
         /bzA==
X-Gm-Message-State: AKS2vOy03+0ZicPh+mtkuYtpZHrNS6hDtm2aVp+VvNDFAXGwA8jAqd6n
        epkqVgM0HyJGlzMk
X-Received: by 10.28.166.137 with SMTP id p131mr645004wme.5.1498365286593;
        Sat, 24 Jun 2017 21:34:46 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id a99sm4977943wrc.64.2017.06.24.21.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 21:34:46 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/3] t1700: make sure split-index respects core.sharedrepository
Date:   Sun, 25 Jun 2017 06:34:29 +0200
Message-Id: <20170625043429.23337-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.517.gf6399a5ea5
In-Reply-To: <20170625043429.23337-1-chriscool@tuxfamily.org>
References: <20170625043429.23337-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a few tests to check that both the split-index file and the
shared-index file are created using the right permissions when
core.sharedrepository is set.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index af3ec0da5a..22f69a410b 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -370,4 +370,34 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
+while read -r mode modebits
+do
+	test_expect_success POSIXPERM "split index respects core.sharedrepository $mode" '
+		# Remove existing shared index files
+		git config core.splitIndex false &&
+		git update-index --force-remove one &&
+		rm -f .git/sharedindex.* &&
+		# Create one new shared index file
+		git config core.sharedrepository "$mode" &&
+		git config core.splitIndex true &&
+		: >one &&
+		git update-index --add one &&
+		echo "$modebits" >expect &&
+		test_modebits .git/index >actual &&
+		test_cmp expect actual &&
+		shared=$(ls .git/sharedindex.*) &&
+		case "$shared" in
+		*" "*)
+			# we have more than one???
+			false ;;
+		*)
+			test_modebits "$shared" >actual &&
+			test_cmp expect actual ;;
+		esac
+	'
+done <<\EOF
+0666 -rw-rw-rw-
+0642 -rw-r---w-
+EOF
+
 test_done
-- 
2.13.1.517.gf6399a5ea5

