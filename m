From: tboegi@web.de
Subject: [PATCH v3 4/7] convert.c: use text_eol_is_crlf()
Date: Fri,  5 Feb 2016 17:13:25 +0100
Message-ID: <1454688805-20832-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 17:13:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRj0G-0002aU-A5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 17:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbcBEQMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 11:12:50 -0500
Received: from mout.web.de ([212.227.17.11]:54066 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbcBEQMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 11:12:22 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LhvyA-1ZfnFe4774-00n5IJ; Fri, 05 Feb 2016 17:12:21
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:cO2TAboRsTGhUB9T5dNrTPYLgAxDUy1bFk3LINgMkx+97SPjoky
 bwx9P5GJFUnGIC95hrjyPU2LrzgJZ/aaqD6SVl29WsIgakoVUsNTx5yOlztcCuNfFAXHqoM
 kMCfA4u8gbMlCW7rlU7Xul0aLjvOKR1mSDo7Li9N20sE/G0mIPr9pWZ163pZJiHPcDts/eM
 0odMy/fLHdhv5DFAqFpxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pLBXmaD0y/U=:Rg9nwTKfDPG21QPDqvpeme
 gb8QVDXDZC9Q1W+tEY1BGDzrfEB6qoQfh/gNgnpKlK13j3NdPOWenv3jDQoE57y80BEVZyQfE
 LugDleKydHT4RibxX/n793oI9pPnPoiF/X+SHKmaTk59icE7kkDwIBVwLF48ZnoIlmf/r0Yp1
 NeflgwJyzsziLeFcJfFLEn97nNAEpHPCRJrBdgXhGSY0rKJHOZWBPOTw7qtyRrMjcAZJP21sT
 Ky6YTyEDRVphuAI0qj5h/FhQvRKPOWP+VLBgSf2WIKfLQPzPWL0w8IOHPCHqZIfDRiA3FVqXD
 H94xbxH/POSpvcahDdW5ZcvcCDoKtKGsdrTw8sYfLjXh4sBswJHNOW+mrx4nq677lTLJWsG5T
 bmPU0T/odlRFdZAQljUzU02bGTFxbo0L88gwzbPPtapNxy1i+tr9QihzUjks3bhSZujbWYjJA
 uDBx44jfQfyUJqdHkC7xGzXPp/VsHz6vuZIfD5BlIpAm5PLgCnQYKY5JRpzl/yhOOtNLgIwBW
 LAtLsYcGSuPgDRAOkv4N0sScnev8DY6fTdQ/Mka5yfQlYoYxdMMrCgwk0vZpa+RmLmfiS/+qy
 EOmc73j5NT2mBCLijOkmXMSMb+MyqH8OjGtnF99CFelAe6pdFnTYA45M6E1z4xeHhpFUNSe9s
 S7MlKbRL+4HgXY+/71WqpE3ttD3oB9LJ6gKYE12Jh+NCUX9qEUSIsApYVDd5hr56ubMGnZLUP
 2dpB6HIY11Zqx/mpW4VAETaqkC+HejtzUB7n1SF+1IRhQlixvzllAZg3A6xjQK9xtRXwQSC1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285587>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Add a helper function to find out, which line endings
text files should get at checkout, depending on
core.autocrlf and core.eol

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index d0c8c66..557e574 100644
--- a/convert.c
+++ b/convert.c
@@ -149,6 +149,19 @@ const char *get_wt_convert_stats_ascii(const char =
*path)
 	return ret;
 }
=20
+static int text_eol_is_crlf(void)
+{
+	if (auto_crlf =3D=3D AUTO_CRLF_TRUE)
+		return 1;
+	else if (auto_crlf =3D=3D AUTO_CRLF_INPUT)
+		return 0;
+	if (core_eol =3D=3D EOL_CRLF)
+		return 1;
+	if (core_eol =3D=3D EOL_UNSET && EOL_NATIVE =3D=3D EOL_CRLF)
+		return 1;
+	return 0;
+}
+
 static enum eol output_eol(enum crlf_action crlf_action)
 {
 	switch (crlf_action) {
@@ -164,12 +177,7 @@ static enum eol output_eol(enum crlf_action crlf_a=
ction)
 		/* fall through */
 	case CRLF_TEXT:
 	case CRLF_AUTO:
-		if (auto_crlf =3D=3D AUTO_CRLF_TRUE)
-			return EOL_CRLF;
-		else if (auto_crlf =3D=3D AUTO_CRLF_INPUT)
-			return EOL_LF;
-		else if (core_eol =3D=3D EOL_UNSET)
-			return EOL_NATIVE;
+		return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
 	}
 	return core_eol;
 }
--=20
2.7.0.303.g2c4f448.dirty
