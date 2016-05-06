From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/33] read_raw_ref(): rename symref argument to referent
Date: Fri,  6 May 2016 18:13:55 +0200
Message-ID: <a81d595d8d327a37a98cffcdf5dc798969cfd39f.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiP4-0008Bp-2z
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672AbcEFQOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:49 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63737 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758559AbcEFQOr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:47 -0400
X-AuditID: 1207440d-bb3ff7000000090b-c2-572cc2f6320d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 91.48.02315.6F2CC275; Fri,  6 May 2016 12:14:46 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUu031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:44 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqPvtkE64wa82GYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8amw61sBU0SFTdfrGNqYOwR7mLk5JAQMJE4vn8y
	WxcjF4eQwFZGiUtdB5khnONMEnM3zWQBqWIT0JVY1NPMBGKLCERINLxqYexi5OBgFvjMKLGS
	GyQsLOAj0f1tKlgJi4CqxPcFF8BsXoEoiXu9W5gglslJXJ7+gA3E5hSwkDjUexwsLiRgLtGx
	9gb7BEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFCAox3B+P/dTKH
	GAU4GJV4eDNOaocLsSaWFVfmHmKU5GBSEuX9XqATLsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	98o+oBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYI36CBQo2BRanpq
	RVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoAuKLgTEAkuIB2isP0s5bXJCYCxSFaD3FqMtx
	ZP+9tUxCLHn5ealS4rxzQYoEQIoySvPgVsDSyStGcaCPhXkvg1TxAFMR3KRXQEuYgJa8n6sJ
	sqQkESEl1cBo7sBusyrykv6cb0eui5v9nOd3wd76mPm9L0HC1zzm2evvdpwRIv1pWfC2kszz
	it94+BbYKAVEbFj6yD2gc5794SldP1z3l3ZJLzXg7mwIPHP3vnPTW72llcp7+CuX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293806>

After all, it doesn't hold the symbolic reference, but rather the
reference referred to.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 21 +++++++++++----------
 refs/refs-internal.h |  2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8ced104..fbbd48f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1393,9 +1393,10 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * If the ref is a sha1, fill in sha1 and return 0.
  *
- * If the ref is symbolic, fill in *symref with the referrent
- * (e.g. "refs/heads/master") and return 0.  The caller is responsible
- * for validating the referrent.  Set REF_ISSYMREF in type.
+ * If the ref is symbolic, fill in *referent with the name of the
+ * branch to which it refers (e.g. "refs/heads/master") and return 0.
+ * The caller is responsible for validating the referent. Set
+ * REF_ISSYMREF in type.
  *
  * If the ref doesn't exist, set errno to ENOENT and return -1.
  *
@@ -1411,15 +1412,15 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * sb_path is workspace: the caller should allocate and free it.
  *
- * It is OK for refname to point into symref. In this case:
- * - if the function succeeds with REF_ISSYMREF, symref will be
+ * It is OK for refname to point into referent. In this case:
+ * - if the function succeeds with REF_ISSYMREF, referent will be
  *   overwritten and the memory pointed to by refname might be changed
  *   or even freed.
- * - in all other cases, symref will be untouched, and therefore
+ * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
 int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, unsigned int *type)
+		 struct strbuf *referent, unsigned int *type)
 {
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
@@ -1469,7 +1470,7 @@ stat_ref:
 		}
 		if (starts_with(sb_contents.buf, "refs/") &&
 		    !check_refname_format(sb_contents.buf, 0)) {
-			strbuf_swap(&sb_contents, symref);
+			strbuf_swap(&sb_contents, referent);
 			*type |= REF_ISSYMREF;
 			ret = 0;
 			goto out;
@@ -1518,8 +1519,8 @@ stat_ref:
 		while (isspace(*buf))
 			buf++;
 
-		strbuf_reset(symref);
-		strbuf_addstr(symref, buf);
+		strbuf_reset(referent);
+		strbuf_addstr(referent, buf);
 		*type |= REF_ISSYMREF;
 		ret = 0;
 		goto out;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0b047f6..37a1a37 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -210,6 +210,6 @@ int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
 
 int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, unsigned int *type);
+		 struct strbuf *referent, unsigned int *type);
 
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.8.1
