From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix dcommit clobbering upstream when committing multiple changes
Date: Sat, 1 Sep 2007 02:33:03 -0700
Message-ID: <20070901093303.GA9867@soma>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site> <20070831221814.GB31033@untitled> <Pine.LNX.4.64.0709010017250.28586@racer.site> <20070831234854.GA6451@mimvista.com> <20070901002501.GA11591@mimvista.com> <20070901011612.GA3407@untitled> <20070901054321.GA8021@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 11:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRPLu-00014l-90
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 11:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXIAJdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 1 Sep 2007 05:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbXIAJdH
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 05:33:07 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40039 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbXIAJdG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 05:33:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EA5F82DC08D;
	Sat,  1 Sep 2007 02:33:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070901054321.GA8021@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57263>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-08-31 18:16:12 -0700, Eric Wong wrote:
>=20
> > Although dcommit could detect if the first commit in the series
> > would conflict with the HEAD revision in SVN, it could not detect
> > conflicts in further commits it made.
> >
> > Now we rebase each uncommitted change after each revision is
> > committed to SVN to ensure that we are up-to-date. git-rebase will
> > bail out on conflict errors if our next change cannot be applied an=
d
> > committed to SVN cleanly, preventing accidental clobbering of
> > changes on the SVN-side.
> >
> > --no-rebase users will have trouble with this, and are thus warned
> > if they are committing more than one commit. Fixing this for
> > (hopefully uncommon) --no-rebase users would be more complex and
> > will probably happen at a later date.
>=20
> Shouldn't it be a simple matter of checking if the total diff over th=
e
> whole series would conflict with the SVN HEAD?

I don't think you can actually check for SVN conflicts until attempting
to do commit.

--=20
Eric Wong
