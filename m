From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] dir.c: Fix a sparse warning
Date: Sat, 02 Jun 2012 18:05:36 +0100
Message-ID: <4FCA47E0.7020700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 19:10:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sarqd-0006WC-Eo
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 19:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759713Ab2FBRKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 13:10:11 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:47288 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759403Ab2FBRKK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2012 13:10:10 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1Sarq4-00071i-gz; Sat, 02 Jun 2012 17:10:08 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199052>


In particular, sparse complains as follows:

        SP dir.c
    dir.c:291:12: warning: symbol 'wildcards' was not declared. \
        Should it be static?

In order to suppress the warning, since 'wildcards' does not need
to be an external symbol, we simply add the static modifier to the
declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

If you need to re-roll the 'nd/exclude-workaround-top-heavy' branch,
could you please squash this into commit dedbd80c ("exclude: do strcmp
as much as possible before fnmatch", 26-05-2012).

Thanks!

ATB,
Ramsay Jones

 dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 1b1a325..571eb0d 100644
--- a/dir.c
+++ b/dir.c
@@ -288,7 +288,7 @@ int match_pathspec_depth(const struct pathspec *ps,
 	return retval;
 }
 
-const char *wildcards = "*?[{\\";
+static const char *wildcards = "*?[{\\";
 
 static int no_wildcard(const char *string)
 {
-- 
1.7.10
