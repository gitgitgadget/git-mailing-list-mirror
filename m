From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Let "git svn" run "git gc --auto" occasionally
Date: Sat, 19 Jan 2008 19:37:37 -0800
Message-ID: <20080120033737.GA7767@soma>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk> <20080119223249.8227.31460.stgit@yoghurt> <1200783050.5724.196.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 04:38:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGR0b-0007L8-7f
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 04:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbYATDhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 22:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYATDhk
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 22:37:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:48176 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbYATDhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 22:37:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 42E152DC08B;
	Sat, 19 Jan 2008 19:37:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1200783050.5724.196.camel@brick>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71154>

Harvey Harrison <harvey.harrison@gmail.com> wrote:
> On Sat, 2008-01-19 at 23:36 +0100, Karl Hasselstr=F6m wrote:
> > Let "git svn" run "git gc --auto" every 100 imported commits, to
> > reduce the number of loose objects.
>=20
> I found 100 was a bit too low when doing some large repos, I've
> been using 1000.  I'd argue that --repack=3D1000 should be done by
> default.

I've found 100 for repack too low in the past, too, which is why
repack defaults to 1000 if no number is specified.  I think it
should hold for gc --auto, too.

> > I'm not quite sure how this should interact with the --repack flag.
> > Right now they just coexist, except for never running right after o=
ne
> > another, but conceivably we should do something cleverer. Eric?

I consider --repack is out-of-date now that we have gc --auto.  I'm in
favor of ripping out repack support in git-svn and just using gc --auto=
=2E

> How about git gc always gets run at the very end of a git svn fetch?

I'd much prefer that we run gc --auto at the end of every fetch instead
of doing so randomly for small fetches.

--=20
Eric Wong
