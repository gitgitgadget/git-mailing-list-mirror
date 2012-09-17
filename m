From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] fetch-pack.h: remove unnecessary #include
Date: Mon, 17 Sep 2012 17:15:10 +0200
Message-ID: <1347894910-27624-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:15:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDd30-0002Wy-Kj
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 17:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab2IQPPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 11:15:31 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:49221 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751837Ab2IQPPa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 11:15:30 -0400
X-AuditID: 12074413-b7f786d0000008bb-49-50573e91269a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 64.44.02235.19E37505; Mon, 17 Sep 2012 11:15:29 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8HFFOSf021601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Sep 2012 11:15:28 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqDvRLjzAYPNMa4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M44+/wec8FK9orOFSsYGxi/
	sXYxcnJICJhI/H39jA3CFpO4cG89kM3FISRwmVFiye/vrBDOGSaJc++us4NUsQnoSizqaWYC
	sUUE1CQmth1iAbGZBRwkNn9uZASxhQWsJFY1fgezWQRUJdY8mQpm8wq4SCx495wFYpuixI/v
	a5gnMHIvYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRHifeEdjLtOyh1i
	FOBgVOLhNZ4UFiDEmlhWXJl7iFGSg0lJlHeLdXiAEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
	2wJAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO8CW6BGwaLU9NSK
	tMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCoxxcDgx0kxQO0dz9IO29xQWIuUBSi9RSjLse+
	dyvuMwqx5OXnpUqJ85aCFAmAFGWU5sGtgMX6K0ZxoI+FedtAqniAaQJu0iugJUxASyqehIEs
	KUlESEk1MKo+/5jdetH7PtfnGY0L7e7cdX+zNGfDNFm3ugzjIp89aTIf4z8aN07Rf+jAt74/
	JvLAev9SKZnLLsmF8vf+l73Km7n7eFd4a23kZEdd0cBXR9815HSckZ1bJaHZvaUzo6ztakp4
	krJrssXbOXtnLtLTE/L5naDMpPXP25HjY2ONSuOBm2nCSizFGYmGWsxFxYkA3pJo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205697>

Given the git project policy that *.c files that include header files
are responsible for including everything the headers they include
need, there is no need for fetch-pack.h to include string-list.h
itself.  As for the files that include fetch-pack.h:

* builtin/clone.c and builtin/fetch-pack.c
  include builtin.h
  which includes notes.h
  which includes string-list.h

* transport.c
  includes string-list.h

so no other adjustments are needed.

Suggested by: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 fetch-pack.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fetch-pack.h b/fetch-pack.h
index cb14871..018f35f 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -1,8 +1,6 @@
 #ifndef FETCH_PACK_H
 #define FETCH_PACK_H
 
-#include "string-list.h"
-
 struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
-- 
1.7.11.3
