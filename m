From: David Kastrup <dak@gnu.org>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Thu, 12 Jul 2007 09:51:32 +0200
Message-ID: <86sl7u12m3.fsf@lola.quinscape.zz>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com> <Pine.LNX.4.64.0707111807470.4516@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 09:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8tSp-0003x3-8t
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 09:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758369AbXGLHvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 03:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758157AbXGLHvs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 03:51:48 -0400
Received: from main.gmane.org ([80.91.229.2]:42744 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758142AbXGLHvr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 03:51:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8tSf-0002UW-TS
	for git@vger.kernel.org; Thu, 12 Jul 2007 09:51:42 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 09:51:41 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 09:51:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:5WYFhA6VQvQrbRMpJfZfiBhyM4U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52254>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 11 Jul 2007, Wincent Colaiuta wrote:
>
>> [describes the typical CDPATH problem]
>
> You exported CDPATH.  You're guaranteed to run into problems with that.  I 
> doubt that your patch catches all problems in git, and even if we tried to 
> avoid breakage, you can only do so much about that.
>
> It is _wrong_ to export CDPATH.

But it is not our job to educate people about that.  So I'd just add
something like

[ "X" = "X$CDPATH" ] || unset CDPATH # ignore braindamaged exports

to the top of possibly affected scripts and be done.

After the first few dozen bug reports (which are just the tip of an
iceberg of people who say "git is crap and fails in strange ways") you
just recognize that you should just make that somebody else's problem.

I've done my fair amount of such educational tasks myself with
packages of mine.  It just gets you annoyed more and more each time,
it is tedious, it gets people get a bad opinion of both your software
_and_ your person (try being friendly after the 20th actually
technically completely unnecessary such request, while basically
explaining that you won't fix it because it is a Darwinian trap for
stupid people and you want evolution to run its course).

A one-liner that makes this somebody else's problem (if at all) is
worth its weight in gold.

Trust me on that.

My personal lowlight in that area are dozens of university and company
document classes derived from some old AMSLaTeX class in prehistoric
times that redefined \endfigure in a way incompatible with quite a few
packages.  Among them preview.sty written by me.

After about 5 bug reports about 5 different classes, explaining what
was wrong and why it broke quite a few packages, not just
preview-latex, and how people should fix it and how they should
complain to the people giving them the package...  preview.sty just
patches the problematic definitions if it has a reasonable guess that
they are in place, and blows out a stern and verbose warning
explaining where to complain and why.

Of course, nobody ever does.

Don't educate people.  Just don't trigger their problems.  Of course,
there are millions of ways of shooting oneself in the foot, but in
this case the same foot has been hit several times already.

-- 
David Kastrup
