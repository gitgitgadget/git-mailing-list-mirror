From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add extra safetly in address sanitazion
Date: Mon, 6 Feb 2012 03:27:50 +0200
Message-ID: <CAMP44s30VmJasMLJxs-JFwksvPEPpG1LB3Gr_pA2+hpE1AnwXg@mail.gmail.com>
References: <1328373162-25188-1-git-send-email-felipe.contreras@gmail.com>
	<87sjipxe5u.fsf@thomas.inf.ethz.ch>
	<CAMP44s1wqmT4mavsXrEhB-OquOtQrYnnoSoX9G7X4wzFoMD29A@mail.gmail.com>
	<877h01rlsr.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 06 02:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuDN6-000691-RA
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 02:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab2BFB1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 20:27:52 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36500 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754751Ab2BFB1w convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 20:27:52 -0500
Received: by lagu2 with SMTP id u2so2711200lag.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 17:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9IVj1Xx/Xc1o+Z1Gq2Von8vZKXGSqp4ODUle5r1SDcg=;
        b=ArCfnaIoEyYGPRaHZU9Pu5iqDuLN36W+40d+85EZnJMpkKMtAVx57wckr6jZ+lRjAP
         m/jrNhXm6jEtbXE/EM4fKYIr0z6Mh7OjzGNWQVflpaTGMGl37pFQuxjS3iwsJn5hnnLQ
         qvXBPMOzZDLbzyICGYflIAq0EpuS9Ag0pdr20=
Received: by 10.152.112.41 with SMTP id in9mr8286304lab.27.1328491670474; Sun,
 05 Feb 2012 17:27:50 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sun, 5 Feb 2012 17:27:50 -0800 (PST)
In-Reply-To: <877h01rlsr.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189995>

On Sun, Feb 5, 2012 at 11:51 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> 2012/2/5 Thomas Rast <trast@inf.ethz.ch>:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>> =C2=A0 'Foo Bar <foo@bar.com>' -> 'Foo Bar <foo@bar.com>'
>>>> =C2=A0 '"Foo Bar" <foo@bar.com>' -> '"Foo Bar" <foo@bar.com>'
>>>> =C2=A0 'foo@bar.com' -> 'foo@bar.com'
>>>> =C2=A0 '<foo@bar.com>' -> 'foo@bar.com'
>>>> =C2=A0 'Foo Bar' -> 'Foo Bar'
>>>
>>> Am I the only one who stared at this for ten seconds, only to then
>>> realize that there is no sanitizing whatsoever going on here?
>>
>> There is: '<foo@bar.com>' -> 'foo@bar.com'
>
> Indeed.
>
> I still feel cheated as a reader though, you showed me four examples =
of
> no change but let me figure that on my own.
>
>>>> =C2=A0 'Foo Bar <foo@bar.com>>' -> 'Foo Bar <foo@bar.com>'
>>>> =C2=A0 '"Foo Bar" <foo@bar.com>>' -> '"Foo Bar" <foo@bar.com>'
>>>> =C2=A0 '<foo@bar.com>>' -> 'foo@bar.com'
>>>
>>> All of these are the same underlying issue. =C2=A0Does your patch f=
ix any
>>> other malformed addresses, or just this particular type?
>>
>> See above.
>
> Ok, I see I am falling into the same communication trap as Jonathan, =
so
> let's be more explicit.
>
> Your commit message first tells me you are going to sanitize somethin=
g,
> but starts out with examples of leaving the string unchanged. =C2=A0T=
hen it
> continues with only the '>>' examples.

Which is why I added a paragraph to explain them. What is unclear about=
?

---
According to commit 155197e[1], the "prhase" should not be empty, so
if it is, remove the
<>. Extra characters after the first ">" are ignored.
---

> Today, and being someone who on average reads about half the mail tha=
t
> comes through here, I know that this relates to the blame -e '>>' bug=
=2E
> So today, I am wondering from the commit message why you narrowly foc=
us
> on that bug. =C2=A0But you don't! =C2=A0It's just that the commit mes=
sage
> insinuates it.

The summary explains the purpose of the patch "add extra safety in
address sanitation" (should fix those typos though).

> In a year, your reader (and bear in mind that this may very well be
> yourself, at least if your memory is as good as mine) will wonder wha=
t
> was so damn special about that '>>' string that it needs a specific f=
ix
> to send-email.

It doesn't matter, could be "<foo@bar.com> err blop", or any number of
other malformed strings.

> I see that you wrote in another thread:
>
>> I have to write a peer-reviewed essay with an introduction for the
>> people that are not familiar with the code in each of the patches
>
> I'm not sure you meant it that literally, but the whole *point* is th=
at
> the message is for people who are not familiar with the code. =C2=A0A=
fter
> all, if I knew that your code did the right thing in the right way, I
> would not be bothering with reading the message. =C2=A0Today, I would=
 just
> send an Acked-by instead. =C2=A0In a year, I'd scroll down for anothe=
r
> potential culprit for the bug I'm hunting.

You are assuming too much. In this case, the code is clear and doesn't
need explaining. I am talking about other cases which in my mind are
akin to explaining what is $recipient, $recipient_name, and what does
sanitize_address does, and why the if case for is_rfc2047_quoted is
modified. IMO that's overkill.

If you have some suggestion about how to improve the commit message, I
would be glad to listen to them, as in this case, I do believe the
changes merit some clear explanation. Not all patches do, though.

> What's especially striking me about your proposed messages of late: t=
hey
> leave me with more open questions than I started with. =C2=A0I tried =
to show
> this above. =C2=A0I'm not sure whether other contributors are better =
at
> answering questions, or just better at not touching any topics that
> might raise them.

Again, what is not clear about:

---
Basically, we try to check that the address is in the form of
"Name <email>", and if not, assume it's "email". According to commit
155197e[1], the "prhase" should not be empty, so if it is, remove the
<>. Extra characters after the first ">" are ignored.
---

To me that explains what the patch is trying to do: "add extra safety
in address sanitation".

Anyway, it seems people don't care if 'git send-email' attempts to
send random garbage regardless, so I'm not going to pursue this patch.

Cheers.

--=20
=46elipe Contreras
