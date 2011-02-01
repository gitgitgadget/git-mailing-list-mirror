From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/3] Towards a Git-to-SVN bridge
Date: Tue,  1 Feb 2011 19:56:40 +0530
Message-ID: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:26:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHBO-0007Xx-5E
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757098Ab1BAO0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 09:26:07 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46258 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757063Ab1BAO0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 09:26:06 -0500
Received: by gwj20 with SMTP id 20so2492142gwj.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 06:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=znIqnp8xNBjD4/UXpw027DUVfq37isIYOtYAjB+2dCQ=;
        b=J9ZQUHd/98BMTchgGNUHwSA/L5H2PuPXPffr6bQPHRC8RWHVEkxZCkfcGM8fcdfXb8
         4ROfee5gpPFYCav664ZRXj0GEjW1PO5O8afvquYWasiLIpvj68hKQUKaH4LxJYX9LGzk
         UG2C7pQxiXLgQbUrvRG1hvFdf2PndpnjMZbNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YBuNC3kfst5mlb6BnolLxeCKoVH/cqqV90chVtpng7MvK7bcDfwe07kOlXheteICbT
         vi7MX1uys7cB64xZH9UCSt+LPMGgUuiSbVcVXTXYrcPbW6gumiS/kPbwlOoXeyjSdtGJ
         42StOzvH4uuyFBwZYCYClH2HsynTL8UPYYYp8=
Received: by 10.236.103.39 with SMTP id e27mr15815875yhg.26.1296570365147;
        Tue, 01 Feb 2011 06:26:05 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id i36sm1494275yhd.27.2011.02.01.06.25.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 06:26:03 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165806>

Hi,

Here's another attempt. I've omitted 3 patches in this round:
1. The --inline-blobs patch
2. The time_to_tm patch
3. The contrib/svn-fe and test-svn-fi patch
(since those haven't changed from last time)

Changes since last time:
1. Bugfixes and testsuite. All tests pass.
2. Style fixes after Junio's review:
<7v39olok4l.fsf@alter.siamese.dyndns.org>
3. Implemented an experimetal dispatch table suggested by Jonathan:
<20110122191801.GB13023@burratino>

Thanks for reading.

Ramkumar Ramachandra (3):
  vcs-svn: Introduce svnload, a dumpfile producer
  t9010-svn-fi: Add tests for svn-fi
  vcs-svn: Refactor dump_export code into dispatch table

 .gitignore            |    1 +
 Makefile              |    9 +-
 t/t9010-svn-fi.sh     |  303 ++++++++++++++++++++++++++++++++++++++++++++++
 test-svn-fi.c         |   20 +++
 vcs-svn/dir_cache.c   |   40 ++++++
 vcs-svn/dir_cache.h   |   12 ++
 vcs-svn/dump_export.c |  150 +++++++++++++++++++++++
 vcs-svn/dump_export.h |   35 ++++++
 vcs-svn/svnload.c     |  322 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svnload.h     |   10 ++
 10 files changed, 899 insertions(+), 3 deletions(-)
 create mode 100644 t/t9010-svn-fi.sh
 create mode 100644 test-svn-fi.c
 create mode 100644 vcs-svn/dir_cache.c
 create mode 100644 vcs-svn/dir_cache.h
 create mode 100644 vcs-svn/dump_export.c
 create mode 100644 vcs-svn/dump_export.h
 create mode 100644 vcs-svn/svnload.c
 create mode 100644 vcs-svn/svnload.h

-- 
1.7.4.rc1.7.g2cf08.dirty
