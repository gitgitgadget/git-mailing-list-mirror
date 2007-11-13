From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Tue, 13 Nov 2007 21:04:55 +0100
Message-ID: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21B-0001Be-Ea
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762471AbXKMUFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762515AbXKMUFP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:15 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49184 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762475AbXKMUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 0AECE10A78A;
	Tue, 13 Nov 2007 21:05:06 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64852>

This is a series of smallish, unrelated changes that were necessary
for the MinGW port.

[PATCH 01/11] t5300-pack-object.sh: Split the big verify-pack test into
	smaller parts.
[PATCH 02/11] t7501-commit.sh: Not all seds understand option -i
[PATCH 03/11] t5302-pack-index: Skip tests of 64-bit offsets if necessary.
[PATCH 04/11] Skip t3902-quoted.sh if the file system does not support
	funny names.

Some changes to the test suite.

[PATCH 05/11] Use is_absolute_path() in sha1_file.c.
[PATCH 06/11] Move #include <sys/select.h> and <sys/ioctl.h> to
	git-compat-util.h.

These two are certainly undisputed.

[PATCH 07/11] builtin run_command: do not exit with -1.

Replaces exit(-1) by exit(255). I don't know if this has any bad
consequences on *nix.

[PATCH 08/11] Close files opened by lock_file() before unlinking.

This one was authored by Dscho. It is a definite MUST on Windows.

[PATCH 09/11] Allow a relative builtin template directory.
[PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access
	of ETC_GITCONFIG.
[PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.

These need probably some discussion. They avoid that $(prefix) is
hardcoded and so allows that an arbitrary installation directory.

 Makefile               |    5 ++++-
 builtin-config.c       |    4 ++--
 builtin-init-db.c      |   16 +++++++++++++---
 cache.h                |    2 ++
 config.c               |   20 ++++++++++++++++++--
 git-compat-util.h      |    2 ++
 git.c                  |    2 +-
 help.c                 |    1 -
 lockfile.c             |   17 ++++++++++-------
 pager.c                |    2 --
 sha1_file.c            |    8 ++++----
 t/t3902-quoted.sh      |    7 +++++++
 t/t5300-pack-object.sh |   34 ++++++++++++++++++----------------
 t/t5302-pack-index.sh  |   25 +++++++++++++++++++++++--
 t/t7501-commit.sh      |    6 ++++--
 15 files changed, 108 insertions(+), 43 deletions(-)

-- Hannes
