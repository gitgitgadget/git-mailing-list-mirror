From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-add--interactive works only in top level
Date: Tue, 4 Dec 2007 11:37:28 +0100
Message-ID: <9AADB5DF-15FA-4A5F-BF4B-509135E486B6@wincent.com>
References: <058EB5A2-1EFE-43B9-9886-7272A955CE51@mit.edu> <7vwsrv9fos.fsf@gitster.siamese.dyndns.org> <4BC1648E-3059-4373-B388-65AD739796D8@MIT.EDU> <7vmysr9dxg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reid Barton <rwbarton@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 11:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzVAh-0000NR-HF
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 11:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbXLDKiP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 05:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbXLDKiP
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 05:38:15 -0500
Received: from wincent.com ([72.3.236.74]:34573 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbXLDKiO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2007 05:38:14 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB4AbTO5024171;
	Tue, 4 Dec 2007 04:37:30 -0600
In-Reply-To: <7vmysr9dxg.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67035>

El 4/12/2007, a las 7:22, Junio C Hamano escribi=F3:

> Reid Barton <rwbarton@MIT.EDU> writes:
>
>> I understand that programs such as git-add--interactive will be move=
d
>> out of the executable path not too long from now, which will also
>> ameliorate the situation.
>
> Honestly, there is nothing to ameliorate.  We do not even document
> git-add--interactive on purpose.
>
> Once I saw somebody who somehow got a root account on a shared UNIX =20
> box
> and tryed running everything he found under /sbin one after another
> without understanding what he was doing.  Needless to say, the box di=
d
> not last too long.  Somehow that "tab completion" comment reminds of
> him.

Here he have two options: blame the user for his/her stupidity, or =20
look at this a UI problem and try to make the UI "idiot proof".

In this particular case I see no impediment to favouring the second =20
option, because we're not talking about making changes that would make =
=20
Git less powerful or useful for "non-idiots", "power users" or "real =20
men" (whatever you want to call them). In other words, we are not =20
talking about "dumbing down" Git for the sake of the ignorant. This is =
=20
an opportunity to polish the UI in the same way that we polish the =20
internal pack format.

And while it's not a good idea to login as root and try everything =20
under "/sbin" without knowing what it does, stumbling across "git-add--=
=20
interactive" via tab completion is easier to understand. It's an easy =20
enough mistake to make and it would be nice if we shielded the user =20
from making it.

I think it is (and always was) an error to expose things like git-add--=
=20
interactive which are fundamentally implementation details *internal* =20
to Git. The user shouldn't even know that it exists. It's one thing to =
=20
have a bunch of high-level commands (porcelain) mixed together with =20
low-level ones (plumbing) in the user's PATH, but it's another =20
entirely to also stick internal implementation stuff which should =20
*never* be directly executed in there too. At least in the case of =20
plumbing there are reasons why you might sometimes directly execute =20
it, but that's not the case with stuff like git-add--interactive.

So I do think there is something to ameliorate, and moving this stuff =20
out of the PATH will do exactly that.

Cheers,
Wincent
