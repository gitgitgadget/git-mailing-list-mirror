From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH v2 2/2] clone: add bare clone to the progress message
Date: Sun, 09 May 2010 13:11:12 -0700
Message-ID: <4BE716E0.6040201@pcharlan.com>
References: <4BE60E89.8010709@pcharlan.com> <20100509110221.GA16639@coredump.intra.peff.net> <4BE7166A.5030107@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 09 22:11:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBCqW-0003Be-7a
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 22:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab0EIULP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 16:11:15 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:34035 "EHLO
	swarthymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751843Ab0EIULN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 16:11:13 -0400
Received: from [192.168.0.119] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(Authenticated sender: pete@tento.net)
	by swarthymail-a4.g.dreamhost.com (Postfix) with ESMTPA id AF55E3B405B;
	Sun,  9 May 2010 13:11:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <4BE7166A.5030107@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146743>

When cloning, we report "Cloning into foo...".  If the repository is
bare, say "Cloning into bare repository foo..." instead.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---
 builtin/clone.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 306aacf..3a3625b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -464,7 +464,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	set_git_dir(make_absolute_path(git_dir));
 
 	if (0 <= option_verbosity)
-		printf("Cloning into %s...\n", dir);
+		printf("Cloning into %s%s...\n",
+		       option_bare ? "bare repository " : "", dir);
 	init_db(option_template, INIT_DB_QUIET);
 
 	/*
-- 
1.7.1.14.gcafbfa.dirty
