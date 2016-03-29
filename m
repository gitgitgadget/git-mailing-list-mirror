From: tboegi@web.de
Subject: [PATCH v1 3/7] Allow core.autocrlf=input and core.eol=crlf
Date: Tue, 29 Mar 2016 15:25:34 +0200
Message-ID: <1459257934-17272-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:22:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktbd-0001FM-5e
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbcC2NWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 09:22:45 -0400
Received: from mout.web.de ([212.227.15.4]:51365 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbcC2NWn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:22:43 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LegAQ-1ZwmH10paw-00qQuM; Tue, 29 Mar 2016 15:22:41
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Xk6eDHsljSKngIn0aTHTDs9ZHMgHdMTtlWrk5As5yVy9LfqYI5H
 +dEHwiXuSFK6UoSRcGg+KBWbs9J2mMHQ9cUOnbTgEETFF1559lMiipB+Iub+xua5nZ1vbUO
 7gegNwTuqpZtDlRd4ibludnc/A9pch8A385SI/pyBboMRr7q1E430EwKaCkdDqCmWE85uzX
 wXdgvzJTVMeA0O7CxSvjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:siixYZ5wE3c=:Htd6wgonEwKcY5TineOFq/
 RlQ20oaO79otj6qKrDtI2E3y0pXwjgQvIjSrikBcZvWmqjowvS2R1Y+IEI7932gpVfhFWN1S6
 AbdXkDZaILvPsCA9eJDgaGgEFlK/aKewB9ZnKd+WK9hsNVBAAbvMUFJrn9rqYpch7wwdnDrB5
 QnktadXyPgmCEmRpBV5xnFCx27eSZpfgF7m8bAVHFnOItnrBwIX3yQ+dFFjpaK531xP0VIy3+
 wbBFYMgzAjWgY7VBip3W6uZnScZlKLVXVvQUhK8NNCi13H+ztXwVqZneUZy+N+0NKCnWtA+Bk
 URFBqJOTIpHHTkFP3dUCT+jqYl4gR7nNaqehR7oeNR1mQrfN7vdx0DZ9A5ZgdPs0iSgvMzAGr
 bK3vIZm3BSp7+b+2Su7ZZvLEUoraem72VjUT7okTxL59cE6YsvnxdtwpSVKhP1lejno+e6tKT
 a2uCclQh+qaKU32sCL3wtBlKox7FW4QSG43PzVYhAkXt6ddAY25S2ekBXgWw8vpuicL+7ZlGk
 jNPO/Q2MHhOYQuF4hkYPc+Mu0SP5eQIYZ2HgAXvIIa6f9QJG22aGdbU3hPMsej+ckU9e5f4j3
 6ksf6oMRxbh6wu6m8rFB74g+wBlTU/y83ETVpMJDEsN24KuhTv1weHfNmQMjJgZw6JHl4OA92
 z4U9ACIJ1soQ46H2DI+wg0zuJzpqN5o/VLJwVF/F25aa7kNIKzVT8mQJVHSyAeCpx6WBCeIJq
 9JQ7MDPWGgtxrcntYHG5LmQ/2HRaB8hTvm9yQ6zpjowyrK+jljgyv6sboflByCXMFHZ7KZ/g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290128>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Commit  942e77 "Add "core.eol" config variable" adds a condition to
the config parser: core.autocrlf=3Dinput is not allowed together with
core.eol=3Dcrlf.

This may lead to unnecessary problems, when config files are parsed:
A global config file sets core.autocrlf=3Dinput,
the repo local config file sets is own configuration: core.eol=3Dcrlf

There is no need to prevent combinations in config.c, in any case
core.autocrlf overrides core.eol.
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
2.8.0.rc2.6.g3847ccb
