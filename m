From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/2] fix cases of rebase -i ignoring core.commentchar
Date: Sun, 18 Aug 2013 13:12:48 -0400
Message-ID: <1376845970-31204-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 19:13:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB6XR-0006ON-KZ
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 19:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab3HRRNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 13:13:09 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:57257 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab3HRRNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 13:13:08 -0400
Received: by mail-oa0-f52.google.com with SMTP id n12so4291504oag.25
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JSZq6fOu09Gc8h80AfhYLfj0tLGKL/l6E73HPJ8exFw=;
        b=VHvrbaALZWwvRidc8kXDWDrluBFnXhpDM81cH5d1nfJ8Jlcd+4Jn2so8gdhlilYbuP
         PQ5k7JGYlRZtEMkI+O84DHUwKWQthKDDo3IKOKR7HbRJurNgPvxx4xy7eN1HR//DY+jK
         0LlPgbzfQ98xBawnJmxRTEKvgTS/aGdAESlwIzD2q+yW/5Ykk3+NedMuv5rx7s1p4i8p
         isIxUiTev9yX6qw2P6VDs7Fu+J9wYKYXmTk/qIrrqZDtR74yDA8mucQ+oSwFAMwg3XP0
         XymD43TsQ9BMRC8VlYQZV92LPC0zBVLfP1L4/M39iR07JuLukzTGLtJdw/AezGW8Km3y
         tkPw==
X-Received: by 10.182.131.196 with SMTP id oo4mr1932807obb.50.1376845987662;
        Sun, 18 Aug 2013 10:13:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id uz16sm9244405obc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 10:13:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.500.gc3113b0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232482>

This is a reroll of [1] which fixes a couple cases where rebase -i
ignores core.commentchar. One case was an oversight from the original
patch which added core.commentchar support to rebase -i, and is already
in 'maint'. The other is a regression introduced by [2] which is still
in 'next'.

In this reroll, the single patch from v1 is split into two: patch 1/2 is
suitable for 'maint'; and patch 2/2 is for 'next'. There are no other
changes.

I wanted to add tests to t3404 for these bugs but couldn't figure out
how to do it using the external interface of rebase -i. I was able to
verify before and after behavior by adding temporary echo's to the code
in order to observe the "internal" functioning.

[1]: http://git.661346.n2.nabble.com/PATCH-rebase-i-fix-cases-ignoring-core-commentchar-td7593965.html
[2]: http://git.661346.n2.nabble.com/PATCH-0-3-fix-interactive-rebase-short-SHA-1-collision-bug-td7593673.html#a7593676

Eric Sunshine (2):
  rebase -i: fix skip_unnecessary_picks() to respect core.commentchar
  rebase -i: fix core.commentchar regression

 git-rebase--interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.4.rc3.500.gc3113b0
