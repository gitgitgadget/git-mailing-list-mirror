From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 27/63] gettext tests: skip lib-gettext.sh tests under GETTEXT_POISON
Date: Sat,  4 Sep 2010 22:10:26 +0000
Message-ID: <1283638229-14199-7-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sam Reed <sam@reedyboy.net>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 00:12:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0yR-0003xh-4G
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab0IDWMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:12:30 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56995 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab0IDWMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:12:30 -0400
Received: by wwj40 with SMTP id 40so4555923wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=p0GWMtxRXYr8xsQmyJxFWZ2rQjM/mrylwuzWHvYnbp4=;
        b=PSc4RRCNjQr4CkkFAURZdvUWGdQXCIa/Ny52b/AWjHlHrO1sog79e1EwjpJRc0sEWn
         KB1iyfTvmKPg/ocjOd82gRHD4zavjFHMeWgE/DmDUGVR7vVV2UNcgmwEowoDLmf4p5YK
         YmZLUfR00wq+46NrVCPvCr0wyJJJvqYiMQfb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uBsvJG+THTzxZOoS7X4nlB1XbNRhIVfCb0rwy1hwSTo9uRlf3wiWlgnxAZBGsGBRDR
         Zn2F6hjiiT7foocx93L6jBNdjIz969KpZ19uzC9g3mubXKgCiGJ7RxadrQXv7JBBUzRH
         uqzH2i37fmPtJ1HWWxylGUyrm7LWQoC3IhVnk=
Received: by 10.216.50.73 with SMTP id y51mr31459web.85.1283638260640;
        Sat, 04 Sep 2010 15:11:00 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k15sm2261604wer.23.2010.09.04.15.10.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 15:10:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155377>

Change the gettext tests (all of whom use lib-gettext.sh) to skip
under GETTEXT_POISON=3DYesPlease. We also print a message to this
effect.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/lib-gettext.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 4570ead..c9a079e 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -11,7 +11,7 @@ export GIT_TEXTDOMAINDIR GIT_PO_PATH
=20
 . "$GIT_BUILD_DIR"/git-sh-i18n
=20
-if test_have_prereq GETTEXT
+if test_have_prereq GETTEXT && test_have_prereq NO_GETTEXT_POISON
 then
 	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
 	is_IS_locale=3D$(locale -a | sed -n '/^is_IS\.[uU][tT][fF]-*8$/{
@@ -58,5 +58,11 @@ then
 else
 	# Only run some tests when we don't have gettext support
 	test_set_prereq NO_GETTEXT
-	say "# lib-gettext: No GETTEXT support available"
+
+	if test_have_prereq NO_GETTEXT_POISON
+	then
+		say "# lib-gettext: GETTEXT_POISON defined, can't test gettext"
+	else
+		say "# lib-gettext: No GETTEXT support available"
+	fi
 fi
--=20
1.7.2.3.313.gcd15
