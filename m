From: tboegi@web.de
Subject: [PATCH v6 02/10] convert: allow core.autocrlf=input and core.eol=crlf
Date: Fri, 22 Apr 2016 16:53:46 +0200
Message-ID: <1461336826-5068-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:49:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcOu-0003H3-12
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbcDVOtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 10:49:40 -0400
Received: from mout.web.de ([212.227.15.4]:51616 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060AbcDVOti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:49:38 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MGiLB-1ayF730sHx-00DVnl; Fri, 22 Apr 2016 16:49:36
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:UsvmxeAhZ4gFIFgkbzxIv33Cq2mcHZSX94FylrWrMy4545Y0GWy
 WkQphSdm1fy20EC977C84BtWu5TojkrpGe6Alenp2GE+IhtOjJtnMyezFQpTVx/9FCDFdME
 3pVj8AmV3c/O/JONfpq7CWPPVwefJGCr1efyyeczUh/TiuVGWKdZa4Vw7GqxGMY90S8IlRL
 93TRZu2b7LcKUMI/dxlrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2iPFr+14MuU=:5m4LUYna8RJQB1sTMb3heH
 aNLAQ1HYDypYwCwDpxnHU7vq2m9hV+aKWPMCfz2iC28ddfjsDTfm4iwH+HD6Vceg/bB/ZwG2V
 xAXV57s4qhAEN8dVRUUdWFdUlqbkaLH+44JvaIu82ukIhrb2rYXGO09O/KxyL9uTgt0bMtT8T
 GGHLbzMlsaUXsYdbu4ZE3kVKYNliUiCiKH6kmGfbY9y0MNpgFIZZM8ylS2Sz3RQ7ym4uaEqP0
 d0vRiok5FNXdQlhwFdiNXk4+93c2Va5B2en88DO7RxNkrR1sXHiLh97PT9Dy812RL5UPIYg/y
 qSoBV85l1cwBIS2MI/CqJ+qQlZWJhJmPnujGYhs78wQGUuqfd3rs/KxxE2nmxWe7rqsSVBc+4
 PxQOjtP4rw6p+LOYq2oIhYh+/llSHAdH8hUSI5NSCr/NejJm1FpHAeTL8Dy7qsi06TtT5nOps
 CVfWc2jqo2R2dxFDRFqV/2d5rhKq5rtRr79pbfBE8/zxcaO80WjVk8DCmFIMEcIum0e4YGfvR
 ZPh+5+4LELrn2L3kyh5EOV+gHpMSW/pFAbKa+6fkKO7SmSvI6KJoJpZOwHagtq7VNVdiTt6CL
 oE4S8gVDXrrQBwF4fdLUD5Oi7UKOiLOtIqPbCLQvvZmBQswy0c0DTVp5U4+wrjQTz/b7tWal6
 u8PiZbhq6aY76lQziI70KzGWIRUUeoSQNZyClfmIoE1lvDPthu7sPlR6C3kMispjBg+xuXJES
 CmJFWfJi19ymZfFsxZ02FKn0Lth8pWiXNlAfdo/Lx4zTihddDIriubwSqMIuJt/QIHtNF7ZD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292210>

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
