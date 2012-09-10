From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/6] Add some string_list-related functions
Date: Mon, 10 Sep 2012 23:18:40 +0200
Message-ID: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:19:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBNy-0000YP-6e
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab2IJVTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:19:05 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:44290 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862Ab2IJVTE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 17:19:04 -0400
X-AuditID: 1207440c-b7f616d00000270b-b2-504e5947bd0c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 8F.28.09995.7495E405; Mon, 10 Sep 2012 17:19:03 -0400 (EDT)
Received: from michael.fritz.box (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8ALIwqL020122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 17:19:01 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsUixO6iqOse6Rdg0Pif36LrSjeTRUPvFWaL
	2yvmM1v8aOlhdmDx+Pv+A5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cd8fveR+aC
	XoGKJcfDGhh/c3cxcnJICJhI/Jw1mwnCFpO4cG89WxcjF4eQwGVGiV9b1zBDOGeYJDauvM8G
	UsUmoCuxqKcZrENEQE1iYtshFhCbWSBFouN5NyOILSxgJ9G4aDFYDYuAqsT8K5/BangFnCWu
	zetjgdimKPHj+xrmCYzcCxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKE
	hAPPDsZv62QOMQpwMCrx8Gry+AUIsSaWFVfmHmKU5GBSEuU1DAEK8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuGN1wTK8aYkVlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeEsi
	gBoFi1LTUyvSMnNKENJMHJwgggtkAw/QhhUghbzFBYm5xZnpEEWnGBWlxHkNQBICIImM0jy4
	AbDIfcUoDvSPMG8XSBUPMOrhul8BDWYCGuzr4QMyuCQRISXVwKituvaEhL3jhsiDRz2L3h6w
	PfH+T0TV3RQj5i/q2dl2LVwL/y5buVpsufqXSOWA+rPKH//XMIW45yXoXA7xeM90dlVo1STm
	30VRNk0XmffaL9m58wpn9eJbgtx/yl+YXi0uEuFja2+8lVvoYFCftJPxVOORt2cDl3FWPJAu
	M+j44cDoUbJ2lRJLcUaioRZzUXEiACwzk8e3AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205184>

Version 2 of a patch series that adds some functions to the
string_list API.  This patch series applies to current master.  Thanks
for Junio for lots of great feedback.

The patch series "Clean up how fetch_pack() handles the heads list"
v3, which requires some of the new string_list functionality, works
unmodified on top of this version of the patch series.

Changes since v1:

* Expose a new function, string_list_append_nodup().  This is used in
  the implementation of string_list_split() and should be generally
  useful.

* Straighten out the API for splitting strings (with help from Junio):

  * Implement two separate functions, one for splitting strings in
    place and a second for making copies while splitting a const
    string.

  * Redefine maxsplit=0 to mean "copy input string to output list as a
    single entry" for better consistency.

* Add tests for more of the new functionality and simplify some of the
  other tests.

* Various comment and documentation improvements.

Michael Haggerty (6):
  string_list: add function string_list_append_nodup()
  string_list: add two new functions for splitting strings
  string_list: add a new function, filter_string_list()
  string_list: add a new function, string_list_remove_duplicates()
  string_list: add a function string_list_longest_prefix()
  api-string-list.txt: initialize the string_list the easy way

 .gitignore                                  |   1 +
 Documentation/technical/api-string-list.txt |  67 +++++++++++++--
 Makefile                                    |   1 +
 string-list.c                               | 123 ++++++++++++++++++++++++++--
 string-list.h                               |  71 ++++++++++++++++
 t/t0063-string-list.sh                      | 121 +++++++++++++++++++++++++++
 test-string-list.c                          | 123 ++++++++++++++++++++++++++++
 7 files changed, 497 insertions(+), 10 deletions(-)
 create mode 100755 t/t0063-string-list.sh
 create mode 100644 test-string-list.c

-- 
1.7.11.3
