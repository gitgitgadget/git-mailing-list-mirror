From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 10/11] Fix "stg mail" address parsing for hyphen
Date: Fri, 16 Sep 2005 21:35:23 +0200
Message-ID: <20050916193523.18681.46404.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:40:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2h-0005rS-SX
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965307AbVIPTib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbVIPTib
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:31 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:28555 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965307AbVIPTib
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:31 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id EC51A28739;
	Fri, 16 Sep 2005 21:35:23 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8720>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Tried sending an email cc'ing LKML - watched my postfix queue - and saw
kernel@vger.kernel.org as delivery address! What had happened? StGIT didn't like
"linux-kernel" ! Fix the regexp.

I just added an hyphen to both sections (yes, there are plenty of domain names
including hyphens, and I tested the problem there too). Don't know if other
chars are missing.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/mail.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -112,7 +112,7 @@ def __parse_addresses(string):
     """Return a two elements tuple: (from, [to])
     """
     def __addr_list(string):
-        return re.split('.*?([\w\.]+@[\w\.]+)', string)[1:-1:2]
+        return re.split('.*?([-\w\.]+@[-\w\.]+)', string)[1:-1:2]
 
     from_addr_list = []
     to_addr_list = []
