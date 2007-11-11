From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Sun, 11 Nov 2007 23:31:34 +0100
Message-ID: <20071111223134.GA12699@atjola.homenet>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org> <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <7v640cxitc.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711090225110.4362@racer.site> <7v1wb0xhxq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLLN-0004Sg-UY
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbXKKWbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 17:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbXKKWbj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:31:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:59911 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755268AbXKKWbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:31:38 -0500
Received: (qmail invoked by alias); 11 Nov 2007 22:31:35 -0000
Received: from i577B84F1.versanet.de (EHLO localhost) [87.123.132.241]
  by mail.gmx.net (mp003) with SMTP; 11 Nov 2007 23:31:35 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1946FgWksJ4IMcO2LODJWRqzDhCPeeQs1Xcrghm9x
	ULJErfD7a4b8pb
Content-Disposition: inline
In-Reply-To: <7v1wb0xhxq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64529>

On 2007.11.08 18:37:37 -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Thu, 8 Nov 2007, Junio C Hamano wrote:
> >
> >> I wonder if this is a sensible thing to do, regardless of the issu=
e of=20
> >> commit log message that contains anything.
> >>=20
> >> The patch replaces git-rebase with git-rebase--interactive.  The o=
nly=20
> >> difference from the existing "git-rebase -i" is if the command is =
called=20
> >> without "-i" the initial "here is the to-do list. please rearrange=
 the=20
> >> lines, modify 'pick' to 'edit' or whatever as appropriate" step is=
 done=20
> >> without letting the user edit the list.
> >
> > Hmm.  I don't know, really.  I had the impression that the "git=20
> > format-patch | git am" pipeline would be faster.
>=20
> Heh, I did not read rebase--interactive carefully enough.
>=20
> Unless told to use merge with "rebase -m", rebase replays the
> change by extracting and applying patches, and speed comparison
> was about that vs merge based replaying; I thought make_patch
> was done in order to avoid using cherry-pick (which is based on
> merge-recursive) and doing patch application with three-way
> fallback.  Apparently that is not what "interactive" does.
>=20
> Perhaps pick_one () could be taught to perform the 3-way
> fallback dance git-am plays correctly.  The patch I sent to make
> git-rebase--interactive take over git-rebase would then become
> quite reasonable, I would think.

Note that git-rebase--interactive also doesn't really support the
--strategy parameter which git-rebase handles using git-merge-* instead
of git-am. Only merge commits during a -i -p run actually apply the
strategy.

Bj=F6rn
