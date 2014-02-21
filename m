From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] rename STATUS_FORMAT_NONE to STATUS_FORMAT_DEFAULT
Date: Sat, 22 Feb 2014 03:09:20 +0800
Message-ID: <1393009762-31133-2-git-send-email-rctay89@gmail.com>
References: <1393009762-31133-1-git-send-email-rctay89@gmail.com>
Cc: Tay Ray Chuan <rctay89@gmail.com>, Jeff King <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 21 20:10:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGvU3-0000a9-KS
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 20:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbaBUTJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 14:09:50 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:34586 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbaBUTJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 14:09:49 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so3821520pbb.6
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bp0YLIuiUfnlqYUGFfXwm2zDWJW5U8xdaviHJdRbPHg=;
        b=HNOSdVOhKXp5c+ahkMnxBetcdGszyz6A9xVE2EVpTP5c15thQT2T/1RohAkUVxqh++
         MhoweN9st3ugqMuVcb6VtZknJdTLgkmJpzdgT0g/O1e917y90fMc6H2tOCKAfxuUSbBe
         9aQK+c/ahcTv7rlFRP9IwlFhVMMqX1jXgi/iJVaTw0kcyjMHTlwyM2D68oO5epyj5B8F
         ig39vgje260A0Z3lXh+KUfNBO0GYbS2TKXR4ehZ30gizHBZXsHxeBXc8Wf5alPTc4McP
         TaqqJ0O5mtnvfDmTWRMYmefT/Peotkt4ujrvUkhCWTVV4+QdT33YSBd+uRY5oh7YB4gT
         dJsg==
X-Received: by 10.66.149.7 with SMTP id tw7mr10985137pab.72.1393009789188;
        Fri, 21 Feb 2014 11:09:49 -0800 (PST)
Received: from chiliad.localdomain (cm245.gamma242.maxonline.com.sg. [202.156.242.245])
        by mx.google.com with ESMTPSA id vf7sm23887999pbc.5.2014.02.21.11.09.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 11:09:48 -0800 (PST)
X-Mailer: git-send-email 1.9.0.291.g027825b
In-Reply-To: <1393009762-31133-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242488>

Cc: Jeff King <peff@peff.net>

In f3f47a1 (status: add --long output format option), STATUS_FORMAT_NONE
was introduced, meaning "the user did not specify anything". Rename this
to *_DEFAULT to better indicate its meaning.

This paves the way for _NONE to really mean "no status".

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/commit.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3783bca..2e86b76 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -125,7 +125,7 @@ static const char *only_include_assumed;
 static struct strbuf message = STRBUF_INIT;
 
 static enum status_format {
-	STATUS_FORMAT_NONE = 0,
+	STATUS_FORMAT_DEFAULT = 0,
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
@@ -487,7 +487,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	case STATUS_FORMAT_UNSPECIFIED:
 		die("BUG: finalize_deferred_config() should have been called");
 		break;
-	case STATUS_FORMAT_NONE:
+	case STATUS_FORMAT_DEFAULT:
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
 		break;
@@ -1028,7 +1028,7 @@ static void finalize_deferred_config(struct wt_status *s)
 				   !s->null_termination);
 
 	if (s->null_termination) {
-		if (status_format == STATUS_FORMAT_NONE ||
+		if (status_format == STATUS_FORMAT_DEFAULT ||
 		    status_format == STATUS_FORMAT_UNSPECIFIED)
 			status_format = STATUS_FORMAT_PORCELAIN;
 		else if (status_format == STATUS_FORMAT_LONG)
@@ -1038,7 +1038,7 @@ static void finalize_deferred_config(struct wt_status *s)
 	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
 		status_format = status_deferred_config.status_format;
 	if (status_format == STATUS_FORMAT_UNSPECIFIED)
-		status_format = STATUS_FORMAT_NONE;
+		status_format = STATUS_FORMAT_DEFAULT;
 
 	if (use_deferred_config && s->show_branch < 0)
 		s->show_branch = status_deferred_config.show_branch;
@@ -1141,7 +1141,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (all && argc > 0)
 		die(_("Paths with -a does not make sense."));
 
-	if (status_format != STATUS_FORMAT_NONE)
+	if (status_format != STATUS_FORMAT_DEFAULT)
 		dry_run = 1;
 
 	return argc;
@@ -1197,7 +1197,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		if (git_config_bool(k, v))
 			status_deferred_config.status_format = STATUS_FORMAT_SHORT;
 		else
-			status_deferred_config.status_format = STATUS_FORMAT_NONE;
+			status_deferred_config.status_format = STATUS_FORMAT_DEFAULT;
 		return 0;
 	}
 	if (!strcmp(k, "status.branch")) {
@@ -1314,7 +1314,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_UNSPECIFIED:
 		die("BUG: finalize_deferred_config() should have been called");
 		break;
-	case STATUS_FORMAT_NONE:
+	case STATUS_FORMAT_DEFAULT:
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
 		s.ignore_submodule_arg = ignore_submodule_arg;
@@ -1522,7 +1522,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
 	status_init_config(&s, git_commit_config);
-	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
+	status_format = STATUS_FORMAT_DEFAULT; /* Ignore status.short */
 	s.colopts = 0;
 
 	if (get_sha1("HEAD", sha1))
-- 
1.9.0.291.g027825b
