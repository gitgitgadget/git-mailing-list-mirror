From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 16/28] rebase: cherry-pick: fix abort of cherry mode
Date: Fri, 30 Aug 2013 00:56:10 -0500
Message-ID: <1377842182-18724-17-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmJ-0007TR-MT
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804Ab3H3GBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:43 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40963 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab3H3GBl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:41 -0400
Received: by mail-oa0-f46.google.com with SMTP id o20so1790045oag.19
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9aitEKAEZrQ8dFQW+QDHW5VYRlyQ20lK8Vb+rmz4DNk=;
        b=VfMoBn4zMJCznluqE2Hp9BNOYNrT1HkcSa6PEwXjIaTa2pa1uconieynh8mwVebTwM
         KueTENc1iYaN6CcGiGNUtlOF2ZI/YvY5YPZsIegHroLaKgXjh6kWdyP/oPv8X6VJX5rH
         lFtn2wddqqTp6R+ubdHdYI9AE0oFAMy+gYNkuAmiEX+v4Iw486se3RdQ/j8lyoNbTB6n
         sFO+uD/2RnUdTIimXPrm6gysKo5aFV9pOCTSYbUYzv1wMO6tVtCPVPu+jH2M7BauQ7AH
         oEo4rU9UOThg3BdA+r0Ji5Zyi9hvikYoGXpMXS2xBbgIipff36dL7eVVunQU/K4cGFNQ
         fA2A==
X-Received: by 10.60.60.105 with SMTP id g9mr5584100oer.8.1377842501171;
        Thu, 29 Aug 2013 23:01:41 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm36905634oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233410>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index b28addc..db2ea8d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -368,6 +368,7 @@ skip)
 	run_specific_rebase
 	;;
 abort)
+	test "$type" == "cherrypick" && git cherry-pick --abort
 	git rerere clear
 	read_basic_state
 	case "$head_name" in
-- 
1.8.4-fc
