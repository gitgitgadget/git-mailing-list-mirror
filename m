From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sun, 5 Feb 2012 22:51:32 +0100
Message-ID: <877h01rlsr.fsf@thomas.inf.ethz.ch>
References: <1328373162-25188-1-git-send-email-felipe.contreras@gmail.com>
	<87sjipxe5u.fsf@thomas.inf.ethz.ch>
	<CAMP44s1wqmT4mavsXrEhB-OquOtQrYnnoSoX9G7X4wzFoMD29A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:51:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9zr-0001DN-Ds
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab2BEVvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 16:51:37 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:36755 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab2BEVvh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 16:51:37 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 5 Feb
 2012 22:51:33 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (84.73.49.17) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 5 Feb
 2012 22:51:33 +0100
In-Reply-To: <CAMP44s1wqmT4mavsXrEhB-OquOtQrYnnoSoX9G7X4wzFoMD29A@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 5 Feb 2012 22:51:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189970>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> 2012/2/5 Thomas Rast <trast@inf.ethz.ch>:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>> =C2=A0 'Foo Bar <foo@bar.com>' -> 'Foo Bar <foo@bar.com>'
>>> =C2=A0 '"Foo Bar" <foo@bar.com>' -> '"Foo Bar" <foo@bar.com>'
>>> =C2=A0 'foo@bar.com' -> 'foo@bar.com'
>>> =C2=A0 '<foo@bar.com>' -> 'foo@bar.com'
>>> =C2=A0 'Foo Bar' -> 'Foo Bar'
>>
>> Am I the only one who stared at this for ten seconds, only to then
>> realize that there is no sanitizing whatsoever going on here?
>
> There is: '<foo@bar.com>' -> 'foo@bar.com'

Indeed.

I still feel cheated as a reader though, you showed me four examples of
no change but let me figure that on my own.

>>> =C2=A0 'Foo Bar <foo@bar.com>>' -> 'Foo Bar <foo@bar.com>'
>>> =C2=A0 '"Foo Bar" <foo@bar.com>>' -> '"Foo Bar" <foo@bar.com>'
>>> =C2=A0 '<foo@bar.com>>' -> 'foo@bar.com'
>>
>> All of these are the same underlying issue. =C2=A0Does your patch fi=
x any
>> other malformed addresses, or just this particular type?
>
> See above.

Ok, I see I am falling into the same communication trap as Jonathan, so
let's be more explicit.

Your commit message first tells me you are going to sanitize something,
but starts out with examples of leaving the string unchanged.  Then it
continues with only the '>>' examples.

Today, and being someone who on average reads about half the mail that
comes through here, I know that this relates to the blame -e '>>' bug.
So today, I am wondering from the commit message why you narrowly focus
on that bug.  But you don't!  It's just that the commit message
insinuates it.

In a year, your reader (and bear in mind that this may very well be
yourself, at least if your memory is as good as mine) will wonder what
was so damn special about that '>>' string that it needs a specific fix
to send-email.

I see that you wrote in another thread:

> I have to write a peer-reviewed essay with an introduction for the
> people that are not familiar with the code in each of the patches

I'm not sure you meant it that literally, but the whole *point* is that
the message is for people who are not familiar with the code.  After
all, if I knew that your code did the right thing in the right way, I
would not be bothering with reading the message.  Today, I would just
send an Acked-by instead.  In a year, I'd scroll down for another
potential culprit for the bug I'm hunting.

What's especially striking me about your proposed messages of late: the=
y
leave me with more open questions than I started with.  I tried to show
this above.  I'm not sure whether other contributors are better at
answering questions, or just better at not touching any topics that
might raise them.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
