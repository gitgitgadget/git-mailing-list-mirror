From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: cg switch -l doesn't work when branches point to the same commit
Date: Wed, 11 Jul 2007 08:59:57 -0400
Message-ID: <f158199e0707110559q43c290b4x2caee13cac46cf29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 15:00:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8bnZ-0007cJ-Gr
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 15:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbXGKNAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 09:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756642AbXGKNAA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 09:00:00 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:6279 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757944AbXGKM77 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 08:59:59 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1168744ika
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 05:59:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZU1NLG9noiWo7H3hQG4shDJCCuHGdRQ0Z24go6SWjgXTfoUQ/Fpr3Ra9esCAadYOlgRE24yOpWU9RFKu0NbpUfrbVqnoP5282sz5uEGwzREWmc0PO8N9V1TTmW186Wf4UK1xfD1yFwk9XLj1O2YvKhJBMlbPyLRIT+v1twgcEkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jkJ3drPAqkH7wmO99Ojt4RGROKQqIvobYg/nKA2eI8/y54lfSHnr7Hyb3pE1HFhFn3yt3vy7LLIMS/3X4Gga/Gson0tQ+XG1ssNeMqtgodiSiFx2X4FzwjzGGVSoMguUsYHZZj5ez5WVZwddWni/Fb9mzRbMCVakrgyp4x29qME=
Received: by 10.78.180.16 with SMTP id c16mr2406918huf.1184158797630;
        Wed, 11 Jul 2007 05:59:57 -0700 (PDT)
Received: by 10.78.178.10 with HTTP; Wed, 11 Jul 2007 05:59:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52158>

The message below applies to software versions:

git version 1.4.4.2
cogito-0.18.2

Why doesn't cg switch -l save local changes when you switch to a
branch that points at the same commit you're already on?  Here's the
case I ran into.

1. On my master branch I was part of the way through making a fairly
complex change when I discovered an unrelated bug.  So, I wanted to:
     a. move my partial changes to a topical branch
     b. fix the bug on master
     c. finish my changes on the topical branch
     d. merge the topical branch back into master

2. I didn't really want to _commit_ my partial changes yet, though,
because I was really in mid-thought there, so I wanted to do it this
way:

# create the topical branch, carrying my local changes along with me
cg switch -c topical-branch
# switch back to master, leaving my local changes with the topical branch
cg switch -l master
# fix bug on master then
cg commit
# switch back to topical branch
cg switch topical-branch
# continue with changes and eventually
cg commit
cg switch master
cg merge topical-branch

Unfortunately, I found that 'cg switch -l master' did NOT save my
local changes.  I had to switch back to the branch, commit my partial
changes, then back to master to fix the bug.  So, I was able to work
around this, but I still found the behavior surprising.  If this is
expected behavior, shouldn't it be documented in the cg-switch man
page?

BTW, in a test repository/working directory I was able to confirm that
cg switch -l worked as documented when the two branches involved
pointed to different commits.

Thanks,

Bradford C. Smith
