From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Sat, 29 Mar 2008 22:43:40 +0100
Message-ID: <200803292243.40733.robin.rosenberg.lists@dewire.com>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291354.10368.robin.rosenberg.lists@dewire.com> <20080329211849.GA30851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 29 22:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfirg-0008Hx-NF
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 22:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbYC2Voi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Mar 2008 17:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYC2Voi
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 17:44:38 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29423 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbYC2Voh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Mar 2008 17:44:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 23C0E8026E9;
	Sat, 29 Mar 2008 22:44:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 025IRHa1eLRL; Sat, 29 Mar 2008 22:44:34 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 7AA3A800782;
	Sat, 29 Mar 2008 22:44:34 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080329211849.GA30851@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78484>

Den Saturday 29 March 2008 22.18.49 skrev Jeff King:
> On Sat, Mar 29, 2008 at 01:54:10PM +0100, Robin Rosenberg wrote:
> > I think you really should try the UTF-8 guess, since a file may wel=
l be
> > UTF-8 even if the user locale is something else. Especially for XML
> > files, UTF-8 is common, but there are many more cases. Look into
> > git-gui/po for more examples. The probability of a UTF-8 test being=
 wrong
> > is just so unimaginable low.
>
> Thinking about this more, I think it is only half the solution. If
> something is not valid utf-8, then we know it must be something else.
> But if something is valid utf-8, is it necessarily utf-8? I think we =
are
> going to have a much higher probability of guessing wrong there.
>
> For example, consider the bytes { 0xc3, 0xb6 }. In utf-8, they are '=C3=
=B6'.
> But in iso8859-1, they also have meaning (paragraph symbol followed b=
y
> =C3=83). Now that is an unlikely combination to come up. And maybe fo=
r
> Latin-1, having two non-ascii characters next to each other is unlike=
ly.
=46irst that is even by random an unlikely sequence. For any "real" is =
string
it simply won't happen, even in this context. Try scanning everything y=
ou
can think of and see if you find such a sequence that is not actually U=
TF-8.

> But over all commonly used encodings, what is the probability in an
> average text of that encoding that it contains valid UTF-8?
> For example, I have no idea what patterns can be found in EUCJP.

See here http://www.ifi.unizh.ch/mml/mduerst/papers/PDF/IUC11-UTF-8.pdf

Note that a random string is a randomly generated string. Not a random =
string
from the set of actually existing strings.

> There is some magic with how Perl marks strings as "binary" versus
> "utf-8" that I don't quite understand. And I think is_utf8 is really
> about asking "is the utf-8 flag set".
>
> I think this discussion would benefit greatly from somebody who has m=
ore
> of a clue how perl i18n stuff works. Why don't you work up a patch th=
at
> makes sense for you, and then hopefully that will get some attention?

The only real question as I see it is whether perl has a builtin metod =
that=20
works better than the decode/encode. Anyone?

-- robin
