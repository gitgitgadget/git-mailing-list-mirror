From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] gitk: Enable mouse horizontal scrolling in diff pane
Date: Sat, 15 Nov 2014 15:05:06 +0100
Message-ID: <1416060306-4048-1-git-send-email-gabriele.mzt@gmail.com>
Cc: paulus@samba.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 15:07:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpe0t-0001yG-8S
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 15:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbaKOOFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 09:05:23 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44118 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbaKOOFW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 09:05:22 -0500
Received: by mail-wi0-f172.google.com with SMTP id hi2so342301wib.5
        for <git@vger.kernel.org>; Sat, 15 Nov 2014 06:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3/mIp+/pIKVX6C7iEw4p1MJ0Wo/QG79sjbp0EWM862A=;
        b=mE+eflfFwBp2l1l/+UfVeh2bMJrDS6tb876v+iOMcvesZfucPGSUABB+IOSYjGkLkM
         YYa4EiNQy8XUJixiwcvmYixA5tr/K7dR86RLahErLIvu2u/oCivH4bWQNCbrqjOGltKA
         W8/8eqxv9hS+yzImV/ZJlRnlesJaEgmGSA9eW2vCbWlncP/jkBjeh2qPipqPnjrFxYsc
         Jje3nurnBQP+ND160PrnOuEqhpL8uACLHSI4xJDE2K746WiA/u1qpFyREvvTCpMj2RS0
         Fb2lK5ZvhQi6C9AGE3sZL9PK7yOpEW2adaVcg4pv5wewgkEqmm6yQo9xCO2+KOGYmiMC
         6TSA==
X-Received: by 10.194.184.75 with SMTP id es11mr22868994wjc.35.1416060321051;
        Sat, 15 Nov 2014 06:05:21 -0800 (PST)
Received: from xps13.homenet (2-235-140-64.ip228.fastwebnet.it. [2.235.140.64])
        by mx.google.com with ESMTPSA id t9sm43442082wjf.41.2014.11.15.06.05.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Nov 2014 06:05:20 -0800 (PST)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently it's required to hold Shift and scroll up and down to move
horizontally. Listen to Button-6 and Button-7 events too to make
horizontal scrolling handier with touchpads and some mice.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 gitk-git/gitk | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 78358a7..95a98e3 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2516,6 +2516,13 @@ proc makewindow {} {
     } else {
 	bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
 	bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
+        bind $ctext <Button> {
+            if {"%b" eq 6} {
+                $ctext xview scroll -5 units
+            } elseif {"%b" eq 7} {
+                $ctext xview scroll 5 units
+            }
+        }
         if {[tk windowingsystem] eq "aqua"} {
             bindall <MouseWheel> {
                 set delta [expr {- (%D)}]
-- 
2.1.3
