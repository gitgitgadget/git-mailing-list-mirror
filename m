From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 023/144] t1050-large.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:28 -0700
Message-ID: <1395735989-3396-24-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:37:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMrT-0002TC-LU
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbaCYIhZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:37:25 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:49686 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbaCYI1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:05 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so134793pab.4
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3xPV1LA+QZK3sV/8Adu8zNLIh3hF75DsfYVhqHZ0Q5U=;
        b=tenu2ImnBEILX2SpDWh4J2t4CY0flf7KWAYBQ90wgcP2pnexA1u0Wo23kebgXD2yyv
         o+/k7GW+WjtxwOd5W16vn7qRuehI10zM1hD/EPSF95z65PIbTZed4LcNp1u2F2VI7f58
         LS1vdFdL8Fs5PwdQsBStlhVdfBI9FxwQydBP/IuvIxPBzbbn96DJmCUKOa9P3EV/Phym
         cTbQnZZBTSL29xj1fic6pa9CiH1YuI/sDJlEu1tCJhu1gWwHuYCIL7q4j/1LzpdsnW7c
         1+/Qsy2rl5PKJEvX0pgnF5127qeqEBqCEjDCe6hWvnTbcvMBd7OYcbKxzUAIp4wGSJJm
         +Z1A==
X-Received: by 10.66.66.66 with SMTP id d2mr77285658pat.80.1395736025019;
        Tue, 25 Mar 2014 01:27:05 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245006>

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
 t/t1050-large.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index fd10528..aea4936 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -131,7 +131,7 @@ test_expect_success 'git-show a large file' '
 '
=20
 test_expect_success 'index-pack' '
-	git clone file://"`pwd`"/.git foo &&
+	git clone file://"$(pwd)"/.git foo &&
 	GIT_DIR=3Dnon-existent git index-pack --strict --verify foo/.git/obje=
cts/pack/*.pack
 '
=20
@@ -140,7 +140,7 @@ test_expect_success 'repack' '
 '
=20
 test_expect_success 'pack-objects with large loose object' '
-	SHA1=3D`git hash-object huge` &&
+	SHA1=3D$(git hash-object huge) &&
 	test_create_repo loose &&
 	echo $SHA1 | git pack-objects --stdout |
 		GIT_ALLOC_LIMIT=3D0 GIT_DIR=3Dloose/.git git unpack-objects &&
--=20
1.7.10.4
