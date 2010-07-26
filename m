From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC PATCH 2/2] Allow "git log -S string" as synonym for "git log -Sstring".
Date: Mon, 26 Jul 2010 20:14:38 +0200
Message-ID: <1280168078-31147-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 26 20:15:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSCX-0005tX-8W
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab0GZSOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:14:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36342 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754712Ab0GZSOr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:14:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6QID3Uq008919
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Jul 2010 20:13:03 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdSCJ-0002Ha-Nj; Mon, 26 Jul 2010 20:14:43 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdSCJ-000874-MT; Mon, 26 Jul 2010 20:14:43 +0200
X-Mailer: git-send-email 1.7.2.23.g58c3b.dirty
In-Reply-To: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Jul 2010 20:13:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6QID3Uq008919
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280772785.2628@w9nGIaOjTC8NOuwh1+3GIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151868>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 diff.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 17873f3..4e3be89 100644
--- a/diff.c
+++ b/diff.c
@@ -2993,6 +2993,7 @@ static int diff_scoreopt_parse(const char *opt);
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
+	const char *optarg = av[1];
 
 	/* Output format options */
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch"))
@@ -3182,6 +3183,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->line_termination = 0;
 	else if (!prefixcmp(arg, "-l"))
 		options->rename_limit = strtoul(arg+2, NULL, 10);
+	else if (!strcmp(arg, "-S")) {
+		options->pickaxe = optarg;
+		return 2;
+	}
 	else if (!prefixcmp(arg, "-S"))
 		options->pickaxe = arg + 2;
 	else if (!strcmp(arg, "--pickaxe-all"))
-- 
1.7.2.23.g58c3b.dirty
