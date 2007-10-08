From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/6] Survive capital punishment
Date: Mon, 08 Oct 2007 10:55:02 +0200
Message-ID: <20071008085430.9734.75797.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:55:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeoOk-0003Em-Ho
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 10:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbXJHIzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 04:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbXJHIzV
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 04:55:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2214 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbXJHIzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 04:55:13 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IeoOJ-00024I-00; Mon, 08 Oct 2007 09:55:07 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60301>

This series allows StGit to deal with a detached HEAD: in most cases
it will just exit with a nice error message, but in some cases it will
actually handle it.

Preceded by some more or less related cleanups. (The "explicit
crt_series" patch was needed so that I could grep for the files that
didn't contain crt_series.)

---

Karl Hasselstr=C3=B6m (6):
      Let some commands work with detached HEAD
      Don't have a global crt_series in stgit.commans.common
      Refactor crt_series creation
      Properly detect that HEAD is detached
      Use our nice message printout wrapping system
      Allow caller to customize title of error/warning message


 stgit/commands/add.py      |    2 +-
 stgit/commands/branch.py   |    8 ++++----
 stgit/commands/clean.py    |    4 ++--
 stgit/commands/clone.py    |    2 +-
 stgit/commands/commit.py   |    2 +-
 stgit/commands/common.py   |   24 ++++++++++++------------
 stgit/commands/delete.py   |    4 ++--
 stgit/commands/diff.py     |    9 +++++----
 stgit/commands/edit.py     |    6 +++---
 stgit/commands/files.py    |    4 ++--
 stgit/commands/float.py    |    6 +++---
 stgit/commands/fold.py     |    5 +++--
 stgit/commands/goto.py     |    8 ++++----
 stgit/commands/id.py       |    2 +-
 stgit/commands/imprt.py    |    7 ++++---
 stgit/commands/mail.py     |   16 +++++++++-------
 stgit/commands/new.py      |    2 +-
 stgit/commands/pick.py     |   12 ++++++------
 stgit/commands/pop.py      |    8 ++++----
 stgit/commands/pull.py     |   14 +++++++-------
 stgit/commands/push.py     |    8 ++++----
 stgit/commands/rebase.py   |   12 ++++++------
 stgit/commands/refresh.py  |   10 +++++-----
 stgit/commands/resolved.py |    2 +-
 stgit/commands/series.py   |    5 +++--
 stgit/commands/show.py     |    2 +-
 stgit/commands/sink.py     |    6 +++---
 stgit/commands/status.py   |    2 +-
 stgit/commands/sync.py     |    8 ++++----
 stgit/commands/uncommit.py |    2 +-
 stgit/git.py               |   23 +++++++++++++++++------
 stgit/main.py              |    8 +++-----
 stgit/out.py               |   12 ++++++------
 33 files changed, 130 insertions(+), 115 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
