From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 098/144] t9001-send-email.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:43 -0700
Message-ID: <1395735989-3396-99-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMjE-0000iP-UK
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbaCYI2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:54 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:40559 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbaCYI2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:24 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so132822pbc.21
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hroWR2HLfovhO87yvc4jc5vQWeP0z8yzh4VvVi52Iys=;
        b=m14W4R9U9Tkv911o68Cp76klyKZ/4lq9zLZzEHtdG5HJSM0VqbLMns5M8AwOyTLdBp
         LNGFsRtaBZJ1J+FDogh8wJIjcPuzNWIjmjF8dNiZK2dIQdxewAU0Ob5LAPhsJGi7TFIO
         RNyZ9Du26dUSfafBQvuQshhXEOnghPRvto2mvPrKtlK9tldu3Ej59xpcZXzIQ6UIKXqf
         T53NJKX/295FEfrEFFQOZIWjwMzPeyTgovyiTcn9W8PMjBQYhOK9C4e/M+1jJfmPlNAF
         mpmXinJgSSrC8iudy8dClWknork6ylEhNAd742h+i4djwTMYXT3AmZD/2E+qGPLHTNua
         KQ+w==
X-Received: by 10.68.202.194 with SMTP id kk2mr9052710pbc.156.1395736103816;
        Tue, 25 Mar 2014 01:28:23 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244943>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t9001-send-email.sh |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1ecdacb..149a5b1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -34,7 +34,7 @@ clean_fake_sendmail() {
 }
=20
 test_expect_success $PREREQ 'Extract patches' '
-    patches=3D`git format-patch -s --cc=3D"One <one@example.com>" --cc=
=3Dtwo@example.com -n HEAD^1`
+    patches=3D$(git format-patch -s --cc=3D"One <one@example.com>" --c=
c=3Dtwo@example.com -n HEAD^1)
 '
=20
 # Test no confirm early to ensure remaining tests will not hang
@@ -1158,7 +1158,7 @@ test_expect_success $PREREQ '--no-bcc overrides s=
endemail.bcc' '
 '
=20
 test_expect_success $PREREQ 'patches To headers are used by default' '
-	patch=3D`git format-patch -1 --to=3D"bodies@example.com"` &&
+	patch=3D$(git format-patch -1 --to=3D"bodies@example.com") &&
 	test_when_finished "rm $patch" &&
 	git send-email \
 		--dry-run \
@@ -1169,7 +1169,7 @@ test_expect_success $PREREQ 'patches To headers a=
re used by default' '
 '
=20
 test_expect_success $PREREQ 'patches To headers are appended to' '
-	patch=3D`git format-patch -1 --to=3D"bodies@example.com"` &&
+	patch=3D$(git format-patch -1 --to=3D"bodies@example.com") &&
 	test_when_finished "rm $patch" &&
 	git send-email \
 		--dry-run \
@@ -1182,8 +1182,8 @@ test_expect_success $PREREQ 'patches To headers a=
re appended to' '
 '
=20
 test_expect_success $PREREQ 'To headers from files reset each patch' '
-	patch1=3D`git format-patch -1 --to=3D"bodies@example.com"` &&
-	patch2=3D`git format-patch -1 --to=3D"other@example.com" HEAD~` &&
+	patch1=3D$(git format-patch -1 --to=3D"bodies@example.com") &&
+	patch2=3D$(git format-patch -1 --to=3D"other@example.com" HEAD~) &&
 	test_when_finished "rm $patch1 && rm $patch2" &&
 	git send-email \
 		--dry-run \
--=20
1.7.10.4
