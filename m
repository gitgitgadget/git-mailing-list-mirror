From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] git-commit: colored status when color.ui is set
Date: Sun, 21 Dec 2008 23:15:00 +0100
Message-ID: <200812212315.00740.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 21 23:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWar-00062X-5x
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbYLUWOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYLUWOw
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:14:52 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:39470 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYLUWOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:14:52 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3F1D3FADB818;
	Sun, 21 Dec 2008 23:14:51 +0100 (CET)
Received: from [91.19.14.55] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LEWZX-0005hz-00; Sun, 21 Dec 2008 23:14:51 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+NKKCOVe8TFUemFFT5UMLDlc1ZajHnTcW635vU
	UOZ5kwuODtWhCRQj3VP+gT9kjISnpxxAbWWhU7KxHHo9ZaNA1v
	iyetmpL15DAzPj6A/Q/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103720>

When using "git commit" and there was nothing to commit (the editor
wasn't launched), the status output wasn't colored, even though color.ui
was set. Only when setting color.status it worked.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 builtin-commit.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index ac88dc2..7cf227a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -948,6 +948,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	git_config(git_commit_config, NULL);
 
+	if (wt_status_use_color == -1)
+		wt_status_use_color = git_use_color_default;
+
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
 
 	index_file = prepare_index(argc, argv, prefix);
-- 
1.6.1.rc3.62.g7c0a2
