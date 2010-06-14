From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Make the Git tests emit TAP format
Date: Mon, 14 Jun 2010 22:10:23 +0000
Message-ID: <AANLkTinHrf_ZuuoMXlL8BFqm3UhRYxrV4t2Nmp5QNjrE@mail.gmail.com>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
	<m3631lp9oe.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 00:10:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOHrT-0002gV-8w
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 00:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab0FNWK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 18:10:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45685 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0FNWKZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 18:10:25 -0400
Received: by iwn9 with SMTP id 9so3785298iwn.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SBr9vUmm9ZCgwqGaHCp1smIj5FEAhZQF3+WZEYfxw5o=;
        b=HckJvMx4Kdy/LsjZYGYJvgHNdgmmBopaYxCV7KTuk6vM/QL1QuiuGOC+o3gUrCPSxr
         PQ+ig+27IA122ToNjOv7uDD+LfGsXCLbPee+8H2MtO6V8yOO/4nUgxr1Qljc37axZl9n
         klzGqJe57YhYi0+dZhc5SSxzdpH99bEOPbu+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BptkWaLTTru39Q/7igYu0slrLK1DRRHmPSQU8jRHWPbDyiOGDGElVuqL5mwuoyw6ng
         EjcSC7f7/vKoZgLY1BR2CgfbxSwEqUXfe6McFicWhnisNDKFWugKCFvifMna8k85u/Ns
         nkigHaFjuwf6epqYnnfp3P6srngxtqq7AxWaA=
Received: by 10.231.170.1 with SMTP id b1mr6346506ibz.13.1276553423371; Mon, 
	14 Jun 2010 15:10:23 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Mon, 14 Jun 2010 15:10:23 -0700 (PDT)
In-Reply-To: <m3631lp9oe.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149142>

On Mon, Jun 14, 2010 at 21:49, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> All this series does is slightly adjust the raw text output of our
>> tests so that it conforms. to the TAP standard, i.e. instead of this=
:
>>
>> =C2=A0 =C2=A0$ ./t0005-signals.sh
>> =C2=A0 =C2=A0* =C2=A0 ok 1: sigchain works
>> =C2=A0 =C2=A0* passed all 1 test(s)
>>
>> We get this:
>>
>> =C2=A0 =C2=A0$ ./t0005-signals.sh
>> =C2=A0 =C2=A0ok 1 - sigchain works
>> =C2=A0 =C2=A0# passed all 1 test(s)
>> =C2=A0 =C2=A01..1
>>
>> Changing the output format like this gives us the ability to run the
>> Git tests with any TAP tool (like prove(1)) at no extra cost. Every
>> other existing way of running the tests continues to work, it's just
>> easier for machines to read the output now.

I'll re-submit a version of the patch with a better commit message
which addresses all of the below.

> This doesn't tell us if the result of running test suite with
> '--verbose' and/or with '--debug' changes, and if changes how? =C2=A0=
Is it
> compatibile with TAP format so that TAP parsers understand it?

It just changes in that the lines that previously said e.g. "* =C2=A0 o=
k 1:
sigchain works" now say "ok 1 - sigchain works".

TAP parsers still understand it, since ignoring unknown garbage is
part of the TAP standard.

> It doesn't tell us if (as I assume) after change git test suite still
> generates summary of tests in t/test-results/. =C2=A0Do those results
> change, and if change then how?

The semantics of t/test-results don't change at all since that's
aggregated internally by test-lib.sh guts that aren't changed in this
series.

> It doesn't tell us if (as I assume) we still have the same color
> output as we had before, and what we should do to have the same color
> output e.g. from TAP tests in Perl.

The color output is still there if you run the tests under `make test'
or manually.

Under TAP consumers like prove(1) the tests won't output color since
the TAP Harness will set a dumb terminal.

That's a good thing, since we shouldn't emit terminal escape codes
with TAP. The output could be used for e.g. a HTML page instead of a
terminal.

> +1
>
> In my opinion it is a good change, because there are many tools that
> understand TAP output format (and being able to output tests in Perl
> via standard Test::Simple / Test::More is also nice). =C2=A0Those inc=
lude
> e.g. Smolder and prove(1).
>
> It would be nice to have something like CPAN Testers
> (http://cpantesters.org) but for git test suite. =C2=A0Junio would be=
 able
> to submit new version of git and check if it breaks on some uncommon
> architecture...

There's been a lot of good changes to the CPAN Testers infrastructure
lately. We could probably just set up a copy of their software.

Then anyone could run a smoker on some odd OS/architechture and send
in test results.

> P.S. I wonder who was original designer of git tests output format,
> ans why it was chosen this way (and e.g. why not TAP)...

It was originally discussed here:
http://thread.gmane.org/gmane.comp.version-control.git/2901/focus=3D307=
6

It seems that the people involved weren't aware of TAP at the time, at
least it wasn't brought up.
