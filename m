From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 0/9] add --gpg-sign to rebase and pull
Date: Mon, 10 Feb 2014 01:03:29 +0000
Message-ID: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 10 02:03:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCfHq-0001D8-BY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 02:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbaBJBDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 20:03:46 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51730 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047AbaBJBDp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Feb 2014 20:03:45 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 09DCA2807A;
	Mon, 10 Feb 2014 01:03:43 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241886>

This series was posted to the list some time back.  This is a re-send of
Nicolas Vigier's work with an additional patch that adds --gpg-sign to
pull as well, as well as the fixes that Junio suggested in review for
v3.

There is also one additional merge call that was not previously given a
signature option that is now provided one.  I believe this was an
oversight, so I fixed it.

The major change in this version is fixed quoting for the arguments.
All the quoting should now be correct.  I reverted the change that
placed quoting around only the argument to -S, as this was too difficult
to get consistently right and nobody objected to '-S1F52F68B!' as being
too ugly to display to the user.

Nicolas Vigier (8):
  cherry-pick, revert: add the --gpg-sign option
  git-sh-setup.sh: add variable to use the stuck-long mode
  am: parse options in stuck-long mode
  am: add the --gpg-sign option
  rebase: remove useless arguments check
  rebase: don't try to match -M option
  rebase: parse options in stuck-long mode
  rebase: add the --gpg-sign option

brian m. carlson (1):
  pull: add the --gpg-sign option.

 Documentation/git-am.txt          |  6 +++-
 Documentation/git-cherry-pick.txt |  7 ++++-
 Documentation/git-rebase.txt      |  4 +++
 Documentation/git-revert.txt      |  6 +++-
 builtin/revert.c                  |  2 ++
 contrib/git-resurrect.sh          |  1 +
 git-am.sh                         | 26 ++++++++++------
 git-instaweb.sh                   |  1 +
 git-pull.sh                       | 13 +++++++-
 git-quiltimport.sh                |  1 +
 git-rebase--am.sh                 |  8 +++--
 git-rebase--interactive.sh        | 39 ++++++++++++++++--------
 git-rebase--merge.sh              |  2 +-
 git-rebase.sh                     | 62 +++++++++++++++++++++------------------
 git-request-pull.sh               |  1 +
 git-sh-setup.sh                   |  2 ++
 sequencer.c                       | 11 +++++++
 sequencer.h                       |  2 ++
 18 files changed, 135 insertions(+), 59 deletions(-)

-- 
1.9.0.rc3.1008.gd08b47c.dirty
