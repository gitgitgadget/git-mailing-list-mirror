From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] Sequencer: working around historical mistakes
Date: Sat,  5 Nov 2011 21:59:41 +0530
Message-ID: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 05 17:31:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMj9l-0005Gc-J5
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 17:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab1KEQbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 12:31:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57013 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab1KEQbk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 12:31:40 -0400
Received: by ywf7 with SMTP id 7so3621338ywf.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=zaal/JtTwhDCg+cxf9MWplluyI09rZ3Q3r7qVs06RkQ=;
        b=X7gYw+cI9xgJz80/F8Af1CsDqwrwC9U9lB/nCJI8HAN3Ilp6sTJdYwJgrInR152mlt
         sx+DfuRibRUzyEE4yhUWxndNStOtM6ZXhvFPEHtj6aAL77/U5/UIrH4CyYkDCI0k95nD
         yrmJvpnXi3HkEegJXvGwkJpJL28vSxxJauaqs=
Received: by 10.42.137.6 with SMTP id w6mr27436933ict.5.1320510699343;
        Sat, 05 Nov 2011 09:31:39 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id p10sm19248815pbd.15.2011.11.05.09.31.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 09:31:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184859>

Hi,

As described in the discussion following $gmane/179304/focus=179383,
we have decided to handle historical hacks in the sequencer itself.
This series that follows is one step in the right direction.

- Part 1/5 makes the gigantic move required to create the sequencer.
If you need an excuse to celebrate, wait till this gets merged :)
- Part 5/5 can be considered as the "ultimate objective" of the
series.  I first wrote this part, and then wrote the other parts to
make tests pass.
- Parts 3/5 and 4/5 are ugly!  Causes heartburn.

Immediate shortcomings of this iteration:
1. No tests yet.  I want to see if it's possible to make this less
ugly first.
2. This series depends on rr/revert-cherry-pick, but doesn't apply to
the current 'next'- sorry, rebasing is a massive pita due to 1/5.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (5):
  sequencer: factor code out of revert builtin
  sequencer: remove CHERRY_PICK_HEAD with sequencer state
  sequencer: sequencer state is useless without todo
  sequencer: handle single commit pick separately
  sequencer: revert d3f4628e

 builtin/revert.c                |  821 +--------------------------------------
 sequencer.c                     |  832 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h                     |   26 ++
 t/t3510-cherry-pick-sequence.sh |   24 --
 4 files changed, 847 insertions(+), 856 deletions(-)

-- 
1.7.6.351.gb35ac.dirty
