From: Jerome Lovy <rqe28bj3vfyi4eo@jetable.net>
Subject: Re: Autoconf/Automake
Date: Fri, 16 Jun 2006 11:06:02 +0200
Message-ID: <e6tso3$s3s$1@sea.gmane.org>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home> <20060615163209.GJ7766@nowhere.earth> <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org> <20060615174833.GA32247@dspnet.fr.eu.org>
Reply-To: rqe28bj3vfyi4eo@jetable.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jun 16 11:20:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrAUq-0007Fh-G9
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 11:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWFPJUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Jun 2006 05:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWFPJUE
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 05:20:04 -0400
Received: from main.gmane.org ([80.91.229.2]:51176 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750891AbWFPJUD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 05:20:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FrAUk-0007EX-8R
	for git@vger.kernel.org; Fri, 16 Jun 2006 11:20:02 +0200
Received: from ngw.jaluna.com ([212.11.48.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 11:20:02 +0200
Received: from rqe28bj3vfyi4eo by ngw.jaluna.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 11:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ngw.jaluna.com
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
In-Reply-To: <20060615174833.GA32247@dspnet.fr.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21936>

Olivier Galibert wrote:
> On Thu, Jun 15, 2006 at 10:02:10AM -0700, Linus Torvalds wrote:
>=20
>>These days, there aren't fifteen different versions of UNIX. There's =
a=20
>>couple, and it's perfectly ok to actually say "fix your damn system a=
nd=20
>>just install GNU make". It's easier to install GNU make than it is to=
=20
>>install autoconf/automake.
>=20
>=20
> You should be careful to separate autoconf and automake.  Autoconf is
> not so bad, and you can make clean, maintainable Makefile.in and
> config.h.in files with it, because it uses simple substitution.  It i=
s
> quite useful to detect available librairies when some are optional,
> and also to lightly[1] ensure that prefix and friends will stay the
> same between make and make install.  Also, especially if you hack a
> little bit to alias 'enable' and 'with', you get a sane interface to
> optional feature selection.  Oh, and to seperate compilation
> directories too (vpath generation).

I fully agree with Olivier. It seems to me that you don't have to buy=20
the whole autoconf/automake/libtool stack to leverage the autoconf=20
functionality. autoconf alone provides the full "autoconfiguration"=20
framework (running scriptlets and setting substitution variables=20
accordingly). You still have to write Makefile.in (with statements=20
looking like: CC=3D@CC@). Therefore the resulting Makefile is just as=20
beautiful or as ugly as you wrote the initial Makefile.in: you have ful=
l=20
control over it.

As for dependencies, one shouldn't confuse what is needed on the=20
autoconfiguration developer's side (in order to build the configure=20
script from the configure.in file) and what is needed on the installer'=
s=20
side to run the configure script and process the generated makefile. Th=
e=20
former needs the autoconf package which itself relies on GNU m4. The=20
latter merely needs a decently compatible Bourne shell and a decently=20
compatible make.

On the other hand, what you get with automake is a fully automatically=20
generated makefile, with make targets conforming to the GNU standards.=20
But then you fully loose control over the Makefile: you don't write the=
=20
Makefile.in anymore (automake does it for you) but rather the terce=20
Makefile.am. In this respect, automake is like imake: you write few=20
lines of (i)makefile, but then you cannot complain if you don't=20
understand what comes in the generated makefile ;-) .

J=E9r=F4me Lovy
