From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/8] bash: Remove short option completions for branch/checkout/diff.
Date: Sun, 4 Feb 2007 21:47:04 -0500
Message-ID: <20070205024704.GB12917@spearce.org>
References: <20070204073817.GA17603@spearce.org> <eq4ccg$9ae$1@sea.gmane.org> <7vr6t6rycz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 03:47:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDtsu-0003zY-CL
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 03:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbXBECrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 21:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbXBECrK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 21:47:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57817 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbXBECrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Feb 2007 21:47:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDtsd-0002AX-Lg; Sun, 04 Feb 2007 21:46:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6AC7820FBAE; Sun,  4 Feb 2007 21:47:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vr6t6rycz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38720>

Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > Shawn O. Pearce wrote:
> >> The short options (-l, -f, -d) for git-branch are rather silly to
> >> include in the completion generation as these options must be full=
y
> >> typed out by the user and most users already know what the options
> >> are anyway, so including them in the suggested completions does
> >> not offer huge value. =A0(The same goes for git-checkout and git-d=
iff.)
> >
> > Not true. It is nice to have on "git branch -" TAB TAB list of all=20
> > (well, all included in completion) short options to git-branch.
> >
> > So I'd vote NAK.
>=20
> Ah, sorry, but it's already done.
>=20
> I tried "git branch <TAB>" and saw hundreds of possibilities
> offered, and thought mixing -d/-l and friends are useless.  I
> didn't think of the possibility of saying "git branch -<TAB>".
>=20
> Presumably it was trying to suggest the <start-point> argument
> but that does not make much sense actually either.

Yeah.  The completion behind git-branch is pretty stupid.  Completing
the first argument from the existing set of branch names is stupid,
unless we are using -m/-M/-d/-D/-f, as we'd otherwise refuse to do
the operation.  But we certainly do want completion on the second
argument.

I could be smarter about it and scan backwards looking for the mode
in use and control completion based on that, but its just weird.
Besides, I sometimes like completing the new branch name from the
existing set, as often I want to make the new branch name using
a leading prefix of another existing name.  Completing part of it
saves a few keystrokes.


Completing single character options is rather useless in my mind.
The bash completion is always out of date with respect to the
actual set of supported options, and by definition they are a
single character.  Hitting '-<tab><tab>' to identify the list of
supported options gives *no* detail about what the options do,
and I still have to enter the option letter to complete it.

Completing `git am --w<tab>hitespace=3Ds<tab>trip ` with just 6
keystrokes on the other hand is very informative (whitespace,
strip!) and saves many keystrokes.  That's why long options are
supported, for at least the more commonly accessed ones.

--=20
Shawn.
