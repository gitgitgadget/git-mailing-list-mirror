From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/5] add a --strategy option to "git cherry-pick"
Date: Wed, 31 Mar 2010 21:22:03 +0200
Message-ID: <20100331192014.5827.90637.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:45:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx6fN-0003AX-Fo
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282Ab0CaWpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 18:45:36 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:52996 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505Ab0CaWpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 18:45:34 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B135A818039;
	Thu,  1 Apr 2010 00:45:26 +0200 (CEST)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8FE4381806B;
	Thu,  1 Apr 2010 00:45:23 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143699>

The purpose of this series is to make it possible to test how "git cherry-pick"
would work with another merge strategy than the recursive one.

Junio suggested:

"It might not be a bad idea to teach a hidden primarily-for-debugging
option to "cherry-pick" to let it use resolve instead of recursive for
cases like this."

The changes since the previous RFC version are the following:

- the commit messages of the first 2 patches have been improved a little,
- some calls to free_commit_list() have been added to the last patch,
- the series was rebased recently on top of next.

Christian Couder (5):
  revert: use strbuf to refactor the code that writes the merge message
  revert: refactor merge recursive code into its own function
  merge: refactor code that calls "git merge-STRATEGY"
  merge: make function try_merge_command non static
  revert: add "--strategy" option to choose merge strategy

 builtin/merge.c   |   81 +++++++++++++-----------
 builtin/revert.c  |  179 +++++++++++++++++++++++++++++++----------------------
 cache.h           |    3 -
 merge-recursive.h |    4 +
 4 files changed, 154 insertions(+), 113 deletions(-)
