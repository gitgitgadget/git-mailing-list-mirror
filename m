From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/4] autoconf: Add configure target to main Makefile
Date: Tue, 8 Aug 2006 18:35:23 +0200
Message-ID: <200608081835.23448.jnareb@gmail.com>
References: <200608081834.09271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 08 18:36:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAUYZ-0002gx-JI
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 18:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWHHQfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 12:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWHHQfX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 12:35:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:37745 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030190AbWHHQfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 12:35:18 -0400
Received: by nf-out-0910.google.com with SMTP id q29so223914nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 09:35:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Oi5maRdpabMb6cd0CpxpeGaWwFs9cdHWsTZlhjuuQkSjcmwBkRJfTAd/7yj2wsv1SavNaUJMr4zQ7pj1128YCiw2waJCPEWNCSG/N6kS3K/vBPBfttwj+/cC5elDKsCiSIUswK+gmaBbBoUy0ey0LOieGYwImS4V12Tp5uJ5sds=
Received: by 10.48.14.4 with SMTP id 4mr716203nfn;
        Tue, 08 Aug 2006 09:35:17 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id y23sm70221nfb.2006.08.08.09.35.12;
        Tue, 08 Aug 2006 09:35:17 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608081834.09271.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25073>

While at it fill git version information in configure.ac
configure target needs autoconf, of course.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This will make testing autoconf improvements easier

 Makefile     |    7 +++++++
 configure.ac |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8c225e6..321267b 100644
--- a/Makefile
+++ b/Makefile
@@ -676,6 +676,13 @@ git-instaweb: git-instaweb.sh gitweb/git
 	chmod +x $@+
 	mv $@+ $@
 
+configure: configure.ac
+	rm -f $@ $<+
+	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    $< > $<+
+	autoconf -o $@ $<+
+	rm -f $<+
+
 # These can record GIT_VERSION
 git$X git.spec \
 	$(patsubst %.sh,%,$(SCRIPT_SH)) \
diff --git a/configure.ac b/configure.ac
index 3c56cc5..e2da891 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,7 +2,7 @@ #                                       
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.59)
-AC_INIT([git], [1.4.1], [git@vger.kernel.org])
+AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
 
 AC_CONFIG_SRCDIR([git.c])
 
-- 
1.4.1.1
