From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Wed, 24 Nov 2010 21:03:53 +0100
Message-ID: <1290629033-20566-1-git-send-email-flameeyes@gmail.com>
References: <7vwro2sd83.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 21:04:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLLZi-0005G4-8E
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 21:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab0KXUEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Nov 2010 15:04:13 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37936 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257Ab0KXUEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 15:04:12 -0500
Received: by vws2 with SMTP id 2so122089vws.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 12:04:12 -0800 (PST)
Received: by 10.216.38.84 with SMTP id z62mr2964136wea.70.1290629051058;
        Wed, 24 Nov 2010 12:04:11 -0800 (PST)
Received: from localhost (host249-252-static.95-94-b.business.telecomitalia.it [94.95.252.249])
        by mx.google.com with ESMTPS id x65sm3659490weq.1.2010.11.24.12.04.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 12:04:10 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <7vwro2sd83.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162077>

When using stricter linkers, such as GNU gold or Darwin ld, transitive
dependencies are not counted towards symbol resolution. If we don't lin=
k
imap-send to libcrypto, we'll have undefined references to the HMAC_*,
EVP_* and ERR_* functions families.

Signed-off-by: Diego Elio Petten=C3=B2 <flameeyes@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 1f1ce04..c8377d4 100644
--- a/Makefile
+++ b/Makefile
@@ -1927,7 +1927,7 @@ git-%$X: %.o $(GITLIBS)
=20
 git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
-		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
+		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
=20
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLI=
BS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
--=20
1.7.3.2
