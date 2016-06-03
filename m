From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 38/38] refs: implement iteration over only per-worktree refs
Date: Fri,  3 Jun 2016 23:04:13 +0200
Message-ID: <adf0c96e684d56943f6b4a62a91de549facad0e7.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJP-0002Q1-Ne
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbcFCVHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:07:19 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60927 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932945AbcFCVFk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:40 -0400
X-AuditID: 12074411-e2bff70000000955-13-5751f11ede44
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 5E.79.02389.E11F1575; Fri,  3 Jun 2016 17:05:34 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kd4003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:32 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqCv3MTDcYOliZYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGf0XuhmLOgUqPh9S62BcQVvFyMn
	h4SAicTKVZ2MXYxcHEICWxkl3v6azgqSEBI4ziTR8qYUxGYT0JVY1NPMBGKLCERINLxqAWtg
	FpjDJHH7YSczSEJYwEdib+9XsCIWAVWJ76962EFsXoEoiZdrZ7BCbJOTuDz9ARuIzSlgIdHy
	eRXUMnOJxlOHWSYw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERJy
	gjsYZ5yUO8QowMGoxMN74kVguBBrYllxZe4hRkkOJiVR3r13gEJ8SfkplRmJxRnxRaU5qcWH
	GCU4mJVEeFNeA+V4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8i94D
	NQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIiC+GBgDICkeoL0xIO28xQWJuUBR
	iNZTjIpS4ryhIAkBkERGaR7cWFgiecUoDvSlMO8ckCoeYBKC634FNJgJaHDBI3+QwSWJCCmp
	BkZz//+hgZIl3KccDrsudnmZetp51TXhmzs+GX5YI+JsIF3+JEN74epa810dR7gVPrimTV5q
	FRegubF+a92jBJ62bS0tofW3lsd7yvYJcxq3Jl2xFvsSW/Ng9fUIaWvdgy9+Xnhp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296411>

From: David Turner <dturner@twopensource.com>

Alternate refs backends might still use files to store per-worktree
refs. So provide a way to iterate over only the per-worktree references
in a ref_store. The other backend can set up a files ref_store and
iterate using the new DO_FOR_EACH_PER_WORKTREE_ONLY flag when iterating.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c |  4 ++++
 refs/refs-internal.h | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 53d0ba1..b5ad21c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1802,6 +1802,10 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	int ok;
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
+		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
+			continue;
+
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
 		    !ref_resolves_to_object(iter->iter0->refname,
 					    iter->iter0->oid,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index db891e6..6d97ed9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -462,10 +462,18 @@ extern struct ref_iterator *current_ref_iter;
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);
 
-/* refs backends */
+/*
+ * Only include per-worktree refs in a do_for_each_ref*() iteration.
+ * Normally this will be used with a files ref_store, since that's
+ * where all reference backends will presumably store their
+ * per-worktree refs.
+ */
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
 
 struct ref_store;
 
+/* refs backends */
+
 /*
  * Initialize the ref_store for the specified submodule, or for the
  * main repository if submodule == NULL. These functions should call
-- 
2.8.1
