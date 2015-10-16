From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/12] git submodule update: Announce skipping submodules on stderr
Date: Thu, 15 Oct 2015 18:52:02 -0700
Message-ID: <1444960333-16003-2-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuC2-000264-Dh
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbbJPBwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:19 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35620 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbbJPBwS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:18 -0400
Received: by pabws5 with SMTP id ws5so6574136pab.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ulxQ4n8LM5BkOQ/Z16tt3g/3op9pCwNhYnqxKtvHUQ=;
        b=BmYO5Zml6XTLNOrssPAPk+nCB+auB1l58RxsU3MdHiddVCKiUO3HHgeQuH9ONx/toy
         50Xvf2weZAGOwHHQyJC8O/nKBDeZD097bEI350hKRtFsfuiEqqXQMiqk8rwdlEfVVfis
         2Ck2U8XDOscSAOwEv8FgaWaRAzF5/un/AyiyNZXX4hXWBT0F5kwcDm4AsjILR8B8SjiA
         dE/3DequYYbkMU3n1+8uDj68sUxuumTSrm2iqQw8enrwQT/EB73AAqw9F4V6Tr+z6KG6
         mAJtYQ1GNkdbFlixrZgWF2ngNk4gBLoiOZwpV1aPGc/XgdeyY4ncSakbh1ZMitgS+ZTL
         S/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ulxQ4n8LM5BkOQ/Z16tt3g/3op9pCwNhYnqxKtvHUQ=;
        b=VE/XZNwRyRVAlx2zb/L4zEu7uIJVX0aKJ0vKMPhl+gR0Bk3Sra0QJ6q+1K8fD6KD+I
         YiUGJQr8feU6p7XafnHZtu001JGmbWWqkCXEJrxnC718N2ce5M/aH8zTzrNUQb4OfXzR
         3Mn/TSJubUYY/LpJFcZgyTMwVeIxIAWQC7C2y06HothkxYnkikQ8JgSOW+GhRqpTeRkW
         EQb5wOQMpfjf24xNE1jDrzOQospCsyF4Ea3RRB18TsVq+M6RBRRRRps70HuOxETBlqn+
         5ecvIzqqwbkAox0Xf5crqIqEpxfMmCrQHXAvbWyoQ2JRfxTpSo8d2PBMXNKe3IeHiHho
         Iitw==
X-Gm-Message-State: ALoCoQls52irym0Lesyr031ZxGT9u7DpKo6cb2NwpAmtRjM+YuZyVwpR5iAkL6/Q+Z+7kSmAHA7b
X-Received: by 10.66.190.135 with SMTP id gq7mr13477629pac.65.1444960337600;
        Thu, 15 Oct 2015 18:52:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id i9sm17772533pbq.84.2015.10.15.18.52.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279718>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b0eb9a..578ec48 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -684,7 +684,7 @@ cmd_update()
 
 		if test "$update_module" = "none"
 		then
-			echo "Skipping submodule '$displaypath'"
+			echo >&2 "Skipping submodule '$displaypath'"
 			continue
 		fi
 
-- 
2.5.0.277.gfdc362b.dirty
