From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of
 some adhocery
Date: Tue, 27 Jun 2006 01:21:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606270117470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com> 
 <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com>
 <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44A06A8D.7080202@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 27 01:23:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv0QP-0003mn-OE
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 01:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933238AbWFZXW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 19:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933236AbWFZXWI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 19:22:08 -0400
Received: from mail.gmx.net ([213.165.64.21]:15029 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933210AbWFZXVv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 19:21:51 -0400
Received: (qmail invoked by alias); 26 Jun 2006 23:21:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 27 Jun 2006 01:21:49 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
In-Reply-To: <44A06A8D.7080202@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22695>

Hi,

On Tue, 27 Jun 2006, Martin Langhoff (CatalystIT) wrote:

> > > There is something strange though. I have a repo with ~150 pending patches
> > > to push, of which git-cherry spots ~100 as already merged upstream. So the
> > > old git-format-patch.sh would spit 50 patches, and the initial C version
> > > would do 150.
> > > 
> > > Now this version gives me 50 patches, regardless of
> > > --ignore-if-in-upstream. Is that expected?
> > 
> > 
> > Hell, no! Something is really wrong there.
> > 
> > What does "git-rev-list their..my | wc" say?
> 
> Ok, I cooked the numbers up a bit, it was 60 total, with 10 merged upstream.
> Here's what I have today:
> 
>   $ git-cherry svnhead..master | grep -c '+'
>   52
>   $ git-rev-list svnhead..master  | wc -l
>   61
> 
>   $ ~/local/git/git-format-patch.sh  -o .patchesold svnhead master
>   ...
>   $ ls .patchesold | wc -l
>   52
> 
>   $ ~/local/git/git format-patch  -o .patchesnewall svnhead..master
>   ...
>   $ ls .patchesnewall/ | wc -l
>   53

That is very, very strange. One more! Do you have any idea which patch it 
is (53 being one more than 52 I suspect there is one slipping through)?

>   $ ~/local/git/git format-patch --ignore-if-in-upstream -o .patchesnewignore
> svnhead..master
>   ...
>   $ ls .patchesnewignore | wc -l
>   52

Could it be that the other patches are merges? format-patch _must_ ignore 
these.

> This is a public repo --
> 
> master tracks origin which is
> http://git.catalyst.net.nz/git/elgg-r2.git#nzvleportfolio
> 
> svnhead is
> http://git.catalyst.net.nz/git/elgg-r2.git#svnhead

Even if I do not use cogito, I will fetch them. However, that must wait 
for tomorrow, as I can no longer keep awake.

Ciao,
Dscho "where do you put the middle name if your nick is only one word?"
