From: Jehan Bing <jehan@orb.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 06 Apr 2012 11:01:31 -0700
Message-ID: <jlnb1k$rdn$1@dough.gmane.org>
References: <7vbonfqezs.fsf@alter.siamese.dyndns.org> <20120329221154.GA1413@sigill.intra.peff.net> <7vfwcqq2dw.fsf@alter.siamese.dyndns.org> <20120330071358.GB30656@sigill.intra.peff.net> <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr> <20120405131301.GB10293@sigill.intra.peff.net> <vpqwr5uceis.fsf@bauges.imag.fr> <20120406071520.GD25301@sigill.intra.peff.net> <vpqr4w12tjj.fsf@bauges.imag.fr> <20120406080004.GA27940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 20:01:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGDTu-0001Cz-U6
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 20:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757563Ab2DFSBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 14:01:50 -0400
Received: from plane.gmane.org ([80.91.229.3]:49118 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708Ab2DFSBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 14:01:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SGDTk-000174-4K
	for git@vger.kernel.org; Fri, 06 Apr 2012 20:01:44 +0200
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 20:01:44 +0200
Received: from jehan by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 20:01:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120406080004.GA27940@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194888>

On 2012-04-06 01:00, Jeff King wrote:
> On the other hand, one thing we have not talked about is how one gets
> into the "topic push fast-forwards master" situation. Which is running:
>
>   $ git checkout -b topic origin/master

That's what I was starting to think myself. This whole discussion about 
"current" is that it may not a good choice because "push" will not 
behave like "pull". But I believe the real problem is that _pull_ 
doesn't behave like _push_.

In other word, maybe "git checkout -b topic origin/master" shouldn't 
create a tracking branch in the first place (unless one uses "--track" 
or that some config setting has been explicitly set).
Or more precisely, I believe it should be create a tracking branch only 
if the local branch name is the same as the remote's branch.
(And the same for "git branch <local> origin/<remote>" of course)

How many newbies/clueless people will think that a branch "topic" tracks 
a branch "origin/master"? And how many of these same people will think 
that a branch "topic" doesn't track a branch "origin/topic"? For that 
matter, that's how I use git myself. And until it's easy to see what 
branch tracks what (i.e. until "git branch" shows the tracking 
branches), I don't want to think differently because it's just too risky.

So for the "me too" votes:
- +1 to change change "push.default" to current
- +1 to change "git checkout -b" to not create a tracking branch unless 
the local name matches the remote name .
