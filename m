From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/33] lock_ref_sha1_basic(): remove unneeded local variable
Date: Fri,  6 May 2016 18:13:58 +0200
Message-ID: <3484a284a7e2d495bff9179aef5ecf29d309e8c1.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPF-0008Kk-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758703AbcEFQPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:04 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56556 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758677AbcEFQOx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:53 -0400
X-AuditID: 12074412-51bff700000009f7-09-572cc2fb8ef3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 85.62.02551.BF2CC275; Fri,  6 May 2016 12:14:51 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUx031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:50 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPv7kE64QcNmLYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8b/TQsZC7bxVRx9eoK5gXESdxcjJ4eEgIlEz8ul
	7F2MXBxCAlsZJXb++skIkhASOM4kMe2eBIjNJqArsainmQnEFhGIkGh41QJUw8HBLPCZUWIl
	2BxhAX+JqQtmsYHYLAKqEt93b2ABsXkFoiS+/nzABLFLTuLy9AdgNZwCFhKHeo8zQawyl+hY
	e4N9AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxgh4SW0g3H9SblD
	jAIcjEo8vBkntcOFWBPLiitzDzFKcjApifJ+L9AJF+JLyk+pzEgszogvKs1JLT7EKMHBrCTC
	e2UfUI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYL30EGgRsGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQ+McXAyMAJMUDtFcepJ23uCAxFygK0XqKUZfj
	yP57a5mEWPLy81KlxHnnghQJgBRllObBrYAlk1eM4kAfC/NOAqniASYiuEmvgJYwAS15P1cT
	ZElJIkJKqoFx+paTE050zTh9p185xktSsuMI1xqLKhVGU0G7gMBLh7P+XD/uZfl+W3Apm26y
	8BfGSScqNAsnF+9r/1JR9ETmmYFmhXil4L2Tk8UckiSLzzZf3LNg2dT3GoHcc/zT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293810>

resolve_ref_unsafe() can cope with being called with NULL passed to its
flags argument. So lock_ref_sha1_basic() can just hand its own type
parameter through.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fc0c7c1..97377c7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1738,7 +1738,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
-					    unsigned int flags, int *type_p,
+					    unsigned int flags, int *type,
 					    struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
@@ -1746,7 +1746,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	const char *orig_refname = refname;
 	struct ref_lock *lock;
 	int last_errno = 0;
-	int type;
 	int lflags = 0;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
@@ -1766,7 +1765,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	}
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
-				     lock->old_oid.hash, &type);
+				     lock->old_oid.hash, type);
 	if (!refname && errno == EISDIR) {
 		/*
 		 * we are trying to lock foo but we used to
@@ -1784,10 +1783,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
-					     lock->old_oid.hash, &type);
+					     lock->old_oid.hash, type);
 	}
-	if (type_p)
-	    *type_p = type;
 	if (!refname) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-- 
2.8.1
