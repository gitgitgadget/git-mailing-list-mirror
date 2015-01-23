From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 2/5] doc: guilt.xml depends on cmds.txt.
Date: Fri, 23 Jan 2015 14:24:56 +0100
Message-ID: <1422019499-2012-3-git-send-email-cederp@opera.com>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:26:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEeFb-0004DS-JD
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 14:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbbAWN0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 08:26:11 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:44263 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbbAWN0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 08:26:10 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so7484108wgh.6
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 05:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aC+2vHbfo70Z75YvAe/3aDx3NPNGqnUNj2H6ysIq0tQ=;
        b=PIROlXp6KBH6ix+GpTquyC64kYEvhcMf9uDk7CphXAtt6VQCU/R/LFhePuHazMhGuf
         WPy1h5ZsDbjgw0KkBZ+39UqTqIcR1TWxntAM3eqYkJNvkYlWA0gvRilgGP5Tp+46E07l
         8Tp0Zmi7EkMnClu7Eg6q9kbAFWh/xmPQT1zrcRFU8T3Xi96qZz7XFccUYUSN6qyPbmM8
         q8QdZ8Qqn7UyOmgTRoV0vE1fRWm/Q6x+T/Oy3tq71MJPsnMTw4fOmRcPK8nRyrM9Jfen
         Bg8gnG+oJRJv8MIX69sJu1SSO4/INjsRA0IwI+tbKKcYsI0Lmh/W0+2tmsQHFNbfPDfg
         AzUQ==
X-Gm-Message-State: ALoCoQnRyY97u9npnIGXzDoy4NBlZOOlU/lQjyNFG9uYKtiTPysv5RRiaQG0/zeeL9FCcjhyVvQU
X-Received: by 10.194.191.227 with SMTP id hb3mr14204667wjc.79.1422019568903;
        Fri, 23 Jan 2015 05:26:08 -0800 (PST)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id fi10sm1841950wib.13.2015.01.23.05.26.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 05:26:08 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1422019499-2012-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262923>

Specify an explicit dependency, to stop make from trying to generate
guilt.xml if cmds.txt could not be created.  The asciidoc will fail
and produce an error message that might hide the original error
message.

The added dependency causes make to not remove the guilt.xml file.
Add *.xml to .gitignore.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 Documentation/.gitignore | 3 +++
 Documentation/Makefile   | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index c4f0588..9b8d4da 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -11,3 +11,6 @@ version.txt
 
 # Generated file dependency list
 doc.dep
+
+# Intermediate generated files
+*.xml
diff --git a/Documentation/Makefile b/Documentation/Makefile
index ec3c9e8..2574125 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -60,6 +60,8 @@ cmds.txt: cmd-list.sh $(MAN1_TXT)
 
 guilt.7 guilt.html: guilt.txt footer.txt version.txt
 
+guilt.xml: cmds.txt
+
 clean:
 	rm -f *.xml *.html *.1 *.7 doc.dep
 	rm -f cmds.txt
-- 
2.1.0
