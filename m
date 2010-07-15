From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is supported
Date: Thu, 15 Jul 2010 18:44:10 +0000
Message-ID: <AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>
	<AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
	<7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 20:44:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZTQ8-0005M4-Go
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 20:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934165Ab0GOSoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 14:44:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64441 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934060Ab0GOSoL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jul 2010 14:44:11 -0400
Received: by iwn7 with SMTP id 7so1251747iwn.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hLEk30GKW2zasyXC26kX55GKjpCf7t4MjQh2O9UIzTQ=;
        b=XYd4tMQzL9V6a1SXEy1lUAyFwIxj4NYxS2wbfGulSTgcJZASx6HKwUmiYwIzlGCGna
         pEbTvU2O4EBtfiODXo88FSRK/cHpJ/xwZbKj/CWNDy7X2Ul0DpLUjVwZmwhvesVeg3l0
         A7syiriBlrzKpWSo8wd9yTKJV6GA4e6AKKuS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OAnNOb8sR5/jXop2pzCfl8oQnkW3eedyKtnRIVtPzEBtI2gyJ3vHulM+bUw/HaBCFP
         PF8MtZJGbzsmOkSsLktjaRTTdYttjVa9X0FazRuQYyrSPn5E3jTKhgOXuQMM3b2TKfsR
         +OA92y2tYQ4PrRdiGGCD87Mw/HTm7kjM/3Evw=
Received: by 10.231.34.11 with SMTP id j11mr7789773ibd.120.1279219450996; Thu, 
	15 Jul 2010 11:44:10 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 15 Jul 2010 11:44:10 -0700 (PDT)
In-Reply-To: <7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151104>

On Thu, Jul 15, 2010 at 17:47, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Jul 8, 2010 at 19:40, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> wri=
tes:
>>>
>>>> +if git grep ile a
>>>> +then
>>>> + =C2=A0 =C2=A0 test_expect_success 'git grep ile a' 'git grep ile=
 a'
>>>> +else
>>>> + =C2=A0 =C2=A0 test_expect_failure 'git grep ile a' 'git grep ile=
 a'
>>>> +fi
>>>
>>> So if command "X" is known to succeed, we run it inside expect_succ=
ess
>>> and if not we run it inside expect_failure?
>>>
>>> What kind of idiocy is that, I have to wonder...
>>
>> Well, the point is to normalize the test suite so that we never have
>> passing TODO tests if everything's OK.
>
> I do not consider a test that passes under some condition but doesn't
> under some other condition "everything is OK". =C2=A0Marking the test=
 as
> "expect failure" as Ren=C3=A9 originally did makes a lot of sense to =
me.
>
> The quoted patch is even worse as it will _actively_ prevent you from
> catching a new error you just introduced while futzing "git grep" on =
a
> platform that used to work. =C2=A0Your "if" statement will say "ah, g=
rep is
> broken", and you will use expect-failure, not because your platform d=
oes
> not support REG_STARTEND, but because you broke "git grep".
>
> The point of having tests is to help you catch your bugs while you
> develop. =C2=A0A test that turns itself off when the feature it is te=
sting is
> broken helps nobody.
>
> So forget about "passing TODO tests", whatever a "TODO test" is. =C2=A0=
The
> change in question is actively _wrong_.

I was under the impression that REG_STARTEND was considered purely
icing on the cake, i.e. that the tests should be passing whether or
not it was present.

I guess my reasoning at the time was that if that wasn't the case,
reporting an unexpected pass by default, as opposed to a failing TODO
on platforms without REG_STARTEND. Since only TAP will report this, I
thought that was just an omission.

Anyway, since REG_STARTEND *isn't* obviously considered icing you're
of course right, but the test is still broken as-is. Now it reports an
abnormal condition if REG_STARTEND is present (passing TODO test), it
should instead have a failing TODO test where REG_STARTEND isn't
present. I'll come up with a patch to fix that.

We should also just upgrade the GNU regex library in compat/regex to
the version that supports REG_STARTEND. Unfortunately that seems
easier said than done, since the library is now part of glibc, and has
aquired a lot of glibc specific macros and other constructs that would
need to be #defined away or otherwise worked around.

Thanks for the review.
