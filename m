From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/6] Document some functions defined in object.c
Date: Fri, 21 Feb 2014 17:32:07 +0100
Message-ID: <1393000327-11402-7-git-send-email-mhagger@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 21 17:40:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGt9F-0001L3-CJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 17:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbaBUQkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 11:40:19 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55436 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932286AbaBUQkR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 11:40:17 -0500
X-AuditID: 12074414-f79d96d000002d2b-7c-53077fb0c94f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 13.3B.11563.0BF77035; Fri, 21 Feb 2014 11:32:48 -0500 (EST)
Received: from michael.fritz.box (p4FDD425E.dip0.t-ipconnect.de [79.221.66.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1LGWAh0026428
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Feb 2014 11:32:47 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqLuhnj3YYFaHgUXXlW4mi4beK8wW
	t1fMZ7aY9+IFm8WPlh5mB1aPv+8/MHk8O9HO5vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGe8nL+GteCeUMXLyS+ZGxiv83UxcnJICJhI9DVNZ4OwxSQu3FsPZHNxCAlcZpQ4NOEy
	WEJI4DiTxNdFeSA2m4CuxKKeZiYQW0QgR2LL1YOMIDazgIPE5s+NYLYwkN1/fSdYDYuAqsSE
	dSuZQWxeAReJLzc3MEIsU5BoWbaLvYuRg4NTwFWiY7kviCkEVPK5q34CI+8CRoZVjHKJOaW5
	urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCHhJLKD8chJuUOMAhyMSjy8DqnswUKsiWXF
	lbmHGCU5mJREeb/XAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8DZHA+V4UxIrq1KL8mFS0hws
	SuK83xar+wkJpCeWpGanphakFsFkZTg4lCR4P9YBNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfm
	paQWJZaWZMSDoiK+GBgXICkeoL0G9SB7iwsSc4GiEK2nGBWlxHmTQOYKgCQySvPgxsKSxCtG
	caAvhXk5QNp5gAkGrvsV0GAmoMElG1lBBpckIqSkGhiz9xt53VaTk5kbkpN1jaegLlt0Qt9u
	Lt6CuqkB1tfrubxPFCw7HZbU+mhbwzkeg6WK9S09E6PmCmscvT3xZ6TYHsOnax38Nt5Nmz7p
	N093waPNafkdda1hjy/4fmVZk2Tv2cE/YXbe0eqDVpkH7xW8+DqjXva5qcwypsBF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242475>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 object.c | 23 ++++++++++++++++++++++-
 object.h |  7 +++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/object.c b/object.c
index 584f7ac..c34e225 100644
--- a/object.c
+++ b/object.c
@@ -43,14 +43,26 @@ int type_from_string(const char *str)
 	die("invalid object type \"%s\"", str);
 }
 
+/*
+ * Return a numerical hash value between 0 and n-1 for the object with
+ * the specified sha1.  n must be a power of 2.
+ *
+ * Since the sha1 is essentially random, we just take the required
+ * bits from the first sizeof(unsigned int) bytes of sha1.
+ */
 static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
 {
 	unsigned int hash;
+
 	memcpy(&hash, sha1, sizeof(unsigned int));
-	/* Assumes power-of-2 hash sizes in grow_object_hash */
 	return hash & (n - 1);
 }
 
+/*
+ * Insert obj into the hash table hash, which has length size (which
+ * must be a power of 2).  On collisions, simply overflow to the next
+ * empty bucket.
+ */
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
 	unsigned int j = hash_obj(obj->sha1, size);
@@ -63,6 +75,10 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
 	hash[j] = obj;
 }
 
+/*
+ * Look up the record for the given sha1 in the hash map stored in
+ * obj_hash.  Return NULL if it was not found.
+ */
 struct object *lookup_object(const unsigned char *sha1)
 {
 	unsigned int i, first;
@@ -92,6 +108,11 @@ struct object *lookup_object(const unsigned char *sha1)
 	return obj;
 }
 
+/*
+ * Increase the size of the hash map stored in obj_hash to the next
+ * power of 2 (but at least 32).  Copy the existing values to the new
+ * hash map.
+ */
 static void grow_object_hash(void)
 {
 	int i;
diff --git a/object.h b/object.h
index dc5df8c..732bf4d 100644
--- a/object.h
+++ b/object.h
@@ -42,7 +42,14 @@ struct object {
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
 
+/*
+ * Return the current number of buckets in the object hashmap.
+ */
 extern unsigned int get_max_object_index(void);
+
+/*
+ * Return the object from the specified bucket in the object hashmap.
+ */
 extern struct object *get_indexed_object(unsigned int);
 
 /*
-- 
1.8.5.3
