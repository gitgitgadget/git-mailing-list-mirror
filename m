Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559901F744
	for <e@80x24.org>; Fri, 17 Jun 2016 07:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbcFQHqc (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 03:46:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42772 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754006AbcFQHqR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 03:46:17 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DF4CF20A87;
	Fri, 17 Jun 2016 03:46:16 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 17 Jun 2016 03:46:16 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=JgfkFUegOQ2uQ/IG/SPgqeXpkv0
	=; b=HEhaQFfwtrbR0ZOGNPysgWT5WVQXG80rk+4dfDpfMh1cjy4cCjuFVE9zFso
	gCLMCGm+I14dstF9yo78goa8lmBDK2n8k1VVI38Aghhzy9AfbNGaboQ9y19l2Jw+
	qUqXPiikPp/AEJpZXFx/D6avbqkySmKtBBaqMHrbuHCjw1XU=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Jgfk
	FUegOQ2uQ/IG/SPgqeXpkv0=; b=uDvCsttH4whulpaN1r3O6Z/zZ9CWXxxkgEZI
	zzlA3UiwnsDNXs8fXsL5AycvjmXAKi+Fpm4c97wv/opmORQoCNmo1SZTOzdHUnU3
	ksEZ85Db5vR0pMZgw50NzCosfdYzq9atI6TMJ9jFmnOKz9BN7vWTFGOrdSJavKUI
	kwXwkTA=
X-Sasl-enc: /NDfOe6sjkI0W7onqVms5FOblnYM/aDheMN5AiaBtXQD 1466149576
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5AFB0F29F3;
	Fri, 17 Jun 2016 03:46:16 -0400 (EDT)
From:	Michael J Gruber <git@drmicha.warpmail.net>
To:	git@vger.kernel.org
Subject: [PATCH 2/5] Documentation/technical: signed tag format
Date:	Fri, 17 Jun 2016 09:46:09 +0200
Message-Id: <353d5207e2e080b50a0262be8d29353c42a51097.1466148698.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.9.0.382.g87fd384
In-Reply-To: <cover.1466148698.git.git@drmicha.warpmail.net>
References: <cover.1466148698.git.git@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/technical/signature-format.txt | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index fda4fb8..833afff 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -15,3 +15,50 @@ produce RFC1991 signatures which use `MESSAGE` instead of `SIGNATURE`.
 
 The signed payload and the way the signature is embedded depends
 on the type of the object resp. transaction.
+
+== Tag signatures
+
+- created by: `git tag -s`
+- payload: annotated tag object
+- embedding: append the signature to the unsigned tag object
+- example: tag `signedtag` with subject `signed tag`
+
+----
+object 04b871796dc0420f8e7561a895b52484b701d51a
+type commit
+tag signedtag
+tagger C O Mitter <committer@example.com> 1465981006 +0000
+
+signed tag
+
+signed tag message body
+-----BEGIN PGP SIGNATURE-----
+Version: GnuPG v1
+
+iQEcBAABAgAGBQJXYRhOAAoJEGEJLoW3InGJklkIAIcnhL7RwEb/+QeX9enkXhxn
+rxfdqrvWd1K80sl2TOt8Bg/NYwrUBw/RWJ+sg/hhHp4WtvE1HDGHlkEz3y11Lkuh
+8tSxS3qKTxXUGozyPGuE90sJfExhZlW4knIQ1wt/yWqM+33E9pN4hzPqLwyrdods
+q8FWEqPPUbSJXoMbRPw04S5jrLtZSsUWbRYjmJCHzlhSfFWW4eFd37uquIaLUBS0
+rkC3Jrx7420jkIpgFcTI2s60uhSQLzgcCwdA2ukSYIRnjg/zDkj8+3h/GaROJ72x
+lZyI6HWixKJkWw8lE9aAOD9TmTW9sFJwcVAzmAuFX2kUreDUKMZduGcoRYGpD7E=
+=jpXa
+-----END PGP SIGNATURE-----
+----
+
+- verify with: `git verify-tag [-v]` or `git tag -v`
+
+----
+gpg: Signature made Wed Jun 15 10:56:46 2016 CEST using RSA key ID B7227189
+gpg: Good signature from "Eris Discordia <discord@example.net>"
+gpg: WARNING: This key is not certified with a trusted signature!
+gpg:          There is no indication that the signature belongs to the owner.
+Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
+object 04b871796dc0420f8e7561a895b52484b701d51a
+type commit
+tag signedtag
+tagger C O Mitter <committer@example.com> 1465981006 +0000
+
+signed tag
+
+signed tag message body
+----
-- 
2.9.0.382.g87fd384

