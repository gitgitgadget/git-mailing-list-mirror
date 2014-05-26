From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 09/15] http-push.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:50 +0900
Message-ID: <1401118436-66090-10-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wowve-0005AU-H7
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbaEZPfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:00 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:59101 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbaEZPe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:58 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so7736650pab.17
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LfsYmmY5RSiSrQaIqGRZbBErYrgsHcrJG+ut59+/Kcs=;
        b=DNIKY0+v15y0npOZdUrEfEhHVgJLL9N0NVXHzwG5+Hk4NGGFKJm0Z+NmF6oQy++zgm
         sSaF0VsNM9+vSXsz3ZG/NdDRfCpSgyBRibO4A1rh2SqDzfMxHZstASszwsjr01QRIuKD
         jbiCymrfsBHu7hl7KxUNsQzEFnF+7N2Kc7Em9yuQuUP2VoamKCwRRG82pIY1sb5nVN/f
         I56j5pid2g45+Y354PqDTsUIfn0/V1ganLYuJBMGrDozrg6mzQPvjsW4AIwpY0hXbtSM
         ypDsoSty6dOhd083b1v9B55EB/1DBbfuj2i/HTRTbumLDoCy+hiDkb2ftsscira46CPA
         ijig==
X-Received: by 10.66.162.74 with SMTP id xy10mr29748023pab.4.1401118498360;
        Mon, 26 May 2014 08:34:58 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250099>

xcalloc takes two arguments: the number of elements and their size.
http-push passes the arguments in reverse order, passing the size
of a repo, followed by the number to allocate. Rearrgange them so
they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index d4b40c9..1c722e5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1733,7 +1733,7 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
-	repo = xcalloc(sizeof(*repo), 1);
+	repo = xcalloc(1, sizeof(*repo));
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
-- 
2.0.0.rc1.543.gc8042da
