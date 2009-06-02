From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/4] make it possible to skip away from broken commits
Date: Tue, 02 Jun 2009 22:16:29 +0200
Message-ID: <20090602200731.3630.33652.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:18:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBaRd-0008Np-I0
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 22:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbZFBURg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 16:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754961AbZFBURf
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:17:35 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:44215 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755095AbZFBURe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:17:34 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 3027F9401E1;
	Tue,  2 Jun 2009 22:17:27 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id E2EF2940150;
	Tue,  2 Jun 2009 22:17:24 +0200 (CEST)
X-Mailer: git-mail-commits v0.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120542>

This patch series adds a "--ratio=x/y" option to "git bisect skip" so
that it is possible to skip away from an area were the commits cannot
be tested.

Note that in this series "--ratio=4" means the same as "--ratio=1/4".
But I am not sure if this shortcut is worth it.

After this series I plan to implement a similar "--skip-ratio" option
that can be passed to "git bisect start" and to add some documentation.

  bisect: add parameters to "filter_skipped"
  bisect: use the skip ratio to choose a commit away from a skipped
    commit
  bisect: add "--ratio=<ratio>" option to "git bisect skip"
  t6030: add test case for "git bisect skip --ratio=x/y"

 bisect.c                    |   74 ++++++++++++++++++++++++++++++++++++++++--
 bisect.h                    |    4 ++-
 builtin-rev-list.c          |    4 ++-
 git-bisect.sh               |   37 ++++++++++++++-------
 t/t6030-bisect-porcelain.sh |   12 +++++++
 5 files changed, 112 insertions(+), 19 deletions(-)
