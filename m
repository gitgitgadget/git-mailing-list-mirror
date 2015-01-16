From: Andreas Krey <a.krey@gmx.de>
Subject: Regarding the determinacy of 'git describe'
Date: Fri, 16 Jan 2015 14:01:13 +0100
Message-ID: <20150116130113.GA3220@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 14:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC6Wf-0006Hd-BE
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 14:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbbAPNBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 08:01:17 -0500
Received: from continuum.iocl.org ([217.140.74.2]:57849 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbAPNBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 08:01:16 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t0GD1Dw03800;
	Fri, 16 Jan 2015 14:01:13 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262549>

Hi all again,

today another expectation crumbled.

I expected the algo of 'git describe' to be deterministic,
but it happens to return different tags in structurally
identical repositories. These are generated on each run
of a test (and obviously have different dates and thus
commit IDs), and 'git describe' doesn't return the same
tags in all of them.

Is that expected behaviour?

The repos each look like
(commit id and parents truncated to three chars):

538 26d 8f5         (HEAD, origin/r2.4/feature-2, r2.4/feature-2) Merge branch 'r2.4/master' into r2.4/feature-2
    26d         20c feature: 1st part
        8f5 ac6     (origin/r2.4/master, origin/HEAD, r2.4/master) main: 3rd commit
            ac6 20c (tag: r2.4/bl-1) main: 2nd commit
                20c (tag: r2.4/bl-0, origin/sidestep) module: initial

So HEAD is two hops away from both tags (bl-0 via 26d and bl-1 via 8f5),
but for one I'd hoped that it always pick bl-1, and especially I'd expect
it to be consistent for a given structure).

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
