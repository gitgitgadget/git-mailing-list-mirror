From: Max Kirillov <max@max630.net>
Subject: [PATCH 0/4] diff --cc: relax path filtering
Date: Thu,  2 Apr 2015 23:34:09 +0300
Message-ID: <1428006853-21212-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:34:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydlp3-0005Fi-W0
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 22:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbbDBUed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 16:34:33 -0400
Received: from p3plsmtpa09-09.prod.phx3.secureserver.net ([173.201.193.238]:52509
	"EHLO p3plsmtpa09-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751933AbbDBUeY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 16:34:24 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-09.prod.phx3.secureserver.net with 
	id B8aH1q00T5B68XE018aM7h; Thu, 02 Apr 2015 13:34:24 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266669>

For diff --cc, paths fitering used to select only paths which have
changed in all parents, while diffing itself output hunks which are
changed in as few as 2 parents.

Fix intersect_paths() to add paths which have at least 2 changed
parents.

Intersects with branch 'bc/object-id' which is not yet in master. This is
rebased on top of it.

Max Kirillov (4):
  Add test for showing discarded changes with diff --cc
  combine-diff.c: refactor: extract insert_path()
  diff --cc: relax too strict paths picking
  t4059: rewrite to be adaptive to hunk filtering

 combine-diff.c                  |  95 ++++++++++++++++++-----------
 t/t4059-diff-merge-with-base.sh | 132 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+), 34 deletions(-)
 create mode 100755 t/t4059-diff-merge-with-base.sh

-- 
2.3.4.2801.g3d0809b
