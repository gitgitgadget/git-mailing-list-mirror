From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking branches
Date: Thu, 8 May 2008 10:13:31 +0200
Message-ID: <20080508081331.GC302@diana.vm.bytemark.co.uk>
References: <20080508013956.GA24956@midwinter.com> <20080508015806.GA759@pe.Belkin> <064B1E1A-9C5C-49A4-AD08-0397FE4C517E@midwinter.com> <20080508022504.GA931@pe.Belkin> <20080508073851.GA302@diana.vm.bytemark.co.uk> <20080508074332.GB302@diana.vm.bytemark.co.uk> <604A38BB-E6A4-4303-BD7C-BF2968B6828D@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu May 08 10:14:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju1Gt-0008W1-13
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 10:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbYEHINp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2008 04:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbYEHINo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 04:13:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1248 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYEHINl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 04:13:41 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ju1Fr-0000Pc-00; Thu, 08 May 2008 09:13:31 +0100
Content-Disposition: inline
In-Reply-To: <604A38BB-E6A4-4303-BD7C-BF2968B6828D@midwinter.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81517>

On 2008-05-08 00:58:48 -0700, Steven Grimm wrote:

> On May 8, 2008, at 12:43 AM, Karl Hasselstr=F6m wrote:
>
> > Or even _only_ pull from the git repo. That repo would have to
> > have some kind of hook to make sure that it's always up-to-date,
> > then -- just a cron job won't do -- but I'm sure that can be done.
>
> If you control both the svn repo and the git repo, you can get close
> to that with an svn commit trigger, but even then there'll be a race
> condition when you want to dcommit. You either have to be able to
> pull from the svn repo when you want to dcommit, or you have to live
> with the possibility of a dcommit failing because you don't actually
> have the most recent rev locally.

I don't see why this has to be the case. Surely, if the local git repo
can dcommit without races by importing new revisions from svn, the
local git repo could dcommit without races by importing new revisions
from svn via an intermediate git repo. This would require the
intermediate repo to import new revisions when it gets a pull request,
but surely that should be doable with a pre-pull hook?

> This ties a bit into the patch I sent a few months back to allow
> update hooks to change refs. I kind of ran out of spare time to
> iterate more on that back then, but the ultimate goal there was that
> you could interact only with the bridge repo, never directly with
> svn, and the bridge repo would dcommit for you when you pushed to
> it.

I guess that approach is what I'd really like to see, since that's the
only one that can guarantee that every git clone of the svn repository
is identical.

=46urthermore, in this setup the clients wouldn't need to run git-svn a=
t
all. Only the bridge would need it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
