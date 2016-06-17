Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357C120189
	for <e@80x24.org>; Fri, 17 Jun 2016 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440AbcFQHqV (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 03:46:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49814 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754013AbcFQHqU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 03:46:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 5363D20A76;
	Fri, 17 Jun 2016 03:46:19 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 17 Jun 2016 03:46:19 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=wlMRi0z9Zj6RBVcHon798w9GezE
	=; b=YA6jauvRIqjQIoi/VH1lKSKKf72Ip8FHBzDB7yypwrMO5Co/AP5querJVgT
	IhptFUeFQeU0gYrm2DqV94UfIXaRck+uORq7mIJj01NuV2gR+UtfsOSuMRjI9IqE
	j8wzT7YixVnksJN3/08gVp7dxcIXCjbL/qZ7o5Rdffgxld/4=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=wlMR
	i0z9Zj6RBVcHon798w9GezE=; b=W5vML+12M1z41RS5I5e4f0S+WJvbjSGDlruk
	0k7bHAxp1A2+9Sk9cSToOmsL3bdMEXo2rsAMbPAksi7xwhTUnuFhF35wx9MvtBJK
	FQsY9rWMwcC/dbIA4kwY40DVWCw8AZh9yk45ZwXN7+8g4uq4pnqVV6zsM6g4cdKB
	4dwU2us=
X-Sasl-enc: kAtmiA5PIjMBBiMvOOmLUTNKa5VyouZvXG6ap+zVUeRI 1466149578
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id D77A0CCD34;
	Fri, 17 Jun 2016 03:46:18 -0400 (EDT)
From:	Michael J Gruber <git@drmicha.warpmail.net>
To:	git@vger.kernel.org
Subject: [PATCH 4/5] Documentation/technical: signed merge tag format
Date:	Fri, 17 Jun 2016 09:46:11 +0200
Message-Id: <70e8fcb0e9cb73976b643aad1f72f1f0f41c553b.1466148698.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.9.0.382.g87fd384
In-Reply-To: <cover.1466148698.git.git@drmicha.warpmail.net>
References: <cover.1466148698.git.git@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/technical/signature-format.txt | 74 ++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index 8ae1dc3..7afd403 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -110,3 +110,77 @@ signed commit
 
 signed commit message body
 ----
+
+== Mergetag signatures
+
+- created by: `git merge` on signed tag
+- payload/embedding: the whole signed tag object is embedded into
+  the (merge) commit object as header entry `mergetag`
+- example: merge of the signed tag `signedtag` as above
+
+----
+tree c7b1cff039a93f3600a1d18b82d26688668c7dea
+parent c33429be94b5f2d3ee9b0adad223f877f174b05d
+parent 04b871796dc0420f8e7561a895b52484b701d51a
+author A U Thor <author@example.com> 1465982009 +0000
+committer C O Mitter <committer@example.com> 1465982009 +0000
+mergetag object 04b871796dc0420f8e7561a895b52484b701d51a
+ type commit
+ tag signedtag
+ tagger C O Mitter <committer@example.com> 1465981006 +0000
+ 
+ signed tag
+ 
+ signed tag message body
+ -----BEGIN PGP SIGNATURE-----
+ Version: GnuPG v1
+ 
+ iQEcBAABAgAGBQJXYRhOAAoJEGEJLoW3InGJklkIAIcnhL7RwEb/+QeX9enkXhxn
+ rxfdqrvWd1K80sl2TOt8Bg/NYwrUBw/RWJ+sg/hhHp4WtvE1HDGHlkEz3y11Lkuh
+ 8tSxS3qKTxXUGozyPGuE90sJfExhZlW4knIQ1wt/yWqM+33E9pN4hzPqLwyrdods
+ q8FWEqPPUbSJXoMbRPw04S5jrLtZSsUWbRYjmJCHzlhSfFWW4eFd37uquIaLUBS0
+ rkC3Jrx7420jkIpgFcTI2s60uhSQLzgcCwdA2ukSYIRnjg/zDkj8+3h/GaROJ72x
+ lZyI6HWixKJkWw8lE9aAOD9TmTW9sFJwcVAzmAuFX2kUreDUKMZduGcoRYGpD7E=
+ =jpXa
+ -----END PGP SIGNATURE-----
+
+Merge tag 'signedtag' into downstream
+
+signed tag
+
+signed tag message body
+
+# gpg: Signature made Wed Jun 15 08:56:46 2016 UTC using RSA key ID B7227189
+# gpg: Good signature from "Eris Discordia <discord@example.net>"
+# gpg: WARNING: This key is not certified with a trusted signature!
+# gpg:          There is no indication that the signature belongs to the owner.
+# Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
+----
+
+- verify with: verification is embedded in merge commit message by default,
+  alternatively with `git show --show-signature`:
+
+----
+commit 9863f0c76ff78712b6800e199a46aa56afbcbd49
+merged tag 'signedtag'
+gpg: Signature made Wed Jun 15 10:56:46 2016 CEST using RSA key ID B7227189
+gpg: Good signature from "Eris Discordia <discord@example.net>"
+gpg: WARNING: This key is not certified with a trusted signature!
+gpg:          There is no indication that the signature belongs to the owner.
+Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
+Merge: c33429b 04b8717
+Author: A U Thor <author@example.com>
+Date:   Wed Jun 15 09:13:29 2016 +0000
+
+    Merge tag 'signedtag' into downstream
+    
+    signed tag
+    
+    signed tag message body
+    
+    # gpg: Signature made Wed Jun 15 08:56:46 2016 UTC using RSA key ID B7227189
+    # gpg: Good signature from "Eris Discordia <discord@example.net>"
+    # gpg: WARNING: This key is not certified with a trusted signature!
+    # gpg:          There is no indication that the signature belongs to the owner.
+    # Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
+----
-- 
2.9.0.382.g87fd384

