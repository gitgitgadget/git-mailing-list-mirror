From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 00/10] vcs-svn,svn-fe add a couple of options
Date: Tue, 16 Aug 2011 15:54:45 +0600
Message-ID: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 11:54:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGLQ-00081U-Ch
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966Ab1HPJxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:53:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab1HPJxy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:53:54 -0400
Received: by bke11 with SMTP id 11so3585259bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Z9LjtX09lRew42mU1fRRhrjAPJb/BddAuh4TJ3HigO8=;
        b=Ox31YyVkQpUBbyGBcIm1gu2nbCssvgGWJ+HwvATJFbUOnJ9eJ5HUxHxG5t/2zp0FXJ
         xSrFoHbDU7Qk37c7xb6hqORqow7tVFJ0FVkPUqBUlqlni0+xDt02UoZfsEwgHlT/sbzw
         +Wv/sLDvHVLjYn3OnMCmf76Z/k0YH2E4NS/9A=
Received: by 10.205.64.74 with SMTP id xh10mr1188768bkb.201.1313488433567;
        Tue, 16 Aug 2011 02:53:53 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.53.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:53:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179412>

This is a next iteration of [1].

Most Noticeable changes since [1] are:
1) squash [2/11] and [4/11] into [3/10] "use parse-options"
2) replace [11/11] with a lesser patch that just adds api for
writing notes in vcs-svn/ but doesn't yet uses it. So that the
series is more stable, while exact notes usage can be adjusted
and played with a bit more separately.
3) applied most of suggestions from [1] with minor edits

The patch base is svn-fe branch at git://repo.or.cz/git/jrn.git

[1] http://thread.gmane.org/gmane.comp.version-control.git/177025

Dmitry Ivankov (10):
  svn-fe: add man target to Makefile
  svn-fe: add EXTLIBS needed for parse-options
  svn-fe,test-svn-fe: use parse-options
  vcs-svn: make svndump_init parameters a struct
  vcs-svn: move commit parameters logic to svndump.c
  vcs-svn,svn-fe: allow to specify dump destination ref
  vcs-svn,svn-fe: convert REPORT_FILENO to an option
  vcs-svn,svn-fe: allow to disable 'progress' lines
  vcs-svn,svn-fe: add --incremental option
  vcs-svn: add fast_export_note to create notes

 contrib/svn-fe/Makefile   |   18 ++++----
 contrib/svn-fe/svn-fe.c   |   45 ++++++++++++++++--
 contrib/svn-fe/svn-fe.txt |   38 +++++++++++++--
 t/t9010-svn-fe.sh         |  118 ++++++++++++++++++++++++++++++++++++++-------
 test-svn-fe.c             |   57 ++++++++++++++++------
 vcs-svn/fast_export.c     |   60 ++++++++++-------------
 vcs-svn/fast_export.h     |   10 ++--
 vcs-svn/svndump.c         |   79 ++++++++++++++++++++++++------
 vcs-svn/svndump.h         |   14 +++++-
 9 files changed, 332 insertions(+), 107 deletions(-)

-- 
1.7.3.4
