From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: SVN Branch Description Format
Date: Sat, 31 Mar 2012 02:27:59 +0100
Message-ID: <4F765D9F.70404@pileofstuff.org>
References: <4F5C85A3.4080806@pileofstuff.org> <CALkWK0mh5hKz+=-Ur3bE2+YBiSwFiPtZXQOJdMwY=BemXrqwWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Nathan Gray <n8gray@n8gray.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 04:08:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDnk2-0000mu-O5
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 04:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266Ab2CaCIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 22:08:30 -0400
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:10376 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269Ab2CaCI2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 22:08:28 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120331012801.GVJZ29686.mtaout01-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Sat, 31 Mar 2012 02:28:01 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120331012801.YSXK10211.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 31 Mar 2012 02:28:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <CALkWK0mh5hKz+=-Ur3bE2+YBiSwFiPtZXQOJdMwY=BemXrqwWQ@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=_K96qfqeG7gA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=wkj3dZ8WAAAA:8 a=NEAV23lmAAAA:8 a=h6NBuFSXrVJB8wr3D5cA:9 a=LHaL6IAPl94zH-ZfZzAA:7 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194427>

On 30/03/12 05:06, Ramkumar Ramachandra wrote:
> Hi,
>=20
> Andrew Sayers wrote:
>> SVN Branch Description Format v0.1
>=20
> I found this pretty interesting.  Doesn't it duplicate some of the
> functionality of reposurgeon [1] though?
>=20
> [1]: http://esr.ibiblio.org/?p=3D4071

Yes, I've been procrastinating all week instead of reading up on
reposurgeon and contacting ESR about possibile collaboration.

I think you need something a bit more expressive than reposurgeon's
format to do SVN<->Git conversion well, and I think you need something =
a
bit more accessible in order to document SVN edge cases.  For example, =
I
don't see how reposurgeon could represent all the madness around SVN
cherry-picks that become merges when you manually add information from
revision logs, then become cherry-picks again when you find a revert
coming in from another branch.  Having said that, a (lossy) conversion
between SBL and reposurgeon format would probably be useful and not tha=
t
hard.

The link above put it very well that most people leave an embarrassed
=E2=80=9Cto be done=E2=80=9D comment and disappear when they realise ho=
w much of a
nightmare the mapping is.  What it doesn't mention is that everyone
experiences a slightly different part of the nightmare, and that we can
only really tackle the problem by getting everyone's freaky edge cases
written up in one language in one place.  The test suite[1] isn't that
impressive right now, but in the long-term I'm really keen to get
implementers to pool their knowledge so we can all benefit.  SBL is
designed to let people open the relevant test without reading the spec
and say "oh right I understand what a piecemeal merge is now.  I'll go
implement that in my project".

I'm currently working on code to read an SVN dump and write to SBL.
This will definitely overlap with reposurgeon's SVN export
functionality, but without seeing the final code I can't say how much.
That's fine though - as I say, the only way to get a good solution is
for multiple implementers to investigate the problem and share the edge
cases they find.

	- Andrew

[1]https://github.com/andrew-sayers/SVN-Branching-Language/tree/master/=
t
