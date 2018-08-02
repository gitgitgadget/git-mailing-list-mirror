Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE941F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbeHBQS7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:18:59 -0400
Received: from ao2.it ([92.243.12.208]:54923 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732272AbeHBQS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:18:59 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv8-0006i0-R6; Thu, 02 Aug 2018 15:45:39 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwR-0002hJ-5T; Thu, 02 Aug 2018 15:46:59 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 07/12] submodule: use 'submodule--helper config --stage' to stage .gitmodules
Date:   Thu,  2 Aug 2018 15:46:29 +0200
Message-Id: <20180802134634.10300-8-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802134634.10300-1-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use 'git submodule--helper config --stage' in git-submodule.sh to remove
the last place where the .gitmodules file is mentioned explicitly by its
file path.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ff258e2e8c..f20c37d92d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -289,7 +289,7 @@ or you are unsure what this means choose another name with the '--name' option."
 	then
 		git submodule--helper config submodule."$sm_name".branch "$branch"
 	fi &&
-	git add --force .gitmodules ||
+	git submodule--helper config --stage ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 
 	# NEEDSWORK: In a multi-working-tree world, this needs to be
-- 
2.18.0

