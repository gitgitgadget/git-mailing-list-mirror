Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976CCC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B92F22B42
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsoUMAM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbgGaS0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387652AbgGaS0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 14:26:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CA3C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 11:26:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so28785081wrh.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7wq4Qdm7HE980P4PBdYkyGBMmJbbMPxhSBVPvHX9oI=;
        b=gsoUMAM2qPKgWZ33mT0O7bQxxjExlLS+ltWH4ZvAdvjK9yGvaQ2uOZtwHkvsZtQvKE
         FEfj0d3TLOLFk0HLnIIpF2yaYNGIktlCWNTAn7Mx8YDegpPYw+SGMEmgJfR/IBux8vfj
         ly6Ta5B+xGxJaqw4KUJn0QNYgDOf/Zsq7vry0A8wuLA40oPkxpKmTnTgeCuAH2B5KoC4
         8LXjmBXAEvp84THNd8I1VbEBcQNKisb3cvJ1evjMN0m+cmpDUSCwk85j27LLzmv6pzbf
         /2UWFNgmomOrYPlSIvk3XVvtlBAGGjYZTsfb7MbZPaygwqiuhhVnO0k0T5y9zS3ap5Dv
         6iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7wq4Qdm7HE980P4PBdYkyGBMmJbbMPxhSBVPvHX9oI=;
        b=BJ1H+tyUMenxPrbKUXKRmBfD9kl6ngduxmhDvNemHTG/MSBKS7txj7iYR58j2vWZzm
         w0wo6NcVCCElga4NZ8Z4zq7UW1g7s2gP25qstwVRQH3LhELQXDqddDVHTRJRIAHUlKwh
         XPz+a9lymYB9z/MYdELUKnKjoYpFoEHApYYNWojEsrTDmr9/Vdyeu/65v+CaXpVzTO+v
         HObtk0ETuEoXRUz8H7REZb4gAYE3Kl8HNPyMSf1qGQK241+EJ4TwgnFlY8Z4tWc6Zc8R
         fhVMtX2jawPelGihXQG5ixVdJ/zaOvGlOjTER6dzb+lOmGGzdl1mGlHlJktKNy+QDGi7
         lGOQ==
X-Gm-Message-State: AOAM530UKsma+bN4e66Z7eqZ1Grg+tkhdCTqlNR7HkMPsSfZBOiscs1i
        HWB3akQR1GEglWDRGnfJKwkXUWzt
X-Google-Smtp-Source: ABdhPJwWNUGomIB1rZBulNnGtyzqTUYs+BaZTt+JrLU/hO/gDA5obIaDZV/G0OTVJc2ps+Uutq56gg==
X-Received: by 2002:adf:f247:: with SMTP id b7mr4863765wrp.128.1596219980495;
        Fri, 31 Jul 2020 11:26:20 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.googlemail.com with ESMTPSA id x204sm21484724wmg.2.2020.07.31.11.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:26:19 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2] t6300: fix issues related to %(contents:size)
Date:   Fri, 31 Jul 2020 20:26:07 +0200
Message-Id: <20200731182607.15532-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200731174509.9199-1-alban.gruin@gmail.com>
References: <20200731174509.9199-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b6839fda68 (ref-filter: add support for %(contents:size), 2020-07-16)
added a new format for ref-filter, and added a function to generate
tests for this new feature in t6300.  Unfortunately, it tries to run
`test_expect_sucess' instead of `test_expect_success', and writes
$expect to `expected', but tries to read `expect'.  Those two issues
were probably unnoticed because the script only printed errors, but did
not crash.  This fixes these issues.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6300-for-each-ref.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ea9bb6dade..a83579fbdf 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -66,9 +66,9 @@ test_atom() {
 		esac
 		# Leave $expect unquoted to lose possible leading whitespaces
 		echo $expect >expected
-		test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
+		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
 			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
-			test_cmp expect actual
+			test_cmp expected actual
 		'
 	fi
 }
-- 
2.20.1

