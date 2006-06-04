From: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
Subject: Re: Importing Mozilla CVS into git
Date: Sun, 4 Jun 2006 21:44:45 +0200
Organization: Dewire
Message-ID: <200606042144.45385.robin.rosenberg.lists@dewire.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com> <e5u0o0$3rm$1@sea.gmane.org> <Pine.LNX.4.64.0606041050010.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 21:45:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmyX8-0006DV-2c
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 21:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWFDTpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Jun 2006 15:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWFDTpA
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 15:45:00 -0400
Received: from [83.140.172.130] ([83.140.172.130]:48203 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1750776AbWFDTpA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 15:45:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id C0FEF802655;
	Sun,  4 Jun 2006 21:43:34 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06360-05; Sun,  4 Jun 2006 21:43:34 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by torino.dewire.com (Postfix) with ESMTP id 248B9802652;
	Sun,  4 Jun 2006 21:43:31 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0606041050010.5498@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21279>

s=F6ndag 04 juni 2006 19:55 skrev Linus Torvalds:
> On Sun, 4 Jun 2006, Jakub Narebski wrote:
> > > And that shouldn't actually be that hard to do. The most trivial
> > > approach is to have just a pre-trigger on commits, but let's face=
 it,
> > > that would not be a good "full" solution. A better one is to just=
 make
> > > the whole "git update-index" thing just have a "automatically ign=
ore
> > > CR/LF" mode.
> >
> > Why wouldn't it be good solution?
>
> The pre-commit filter thing should work fine, and hey, maybe it's wor=
th
> doing that way. I just worry/think that it will result in tons of noi=
se
> when you do a "git diff" and "git update-index --refresh" on a file t=
hat
> has been changed, but then the change reverted.
>
> But I didn't really think it through very deeply, it was just an idle=
 "I
> think the pre-commit hook will fall down when X happens that is a
> non-commit event" thought. I suspect this is one of those things wher=
e
> somebody actually working in that kind of environment will figure out=
 what
> the problems are, and what the righ solution is.
>
> > BTW. wouldn't Mercurial encode/decode filters
> >
> >   http://www.selenic.com/mercurial/wiki/index.cgi/EncodeDecodeFilte=
r
> >
> > be a better solution than modifying files by "git update-index",
> > with all problems it can cause (not detected binary files, text fil=
es
> > which have to be in CR/LF line ending,...).
>
> Please do realize that the patch I sent out was absolutely _not_ mean=
t to
> be taken seriously. It was more a "somebody could try this in a windo=
ws
> environment, and if it works as an approach, we can try to do it righ=
t".

Other version control systems simply treat text and binary files differ=
ently.=20
No smart(ass) logic doing the wrong thing. A text file gets processed o=
n
check-in AND checkout depending on it's type and the client setting.
Some heuristics may be applied when adding files. i.e look-up according=
 to=20
magic cookies or looking for bytes that simply do not occur in text fil=
es=20
(e..g a nul byte).  Those few systems that I know about treat the type =
as a=20
file (as opposed to a version specific) attribute. Some systems have lo=
ts of=20
file types, not just text and binary. Encoding is about the only thing =
that=20
would interest me, although not terribly important (except the file nam=
e),=20
but that may be off topic for this thread.

The hash-on-the whole-tree might be a reason for making the attribute=20
version-specific.

Mercurial's filters sounds like a good way to implement file types in a=
=20
generic way as long as git's excellent performance isn't hurt.

> I'm absolutely _not_ suggesting merging that patch as-is or even in a=
ny
> form very close to it. It clearly needs a config file entry with file=
name
> patterns etc at a minimum.

Do people apply your patches right away, like it's some god-like comman=
dments?

-- robin
