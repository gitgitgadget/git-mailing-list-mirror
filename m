From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/13] delete_refs(): add a flags argument
Date: Fri,  3 Jun 2016 14:33:44 +0200
Message-ID: <03e08d91d289ef24ea53344ce005eda0bb4a7a14.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oIu-0005Ac-Ep
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbcFCMeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:14 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43782 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932263AbcFCMeL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:11 -0400
X-AuditID: 1207440d-bc7ff7000000090b-7a-5751793fc4e4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 90.B1.02315.F3971575; Fri,  3 Jun 2016 08:34:07 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtio005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:05 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqGtfGRhu0H5Q2WL+phOMFl1Xupks
	GnqvMFvcXjGf2aJ7yltGix8tPcwWM69aW5x508jowOHx9/0HJo+ds+6yezzr3cPocfGSssf+
	pdvYPBY/8PJY8Pw+u8fnTXIBHFHcNkmJJWXBmel5+nYJ3Bnn5zSxFWwTqzi//hBTA+McoS5G
	Tg4JAROJLf3rWboYuTiEBLYySrzZDeMcZ5I4dOwVO0gVm4CuxKKeZiYQW0QgQqLhVQsjSBGz
	wBwmidsPO5lBEsICthL7r04Ba2ARUJU4tBbC5hWIkvh7cwYjxDo5icvTH7CB2JwCFhJ9936A
	1QgJmEs8nLObfQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIWHH
	u4Px/zqZQ4wCHIxKPLwMiwPChVgTy4orcw8xSnIwKYnynj8LFOJLyk+pzEgszogvKs1JLT7E
	KMHBrCTC+6cgMFyINyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBa14B
	1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioL4YmAcgKR4gPZWgLTzFhck5gJF
	IVpPMSpKifMKgyQEQBIZpXlwY2HJ5BWjONCXwrw+IFU8wEQE1/0KaDAT0OCCR/4gg0sSEVJS
	DYwKvkkzjkb8Or9JLF6y7m9nT3LugQZmkxVvucxOZE+/YLrBzPq6inrSliez0njflK4we+j6
	al/Rjk+8uhflxTs1Jefqm2W6aHnyp3+wl3Bz592XKeeSkLy++QrDjT1mP20PvHyT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296320>

This will be useful for passing REF_NODEREF through.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c      | 2 +-
 builtin/remote.c     | 4 ++--
 refs.h               | 5 +++--
 refs/files-backend.c | 4 ++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f8455bd..b55c83c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -806,7 +806,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 		for (ref = stale_refs; ref; ref = ref->next)
 			string_list_append(&refnames, ref->name);
 
-		result = delete_refs(&refnames);
+		result = delete_refs(&refnames, 0);
 		string_list_clear(&refnames, 0);
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index fda5c2e..1bbf9b4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -788,7 +788,7 @@ static int rm(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (!result)
-		result = delete_refs(&branches);
+		result = delete_refs(&branches, 0);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
@@ -1303,7 +1303,7 @@ static int prune_remote(const char *remote, int dry_run)
 	string_list_sort(&refs_to_prune);
 
 	if (!dry_run)
-		result |= delete_refs(&refs_to_prune);
+		result |= delete_refs(&refs_to_prune, 0);
 
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname = item->util;
diff --git a/refs.h b/refs.h
index 21874f0..6d515a4 100644
--- a/refs.h
+++ b/refs.h
@@ -274,9 +274,10 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 /*
  * Delete the specified references. If there are any problems, emit
  * errors but attempt to keep going (i.e., the deletes are not done in
- * an all-or-nothing transaction).
+ * an all-or-nothing transaction). flags is passed through to
+ * ref_transaction_delete().
  */
-int delete_refs(struct string_list *refnames);
+int delete_refs(struct string_list *refnames, unsigned int flags);
 
 /** Delete a reflog */
 int delete_reflog(const char *refname);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5af7441..a0d09f4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2403,7 +2403,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames)
+int delete_refs(struct string_list *refnames, unsigned int flags)
 {
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
@@ -2432,7 +2432,7 @@ int delete_refs(struct string_list *refnames)
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
-		if (delete_ref(refname, NULL, 0))
+		if (delete_ref(refname, NULL, flags))
 			result |= error(_("could not remove reference %s"), refname);
 	}
 
-- 
2.8.1
