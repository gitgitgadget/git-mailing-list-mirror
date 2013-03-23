From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v9a 0/5] git log -L
Date: Sat, 23 Mar 2013 07:44:01 +0100
Message-ID: <cover.1364020899.git.trast@student.ethz.ch>
References: <cover.1363865444.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 23 07:44:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJICH-00023l-GX
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 07:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812Ab3CWGoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 02:44:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:57671 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807Ab3CWGoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 02:44:13 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Mar
 2013 07:44:06 +0100
Received: from pctrast.inf.ethz.ch (129.132.211.113) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 23 Mar
 2013 07:44:10 +0100
X-Mailer: git-send-email 1.8.2.235.g4032450
In-Reply-To: <cover.1363865444.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.211.113]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218892>

This is a small fix to an embarrassing problem with 4/5; as Junio
noticed

>  Does not seem to pass its own test (t4211-line-log.sh).

This resurrects two t/t4211/expect.* files that were missing from v9
due to a botched cleanup.  Sorry for the noise.


Bo Yang (2):
  Refactor parse_loc
  Export rewrite_parents() for 'log -L'

Thomas Rast (3):
  Implement line-history search (git log -L)
  log -L: :pattern:file syntax to find by funcname
  Speed up log -L... -M

 Documentation/blame-options.txt     |   21 +-
 Documentation/git-blame.txt         |    6 +-
 Documentation/git-log.txt           |   23 +
 Documentation/line-range-format.txt |   25 +
 Makefile                            |    4 +
 builtin/blame.c                     |   99 +--
 builtin/log.c                       |   31 +
 line-log.c                          | 1228 +++++++++++++++++++++++++++++++++++
 line-log.h                          |   49 ++
 line-range.c                        |  237 +++++++
 line-range.h                        |   36 +
 log-tree.c                          |    4 +
 revision.c                          |   22 +-
 revision.h                          |   16 +-
 t/perf/p4211-line-log.sh            |   34 +
 t/t4211-line-log.sh                 |   40 ++
 t/t4211/expect.beginning-of-file    |   43 ++
 t/t4211/expect.end-of-file          |   62 ++
 t/t4211/expect.move-support-f       |   40 ++
 t/t4211/expect.simple-f             |   59 ++
 t/t4211/expect.simple-f-to-main     |  100 +++
 t/t4211/expect.simple-main          |   68 ++
 t/t4211/expect.simple-main-to-end   |   70 ++
 t/t4211/expect.two-ranges           |  102 +++
 t/t4211/expect.vanishes-early       |   39 ++
 t/t4211/history.export              |  330 ++++++++++
 t/t8003-blame-corner-cases.sh       |    6 +
 27 files changed, 2671 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line-log.c
 create mode 100644 line-log.h
 create mode 100644 line-range.c
 create mode 100644 line-range.h
 create mode 100755 t/perf/p4211-line-log.sh
 create mode 100755 t/t4211-line-log.sh
 create mode 100644 t/t4211/expect.beginning-of-file
 create mode 100644 t/t4211/expect.end-of-file
 create mode 100644 t/t4211/expect.move-support-f
 create mode 100644 t/t4211/expect.simple-f
 create mode 100644 t/t4211/expect.simple-f-to-main
 create mode 100644 t/t4211/expect.simple-main
 create mode 100644 t/t4211/expect.simple-main-to-end
 create mode 100644 t/t4211/expect.two-ranges
 create mode 100644 t/t4211/expect.vanishes-early
 create mode 100644 t/t4211/history.export

-- 
1.8.2.235.g4032450
