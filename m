From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/6] build: be clearer about order-only prerequisites
Date: Fri, 24 May 2013 21:41:04 -0500
Message-ID: <1369449666-18879-5-git-send-email-felipe.contreras@gmail.com>
References: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Rl-0000Ly-Df
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab3EYCm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:42:59 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:39993 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab3EYCm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:42:56 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so7071550oag.29
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SgwPSwv838yj8+yDcnDywIHHPWCLGFqmi8ypryaLmZI=;
        b=NZIj7iWsWdEnSnkUTlhBurFwz8gLrUQcIeBZJQ2oplgcMPQcrgtCcxjZI+dFaO082U
         XYe8HlnSHOy9F8Cp4zlhtx929mnF+9uD6CiCqCXh9wxMtTnq6rvO/FvItvnTR/8QPRZU
         uiGpgE/M9bpyaEkdZDbhxEYy1eajBRpgIzB/Lm7dMzgttDqP+W9iVTOQTsCY2JlEbFiC
         Z3oCcABpE7mD2ToI80FAy5B+Z+oMOTu2u99yScZBJhxMi3YBRVGSjqa6uQlJvf/2/gNO
         425iT/9oZtjGAFBtvhMTfK0bMrgixnnMcoTCLtiChLRBk3ygshI6xZpeNpH3Dg9tnr4b
         GYRQ==
X-Received: by 10.60.116.99 with SMTP id jv3mr13418562oeb.7.1369449776360;
        Fri, 24 May 2013 19:42:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm20592322oes.6.2013.05.24.19.42.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:42:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225472>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 28b6117..97ff848 100644
--- a/Makefile
+++ b/Makefile
@@ -1787,7 +1787,7 @@ perl/PM.stamp: FORCE
 perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
-$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
+$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl | GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
@@ -1850,7 +1850,7 @@ CONFIGURE_RECIPE = $(RM) configure configure.ac+ && \
 		   autoconf -o configure configure.ac+ && \
 		   $(RM) configure.ac+
 
-configure: configure.ac GIT-VERSION-FILE
+configure: configure.ac | GIT-VERSION-FILE
 	$(QUIET_GEN)$(CONFIGURE_RECIPE)
 
 ifdef AUTOCONFIGURED
@@ -2415,7 +2415,7 @@ quick-install-html:
 
 ### Maintainer's dist rules
 
-git.spec: git.spec.in GIT-VERSION-FILE
+git.spec: git.spec.in | GIT-VERSION-FILE
 	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
 	mv $@+ $@
 
-- 
1.8.3.rc3.312.g47657de
