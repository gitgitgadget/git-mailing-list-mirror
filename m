From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 0/9] Improve git-pull test coverage
Date: Wed, 13 May 2015 17:08:47 +0800
Message-ID: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:09:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfM-0003By-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbbEMJJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:20 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33516 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbbEMJJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:16 -0400
Received: by pdbnk13 with SMTP id nk13so45449333pdb.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=13PjOKa0hvehtrwLFP0Q6j/dwiwIZtN5PW5USUzbvE4=;
        b=fPbEzbvVQlrJTB/Fv9wsN82l3saeF17aWXgg7kSYMT6tkGOsH0J8n4FS9O3hyY0QrQ
         besHSuWN5nDJ/CZCk/TKt7ugkn58+CIm18Jd5ZT9ZImVyabRLh/E45Oy6AZ1MxXgys/6
         NOMhPFp5MpjnklPYbNsyDTH46Zf/N57gfsoU88tzawsebYGQV3lkPOq/a/gEApusgdXi
         hSEzf202ixMrhooA+yfahnj4ZLbOJdxE7RH6WtEYegYesvdDevOpfd3IA7wKjhsAxNyq
         mZn2E9gQfgCM1A0y5HTTa23hg3V0cyN2pMP1CCKk6FMabFdl1c4D7ZDjfcFHrfURCUFA
         znpA==
X-Received: by 10.66.66.135 with SMTP id f7mr35693044pat.22.1431508156539;
        Wed, 13 May 2015 02:09:16 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:15 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268950>

This is a re-roll of [1]. This series depends on jc/merge.

This patch series improves test coverage of git-pull.sh, and is part of my
GSoC project to rewrite git-pull into a builtin. Improving test coverage
helps to prevent regressions that could occur due to the rewrite.

This re-roll includes the following changes across all patches:

* Added clean-up patch to fix file content comparisons in t5520

* All file content comparisons are quoted to prevent word splitting and use
  verbose() to provide better error messages.

* Style: References to commits are standardized with their summary and date.

* Failing tests have been removed. This series will be solely used to extend
  test coverage of already working functionality. Bugs will be fixed in their
  own patch series'.

* Style: Instead of redirecting stderr to a file named "out", redirect it to a
  file named "err".

Thanks Eric, Torsten, Junio, Stefan, Dscho and Johannes for your reviews last
round.

[1] http://thread.gmane.org/gmane.comp.version-control.git/268510/

Paul Tan (9):
  t5520: fixup file contents comparisons
  t5520: ensure origin refs are updated
  t5520: test no merge candidates cases
  t5520: test for failure if index has unresolved entries
  t5520: test work tree fast-forward when fetch updates head
  t5520: test --rebase with multiple branches
  t5520: test --rebase failure on unborn branch with index
  t5521: test --dry-run does not make any changes
  t5520: check reflog action in fast-forward merge

 t/t5520-pull.sh         | 214 ++++++++++++++++++++++++++++++++++++++----------
 t/t5521-pull-options.sh |  13 +++
 2 files changed, 184 insertions(+), 43 deletions(-)

-- 
2.1.4
