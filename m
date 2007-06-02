From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] Allow CFLAGS to be overridden while preserving VERSION
Date: Sat,  2 Jun 2007 13:14:50 -0400
Message-ID: <118080449045-git-send-email-jbowes@dangerouslyinc.com>
To: fonseca@diku.dk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 19:16:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuXDH-0001aT-I0
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 19:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760684AbXFBRQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 13:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760800AbXFBRQV
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 13:16:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760684AbXFBRQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 13:16:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l52HGHf5019852;
	Sat, 2 Jun 2007 13:16:17 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l52HGHWx015495;
	Sat, 2 Jun 2007 13:16:17 -0400
Received: from localhost.localdomain (vpn-14-52.rdu.redhat.com [10.11.14.52])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l52HGGJv019921;
	Sat, 2 Jun 2007 13:16:16 -0400
X-Mailer: git-send-email 1.5.2.888.g96a5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48938>

If someone defined their own CFLAGS, they would have to include a -DVERSION=
as well (or else get unknown-version as the version).

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 61fc86b..91cb097 100644
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,7 @@ endif
 RPM_VERSION = $(subst -,.,$(VERSION))
 
 LDLIBS	= -lcurses
-CFLAGS	= -Wall -O2 '-DVERSION="$(VERSION)"'
+CFLAGS	= -Wall -O2
 DFLAGS	= -g -DDEBUG -Werror
 PROGS	= tig
 MANDOC	= tig.1 tigrc.5
@@ -28,6 +28,8 @@ HTMLDOC = tig.1.html tigrc.5.html manual.html README.html
 ALLDOC	= $(MANDOC) $(HTMLDOC) manual.html-chunked manual.pdf
 TARNAME	= tig-$(RPM_VERSION)
 
+override CFLAGS += '-DVERSION="$(VERSION)"'
+
 all: $(PROGS)
 all-debug: $(PROGS)
 all-debug: CFLAGS += $(DFLAGS)
-- 
1.5.2.888.g96a5e
