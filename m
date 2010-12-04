From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 12/14] rev-list.c: Initialise variables to suppress msvc warnings
Date: Sat, 04 Dec 2010 19:10:54 +0000
Message-ID: <4CFA923E.80801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:56:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POz9d-000703-L0
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab0LDU4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:56:21 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:42924 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755945Ab0LDU4U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 15:56:20 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1POytB-0001Tf-iS; Sat, 04 Dec 2010 20:39:27 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162909>


The msvc compiler thinks that two variables could be used
while uninitialised and issues the following warnings:

    ...\git\builtin\rev-list.c(400) : warning C4700: uninitialized \
        local variable 'reaches' used
    ...\git\builtin\rev-list.c(400) : warning C4700: uninitialized \
        local variable 'all' used

In order to suppress the warnings, we simply initialise the
variables to zero.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/rev-list.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ba27d39..e28695f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -397,7 +397,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);
 
 	if (bisect_list) {
-		int reaches = reaches, all = all;
+		int reaches = 0, all = 0;
 
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
-- 
1.7.3
