From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Thu, 15 Nov 2007 00:28:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711150018160.4362@racer.site>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br>
 <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com>
 <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr>
 <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <87myth58r5.fsf@osv.gnss.ru>
 <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org> <18235.22445.16228.535898@lisa.zopyra.com>
 <Pine.LNX.4.64.0711142047170.4362@racer.site> <18235.34578.886521.944550@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:29:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsSbR-0000mB-Kc
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 01:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817AbXKOA2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 19:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756640AbXKOA2t
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 19:28:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:42295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755892AbXKOA2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 19:28:48 -0500
Received: (qmail invoked by alias); 15 Nov 2007 00:28:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 15 Nov 2007 01:28:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sNncANXCsavYyhT0wUzr+AnIfUPoWMeS4knS0rU
	T/aoQ/ayP2QYs7
X-X-Sender: gene099@racer.site
In-Reply-To: <18235.34578.886521.944550@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65030>

Hi,

On Wed, 14 Nov 2007, Bill Lear wrote:

> On Wednesday, November 14, 2007 at 20:58:29 (+0000) Johannes Schindelin writes:
> >...
> >I have a better idea:
> >
> >[the initial import, on another machine:]
> >% mkdir new_repo
> >% cd new_repo
> >% git init
> >[add content]
> >% git commit -a -m "Initial stuff"
> >% git remote add origin git://host/repo
> >% git push origin master
> >
> >If you do not want to be bothered with setting up the default 
> >"remote" and "merge" config variables manually, it is reasonable to ask 
> >for support to do that in "git remote".
> 
> Um, ok, but the above means that this repo now differs from other
> repos, in that pushing now involves more than 'git push', i.e.,
> 'git push origin master'.

Nope.  That is necessary only for the initial push.

Remember: "git push" defaults to pushing to the remote "origin", and _all_ 
local branches which the remote knows about.

And the latter is the reason why the initial push needs a special 
handling: the local and the remote repository have no branches in common, 
because the remote one does not have _any_ branch yet!

So, once you pushed the initial push, you can drop the "origin master" 
from subsequent pushes!

> What's wrong with 'git init --mirror git://host/repo'?

It's highly unlikely that you have the same in mind as git when you say 
"--mirror" in this context.  Just have a look at git-push, which has 
recently acquired that option.

Besides, we really have "clone" for "init + fetch".

> >(I actually think that it is another example of cvs/svn damage, where 
> >you _need_ to clone first, or otherwise you will _never_ be able to 
> >commit to the repository.)
> 
> I think there is a tendency here to blame every shortcoming of git on 
> someone else's supposedly unsanitary past rather than facing up to 
> inherent problems in git itself.

I am not blaming here.  I just try to see where it comes from.

In git, all repositories are equal.  Provided you can connect two of them 
(or not even that; think of bundles), you can push back and forth between 
_all_ of them.

Since this is something I like about git, I had some problems finding out 
where this "I have to clone from the same repository I want to push to" 
idea comes from.

>  We have several very senior, very dedicated software developers who 
> LOVE git, and who loathe CVS, but who nevertheless find many vexing 
> issues in git.

And I am thankful that you bring up the vexing issues so that we can 
discuss (and hopefully fix) them.

> >BTW I am somewhat disgusted by your usage of git:// for pushing.
> 
> Whatever.  We went through this before on the list and push support was 
> added to git://.  We have SUCKY sysadmin support at our company and 
> permissions were getting HOSED using ssh pushes.  The git:// protocol 
> makes everything clean on the repo side and no nasty surprises with 
> permissions and no delays begging the support team to clean things up.

Hey, if it works for you, I am all the happier! (Of course, I am in a 
better position than you, here; I _am_ the sysadmin, and my ssh setup Just 
Works...)

Ciao,
Dscho
