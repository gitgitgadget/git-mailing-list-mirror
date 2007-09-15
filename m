From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: db/fetch-pack topic (was: What's cooking in git.git (topics))
Date: Sat, 15 Sep 2007 03:47:59 -0400
Message-ID: <20070915074759.GA3099@spearce.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <20070914183028.GV3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 09:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWSNu-0008MA-LK
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 09:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbXIOHsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 03:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbXIOHsF
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 03:48:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36408 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbXIOHsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 03:48:04 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWSNj-0007Le-VZ; Sat, 15 Sep 2007 03:48:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0B57D20FBAE; Sat, 15 Sep 2007 03:48:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070914183028.GV3099@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58229>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > * db/fetch-pack (Fri Sep 14 03:31:25 2007 -0400) 22 commits
> ...
> > This is Daniel's fetch-pack in C plus fixups from Shawn.
> > Unfortunately the fixups breaks t3200 ("*** glibc detected ***
> > fetch: free(): invalid pointer xxx ***"), which I haven't looked
> > into yet.
> 
> Doesn't crash out on my Mac OS X system but I am getting the
> above failure on my amd64 Linux system.

OK, so in addition to the above fixups Junio mentions I have
also sent two more series today:

  2 patch "fixup of the fixup" to resolve the t3200 crash
  5 patch "fixup + cleanup" of http support

and now I just discovered that pushing to yourself is probably also
broken by this series:

  $ git push . jc/maint:gfi-maint
  updating 'refs/heads/gfi-maint' using 'refs/remotes/jc/maint'
    from 05cc2ffc572f05e8aeec495a9ab9bc9609863491
    to   8419d2ee9ba8b375186a5c1019df8dfbce610aba
  Also local refs/heads/gfi-maint
  Generating pack...
  Done counting 0 objects.
  Writing 0 objects...
  Unpacking 0 objects...
  error: Ref refs/heads/gfi-maint is at 8419d2ee9ba8b375186a5c1019df8dfbce610aba but expected 05cc2ffc572f05e8aeec495a9ab9bc9609863491
  error: failed to lock refs/heads/gfi-maint
  Total 0 (delta 0), reused 0 (delta 0)
  ng refs/heads/gfi-maint failed to lock
  error: failed to push to '.'

What's really exciting is we actually updated the ref 'gfi-maint',
even though it was "ng" and we failed to push.  Yup.  More work
for me to look at tomorrow.  Right now I think I'm all memory
corruptioned out for *** brain detected *** Shawn(): nextword():
too tired, try sleep ***

;-)

-- 
Shawn.
