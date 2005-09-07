From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] Add $(LIBS) and set libiconv in tools/Makefile for Darwin
Date: Tue, 6 Sep 2005 20:08:55 -0700 (PDT)
Message-ID: <20050907030855.9278.qmail@web34313.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1719237674-1126062535=:8217"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Sep 07 05:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECqJ1-0004IA-HP
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 05:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVIGDI4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 23:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVIGDI4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 23:08:56 -0400
Received: from web34313.mail.mud.yahoo.com ([66.163.178.145]:1719 "HELO
	web34313.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750887AbVIGDI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 23:08:56 -0400
Received: (qmail 9280 invoked by uid 60001); 7 Sep 2005 03:08:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OZ07BlresPd1FIxd8JqXu90Hyrm33uwyXyx0dhK3wysf36euqDcRDjGgSzX2aMj6bhHOR4pW5nRMMRBsVsTw0nS5zkf83lgtUwYx3lHAztHyr6dIl8mGU8gOH/tcHPGZoOBdT/oxNe/iHSnNtN5E3i/a3lBlNY+3lQzvkHeqCYU=  ;
Received: from [66.41.38.150] by web34313.mail.mud.yahoo.com via HTTP; Tue, 06 Sep 2005 20:08:55 PDT
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8164>

--0-1719237674-1126062535=:8217
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

[PATCH] Add $(LIBS) and set libiconv in tools/Makefile for Darwin 

This trivial patch creates $(LIBS) and sets it to iconv in tools/Makefile because MacOS
10.4 [gcc 4.0] gets cranky about libiconv routines referenced in mailinfo.c
(convert_to_utf8) and no library pointer to link the symbols against.

I haven't tested this on Linux yet (but I will tomorrow when I get into work).

Signed-off-by: Mark Allen <mrallen1@yahoo.com>
--0-1719237674-1126062535=:8217
Content-Type: text/plain; name="0001-patch.txt"
Content-Description: 2448049805-0001-patch.txt
Content-Disposition: inline; filename="0001-patch.txt"

[PATCH] Add LIBS field and populate with iconv to tools/Makefile for Darwin 

OS X.4 [gcc 4.0] gets cranky about iconv data structures and no 
library pointer to link the symbols against.

Signed-off-by: Mark Allen <mrallen1@yahoo.com>
---

 tools/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

44865be29a83e2b4b0bf65c6dae427203b7be9b9
diff --git a/tools/Makefile b/tools/Makefile
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -7,13 +7,14 @@ ALL_CFLAGS = $(CFLAGS)
 INSTALL=install
 prefix=$(HOME)
 bindir=$(prefix)/bin
+LIBS=iconv
 # DESTDIR=
 
 PROGRAMS=git-mailsplit git-mailinfo
 SCRIPTS=git-applymbox git-applypatch
 
 git-%: %.c
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.c,$^)
+	$(CC) $(ALL_CFLAGS) -l$(LIBS) -o $@ $(filter %.c,$^)
 
 all: $(PROGRAMS)
 

--0-1719237674-1126062535=:8217--
