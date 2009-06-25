From: Junio C Hamano <gitster@pobox.com>
Subject: Re: names using git config
Date: Thu, 25 Jun 2009 11:46:17 -0700
Message-ID: <7vy6rgb18m.fsf@alter.siamese.dyndns.org>
References: <376636be0906240958l70c81b68g83340556f2bf4eca@mail.gmail.com>
	<vpqljnhv9w0.fsf@bauges.imag.fr>
	<376636be0906242146h1d4c3b1q8c2e9af26f124af4@mail.gmail.com>
	<7veit8kidz.fsf@alter.siamese.dyndns.org>
	<376636be0906250309h6eb99296r4b81cf22985b690a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJtxs-00035x-Lj
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 20:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbZFYSqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 14:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607AbZFYSqQ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 14:46:16 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59745 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbZFYSqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 14:46:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625184618.VTSR25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 25 Jun 2009 14:46:18 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8JmH1c00C4aMwMQ04JmJVf; Thu, 25 Jun 2009 14:46:18 -0400
X-VR-Score: -210.00
X-Authority-Analysis: v=1.0 c=1 a=mK_AVkanAAAA:8 a=ybZZDoGAAAAA:8
 a=A1X0JdhQAAAA:8 a=EXwH7TH5yibCbZU3t-kA:9 a=h9xPZ3p2fLWW1PYVIqFFM_7yCawA:4
 a=9xyTavCNlvEA:10 a=qIVjreYYsbEA:10 a=Y6qChIQXU1wA:10
X-CM-Score: 0.00
In-Reply-To: <376636be0906250309h6eb99296r4b81cf22985b690a@mail.gmail.com> (Ryan's message of "Thu\, 25 Jun 2009 15\:39\:11 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122233>

Ryan <ryanphilips19@googlemail.com> writes:

> On Thu, Jun 25, 2009 at 10:41 AM, Junio C Hamano<gitster@pobox.com> w=
rote:
>> Ryan <ryanphilips19@googlemail.com> writes:
>>
>>> Hi,
>>> =C2=A0 Thank you for your response.
>>>
>>> 1) git config user.name 'Matthieu M. Moy' Works
>>> 2) git config user.name 'Matthieu M.' =C2=A0does not
>>>
>>> Name cannot end in a '.' <dot>. in git config user.name
>>
>> That is correct, but I think we are a bit too strict in sanitizing n=
ames.
>> The code is ident.c::copy() whose intent was to sanitize useless run=
s of
>> commas we slurp from GECOS field, but the sanitization is done also =
for
>> anything specified by the end user.
>
> What are you suggesting me to do? Apply the below patch.
> I may want to submit patches to the linux kernel. Is this okay?

Sorry if I was unclear.  I wasn't suggesting anything in particular to
you.  The only concrete thing addressed to you in my message was the
answer "That is correct" and all the remainder of my message, including
the patch, was primarily meant as illustration for other git developers=
 to
think about.

I do not think this matters that much in practice, as long as you are
submitting patches via e-mail, the usual method for leaf-level develope=
rs.
The maintainers apply your patches under the name your e-mail's From:
header carries, not your user.name.

If you apply the patch to your copy of git, your "git log" output will
start showing otherwise forbidden names that have leading or trailing d=
ots
(and other letters like semicolons) because your modified copy of "git
commit" will allow them, and I think "git commit -s" also will pass the
trailing dots intact, but that is about the extent of the damage.  With=
out
applying the patch, you will perhaps see your "Signed-off-by: Foo M
<foo.m@example.com>" line without the trailing dots after the name, but
that is something you can easily modify in your MUA when you are sendin=
g
the e-mail out.
