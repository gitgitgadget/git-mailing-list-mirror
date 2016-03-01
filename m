From: Jeff King <peff@peff.net>
Subject: [PATCH 09/10] setup: drop repository_format_version global
Date: Tue, 1 Mar 2016 09:45:30 -0500
Message-ID: <20160301144530.GI12887@sigill.intra.peff.net>
References: <20160301143546.GA30806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 15:45:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aalYb-00012o-Ap
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbcCAOph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 09:45:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:52458 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754391AbcCAOpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:45:33 -0500
Received: (qmail 27938 invoked by uid 102); 1 Mar 2016 14:45:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:45:32 -0500
Received: (qmail 8259 invoked by uid 107); 1 Mar 2016 14:45:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:45:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 09:45:30 -0500
Content-Disposition: inline
In-Reply-To: <20160301143546.GA30806@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288026>

Nobody reads this anymore, and they're not likely to; the
interesting thing is whether or not we passed
check_repository_format(), and possibly the individual
"extension" variables.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h       | 1 -
 environment.c | 1 -
 setup.c       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/cache.h b/cache.h
index 1795807..ecefa00 100644
--- a/cache.h
+++ b/cache.h
@@ -747,7 +747,6 @@ extern int grafts_replace_parents;
  */
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
-extern int repository_format_version;
 extern int repository_format_precious_objects;
 
 struct repository_format {
diff --git a/environment.c b/environment.c
index 8b8c8e8..d9e3861 100644
--- a/environment.c
+++ b/environment.c
@@ -25,7 +25,6 @@ int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
-int repository_format_version;
 int repository_format_precious_objects;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
diff --git a/setup.c b/setup.c
index a04d7dd..f52011e 100644
--- a/setup.c
+++ b/setup.c
@@ -428,7 +428,6 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 		die("%s", err.buf);
 	}
 
-	repository_format_version = candidate.version;
 	repository_format_precious_objects = candidate.precious_objects;
 	string_list_clear(&candidate.unknown_extensions, 0);
 	if (!has_common) {
-- 
2.8.0.rc0.278.gfeb5644
