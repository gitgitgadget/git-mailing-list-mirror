From: Wincent Colaiuta <win@wincent.com>
Subject: Re: On pathnames
Date: Fri, 25 Jan 2008 13:53:54 +0100
Message-ID: <FAC8E3EF-7F18-4601-8B4F-09ED24228C21@wincent.com>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu> <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org> <7vprvr7x8h.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801241722130.22568@xanadu.home> <7vy7ae7dcb.fsf@gitster.siamese.dyndns.org> <alpi
 ne.LSU.1.00.0801251137030.5731@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 13:55:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIO5c-0000Zz-7q
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 13:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbYAYMyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 07:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754964AbYAYMyy
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 07:54:54 -0500
Received: from wincent.com ([72.3.236.74]:59368 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754905AbYAYMyx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 07:54:53 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0PCrsS9015321;
	Fri, 25 Jan 2008 06:53:55 -0600
In-Reply-To: <alpine.LSU.1.00.0801251137030.5731@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71706>

El 25/1/2008, a las 13:25, Johannes Schindelin escribi=F3:

> The strange thing is that
>
> http://colabti.de/irclogger/irclogger_log/git?date=3D2008-01-25,Fri&s=
el=3D57#l89
>
> the command line seems not to be mangling the name.
>
> Summary:
>
> it seems that for some strange reason, "git add M=E4rchen" puts the =20
> mangled
> filename into the index, even if "echo M=E4rchen" shows the unmangled
> filename.
>
> Ciao,
> Dscho


Not sure if I grokked the IRC interchange fully but check this out:

$ touch M=E4rchen
$ echo M=E4rchen | xxd -g1
0000000: 4d 61 cc 88 72 63 68 65 6e 0a                    Ma..rchen.
$ echo M=E4rchen | xxd -g1
0000000: 4d c3 a4 72 63 68 65 6e 0a                       M..rchen.

The first one shows me creating the file, then typing "echo M" and =20
hitting tab so that the shell autocompletes the filename for me based =20
on what it sees in the current directory. Note how it's decomposed.

The second one shows me manually typing the string "M=E4rchen" with no =
=20
tab autocompletion (literally typing =A8 then a), and you'll notice tha=
t =20
this time it is precomposed.

So that might explain why "echo M=E4rchen" is showing an unmangled name=
; =20
if he just typed it out like I did then that would be the expected =20
result.

Cheers,
Wincent
