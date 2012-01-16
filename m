From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 0/4] git-p4: small fixes to branches and labels
Date: Mon, 16 Jan 2012 23:14:45 +0000
Message-ID: <1326755689-3344-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 00:15:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmvld-0008Bd-Db
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 00:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab2APXPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 18:15:03 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:34466 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab2APXPC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 18:15:02 -0500
Received: by werb14 with SMTP id b14so696913wer.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 15:15:00 -0800 (PST)
Received: by 10.216.137.148 with SMTP id y20mr4579217wei.32.1326755700501;
        Mon, 16 Jan 2012 15:15:00 -0800 (PST)
Received: from ethel.diamand (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id hv1sm13727543wib.1.2012.01.16.15.14.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 15:14:59 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188668>

This is the third version of some small fixes to git-p4 branch and
label handling.

It was suggested for the earlier version that the author handling
could be simplified to use the 'author' variable. The code can
be simplified, but the author is the wrong value to use - it is
just the author of the commit, not the tag. Use the creator of the
label, or, if that does not exist ("p4 tag ..."), the p4 user.

This change does not fix the other problems with git-p4 labels:

- two p4 labels on the same changelist will fall over
- labels must match exactly the list of files imported
- you can't import a label without a p4 commit

Luke Diamand (4):
  git-p4: handle p4 branches and labels containing shell chars
  git-p4: cope with labels with empty descriptions
  git-p4: importing labels should cope with missing owner
  git-p4: add test for p4 labels

 contrib/fast-import/git-p4        |   79 ++++++++++++++++++++----------------
 t/t9803-git-p4-shell-metachars.sh |   48 ++++++++++++++++++++++
 t/t9804-git-p4-label.sh           |   73 ++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 35 deletions(-)
 create mode 100755 t/t9804-git-p4-label.sh

-- 
1.7.8.rc1.209.geac91.dirty
