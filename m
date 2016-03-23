From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/21] get_default_remote(): remove unneeded flag variable
Date: Wed, 23 Mar 2016 11:04:35 +0100
Message-ID: <984403a927046ddd3fec02f32500ee5c73750396.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:14:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmg-0001Ah-7u
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbcCWKMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:47 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54349 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754481AbcCWKMi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:38 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Mar 2016 06:12:38 EDT
X-AuditID: 12074413-f03ff7000000516b-1d-56f26a5b4072
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 73.AE.20843.B5A62F65; Wed, 23 Mar 2016 06:05:15 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1N018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:14 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqBud9SnM4EOvrEXXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zxcyr1g5sHn/ff2Dy2DnrLrvHs949jB4XLyl77F+6jc3j8ya5ALYo
	bpukxJKy4Mz0PH27BO6M/QffMBb8Yq14eHspcwPjZ5YuRg4OCQETibU3PLoYuTiEBLYySsx8
	0cME4Zxkktgz4TR7FyMnB5uArsSinmYmEFtEQE1iYtshFpAiZoEFjBIbFy9mBkkIC3hJnFlz
	igXEZhFQlehYe48RxOYViJI48vMGK4gtIaAkseHBBbBBnAIWEidPLgWrERIwl9j+YC3TBEae
	BYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfVyM0v0UlNKNzFCwkl4B+Ouk3KHGAU4GJV4
	eAvPfQwTYk0sK67MPcQoycGkJMp7PuhTmBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXs5MoBxv
	SmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJ3WwZQo2BRanpqRVpmTglC
	momDE2Q4l5RIcWpeSmpRYmlJRjwoBuKLgVEAkuIB2ssLtre4IDEXKArReopRl2PBj9trmYRY
	8vLzUqXEeTVAdgiAFGWU5sGtgCWPV4ziQB8LQ7zAA0w8cJNeAS1hAlqy0AdsSUkiQkqqgbFl
	46uTnq6f3+etafSMz81PsnsinbZDfPeUA4s5lHc9q82K+PLm01TX80t66yYKVb5XCt+/y0hD
	aGXf22XmYWcT4k0bk5Q+bFlob31/JseiC/+O5ez/9iVirtqGDukb9qZJrK+/JvAX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289617>

It is never read, so we can pass NULL to resolve_ref_unsafe().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/submodule--helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ed4f60b..c72365e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -17,9 +17,8 @@ static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
 	unsigned char sha1[20];
-	int flag = 0;
 	struct strbuf sb = STRBUF_INIT;
-	const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
+	const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
 
 	if (!refname)
 		die("No such ref: HEAD");
-- 
2.8.0.rc3
