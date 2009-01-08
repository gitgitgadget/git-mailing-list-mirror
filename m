From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH, resend] git-commit: colored status when color.ui is set
Date: Thu, 8 Jan 2009 19:53:01 +0100
Message-ID: <200901081953.01418.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 20:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL01F-0000cI-6r
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 19:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761598AbZAHSww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 13:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761610AbZAHSwv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 13:52:51 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:49694 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757577AbZAHSwu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 13:52:50 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 55251F6518E1;
	Thu,  8 Jan 2009 19:52:47 +0100 (CET)
Received: from [89.59.114.169] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LKzzr-0001Z7-00; Thu, 08 Jan 2009 19:52:47 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19eqfBSGbUCsmI1E1mWq2U9pf2AfaI5yNpfvCfA
	dfVWJzqm/DV2FW7KC+Sr5+74/Z1TxrV8YjMuE29D4mnjvKM4Kg
	U4gVrQJAwYnsX+1IzjlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104952>

When using "git commit" and there was nothing to commit (the editor
wasn't launched), the status output wasn't colored, even though color.ui
was set. Only when setting color.status it worked.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 builtin-commit.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e88b78f..2d90f74 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -945,6 +945,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	git_config(git_commit_config, NULL);
 
+	if (wt_status_use_color == -1)
+		wt_status_use_color = git_use_color_default;
+
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
 
 	index_file = prepare_index(argc, argv, prefix);
-- 
1.6.1.35.g0c23
