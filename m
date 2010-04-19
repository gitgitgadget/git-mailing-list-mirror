From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] reflog: make the 'show' subcommand really the default
Date: Mon, 19 Apr 2010 11:52:29 +0200
Message-ID: <1271670750-30297-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 12:08:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ntc-0005a6-Ra
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 12:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab0DSKH7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 06:07:59 -0400
Received: from francis.fzi.de ([141.21.7.5]:55038 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753518Ab0DSKH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 06:07:57 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2010 06:07:56 EDT
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Apr 2010 11:52:38 +0200
X-Mailer: git-send-email 1.7.1.rc1.43.gf0841
X-OriginalArrivalTime: 19 Apr 2010 09:52:38.0214 (UTC) FILETIME=[0B63DE60:01CADFA6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145288>

Since the introduction of the 'show' subcommand in cf39f54e (git
reflog show, 2007-02-08), 'git reflog's documentation states that in
the absence of any subcommands 'show' is the default.  Although 'git
reflog <log-options>' works as described, i.e. it defaults to 'show',
the command 'git reflog <ref>' errors out showing the usage instead of
showing the specified ref's reflog.  Fix this by treating an unknown
subcommand as a ref for 'show'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 builtin/reflog.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 64e45bd..d4d4409 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -712,6 +712,5 @@ int cmd_reflog(int argc, const char **argv, const c=
har *prefix)
 	if (!strcmp(argv[1], "delete"))
 		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
=20
-	/* Not a recognized reflog command..*/
-	usage(reflog_usage);
+	return cmd_log_reflog(argc, argv, prefix);
 }
--=20
1.7.1.rc1.43.gf0841
