From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/7] write_ref_sha1(): remove check for lock == NULL
Date: Mon,  2 Mar 2015 10:29:51 +0100
Message-ID: <1425288597-20547-2-git-send-email-mhagger@alum.mit.edu>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:30:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMgR-0007Nu-GV
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbbCBJaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:30:25 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62457 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744AbbCBJaT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 04:30:19 -0500
X-AuditID: 12074414-f797f6d000004084-2b-54f42da4c010
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B3.BD.16516.4AD24F45; Mon,  2 Mar 2015 04:30:12 -0500 (EST)
Received: from michael.fritz.box (p5DDB2321.dip0.t-ipconnect.de [93.219.35.33])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t229U5HU008921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 2 Mar 2015 04:30:09 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1F2i+yXEoP8qt0XXlW4mi4beK8wW
	b28uYbS4vWI+s0X3lLeMFj9aepgtevs+sVps3tzOYnHmTSOjA6fH3/cfmDx2zrrL7rFgU6nH
	s949jB4XLyl7LH7g5fF5k1wAexS3TVJiSVlwZnqevl0Cd8amqd2sBXNZKx4dPMXUwNjP0sXI
	ySEhYCIx+dAeNghbTOLCvfVANheHkMBlRol5kz8wQzjHmCSWbL/DClLFJqArsainmQnEFhFQ
	k5jYdghsErPADyaJQytqQWxhAXeJtvNHweIsAqoSPVsPgm3gFXCRWHRnGiPENjmJ88d/MoPY
	nAKuEj9/NbKD2EJANbOur2aewMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuhV5uZole
	akrpJkZIMIrsYDxyUu4QowAHoxIP74J5n0OEWBPLiitzDzFKcjApifLOUf8SIsSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmE97U8UI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxW
	hoNDSYI3WAeoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UG/HFwOgASfEA7U0F
	aectLkjMBYpCtJ5i1OVY0L5/JpMQS15+XqqUOK8TSJEASFFGaR7cCljqecUoDvSxMG8FSBUP
	MG3BTXoFtIQJaMktRbAlJYkIKakGxjyFef2r4xiYvvF2RgY/2dnKNpOjXkaAj3u1UJnoqmci
	lx54Sch8XLX4wKuLfdlei3bteXJUWf7ijmrhKwuteGUmpGl2+qQtFbX33a59dOWc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264581>

None of the callers pass NULL to this function, and there doesn't seem
to be any usefulness to allowing them to do so.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/refs.c b/refs.c
index ab2f2a9..e82d503 100644
--- a/refs.c
+++ b/refs.c
@@ -3079,10 +3079,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 	static char term = '\n';
 	struct object *o;
 
-	if (!lock) {
-		errno = EINVAL;
-		return -1;
-	}
 	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
 		unlock_ref(lock);
 		return 0;
-- 
2.1.4
