From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Allow users to un-configure rename detection
Date: Thu, 9 Apr 2009 12:40:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904091232420.4583@localhost.localdomain>
References: <alpine.LFD.2.00.0904091141420.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 09 21:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls0AL-000406-04
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 21:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762094AbZDITm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 15:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759146AbZDITm0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 15:42:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52638 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755690AbZDITmZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 15:42:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n39JedSC027202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Apr 2009 12:41:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n39Jedka021696;
	Thu, 9 Apr 2009 12:40:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0904091141420.4583@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.443 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116202>



On Thu, 9 Apr 2009, Linus Torvalds wrote:
> 
> 	[diff]
> 		renames = no

Btw, while doing this, I also though that "renames = on/off" made more 
sense, but while we allow yes/no and true/false for booleans, we don't 
allow on/off.

Should we? Maybe. Here's a stupid patch. 

		Linus

---
 config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index b76fe4c..e7d91f5 100644
--- a/config.c
+++ b/config.c
@@ -331,9 +331,9 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 		return 1;
 	if (!*value)
 		return 0;
-	if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
+	if (!strcasecmp(value, "true") || !strcasecmp(value, "yes") || !strcasecmp(value, "on"))
 		return 1;
-	if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
+	if (!strcasecmp(value, "false") || !strcasecmp(value, "no") || !strcasecmp(value, "off"))
 		return 0;
 	*is_bool = 0;
 	return git_config_int(name, value);
