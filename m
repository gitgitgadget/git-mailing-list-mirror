From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Git messes up =?iso-8859-1?Q?'=F8?= =?iso-8859-1?Q?'?= character
Date: Wed, 21 Jan 2015 05:05:43 +0800
Message-ID: <20150120210543.GA13382@kroah.com>
References: <54BEB08D.9090905@tronnes.org>
 <54BEB585.2030902@web.de>
 <54BEB7ED.2050103@tronnes.org>
 <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <notro@tronnes.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDfzn-0005Fr-56
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 22:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbbATVFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 16:05:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47421 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbbATVFu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 16:05:50 -0500
Received: from localhost (unknown [203.117.110.130])
	by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49A4893B;
	Tue, 20 Jan 2015 21:05:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262689>

On Tue, Jan 20, 2015 at 09:45:46PM +0100, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> On Tue, Jan 20, 2015 at 9:17 PM, Noralf Tr=F8nnes <notro@tronnes.org>=
 wrote:
> > Den 20.01.2015 21:07, skrev Torsten B=F6gershausen:
> >>
> >> On 2015-01-20 20.46, Noralf Tr=F8nnes wrote:
> >> could it be that your "=F8" is not encoded as UTF-8,
> >> but in ISO-8859-15 (or so)
> >>
> >>> $ git log -1
> >>> commit b2a4f6abdb097c4dc092b56995a2af8e42fbea79
> >>> Author: Noralf Tr<F8>nnes <notro@tronnes.org>
> >>
> >> What does
> >> git config -l | grep Noralf | xxd
> >> say ?
> >>
> > $ git config -l | grep Noralf | xxd
> > 0000000: 7573 6572 2e6e 616d 653d 4e6f 7261 6c66  user.name=3DNoral=
f
> > 0000010: 2054 72f8 6e6e 6573 0a                    Tr.nnes.
> >
> > $ file ~/.gitconfig
> > /home/pi/.gitconfig: ISO-8859 text
>=20
> What's happened here is that:
>=20
>  1. You've authored your commit in ISO-8859-1
>  2. Git itself has no place for the encoding of the author name in th=
e
> commit object format
>  3. git-format-patch has a --compose-encoding which I think would sor=
t
> this out if you set it to ISO-8859-1, but it defaults to UTF-8
>  4. Your patch is actually a ISO-8859-1 byte sequence, but is
> advertised as UTF-8
>  5. You end up with a screwed-up commit
>=20
> You could work around this, but I suggest just joining the 21st
> century and working exclusively in UTF-8, it makes things much easier=
,
> speaking as someone with 3x more non-ASCII characters their his name
> than you :)

So how exactly do you fix this using UTF-8?  Git is exporting a UTF-8
"From:" line so it thinks the character is correct, but it's not
creating something properly here.

confused,

greg k-h
