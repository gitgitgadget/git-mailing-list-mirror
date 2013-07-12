From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 01/19] t2104: Don't fail for index versions other than [23]
Date: Fri, 12 Jul 2013 19:26:46 +0200
Message-ID: <1373650024-3001-2-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxh7x-0002dY-3z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242Ab3GLR1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:27:25 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:55458 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3GLR1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:27:24 -0400
Received: by mail-pd0-f170.google.com with SMTP id x11so8855410pdj.1
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5KuRsHzD2SjHeKWyKqHgwSBGWw0IzCAy+O/+Z5AiyrA=;
        b=XwB+N++RRZIhV8x8Cfgu6d17P0LFkkPRzOZ+M1ma7xHO0dUJhQGTrq+R1njPH3pXVg
         4E+crrfJIlx2Qetmzuyoi3OddFa8QsOCZFWQ2MI553o54+sIGqGhkG+YJT6/iraXQXuE
         RgC874mtLRNT/6DZYjyFUW4AhGorGdwiVnlyAh9ToF97R9F3NdOYYLl+fTr/DPX0xjG4
         K5NrM2++KGEDrnXPU8QoO/S6ngXG0NaKuNY1rkjD10KAbW/tFyEZeLcUP/6P6wFKF1Gl
         u8H49ysAhhYisCkSweSF9kUxU/Kw5BraKDH0t7ugA6oiC1aIcIg1FUmzpxi+xMyX7fS5
         e+HQ==
X-Received: by 10.68.138.170 with SMTP id qr10mr6390253pbb.158.1373650044070;
        Fri, 12 Jul 2013 10:27:24 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id z19sm49193693paf.12.2013.07.12.10.27.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:27:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230211>

t2104 currently checks for the exact index version 2 or 3,
depending if there is a skip-worktree flag or not. Other
index versions do not use extended flags and thus cannot
be tested for version changes.

Make this test update the index to version 2 at the beginning
of the test. Testing the skip-worktree flags for the default
index format is still covered by t7011 and t7012.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t2104-update-index-skip-worktree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 1d0879b..bd9644f 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -22,6 +22,7 @@ H sub/2
 EOF
 
 test_expect_success 'setup' '
+	git update-index --index-version=2 &&
 	mkdir sub &&
 	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2 &&
-- 
1.8.3.453.g1dfc63d
