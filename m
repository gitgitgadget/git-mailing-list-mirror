From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] Makefile: Change the default compiler from "gcc" to "cc"
Date: Tue, 20 Dec 2011 23:40:47 +0000
Message-ID: <1324424447-7164-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 00:40:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd9Ig-0002KM-O7
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 00:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab1LTXkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 18:40:46 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41448 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab1LTXkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 18:40:45 -0500
Received: by eekc4 with SMTP id c4so7071422eek.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 15:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=/7/Irgb2RjHQUH0eU0DTZEn9MvQzfz03POcLqdLvxQE=;
        b=dAIRLKMTxz31/3KPVXldblknfQ+51WTgWWYMhhqEg0FK9ymNaeuukN28HQpaQGlxkF
         k77EG3Qi2VsCWzsyDe8lJgpXZVWiiSlqjcZClfPwygZvYBU6pFooC+82HQ/ql8ns+A1e
         wPgPi7/hw3zNsfBxk55T8fi00rJzclnr45roE=
Received: by 10.14.3.232 with SMTP id 80mr1736584eeh.2.1324424444241;
        Tue, 20 Dec 2011 15:40:44 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id s16sm13242075eef.2.2011.12.20.15.40.43
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 15:40:43 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187536>

Ever since the very first commit to git.git we've been setting CC to
"gcc". Presumably this is behavior that Linus copied from the Linux
Makefile.

However unlike Linux Git is written in ANSI C and supports a multitude
of compilers, including Clang, Sun Studio, xlc etc. On my Linux box
"cc" is a symlink to clang, and on a Solaris box I have access to "cc"
is Sun Studio's CC.

Both of these are perfectly capable of compiling Git, and it's
annoying to have to specify CC=3Dcc on the command-line when compiling
Git when that's the default behavior of most other portable programs.

So change the default to "cc". Users who want to compile with GCC can
still add "CC=3Dgcc" to the make(1) command-line, but those users who
don't have GCC as their "cc" will see expected behavior, and as a
bonus we'll be more likely to smoke out new compilation warnings from
our distributors since they'll me using a more varied set of compilers
by default.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 9470a10..958c6e6 100644
--- a/Makefile
+++ b/Makefile
@@ -336,7 +336,7 @@ pathsep =3D :
=20
 export prefix bindir sharedir sysconfdir gitwebdir localedir
=20
-CC =3D gcc
+CC =3D cc
 AR =3D ar
 RM =3D rm -f
 DIFF =3D diff
--=20
1.7.7.3
