From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 10/14] fast-export.c: Initialise variable to suppress msvc
 warning
Date: Sat, 04 Dec 2010 19:09:15 +0000
Message-ID: <4CFA91DB.6030304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzSX-0006hf-50
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab0LDVPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 16:15:52 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:44082 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755843Ab0LDVPv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 16:15:51 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1POyt1-0001RG-gk; Sat, 04 Dec 2010 20:39:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162917>


The msvc compiler thinks that a variable could be used while
uninitialised and issues the following warning:

    ...\git\builtin\fast-export.c(466) : warning C4700: uninitialized \
        local variable 'commit' used

In order to suppress the warning, we simply initialise the
commit pointer variable to NULL.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/fast-export.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c8fd46b..38091fb 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -463,7 +463,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 	for (i = 0; i < pending->nr; i++) {
 		struct object_array_entry *e = pending->objects + i;
 		unsigned char sha1[20];
-		struct commit *commit = commit;
+		struct commit *commit = NULL;
 		char *full_name;
 
 		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
-- 
1.7.3
