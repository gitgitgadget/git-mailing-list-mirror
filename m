From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/29] read_raw_ref(): clear *type at start of function
Date: Wed, 27 Apr 2016 18:57:27 +0200
Message-ID: <46e7314c13cfab5cb98f1435f596063826487421.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnS-0003nF-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbcD0Q62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:28 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:63732 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753468AbcD0Q6Z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:25 -0400
X-AuditID: 12074412-51bff700000009f7-e8-5720efabc41d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 84.66.02551.BAFE0275; Wed, 27 Apr 2016 12:58:19 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6N022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:18 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLv6vUK4wf6NxhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owLv/tZCvazVPR++s7SwHiduYuRk0NCwERi14JZ
	QDYXh5DAVkaJ3hM9UM5xJom/m7czgVSxCehKLOppBrNFBBwklq/8xQ5SxCzQxCTxfXkTC0hC
	WMBd4v7WPWA2i4CqxOsHc9hAbF6BKIkZSxYzQqyTk7g8/QFYnFPAQuJL61uwuJCAucSSB6vZ
	JzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokREmRCOxjXn5Q7xCjA
	wajEw1sooRAuxJpYVlyZe4hRkoNJSZR3yVmgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe6W+A
	crwpiZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKEryqwGgSEixKTU+tSMvM
	KUFIM3FwggznkhIpTs1LSS1KLC3JiAdFQXwxMA5AUjxAe0vfgewtLkjMBYpCtJ5i1OVY8OP2
	WiYhlrz8vFQpcd7XIEUCIEUZpXlwK2Ap5RWjONDHwrwXQKp4gOkIbtIroCVMQEsuH5IFWVKS
	iJCSamB07fATvDNd99ypHa7fnXuqa6PmvVk/xb3n9d5d76e+LF77YU6Kys+L3xzKFzY+0JCv
	/sj7S+X75El72WbXWD88X/PhzjHZBf6FD5XjEs9KFdl0ZDz4LbykaevCzSlVImuX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292752>

This is more convenient and less error-prone for callers.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 303c43b..f10c80f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1430,6 +1430,7 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
 	int ret = -1;
 	int save_errno;
 
+	*type = 0;
 	strbuf_reset(&sb_path);
 	strbuf_git_path(&sb_path, "%s", refname);
 	path = sb_path.buf;
-- 
2.8.1
