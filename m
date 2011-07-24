From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 0/2] ls-tree: exit with non-zero status on error
Date: Mon, 25 Jul 2011 00:59:12 +1000
Message-ID: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 16:59:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql09f-0008BH-24
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab1GXO7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:59:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46160 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1GXO7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:59:30 -0400
Received: by ywe9 with SMTP id 9so1895895ywe.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=SuV4zq5Bl30QJn6pVHWNvkQRdUj6kT/NxJLs+8vwmNQ=;
        b=wA1GoiOVw3heOi42DmhpmgKebmDzCX72rD0rIBsBb5SSoG0PbB2LFAACUabUiIrIwB
         D/M9G9qDSLNuVahxns3tIhq57xPKwlFIXAbYhbc5JJoqT5N7SojeTcbtZWurr8bDrdYA
         1OaMKfRNUgmLvVAXvD23MCNX5xFT2SoAwFK/I=
Received: by 10.236.190.34 with SMTP id d22mr4541772yhn.442.1311519569570;
        Sun, 24 Jul 2011 07:59:29 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id v25sm3598186yhk.8.2011.07.24.07.59.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 07:59:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.gf855
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177762>

While working with a damaged repository, I noticed that git ls-tree was reporting an error 
even though it set a zero exit code. 

This patch uses the return code from read_tree_recursive instead.

| v2: Amended test per Jens Lehmann's suggestion.
| v3: Generalize name of test script (in response to Junio's comment).
|     Removed unnecessary local variable, per Jens' comment.

Jon Seymour (2):
  Add a test to check that git ls-tree sets non-zero exit code on
    error.
  Ensure git ls-tree exits with a non-zero exit code if
    read_tree_recursive fails.

 builtin/ls-tree.c               |    6 +++---
 t/t3103-ls-tree-misc.sh         |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)
 create mode 100755 t/t3103-ls-tree-missing-tree.sh

-- 
1.7.6.347.g6a5a9c
