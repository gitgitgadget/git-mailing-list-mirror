From: Tommi Virtanen <tv@inoi.fi>
Subject: [PATCH] Fix segfault in git-shell when given no argument.
Date: Fri, 25 Nov 2005 13:49:31 +0200
Message-ID: <11329193711298-git-send-email-tv@inoi.fi>
Reply-To: Tommi Virtanen <tv@inoi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@inoi.fi>
X-From: git-owner@vger.kernel.org Fri Nov 25 12:51:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efc5S-0003dt-OM
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 12:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVKYLtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 06:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKYLtk
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 06:49:40 -0500
Received: from i1.inoi.fi ([194.100.97.46]:31908 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S1751219AbVKYLtk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 06:49:40 -0500
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 79591F5111;
	Fri, 25 Nov 2005 13:49:47 +0200 (EET)
Received: from pooch.inoi.fi (GMMDXXVII.dsl.saunalahti.fi [85.76.242.28])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 1CECCF4D30;
	Fri, 25 Nov 2005 13:49:47 +0200 (EET)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id 8A551BA068;
	Fri, 25 Nov 2005 13:49:31 +0200 (EET)
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12739>

The bug is trivially reproducible with "git-shell -c git-receive-pack"

Signed-off-by: Tommi Virtanen <tv@inoi.fi>

---

 shell.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: 2ada0cb8fce070b6b2c56fa689791230636f1857
4fbfea212a9afcd123a213e20388b1fa775fc7fe
diff --git a/shell.c b/shell.c
index 2c4789e..7fab432 100644
--- a/shell.c
+++ b/shell.c
@@ -5,6 +5,8 @@ static int do_generic_cmd(const char *me
 {
 	const char *my_argv[4];
 
+	if (!arg)
+		die("missing argument");
 	arg = sq_dequote(arg);
 	if (!arg)
 		die("bad argument");
---
0.99.9.GIT
