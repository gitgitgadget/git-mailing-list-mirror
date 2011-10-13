From: Brad King <brad.king@kitware.com>
Subject: [PATCH 0/2] Do not search submodules in deep recursive merge
Date: Thu, 13 Oct 2011 08:59:03 -0400
Message-ID: <cover.1318509069.git.brad.king@kitware.com>
References: <7vipnu9hbj.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 15:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REL2R-0004ph-Cl
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab1JMNJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:09:12 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:57809 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755067Ab1JMNJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:09:10 -0400
Received: from vesper (vesper.kitwarein.com [192.168.1.207])
	by public.kitware.com (Postfix) with ESMTP id 60C313B2D7;
	Thu, 13 Oct 2011 08:59:07 -0400 (EDT)
Received: by vesper (Postfix, from userid 1000)
	id 981CD1331; Thu, 13 Oct 2011 08:59:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <7vipnu9hbj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183476>

On 10/12/2011 2:48 PM, Junio C Hamano wrote:
> [Stalled]
>
> * hv/submodule-merge-search (2011-08-26) 5 commits
>   - submodule: Search for merges only at end of recursive merge
>   - allow multiple calls to submodule merge search for the same path
>   - submodule: Demonstrate known breakage during recursive merge
>   - push: Don't push a repository with unpushed submodules
>   - push: teach --recurse-submodules the on-demand option
>   (this branch is tangled with fg/submodule-auto-push.)

AFAICT these two topics are tangled due revision traversal interactions.
I've untangled the two "submodule:" commits from this stalled topic and
rebased on master (34c4461a) resolving one conflict.

The first commit demonstrates a bug: submodule merge search occurs
multiple times for the same path during a recursive merge and fails the
second time.  The second commit fixes it by performing the merge search
only at depth 0 recursion.  These changes are independent from the
actual merge search and revision traversal logic.

Brad


Brad King (2):
  submodule: Demonstrate known breakage during recursive merge
  submodule: Search for merges only at end of recursive merge

 merge-recursive.c          |    6 +++-
 submodule.c                |    6 ++++-
 submodule.h                |    2 +-
 t/t7405-submodule-merge.sh |   51 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 4 deletions(-)

-- 
1.7.5.4
