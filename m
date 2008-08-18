From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] templates/Makefile: work around SGI install which assumes
 / if ROOT not defined
Date: Mon, 18 Aug 2008 18:14:23 -0500
Message-ID: <XAO6w2f4AxtqGEL6HNTkRYjhSFFUavQK8LYfdASEGw3-LRoH4_7Cdg@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:15:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDwf-0004aX-S5
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbYHRXOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbYHRXOZ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:14:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59217 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbYHRXOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:14:24 -0400
Received: by mail.nrlssc.navy.mil id m7INENnJ026359; Mon, 18 Aug 2008 18:14:23 -0500
In-Reply-To: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Aug 2008 23:14:23.0294 (UTC) FILETIME=[26AECDE0:01C90188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92754>

---

Hmm, I'm thinking that this is probably only an issue when path is
not absolute, since I didn't have any problems installing the
executables. Possibly, a more general fix is to provide the
absolute path here.

-brandon

 templates/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/Makefile b/templates/Makefile
index 9f3f1fc..3ea63e1 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -29,7 +29,7 @@ boilerplates.made : $(bpsrc)
 		case "$$boilerplate" in *~) continue ;; esac && \
 		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
 		dir=`expr "$$dst" : '\(.*\)/'` && \
-		$(INSTALL) -d -m 755 blt/$$dir && \
+		ROOT=./ $(INSTALL) -d -m 755 blt/$$dir && \
 		case "$$boilerplate" in \
 		*--) ;; \
 		*) cp -p $$boilerplate blt/$$dst ;; \
-- 
1.6.0.13.ge1c8
