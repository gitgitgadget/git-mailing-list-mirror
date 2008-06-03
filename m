From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: [PATCH] describe match pattern for soft tags too
Date: Tue, 3 Jun 2008 19:59:02 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0806031957360.3605@pollux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 20:00:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ank-0004BZ-6Y
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 20:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbYFCR7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 13:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbYFCR7L
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 13:59:11 -0400
Received: from mailout03.t-online.de ([194.25.134.81]:51460 "EHLO
	mailout03.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbYFCR7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 13:59:10 -0400
Received: from fwd29.aul.t-online.de 
	by mailout03.sul.t-online.de with smtp 
	id 1K3amq-0000iB-06; Tue, 03 Jun 2008 19:59:08 +0200
Received: from [192.168.2.100] (GQgeNeZAwh5nG4cQsY4DgvCDV1DGZmB+hfD5NTirxXDIQRFGAc69CddDytZfoGOw5d@[84.163.209.200]) by fwd29.t-online.de
	with esmtp id 1K3amj-0oiyLw0; Tue, 3 Jun 2008 19:59:01 +0200
X-X-Sender: michael@pollux
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-ID: GQgeNeZAwh5nG4cQsY4DgvCDV1DGZmB+hfD5NTirxXDIQRFGAc69CddDytZfoGOw5d
X-TOI-MSGID: d42491b9-c9bb-4f25-86da-6047b8ba1623
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83683>


So far git describe --match <pattern> would apply the <pattern> only
to tag objects not to soft tags. This change make describe apply
the <pattern> to soft tags too.
---
  builtin-describe.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index df554b3..a1b8251 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -82,10 +82,10 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
  	if (might_be_tag) {
  		if (is_tag) {
  			prio = 2;
-			if (pattern && fnmatch(pattern, path + 10, 0))
-				prio = 0;
  		} else
  			prio = 1;
+		if (pattern && fnmatch(pattern, path + 10, 0))
+			prio = 0;
  	}
  	else
  		prio = 0;
-- 
1.5.5.3
