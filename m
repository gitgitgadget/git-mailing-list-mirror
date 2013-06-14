From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] stash: simplify option parser for create
Date: Fri, 14 Jun 2013 16:02:02 +0530
Message-ID: <1371205924-8982-4-git-send-email-artagnon@gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 12:30:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnRHO-0000Tc-CA
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 12:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab3FNKag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 06:30:36 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:58383 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab3FNKaT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 06:30:19 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so442737pbc.11
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4Cvd1DdnvQLXC5jMr44fMoDfs8QpbjpmmPvlmPRe/E0=;
        b=EPPe9FTpxGTuygLoOKC59F8EbX9OMLR8LvomWIacuJpBC7boqN4FauJMiRfG511L5d
         UbmaKPb+JYHk+GlwvF/OCwAUAKSo7zebRKr1JO6q2sdbIP1LY1/j2pwZeG5KCCWovFI5
         AvJcWybkZ3yUYCue4Yxyt3WUbRBAKagrua05kITM0GY84i6X6VQGkSaDMLLrUyre/mwJ
         VxHOGAnOtGPV47xLIbgY/SPxESkQUW03ecBQZ/flkrVIn51TSz197gngb0p/+VxrqOQN
         7j5OonmCh3jvbLUnlwodVWh7keNsTGycjdTwhPrJg/Xd4Bz9G7+rvOfxrjaQzWYrdIh7
         L1kw==
X-Received: by 10.68.178.229 with SMTP id db5mr1890578pbc.79.1371205818861;
        Fri, 14 Jun 2013 03:30:18 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id xj9sm1809871pbc.16.2013.06.14.03.30.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 03:30:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.g0d5ad6b
In-Reply-To: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227808>

The option parser for create unnecessarily checks "$1" inside a case
statement that matches "$1" in the first place.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-stash.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index bbefdf6..64800b8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -546,10 +546,7 @@ clear)
 	clear_stash "$@"
 	;;
 create)
-	if test $# -gt 0 && test "$1" = create
-	then
-		shift
-	fi
+	shift
 	create_stash "$*" && echo "$w_commit"
 	;;
 drop)
-- 
1.8.3.1.383.g0d5ad6b
