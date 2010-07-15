From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/8] Resurrect rr/svn-export
Date: Thu, 15 Jul 2010 18:22:56 +0200
Message-ID: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 15 18:21:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZRBe-0006Vx-U1
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 18:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933672Ab0GOQVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 12:21:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56031 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933663Ab0GOQVT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 12:21:19 -0400
Received: by eya25 with SMTP id 25so213063eya.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=It6XOGqtdsGOOpTKqz+CiNnIUy8XApHFyxT3tVHXK7M=;
        b=XqZFlrZrVU90dlKvoM4TnztTbLtrQj5aOJEQfo+ofX7nJAHaZYQRxGjPi46ynUzWin
         6tLSAnGeKr5k2QtIwtdIfE3EvO0gGKRPbqMQunqo3BMbzJgh7xhrNeiMpwfEwe7i3dBo
         uEaZtG561MnTEx3Dexxeagg23bjw9ZIM+P3Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=V9CclScBD+PlH7RJumyfsyF0wb9B5b0OMnxohuc9fnbLmaJVMn+V+lANYFHg8x4FsL
         6tWA0KCBIK1uJrQSMWww8dWk5tldMvG0HDVIV6Rad7hzfb5HQYo1wcIATGBb0SMnIuWs
         KlHPGjdc5JDJFRZzZtA/elTJhmlxDhCDq6kw0=
Received: by 10.213.32.141 with SMTP id c13mr2939781ebd.44.1279210878251;
        Thu, 15 Jul 2010 09:21:18 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm9358550eeh.17.2010.07.15.09.21.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 09:21:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151086>

Hi,

I've decided to get this series merged now instead of waiting for the
ternary treap refactor. It's in excellent shape, thanks to Jonathan's
constant reviews/ fixes and David's constant refactoring. Since
Jonathan's last send, I've incoporated some suggestions from my own
review of Jonathan's series and split it into two series as I proposed
earlier; I'll send the second series (rr/contrib-svn-fe) shortly after
this.

Once this series is merged, I estimate that the following will come in
as incremental patches when the work is finished:
rr/ternary-trp-refactor
rr/zero-tree-refactor
rr/dumpfilev3-parser

Thanks.

-- Ram

David Barr (5):
  Add memory pool library
  Add string-specific memory pool
  Add stream helper library
  Add infrastructure to write revisions in fast-export format
  Add SVN dump parser

Jason Evans (1):
  Add treap implementation

Jonathan Nieder (2):
  Export parse_date_basic() to convert a date string to timestamp
  Introduce vcs-svn lib

 Makefile              |   12 ++-
 cache.h               |    1 +
 date.c                |   14 +--
 vcs-svn/LICENSE       |   33 +++++
 vcs-svn/fast_export.c |   75 +++++++++++
 vcs-svn/fast_export.h |   14 ++
 vcs-svn/line_buffer.c |   93 ++++++++++++++
 vcs-svn/line_buffer.h |   14 ++
 vcs-svn/obj_pool.h    |   80 ++++++++++++
 vcs-svn/repo_tree.c   |  335 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/repo_tree.h   |   26 ++++
 vcs-svn/string_pool.c |  114 +++++++++++++++++
 vcs-svn/string_pool.h |   15 +++
 vcs-svn/svndump.c     |  289 ++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.h     |    8 ++
 vcs-svn/trp.h         |  220 ++++++++++++++++++++++++++++++++
 vcs-svn/trp.txt       |  102 +++++++++++++++
 17 files changed, 1436 insertions(+), 9 deletions(-)
 create mode 100644 vcs-svn/LICENSE
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h
 create mode 100644 vcs-svn/obj_pool.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt
