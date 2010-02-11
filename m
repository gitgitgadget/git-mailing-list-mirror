From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH/RFC 0/4] Using git-mailsplit in mixed line ending
	environment
Date: Thu, 11 Feb 2010 19:13:16 +0100
Message-ID: <20100211181316.GA15028@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 19:13:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfdXZ-0004FW-LM
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 19:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611Ab0BKSNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 13:13:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:55829 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab0BKSNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 13:13:19 -0500
Received: from scotty.home (port-92-203-5-233.dynamic.qsc.de [92.203.5.233])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MGmAP-1NSlUV1ppJ-00DhXb; Thu, 11 Feb 2010 19:13:18 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1BIDGtF015092
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 19:13:16 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1BIDGpH015090
	for git@vger.kernel.org; Thu, 11 Feb 2010 19:13:16 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
X-Mailer: git-send-email 1.7.0.rc1.50.g84249.dirty
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1+RJAjQIJAJFloYdgSPT5PkYqhsThTjMQswAvv
 biFX9HHiwkP2ZMSvR2GlTiEnoZoJ1OsHTHU1vNERGfB4C3fGCF
 qoLyUO2djtjGI+GhrQ69A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139610>

Hello,

I'm using git in an environment with files having dos or unix line
ending. I apply patches using 'git format-patch ... | git am ...'.
A change in git-mailsplit in commit c2ca1d79 introduced a change in
the default behaviour of git-mailsplit when splitting mbox patches. It
makes dos line endings to unix line endings. With this behaviour it is
impossible to apply patches, because there is no possibility to
forward '--keep-cr' through git-am to git-mailsplit.

The following patches introduce the '--kepp-cr' parameter to git-am an
an additional possibility to set '--keep-cr' via configuration for
git-mailsplit. Also I added missing description for '--keep-cr' of
git-mailsplit.

Stefan

Stefan-W. Hahn (4):
  git-mailsplit: Show parameter '--keep-cr' in usage and documentation
  git-mailsplit: add `mailsplit.keep-cr` configuration variable.
  git-am: Add command line parameter `--keep-cr` passing it to
    git-mailsplit.
  Adding test for `--keep-cr` for git-mailsplit and git-am.

 Documentation/config.txt        |    4 ++
 Documentation/git-mailsplit.txt |    5 ++-
 builtin-mailsplit.c             |   12 ++++++-
 git-am.sh                       |   18 +++++++--
 t/t5101-mailinfo-dos.sh         |   75 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 6 deletions(-)
 create mode 100644 t/t5101-mailinfo-dos.sh
