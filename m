From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 09/19] git-rebase--interactive.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:22 -0700
Message-ID: <1400593832-6510-10-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRg-0000Bh-Qa
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbaETNut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:49 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:42156 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbaETNus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:48 -0400
Received: by mail-pd0-f176.google.com with SMTP id p10so337308pdj.35
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Noy7dQiobht7BPYXI1BtYtgW2rwS4S35a9Lp5veyjqs=;
        b=OWnizhrMtL47V0/P0VAQ9/Iw37oxuDnTMeJEPpKhGnxzuW1BFEfCJF9B6TnG/M4n9A
         XG3rdU6ptEwwDj5h2H7qtUBvpz6SIubfBvT5hElR37owwVGnQpE+/gs20OKUYYYr1+yO
         /4KgUhfagZo4WvZBN6gxmNOs3keCs8UQtJpvJbhzXkATqkZrGLWzmXVx4q9BTq1Qu423
         FKoe7Aj+Q2v3mJE5XaR741pn+fB9dPGVkPjVcwu6viPWbuwdV553t84RwIc+rPH9Rao7
         Y1AjqNzi/tq12tBt58rHL+hhuQulYsBvrMtWovx049A0H63dMZ+DG/LiLrgSUounrTe0
         JqRw==
X-Received: by 10.68.132.68 with SMTP id os4mr50925609pbb.129.1400593847933;
        Tue, 20 May 2014 06:50:47 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249668>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-rebase--interactive.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6ec9d3c..797571f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1013,7 +1013,7 @@ then
 	git rev-list $revisions |
 	while read rev
 	do
-		if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
+		if test -f "$rewritten"/$rev && test "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
 		then
 			# Use -f2 because if rev-list is telling us this commit is
 			# not worthwhile, we don't want to track its multiple heads,
-- 
1.7.10.4
