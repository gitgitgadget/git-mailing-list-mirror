From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 1/2] t7503: use write_script to generate hook scripts
Date: Tue, 25 Nov 2014 23:51:28 +0100
Message-ID: <78f25aaa60554f7e3b917c565df0f89fb9c08921.1416955873.git.oystwa@gmail.com>
References: <cover.1416953772.git.oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 23:51:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtOxZ-0005tZ-JG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 23:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaKYWvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 17:51:45 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:65494 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaKYWvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 17:51:45 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so2182187wgh.34
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 14:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=rTYPOEdRR3IAuFTkjgFk65s4ytjB1vnpx0Opy/HdMTY=;
        b=nM+gCgjkMaIy9CbUYmCrURHGYUHHJdC9d8CHd2H0BbQlt9cOlP9zME1u1EhDdIBb8P
         5ECcvWRocueXWtxq33tnNH5s9sU+NKF6Pw0MMwJLRqQ9Eemtars63IRLYwUWetxc+p5B
         TZjNlOYKKARXnqW4Ae4X5JWAphHxfddNq89104J2Ok/FXEsB7SWhleAXGk8tLVqO+GJ4
         JgFDF/OR5NDoJiuR+wiyjoUt0I1tHIqcyDcpiT6DBdI/Kc3mGg312diD/DUWIxSIHb36
         ikhg/v63bWes3LnsFP5YOM4kw3jWPheSsRfOV2tR2l9Jy5K8TLY4Ik9izX1lW/RhBbXh
         Az1Q==
X-Received: by 10.180.90.241 with SMTP id bz17mr36687604wib.41.1416955903872;
        Tue, 25 Nov 2014 14:51:43 -0800 (PST)
Received: from bigge.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by mx.google.com with ESMTPSA id ry19sm3830783wjb.3.2014.11.25.14.51.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Nov 2014 14:51:43 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <cover.1416953772.git.oystwa@gmail.com>
In-Reply-To: <cover.1416955873.git.oystwa@gmail.com>
References: <cover.1416955873.git.oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260246>

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
 t/t7503-pre-commit-hook.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b..99ed967 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -24,8 +24,7 @@ test_expect_success '--no-verify with no hook' '
 HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
 HOOK=3D"$HOOKDIR/pre-commit"
 mkdir -p "$HOOKDIR"
-cat > "$HOOK" <<EOF
-#!/bin/sh
+write_script "$HOOK" <<EOF
 exit 0
 EOF
 chmod +x "$HOOK"
@@ -47,8 +46,7 @@ test_expect_success '--no-verify with succeeding hook=
' '
 '
=20
 # now a hook that fails
-cat > "$HOOK" <<EOF
-#!/bin/sh
+write_script "$HOOK" <<EOF
 exit 1
 EOF
=20
@@ -88,8 +86,7 @@ chmod +x "$HOOK"
=20
 # a hook that checks $GIT_PREFIX and succeeds inside the
 # success/ subdirectory only
-cat > "$HOOK" <<EOF
-#!/bin/sh
+write_script "$HOOK" <<EOF
 test \$GIT_PREFIX =3D success/
 EOF
=20
--=20
2.2.0.rc3
