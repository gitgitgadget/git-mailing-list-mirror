From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 05/10] Make PGP macros global
Date: Thu, 17 Mar 2016 19:46:56 +0100
Message-ID: <1458240421-3593-6-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:47:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxZ-0007X0-Jf
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936598AbcCQSrn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:43 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43314 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935942AbcCQSri (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:38 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id C8F1C58C4CC;
	Thu, 17 Mar 2016 19:47:36 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:36 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289148>

This commit moves the macros PGP_SIGNATURE and PGP_MESSAGE to gpg-inter=
face.h to
make them publicly reachable, which is necessary for RFC3161 time-stamp=
ing.

When verifying an RFC3161 time-stamp signature, a SHA-1 hash has to be =
generated
over the git object excluding a possible PGP signature, which makes it =
necessary
to detect the beginning of this PGP signature.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 gpg-interface.c | 3 ---
 gpg-interface.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 3dc2fe3..4b42860 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,9 +7,6 @@
 static char *configured_signing_key;
 static const char *gpg_program =3D "gpg";
=20
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
-#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
-
 void signature_check_clear(struct signature_check *sigc)
 {
 	free(sigc->payload);
diff --git a/gpg-interface.h b/gpg-interface.h
index ea68885..04b0eab 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -4,6 +4,9 @@
 #define GPG_VERIFY_VERBOSE	1
 #define GPG_VERIFY_RAW		2
=20
+#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
+
 struct signature_check {
 	char *payload;
 	char *gpg_output;
--=20
2.8.0.rc0.62.gfc8aefa.dirty
