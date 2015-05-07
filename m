From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 00/12] Improve git-pull test coverage
Date: Thu,  7 May 2015 16:43:56 +0800
Message-ID: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:44:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHPq-0005Lr-9N
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbbEGIoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:17 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35908 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbbEGIoP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:15 -0400
Received: by pabsx10 with SMTP id sx10so34331442pab.3
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cZyI3sLOScV0hmCAX2ZCRMUIYzz2533i+16tl7ppyP4=;
        b=cuht3d+3zjlWXh4l2uOcKEJABDXmKDtk0hq8rRMJN8oGGE+YGlbSppRDC+9/Exx/5K
         e9lVhlLtV0YnxGs9FAqHc5VZRqCJ3XbOXOIyeUNAid47rftc+Co4/XiRt3yoXRV3a0Hq
         ZYSgzw9JkdiUzL8MgQijgZ2A9R9MwGH7DjtyV9Z4ouCPz9LmRF3ZXSxYuNMUqncsKHxK
         CGGVd6VJEer4kbQ2dUD0f9XG9/ASqePSQe97UxIv+Dx4OxzsPoSsH1zxeVMmfy2lOQAN
         CqeH0jaSzT+bdf2nbB1628QtUt9Aa3gW7qj52kQYX3DrCHENX2NwOnnFYqfRn2Kry/wm
         Jd1g==
X-Received: by 10.70.130.198 with SMTP id og6mr4951173pdb.153.1430988255484;
        Thu, 07 May 2015 01:44:15 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:14 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268510>

This patch series improves test coverage of git-pull.sh.

This is part of my GSoC project to rewrite git-pull into a builtin. Improving
test coverage helps to prevent regressions that could occur due to the rewrite.

The previous patch series can be found at [1]. Note that it is now based on
jc/merge in pu.

Besides fixing issues raised in the last round, some failing tests have been
added to demonstrate some bugs in git-pull.sh, and some tests are modified to
reduce their dependence on git-pull's functionality so that irrelevant test
suites will not break during the rewrite.

[1] http://thread.gmane.org/gmane.comp.version-control.git/268231

Paul Tan (12):
  t5520: implement tests for no merge candidates cases
  t5520: test for failure if index has unresolved entries
  t5520: test work tree fast-forward when fetch updates head
  t5520: test --rebase with multiple branches
  t5520: test --rebase failure on unborn branch with index
  t5521: test --dry-run does not make any changes
  t4013: call git-merge instead of git-pull
  t5520: ensure origin refs are updated
  t7406: use "git pull" instead of "git pull --rebase"
  t5520: failing test for pull --all with no configured upstream
  t5524: test --log=1 limits shortlog length
  t5520: check reflog action in fast-forward merge

 t/t4013-diff-various.sh     |   2 +-
 t/t5520-pull.sh             | 148 +++++++++++++++++++++++++++++++++++++++++++-
 t/t5521-pull-options.sh     |  13 ++++
 t/t5524-pull-msg.sh         |  17 +++++
 t/t7406-submodule-update.sh |   2 +-
 5 files changed, 177 insertions(+), 5 deletions(-)

-- 
2.1.4
