From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] shortlog: initialize nongit variable
Date: Tue, 25 Mar 2008 15:46:17 +0100
Message-ID: <1206456377-2735-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 15:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeAQb-00034z-Hp
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 15:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbYCYOqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 10:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbYCYOqU
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 10:46:20 -0400
Received: from francis.fzi.de ([141.21.7.5]:41485 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754337AbYCYOqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 10:46:19 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Mar 2008 15:46:16 +0100
X-Mailer: git-send-email 1.5.5.rc1
X-OriginalArrivalTime: 25 Mar 2008 14:46:16.0989 (UTC) FILETIME=[FB1E54D0:01C88E86]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78189>

setup_git_directory_gently() only modifies the value of the nongit
variable if we are not in a git repository, therefore nongit is left
uninitialized if we are in a git repository.  This sometimes broke
shortlog when it was not fed with a log on its standard input.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 builtin-shortlog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index bd795b1..60a6d45 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -229,7 +229,7 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
 {
 	struct shortlog log;
 	struct rev_info rev;
-	int nongit;
+	int nongit =3D 0;
=20
 	prefix =3D setup_git_directory_gently(&nongit);
 	shortlog_init(&log);
--=20
1.5.5.rc1
