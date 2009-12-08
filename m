From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 0/6] "git reset --merge" related improvements
Date: Tue, 08 Dec 2009 08:56:09 +0100
Message-ID: <20091208075005.4475.26582.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 09:05:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHv4N-00014T-Pe
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 09:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960AbZLHIEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 03:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755934AbZLHIEq
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 03:04:46 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38809 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537AbZLHIEo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 03:04:44 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A0985818028;
	Tue,  8 Dec 2009 09:04:40 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 35DA6818143;
	Tue,  8 Dec 2009 09:04:37 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134840>

This is a reroll of a previous series from last september:

http://thread.gmane.org/gmane.comp.version-control.git/128706/focus=128707

The changes in this reroll are the following:

- new option was renamed "--keep-local-changes" instead of "--merge-safe",
- some test cases have been added,
- a bug was fixed (head_sha1 is now "unsigned char head_sha1[20]"),
- I took ownership of the third patch,
- some commit messages were improved,
- there are 2 new documentation patches at the end,
- the last documentation patch adds some tables about what all the reset
options are doing in the different cases.

The new option name is "--keep-local-changes" because that's what
Junio used in the last email of the previous discussion, but my
opinion is that it is a bit long and so I'd like to rename it "--keep"
or another such short name.

Christian Couder (5):
  reset: add a few tests for "git reset --merge"
  reset: add option "--keep-local-changes" to "git reset"
  reset: add test cases for "--keep-local-changes" option
  Documentation: reset: describe new "--keep-local-changes" option
  Documentation: reset: add some tables to describe the different
    options

Stephan Beyer (1):
  reset: use "unpack_trees()" directly instead of "git read-tree"

 Documentation/git-reset.txt |   80 ++++++++++++++++++++++-
 builtin-reset.c             |   81 ++++++++++++++++++-----
 t/t7110-reset-merge.sh      |  156 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 300 insertions(+), 17 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh
