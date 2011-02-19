From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 57/72] gettextize: git-status "Initial commit" message
Date: Sat, 19 Feb 2011 19:24:40 +0000
Message-ID: <1298143495-3681-58-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUb-0003dU-8n
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab1BST3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:16 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61282 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147Ab1BST2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:15 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347203eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=k6OwmIrcQNMG9AP8nUPp4VwyJEWmR6dYGzbZUg3GE2k=;
        b=tHPRc4CfkG2KjRxQuDI2ZjCPGt8NoZiONpn75YbIIPNSzYD6Pylm81hct3V/vNJmnE
         gdEW2wNC7uqfHCOfOqgNktlfeyM4FqGoizKTX/SFxTGac2yr8Hax/JjnyHs+psE/SKmt
         E/z0H4Erx4oEstUf+FwXALcjIfJnDLpWBIJfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HFS6wMGTu+aeNoGOnjkJ26NUPa5QOIUkFVq4/HhlVdDwMpeDksAjeysjVV9LZNJqFR
         3AhGgGVfr75ep46E39QABvDvXklr7h78LujPQKJPyuoDJJA3iokpoTXBK92RNeHU5ITN
         1pMjlzFIa69d02EtioLm4wKdMW8OU4EllkreU=
Received: by 10.14.37.137 with SMTP id y9mr2426185eea.40.1298143694425;
        Sat, 19 Feb 2011 11:28:14 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.13
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:14 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167356>

Gettextize the "# Initial commit" message. A test in t7501-commit.sh
explicitly checked for this message. Change it to skip under
GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7501-commit.sh |    7 +++++--
 wt-status.c       |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 8980738..9f6e852 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -14,8 +14,11 @@ test_tick
 test_expect_success \
 	"initial status" \
 	"echo 'bongo bongo' >file &&
-	 git add file && \
-	 git status | grep 'Initial commit'"
+	 git add file"
+
+test_expect_success NO_GETTEXT_POISON \
+	"Constructing initial commit" \
+	"git status | grep 'Initial commit'"
=20
 test_expect_success \
 	"fail initial amend" \
diff --git a/wt-status.c b/wt-status.c
index c6295f9..ad6ef7a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -651,7 +651,7 @@ void wt_status_print(struct wt_status *s)
=20
 	if (s->is_initial) {
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "# Initial commi=
t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("# Initial com=
mit"));
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 	}
=20
--=20
1.7.2.3
