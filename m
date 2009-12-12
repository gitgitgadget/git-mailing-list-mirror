From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 0/7] "git reset --merge" related improvements
Date: Sat, 12 Dec 2009 05:32:51 +0100
Message-ID: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 05:31:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJdR-0000Cf-KM
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017AbZLLEau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 23:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756510AbZLLEau
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:30:50 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36803 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755876AbZLLEat (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 23:30:49 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D895C81806A;
	Sat, 12 Dec 2009 05:30:46 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6582A818052;
	Sat, 12 Dec 2009 05:30:43 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135116>

Another reroll with the following changes:

- the name of the new option is now "--keep" instead of "--keep-local-changes",
- the fill_tree_descriptor() function is used instead of adding a new
parse_and_init_tree_desc() function (thanks to Stephen Boyd),
- patch 1/7 was added to only accept soft reset when not in a working tree;
this makes the test suite pass,
- the commit message of patch 4/7 that adds the --keep option has been
improved; it talks more about the use case of this new option.

Christian Couder (6):
  reset: do not accept a mixed reset in a .git dir
  reset: add a few tests for "git reset --merge"
  reset: add option "--keep" to "git reset"
  reset: add test cases for "--keep" option
  Documentation: reset: describe new "--keep" option
  Documentation: reset: add some tables to describe the different
    options

Stephan Beyer (1):
  reset: use "unpack_trees()" directly instead of "git read-tree"

 Documentation/git-reset.txt |   79 +++++++++++++++++++++-
 builtin-reset.c             |   74 +++++++++++++++-----
 t/t7103-reset-bare.sh       |    4 +-
 t/t7110-reset-merge.sh      |  156 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 292 insertions(+), 21 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh
