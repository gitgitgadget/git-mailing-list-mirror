From: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
Subject: AW: Understanding behavior of git blame -M
Date: Fri, 15 Aug 2014 20:54:48 +0000
Message-ID: <71BF70CE41AEE741896AF3A5450D86F11F28C786@DEFTHW99EH3MSX.ww902.siemens.net>
References: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
 <874mxderwj.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 22:55:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIOWb-0008SU-QX
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 22:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbaHOUy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 16:54:57 -0400
Received: from gecko.sbs.de ([194.138.37.40]:57359 "EHLO gecko.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbaHOUy4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2014 16:54:56 -0400
Received: from mail2.sbs.de (localhost [127.0.0.1])
	by gecko.sbs.de (8.14.3/8.14.3) with ESMTP id s7FKsoLo001315;
	Fri, 15 Aug 2014 22:54:50 +0200
Received: from DEFTHW99ERGMSX.ww902.siemens.net (defthw99ergmsx.ww902.siemens.net [139.22.70.132])
	by mail2.sbs.de (8.14.3/8.14.3) with ESMTP id s7FKsnkg017027
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 15 Aug 2014 22:54:50 +0200
Received: from DEFTHW99ER2MSX.ww902.siemens.net (139.22.70.75) by
 DEFTHW99ERGMSX.ww902.siemens.net (139.22.70.132) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Fri, 15 Aug 2014 22:54:49 +0200
Received: from DEFTHW99EH3MSX.ww902.siemens.net ([169.254.1.177]) by
 DEFTHW99ER2MSX.ww902.siemens.net ([139.22.70.75]) with mapi id
 14.03.0195.001; Fri, 15 Aug 2014 22:54:49 +0200
Thread-Topic: Understanding behavior of git blame -M
Thread-Index: Ac+4jUNF6aAz44SIRIyypexOO2EquAAAPv+AAAI3tnoADDBMIA==
In-Reply-To: <874mxderwj.fsf@fencepost.gnu.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.50]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255304>

Hi David,

thank you very much for the exhaustive answer. The keyword "hunk" made =
me try a little bit more. So I realized that -M works as expected when =
at least three lines are moved.=20

=46rom your answer I discern that you find the current behavior correct=
=2E In my opinion, it diverges at least from the documented behavior, a=
s the documentation doesn't mention this "number of lines" aspect but r=
ather speaks about "number of alphanumeric characters".=20

Regards
Konstantin

-----Urspr=FCngliche Nachricht-----
Von: David Kastrup [mailto:dak@gnu.org]=20
Gesendet: Freitag, 15. August 2014 16:42
An: Sokolov, Konstantin (ext)
Cc: git@vger.kernel.org
Betreff: Re: Understanding behavior of git blame -M

"Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com> writes=
:

> Hi Folks,
>
> I'm trying to understand the behavior of git blame -M and find that=20
> the actual results differ from what I understood from the=20
> documentation. I've already asked longer time ago on stackoverflow an=
d=20
> on the user mailing list without any satisfactory results. So here is=
=20
> the example:
>
> Initial content of file.txt (2cd9f7f)
>
> AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
> CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
> DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
> EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
> GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>
> Move line B to the middle (d4bbd97e):
>
> AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
> DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
> BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
> EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
> GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
> FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>
>>git blame -s -n -f -w -M20 file.txt
> ^2cd9f7f 1 1) AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> ^2cd9f7f 3 2) CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
> ^2cd9f7f 4 3) DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
> d4bbd97e 4 4) BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
> ^2cd9f7f 5 5) EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
> ^2cd9f7f 6 6) GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
> ^2cd9f7f 7 7) FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>
> I wonder, why line B is not recognized as moved. According to the=20
> documentation, I would expect git blame to report that it originates=20
> from line 2 in revision 2cd9f7f. Can anybody explain the behavior?

Someone had reasons.  diff_hunks in builtin/blame.c is once called with=
 0 as third argument, once with 1.  Change the latter call to using 0 a=
s well and you get your expected result:

dak@lola:/tmp/test$ /usr/local/tmp/git/git blame -s -n -f -w -M20 file.=
txt
^2cab496 file.txt 1 1) AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
A
^2cab496 file.txt 3 2) CCCCCCCCCCCCCCCCCCCCCCCC222222222222222222222222=
2
^2cab496 file.txt 4 3) DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD=
D
^2cab496 file.txt 2 4) BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=
B
^2cab496 file.txt 5 5) EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE=
E
^2cab496 file.txt 6 6) GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG=
G
^2cab496 file.txt 7 7) FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
=46

The function diff_hunks is a wrapper for the diff engine.  Putting the =
context length explicitly into this wrapper (rather than not passing an=
 argument and just setting the context length to zero anyway in the
function) clearly indicates that somebody _wanted_ it called with diffe=
rent values.

There is no documentation or rationale in the file _why_ as far as I=A0=
remember.  Maybe it can crash or end up in an infinite loop.  Maybe it =
could do so at one point of time but no longer does.

Maybe Git is just a puzzle from genius to genius.  Good luck figuring i=
t out.

I have not touched this when rewriting git-blame recently, and I am not=
 interested in touching it.  I stand absolutely nothing to gain from wo=
rking on Git.

--
David Kastrup
