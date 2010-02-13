From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCHv3 0/3] Using git-mailsplit in mixed line ending environment
Date: Sat, 13 Feb 2010 18:09:54 +0100
Message-ID: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 18:10:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgLVj-0006IL-Gk
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 18:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766Ab0BMRJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 12:09:58 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:65240 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab0BMRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 12:09:57 -0500
Received: from scotty.home (port-92-203-27-201.dynamic.qsc.de [92.203.27.201])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LoJRp-1ODSKw4C6L-00glzl; Sat, 13 Feb 2010 18:09:56 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1DH9tDH025687;
	Sat, 13 Feb 2010 18:09:55 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1DH9s2n025685;
	Sat, 13 Feb 2010 18:09:54 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX19wNKfBi0frPIG7x8p4TDu4fSaPcpJPQcl7Nd1
 sZbVn1NQNEXVb9TCzTkRylisusRhFby2sUsF32dhiyifC604I6
 qO0/fPr3t244O/6Zi1YGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139812>

Hello,

I'm using git in environments with files having dos or unix line
ending. I apply patches using 'git format-patch ... | git am ...'.
A change in git-mailsplit in commit c2ca1d79 introduced a change in
the default behaviour of git-mailsplit when splitting mbox patches. It
makes dos line endings to unix line endings. With this behaviour it is
impossible to apply patches.

The following patches introduce the '--kepp-cr' parameter to git-am an
an additional possibility to set '--keep-cr' via configuration for
git-am. Also I added missing description for '--keep-cr' of
git-mailsplit.

Second round:
I changed 'mailsplit.keep-cr' to 'mailsplit.keepcr' as suggested by Jakub
and comment in the testcase.

Third round:
I moved configuration 'mailsplit.keepcr' to 'am.keepcr' because
git-mailsplit can be used outside a git repository (thx Junio).

Stefan

Stefan-W. Hahn (3):
      git-mailsplit: Show parameter '--keep-cr' in usage and documentation
      git-am: Add command line parameter `--keep-cr` passing it to git-mailsplit.
      Adding test for `--keep-cr` for git-am.

 Documentation/config.txt        |    6 +++
 Documentation/git-mailsplit.txt |    5 ++-
 builtin-mailsplit.c             |    2 +-
 git-am.sh                       |   27 +++++++++++----
 t/t4253-am-keep-cr-dos.sh       |   68 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 9 deletions(-)
