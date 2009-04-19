From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/5] port more "git bisect next" code to C
Date: Sun, 19 Apr 2009 11:55:34 +0200
Message-ID: <20090419115534.f0473356.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 11:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvTn7-0002Ej-6i
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 11:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbZDSJ4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 05:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbZDSJ4v
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 05:56:51 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:38606 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbZDSJ4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 05:56:50 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id BB5B2D48052;
	Sun, 19 Apr 2009 11:56:43 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with SMTP id AF291D480E4;
	Sun, 19 Apr 2009 11:56:40 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116886>

This patch series moves code from the "bisect_next" shell function
in "git-bisect.sh" to C code in "builtin-bisect--helper.c".

To do that a "--next-exit" option to "git bisect--helper" is
added, and is used instead of the "--next-vars" option in
"bisect_next".

  rev-list: make "estimate_bisect_steps" non static
  rev-list: refactor printing bisect vars
  bisect: move common bisect functionality in "bisect_common"
  bisect--helper: add "--next-exit" to output bisect results
  bisect: use "git bisect--helper --next-exit" in "git-bisect.sh"

 bisect.c                 |  127 +++++++++++++++++++++++++++++++++++++++++++---
 bisect.h                 |    7 +++
 builtin-bisect--helper.c |   12 +++-
 builtin-rev-list.c       |   63 ++++++++++++-----------
 git-bisect.sh            |   39 +++-----------
 5 files changed, 178 insertions(+), 70 deletions(-)
