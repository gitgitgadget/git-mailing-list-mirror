From: Eric Wong <e@80x24.org>
Subject: [PATCH v2 0/3] support mboxrd format
Date: Sun,  5 Jun 2016 04:46:38 +0000
Message-ID: <20160605044641.9221-1-e@80x24.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 06:46:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9Pxb-0006aI-6x
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 06:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbcFEEqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 00:46:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35386 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbcFEEqq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 00:46:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E551F71A;
	Sun,  5 Jun 2016 04:46:45 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296461>

Changes since v2:

* beef up tests, including accounting for the trailing whitespace
  omission in pretty output but still accepting and preserving
  trailing whitespace in mailsplit.

* indicate disabling variable interpolation in heredoc (but
  using variable interpolation as needed for trailing space
  in tests).

* use "git grep" for "-A<NUM>" for portability

* avoid the use of regexp for matching /^From / and /^>+From /

Thanks to Eric Sunshine and Junio for helping with the first round.

v1 started at http://mid.gmane.org/20160530232142.21098-1-e@80x24.org

The following changes since commit 6326f199252a1a5fbdea105473f8305d850cdd87:

  Almost ready for 2.9-rc2 (2016-06-03 14:38:35 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git mboxrd-v2

for you to fetch changes up to 1ab223c4f7b8d6cc246f873795d89ac97da84ae1:

  am: support --patch-format=mboxrd (2016-06-05 04:16:57 +0000)

----------------------------------------------------------------
Eric Wong (3):
      pretty: support "mboxrd" output format
      mailsplit: support unescaping mboxrd messages
      am: support --patch-format=mboxrd

 Documentation/git-am.txt        |  3 ++-
 Documentation/git-mailsplit.txt |  7 ++++++-
 builtin/am.c                    | 14 +++++++++++---
 builtin/log.c                   |  2 +-
 builtin/mailsplit.c             | 18 ++++++++++++++++++
 commit.h                        |  6 ++++++
 log-tree.c                      |  4 ++--
 pretty.c                        | 33 +++++++++++++++++++++++++--------
 t/t4014-format-patch.sh         | 41 +++++++++++++++++++++++++++++++++++++++++
 t/t4150-am.sh                   | 20 ++++++++++++++++++++
 t/t5100-mailinfo.sh             | 31 +++++++++++++++++++++++++++++++
 t/t5100/0001mboxrd              |  4 ++++
 t/t5100/0002mboxrd              |  5 +++++
 t/t5100/sample.mboxrd           | 19 +++++++++++++++++++
 14 files changed, 191 insertions(+), 16 deletions(-)
 create mode 100644 t/t5100/0001mboxrd
 create mode 100644 t/t5100/0002mboxrd
 create mode 100644 t/t5100/sample.mboxrd
