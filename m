From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: manpage name conflict
Date: Thu, 19 May 2005 12:18:39 -0600
Message-ID: <E1DYpbT-0003jv-JY@highlab.com>
References: <E1DYmy8-0003YB-JW@highlab.com> <20050519155804.GB4513@pasky.ji.cz> <E1DYnpO-0003cF-I6@highlab.com> <Pine.LNX.4.58.0505190956330.2322@ppc970.osdl.org>
X-From: git-owner@vger.kernel.org Thu May 19 20:23:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYpdX-0006DW-I5
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVESSVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVESSVK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:21:10 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:46832 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261210AbVESSRk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 14:17:40 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (rwcrmhc14) with ESMTP
          id <2005051918173301400c2nc2e>; Thu, 19 May 2005 18:17:33 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1DYpbT-0003jv-JY
	for git@vger.kernel.org; Thu, 19 May 2005 12:18:39 -0600
To: git@vger.kernel.org
In-reply-to: <Pine.LNX.4.58.0505190956330.2322@ppc970.osdl.org> 
Comments: In-reply-to Linus Torvalds <torvalds@osdl.org>
   message dated "Thu, 19 May 2005 09:57:05 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On Thu, 19 May 2005, Sebastian Kuzminsky wrote:
> > Anyway, here's the documentation patch:
> 
> It's whitespace-corrupted, with tabs turned into spaces..


<blush>


Index: Documentation/Makefile
===================================================================
--- 75b95bec390d6728b9b1b4572056af8cee34ea7d/Documentation/Makefile  (mode:100644)
+++ uncommitted/Documentation/Makefile  (mode:100644)
@@ -1,6 +1,6 @@
 DOC_SRC=$(wildcard git*.txt)
 DOC_HTML=$(patsubst %.txt,%.html,$(DOC_SRC))
-DOC_MAN=$(patsubst %.txt,%.1,$(DOC_SRC))
+DOC_MAN=$(patsubst %.txt,%.1,$(wildcard git-*.txt)) git.7
 
 all: $(DOC_HTML) $(DOC_MAN)
 
@@ -13,13 +13,15 @@
 	touch $@
 
 clean:
-	rm -f *.xml *.html *.1
+	rm -f *.xml *.html *.1 *.7
 
 %.html : %.txt
 	asciidoc -b css-embedded -d manpage $<
 
-%.1 : %.xml
+%.1 %.7 : %.xml
 	xmlto man $<
+	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
+	[ "$@" = "git.7" ] || mv git.1 $@
 
 %.xml : %.txt
 	asciidoc -b docbook -d manpage $<
Index: Documentation/git-diff-helper.txt
===================================================================
--- 75b95bec390d6728b9b1b4572056af8cee34ea7d/Documentation/git-diff-helper.txt  (mode:100644)
+++ uncommitted/Documentation/git-diff-helper.txt  (mode:100644)
@@ -1,5 +1,5 @@
 git-diff-helper(1)
-=======================
+==================
 v0.1, May 2005
 
 NAME
Index: Documentation/git.txt
===================================================================
--- 75b95bec390d6728b9b1b4572056af8cee34ea7d/Documentation/git.txt  (mode:100644)
+++ uncommitted/Documentation/git.txt  (mode:100644)
@@ -1,4 +1,4 @@
-git(1)
+git(7)
 ======
 v0.1, May 2005
 


-- 
Sebastian Kuzminsky
"Marie will know I'm headed south, so's to meet me by and by"
-Townes Van Zandt
