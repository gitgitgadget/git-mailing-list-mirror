From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/38] resolve_gitlink_packed_ref(): remove function
Date: Fri,  3 Jun 2016 23:03:48 +0200
Message-ID: <ebfdfb0bb15f16418f9155c529a486feacc776c4.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHm-00013O-AF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbcFCVFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:31 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48494 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932948AbcFCVFC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:02 -0400
X-AuditID: 12074414-62bff700000008e6-ce-5751f0f0220c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 73.49.02278.0F0F1575; Fri,  3 Jun 2016 17:04:48 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcd003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:46 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsUixO6iqPvhQ2C4wfxPChbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M74ueAEe0Ezb8Xma3+ZGhjPcHUx
	cnJICJhIzH2+mQ3EFhLYyijR+6mui5ELyD7OJNHy+g5Ygk1AV2JRTzMTiC0iECHR8KqFEaSI
	WWAOk8Tth53MIAlhAReJrWdusncxcnCwCKhKTP4vDGLyCkRJfFnrD7FLTuLy9AdgIzkFLCRa
	Pq9ihdhrLtF46jDLBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0LfRyM0v0UlNKNzFC
	Ak5kB+ORk3KHGAU4GJV4eE+8CAwXYk0sK67MPcQoycGkJMq79w5QiC8pP6UyI7E4I76oNCe1
	+BCjBAezkghvymugHG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwMB4eSBO+i
	90CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDwjy8GRgBIigdoL/cHkL3FBYm5
	QFGI1lOMilLivIdA5gqAJDJK8+DGwtLIK0ZxoC+FeQNB2nmAKQiu+xXQYCagwQWP/EEGlyQi
	pKQaGGvV035f98k50eI3K2D7l3jnzdeVPjn8SFm/Ywtf8ioJzz0ykkcVE2ddkv5kfCz0rI7C
	i0yle70KSzsrLvx6fmKebvWWBMUTD1t9/1UlLlDRKd97p+Dkony9nC7j46vTdu7S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296386>

Now that resolve_packed_ref() can work with an arbitrary
files_ref_store, there is no need to have a separate
resolve_gitlink_packed_ref() function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b54355d..5f14227 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1494,25 +1494,6 @@ static void unlock_ref(struct ref_lock *lock)
 
 #define MAXREFLEN (1024)
 
-/*
- * Called by resolve_gitlink_ref_recursive() after it failed to read
- * from the loose refs in refs. Find <refname> in the packed-refs file
- * for the submodule.
- */
-static int resolve_gitlink_packed_ref(struct files_ref_store *refs,
-				      const char *refname, unsigned char *sha1)
-{
-	struct ref_entry *ref;
-	struct ref_dir *dir = get_packed_refs(refs);
-
-	ref = find_ref(dir, refname);
-	if (ref == NULL)
-		return -1;
-
-	hashcpy(sha1, ref->u.value.oid.hash);
-	return 0;
-}
-
 static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
 					 const char *refname, unsigned char *sha1,
 					 int recursion)
@@ -1528,8 +1509,11 @@ static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
 		: git_pathdup("%s", refname);
 	fd = open(path, O_RDONLY);
 	free(path);
-	if (fd < 0)
-		return resolve_gitlink_packed_ref(refs, refname, sha1);
+	if (fd < 0) {
+		unsigned int flags;
+
+		return resolve_packed_ref(refs, refname, sha1, &flags);
+	}
 
 	len = read(fd, buffer, sizeof(buffer)-1);
 	close(fd);
-- 
2.8.1
