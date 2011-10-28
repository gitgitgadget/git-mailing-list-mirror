From: mhagger@alum.mit.edu
Subject: [PATCH v2 01/12] Rename another local variable name -> refname
Date: Fri, 28 Oct 2011 13:27:53 +0200
Message-ID: <1319801284-15625-2-git-send-email-mhagger@alum.mit.edu>
References: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:28:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkbn-0002Nv-T0
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335Ab1J1L2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:28:18 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:54966 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab1J1L2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:28:14 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkVI-0007Cx-Dl; Fri, 28 Oct 2011 13:21:40 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184364>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 1c6de61..855c791 100644
--- a/refs.c
+++ b/refs.c
@@ -316,11 +316,11 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 	if (dir) {
 		struct dirent *de;
 		int baselen = strlen(base);
-		char *ref = xmalloc(baselen + 257);
+		char *refname = xmalloc(baselen + 257);
 
-		memcpy(ref, base, baselen);
+		memcpy(refname, base, baselen);
 		if (baselen && base[baselen-1] != '/')
-			ref[baselen++] = '/';
+			refname[baselen++] = '/';
 
 		while ((de = readdir(dir)) != NULL) {
 			unsigned char sha1[20];
@@ -336,31 +336,31 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 				continue;
 			if (has_extension(de->d_name, ".lock"))
 				continue;
-			memcpy(ref + baselen, de->d_name, namelen+1);
+			memcpy(refname + baselen, de->d_name, namelen+1);
 			refdir = *refs->name
-				? git_path_submodule(refs->name, "%s", ref)
-				: git_path("%s", ref);
+				? git_path_submodule(refs->name, "%s", refname)
+				: git_path("%s", refname);
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				get_ref_dir(refs, ref, array);
+				get_ref_dir(refs, refname, array);
 				continue;
 			}
 			if (*refs->name) {
 				hashclr(sha1);
 				flag = 0;
-				if (resolve_gitlink_ref(refs->name, ref, sha1) < 0) {
+				if (resolve_gitlink_ref(refs->name, refname, sha1) < 0) {
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
 			} else
-				if (!resolve_ref(ref, sha1, 1, &flag)) {
+				if (!resolve_ref(refname, sha1, 1, &flag)) {
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			add_ref(ref, sha1, flag, array, NULL);
+			add_ref(refname, sha1, flag, array, NULL);
 		}
-		free(ref);
+		free(refname);
 		closedir(dir);
 	}
 }
-- 
1.7.7
