From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCHv2 0/4] Using git-mailsplit in mixed line ending environment
Date: Thu, 11 Feb 2010 22:26:15 +0100
Message-ID: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 22:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgZF-0004pW-Ll
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab0BKV1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:27:13 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:54737 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab0BKV1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:27:09 -0500
Received: from scotty.home (port-92-203-5-233.dynamic.qsc.de [92.203.5.233])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lhkwb-1O22wq2ZLV-00nP48; Thu, 11 Feb 2010 22:27:06 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1BLR4Uv025003;
	Thu, 11 Feb 2010 22:27:04 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1BLR4sv025001;
	Thu, 11 Feb 2010 22:27:04 +0100
X-Mailer: git-send-email 1.7.0.rc2.17.g39385
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1+dAp6wc9AJ5xmmCotjk1iJ7rqB2q2fZnlZDSO
 L3cTWPpAj16NsCctBIOMsck7fS0vmlImMNQdZgTgT/rdCtJHkx
 9yTj/cXYzXtLPn2WPLgeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139632>

Hello,

I'm using git in environments with files having dos or unix line
ending. I apply patches using 'git format-patch ... | git am ...'.
A change in git-mailsplit in commit c2ca1d79 introduced a change in
the default behaviour of git-mailsplit when splitting mbox patches. It
makes dos line endings to unix line endings. With this behaviour it is
impossible to apply patches.

The following patches introduce the '--kepp-cr' parameter to git-am an
an additional possibility to set '--keep-cr' via configuration for
git-mailsplit. Also I added missing description for '--keep-cr' of
git-mailsplit.

Second round:
I changed 'mailsplit.keep-cr' to 'mailsplit.keepcr' as suggested by Jakub
and a comment in the testcase.

Stefan-W. Hahn (4):
  git-mailsplit: Show parameter '--keep-cr' in usage and documentation
  git-mailsplit: add `mailsplit.keepcr` configuration variable.
  git-am: Add command line parameter `--keep-cr` passing it to
    git-mailsplit.
  Adding test for `--keep-cr` for git-mailsplit and git-am.

 Documentation/config.txt        |    4 ++
 Documentation/git-mailsplit.txt |    5 ++-
 builtin-mailsplit.c             |   12 ++++++-
 git-am.sh                       |   18 +++++++--
 t/t5101-mailinfo-dos.sh         |   74 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+), 6 deletions(-)
 create mode 100644 t/t5101-mailinfo-dos.sh
