From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] status: add --long for default format
Date: Tue, 16 Oct 2012 23:22:49 +0700
Message-ID: <1350404569-9787-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 18:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO9vg-0007HR-Ia
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 18:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484Ab2JPQX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2012 12:23:28 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:55389 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab2JPQXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 12:23:20 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so3250277dak.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=nWtm+teFAz3yAZ2E7/qsHRzVKDcbXd47shnLPHdsW4U=;
        b=h3/mp44rHPp9YWF/msaowpZ861P3cjT7XNEog9vtQrznq+O0u22XfE/J+cO/hmGKwz
         az4Orf1lKbAHvQSnG5pSLJoursmy4KBZwynkhlVmnYMmyP/G2uDCq0uCiMs+ajpRYjyK
         lvoHv6zhOn0AudBS0ZihVsyE2GJpEnUpSULItsOs7R6axcdse1U9u5Id1U9y9+QXuao1
         T6HllnLX0gHqS/M3pQy5zp32zL6WJhFu5ukHZtoWUrJ68vxhuvkMPpuihwxaDlAe8Nlv
         Afdlo61D+Y1t+dLfXXAfcFgzpZVGD82akpdZHOkvjHduiN/dnZCyB5C2rcKjt7og4aRw
         5VFw==
Received: by 10.68.195.195 with SMTP id ig3mr48824963pbc.108.1350404599134;
        Tue, 16 Oct 2012 09:23:19 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id mn5sm11003960pbc.12.2012.10.16.09.23.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 09:23:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Oct 2012 23:22:59 +0700
X-Mailer: git-send-email 1.8.0.rc2.21.g0695653
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207843>

This could be useful when the user sets an alias to "status --short"
and wants to get back the default format temporarily.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-status.txt | 3 +++
 builtin/commit.c             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index 67e5f53..9f1ef9a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -38,6 +38,9 @@ OPTIONS
 	across git versions and regardless of user configuration. See
 	below for details.
=20
+--long::
+	Give the output in the long-format. This is the default.
+
 -u[<mode>]::
 --untracked-files[=3D<mode>]::
 	Show untracked files.
diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..5adab33 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1159,6 +1159,8 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"),
 			    STATUS_FORMAT_PORCELAIN),
+		OPT_SET_INT(0, "long", &status_format,
+			    N_("show status in long format (default)"), STATUS_FORMAT_LONG)=
,
 		OPT_BOOLEAN('z', "null", &s.null_termination,
 			    N_("terminate entries with NUL")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
--=20
1.8.0.rc2.21.g0695653
