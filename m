From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: bash 4.0 breaks some completion scripts
Date: Fri, 3 Dec 2010 01:11:57 +0100
Message-ID: <20101203001157.GC3577@neumann>
References: <20101027235919.GB30490@burratino>
	<20101202233848.GA8438@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 601632@bugs.debian.org,
	Peter van der Does <peter@avirtualhome.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 01:12:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POJFz-0006fK-B6
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 01:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120Ab0LCAMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 19:12:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:55311 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824Ab0LCAME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 19:12:04 -0500
Received: from localhost6.localdomain6 (p5B130C9F.dip0.t-ipconnect.de [91.19.12.159])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LeBRc-1Oau1J3szs-00q7EX; Fri, 03 Dec 2010 01:11:58 +0100
Content-Disposition: inline
In-Reply-To: <20101202233848.GA8438@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:u8ew4Wgy/0Qg5ztI8KAU9EdhDXYe3MjgQDC06oPJBwA
 l3YBN/OkNXpuM5lDV+oKXh/bC/+vCaGu5PuBAH1aZKBKlldTra
 aaPxmCD7HmqHmgcC+ju9fQam+YWsggRRDTL9Jn/sHDOzhyP1UV
 iTMdbBsT6Mo3Uqc8/+kZtenbEAU2gEo58q25D2lWSUMUbpXuD9
 tlY5zkWPzTpQDFEwjghFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162755>

Hi,


On Thu, Dec 02, 2010 at 05:38:48PM -0600, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
>=20
> > Bash 4.0 changed the rules for completion word splitting so that
> > they are incompatible with 3.x.  I think some Breaks: will be neede=
d
> > to ensure smooth upgrades.
>=20
> Just FYI: Ah, at last some clarity!
>=20
> From the bash 3 manual:
>=20
>  COMP_WORDS
> 	An array variable (see Arrays below) consisting of the
> 	individual words in the current command line.  The
> 	words are split on shell metacharacters as the shell
> 	parser would separate them.  This variable is
> 	available only in shell functions invoked by the
> 	programmable completion facilities (see Programmable
> 	Completion below).
>=20
> From the bash 4 manual:
>=20
>  COMP_WORDS
> 	An array variable (see Arrays below) consisting of the
> 	individual words in the current command line.  The
> 	line is split into words as readline would split it,
> 	using COMP_WORDBREAKS as described above.  This
> 	variable is available only in shell functions invoked
> 	by the programmable completion facilities (see
> 	Programmable Completion below).

Oh dear, oh dear.  I've just sent a reply to your message on the git
list with basically the same findigs. [1]

> The workaround used by the bash-completion scripts is to paste words
> from COMP_WORDS together (in _get_comp_words_by_ref).
>=20
> If only the NEWS file had mentioned it. :) =20

Actually, the NEWS file does mention it (and Peter noted it right at
the start! [2]):

i.  The programmable completion code now uses the same set of character=
s as
    readline when breaking the command line into a list of words.

But it's really easy to misinterpret this statement, because there is
and there was a $COMP_WORDBREAKS, so the first thing that
comes to mind is that the set of characters in $COMP_WORDBREAKS is
changed, leaving you puzzled for weeks when you discover that the
set of characters is still the same.


Best,
G=E1bor


[1] http://marc.info/?l=3Dgit&m=3D129133327312420&w=3D2
[2] http://thread.gmane.org/gmane.comp.version-control.git/159516/focus=
=3D159628
