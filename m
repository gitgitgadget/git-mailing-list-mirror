From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 3/4] t2027-worktree-list: add and adjust tests related to git-rev-parse
Date: Fri, 22 Apr 2016 17:53:11 -0400
Message-ID: <1461361992-91918-4-git-send-email-rappazzo@gmail.com>
References: <1461361992-91918-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 23:53:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atj0k-0001lV-SU
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 23:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbcDVVxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 17:53:10 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33200 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbcDVVxE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 17:53:04 -0400
Received: by mail-yw0-f196.google.com with SMTP id o63so17216012ywe.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z+fCegvqh9aqswHPtuLydTamvQajZUmK2ULWRz66Mtc=;
        b=RaKetelrvHAAukFTIQX8++Iy42JjtybIQaKZ62t2cnCfyE9HLReSHzWr9yfD9iCeDA
         dgwpyZ/Z/MIIpa8BcxHeJE9efnQmGNdHFB4GjGytkOP57pKYKqEazouOLWnM0IKJu7po
         XnxL+Ya0z/FZTgAvc69gnBBqh2zTvtl99nAu6uwtOv/c2zXfgn4MSDRRRhrpztG+GmZI
         j7oNW1Og7l+Xq8NeyA0fIBqM76K1zZQv1Ay8bdFBReuWyesGttSggw8jJt/b3J6iMttG
         hW07x+gc+o0H2ViKzTssxozOgMuk9oj7Oc3wpswZJeK2IcKvohJ5I1ZTsiqa2ykTc+FR
         3UPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z+fCegvqh9aqswHPtuLydTamvQajZUmK2ULWRz66Mtc=;
        b=dmnbFtzncd+vAtE+aMwDctcr4WRsj1jYaxHtKzqZTpzCtlgR+UELghzUJp97vMBCAa
         Y/T/wf2nGvfLWtOET8DHm1fLpxD2vLI1eY/ThZVZPVdmJZ3I5719dbFlpiq070tisFXk
         C6Lh4buGO3ZaKGLDa/bpjkwdyRHIFGmTiCZGJNz9J4/Vq4Wed8IDLkMY3wpcjHr7HUiC
         ML08UVRwbYL70Jv1ZPSAqD7BHCrWJQ7ZXLSLFepoS0OPo5qXGeV2zvHP8xzSUfyKQZ9H
         vRtJeCCdALgpf4W3Td5Wl6bm8qLiYBspih1nqnFPYZH/ECzzeC8gjto9Xj6r7Gn3UK5P
         +QIA==
X-Gm-Message-State: AOPr4FU7VYD1mdv4+gGnaysUjXv8zLu+e1xLNT8XB5hMWkAPvBrgieO3XLgCn8G4AvJNWg==
X-Received: by 10.37.208.199 with SMTP id h190mr14346378ybg.154.1461361983803;
        Fri, 22 Apr 2016 14:53:03 -0700 (PDT)
Received: from MRappazzo-8.local.com (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id m141sm5542104ywd.2.2016.04.22.14.53.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 14:53:03 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461361992-91918-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292270>

Adjust the incorrect expectation for `rev-parse --git-common-dir`.

Add a test for `git rev-parse --git-path` executed from a linked
worktree.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 t/t2027-worktree-list.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 1b1b65a..16eec6e 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -14,10 +14,18 @@ test_expect_success 'rev-parse --git-common-dir on main worktree' '
 	test_cmp expected actual &&
 	mkdir sub &&
 	git -C sub rev-parse --git-common-dir >actual2 &&
-	echo sub/.git >expected2 &&
+	echo ../.git >expected2 &&
 	test_cmp expected2 actual2
 '
 
+test_expect_success 'rev-parse --git-path objects linked worktree' '
+	echo "$(git rev-parse --show-toplevel)/.git/worktrees/linked-tree/objects" >expect &&
+	test_when_finished "rm -rf linked-tree && git worktree prune" &&
+	git worktree add --detach linked-tree master &&
+	git -C linked-tree rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '"list" all worktrees from main' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
 	test_when_finished "rm -rf here && git worktree prune" &&
-- 
2.8.0
