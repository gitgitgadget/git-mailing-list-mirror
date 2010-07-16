From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is supported
Date: Fri, 16 Jul 2010 21:19:40 +0000
Message-ID: <AANLkTim4iI-MMkSCEU6ln9wrlC_X1GvfMHM5Qij3P591@mail.gmail.com>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>
	<AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
	<7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
	<AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
	<AANLkTimZ3f550HQwx3OEpO6n1b037He6hJ6rAXP8vfIk@mail.gmail.com>
	<20100716195007.GC16371@burratino>
	<AANLkTikDwJaBN8Y0814m6JaVab9BAXPx_VKE7Z_Q6hq7@mail.gmail.com>
	<20100716210609.GA23044@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 23:19:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZsK3-0005Ea-Jq
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 23:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759191Ab0GPVTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 17:19:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47788 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab0GPVTl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 17:19:41 -0400
Received: by iwn7 with SMTP id 7so2544350iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TIClqkum+onKe9hCyoX2nWrhKv6B/9t+T1o6U77Sll0=;
        b=PK2waoawX+92b1GhgrFiLkRpRy7lTkSi5d307RGgX0cIdguvmQymAKunGxFWZUEf2q
         j8fTNITVx0AiHEAGidsFF6FwF3x/j7m+jYbMZuUB5Dfe/pzZ76CWvTEyYxM14nQcsXlc
         lZcZG/1+76YsVO02kVact8AZhDmfPK8slzpJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hJI0sa6/TjNndybtFtYv2Cnt0JSkzR+aqYefwNXAC7o1CizukOU+EAxsJ1wIfNdJdU
         iHzMozDs2KaW+FhMM1KBvUSI6Fw70v1UPKaro5d9WDXSNijNekIjtyObNvENdS7cXcqw
         uVRRUdQNwUc1hg6+xuzPragpbFmJgZALHnYKc=
Received: by 10.231.37.75 with SMTP id w11mr1426871ibd.45.1279315180483; Fri, 
	16 Jul 2010 14:19:40 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 16 Jul 2010 14:19:40 -0700 (PDT)
In-Reply-To: <20100716210609.GA23044@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151174>

On Fri, Jul 16, 2010 at 21:06, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> The failure is totally predicated on whether or not REG_STARTEND is
>> available on the system
> [...]
>> Then you could do:
>>
>> =C2=A0 =C2=A0 test_expect_success REG_STARTEND 'git grep ile a' '
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 git grep ile a
>> =C2=A0 =C2=A0 '
>
> Sorry to harp on this, but no, that would not be right. =C2=A0When
> REG_STARTEND is not available on a system, this is still a bug and
> we still want to know when it is fixed. =C2=A0The test should not be
> skipped.
>
> So one could do:
>
> =C2=A0if have_reg_startend
> =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0expectation=3Dsuccess
> =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0expectation=3Dfailure
> =C2=A0fi
> =C2=A0test_expect_$expectation 'git grep ile a' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git grep ile a
> =C2=A0'

Well, the assumption I was making that we would do something in the
make or ./configure process to set NO_REGEX=3DYesPlease if we found tha=
t
the system didn't support REG_STARTEND, and fail loudly if that
requirenment wasn't met.

However, what you posted above would be what we'd want if we wanted a
soft requirement. Maybe that's what we want, I don't know :)

>> The glibc one is probably pretty good as far as minimal POSIX DFA
>> engines go. Hopefully you can patch it up to get it to compile on
>> non-GNU systems.
>
> No promises, in particular because I don=E2=80=99t have any non-GNU
> installations handy to test on. =C2=A0Probably gnulib=E2=80=99s copy =
will do,
> as Andreas suggested.

Probably, I didn't look closely at it.

>> Regarding regular expression implementations. We might want to look
>> into bundling one implementation and using it everywhere
>
> Please no. :)
>
> If we can do better than glibc, then glibc should be improved (yes,
> I know GNU grep does much better than glibc already).

I think engines like GNU grep get some of their speed by not
supporting some POSIX features. So it's not something you can
completely solve at the libc level, since regcomp/regexec should only
have POSIX semantics.

But I should find out if we need this before we discuss this any
further, if it's a big performance win when e.g. grep-ing through the
entire history of Linux it might be worth it.

>> Using NFA engines like that also gives you some performance guarante=
es
>
> Do you mean =E2=80=9Cusing DFA engines=E2=80=9D? =C2=A0i.e. I thought=
 GNU grep avoids
> backtracking by converting the NFA to a DFA, at least conceptually.

Yes, I always mix up my NFA and DFA at this time of night. I should
just start writing whatever I think I don't mean, and that'll be what
I mean :)
