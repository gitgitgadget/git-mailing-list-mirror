From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] git-status -v: colored diff when color.ui is set
Date: Sun, 21 Dec 2008 23:14:51 +0100
Message-ID: <200812212314.51950.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 21 23:16:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWag-0005zO-TP
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbYLUWOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbYLUWOo
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:14:44 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:40593 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYLUWOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:14:44 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id B8E7CF5AFD8C;
	Sun, 21 Dec 2008 23:14:42 +0100 (CET)
Received: from [91.19.14.55] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LEWZO-0005gH-00; Sun, 21 Dec 2008 23:14:42 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1941YntLE1G5Gatf6Z5H/+9rkVsZdfEFLZAU/xT
	xsQpve38n6TC+F0aOwjPpoDbc75NTV7Lak4IrcVnX6Vky1eenZ
	mSKw8midE5ba2ZMtYaUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103719>

When using "git status -v", the diff output wasn't colored, even though
color.ui was set. Only when setting color.diff it worked.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 builtin-commit.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e88b78f..ac88dc2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -866,6 +866,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (wt_status_use_color == -1)
 		wt_status_use_color = git_use_color_default;
 
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
 	argc = parse_and_validate_options(argc, argv, builtin_status_usage, prefix);
 
 	index_file = prepare_index(argc, argv, prefix);
-- 
1.6.1.rc3.62.g7c0a2
