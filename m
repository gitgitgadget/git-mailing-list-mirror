From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [jgit PATCH] Paper bag fix quoting for SSH transport commands
Date: Sun, 22 Jun 2008 18:15:45 -0400
Message-ID: <20080622221545.GF11793@spearce.org>
References: <20080622013640.GA18629@spearce.org> <200806221954.08919.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 00:17:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAXrs-0005af-GK
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 00:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbYFVWPv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 18:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbYFVWPv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 18:15:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38021 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbYFVWPu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 18:15:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAXqU-0003gj-Bp; Sun, 22 Jun 2008 18:15:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2C4B820FBAE; Sun, 22 Jun 2008 18:15:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200806221954.08919.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85808>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s=C3=B6ndagen den 22 juni 2008 03.36.40 skrev Shawn O. Pearce:
> >=20
> > Testing concludes that git-shell requires the command name to never
> > be quoted, and the argument name to always be single quoted.  As
> > this is a long-standing behavior in the wild jgit needs to conform,
> > as git-shell and all git-shell work-a-likes such as gitosis may be
> > following the same convention.
>=20
> Seems ok and works here. Error handling still has a paperbagish feel.=
 See
> follow up patches.

Well, I wasn't trying to clean up error handling, I was just trying
to make `jgit fetch` work against repo.or.cz.  But I agree, the
error handling and feedback in the transport code could be improved.

> Maybe we should have a patch for git too so it will actually work
> with spaces in file names. What do people on Windows do? (those that
> actually get an SSH server up and running and sleep well overe it
> on that platform).

The issue only happens with the command name, which most people
use just git-upload-pack/git-receive-pack as they have git in their
$PATH on the remote side, or are running git-shell.  I suspect that
Windows users just don't run Git over SSH with paths that contain
spaces to access git-upload-pack remotely.

I'd patch Git to use the same rule as jgit and only quote the command
when really necessary, but its not high on my list of things to do
this month.  :-)

> As for pushing and signing. One way is for you (Shawn) and me is
> to sign-off and push each other's patches. I pushed this one.

Given that repo.or.cz doesn't show reflogs, I take it this is only
a way to make sure at least someone has reviewed the patch before
it goes into the main tree, since we both have write access?  I
can live with that.

--=20
Shawn.
