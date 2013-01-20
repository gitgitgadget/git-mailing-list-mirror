From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 1/8] git_remote_helpers: Allow building with Python 3
Date: Sun, 20 Jan 2013 13:15:31 +0000
Message-ID: <72abc4652432c35ebb81404b41c2149d0400347a.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwulB-00031Y-Ua
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 14:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab3ATNQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 08:16:08 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:52899 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATNQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 08:16:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 50AF9CDA58B;
	Sun, 20 Jan 2013 13:16:06 +0000 (GMT)
X-Quarantine-ID: <Gnnu+lwgJ1Qj>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gnnu+lwgJ1Qj; Sun, 20 Jan 2013 13:16:05 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 86990CDA5BF;
	Sun, 20 Jan 2013 13:16:05 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7D227161E509;
	Sun, 20 Jan 2013 13:16:05 +0000 (GMT)
X-Quarantine-ID: <F8DjUTDJFMPk>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8DjUTDJFMPk; Sun, 20 Jan 2013 13:16:05 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id AFD2F161E480;
	Sun, 20 Jan 2013 13:15:58 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214011>

Change inline Python to call "print" as a function not a statement.

This is harmless because Python 2 will see the parentheses as redundant
grouping but they are necessary to run this code with Python 3.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git_remote_helpers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
index 74b05dc..f65f064 100644
--- a/git_remote_helpers/Makefile
+++ b/git_remote_helpers/Makefile
@@ -23,7 +23,7 @@ endif
 
 PYLIBDIR=$(shell $(PYTHON_PATH) -c \
 	 "import sys; \
-	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
+	 print('lib/python%i.%i/site-packages' % sys.version_info[:2])")
 
 all: $(pysetupfile)
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
-- 
1.8.1.353.gc992d5a.dirty
