From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 1/8] git_remote_helpers: allow building with Python 3
Date: Thu, 17 Jan 2013 18:53:54 +0000
Message-ID: <e450e2711f963ed46fabbeccafc5fbea02fdc834.1358448207.git.john@keeping.me.uk>
References: <cover.1358448207.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvucz-000463-G1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 19:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab3AQSza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 13:55:30 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:35763 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab3AQSz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 13:55:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id CDDC1198057;
	Thu, 17 Jan 2013 18:55:28 +0000 (GMT)
X-Quarantine-ID: <uUsh1q+oXpjN>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uUsh1q+oXpjN; Thu, 17 Jan 2013 18:55:23 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id 8F2FE19801D;
	Thu, 17 Jan 2013 18:55:23 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 6E4E6276DFE;
	Thu, 17 Jan 2013 18:55:23 +0000 (GMT)
X-Quarantine-ID: <NK-+Eannpvcz>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NK-+Eannpvcz; Thu, 17 Jan 2013 18:55:23 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 8217F276DFB;
	Thu, 17 Jan 2013 18:55:12 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213863>

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
1.8.1.1.260.g99b33f4.dirty
