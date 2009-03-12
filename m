From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|")
	in sed regular expressions
Date: Thu, 12 Mar 2009 08:45:24 +0100
Message-ID: <20090312074524.GA14844@pengutronix.de>
References: <1236837389-35687-1-git-send-email-brian.p.campbell@dartmouth.edu> <1236837389-35687-2-git-send-email-brian.p.campbell@dartmouth.edu> <7viqmfjklm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Brian Campbell <brian.p.campbell@dartmouth.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 08:47:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhfd7-0005LJ-9o
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 08:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbZCLHpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 03:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbZCLHpc
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 03:45:32 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32828 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbZCLHpc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 03:45:32 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lhfbc-0001dp-Hg; Thu, 12 Mar 2009 08:45:28 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LhfbY-0003vk-Sf; Thu, 12 Mar 2009 08:45:24 +0100
Content-Disposition: inline
In-Reply-To: <7viqmfjklm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113011>

Hello Brian, hello Junio,

On Wed, Mar 11, 2009 at 11:55:49PM -0700, Junio C Hamano wrote:
> Brian Campbell <brian.p.campbell@dartmouth.edu> writes:
>=20
> > +current_branch()
> > +{
> > +	echo "$(git symbolic-ref HEAD | sed -e 's#^refs/heads/##' -e 's#^=
refs/top-bases/##')"
> > +}
>=20
> Two micronits.
>=20
>  - what happens when you are on a detached HEAD?
The original code had this problem, too, so I would not take this as a
stopper for the patch.  There are some other locations that suffer from
the same problem.  That's already on my todo list.  So I don't care muc=
h
here.
=20
>  - You will be utterly confused by a local branch whose name is
>    "refs/top-bases/foo"
You mean a branch that has the full name refs/heads/refs/top-bases/foo?
Well OK, valid concern.

> To fix these, you might want to do something like:
>=20
> 	if head_=3D$(git symbolic-ref HEAD)
>         then
>                 case "$head_" in
>                 refs/heads/*)
>                         echo "${head_#refs/heads/}"
>                         ;;
>                 refs/top-bases/*)
>                         echo "${head_#refs/top-bases/}"
>                         ;;
>                 *)
>                         echo "$head_"
>                         ;;
>                 esac
> 	else
>         	whatever you want to do on a detached HEAD
> 	fi
Thanks Junio and Brian.

Brian, do you update the series?

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
