From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/3] automatically skip away from broken commits
Date: Sat, 06 Jun 2009 06:41:32 +0200
Message-ID: <20090606043853.4031.78284.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 06:44:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCnlI-0006bC-8T
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 06:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbZFFEns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 00:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbZFFEnr
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 00:43:47 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:45203 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbZFFEnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 00:43:47 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 5BFD5E08076;
	Sat,  6 Jun 2009 06:43:41 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 502E4E0805A;
	Sat,  6 Jun 2009 06:43:39 +0200 (CEST)
X-Mailer: git-mail-commits v0.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120869>

This patch series makes "git bisect skip" skip away from an area where
the commits cannot be tested.

This is done automatically. The user has nothing todo. We alternatively
try to test commits 20%, 40% and 60% away from the optimal commit that
has been skipped.

Some comments have been added and a left over from v1 has been removed
since v2, thanks to Junio.

  bisect: add parameters to "filter_skipped"
  bisect: when skipping, choose a commit away from a skipped commit
  t6030: test skipping away from an already skipped commit

 bisect.c                    |   88 +++++++++++++++++++++++++++++++++++++++++--
 bisect.h                    |    4 +-
 builtin-rev-list.c          |    4 +-
 t/t6030-bisect-porcelain.sh |   12 ++++++
 4 files changed, 102 insertions(+), 6 deletions(-)
