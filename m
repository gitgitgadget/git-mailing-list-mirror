From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Ignore merged status of the file-level merge
Date: Thu, 26 Apr 2007 21:13:49 +0200
Message-ID: <20070426191349.GA9964@steel.home>
References: <20070425200659.GA30061@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 21:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh9QN-0001x9-Qo
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031460AbXDZTOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031459AbXDZTNx
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:13:53 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:37629 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031460AbXDZTNv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:13:51 -0400
Received: from tigra.home (Faaeb.f.strato-dslnet.de [195.4.170.235])
	by post.webmailer.de (klopstock mo23) (RZmta 5.6)
	with ESMTP id B07471j3QIBC7x ; Thu, 26 Apr 2007 21:13:49 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9E53C277BD;
	Thu, 26 Apr 2007 21:13:49 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 55AA8BDDE; Thu, 26 Apr 2007 21:13:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070425200659.GA30061@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtopLFM0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45642>

as it is not relevant for whether the result should be written.
Even if no real merge happened, there might be _no_ reason to
rewrite the working tree file. Maybe even more so.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 094ac59..8f72b2c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1342,7 +1342,7 @@ static int process_renames(struct path_list *a_renames,
 				mfi = merge_file(o, a, b,
 						a_branch, b_branch);
 
-				if (mfi.merge && mfi.clean &&
+				if (mfi.clean &&
 				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
 				    mfi.mode == ren1->pair->two->mode)
 					/*
-- 
1.5.2.rc0.65.g92b0b
