From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] perl libs: perl -w + use warnings is redundant
Date: Fri, 21 May 2010 14:50:55 +0000
Message-ID: <1274453455-1941-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 16:51:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFTZD-0005xm-RZ
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 16:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757619Ab0EUOvJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 10:51:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56981 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757540Ab0EUOvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 10:51:05 -0400
Received: by fxm5 with SMTP id 5so918294fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=K48lRkn5SqwifaOouUIkMVxaivZZKupgeXtYL9Erje8=;
        b=O2gusQlkGh75WcEFAe7rjROwCVzjC93H+HZTOUQeRt1kRh9AphqkjL6GJ6A4k987HQ
         k4X8ZeNc6Zd1gMEqQHvIjyxrAk6K3d1AjIQv5raOGlZQhDOW1aNhjxqJg2yMSOiQE/Ea
         22IYeut8SanXxzegImKg0j62WxczMkY2N6W/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=uOzAx7KxU6Hu9CmAVAWOm7Yy/wUvZiJJgZkDT4W954XVoyadTgcNhtukTETKmWtACb
         tWUjFA0XEr2GH9ZMyJtsZrShlKU8X+ra89kFRKqn/xHWMAWIW+tpabnqKoj5XrsihVRE
         YAlQl9cqX3nQoFMvHyvjMTlc5wjbAtzgNVsjo=
Received: by 10.223.29.156 with SMTP id q28mr1549511fac.77.1274453463248;
        Fri, 21 May 2010 07:51:03 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm4857562fad.7.2010.05.21.07.51.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 07:51:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.98.g4a5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147459>

Change the Perl scripts to turn on lexical warnings, but only in Perl
scripts that definitely require 5.6.0 or later. I.e. those that either
did 'use warnings' in addition to -w already, or used the three-arg
form of open.

-w sets warnings for all code that interpreter runs. "use warnings" is
lexically scoped. The former is probably not what the authors wanted.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 contrib/examples/git-svnimport.perl         |    2 +-
 contrib/fast-import/import-directories.perl |    3 ++-
 git-add--interactive.perl                   |    3 ++-
 git-archimport.perl                         |    2 +-
 git-send-email.perl                         |    2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git=
-svnimport.perl
index 4576c4a..ead4c04 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
=20
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast=
-import/import-directories.perl
index 3a5da4a..7f3afa5 100755
--- a/contrib/fast-import/import-directories.perl
+++ b/contrib/fast-import/import-directories.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 #
 # Copyright 2008-2009 Peter Krefting <peter@softwolves.pp.se>
 #
@@ -140,6 +140,7 @@ by whitespace or other characters.
=20
 # Globals
 use strict;
+use warnings;
 use integer;
 my $crlfmode =3D 0;
 my @revs;
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 21f1330..c2e7ab4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,7 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
=20
 use strict;
+use warnings;
 use Git;
=20
 binmode(STDOUT, ":raw");
diff --git a/git-archimport.perl b/git-archimport.perl
index 98f3ede..6ee3fca 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 #
 # This tool is copyright (c) 2005, Martin Langhoff.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-send-email.perl b/git-send-email.perl
index 111c981..bbb03f7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 #
 # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
 # Copyright 2005 Ryan Anderson <ryan@michonline.com>
--=20
1.7.1.98.g4a5f
