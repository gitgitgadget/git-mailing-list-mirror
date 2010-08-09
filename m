From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/10] Introduce vcs-svn lib
Date: Mon, 9 Aug 2010 17:04:29 -0500
Message-ID: <20100809220429.GC4203@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 00:06:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiaTr-0001Ws-7C
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757059Ab0HIWF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 18:05:58 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40534 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017Ab0HIWF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 18:05:58 -0400
Received: by qwh6 with SMTP id 6so7661179qwh.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3XRDyAxaikJ7Bwvlz/WnaSbYnsq29whGP015Qh64uKs=;
        b=E+Tfhavbru3RC4Lj5KaNxh71uVMDBpVLWlc4TOxpHI779PO6w1qCkcR7YnuKz7UT3b
         sD18xYP1yKymOaOWvGzAWVdPZqzPdIg64jfKZmpRf6KwcNmEvJthzjZTHbHn3immmZ+4
         qMYOYRbDCL4V0EEzCmiJRsAEEtmKEN6C5X+m0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oB8JQtooFaZqexVTaZqd7pnQ7DPSfxXmCBPlGsoDZ+2kIU2w7jizH+rAZ2JlVaBrqD
         TuI/0aQafi0DrN55sbS9q140L4dDTpXM68Y9Xfql+DEh1mV0Xd7rj3Kqk/El9yfkJSGX
         184X4pmGdZtbw19ekEXX/envuEPa45us2JBiI=
Received: by 10.220.124.211 with SMTP id v19mr2052297vcr.184.1281391557083;
        Mon, 09 Aug 2010 15:05:57 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id w1sm2852306vbl.18.2010.08.09.15.05.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 15:05:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153034>

Teach the build system to build a separate library for the
upcoming subversion interop support.

The resulting vcs-svn/lib.a does not contain any code, nor is
it built during a normal build.  This is just scaffolding for
later changes.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is just for reference; no change from last round.

 Makefile        |    8 +++++++-
 vcs-svn/LICENSE |   26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletions(-)
 create mode 100644 vcs-svn/LICENSE

diff --git a/Makefile b/Makefile
index f33648d..71cca35 100644
--- a/Makefile
+++ b/Makefile
@@ -468,6 +468,7 @@ export PYTHON_PATH
 
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
+VCSSVN_LIB=vcs-svn/lib.a
 
 LIB_H += advice.h
 LIB_H += archive.h
@@ -1739,7 +1740,8 @@ ifndef NO_CURL
 endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS)
+VCSSVN_OBJS =
+OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS) $(VCSSVN_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
@@ -1860,6 +1862,8 @@ http.o http-walker.o http-push.o remote-curl.o: http.h
 xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
+
+$(VCSSVN_OBJS):
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
@@ -1908,6 +1912,8 @@ $(LIB_FILE): $(LIB_OBJS)
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
+$(VCSSVN_LIB): $(VCSSVN_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
 doc:
 	$(MAKE) -C Documentation all
diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
new file mode 100644
index 0000000..6e52372
--- /dev/null
+++ b/vcs-svn/LICENSE
@@ -0,0 +1,26 @@
+Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice(s), this list of conditions and the following disclaimer
+   unmodified other than the allowable addition of one or more
+   copyright notices.
+2. Redistributions in binary form must reproduce the above copyright
+   notice(s), this list of conditions and the following disclaimer in
+   the documentation and/or other materials provided with the
+   distribution.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) ``AS IS'' AND ANY
+EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) BE
+LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
1.7.2.1.544.ga752d.dirty
