From: larsxschneider@gmail.com
Subject: [PATCH v2 0/4] Add Travis CI support
Date: Sun,  4 Oct 2015 11:06:13 -0700
Message-ID: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 04 20:06:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zing4-0000Wm-Ay
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbbJDSGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:06:24 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36722 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbJDSGX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:06:23 -0400
Received: by wicgb1 with SMTP id gb1so91220045wic.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ilwaQCP/6sX+gCzJq0oaJ4JtRcmZJaYrs3WRe2h+Ggs=;
        b=cXU44yV4enSJ2AhPE0FRGH7EABOvoXrB0nDiJREz5jUI67/sOyXl/6EIaqVb5uq+rh
         pOUXYx9tuTdVelEqlX0PK0sA1pfSqFoeCNaFvhs0qc+cB95QvbPvV18XBW2r2QJM1T7m
         UTpbSDHKZ7YF8I60t8eU2iFxYnswouTWwpon5KYq5Lb2L0jJthnQ5u5+oiHXlSp0+sXT
         5dXnmwLG2N9dN5Wt4B09BNPsP/fINNC16Ha1QXPGos0curgcvDRSkc+PcE3M3un4soXb
         HjXHZbsULKkmEB6BIMZ2k0QXMp7MEEoNBijmT9Mp+10MpgatVpZJCtldxcVzMrE2xl+W
         nx7g==
X-Received: by 10.180.187.141 with SMTP id fs13mr8286256wic.13.1443981982139;
        Sun, 04 Oct 2015 11:06:22 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsk-nat-ip3.autodesk.com. [132.188.71.3])
        by smtp.gmail.com with ESMTPSA id o3sm10378607wif.22.2015.10.04.11.06.19
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Oct 2015 11:06:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279011>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v1:
* improve readabilty of Travis "before_script" section
* make OS X Perforce brew robust against changing Perforce builds [1]
* add a prereq to detect OS X in tests
* fix t9815 git-p4-submit-fail test case on OS X
* disable t9819 git-p4-case-folding test on OS X

Thanks Junio for the feedback. You are right, I should have fixed the failing
tests in the first place. With this patch all tests pass on Linux and OS X:
https://travis-ci.org/larsxschneider/git/builds/83575208

In a subsequent patch I plan to:
* add cvs to run t94?? tests
* add svn to run t91?? tests
* add apache to run 5539, 5550, and 5561
* investigate if it is possible to run t1509 root worktree test
* investigate if it is possible to add jgit to run t5310

Plus I have the following questions:
* Can you explain to me how the t7006 page tests should be executed?
* Should we enable EXPENSIVE, CLONE_2GB, and USE_LIBPCRE flag?

Thanks,
Lars

[1] This is a workaround. I am in contact about the issue with the homebrew
maintainers and maybe we can make this easier soon:
https://github.com/Homebrew/homebrew-binary/pull/267#issuecomment-145317114

Lars Schneider (4):
  Add Travis CI support
  Add prereq to detect OS X
  git-p4: Fix t9815 git-p4-submit-fail test case on OS X
  git-p4: Disable t9819 git-p4-case-folding test on OS X

 .travis.yml                    | 31 +++++++++++++++++++++++++++++++
 t/t9815-git-p4-submit-fail.sh  |  8 ++++++--
 t/t9819-git-p4-case-folding.sh |  5 +++++
 t/test-lib.sh                  |  5 ++++-
 4 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 .travis.yml

--
2.5.1
