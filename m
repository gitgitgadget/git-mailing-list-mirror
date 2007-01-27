From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/4] Prefer %d over %i in printf format strings.
Date: Sat, 27 Jan 2007 01:51:56 -0500
Message-ID: <20070127065156.GA10380@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 07:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAhPy-0000yf-OE
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 07:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbXA0GwD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 01:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbXA0GwD
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 01:52:03 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49327 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbXA0GwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 01:52:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HAhPq-000805-GO; Sat, 27 Jan 2007 01:51:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C85E620FBAE; Sat, 27 Jan 2007 01:51:56 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37924>

The git project seems to prefer using %d when formatting signed
integer values.  These handful of locations were noticed by Junio
as not conforming.  At least one of them was my fault, perhaps
the others were too.  :-)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |    2 +-
 receive-pack.c     |    2 +-
 sha1_file.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 4921eee..f8afb9c 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -182,7 +182,7 @@ static void describe(const char *arg, int last_one)
 		fprintf(stderr, "traversed %lu commits\n", seen_commits);
 		if (gave_up_on) {
 			fprintf(stderr,
-				"more than %i tags found; listed %i most recent\n"
+				"more than %d tags found; listed %d most recent\n"
 				"gave up search at %s\n",
 				max_candidates, max_candidates,
 				sha1_to_hex(gave_up_on->object.sha1));
diff --git a/receive-pack.c b/receive-pack.c
index 7d26326..19bc685 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -317,7 +317,7 @@ static const char *unpack(void)
 		char keep_arg[256];
 		char packname[46];
 
-		s = sprintf(keep_arg, "--keep=receive-pack %i on ", getpid());
+		s = sprintf(keep_arg, "--keep=receive-pack %d on ", getpid());
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 			strcpy(keep_arg + s, "localhost");
 
diff --git a/sha1_file.c b/sha1_file.c
index 498665e..335b4b4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1326,7 +1326,7 @@ void *unpack_entry(struct packed_git *p, unsigned long offset,
 		retval = unpack_compressed_entry(p, &w_curs, offset, size);
 		break;
 	default:
-		die("unknown object type %i in %s", kind, p->pack_name);
+		die("unknown object type %d in %s", kind, p->pack_name);
 	}
 	unuse_pack(&w_curs);
 	return retval;
-- 
1.5.0.rc2.g8a816
