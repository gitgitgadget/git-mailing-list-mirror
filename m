From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/38] refs: add a backend method structure
Date: Fri,  3 Jun 2016 23:03:39 +0200
Message-ID: <151f90bea3b22cc1f0818b08c1505aad2db891d4.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:07:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wJ7-00025e-A1
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbcFCVG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:59 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58635 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752780AbcFCVEc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:32 -0400
X-AuditID: 1207440e-f07ff700000008c5-3a-5751f0df6a67
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 60.68.02245.FD0F1575; Fri,  3 Jun 2016 17:04:31 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcU003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:29 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqHv/Q2C4wbvnuhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLfhBqLM28aGR04Pf6+/8DksXPWXXaPBZtKPZ71
	7mH0uHhJ2WP/0m1sHosfeHkseH6f3ePzJrkAzihum6TEkrLgzPQ8fbsE7oyHjatZC7aIVvy8
	9JetgXGXYBcjJ4eEgInEnm83GbsYuTiEBLYySmw80scM4Rxnkvj+pYcdpIpNQFdiUU8zE4gt
	IhAh0fCqBayDWeAMk8T02e1gRcIC1hJdW/rAbBYBVYnuadeZQWxegSiJPU+WMEKsk5O4PP0B
	G4jNKWAh0fJ5FSuILSRgLtF46jDLBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVy
	M0v0UlNKNzFCwpBvB2P7eplDjAIcjEo8vAXPAsOFWBPLiitzDzFKcjApifLuvQMU4kvKT6nM
	SCzOiC8qzUktPsQowcGsJMKb8hoox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoE
	k5Xh4FCS4F30HqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQF8cXAOABJ8QDt
	5f4Asre4IDEXKArReopRUUqcNxRkrgBIIqM0D24sLLm8YhQH+lKYNxmkigeYmOC6XwENZgIa
	XPDIH2RwSSJCSqqB0WGvL+O5edq93tMOMpueb0n+zXs7efpunsyP/x07CtRUrsafeHO2XExJ
	+0CCwkTGa2tfsuWbHK43rltwI//VZEM1v7OnnwVP8l9Qals817Sn03/jtqXKdnZT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296402>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a `struct ref_storage_be` to represent types of reference stores. In
OO notation, this is the class, and will soon hold some class
methods (e.g., a factory to create new ref_store instances) and will
also serve as the vtable for ref_store instances of that type.

As yet, the backends cannot do anything.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 19 +++++++++++++++++++
 refs.h               |  2 ++
 refs/files-backend.c |  5 +++++
 refs/refs-internal.h |  8 ++++++++
 4 files changed, 34 insertions(+)

diff --git a/refs.c b/refs.c
index 814cad3..f57a93e 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,25 @@
 #include "tag.h"
 
 /*
+ * List of all available backends
+ */
+static struct ref_storage_be *refs_backends = &refs_be_files;
+
+static struct ref_storage_be *find_ref_storage_backend(const char *name)
+{
+	struct ref_storage_be *be;
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name))
+			return be;
+	return NULL;
+}
+
+int ref_storage_backend_exists(const char *name)
+{
+	return find_ref_storage_backend(name) != NULL;
+}
+
+/*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
  * 1: End-of-component
diff --git a/refs.h b/refs.h
index 442c1a5..52ea93b 100644
--- a/refs.h
+++ b/refs.h
@@ -544,4 +544,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data);
 
+int ref_storage_backend_exists(const char *name);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b94aad2..bde6f0e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4066,3 +4066,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	unlock_ref(lock);
 	return -1;
 }
+
+struct ref_storage_be refs_be_files = {
+	NULL,
+	"files"
+};
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d8a2606..4d88849 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -520,4 +520,12 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 int read_raw_ref(const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type);
 
+/* refs backends */
+struct ref_storage_be {
+	struct ref_storage_be *next;
+	const char *name;
+};
+
+extern struct ref_storage_be refs_be_files;
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.8.1
