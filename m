From: Luke Diamand <luke@diamand.org>
Subject: [RFC/PATCH 0/4] git-p4: small fixes to branches and labels; tests
Date: Mon,  7 Nov 2011 21:36:35 +0000
Message-ID: <1320701799-26071-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 22:36:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNWs6-0002wz-B8
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab1KGVgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 16:36:45 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33354 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1KGVgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 16:36:45 -0500
Received: by wyh15 with SMTP id 15so4955595wyh.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 13:36:43 -0800 (PST)
Received: by 10.227.197.69 with SMTP id ej5mr30931368wbb.1.1320701803836;
        Mon, 07 Nov 2011 13:36:43 -0800 (PST)
Received: from localhost.localdomain (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id b5sm29264775wbh.4.2011.11.07.13.36.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 13:36:43 -0800 (PST)
X-Mailer: git-send-email 1.7.7.295.g34dd4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185031>

This is a small set of patches to git-p4 to fix a couple of issues with
branches and labels.

Firstly, I've added the fixes needed so that branches and labels can
contain shell metacharacters (missed from the previous series). Added
a test case for this.

In adding the test case for labels I also found a few other small bugs
in the label handling:

 - labels missing a description or "EOT" in their text cause problems;
 - labels without an owner cause problems.

I also noticed, but did not fix, that you can't have more than one label
per commit (the others are silently dropped) and the documentation for
branch import could be improved.

Luke Diamand (4):
  git-p4: handle p4 branches and labels containing shell chars
  git-p4: cope with labels with empty descriptions
  git-p4: importing labels should cope with missing owner
  git-p4: add test for p4 labels

 contrib/fast-import/git-p4 |   61 ++++++++++++++++++++-----------------
 t/t9801-git-p4-branch.sh   |   48 +++++++++++++++++++++++++++++
 t/t9804-git-p4-label.sh    |   73 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 28 deletions(-)
 create mode 100755 t/t9804-git-p4-label.sh

-- 
1.7.7.295.g34dd4
