Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328F01F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 22:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeK1JyX (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 04:54:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45252 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeK1JyW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 04:54:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so24379641wrr.12
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 14:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vORBfGdZqL1lo23XToX494/WD8Uqx4SK24NrQ8RxLtw=;
        b=QTzjbrzjdZ7051uGadwVg0vocqm5cILggQH5qW8q/2DxiA62IUvyac1B+bO3fUtIaM
         BlacRjy7h88qKKW077NIrLGZKFRdh02D7Hr8xcPOkcVJElcT6c03BgEDCjAcsWKd1dxE
         zcI3tdfABhqPsymmRqT6BzdEZqLoTKpYO83tn24aI+4O/bsiCDMBLMZ0KHQe8lVgzDLe
         evU6MRuVnNKHWJyIHDJYGjAcIXLz2bmDnT8Y5U8B07/muMamUfTDiUTMLpikeCzuyRSo
         4hz+sgWx1L4aa3ssO5XQXHMAc54DMewpdeLLVR0T4D8hxlAUuGkDKf9rf26kyEeZ3l+M
         YnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vORBfGdZqL1lo23XToX494/WD8Uqx4SK24NrQ8RxLtw=;
        b=XKLbYPArDU2a1xnBelBZMfSkmb0z2mPbKjyV8sy4yOzqwwg2v9RHKMF+aUIxVQQ5gF
         8SU7tmdr79+68Hv3QfSf4yvU3EgPJHqBvgUbWUYOagM2v3DTkZ+m79BRUhhXHx+bNlyp
         9WLCyhowAfTntNr+/RnVwyZncggEtJbrdeWIqLq87zV6iSUKbK2BgmPInAZH5cszSS6l
         rrPAF1qLE7c68uFV/0x0gNDtp1iAbcqMHn2Xic4+NDTIsJeEqvB9JkoWpyuccAS4XIgb
         ZRYVT0awKcLv/KP6yJGXz2V2I5Ow9AKrElvaGM8TiuqVE02CHPVetdOb6aj5C7e8CiaW
         A2ag==
X-Gm-Message-State: AA+aEWb27kWQYu6BOhtySDaEa1TRWSK1r7AnzvXnKjUHgQRWbvFL1/vU
        KthOoTfMmSzXQWNe8Qo5W1O+JZbK
X-Google-Smtp-Source: AFSGD/WBe8X/+JKxUlbDlAFj+VRE1+N15jJB2b0hEceUaJxLxC9i4A82dMMAoVPOVBF94CezN7KCdQ==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr26290644wrg.183.1543359295345;
        Tue, 27 Nov 2018 14:54:55 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v189-v6sm710604wmd.40.2018.11.27.14.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:54:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] test-lib: add more exhaustive GIT_SKIP_TESTS testing
Date:   Tue, 27 Nov 2018 23:54:44 +0100
Message-Id: <20181127225445.30045-4-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.379.g1dd7ef354c
In-Reply-To: <20181127225445.30045-1-avarab@gmail.com>
References: <20181127225445.30045-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the when GIT_SKIP_TESTS is used to skip entire test
files. Support for this was added back in 04ece59399 ("GIT_SKIP_TESTS:
allow users to omit tests that are known to break", 2006-12-28), but
never tested for.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b6566003dd..b87a8f18c2 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -393,6 +393,23 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
 	)
 "
 
+test_expect_success 'GIT_SKIP_TESTS entire file' "
+	(
+		GIT_SKIP_TESTS='git' && export GIT_SKIP_TESTS &&
+		run_sub_test_lib_test git-skip-tests-entire-file \
+			'GIT_SKIP_TESTS' <<-\\EOF &&
+		for i in 1 2 3
+		do
+			test_expect_success \"passing test #\$i\" 'true'
+		done
+		test_done
+		EOF
+		check_sub_test_lib_test git-skip-tests-entire-file <<-\\EOF
+		1..0 # SKIP skip all tests in git
+		EOF
+	)
+"
+
 test_expect_success '--run basic' "
 	run_sub_test_lib_test run-basic \
 		'--run basic' --run='1 3 5' <<-\\EOF &&
-- 
2.20.0.rc1.379.g1dd7ef354c

