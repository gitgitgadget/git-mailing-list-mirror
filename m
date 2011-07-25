From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 0/2] ls-tree: exit with non-zero status on error
Date: Tue, 26 Jul 2011 08:03:09 +1000
Message-ID: <1311631391-12842-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, schwab@linux-m68k.org,
	gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 00:03:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlTFZ-0007lq-BY
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 00:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab1GYWDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 18:03:40 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:64333 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab1GYWDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 18:03:39 -0400
Received: by pzk37 with SMTP id 37so9174086pzk.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9OPFMad57JEyngFwpwtCh7Nj92z3yJr4bYOYUhlMnKQ=;
        b=vlfK727EnJZglxiIGdjrZ56NjPEfxO+WJTf3Eu6qzJ9riPv00pfVU9t+kGdM99qZap
         6s9JXfGTgABgvLxGpNNgS7E70X5zXbuzlpLkRJ/ZYpJDO4ZLeesB/34uHGEt1PhBLNQn
         DbH2L6ZNpnqMuggn4QABaHbcbC7iG1PG90jZ8=
Received: by 10.68.52.1 with SMTP id p1mr8798374pbo.127.1311631418540;
        Mon, 25 Jul 2011 15:03:38 -0700 (PDT)
Received: from localhost.localdomain ([120.17.170.52])
        by mx.google.com with ESMTPS id d1sm4966401pbj.88.2011.07.25.15.03.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 15:03:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g8394c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177825>

While working with a damaged repository, I noticed that git ls-tree was reporting an error 
even though it set a zero exit code. 

This patch uses the return code from read_tree_recursive instead.

| v2: Amended test per Jens Lehmann's suggestion.
| v3: Generalize name of test script (in response to Junio's comment).
|     Removed unnecessary local variable, per Jens' comment.
| v4: Lexical simplification (Andreas, Junio), 0 or 1 exit code (Nguyen).

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
