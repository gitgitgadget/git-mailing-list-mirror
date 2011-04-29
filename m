From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 8/8] Mark dirstat error messages for translation
Date: Fri, 29 Apr 2011 11:36:23 +0200
Message-ID: <1304069783-22739-9-git-send-email-johan@herland.net>
References: <7vfwp13dme.fsf@alter.siamese.dyndns.org>
 <1304069783-22739-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 11:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFk8P-0004WC-NK
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 11:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758048Ab1D2Jgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 05:36:51 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52918 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569Ab1D2Jgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 05:36:44 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKE00BN8QOZZU50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 11:36:35 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 242731EEFBEE_DBA86A3B	for <git@vger.kernel.org>; Fri,
 29 Apr 2011 09:36:35 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 6D57D1EEFCF5_DBA86A2F	for <git@vger.kernel.org>; Fri,
 29 Apr 2011 09:36:34 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKE00LICQOV8010@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 11:36:34 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1304069783-22739-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172442>

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

This patch WILL NOT COMPILE until the topic branch is merged with an
i18n/gettext-aware branch (i.e. where _() and test_i18ngrep is present).

 diff.c                  |    8 ++++----
 t/t4047-diff-dirstat.sh |   22 +++++++++++-----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index b290543..0f65413 100644
--- a/diff.c
+++ b/diff.c
@@ -101,12 +101,12 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 			if (end - p == p_len)
 				options->dirstat_permille = permille;
 			else {
-				strbuf_addf(errmsg, "  Failed to parse dirstat cut-off percentage '%.*s'\n",
+				strbuf_addf(errmsg, _("  Failed to parse dirstat cut-off percentage '%.*s'\n"),
 					    p_len, p);
 				ret++;
 			}
 		} else {
-			strbuf_addf(errmsg, "  Unknown dirstat parameter '%.*s'\n",
+			strbuf_addf(errmsg, _("  Unknown dirstat parameter '%.*s'\n"),
 				    p_len, p);
 			ret++;
 		}
@@ -202,7 +202,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		struct strbuf errmsg = STRBUF_INIT;
 		default_diff_options.dirstat_permille = diff_dirstat_permille_default;
 		if (parse_dirstat_params(&default_diff_options, value, &errmsg))
-			warning("Found errors in 'diff.dirstat' config variable:\n%s",
+			warning(_("Found errors in 'diff.dirstat' config variable:\n%s"),
 				errmsg.buf);
 		strbuf_release(&errmsg);
 		diff_dirstat_permille_default = default_diff_options.dirstat_permille;
@@ -3255,7 +3255,7 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 {
 	struct strbuf errmsg = STRBUF_INIT;
 	if (parse_dirstat_params(options, params, &errmsg))
-		die("Failed to parse --dirstat/-X option parameter:\n%s",
+		die(_("Failed to parse --dirstat/-X option parameter:\n%s"),
 		    errmsg.buf);
 	strbuf_release(&errmsg);
 	/*
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index cc947fd..29e80a5 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -943,37 +943,37 @@ test_expect_success '--dirstat=future_param,lines,0 should fail loudly' '
 	test_must_fail git diff --dirstat=future_param,lines,0 HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_cmp /dev/null actual_diff_dirstat &&
-	grep -q "future_param" actual_error &&
-	grep -q "\--dirstat" actual_error
+	test_i18ngrep -q "future_param" actual_error &&
+	test_i18ngrep -q "\--dirstat" actual_error
 '
 
 test_expect_success '--dirstat=dummy1,cumulative,2dummy should report both unrecognized parameters' '
 	test_must_fail git diff --dirstat=dummy1,cumulative,2dummy HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_cmp /dev/null actual_diff_dirstat &&
-	grep -q "dummy1" actual_error &&
-	grep -q "2dummy" actual_error &&
-	grep -q "\--dirstat" actual_error
+	test_i18ngrep -q "dummy1" actual_error &&
+	test_i18ngrep -q "2dummy" actual_error &&
+	test_i18ngrep -q "\--dirstat" actual_error
 '
 
 test_expect_success 'diff.dirstat=future_param,0,lines should warn, but still work' '
 	git -c diff.dirstat=future_param,0,lines diff --dirstat HEAD^..HEAD >actual_diff_dirstat 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_cmp expect_diff_dirstat actual_diff_dirstat &&
-	grep -q "future_param" actual_error &&
-	grep -q "diff\\.dirstat" actual_error &&
+	test_i18ngrep -q "future_param" actual_error &&
+	test_i18ngrep -q "diff\\.dirstat" actual_error &&
 
 	git -c diff.dirstat=future_param,0,lines diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
-	grep -q "future_param" actual_error &&
-	grep -q "diff\\.dirstat" actual_error &&
+	test_i18ngrep -q "future_param" actual_error &&
+	test_i18ngrep -q "diff\\.dirstat" actual_error &&
 
 	git -c diff.dirstat=future_param,0,lines diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC &&
-	grep -q "future_param" actual_error &&
-	grep -q "diff\\.dirstat" actual_error
+	test_i18ngrep -q "future_param" actual_error &&
+	test_i18ngrep -q "diff\\.dirstat" actual_error
 '
 
 test_done
-- 
1.7.5.rc1.3.g4d7b
