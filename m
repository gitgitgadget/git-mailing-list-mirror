From: tboegi@web.de
Subject: [PATCH v7 02/10] convert: allow core.autocrlf=input and core.eol=crlf
Date: Mon, 25 Apr 2016 18:56:29 +0200
Message-ID: <1461603389-30678-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 18:52:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujkV-0000Rw-By
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbcDYQwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 12:52:23 -0400
Received: from mout.web.de ([212.227.17.11]:61301 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933130AbcDYQwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:52:17 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MeSKR-1b4Inm2vtv-00QD86; Mon, 25 Apr 2016 18:52:09
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Xrs8P7E7ZI+SOLACKF2N35OQ2Lz346dAQ78aUJeplk8feudBOiw
 9GAcdWlnudV4HOzkg1S+h8TJ1RVDNNWYRIiV2p2euJubDqzSK6wj279O8wjPZYrQCPv3ZqX
 bcAkP4zsGyQk1zyit8Qku5TFi+JyUrqko7pZh8sEhxiFOPmMbSNx6M8Fjry/MLQ+RPN3CZC
 LYYZEvM3g/QTbpfpi0eCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eMs0OdWhzWI=:01HnpuopP+4X8BYWTvwTur
 LNntgGjcrsNRj8tZI3EEGSraRoALtXx4nwAgpEEAdv+Bhj9jp7sd8lYRgl4PsGVRH6wRozl+p
 ppQ97YPJ6iEMPr8tkVo7cQcqrs2JvCzgNY8Q6D+s7b1CJymAZb8ZlmwV8Zx3tKzKwemSDd3//
 k3CnGD+CimkYisPPHLdNGLwpc+PEK2q3a3wPoHvQkHRtgev7iYespYJwIvWDsresGY181YfL8
 rUAK9v38SNWYLKHx8IIziBx1IopFqVBTvHA5GLMcEhQawefPj76zCTCdKWz7+RA74rgvyQHB/
 wgl8dBnP9t5Sjw0Y9y5CHhCYbs73ggbAH52DQJPS6dFU4ZsR6Hf9p5CMyMWURu3Fo7gRE+eM1
 bLbq4SnTu6KsYivGLJBolBo+JKrkgOpY29iWrbXkzaY+zL4hlELqQbvpavNkiV0f+z2E2SLBg
 4SsdwQ7OvGp6KTia44iQv3ryR0UzHVbwZj5PcpaikjURNI6Iq5u0XLLLkZOQfoafBrc4MPtyN
 LDT8wCKvLzGGoYs9WI+Mmo/C5PczerR35pGbs7RdVZeth9MRDao2hkG902F7uDeYd5a6Co9Zg
 nXpiiNnyw+/NYxp4IUML87ewCANkGez3kX718Fl+433cjkNIFT0tsm7wpZDnKzDvKOpmtTjOc
 3XzkXIAVVQXg80eIGMmrk080vMsA31iTAo+BUIXh1MHgIsaJze+z44zYZ7XWukjO2EHJYNFTH
 cYedNUBRfLvd/3wlY67gIO9BUR8Xg8lqizGRaippBW9OArt7J1BfgkJgNmLEUJe0TkKTv2X7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292515>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Even though the configuration parser errors out when core.autocrlf
is set to 'input' when core.eol is set to 'crlf', there is no need
to do so, because the core.autocrlf setting trumps core.eol.

Allow all combinations of core.crlf and core.eol and document
that core.autocrlf overrides core.eol.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Documentation/config.txt | 6 +++---
 config.c                 | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..4a27ad4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -337,9 +337,9 @@ core.quotePath::
=20
 core.eol::
 	Sets the line ending type to use in the working directory for
-	files that have the `text` property set.  Alternatives are
-	'lf', 'crlf' and 'native', which uses the platform's native
-	line ending.  The default value is `native`.  See
+	files that have the `text` property set when core.autocrlf is false.
+	Alternatives are 'lf', 'crlf' and 'native', which uses the platform's
+	native line ending.  The default value is `native`.  See
 	linkgit:gitattributes[5] for more information on end-of-line
 	conversion.
=20
diff --git a/config.c b/config.c
index 9ba40bc..a6adc8b 100644
--- a/config.c
+++ b/config.c
@@ -803,8 +803,6 @@ static int git_default_core_config(const char *var,=
 const char *value)
=20
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
-			if (core_eol =3D=3D EOL_CRLF)
-				return error("core.autocrlf=3Dinput conflicts with core.eol=3Dcrlf=
");
 			auto_crlf =3D AUTO_CRLF_INPUT;
 			return 0;
 		}
@@ -830,8 +828,6 @@ static int git_default_core_config(const char *var,=
 const char *value)
 			core_eol =3D EOL_NATIVE;
 		else
 			core_eol =3D EOL_UNSET;
-		if (core_eol =3D=3D EOL_CRLF && auto_crlf =3D=3D AUTO_CRLF_INPUT)
-			return error("core.autocrlf=3Dinput conflicts with core.eol=3Dcrlf"=
);
 		return 0;
 	}
=20
--=20
2.0.0.rc1.6318.g0c2c796
