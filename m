From: tboegi@web.de
Subject: [PATCH v5 2/4] convert: allow core.autocrlf=input and core.eol=crlf
Date: Tue, 19 Apr 2016 15:26:00 +0200
Message-ID: <1461072360-2796-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:22:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVbh-0004Qt-VM
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbcDSNWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 09:22:11 -0400
Received: from mout.web.de ([212.227.15.3]:60632 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbcDSNWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:22:08 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LjJaZ-1bSgUx1bnb-00dUwG; Tue, 19 Apr 2016 15:22:00
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:sX+Iq753EQpIn4ZzMoYNd9pzfBeHjS17zClmYdS9njgRxErDuIy
 lv8dKcyJdQEZO3eWR7gZB09TqWShqoF/zDXY7cB+W7U73TIdyTzS9x+oAAWKreO+SdA81Co
 wtPF4i9r7PCeqz6KCvWE14PFW6apzXyC8//f6oBRRfHlNJDeO5Bx0mLLHsNBQ5iTe/wT51c
 oTToqrdJbHSMxDt1FRSKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FEqMu2nA+Fc=:bzAwtKqLOJQUTVgJ8zUR2V
 Jae0al4G4Hp6WHCBJCRaUkybnI8rDjgtG3R8CUTO/TH4W0UlEeRRTfJbkD/dQwd4wNqyFUque
 szHK0TG2T/AD5LmpdW/IpfzonleUWJG/uQgWrRJwJo66fxu35AbxvCus8UbRW0NRIEMGwlJO8
 0XF0i/KjrR9wr/GHbWnt6VH/+wc08JPznlXOYH0rzLvOchzeeaE01Z21dX06nGKJJXaef9wAs
 5XAPBSIfM9jetERmaEwZqDms47sm3ByNwy95yBOCkcL13PX40fftQBGTfnq4Wmfe9rBbzgb72
 5E32t5yvFVXaepL2Ig8Y/3bnMZCjZ/Fe9K+CyI6GfMACOqt2L5Ws2hfQ37AUTb7EdpLMD5xi7
 cQFDQeKlphRzYJdvVN4PEl2v6rxWR6iR3MDbRu4ryiKazT/KNzMRJUnQom1mzhPf27fAyVY2r
 wwhMdeRhscWxATnACjIF+kkQmtOtCI4ns2Brht6KqyUKlNl44Vbh05kpxH0vvj9LH59UBn2Sh
 24fWYhbJwLYg1wN7/+nAhn4Gu0AEd4ZoW1jGrYAr9/LJTdtME94TY8Dvuy393wL2AnbtnrQiW
 Osj6UYCwZ/Xs3D4fE2nVIdZgJWe9dql7iH10gm/pxvrH3qbe4kfwNXEW3iToy78aGtezTpK8H
 2KNwdhDxSka/7GttdnXnHG8+7jjgWYXSTUdCpuv6vjrB0lDvGaZZfF4+Avz0KK2rCwLzvIiyY
 hu6kznVspKZVqgFn6m79blMeJtPMIYwQlKgqwftr7FsLodga3XCRyFEry2LQ6WmcOLWJhd+I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291864>

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
index 42d2b50..155f988 100644
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
index 4c92699..c8ac9c2 100644
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
2.8.0.rc2.2.g1a4d45a.dirty
