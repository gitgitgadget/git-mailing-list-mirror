From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 2/8] real_path_internal(): add comment explaining use of cwd
Date: Sun, 28 Oct 2012 17:16:21 +0100
Message-ID: <1351440987-26636-3-git-send-email-mhagger@alum.mit.edu>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:17:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSVXu-0003CZ-DS
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab2J1QQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:16:53 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:56340 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086Ab2J1QQv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:16:51 -0400
X-AuditID: 12074411-b7fa36d0000008cc-cc-508d5a72a2bb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.44.02252.27A5D805; Sun, 28 Oct 2012 12:16:50 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGGXJc002689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:16:49 -0400
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqFsU1Rtg8LtB16LrSjeTRUPvFWaL
	J3PvMlscPWVhcXvFfGaLHy09zBbr311ldmD3+Pv+A5PHzll32T0evupi93jWu4fR4+IlZY/P
	m+QC2KK4bZISS8qCM9Pz9O0SuDPW7epiL5jLWnFgwkHWBsYWli5GTg4JAROJbV/2sEHYYhIX
	7q0Hsrk4hAQuM0rsPXqaEcI5wyQxs30pWBWbgK7Eop5mJhBbREBW4vvhjWBFzAJ3GSUmHZ0K
	VMTBISzgL3FhjgtIDYuAqsTJfa/A6nkFXCSWbnnHBLFNTuLDnkfsIOWcAq4SR/udQcJCQCV/
	Vr1jnMDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSLgJ7mCccVLu
	EKMAB6MSD++lgp4AIdbEsuLK3EOMkhxMSqK8zEG9AUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
	eJdyA+V4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8UyOBGgWLUtNT
	K9Iyc0oQ0kwcnCCCC2QDD9AGc5BC3uKCxNzizHSIolOMilLivMcigBICIImM0jy4AbDE8IpR
	HOgfYd40kHYeYFKB634FNJgJaLAOH9jgkkSElFQDI4vfh7OLvnzmnT3VtvNRoLvQ3luG/PVT
	1L6nVu4905aREpHr/mKVcYi2wKE4uXt8b1zmLmYOvhxoeIG38uKmc9O4GzoPLO49uXufmsTV
	oEUdPK1Or7W95b1P2zDeKdkfr6NxkI3Hw86s4Z3HvoQlTJV56S4RxxIXqfupqhk8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208552>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/abspath.c b/abspath.c
index a7ab8e9..f8a526f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -35,7 +35,14 @@ static const char *real_path_internal(const char *path, int die_on_error)
 {
 	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
 	char *retval = NULL;
+
+	/*
+	 * If we have to temporarily chdir(), store the original CWD
+	 * here so that we can chdir() back to it at the end of the
+	 * function:
+	 */
 	char cwd[1024] = "";
+
 	int buf_index = 1;
 
 	int depth = MAXDEPTH;
-- 
1.8.0
