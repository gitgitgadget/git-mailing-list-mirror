From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 02/16] Add git-remote-testsvn to Makefile.
Date: Mon, 20 Aug 2012 23:52:08 +0200
Message-ID: <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZuN-00086b-M4
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab2HTVxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:11 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63386 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab2HTVxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:07 -0400
Received: by wibhr14 with SMTP id hr14so4065368wib.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sUjSQXCHWjzgW/r4L+79tcrOrIjN6JWJSvIq8sgCk8w=;
        b=jCF9YDll2ekK1ZhIXxDyHACYOLx75sGzhKrkD5AUyRCnvFHfmjrYuy9Pqs43PHFMUS
         lLIWdQRHOQWTP72b+zUFsDAM3NCJQHPiEQdXMTaC0OJycfi6pN/dCJLKvWLGCL4uvszm
         jfJYgmQSVBXE8N0JgvRQpa4Fevws+t5w+HtrDwFJTDn3Ic2JrZO54BvvPZoyBjRD3b9n
         ZTO3K9phN6na1uAjg42RDhZVyN6Dp/0wWoEXcSZpfnDA1Z2ILQEqWYgdMXF8aE1uA+mU
         +ENZ6PuC3EfGrVePbbzKSagmVTg3Gs8GUn9Wg+5o+gAwzJn/mF3C3NH/82XIrr7O4PBb
         dUlg==
Received: by 10.180.82.39 with SMTP id f7mr32484121wiy.2.1345499585989;
        Mon, 20 Aug 2012 14:53:05 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.04
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203877>

The link-rule is a copy of the standard git$X rule but adds VCSSVN_LIB.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 Makefile |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 6b0c961..fb5cdcf 100644
--- a/Makefile
+++ b/Makefile
@@ -477,6 +477,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
+PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -2352,6 +2353,10 @@ git-http-push$X: revision.o http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) 
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
+	$(VCSSVN_LIB)
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
-- 
1.7.9.5
