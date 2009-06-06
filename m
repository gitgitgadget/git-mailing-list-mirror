From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/3] Thomas Rast <trast@student.ethz.ch>
Date: Sat,  6 Jun 2009 16:44:50 +0200
Message-ID: <cover.1244299302.git.trast@student.ethz.ch>
References: <200906061509.15870.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 16:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCx8t-0000n1-Bc
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 16:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbZFFOo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 10:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZFFOo5
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 10:44:57 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24862 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbZFFOo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 10:44:56 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 16:44:43 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 6 Jun 2009 16:44:42 +0200
X-Mailer: git-send-email 1.6.3.2.288.g40844
In-Reply-To: <200906061509.15870.trast@student.ethz.ch>
X-OriginalArrivalTime: 06 Jun 2009 14:44:42.0876 (UTC) FILETIME=[53F453C0:01C9E6B5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120919>

So here's the reroll.

Changes since v1:

- add die_errno() [1/3] and use it [2/3]

- [3/3] dropped errno reporting after write_buffer, as it already does
  error(..., strerror(errno))

- [3/3] save errno around rollback_locks in builtin-commit.c:965



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
 builtin-blame.c          |   16 +++++++---------
 builtin-clone.c          |   22 ++++++++++------------
 builtin-commit-tree.c    |    3 +--
 builtin-commit.c         |   36 +++++++++++++++++-------------------
 builtin-config.c         |    4 ++--
 builtin-diff.c           |    2 +-
 builtin-fast-export.c    |    5 ++---
 builtin-fetch--tool.c    |    2 +-
 builtin-fmt-merge-msg.c  |    5 ++---
 builtin-fsck.c           |   10 +++++-----
 builtin-grep.c           |    2 +-
 builtin-init-db.c        |   22 +++++++++++-----------
 builtin-log.c            |    4 ++--
 builtin-mailsplit.c      |    7 +++----
 builtin-merge.c          |   33 +++++++++++++++++++--------------
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
 connect.c                |    4 ++--
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
 usage.c                  |   13 +++++++++++++
 wrapper.c                |    8 ++++----
 write_or_die.c           |    6 +++---
 61 files changed, 219 insertions(+), 220 deletions(-)
