From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH 0/5] Some preliminary work based on sequencer-stable
Date: Wed, 10 Aug 2011 15:25:46 +0530
Message-ID: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 10 11:58:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qr5Yw-0001g7-2p
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 11:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab1HJJ6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 05:58:52 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61802 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab1HJJ6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 05:58:52 -0400
Received: by pzk37 with SMTP id 37so1583833pzk.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=mQ6AThfSCh3ko0nVaypyvNtr9jZfhwkOaeLfZ0UYV9Y=;
        b=escZjmcWDaDaUaneVlMmh/nxBOkVjI0FFXDvjxvPFuEqAkvG/hU65fDzSENgJs/NwA
         RVZpLPYZ0ukfAGCqIbHIyClIABBhzhQD4cPXZJHNnAe4f+RxR0mCGkwyvvT49cSzikoV
         F+hfL1e+dtpqp7300InTD3+MnJ1hgjqMr5lak=
Received: by 10.142.9.2 with SMTP id 2mr92986wfi.305.1312970331583;
        Wed, 10 Aug 2011 02:58:51 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id s7sm725394pbj.69.2011.08.10.02.58.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 02:58:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179057>

Hi,

The series is quite unpolished at the moment, but I'm sending it to
the list because I want early feedback before I make mypoic decisions
and waste work.  Tests and rough commit messages included :)

The first patch is something I should've done earlier -- it makes
debugging much easier.  Should it go into maint? The last patch is the
most important, and everything else is just building towards it.  With
this series, we should now be able to abort at the last-but-one
commit, since 'git commit' actually cleans up the sequencer state now.

Note: All the SHA-1 references in the commit messages will change
after sequencer-stable is merged.  I hope it's clear for the moment.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (5):
  revert: Don't remove the sequencer state on error
  sequencer.h: Move data structures
  revert: Allow mixed pick and revert instructions
  sequencer: Expose code that handles files in .git/sequencer
  sequencer: Remove sequencer state after final commit

 builtin/commit.c                |    5 +
 builtin/revert.c                |  417 +++------------------------------------
 sequencer.c                     |  323 ++++++++++++++++++++++++++++++
 sequencer.h                     |   53 +++++
 t/t3510-cherry-pick-sequence.sh |   62 ++++++-
 5 files changed, 471 insertions(+), 389 deletions(-)

-- 
1.7.6.351.gb35ac.dirty
