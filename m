From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/3] automatically skip away from broken commits
Date: Fri, 05 Jun 2009 06:10:40 +0200
Message-ID: <20090605040238.8885.92790.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 06:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCQnK-0001a8-Dv
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 06:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbZFEEM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 00:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbZFEEM0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 00:12:26 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:55598 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbZFEEM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 00:12:26 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id EB63D4B0063;
	Fri,  5 Jun 2009 06:12:19 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id CAB264B0070;
	Fri,  5 Jun 2009 06:12:16 +0200 (CEST)
X-Mailer: git-mail-commits v0.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120736>

This patch series makes "git bisect skip" skip away from an area where
the commits cannot be tested.

This is done automatically. The user has nothing todo. We alternatively
try to test commits 20%, 40% and 60% away from the optimal commit that
has been skipped.

  bisect: add parameters to "filter_skipped"
  bisect: when skipping, choose a commit away from a skipped commit
  t6030: test skipping away from an already skipped commit

 bisect.c                    |   77 ++++++++++++++++++++++++++++++++++++++++--
 bisect.h                    |    4 ++-
 builtin-rev-list.c          |    4 ++-
 t/t6030-bisect-porcelain.sh |   12 +++++++
 4 files changed, 91 insertions(+), 6 deletions(-)
