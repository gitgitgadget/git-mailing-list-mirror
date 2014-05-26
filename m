From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 06/15] diff.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:47 +0900
Message-ID: <1401118436-66090-7-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WowvU-0004kf-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbaEZPez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:34:55 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43532 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbaEZPey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:54 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so7745469pad.18
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ASdtijVvAsuUWYaqIUqO3QgX2yTBMzOboeB7kyRzo6U=;
        b=w1x4kom61e9xa+WTU+U+u+8d3G7IOtUJHqqLtfzOOjrjShF6e/oi4Ud8WnLBM4KiVa
         cupsyYtWTNjOEj5vBw7GcbERkF+3MBFlS701bVRdPEVdAMKYqcj0daIbPi/2CCBlXHek
         Z9aY6gIICYcQ8vXJh6EaFNmfQG/LIt2rRo1xWjWhzhAyotAejQEP0qX6NQ4+qz4vFpg0
         J+m2B4FD4AycDV3gDP2zs45Ez3Jacsop2JTBBfn6PXysy95UIJenWbl0AvKQQyo/yNBB
         vfHNGLyeVjgPgmaBQH+0UtovvjXPGmC8LtVLiC6IPbgyk2vRpn0MwKYzm2Yt4NZqA7l7
         T1ng==
X-Received: by 10.68.249.195 with SMTP id yw3mr29135102pbc.134.1401118493725;
        Mon, 26 May 2014 08:34:53 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250097>

xcalloc takes two arguments: the number of elements and their size.
diffstat_add passes the arguments in reverse order, passing the
size of a diffstat_file*, followed by the number of diffstat_file* to
be allocated. Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 635dee2..a71dfde 100644
--- a/diff.c
+++ b/diff.c
@@ -1360,7 +1360,7 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 					  const char *name_b)
 {
 	struct diffstat_file *x;
-	x = xcalloc(sizeof (*x), 1);
+	x = xcalloc(1, sizeof(*x));
 	if (diffstat->nr == diffstat->alloc) {
 		diffstat->alloc = alloc_nr(diffstat->alloc);
 		diffstat->files = xrealloc(diffstat->files,
-- 
2.0.0.rc1.543.gc8042da
