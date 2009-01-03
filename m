From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] fast-export: print usage when no options specified
Date: Sat,  3 Jan 2009 04:59:12 +0100
Message-ID: <1230955152-23646-1-git-send-email-vmiklos@frugalware.org>
References: <87r63lus6k.fsf@jidanni.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jidanni@jidanni.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 04:59:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIxfm-0004JE-2J
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 04:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbZACD5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 22:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZACD5V
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 22:57:21 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:39586 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbZACD5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 22:57:21 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 4F78D446CE1;
	Sat,  3 Jan 2009 04:57:17 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 37A3C19DB57; Sat,  3 Jan 2009 04:59:13 +0100 (CET)
X-Mailer: git-send-email 1.6.1
In-Reply-To: <87r63lus6k.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104453>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I found that behaviour surprising as well when I saw it the first time.
git rev-list outputs some usage info in that case, git log just logs
HEAD. Given that unconditionally exporting HEAD with no arguments is
probably not something most users want, here is a patch to make the
behaviour like what git rev-list already has.

 builtin-fast-export.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 8386338..e9ee2c7 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -497,6 +497,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	if (argc == 1)
+		usage_with_options (fast_export_usage, options);
+
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
 
-- 
1.6.1
