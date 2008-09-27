From: Johan Herland <johan@herland.net>
Subject: [PATCH] Use strchrnul() instead of strchr() plus manual workaround
Date: Sun, 28 Sep 2008 00:24:36 +0200
Message-ID: <200809280024.36190.johan@herland.net>
References: <20080928070858.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 00:26:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjiFc-0003Fg-3g
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 00:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbYI0WYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 18:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbYI0WYu
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 18:24:50 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35238 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412AbYI0WYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 18:24:49 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K7V00A01KX1FO00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 28 Sep 2008 00:24:37 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7V00JKHKX0Y3A0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 28 Sep 2008 00:24:36 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7V00JVQKX0WH10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 28 Sep 2008 00:24:36 +0200 (CEST)
In-reply-to: <20080928070858.6117@nanako3.lavabit.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96923>

Also gets rid of a C++ comment.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Sunday 28 September 2008, Nanako Shiraishi wrote:
> Why does this C++ style comment talk about "simulate"?
>
> Don't other parts of git already use strchrnul()?

Oops. Sorry about that. The man page for strchrnul() says that it is
a GNU extension, so I stayed away from it. Of course, I should have
grepped the git source instead...

This should fix it.


...Johan

 builtin-for-each-ref.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index e59bd80..fa6c1ed 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -320,9 +320,7 @@ static const char *find_wholine(const char *who, int wholen, const char *buf, un
 
 static const char *copy_line(const char *buf)
 {
-	const char *eol = strchr(buf, '\n');
-	if (!eol) // simulate strchrnul()
-		eol = buf + strlen(buf);
+	const char *eol = strchrnul(buf, '\n');
 	return xmemdupz(buf, eol - buf);
 }
 
-- 
1.6.0.2.471.g47a76
