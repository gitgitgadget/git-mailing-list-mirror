Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6508D1F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeCaKDq (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42834 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbeCaKDl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:41 -0400
Received: by mail-lf0-f66.google.com with SMTP id a22-v6so15118262lfg.9
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utWlee1mRklrySnjAKsTSz10YA8DuLwRWsqco00Gtmw=;
        b=cOQamt2sOIN4GMIPHkz1CuCH5RHfYQ5uuM1XkDDAPvvowO4t6bShGZItGJyFlnZ1Ku
         v1pXU6uaFBYZ52zMWdUwW9pachcB3ejW/qfwArvxep/li5Ao6xQ2MJ9fE7HNInKAA25A
         /iGS89GepCxj1xLJ59Aqs59M0KuISs9Jv/zaCdG4FQa/IOyjgzwZGru0PeNqTCN04ohD
         Ziv6FBv8uJopTjXBgYP3DLXAw6Dr2Vb7zqXjPP1W4Q/PVuVfrxate9Z60RUx1YQki0nQ
         xUk2SOd/FDZU+0Oc5VzaE2U3ga++dTsLMSgLn74O+L0i4gHPLp3cdzXx9LbENOQl98d7
         GmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utWlee1mRklrySnjAKsTSz10YA8DuLwRWsqco00Gtmw=;
        b=VwscKAqzbd5Vs2EM/68qs9aFDUlJT2Ry/64UOsl14MpoTZ7EVSjIJtC7s5FkiypeSB
         j9bdeI/Kj9y5+NB70/TC0vZMRJ/QOiODMA+kIJrC3CjNMR1AVklFCu7dytlDzl6r2Jn2
         ICJ5k7eLEfC5HzX0SlDVwNf6RocqslXwESzFOURnZ/wrapSGiaLokSoZ4X/C6bhQGg+z
         IB3ODdtFMdjzsd+VOR76ZodUV81cMuRQ+TfBURkKaltEp1m3mfcSp6epd8eJFHsJ6r1j
         kiWKMLKmKfsIEOgpTyU3NAPeJ6AdDfPxEng8XfW6ysULg7FFUsPA64aKdILs8ywpRwiz
         +FWA==
X-Gm-Message-State: ALQs6tCmGvIMM6j9QqImnlZoAjyBdnYc1a+y1pIenIsxJ5vKZ+kSzCpW
        wuwzIC2VbY3qcYZM6CFPVbo=
X-Google-Smtp-Source: AIpwx49hW4C4Geb6vzGg7xEjCm6KqHzSz//LxYy6X3YFRz6Js7tnX+uwvPPepwMYA3C1xvuShf2N9g==
X-Received: by 10.46.113.17 with SMTP id m17mr1404127ljc.114.1522490620440;
        Sat, 31 Mar 2018 03:03:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 15/15] ci: exercise the whole test suite with uncommon code in pack-objects
Date:   Sat, 31 Mar 2018 12:03:11 +0200
Message-Id: <20180331100311.32373-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some recent optimizations have been added to pack-objects to reduce
memory usage and some code paths are split into two: one for common
use cases and one for rare ones. Make sure the rare cases are tested
with Travis since it requires manual test configuration that is
unlikely to be done by developers.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 ci/run-tests.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ci/run-tests.sh b/ci/run-tests.sh
index 73e273fac7..857d144ee8 100755
--- a/ci/run-tests.sh
+++ b/ci/run-tests.sh
@@ -10,7 +10,10 @@ ln -s "$cache_dir/.prove" t/.prove
 make --quiet test
 if test "$jobname" = "linux-gcc"
 then
-	GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
+	export GIT_TEST_SPLIT_INDEX=YesPlease
+	export GIT_TEST_FULL_IN_PACK_ARRAY=true
+	export GIT_TEST_OE_SIZE=10
+	make --quiet test
 fi
 
 check_unignored_build_artifacts
-- 
2.17.0.rc2.515.g4feb9b7923

