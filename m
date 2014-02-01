From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/9] add --gpg-sign to rebase and pull
Date: Sat,  1 Feb 2014 02:17:57 +0000
Message-ID: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 01 03:18:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9QAS-0008J1-2d
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 03:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbaBACSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 21:18:14 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51542 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754332AbaBACSM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jan 2014 21:18:12 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 04A6C28071;
	Sat,  1 Feb 2014 02:18:10 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc1.1006.g81f3755.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241330>

This series was posted to the list some time back.  This is a re-send of
Nicolas Vigier's work with an additional patch that adds --gpg-sign to
pull as well, as well as the fixes that Junio suggested in review.

Since the parsed option value for --gpg-sign=<value> is used not only as
an argument to other commands, but also as output to the user, I chose
to abuse git rev-parse --sq-quote slightly to quote only the argument,
which I feel is more aesthetically pleasing than quoting the entire
option, and perhaps less confusing for the novice shell user.  Both
options are equally functional.

Other than that, this is a simple reroll addressing Junio's review
comments.  I've been using it on my laptop for some time, and it works
fine for me, although further comments are certainly welcome.

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
 git-rebase--interactive.sh        | 32 +++++++++++--------
 git-rebase--merge.sh              |  2 +-
 git-rebase.sh                     | 65 ++++++++++++++++++++++-----------------
 git-request-pull.sh               |  1 +
 git-sh-setup.sh                   |  2 ++
 sequencer.c                       | 11 +++++++
 sequencer.h                       |  2 ++
 18 files changed, 132 insertions(+), 58 deletions(-)

-- 
1.9.rc1.1006.g13f506b.dirty
