From: tboegi@web.de
Subject: [PATCH v6b 02/10] convert: allow core.autocrlf=input and core.eol=crlf
Date: Sun, 24 Apr 2016 17:11:19 +0200
Message-ID: <1461510679-20927-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 17:07:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auLd3-000605-Jt
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 17:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbcDXPHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 11:07:08 -0400
Received: from mout.web.de ([212.227.17.11]:54627 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbcDXPHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 11:07:06 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MHY5w-1ar3pz2YIu-003Kh3; Sun, 24 Apr 2016 17:07:03
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:gQshTTikiOKjJuDFjjhEMUdKbYO3SFRl0LrfNnhra/TiwfB+UKI
 0OEuvAOZzt2J7ivhneIk/aH5fSU5EPW3mIJ4Ihy1num6PlUlFIQFE3nZCvtG9hjdw/L9GNM
 6sUuUIHpyQsQ9gSkF8ROVWyicfBW+UCR91tPsIyqCLHIhEQ/+0kFZ3+0RoL3/UgUNLb/vyp
 Zh/ap6184ijR9g41Sr2hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g1zHTIH0rkk=:mN5HdvygQITwpj6eOjh67n
 OIzjFZC6TP39SvXTzFOYHDRROKYxQpJaTw7d4cSMZq78h98IljbY6Wbq9kyc9f/PRhWOL7nT9
 YihaK416lp8JkesoX9rPi/085xNUleT6wHHoOc8c9P2KT/0t+p2l69RmTbFPNIu29UOaufuZZ
 0G8iowpUSt7ciNp4QJwE88i5uChk0ynoAegNWDkCmyCbZY54ztEiyKBBJ0BEZi0ptvR6+AsCl
 2OXZuzQFPMYpPH57M5zWVjBIDjmIB1oVWWMjLCRfbN5XQqkj/3dnjsNh9fBKyXbnmV2XRMLBg
 0AGi86INc9K1jy69V1N/9o9b9sRy4tQNHpGGFDcqfn1t5bvDM8GfQr6e42BgphjXEhRnWweUF
 CKlf04T2YtI0OoBfGKEIOLg+zLqXm/WLbK4IGMJ5zhWxDztX2hQe7UT7dl72/wCrGNRrT3obn
 2d7KEVNPot64RNmejHnzz+SOMlenDNRprQ5EJELjaCeogpeVBV3mJRfmmf8bTaVqgUX6oGHEa
 9jZo65XJbeBD3c2DgTBlMCbVJkOEWS89+Z3/oCg7h5kyJ6h02jsnleD7uvcm3L64oHMBNssBn
 YM2gd3A/kssn3NRjn65gSGXwsSShaNX5mB4A7ro6NsW2fPUH1y/+IQdN6KdvUThxdTi6Hb72A
 7XJVt22z5pWZwLTfs5LbcucQPA5BYqIzdITNz9j5sLYtOzKA8sOO/8LCQfiJa/Mti1XGoIsvd
 D/QLOQXsN2GwzxRoUL+suuiIst+9BGpIqQUAIcFAxx+gxpIaxUjhyofU1phMlPun/r7irky1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292407>

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
