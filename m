From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/6] Add docstrings for lookup_replace_object() and do_lookup_replace_object()
Date: Fri, 21 Feb 2014 17:32:02 +0100
Message-ID: <1393000327-11402-2-git-send-email-mhagger@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 21 17:32:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGt1x-0001GP-8p
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 17:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbaBUQcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 11:32:42 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:42037 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932264AbaBUQcl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 11:32:41 -0500
X-AuditID: 12074411-f79ab6d000002f0e-b1-53077fa85054
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 89.05.12046.8AF77035; Fri, 21 Feb 2014 11:32:40 -0500 (EST)
Received: from michael.fritz.box (p4FDD425E.dip0.t-ipconnect.de [79.221.66.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1LGWAgt026428
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Feb 2014 11:32:39 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqLuinj3YoHmfsUXXlW4mi4beK8wW
	t1fMZ7aY9+IFm8WPlh5mB1aPv+8/MHk8O9HO5vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGecmb6TpWAFd8WRj7fYGhiXcnYxcnJICJhI/D33nQXCFpO4cG89WxcjF4eQwGVGiSer
	FzFCOMeZJLZ+vc4KUsUmoCuxqKeZCcQWEciR2HL1ICOIzSzgILH5cyOYLSwQJ3F5+VugqRwc
	LAKqEq2rBEFMXgEXiXnrQiB2KUi0LNvFDhLmFHCV6FjuC2IKAVV87qqfwMi7gJFhFaNcYk5p
	rm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIMAnuYJxxUu4QowAHoxIPr0Mqe7AQa2JZ
	cWXuIUZJDiYlUd7vtUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzN0UA53pTEyqrUonyYlDQH
	i5I4L98SdT8hgfTEktTs1NSC1CKYrAwHh5IE78c6oEbBotT01Iq0zJwShDQTByfIcC4pkeLU
	vJTUosTSkox4UEzEFwOjAiTFA7T3M0g7b3FBYi5QFKL1FKOilDhvEkhCACSRUZoHNxaWIl4x
	igN9KczLAUwYQjzA9ALX/QpoMBPQ4JKNrCCDSxIRUlINjLK3FLTj8or3zbINt2ydpKx/j8nu
	lGbwsnaHNYc3qf0vsNJ6+mjmiVert+uIyjNHbp7IMOd7VO/GOMkUjwkKzflz4zl2acluTJXi
	UyqWXXvQf3Fb4erJEzqqcuXXn+5aM01R9duRrufTy7wOaffmn5c9Gxf4webXhOqD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242472>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/cache.h b/cache.h
index dc040fb..0ecd1c8 100644
--- a/cache.h
+++ b/cache.h
@@ -788,13 +788,29 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 {
 	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
 }
+
+/*
+ * If a replacement for object sha1 has been set up, return the
+ * replacement object's name (replaced recursively, if necessary).
+ * The return value is either sha1 or a pointer to a
+ * permanently-allocated value.  This function always respects replace
+ * references, regardless of the value of check_replace_refs.
+ */
 extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
+
+/*
+ * If object sha1 should be replaced, return the replacement object's
+ * name.  This function is similar to do_lookup_replace_object(),
+ * except that it when object replacement is suppressed, it always
+ * returns its argument unchanged.
+ */
 static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
 {
 	if (!read_replace_refs)
 		return sha1;
 	return do_lookup_replace_object(sha1);
 }
+
 static inline const unsigned char *lookup_replace_object_extended(const unsigned char *sha1, unsigned flag)
 {
 	if (!(flag & LOOKUP_REPLACE_OBJECT))
-- 
1.8.5.3
