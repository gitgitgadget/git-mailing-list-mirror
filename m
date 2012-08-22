From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 02/16] Add git-remote-testsvn to Makefile
Date: Wed, 22 Aug 2012 21:15:47 +0200
Message-ID: <1345662961-9587-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQ7-0001Ql-AM
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026Ab2HVTQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:16:38 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964976Ab2HVTQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:33 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so449679bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=abYKEAWS1VuZUlLDK3Jrjdi/sIWvzF8xjQUUDGCMTnk=;
        b=ydWqQBvMWYFH+KEF3/CMAzj1oQb6U89Bj6QADJONdsrTxNvduNgXze2h20MlunDUIN
         /3rt+t7an58yxQ1xQy+inGoRqm4Ybyb7z8Oqrhd65HxDbkSEGX99s6NJpD9SEsz5CjWK
         QUvFpf5QeCqJtEbZ3HMQ8Rgfokt/Tk0m3+F2x7SKV5ShVWcz1FSCmH2SP1CcC3/kphT6
         jtHHIgCWBrMOOFIuZcwxIFOUYzGkYhNvoxrKLPuklTbYaPA7BNvqDLzKhe714lCs8iXL
         WyTPUZWM6RSR8G0wr/gKiodRm/hoHcakxtDUf+3eyXQAN6BORaPf3Xbfdxz1AKZBloJ0
         8kQA==
Received: by 10.205.123.8 with SMTP id gi8mr6838222bkc.92.1345662992883;
        Wed, 22 Aug 2012 12:16:32 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.30
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204071>

The link-rule is a copy of the standard git$X rule but adds VCSSVN_LIB.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 6b0c961..d62dbe5 100644
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
