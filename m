From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [RFC/PATCH 3/4] gitweb: Create Gitweb::HTML module
Date: Tue,  8 Jun 2010 02:20:43 +0530
Message-ID: <1275943844-24991-3-git-send-email-pavan.sss1991@gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Mon Jun 07 22:51:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLjIF-0007CR-1o
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 22:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab0FGUv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 16:51:26 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44236 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab0FGUvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 16:51:25 -0400
Received: by pwj5 with SMTP id 5so1014768pwj.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+R+1F0XjcF988afewGod59TKbZw+dNGQY0RiOghs0f4=;
        b=xZO4c9DK2yn/hTIge5q/HcsTCoW1MfnzDpCcYt5Tz3nxiFgxP1JWw553bXn+BJ3aR6
         fMGv4QNU4YlR95M+PEjGzBonz0FGH4/+HebVeh0QOG3AFB8G4jdcpXgeKP0h8ecmrsdM
         jESWrcg8ziM624c1UKdxr4h4iskHyc1ao1iAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=En4v6AukVv6/5UEdwGqQ8d+yqgcv+UehprmpMC+9tAodGaYbm4GcRHjy2itFdsBILp
         FY/dLCpLAJdPnMdeq8HONR6PYxRW0d1JLvPMhbobSGuQmoJlA7skDuJ74Z1VfbtL6S+R
         D9sBXw0QtW6PrtiKgLWFhpzM35podMzrmeAYA=
Received: by 10.140.57.21 with SMTP id f21mr12319611rva.165.1275943884878;
        Mon, 07 Jun 2010 13:51:24 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id o38sm1180853rvp.2.2010.06.07.13.51.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 13:51:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.ga8c50c
In-Reply-To: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148626>

Create Gitweb::HTML module in 'gitweb/lib/Gitweb/HTML.pm'
to import all the Gitweb::HTML::* modules into it.

Update gitweb/Makefile to install Gitweb::HTML alongside gitweb.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile           |    1 +
 gitweb/gitweb.perl        |    2 +-
 gitweb/lib/Gitweb/HTML.pm |   17 +++++++++++++++++
 3 files changed, 19 insertions(+), 1 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/HTML.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 28f0858..5e44ace 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -116,6 +116,7 @@ GITWEB_LIB_GITWEB += lib/Gitweb/Config.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/Request.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/Escape.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/Git.pm
+GITWEB_LIB_GITWEB += lib/Gitweb/HTML.pm
 # Files: gitweb/lib/Gitweb/HTML
 GITWEB_LIB_GITWEB_HTML += lib/Gitweb/HTML/Link.pm
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bd11ae0..12646c0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -28,7 +28,7 @@ use Gitweb::Git;
 use Gitweb::Config;
 use Gitweb::Request;
 use Gitweb::Escape;
-use Gitweb::HTML::Link;
+use Gitweb::HTML;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
diff --git a/gitweb/lib/Gitweb/HTML.pm b/gitweb/lib/Gitweb/HTML.pm
new file mode 100644
index 0000000..a0a1606
--- /dev/null
+++ b/gitweb/lib/Gitweb/HTML.pm
@@ -0,0 +1,17 @@
+#!/usr/bin/perl
+#
+# Gitweb::HTML -- gitweb's HTML subs package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::HTML;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(href);
+
+use Gitweb::HTML::Link;
+
+1;
-- 
1.7.1.454.ga8c50c
