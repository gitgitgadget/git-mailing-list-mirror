From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Wed, 30 Nov 2011 09:03:33 +0000
Message-ID: <1322643817-13051-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 10:04:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVg5a-0005Cf-Ff
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 10:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757204Ab1K3JEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 04:04:21 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54127 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165Ab1K3JET (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 04:04:19 -0500
Received: by mail-bw0-f46.google.com with SMTP id s6so570681bka.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 01:04:18 -0800 (PST)
Received: by 10.204.156.141 with SMTP id x13mr1289984bkw.54.1322643858347;
        Wed, 30 Nov 2011 01:04:18 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id c4sm2565364bkk.13.2011.11.30.01.04.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 01:04:17 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186117>

This is a small set of patches to git-p4 to fix a couple of issues with
branches and labels.

This is the second version of this patch series; the first one vanished
without trace :-)

Firstly, I've added the fixes needed so that branches and labels can
contain shell metacharacters (missed from the previous series). Added
a test case for this.

In adding the test case for labels I also found and fixed a few other
small bugs in the label handling:

 - labels missing a description or "EOT" in their text cause problems;
 - labels without an owner cause problems.

I also noticed, but did not fix, that you can't have more than one label
per commit (the others are silently dropped) and the documentation for
branch import could be improved. I've added a (failing) test case for
the multiple label problem.


Luke Diamand (4):
  git-p4: handle p4 branches and labels containing shell chars
  git-p4: cope with labels with empty descriptions
  git-p4: importing labels should cope with missing owner
  git-p4: add test for p4 labels

 contrib/fast-import/git-p4 |   61 +++++++++++++-----------
 t/t9801-git-p4-branch.sh   |   48 ++++++++++++++++++
 t/t9804-git-p4-label.sh    |  114 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 28 deletions(-)
 create mode 100755 t/t9804-git-p4-label.sh

-- 
1.7.8.rc1.209.geac91.dirty
