From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/38] get_packed_ref(): add a files_ref_store argument
Date: Fri,  3 Jun 2016 23:03:42 +0200
Message-ID: <bf2601a0a5c940b5c9f81f917c1935d3d3144c93.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ0-00025e-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbcFCVGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:30 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61153 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932214AbcFCVEi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:38 -0400
X-AuditID: 1207440f-8a7ff700000008e4-e9-5751f0e5a462
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 44.EB.02276.5E0F1575; Fri,  3 Jun 2016 17:04:37 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcX003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:35 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqPv0Q2C4wYYGCYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGdc3ryMtaBJqGJO0ySmBsa9fF2M
	nBwSAiYSF/bfZ+li5OIQEtjKKDFl2x82COc4k8TT5bNZQarYBHQlFvU0M4HYIgIREg2vWhhB
	ipgF5jBJ3H7YydzFyMEhLOAucfAUP0gNi4CqxM2HrYwgNq9AlMTdF8uYILbJSVye/oANxOYU
	sJBo+bwKbL6QgLlE46nDLBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXRy80s0UtN
	Kd3ECAk6/h2MXetlDjEKcDAq8fCeeBEYLsSaWFZcmXuIUZKDSUmUd+8doBBfUn5KZUZicUZ8
	UWlOavEhRgkOZiUR3pTXQDnelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeH
	kgTvovdAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgGIgvBkYBSIoHaC/3B5C9
	xQWJuUBRiNZTjIpS4ryHQOYKgCQySvPgxsJSyStGcaAvhXkDQdp5gGkIrvsV0GAmoMEFj/xB
	BpckIqSkGhh9T7NZmvQuLVg7U/29r6vNAsmSn8d4qkS9J2612GyT2iK61XXT2o9ut16mvP91
	9bUz/74jEqVvWRbY65Rc/DH/UeDeLVPs9YrCw1OnWx2cF+CfprFfcdtM/YTJbdnz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296404>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5bfa912..57f1965 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1407,11 +1407,9 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
  * Return the ref_entry for the given refname from the packed
  * references.  If it does not exist, return NULL.
  */
-static struct ref_entry *get_packed_ref(const char *refname)
+static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
+					const char *refname)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "get_packed_ref");
-
 	return find_ref(get_packed_refs(refs), refname);
 }
 
@@ -1422,13 +1420,16 @@ static int resolve_missing_loose_ref(const char *refname,
 				     unsigned char *sha1,
 				     unsigned int *flags)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "resolve_missing_loose_ref");
+
 	struct ref_entry *entry;
 
 	/*
 	 * The loose reference file does not exist; check for a packed
 	 * reference.
 	 */
-	entry = get_packed_ref(refname);
+	entry = get_packed_ref(refs, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.oid.hash);
 		*flags |= REF_ISPACKED;
@@ -1840,6 +1841,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 
 int peel_ref(const char *refname, unsigned char *sha1)
 {
+	struct files_ref_store *refs = get_files_ref_store(NULL, "peel_ref");
 	int flag;
 	unsigned char base[20];
 
@@ -1864,7 +1866,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	 * have REF_KNOWS_PEELED.
 	 */
 	if (flag & REF_ISPACKED) {
-		struct ref_entry *r = get_packed_ref(refname);
+		struct ref_entry *r = get_packed_ref(refs, refname);
 		if (r) {
 			if (peel_entry(r, 0))
 				return -1;
@@ -2473,7 +2475,7 @@ static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 
 	/* Look for a packed ref */
 	for_each_string_list_item(refname, refnames) {
-		if (get_packed_ref(refname->string)) {
+		if (get_packed_ref(refs, refname->string)) {
 			needs_repacking = 1;
 			break;
 		}
-- 
2.8.1
