X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 21:31:13 +0100
Message-ID: <200611152131.14883.Josef.Weidendorfer@gmx.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <ejfm6c$bu4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 20:31:47 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <ejfm6c$bu4$1@sea.gmane.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31486>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRPn-0000Ug-UC for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030980AbWKOUbU convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWKOUbU
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:31:20 -0500
Received: from mail.gmx.de ([213.165.64.20]:8416 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030980AbWKOUbT convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:31:19 -0500
Received: (qmail invoked by alias); 15 Nov 2006 20:31:17 -0000
Received: from p5496A980.dip0.t-ipconnect.de (EHLO noname) [84.150.169.128]
 by mail.gmx.net (mp030) with SMTP; 15 Nov 2006 21:31:17 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Wednesday 15 November 2006 19:28, you wrote:
> Linus Torvalds wrote:
>=20
> > But the fact is, git isn't really that hard to work out, and the co=
mmands=20
> > aren't that complicated. There's no reason to rename them. We do ha=
ve=20
> > other problems:
> >=20
> > =A0- default branch selection for merging is broken (it should defi=
nitely=20
> > =A0 =A0take the current branch into account). When I do "git pull" =
with no=20
> > =A0 =A0branch specification, and I happen to be on a branch that is=
 associated=20
> > =A0 =A0with something else than "master" in the remote, I shouldn't=
 merge with=20
> > =A0 =A0master.
>=20
> This problem is _slightly_ migitated by branch.<name>.merge config va=
riable.
> Slightly because you have to specify branch to merge, instead of forb=
idding
> merge if you are not on specific branch (and you don't override it).

We should change this.

The problem is that whatever is the first Pull line in remotes config g=
ets
merged by default into current branch, which most often is not the righ=
t
thing to do.

Often, I find myself doing "git branch" just to make sure that I am on
"master", so that a following pull does not do a bogus merge.

Can we please disable this behavior, e.g. by allowing a fake first
Pull line like "Pull: (not-for-merge)" to prohibit any merge?

This even could be written by default in git-clone somewhere in the fut=
ure,
and we suddenly get the behavior of pull being symmetric to push - at l=
east
by default. And still, it is fully compatible to existing repositories.

To make pull do the right thing, we _have_ to configure branch.<name>.m=
erge
whenever we create a new branch (which matters for git-clone, too).

Josef

>=20
> > =A0- I agree that having to create temporary branches to just look =
at a tag=20
> > =A0 =A0that you don't want to actually develop on is just unnecessa=
rily=20
> > =A0 =A0bothersome.
>=20
> Agreed.
