Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B775AC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 05:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358590AbiATFdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 00:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiATFdq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 00:33:46 -0500
Received: from tilde.club (ipv6two.tilde.club [IPv6:2607:5300:61:c67::196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED7C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 21:33:46 -0800 (PST)
Received: from tilde.club (tor-exit5-vie.linkspartei.org [89.58.17.76])
        by tilde.club (Postfix) with ESMTPSA id D3A76220A9909;
        Thu, 20 Jan 2022 05:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club D3A76220A9909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1642656811; bh=pRsiBHIcS5xTTPInMLOkzsrkBJ/jcpnBFDCYQcnF/ZY=;
        h=From:To:Cc:Subject:Date:From;
        b=yQ3CStr9oPNG4+9jOlP3OHHNQnzHgJwNmNqIeZjUfW5g4PrlzrZDpfyHpomBViHXR
         4PvIGc2lS1bG0n2zDIPC88OpY0DdZQd9i/zMWWfpquans3vj54IcNoeyHdhgmOFcWM
         ZfvmqIXe2l/tvOcxTdgI9UGkENITHLKjqovUezx0=
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     git@vger.kernel.org
Cc:     Gwyneth Morgan <gwymor@tilde.club>
Subject: [PATCH] signature-format.txt: Note SSH and X.509 signature delimiters
Date:   Thu, 20 Jan 2022 05:32:24 +0000
Message-Id: <20220120053223.221667-1-gwymor@tilde.club>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This document only explained PGP signatures, but Git now supports X.509
and SSH signatures.

Signed-off-by: Gwyneth Morgan <gwymor@tilde.club>
---
 Documentation/technical/signature-format.txt | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index 166721be6f..c148d4c750 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -9,9 +9,22 @@ is about to create an object or transaction determines a payload from that,
 calls gpg to obtain a detached signature for the payload (`gpg -bsa`) and
 embeds the signature into the object or transaction.
 
-Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
-and end with `-----END PGP SIGNATURE-----`, unless gpg is told to
-produce RFC1991 signatures which use `MESSAGE` instead of `SIGNATURE`.
+Signatures always begin and end with a delimiter, which differs
+depending on signature type.
+
+PGP::
+	Signatures begin with `-----BEGIN PGP SIGNATURE-----` and end
+	with `-----END PGP SIGNATURE-----`, unless gpg is told to
+	produce RFC1991 signatures which use `MESSAGE` instead of
+	`SIGNATURE`.
+
+SSH::
+	Signatures begin with `-----BEGIN SSH SIGNATURE-----` and end
+	with `-----END SSH SIGNATURE-----`.
+
+X.509::
+	Signatures begin with `-----BEGIN SIGNED MESSAGE-----` and end
+	with `-----END SIGNED MESSAGE-----`.
 
 Signatures sometimes appear as a part of the normal payload
 (e.g. a signed tag has the signature block appended after the payload
