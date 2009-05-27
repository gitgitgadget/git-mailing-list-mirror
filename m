From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/2] Avoid forking a process when checking merge bases
Date: Wed, 27 May 2009 07:09:40 +0200
Message-ID: <20090527050656.3694.86787.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 07:13:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9BRm-0002xG-Sh
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 07:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758219AbZE0FMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 01:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbZE0FMr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 01:12:47 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:50149 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbZE0FMq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 01:12:46 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 6AFE34B00AE;
	Wed, 27 May 2009 07:12:41 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 4A9C84B00AC;
	Wed, 27 May 2009 07:12:39 +0200 (CEST)
X-Mailer: git-mail-commits v0.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120028>

The goal of this patch series is to check if good revisions are
ancestor of the bad revision without forking a process to launch
"git rev-list $good ^$bad".

This new version of this patch series does not use an "unparse_commit"
function anymore, we use "clear_commit_marks" instead.

  bisect: rework some rev related functions to make them more reusable
  bisect: check ancestors without forking a "git rev-list" process

 bisect.c                    |   79 +++++++++++++++++++-----------------------
 t/t6030-bisect-porcelain.sh |   13 +------
 2 files changed, 37 insertions(+), 55 deletions(-)
