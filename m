From: Shawn Pearce <spearce@spearce.org>
Subject: blame --reverse selecting wrong commit
Date: Sun, 29 May 2011 19:21:33 -0700
Message-ID: <BANLkTikuFEg686VH_RojEe-zmBZRBOx6eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 04:22:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQs7M-0008OW-7H
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 04:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab1E3CV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 22:21:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43690 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab1E3CVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 22:21:55 -0400
Received: by vws1 with SMTP id 1so2389927vws.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 19:21:54 -0700 (PDT)
Received: by 10.52.74.4 with SMTP id p4mr911946vdv.137.1306722114253; Sun, 29
 May 2011 19:21:54 -0700 (PDT)
Received: by 10.52.167.228 with HTTP; Sun, 29 May 2011 19:21:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174711>

Although blame shows Stefan Lay removed the block in commit 05fa1713,
this isn't what happened. It was actually removed in commit 2302a6d3
by Christian Halstrick. It looks like blame gets confused around this
section of the JGit history.

Repository URL:  git://egit.eclipse.jgit/jgit.git

$ git blame -L 1080, --reverse 40fa75feb..master --
org.eclipse.jgit.test/tst/org/eclipse/jgit/storage/file/RefDirectoryTest.java
283a60d1 (Shawn O. Pearce 2011-05-26 17:25:59 -0700 1080)       }
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1081)
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1082)       /**
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1083)        *
Kick the timestamp of a local file.
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1084)        * <p>
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1085)        * We
shouldn't have to make these method calls. The cache is using file
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1086)        *
system timestamps, and on many systems unit tests run faster than the
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1087)        *
modification clock. Dumping the cache after we make an edit behind
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1088)        *
RefDirectory's back allows the tests to pass.
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1089)        *
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1090)        * @param name
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1091)        *
       the file in the repository to force a time change on.
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1092)        */
05fa1713 (Stefan Lay      2011-05-24 01:38:59 -0700 1093)
private void BUG_WorkAroundRacyGitIssues(String name) {


-- 
Shawn.
