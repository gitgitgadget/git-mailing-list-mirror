From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 6 May 2009 09:19:06 +0000 (UTC)
Message-ID: <loom.20090506T091628-717@post.gmane.org>
References: <20090506055913.GA9701@dektop> <4A01320A.2050600@viscovery.net> <fcaeb9bf0905052357v6773cbf5i12795c1866a80783@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 11:19:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1dHo-0005LG-2h
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 11:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbZEFJTY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 05:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbZEFJTY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 05:19:24 -0400
Received: from main.gmane.org ([80.91.229.2]:38890 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbZEFJTX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 05:19:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M1dHe-0002rZ-EX
	for git@vger.kernel.org; Wed, 06 May 2009 09:19:22 +0000
Received: from gibraltar.ins.uni-bonn.de ([131.220.223.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 May 2009 09:19:22 +0000
Received: from Ralf.Wildenhues by gibraltar.ins.uni-bonn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 May 2009 09:19:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 131.220.223.4 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.6) Gecko/2009020911 Ubuntu/8.04 (hardy) Firefox/3.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118333>

Nguyen Thai Ngoc Duy writes:
> On Wed, May 6, 2009 at 4:45 PM, Johannes Sixt wrote:
> > Nguyen Thai Ngoc Duy schrieb:
> >> =C2=A0 =C2=A0 =C2=A0 # normalize path:
> >> =C2=A0 =C2=A0 =C2=A0 # multiple //; leading ./; /./; /../; trailin=
g /
> >> =C2=A0 =C2=A0 =C2=A0 path=3D$(printf '%s/\n' "$path" |
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -e '
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s|//*|/|g
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s|^\(\./\)*||
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s|/\./|/|g
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 :start
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s|\([^/]*\)/\.\./||
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tstart
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s|/*$||
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ')

> It says nothing. The result of "printf '%s\n' ./foo/bar | sed -e blah=
"
> is just wrong, (i.e. "./" remains). I stripped down to "sed -e
> 's|^\(\./\)*||'", does not work. Probably due to \( \) pair. Skimmed
> through sed manpage, seems no mention of bracket grouping.

Quoting 'info Autoconf "Limitation of Usual Tools"':

     Some `sed' implementations, e.g., Solaris, restrict the special
     role of the asterisk to one-character regular expressions.  This
     may lead to unexpected behavior:

          $ echo '1*23*4' | /usr/bin/sed 's/\(.\)*/x/g'
          x2x4
          $ echo '1*23*4' | /usr/xpg4/bin/sed 's/\(.\)*/x/g'
          x

You can work around it in this case with
  :again
  s|^\./||
  t again

BTW, you should put a space between t and the label (but not between
: and label), POSIX requires that and some sed versions expect it.

Cheers,
Ralf
