From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 00/11] vcs-svn,svn-fe add a couple of options
Date: Wed, 13 Jul 2011 18:21:02 +0600
Message-ID: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyR0-0004Ap-8E
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635Ab1GMMUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:20:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab1GMMUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:20:51 -0400
Received: by bwd5 with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QW24V53+rCoV3sC3o0AZdqrWkPeRS8WvLAgADWfP3hQ=;
        b=VBjncAk2r8MuWNbuD42VnnGqjRICSvkk+Q1CfclSPSWyGid1sXk2YG13XAbDGgqL+6
         saNN1LJ8J51RCWlt0/h24lKYgYCI0iu6fWR3xve22X+FYqXvuSk+Soc5xODlcHePMVJp
         ZVIeclGrqLbdvCOL16sJb6801rOrrAv8sRqnk=
Received: by 10.204.70.76 with SMTP id c12mr550502bkj.70.1310559650074;
        Wed, 13 Jul 2011 05:20:50 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.20.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:20:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177025>

This is a second iteration of [1].

The most significant changes since [1] are:
1) svndump_init parameters are wrapped into a struct svndump_init_args
This way it is a bit easier to play with various parameters.
Thanks to Ram for insisting on this.
2) added [6/11] "vcs-svn: move commit parameters logic to svndump.c"
Now fast_export is touched only in one commit of this series and there
are other nice implications mentioned in the commit message.
3) added [10/11] and [11/11] - two more options to be used in a
upcoming iteration of remote-svn-alpha series

The patch base is svn-fe branch at git://repo.or.cz/git/jrn.git

[1] http://thread.gmane.org/gmane.comp.version-control.git/176578

Dmitry Ivankov (11):
  svn-fe: add man target to Makefile
  test-svn-fe: use parse-options
  svn-fe: add EXTLIBS needed for parse-options
  svn-fe: add usage and unpositional arguments versions
  vcs-svn: move url parameter from _read to _init
  vcs-svn: move commit parameters logic to svndump.c
  vcs-svn,svn-fe: allow to specify dump destination ref
  vcs-svn,svn-fe: convert REPORT_FILENO to an option
  vcs-svn,svn-fe: allow to disable 'progress' lines
  vcs-svn,svn-fe: add --incremental option
  vcs-svn,svn-fe: add an option to write svnrev notes

 contrib/svn-fe/Makefile   |   18 +++---
 contrib/svn-fe/svn-fe.c   |   46 ++++++++++++-
 contrib/svn-fe/svn-fe.txt |   37 +++++++++--
 t/t9010-svn-fe.sh         |  157 +++++++++++++++++++++++++++++++++++++++-----
 test-svn-fe.c             |   59 +++++++++++++----
 vcs-svn/fast_export.c     |   44 ++++---------
 vcs-svn/fast_export.h     |    8 ++-
 vcs-svn/svndump.c         |   82 +++++++++++++++++++----
 vcs-svn/svndump.h         |   11 +++-
 9 files changed, 361 insertions(+), 101 deletions(-)

-- 
1.7.3.4
