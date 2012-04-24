From: mhagger@alum.mit.edu
Subject: [PATCH 03/30] get_ref_dir(): rename "base" parameter to "dirname"
Date: Wed, 25 Apr 2012 00:45:09 +0200
Message-ID: <1335307536-26914-4-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:52:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMoaZ-0004vl-JN
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758186Ab2DXWwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:52:01 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:48853 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758083Ab2DXWv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:51:57 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id A6637248142;
	Wed, 25 Apr 2012 00:45:53 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196257>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index df98622..dc2b4df 100644
--- a/refs.c
+++ b/refs.c
@@ -749,30 +749,30 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 			create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
-static void get_ref_dir(struct ref_cache *refs, const char *base,
+static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 			struct ref_dir *dir)
 {
 	DIR *d;
 	const char *path;
 	struct dirent *de;
-	int baselen;
+	int dirnamelen;
 	struct strbuf refname;
 
 	if (*refs->name)
-		path = git_path_submodule(refs->name, "%s", base);
+		path = git_path_submodule(refs->name, "%s", dirname);
 	else
-		path = git_path("%s", base);
+		path = git_path("%s", dirname);
 
 	d = opendir(path);
 	if (!d)
 		return;
 
-	baselen = strlen(base);
-	strbuf_init(&refname, baselen + 257);
-	strbuf_add(&refname, base, baselen);
-	if (baselen && base[baselen-1] != '/') {
+	dirnamelen = strlen(dirname);
+	strbuf_init(&refname, dirnamelen + 257);
+	strbuf_add(&refname, dirname, dirnamelen);
+	if (dirnamelen && dirname[dirnamelen-1] != '/') {
 		strbuf_addch(&refname, '/');
-		baselen++;
+		dirnamelen++;
 	}
 
 	while ((de = readdir(d)) != NULL) {
@@ -807,7 +807,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 			}
 			add_ref(dir, create_ref_entry(refname.buf, sha1, flag, 1));
 		}
-		strbuf_setlen(&refname, baselen);
+		strbuf_setlen(&refname, dirnamelen);
 	}
 	strbuf_release(&refname);
 	closedir(d);
-- 
1.7.10
