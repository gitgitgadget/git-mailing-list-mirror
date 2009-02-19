From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 8/8] refs: use warning() instead of fprintf(stderr,
	"warning: ")
Date: Thu, 19 Feb 2009 13:55:44 +0100
Message-ID: <628e1950be4069a614567fd4fc06aa2ce95a1004.1235047192.git.vmiklos@frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8Sp-0001wB-7P
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbZBSMzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbZBSMzq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:55:46 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47478 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165AbZBSMzq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:55:46 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F2858580D1;
	Thu, 19 Feb 2009 13:55:45 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B4620446A6;
	Thu, 19 Feb 2009 13:55:44 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 012BB11B877C; Thu, 19 Feb 2009 13:55:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1235047192.git.vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110693>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 refs.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 6eb5f53..fd96824 100644
--- a/refs.c
+++ b/refs.c
@@ -995,7 +995,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 	err = unlink(git_path("logs/%s", lock->ref_name));
 	if (err && errno != ENOENT)
-		fprintf(stderr, "warning: unlink(%s) failed: %s",
+		warning("unlink(%s) failed: %s",
 			git_path("logs/%s", lock->ref_name), strerror(errno));
 	invalidate_cached_refs();
 	unlock_ref(lock);
@@ -1437,8 +1437,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 				if (get_sha1_hex(rec + 41, sha1))
 					die("Log %s is corrupt.", logfile);
 				if (hashcmp(logged_sha1, sha1)) {
-					fprintf(stderr,
-						"warning: Log %s has gap after %s.\n",
+					warning("Log %s has gap after %s.",
 						logfile, show_date(date, tz, DATE_RFC2822));
 				}
 			}
@@ -1450,8 +1449,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 				if (get_sha1_hex(rec + 41, logged_sha1))
 					die("Log %s is corrupt.", logfile);
 				if (hashcmp(logged_sha1, sha1)) {
-					fprintf(stderr,
-						"warning: Log %s unexpectedly ended on %s.\n",
+					warning("Log %s unexpectedly ended on %s.",
 						logfile, show_date(date, tz, DATE_RFC2822));
 				}
 			}
-- 
1.6.1
