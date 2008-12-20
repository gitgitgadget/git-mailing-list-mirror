From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Sun, 21 Dec 2008 00:31:08 +0100
Message-ID: <200812210031.08443.robin.rosenberg.lists@dewire.com>
References: <200812182039.15169.bss@iguanasuicide.net> <200812200808.02011.robin.rosenberg.lists@dewire.com> <200812201654.23110.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Dec 21 00:32:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEBJO-0004be-K6
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 00:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbYLTXbV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Dec 2008 18:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYLTXbV
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 18:31:21 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:56729 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053AbYLTXbU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 18:31:20 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 4873CA95028D5A8F; Sun, 21 Dec 2008 00:31:12 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <200812201654.23110.bss@iguanasuicide.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103673>

l=F6rdag 20 december 2008 23:54:19 skrev Boyd Stephen Smith Jr.:
> On Saturday 2008 December 20 01:08:01 Robin Rosenberg wrote:
> > fredag 19 december 2008 03:39:15 skrev Boyd Stephen Smith Jr.:
> > > On Thursday 2008 December 18 18:21:25 Linus Torvalds wrote:
> > > > I suspect we should warn about reverting merges.
> >
> > Or mention the reverted parent in the commit message since it is no=
t
> > obvious.
> >
> > ---
> >  builtin-revert.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/builtin-revert.c b/builtin-revert.c
> > index 4038b41..fc59229 100644
> > --- a/builtin-revert.c
> > +++ b/builtin-revert.c
> > @@ -352,6 +352,10 @@ static int revert_or_cherry_pick(int argc, con=
st char
> > **argv) add_to_msg(oneline_body + 1);
> >  		add_to_msg("\"\n\nThis reverts commit ");
> >  		add_to_msg(sha1_to_hex(commit->object.sha1));
> > +		if (commit->parents->next) {
> > +			add_to_msg(" removing\ncontributions from ");
> > +			add_to_msg(sha1_to_hex(parent->object.sha1));
> > +		}
> >  		add_to_msg(".\n");
> >  	} else {
> >  		base =3D parent;
>=20
> I'm still new to the code, but parent is the "mainline" specified on =
the=20
> command-line, which (I think) is actually the parent to be reverted t=
o, so we=20
> are actually removing contributions from all the *other* parents.  So=
, the=20
> message may be backward.  Because of that, I'd say the patch doesn't =
handle=20

Indeed the message is backward. How about  "removing all contributions =
except from"... etc ?

An alternative, would be "removing changes relative to .." (mainline). =
The changes are
the contributions from all other parents. I have to huge interest in th=
e exact phrase used.

> octopus merges well, either.

Same problem, I think.

-- robin
