From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/7] find commit subject refactoring
Date: Thu, 22 Jul 2010 15:18:28 +0200
Message-ID: <20100722131141.2148.63850.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 15:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obvuh-00053b-Lx
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 15:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759293Ab0GVNeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:34:09 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:56817 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779Ab0GVNeH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:34:07 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 4765080021D9;
	Thu, 22 Jul 2010 15:34:00 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 39C6A80021FE;
	Thu, 22 Jul 2010 15:34:00 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-203.w90-12.abo.wanadoo.fr [90.12.251.203])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 6A0C180021D9;
	Thu, 22 Jul 2010 15:33:55 +0200 (CEST)
X-ME-UUID: 20100722133356434.6A0C180021D9@mwinf2f18.orange.fr
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151448>

I found 4 different places where there was custom code to find the
subject (sometimes called title) of a commit in the commit buffer.
So the purpose of this series is to refactor this by using a
common function called find_commit_subject(), except for the first
patch that is bug fix.

Christian Couder (7):
  revert: fix off by one read when searching the end of a commit
    subject
  revert: refactor code to find commit subject in find_commit_subject()
  revert: rename subject related variables in get_message()
  commit: move find_commit_subject() into commit.{h,c}
  bisect: use find_commit_subject() instead of custom code
  merge-recursive: use find_commit_subject() instead of custom code
  blame: use find_commit_subject() instead of custom code

 bisect.c                     |   13 +++++--------
 builtin/blame.c              |   22 +++++++---------------
 builtin/revert.c             |   20 +++++---------------
 commit.c                     |   19 +++++++++++++++++++
 commit.h                     |    3 +++
 merge-recursive.c            |   14 ++++----------
 t/t3505-cherry-pick-empty.sh |   20 +++++++++++++++++++-
 7 files changed, 62 insertions(+), 49 deletions(-)

-- 
1.7.2.rc3.267.g400b3
