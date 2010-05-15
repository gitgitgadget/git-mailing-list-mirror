From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 3/7] Output the graph columns at the end of the commit message.
Date: Sat, 15 May 2010 04:02:07 -0700
Message-ID: <1273921331-32702-4-git-send-email-struggleyb.nku@gmail.com>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-2-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-3-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 13:02:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODF8V-0007jL-TV
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab0EOLCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 07:02:22 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42018 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab0EOLCR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 07:02:17 -0400
Received: by mail-pv0-f174.google.com with SMTP id 1so973492pvh.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 04:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DAgP97F8uxiN/coxDfnpFBZlpNVYEh0jQHP22ptMLgY=;
        b=qsjvrLR+V2qGLkbOP+rtVJ2HkjJEak5Fc++D67vzPcuf2KdZek7S4WbnbxvZAO6He/
         rOct1A3TUBpfRAS1K4J3tYUI2zE0Bw5sk4fkcVBrJubHee8XiRKwuWImAf5NQHbj9erT
         +yCMLfWKYjrPJ1PqdU1l7fSdPnSfoXVttQXoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=d7bxutoeD6PifX0qyY19fpbkjpvR8UXjRKv1txtVI22iPi0kQ11VwqEju1OmlCrHd5
         udXf458bwhHH1ZbmDmX9GBwxBR4TP6ttc0V2MrUGHjnS8Fouq9J5xwkCvqnTM9znQXNb
         8a/qN6jTICbq/c6trnO0fAn5ySirMBY3uLTYk=
Received: by 10.115.81.6 with SMTP id i6mr2168362wal.48.1273921337103;
        Sat, 15 May 2010 04:02:17 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id d16sm28703988wam.12.2010.05.15.04.02.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 04:02:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273921331-32702-3-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147142>

There is an empty line between the commit message and the
diff output. Add the graph columns as prefix of this line.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 log-tree.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index d3ae969..1da4ea7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -469,6 +469,10 @@ int log_tree_diff_flush(struct rev_info *opt)
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if ((pch & opt->diffopt.output_format) == pch)
 				printf("---");
+			if (opt->diffopt.output_prefix) {
+				opt->diffopt.output_prefix(opt->diffopt.file,
+					1, opt->diffopt.output_prefix_data);
+			}
 			putchar('\n');
 		}
 	}
-- 
1.7.1.94.gc3269
