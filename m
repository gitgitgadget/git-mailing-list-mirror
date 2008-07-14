From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
	completion
Date: Mon, 14 Jul 2008 06:27:55 +0000
Message-ID: <20080714062755.GA15992@spearce.org>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org> <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:29:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIHYN-0000z8-5O
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 08:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbYGNG15 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 02:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbYGNG15
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 02:27:57 -0400
Received: from george.spearce.org ([209.20.77.23]:53253 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbYGNG14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 02:27:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EB7203836B; Mon, 14 Jul 2008 06:27:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88380>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
> > >=20
> > > Does it fix this one too:
> > >=20
> > > 	git show origin/pu:Makef<tab>
> > >=20
> > > which totally screws up and becomes
> > >=20
> > > 	git show Makefile
> > >=20
> > > dropping the version specifier?

What is $COMP_WORDBREAKS set to in your shell?  In mine it
appears to be:

	" \"'@><=3D;|&(:"

which is the I believe the shell default.

Bj=C3=B6rn Steinbrink (doener on #git) is running bash 3.2.39 from
Debian and has the same setting, and the completion works correctly
there too.  He reports that removing : from COMP_WORDBREAKS will
get the behavior you are reporting as broken.

I have to say, this sounds to me like you (or some package on your
system) modified COMP_WORDBREAKS away from the default that other
distributions use and that is what is breaking us here.  Since we
can have only one setting for this variable in the shell I do not
thing it would be a good idea for our completion package to force
a specific setting upon the user.

Though we could try to detect : in there and if it is not present
use the workaround you posted.  But I wonder if just asking the
user to include : is easier.

--=20
Shawn.
