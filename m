From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/11] strbuf_read_file(): preserve errno on failure
Date: Wed, 15 Oct 2014 17:06:13 +0200
Message-ID: <1413385583-4872-2-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:06:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQAA-0002Oj-DG
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbaJOPGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2014 11:06:48 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47497 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645AbaJOPGr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:47 -0400
X-AuditID: 1207440e-f79996d000007413-b8-543e8d78804f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id CB.5F.29715.87D8E345; Wed, 15 Oct 2014 11:06:32 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNT020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:31 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqFvRaxdi0HzdwqLrSjeTRUPvFWaL
	2yvmM1t0T3nLaPFvQo3FmTeNjA5sHn/ff2Dy2DnrLrvHgk2lHhcvKXssfuDl8XmTXABbFLdN
	UmJJWXBmep6+XQJ3xs/ui2wFr9kqtp55wdjAuIy1i5GTQ0LAROLCxUYoW0ziwr31bF2MXBxC
	ApcZJQ7MW8gO4RxnkrhyawMbSBWbgK7Eop5mJpCEiEADo8ShVwvBWpgFFjFKtK+6wgxSJSzg
	LrFo/VEwm0VAVeJO01cWEJtXwFli+qelLBD75CT2Tl4NZnMKuEj8ermNEcQWAqpZsHQyVL2g
	xMmZT4BsDqAF6hLr5wmBhJkF5CWat85mnsAoMAtJ1SyEqllIqhYwMq9ilEvMKc3VzU3MzClO
	TdYtTk7My0st0jXWy80s0UtNKd3ECAl5vh2M7etlDjEKcDAq8fBu2GsbIsSaWFZcmXuIUZKD
	SUmUd0GPXYgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd75CUA53pTEyqrUonyYlDQHi5I4r9oS
	dT8hgfTEktTs1NSC1CKYrAwHh5IE7z6QoYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUl
	GfGgWI0vBkYrSIoHaC9YO29xQWIuUBSi9RSjLkdL09teJiGWvPy8VClx3iyQIgGQoozSPLgV
	sAT3ilEc6GNh3h6QKh5gcoSb9ApoCRPQkomhtiBLShIRUlINjFGvQ7U6uPzPb3rJH/iX+/Lt
	9Am/c49HvXjjJLXYeaqGyf/Ghk+aWw0c7gnulb8/kU8y8qiDyI9ryaw7ecuupGj4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This will allow the function to be used in a later patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 strbuf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 0346e74..f1fec58 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -482,15 +482,18 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int=
 fd, int term)
=20
 int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
-	int fd, len;
+	int fd, len, saved_errno;
=20
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0)
 		return -1;
 	len =3D strbuf_read(sb, fd, hint);
+	saved_errno =3D errno;
 	close(fd);
-	if (len < 0)
+	if (len < 0) {
+		errno =3D saved_errno;
 		return -1;
+	}
=20
 	return len;
 }
--=20
2.1.1
