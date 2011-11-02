From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Thu, 3 Nov 2011 00:35:12 +0100
Message-ID: <CAGdFq_h+Hpv9perLTU2rbdT6oZ3kZy22t5nghJQeEjNGvunL+A@mail.gmail.com>
References: <4E417CB4.50007@ramsay1.demon.co.uk> <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
 <7vpqjgyvn1.fsf@alter.siamese.dyndns.org> <4E68FE73.4000005@ramsay1.demon.co.uk>
 <20110908182055.GA16500@sigill.intra.peff.net> <4E6D089C.4090006@ramsay1.demon.co.uk>
 <CALxABCbnZp-y0Fqzoa=Ab92P+hsT7hs3nXZsnA=ph3yGfkXhdA@mail.gmail.com>
 <7vfwi7lc54.fsf@alter.siamese.dyndns.org> <CALxABCbKSi-aHezjyn5wJ0-BPW1PvvaC2i9VeV7yXOf4yCdx4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 00:36:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLkLf-0000Ul-0m
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 00:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab1KBXfy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 19:35:54 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56084 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629Ab1KBXfy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 19:35:54 -0400
Received: by qabj40 with SMTP id j40so667368qab.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=y9IB0iSo+ekkS2k7DElqBHK5v7jzyFgL3O0BrTjq3LQ=;
        b=B4QKyL2vo9x54HrF8i4e0JL5gyDBmvrRaKRFwAsQSs8G+ose+YgSFHL+v3nTwO/2yo
         R8xBFaGVuxPAQ2p+a8sM4svPL/+FXvUPTJKDP8Q2rEzfzA4VgzmZREoGpA2EbizeHLJv
         oI87O2KGX8oGZ6aY57sOuha/LQR4VmMTmfVD4=
Received: by 10.182.227.7 with SMTP id rw7mr1303162obc.70.1320276953232; Wed,
 02 Nov 2011 16:35:53 -0700 (PDT)
Received: by 10.182.52.3 with HTTP; Wed, 2 Nov 2011 16:35:12 -0700 (PDT)
In-Reply-To: <CALxABCbKSi-aHezjyn5wJ0-BPW1PvvaC2i9VeV7yXOf4yCdx4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184683>

Heya,

On Wed, Nov 2, 2011 at 00:02, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Tue, Nov 1, 2011 at 23:18, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>>> On Sun, Sep 11, 2011 at 21:14, Ramsay Jones <ramsay@ramsay1.demon.c=
o.uk> wrote:
>>>> ... these hangs *are* the failures of which I speak! =C2=A0Yes, th=
e script
>>>> doesn't get to declare a failure, but AFAIAC a hanging test (and i=
t
>>>> isn't the same test # each time) is a failing test. :-D
>>>
>>> Was there any outcome of this discussion? I'm asking because I
>>> can reproduce this very reliably on a little server here.
>>
>> I do remember this discussion and recall seeing _no_ outcome.
>>
>> I did see the hang myself once or twice but did not and do not have =
a
>> reliable reproduction. I have been waiting for somebody to raise the=
 issue
>> again ;-).
>>
>
> I think I managed to bisect it (between 1.7.6 and 1.7.7):
>
> $ git bisect start v1.7.7 v1.7.6
> ...
> $ git bisect good
> a515ebe9f1ac9bc248c12a291dc008570de505ca is the first bad commit
> commit a515ebe9f1ac9bc248c12a291dc008570de505ca
> Author: Sverre Rabbelier <srabbelier@gmail.com>
> Date: =C2=A0 Sat Jul 16 15:03:40 2011 +0200
>
> =C2=A0 =C2=A0transport-helper: implement marks location as capability
>
> =C2=A0 =C2=A0Now that the gitdir location is exported as an environme=
nt variable
> =C2=A0 =C2=A0this can be implemented elegantly without requiring any =
explicit
> =C2=A0 =C2=A0flushes nor an ad-hoc exchange of values.
>
> =C2=A0 =C2=A0Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> =C2=A0 =C2=A0Acked-by: Jeff King <peff@peff.net>
> =C2=A0 =C2=A0Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> :100644 100644 1ed7a5651ef5a2320c56856b5a1fe784e178ab23
> e9c832bfd3da7db771cc2113027d3e590dc51d59 M =C2=A0 =C2=A0 =C2=A0git-re=
mote-testgit.py
> :100644 100644 0cfc9ae9059ce121b567406d7941b71cd54b961c
> 74c3122df1835c45a6b621205fb18b4fc89af366 M =C2=A0 =C2=A0 =C2=A0transp=
ort-helper.c
>
> Sadly, I'm going to be able to repeat the test in about 20 hours.

=C3=86var, this seems like something we could look at during the mini
GitTogether in Amsterdam this Saturday, no?

--=20
Cheers,

Sverre Rabbelier
