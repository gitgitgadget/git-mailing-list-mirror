From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 0/4] die_errno()
Date: Sat, 27 Jun 2009 17:58:43 +0200
Message-ID: <cover.1246115204.git.trast@student.ethz.ch>
References: <cover.1244494646.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 17:58:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKaIt-0004IM-0c
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 17:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZF0P6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 11:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbZF0P6s
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 11:58:48 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16289 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbZF0P6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 11:58:47 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 17:58:48 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 17:58:48 +0200
X-Mailer: git-send-email 1.6.3.3.433.gc91b
In-Reply-To: <cover.1244494646.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 27 Jun 2009 15:58:48.0820 (UTC) FILETIME=[289E4B40:01C9F740]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122369>

Sorry for taking so long to come up with another iteration; I was on
holiday last week and rather busy otherwise.

This just picks up Junio's %-doubling patch from pu, with the extra
change I suggested in <200906121204.37752.trast@student.ethz.ch> to
handle the border case where a lone % would end up at the end of the
buffer.  The rest is the same as v3.


Junio C Hamano (1):
  die_errno(): double % in strerror() output just in case

Thomas Rast (3):
  Introduce die_errno() that appends strerror(errno) to die()
  Convert existing die(..., strerror(errno)) to die_errno()
  Use die_errno() instead of die() when checking syscalls

 abspath.c                |   12 ++++++------
 bisect.c                 |    5 ++---
 branch.c                 |    4 ++--
 builtin-add.c            |    2 +-
 builtin-apply.c          |   12 ++++++------
 builtin-archive.c        |    4 ++--
 builtin-blame.c          |   15 +++++++--------
 builtin-clone.c          |   21 ++++++++++-----------
 builtin-commit-tree.c    |    2 +-
 builtin-commit.c         |   28 +++++++++++++---------------
 builtin-config.c         |    4 ++--
 builtin-diff.c           |    2 +-
 builtin-fast-export.c    |    4 ++--
 builtin-fetch--tool.c    |    2 +-
 builtin-fmt-merge-msg.c  |    5 ++---
 builtin-fsck.c           |   10 +++++-----
 builtin-grep.c           |    2 +-
 builtin-init-db.c        |   21 +++++++++++----------
 builtin-log.c            |    4 ++--
 builtin-mailsplit.c      |    6 +++---
 builtin-merge.c          |   29 ++++++++++++++++-------------
 builtin-mv.c             |    2 +-
 builtin-pack-objects.c   |   14 +++++---------
 builtin-rev-parse.c      |    2 +-
 builtin-revert.c         |    2 +-
 builtin-rm.c             |    2 +-
 builtin-send-pack.c      |    2 +-
 builtin-stripspace.c     |    2 +-
 builtin-tag.c            |    9 ++++-----
 builtin-tar-tree.c       |    2 +-
 builtin-unpack-objects.c |    2 +-
 combine-diff.c           |    2 +-
 csum-file.c              |    5 ++---
 daemon.c                 |   15 +++++++--------
 diff.c                   |   10 +++++-----
 dir.c                    |    2 +-
 entry.c                  |   10 +++++-----
 fast-import.c            |    8 ++++----
 git-compat-util.h        |    1 +
 git.c                    |    6 +++---
 hash-object.c            |    2 +-
 index-pack.c             |   21 ++++++++++-----------
 ll-merge.c               |    2 +-
 merge-recursive.c        |    6 +++---
 mktag.c                  |    2 +-
 pack-refs.c              |    7 +++----
 pack-write.c             |   10 +++++-----
 pkt-line.c               |    4 ++--
 read-cache.c             |    8 ++++----
 refs.c                   |    2 +-
 run-command.c            |    4 ++--
 setup.c                  |   18 +++++++++---------
 sha1_file.c              |    2 +-
 shell.c                  |    2 +-
 test-sha1.c              |    2 +-
 transport.c              |    4 ++--
 unpack-file.c            |    2 +-
 usage.c                  |   28 ++++++++++++++++++++++++++++
 wrapper.c                |    8 ++++----
 write_or_die.c           |    6 +++---
 60 files changed, 225 insertions(+), 207 deletions(-)
