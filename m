From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH] branch: give better message when no names specified for  rename
Date: Sat, 30 Mar 2013 18:27:44 -0700
Message-ID: <00E97900-F00D-455F-A3EB-52D0A3CF5CF6@JonathonMah.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 31 03:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UM74G-0008OO-Iq
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 03:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab3CaB1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 21:27:42 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:34094 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755329Ab3CaB1m convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 21:27:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar8TAHaPV1FHynyrPGdsb2JhbAANNosVuBCBIgMBAQEBOIMVP4EkGhO1PZJCjW2BRIJmYQOIeqIngUo
Received: from c-71-202-124-171.hsd1.ca.comcast.net (HELO [192.168.120.29]) ([71.202.124.171])
  by ipmail07.adl2.internode.on.net with ESMTP; 31 Mar 2013 11:57:39 +1030
X-Mailer: Apple Mail (2.1503)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219600>

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---

The previous message was incorrect when not enough arguments were
specified:
    
    $ git branch -m 
    fatal: too many branches for a rename operation

I changed to "branch name required" instead of "new branch name required" in the hope that existing translations can be used.

 builtin/branch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 00d17d2..580107f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -880,7 +880,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (edit_branch_description(branch_name))
 			return 1;
 	} else if (rename) {
-		if (argc == 1)
+		if (!argc)
+			die(_("branch name required"));
+		else if (argc == 1)
 			rename_branch(head, argv[0], rename > 1);
 		else if (argc == 2)
 			rename_branch(argv[0], argv[1], rename > 1);
-- 
1.8.2.279.g631bc94
