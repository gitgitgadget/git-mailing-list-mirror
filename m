From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/6] Miscellaneous merge fixes
Date: Sat,  9 Apr 2016 23:13:34 -0700
Message-ID: <1460268820-8308-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 08:14:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap8dH-00049x-Sd
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 08:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbcDJGNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 02:13:50 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36670 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbcDJGNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 02:13:49 -0400
Received: by mail-pa0-f66.google.com with SMTP id k3so8290488pav.3
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 23:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y9dZLQW1koWO5yS/BpPENYsQpevn9jO++VDXbmu8nR4=;
        b=pHRninhiGUem/L3/9hYJVXO6jf1nrqRAAFwQzi0aJvgDGy6CWcZjOfWNyN7EZ10j2i
         Zqy1OWSpavW57wjzJS+hSyS410WLjY/8Xww38W6jvL2BqSD4tG7ZJPgf3tIetdmCQ2DG
         wVQiEURnWqGHPdIvplLtTZxrTclD1pnTIBu91vtdO7FcY036ahv92LNKcdtP/PJw5oAj
         0UKfIfpIsMrvEZfY7obLXgzLprHIujinjAH7U2AiqBrDS66a+VSVpL0HIlKi6wn8hjrc
         bOG/uWlyqEKbaF1BWidWjlXAdbK2yZ9zDLbszSfsnOHLizE4A1c4K8s6BTBC0Ym8mxuq
         VWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y9dZLQW1koWO5yS/BpPENYsQpevn9jO++VDXbmu8nR4=;
        b=fsogzdS5+jTac7hVzH39afowRUoYy0EVFKZWlxP/Ko32pnZdpGsUkSDUn1hDie4uvU
         uWBPsEYPpMdNRhaOLJFPf4pCeVIBkNAftruagIFISrjMcMtY0nJm6WheJi95fV/Oz5oN
         hTKZLbLcduWZOYiHy/uROvI2ugKvblOUFysOS+4YfdJTyFfgSsp+n6yDbIglOZpd/mgo
         1Oq1Kg/4DDa7CyoMgXdIAyLqk5rchGbAjs+3OaERe4cLhKhDsxfg+Oj/yqgjXKeBPQzE
         p0PmcK/+m0DfUsam+6YG9ceT1bJJR7Y2dnOdYJacFVwAFwtY5pXICIVk+zOL5VOj+rNm
         3dyg==
X-Gm-Message-State: AD7BkJKPGPGvaF5kxzzmwHT7pC/PhEjOOz/MJcPltyY4QyXVe3Lhjy1HBJZm2Grl4UKOYg==
X-Received: by 10.66.90.136 with SMTP id bw8mr24208578pab.52.1460268828813;
        Sat, 09 Apr 2016 23:13:48 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id p26sm28228711pfi.84.2016.04.09.23.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2016 23:13:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g5833b2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291143>

This series has four independent miscellaneous fixes, three split out
from my RFC series at $gmane/291007 and one new fix.  These four fixes
have no dependencies on each other, so I can trivially split them into
four submissions if preferred.  I only batched them because I want my
index-only merge series to be able to simultaneously depend on three
of them.

The first patch is a very minor code cleanup, which has already been
reviewed by Junio.

The second patch is also a minor code cleanup.

The third and fourth patches test and fix a bug with octopus merges.
Since last submitting these patches with my RFC series, I discovered
our documentation used to explicitly state the expectation I enforced
with these patches.  I added a note about that in the commit message.

The fifth and sixth patches test and fix a bug with trivial merges;
these patches are new since my RFC series.


Elijah Newren (6):
  Remove duplicate code
  Avoid checking working copy when creating a virtual merge base
  Add merge testcases for when index doesn't match HEAD
  merge-octopus: Abort if index does not match HEAD
  Add a testcase demonstrating a bug with trivial merges
  builtin/merge.c: Fix a bug with trivial merges

 builtin/merge.c                          |   8 ++
 git-merge-octopus.sh                     |   6 ++
 merge-recursive.c                        |   8 +-
 t/t6044-merge-unrelated-index-changes.sh | 153 +++++++++++++++++++++++++++++++
 t/t7605-merge-resolve.sh                 |   6 +-
 5 files changed, 175 insertions(+), 6 deletions(-)
 create mode 100755 t/t6044-merge-unrelated-index-changes.sh

-- 
2.8.0.21.g229f62a
