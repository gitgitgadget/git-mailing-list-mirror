From: Noe Rubinstein <nrubinstein@proformatique.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20rebase=20-i=3A=20fix=20has=5Faction?=
Date: Thu,  4 Aug 2011 11:39:40 +0200
Message-ID: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Noe Rubinstein <nrubinstein@proformatique.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 04 11:45:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QouUy-00050y-Ak
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 11:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab1HDJps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 05:45:48 -0400
Received: from office-puteaux.avencall.com ([92.103.5.174]:44094 "EHLO
	debian.lan-puteaux.avencall.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752621Ab1HDJpr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 05:45:47 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Aug 2011 05:45:47 EDT
Received: by debian.lan-puteaux.avencall.com (Postfix, from userid 1000)
	id EE8688C6056; Thu,  4 Aug 2011 11:39:50 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.398.ge155e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178713>

When doing git rebase -i, removing all actions in the todo list is
supposed to result in aborting the rebase. However, if there are spaces
at the beginning of an empty line, has_action returns true and the
rebase therefore removes all commits. This is probably not what a user
leaving a space on an empty line expects.

This patch fixes the bug by changing has_action to grep any line
containing anything that is not a space nor a #.

Signed-off-by: Noe Rubinstein <nrubinstein@proformatique.com>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c6ba7c1..bed79af 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -149,7 +149,7 @@ die_abort () {
 }
=20
 has_action () {
-	sane_grep '^[^#]' "$1" >/dev/null
+	sane_grep '^[^#[:space:]]' "$1" >/dev/null
 }
=20
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
--=20
No=C3=A9 Rubinstein
Avencall - XiVO IPBX OpenHardware
10 bis, rue Lucien VOILIN - 92800 Puteaux
T=C3=A9l. : +33 (0)1 41 38 99 60 ext 123
=46ax. : +33 (0)1 41 38 99 70
