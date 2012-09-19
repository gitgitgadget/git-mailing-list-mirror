From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 02/16] Add git-remote-testsvn to Makefile
Date: Wed, 19 Sep 2012 17:21:16 +0200
Message-ID: <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:22:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM6l-0005pb-HO
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532Ab2ISPW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:22:29 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64575 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab2ISPW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:22:27 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so596995bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tFfTHB38xMxydi2swfG+qq/go1QiOk4art6izTlr9vM=;
        b=tipjfJz5ORyiKeD85070AITySK4zlyx/72igWG+XJ/d9zOe4N8Re7LPyDQWG1yhYMW
         ZU7QOc8xEOu7YoI/Y0cN21IXIxSpj++7U8qHo6plrN2+jVF2/0nL3BAqynj6VWAeBB8p
         cE6N0Ul34aYEy9SZhCpaQTCafk4OmJWBnrkdUu5tlGwHml2mJ0FnySjpdjaW/Hh3CwL8
         2zBvz0Yro24MnLpjFUiT46vyC0X9oB1cuxTLFw1OOt2CipFDoN74xw9k4reZ1yUAZv+7
         JelFk6tbY5dYHak91KS2Zn2nicOIEee+vEPMUhwmU0Dy+sg3T6qMNYDPi5zfmS5t+AJR
         Ngzg==
Received: by 10.204.133.220 with SMTP id g28mr1377441bkt.117.1348068146950;
        Wed, 19 Sep 2012 08:22:26 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.22.24
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:22:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205928>

The link-rule is a copy of the standard git$X rule but adds VCSSVN_LIB.
Add executable to .gitignore.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff:
- add gitignore line.

 .gitignore |    1 +
 Makefile   |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/.gitignore b/.gitignore
index a188a82..f702415 100644
--- a/.gitignore
+++ b/.gitignore
@@ -125,6 +125,7 @@
 /git-remote-fd
 /git-remote-ext
 /git-remote-testgit
+/git-remote-testsvn
 /git-repack
 /git-replace
 /git-repo-config
diff --git a/Makefile b/Makefile
index a49d1db..7743311 100644
--- a/Makefile
+++ b/Makefile
@@ -484,6 +484,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
+PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -2372,6 +2373,10 @@ git-http-push$X: revision.o http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
+	$(VCSSVN_LIB)
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
-- 
1.7.9.5
