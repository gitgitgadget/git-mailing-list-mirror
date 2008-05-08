From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking branches
Date: Thu, 8 May 2008 00:58:48 -0700
Message-ID: <604A38BB-E6A4-4303-BD7C-BF2968B6828D@midwinter.com>
References: <20080508013956.GA24956@midwinter.com> <20080508015806.GA759@pe.Belkin> <064B1E1A-9C5C-49A4-AD08-0397FE4C517E@midwinter.com> <20080508022504.GA931@pe.Belkin> <20080508073851.GA302@diana.vm.bytemark.co.uk> <20080508074332.GB302@diana.vm.bytemark.co.uk>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu May 08 09:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju12Y-0003I7-GF
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 09:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYEHH6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2008 03:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbYEHH6v
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 03:58:51 -0400
Received: from tater.midwinter.com ([216.32.86.90]:32970 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752710AbYEHH6t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 03:58:49 -0400
Received: (qmail 17560 invoked from network); 8 May 2008 07:58:49 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=f1G1gPearqwznxHcLp+JbyRhZQodiZqI1uUC1WTmVMOE3xfMHNY6zFU+AEqEqZO5  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 8 May 2008 07:58:49 -0000
In-Reply-To: <20080508074332.GB302@diana.vm.bytemark.co.uk>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81515>

On May 8, 2008, at 12:43 AM, Karl Hasselstr=F6m wrote:
> Or even _only_ pull from the git repo. That repo would have to have
> some kind of hook to make sure that it's always up-to-date, then --
> just a cron job won't do -- but I'm sure that can be done.

If you control both the svn repo and the git repo, you can get close =20
to that with an svn commit trigger, but even then there'll be a race =20
condition when you want to dcommit. You either have to be able to pull =
=20
from the svn repo when you want to dcommit, or you have to live with =20
the possibility of a dcommit failing because you don't actually have =20
the most recent rev locally.

This ties a bit into the patch I sent a few months back to allow =20
update hooks to change refs. I kind of ran out of spare time to =20
iterate more on that back then, but the ultimate goal there was that =20
you could interact only with the bridge repo, never directly with svn, =
=20
and the bridge repo would dcommit for you when you pushed to it.

The approach in this thread's patch is maybe not as conceptually =20
clean, but it's much simpler and (apparently) less controversial.

-Steve