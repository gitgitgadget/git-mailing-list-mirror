From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 03/16] bisect: make bisect compile if DEBUG_BISECT is set
Date: Fri, 26 Feb 2016 03:04:29 +0100
Message-ID: <1456452282-10325-4-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:05:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7n1-0007NX-Dv
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbcBZCFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:05:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:64222 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbcBZCFo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:44 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MOfcU-1abrKy1Gek-00643e; Fri, 26 Feb 2016 03:05:42
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:6PFnR+R015dp35IRmFBIuEl0aDFawvApi3ODhVDFX6zh4iGAzE2
 CVnmeW1b/iP2RI3gyWjukLbRATu0OpI6CoOKcoBwPbY0SmHKBdDwUIRpEhvUlfRBoPKytPN
 MNrG8tzdURnmESrgSUEuvgdibTxuEmIwE8l5U1aTSK/evHQDNfUo7m/IG2uvs86d60h5TAM
 FNj/MHeL1WI7jKYlQ4p5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tVFAa+jI8Zg=:7ymUhM97Npy6glzMz6vM4E
 j+kFZY1Cu2sppAd1x39dDQK/9nkm1lLNb7PEG2YRGKdAVoG8Lpj5cHw/8V51M9WtroK79g4Ks
 5iIEvbU+vWpCDBS2/8njDKIkLfcdU8oqNA8hwyAVnPi66T9momaOI50cZZFgwnhIpNndR75ur
 6VP39F3f5gIUpVTUQXYvnc/JSIPfkNsYg6ftSJ8fRq0UyYXn8vb0vZ/kbiUtWYCiE4+cAd2W0
 pFIanct+2KAt16rqhtazhQGVFLoV/eDHOPx7YnA5oV8a3fY2Zvmc5b1Ab/7F+I3seshB72DN+
 xQdy8sPY2hwqTUyQeTTL1ZoOp1BJ4qBvRkgXOnjg2TjY67THnf9t3fbFq2z5cXi3jcW2I8UKO
 WUcxZa/Jf0aEev1ghJL6+dfI8BV5CdZ6vfwTFUPH6Oyjun6tZgzMactgA8T5Hpp8AuRVkD7BQ
 lHRZ+tOnObYHeAoVSjd5Cm6qEE3eWFmi8WdjEkDbuvdr+XLb3UDwhsLhWmElF7Yghoxb6Ng89
 dc7YDJ7eCxzFjn8r8NHHfGb1OAHDlknxL9818WyrcEnkigfx7Hp+lz68zjzpCWy2vLixa4yUF
 BfckP9B/BY3xPGYemI6AcgJAIIVCD20TAnCozC2imIlvbsNBaPi39dADzK6p41uoljUZq7DH+
 QDVz+BlegcEvdQO/v5hZT06swujrfkUAgfi1pWSyTBdnnkUESbheYUb6ce+6iLo7Lofl8Y6je
 crZHkkEHbhsS4JjffdsR3HpYIUC4JfWKQnYRV9QWf0/KrPCUKlV3iQEtW/Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287514>

Setting the macro DEBUG_BISECT to 1 enables debugging information
for the bisect algorithm. The code did not compile due to struct
changes.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 06ec54e..905e63a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -131,7 +131,7 @@ static void show_list(const char *debug, int counted, int nr,
 		unsigned flags = commit->object.flags;
 		enum object_type type;
 		unsigned long size;
-		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
+		char *buf = read_sha1_file(commit->object.oid.hash, &type, &size);
 		const char *subject_start;
 		int subject_len;
 
@@ -143,10 +143,10 @@ static void show_list(const char *debug, int counted, int nr,
 			fprintf(stderr, "%3d", weight(p));
 		else
 			fprintf(stderr, "---");
-		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
+		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.oid.hash));
 		for (pp = commit->parents; pp; pp = pp->next)
 			fprintf(stderr, " %.*s", 8,
-				sha1_to_hex(pp->item->object.sha1));
+				sha1_to_hex(pp->item->object.oid.hash));
 
 		subject_len = find_commit_subject(buf, &subject_start);
 		if (subject_len)
-- 
2.7.1.354.gd492730.dirty
