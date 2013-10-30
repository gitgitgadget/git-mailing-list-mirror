From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/23] builtin/remote.c:update(): use struct argv_array
Date: Wed, 30 Oct 2013 06:33:03 +0100
Message-ID: <1383111192-23780-15-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:42:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXd-0007Wr-V7
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab3J3Fl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:59 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61769 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692Ab3J3Fl5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:57 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 01:41:57 EDT
X-AuditID: 12074412-b7fc96d0000023d5-62-52709a6051af
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.D2.09173.06A90725; Wed, 30 Oct 2013 01:34:24 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIP014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:22 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqJswqyDI4PsCc4vpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE742y7UcEXwYot/7tYGhhf8nUxcnBICJhI3NrA1cXICWSKSVy4t56ti5GLQ0jgMqPEvtkL
	2SGcK0wS15/cYAOpYhPQlVjU08wEYosIqElMbDvEAlLELDCRWeL49EUsIAlhAS+J86eXMYPY
	LAKqEuvanzCBbOMVcJWY+bIIYpuCxI3mqawgNidQ+NOum+wgtpCAi0RT+2f2CYy8CxgZVjHK
	JeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEhKzQDsb1J+UOMQpwMCrx8Bo8yA8S
	Yk0sK67MPcQoycGkJMqbNqUgSIgvKT+lMiOxOCO+qDQntfgQowQHs5II7/TjQOW8KYmVValF
	+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8yjOBhgoWpaanVqRl5pQgpJk4OEEE
	F8gGHqANPCCFvMUFibnFmekQRacYFaXEeRVAEgIgiYzSPLgBsOTyilEc6B9hiHYeYGKC634F
	NJgJaPAeljyQwSWJCCmpBkZBmxX5DS91Jv2L3duwd1e4vYDs3p0Hd7X+5p7/0zA3e3plz9vy
	Fa7XC5pbE3UWni96cuq8+HqH238aHuqsjlx70v/34z1xak/jD7HMW35U3LeGN2ZL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236977>

Use struct argv_array for calling the "git fetch" subprocesses.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index ecedd96..bffe2f9 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -6,6 +6,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
+#include "argv-array.h"
 
 static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose]"),
@@ -1376,36 +1377,36 @@ static int update(int argc, const char **argv)
 			 N_("prune remotes after fetching")),
 		OPT_END()
 	};
-	const char **fetch_argv;
-	int fetch_argc = 0;
+	struct argv_array fetch_argv = ARGV_ARRAY_INIT;
 	int default_defined = 0;
-
-	fetch_argv = xmalloc(sizeof(char *) * (argc+5));
+	int retval;
 
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_update_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
-	fetch_argv[fetch_argc++] = "fetch";
+	argv_array_push(&fetch_argv, "fetch");
 
 	if (prune)
-		fetch_argv[fetch_argc++] = "--prune";
+		argv_array_push(&fetch_argv, "--prune");
 	if (verbose)
-		fetch_argv[fetch_argc++] = "-v";
-	fetch_argv[fetch_argc++] = "--multiple";
+		argv_array_push(&fetch_argv, "-v");
+	argv_array_push(&fetch_argv, "--multiple");
 	if (argc < 2)
-		fetch_argv[fetch_argc++] = "default";
+		argv_array_push(&fetch_argv, "default");
 	for (i = 1; i < argc; i++)
-		fetch_argv[fetch_argc++] = argv[i];
+		argv_array_push(&fetch_argv, argv[i]);
 
-	if (strcmp(fetch_argv[fetch_argc-1], "default") == 0) {
+	if (strcmp(fetch_argv.argv[fetch_argv.argc-1], "default") == 0) {
 		git_config(get_remote_default, &default_defined);
-		if (!default_defined)
-			fetch_argv[fetch_argc-1] = "--all";
+		if (!default_defined) {
+			argv_array_pop(&fetch_argv);
+			argv_array_push(&fetch_argv, "--all");
+		}
 	}
 
-	fetch_argv[fetch_argc] = NULL;
-
-	return run_command_v_opt(fetch_argv, RUN_GIT_CMD);
+	retval = run_command_v_opt(fetch_argv.argv, RUN_GIT_CMD);
+	argv_array_clear(&fetch_argv);
+	return retval;
 }
 
 static int remove_all_fetch_refspecs(const char *remote, const char *key)
-- 
1.8.4.1
