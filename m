From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 0/4] Run test suite without dashed commands in PATH
Date: Sat, 28 Nov 2009 11:38:53 -0700
Message-ID: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Nov 28 19:43:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NESGq-0005md-63
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 19:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbZK1Snd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 13:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbZK1Snd
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 13:43:33 -0500
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:54425 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752120AbZK1Snc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 13:43:32 -0500
Received: from OMTA23.emeryville.ca.mail.comcast.net ([76.96.30.90])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id AiWx1d0041wfjNsA9ijgim; Sat, 28 Nov 2009 18:43:40 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA23.emeryville.ca.mail.comcast.net with comcast
	id AitN1d0095FCJCg8jitPsL; Sat, 28 Nov 2009 18:53:23 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id E83FA89114;
	Sat, 28 Nov 2009 11:43:36 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133965>

This patch series runs the test suite without the dashed commands
in the PATH.  This improves the usefulness of the test suite
as examples of how to do things, and more importantly,
minimizes any possibility of regressions in bindir-installed
scripts that might prevent them from working in a standard
install where most dashed commands are not in the PATH (git-cvsserver
was broken in this way until Sep 2009: d2feb01aa5).

The scripts in the "test-bin" directory that patch 3 creates
can also be useful for manually testing a build of git without
installing it; you typically don't need to set any environment
variables (except maybe PATH) for the test-bin scripts to use
the build properly.

Trivial note: This is a cleaned up resend of part of a hodgepodge
cvsserver patch series that I sent last January.

---------

By the way, has anyone considered the possibility of splitting
up the large directory at the top of the git source tree?  I
suspect that no one is interested, or it would have been done
already, but I thought I would mention it anyway.  Perhaps split
off separate directories for libgit.a, builtins, other C-based
excutables, test support executables, scripts, output execdir, and
output intermediate (object) files for each of the other
directories.  Or some subset of these.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

Matthew Ogilvie (4):
  t2300: use documented technique to invoke git-sh-setup
  t3409 t4107 t7406: use dashless commands
  build dashless "test-bin" directory similar to installed bindir
  run test suite without dashed git-commands in PATH

 .gitignore                         |    1 +
 INSTALL                            |    8 +++++-
 Makefile                           |   46 +++++++++++++++++++++++++----------
 t/README                           |    8 ++++++
 t/t2300-cd-to-toplevel.sh          |    2 +-
 t/t3409-rebase-preserve-merges.sh  |    6 ++--
 t/t4107-apply-ignore-whitespace.sh |   20 ++++++++--------
 t/t7406-submodule-update.sh        |    4 +-
 t/test-lib.sh                      |   33 ++++++++++++++++---------
 test-bin-wrapper.sh                |   13 ++++++++++
 10 files changed, 99 insertions(+), 42 deletions(-)
 create mode 100644 test-bin-wrapper.sh
