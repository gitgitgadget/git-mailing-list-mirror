From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 00/12] Improve git-am test coverage
Date: Fri,  3 Jul 2015 02:16:28 +0800
Message-ID: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj2x-0006EP-0Q
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbbGBSRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:09 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34558 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbbGBSRH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:07 -0400
Received: by pabvl15 with SMTP id vl15so44207082pab.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lwEfDacMEYm4zsKrMqh70brfzcgqtXBPX6/o7bjYOMM=;
        b=Ea0B9pm8PLUBZLmMr9eriIknt5aqe/GzZ1whAKfejAqw5ThERsZXHzxv9yyucyKG2/
         +EugYdCJDlNilldVj3aWVYPOOy6nwRTmPAzKxEFZLYefDjYBukWF+EqEawlNrmGvhJnw
         CuI2GKPgYnu+heZiEMtKlHHGfMQJBb/42PqX0u7U7BneejXU+qR12cBgJQOcLiDjDDZQ
         uGH2dL4Ljs59p4fY9rucw24tuAsCdfYiVO69OUpR8csWubYJvU5Eff9vUXX/BCsYHk9y
         q2yMhh92JmV22IyvV4haLju/XCpLx81dUMJQTtGY1lkaig1k7ONg+LKIj7c38eLxfMnx
         k9UQ==
X-Received: by 10.70.101.3 with SMTP id fc3mr69262507pdb.167.1435861027103;
        Thu, 02 Jul 2015 11:17:07 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273254>

Increase test coverage of git-am.sh to help prevent regressions that could arise
from the rewrite of git-am.sh to C. This patch series, along with
pt/am-foreign, improved test coverage as measured by kcov from 56.5%[1] to
67.3%[2].

No tests for git-am's interactive mode, though, as test_terminal does not seem
to attach a pseudo-tty to stdin(?), thus making git-am's "test -t 0" check fail.

This is part of my GSoC project to rewrite git-am.sh to a C builtin[3].

[1] http://pyokagan.github.io/git/20150430132408-a75942b//kcov-merged/git-am.eb79278e.html
[2] http://pyokagan.github.io/git/20150702173751-2fdae08//kcov-merged/git-am.eb79278e.html
[3] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1


Paul Tan (12):
  t4150: am.messageid really adds the message id
  t4150: am fails if index is dirty
  t4151: am --abort will keep dirty index intact
  t4150: am refuses patches when paused
  t4150: am --resolved fails if index has no changes
  t4150: am --resolved fails if index has unmerged entries
  t4150: am with applypatch-msg hook
  t4150: am with pre-applypatch hook
  t4150: am with post-applypatch hook
  t4150: tests for am --[no-]scissors
  t3418: non-interactive rebase --continue with rerere enabled
  t3901: test git-am encoding conversion

 t/t3418-rebase-continue.sh |  19 ++++
 t/t3901-i18n-patch.sh      |  62 ++++++++++++
 t/t4150-am.sh              | 228 +++++++++++++++++++++++++++++++++++++++++++++
 t/t4151-am-abort.sh        |  15 +++
 4 files changed, 324 insertions(+)

-- 
2.5.0.rc1.81.gfe77482
