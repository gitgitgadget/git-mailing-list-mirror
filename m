From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] string_list API: document what "sorted" means.
Date: Mon, 17 Sep 2012 17:21:07 +0200
Message-ID: <1347895267-5054-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:21:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDd8i-0005vQ-2P
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 17:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab2IQPV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 11:21:27 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:59528 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755163Ab2IQPV0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 11:21:26 -0400
X-AuditID: 1207440d-b7f236d000000943-2d-50573ff6082e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.F6.02371.6FF37505; Mon, 17 Sep 2012 11:21:26 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8HFLGHG021884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Sep 2012 11:21:25 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsUixO6iqPvNPjzAYEUjj0XXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGcsnPCSvWAZb8XrC2/YGhjb
	uLsYOTkkBEwkfryYwAZhi0lcuLceyObiEBK4zCixYPZRVgjnDJPEza57LCBVbAK6Eot6mplA
	bBEBNYmJbYfA4swCDhKbPzcygtjCAvYSDV8+MIPYLAKqErdO72PvYuTg4BVwluh9owOxTFHi
	x/c1zBMYuRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3ECPE97w7G/+tk
	DjEKcDAq8fAaTwoLEGJNLCuuzD3EKMnBpCTKe8s2PECILyk/pTIjsTgjvqg0J7X4EKMEB7OS
	CO9tAaAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCVwAY4kKCRanp
	qRVpmTklCGkmDk4QwQWygQdow1o7kA3FBYm5xZnpEEWnGBWlxHmVQSYIgCQySvPgBsCi9BWj
	ONA/wrw6IFU8wAiH634FNJgJaHDFkzCQwSWJCCmpBsZZp6c9uh4tb2rYtXVNzIIYFf0vTvOF
	9s++03VK4/liaSHjS7XrDmu01Tlnsaq8WPB8lcZzyaYDQvLhr9+kz326wIznmMnjRdwtwVOk
	U25+vu+zfw1bq9WOu/Vf77xev6itcrviZ0nz91vVDmx3UjS98CqR+21a7ori61fM3udOnyP8
	ZIJ53mUDJZbijERDLeai4kQAbllPWa0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205698>

Junio pointed out that the sort order currently used by string_list
could be considered to be an implementation detail internal to
string_list.  But the sort order is already visible to the outside
world (e.g., via iteration or via print_string_list()), so it
shouldn't be changed willy-nilly.  Therefore, document the current
sort order as part of the API's contract.

(If, at some future time, somebody wants a string_list that is sorted
by a different criterion, then the order should be made specifiable
via a callback function specified by the user.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 155ac8c..94d7a2b 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -1,8 +1,9 @@
 string-list API
 ===============
 
-The string_list API offers a data structure and functions to handle sorted
-and unsorted string lists.
+The string_list API offers a data structure and functions to handle
+sorted and unsorted string lists.  A "sorted" list is one whose
+entries are sorted by string value in `strcmp()` order.
 
 The 'string_list' struct used to be called 'path_list', but was renamed
 because it is not specific to paths.
@@ -143,7 +144,7 @@ write `string_list_insert(...)->util = ...;`.
 
 `sort_string_list`::
 
-	Make an unsorted list sorted.
+	Sort the list's entries by string value in `strcmp()` order.
 
 `unsorted_string_list_has_string`::
 
-- 
1.7.11.3
