From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFCv4 1/4] Documentation: Preparation for gitweb manpages
Date: Tue, 20 Sep 2011 22:11:05 +0200
Message-ID: <201109202211.06899.jnareb@gmail.com>
References: <1316352884-26193-1-git-send-email-jnareb@gmail.com> <1316352884-26193-2-git-send-email-jnareb@gmail.com> <20110919233703.GF6343@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 22:11:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66f0-0004aY-4h
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 22:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab1ITULM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 16:11:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60446 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1ITULK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 16:11:10 -0400
Received: by fxe4 with SMTP id 4so848903fxe.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=yuzKE8yGv2EUZq/WGY/3W0x3k/xjSOa4q3R6Lu3I1uU=;
        b=sk0/ujMSL1rU+d6waBVZaA7Npr+X1D0EM+d06ZSAT6oZjy+1GxDSB0xtKHpuGUSDYf
         T9z54OPD0Y6/ndVrJ1fF0flZtncZz8Ri3QJzWRNpfxHT2XhWawrctBkix0pa9Gr34ffw
         T+WmQGLBvKjlmABfNWbFX8epzsFIIOcsMOrXs=
Received: by 10.223.21.26 with SMTP id h26mr1919024fab.1.1316549468888;
        Tue, 20 Sep 2011 13:11:08 -0700 (PDT)
Received: from [192.168.1.13] (abvd239.neoplus.adsl.tpnet.pl. [83.8.201.239])
        by mx.google.com with ESMTPS id y24sm2284410fan.24.2011.09.20.13.11.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 13:11:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110919233703.GF6343@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181788>

Thanks again for all language fixes.  English is my secondary language...

Jonathan Nieder wrote:
> Jakub Narebski wrote:

> > The goal is to move documentation out of gitweb/README to gitweb.txt and
> > gitweb.conf.txt manpages, reducing its size 10x from around 500 to
> > around 50 lines (two pages), and move information not related drectly to
> > building and installing gitweb out of gitweb/INSTALL there.
> 
> I guess you mean this patch prepares for or is part of a larger
> project or series with that goal? [...]

[...]
> > This way to build gitweb documentation one can use
> >
> >   make -C gitweb doc
> >
> > or
> >
> >   cd gitweb; make doc
> 
> Language nit: a comma after "This way" would disambiguate.
> 
> Does "make -CDocumentation man html" build the gitweb documentation,
> too (and "make install-doc" install it)?

Jonathan Nieder wrote:

>                                         Maybe its commit message could
> be clarified to mention that the new targets build a subset of the pages
> built by the ordinary "make doc" et al targets.

I hope that this version is more clear:

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFCv5 1/4] Documentation: Preparation for gitweb manpages

Gitweb documentation currently consists of gitweb/README, gitweb/INSTALL
and comments in gitweb source code.  This is harder to find, use and
browse than manpages ("man gitweb" or "git help gitweb") and HTML
documentation ("git help --web gitweb").

The goal of the next two commits is to move documentation out of
gitweb/README to gitweb.txt and gitweb.conf.txt manpages, reducing its
size 10x from around 500 to around 50 lines (two pages), and to move
information not related directly to building and installing gitweb out
of gitweb/INSTALL.

The idea is to have the gitweb manpage sources reside in AsciiDoc
format in the Documentation/ directory, like for gitk and git-gui.
This means that building git documentation (with "make doc") would
also build gitweb manpages.

An alternate solution would be to have gitweb documentation in the
gitweb/ directory, perhaps in POD format (see perlpod(1)).


This patch adds infrastructure for easy generation of only
gitweb-related manpages.  It adds a currently empty 'gitweb-doc'
target to Documentation/Makefile, and a 'doc' proxy target to
gitweb/Makefile.

This way to build only gitweb documentation in both 'man' and 'html'
formats one can use

  make -C gitweb doc

or

  cd gitweb; make doc

This somewhat follows the idea of 'full-svn-test' and 'gitweb-test' in
t/Makefile.  Note also that with alternate solution, where source of
gitweb manpages would reside in the gitweb/ directory, "make doc"
would invoke "make -C gitweb doc" to generate formatted docs.

The gitweb.conf(5) and gitweb(1) manpages will be added in subsequent
commits.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/Makefile |    3 +++
 gitweb/Makefile        |    7 ++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6346a75..44be67b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -170,6 +170,9 @@ info: git.info gitman.info
 
 pdf: user-manual.pdf
 
+GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7))
+gitweb-doc: $(GITWEB_DOC)
+
 install: install-man
 
 install-man: man
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 1c85b5f..3014d80 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -174,6 +174,11 @@ test-installed:
 	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
 		$(MAKE) -C ../t gitweb-test
 
+### Documentation
+
+doc:
+	$(MAKE) -C ../Documentation gitweb-doc
+
 ### Installation rules
 
 install: all
@@ -187,5 +192,5 @@ install: all
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
+.PHONY: all clean install test test-installed doc .FORCE-GIT-VERSION-FILE FORCE
 
-- 
1.7.6
