From: tboegi@web.de
Subject: [PATCH v8 02/10] convert: allow core.autocrlf=input and core.eol=crlf
Date: Fri, 29 Apr 2016 17:01:55 +0200
Message-ID: <1461942115-15982-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 16:57:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9rJ-0006oF-CM
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbcD2O51 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 10:57:27 -0400
Received: from mout.web.de ([212.227.15.4]:56842 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbcD2O5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:57:25 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0M1FqS-1bpES31B2e-00tEkw; Fri, 29 Apr 2016 16:57:23
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:oOTlxq0fviUJvBokvXjBmFhsFrWjKCOGxZrN13E1RyQJTYPCuC7
 vRXD3A0IaMiOvaSKvCtb7NiJwJNwuNJjqZB7hFCs/wJYHeQ1GJLA6Pd8LTDwY2++PcgGOkg
 wo8K6xtvGNa3ezmqB+N8LHckiv9JbH0+h1B85SJlaPGiBzlGCyt5a8EcpUN4uFK69gJcci3
 CR72K/zcaAmskhkrcaPVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pZeMh9BgYM4=:wOuT4wQUhJvMei0uSPUcDc
 CTHmcL1vu97fnVCeY4nMu3nieuJHVwakafHVnXQs/ChwS4PaBdpNVc133m2doE6DfwWozomZq
 pqLj8JKSmT3FL+bx2eAglZzm/U5f2yfrEDJCq9ZlCP5FuboLaRiCswmeXO9DErniGBNSlEBdV
 QPMT4ZNxzyMf71o9MEH1TbRS7r3JyGxKM0bWuSD18wtBn5C7D1JHgi7MX5CkCupuShMiKIjpw
 xueFTnY7Aa/INDQr84NZayFwcNFR0frFT33p7xP9/a03h6XfkZeR2W7pkn5i+lsWH7DZCcT58
 xdaduuRc8eX5Pd2YxLrKOwyXtsXd9CC62wSBC7L9rGDJ1IART1NsbKTH6Wezfe5gLPmIbC+ki
 3pa0m2CdS4MaWX7jbt4+4XWEnsfzRNZVowFtlxswQ/hf2bUjU1PULT/F5jOiGL9yj98VJR406
 wkP6Opo7Lada3SFiuEMoQv9CAenjG+0L62LvCadFm7qH8IgDq3JxKkF6ZOaQkbfjKsvUbKwlG
 +JsTxFC/73Plyo0tUOgza4i8cktoadswO6hrUx63w74rAaIcmFCrwZs0A2pjNwG+06ojqkc95
 eehg1Z/LjJibs+ckAe2HDmFUj18387bKJjXwaPxlG7YUH1Y7fbvGC91cpRLOgLL1wB5nESqF7
 EqkVhYMpPi44C6Wy4yElVgRpIU6j4Ntm3tIbMMuXIcoDnhMxsF5BDUpAjuymk8CdNkv6OevGQ
 m/OO1nPEg39ibhHn4YkcRgh2faTFTHBMZF/62u22kSH7YW0eTNrJfYKWrgdfN3/iggdJamYy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293008>

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
2.7.0.992.g0c2c796
