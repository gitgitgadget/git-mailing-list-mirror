From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 18:24:54 +0000
Message-ID: <AANLkTikk8nVyvp0hTycMY9bjMub38msxrOHMMLNER_DS@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<7v39tveq0j.fsf@alter.siamese.dyndns.org>
	<AANLkTinKgOdgTpORf-NSJ1wpURw9xOkQ3rXZvmV6XtBb@mail.gmail.com>
	<20100831180832.GQ2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:25:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVW1-0000nG-VP
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab0HaSY4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 14:24:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53186 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0HaSY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 14:24:56 -0400
Received: by fxm13 with SMTP id 13so4159323fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7af4t/Jmr0W9uvMA+Sfu5V8RpITksBFTCtrMbKacEmE=;
        b=N2Om5qwOo0uNnLQphhohKV38x74evd+o3FUnPWRODkORsiE7hfQEDyuPbr70zBbwg9
         pR/yOquWWa7i6rYTE9zMtCsn5Yo7ycnyzdO7r7rVinCK463mkKRxM7ZEDGNjClw6yroA
         7yUnPovFq6lS4gWyDWe6LpVaEjGQabzccZoGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RdkpZEe0xmE5Sh5gsCUFDTXrBq/FC7SDn2aG9ZPqB/ibEcV3G3+t26HOZQVISkzWEx
         2ZpSIvRvSIiQjqOnTQat0ZtCmXGE8zXfYaU7xjarB0TcXnHnRA/SzAYriVtOKkAJcIQ2
         EiKRQ0xKeOlxi1YqAaqMEDMFgG0SY6VIoa60Q=
Received: by 10.223.116.6 with SMTP id k6mr5899976faq.49.1283279094424; Tue,
 31 Aug 2010 11:24:54 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 31 Aug 2010 11:24:54 -0700 (PDT)
In-Reply-To: <20100831180832.GQ2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154957>

On Tue, Aug 31, 2010 at 18:08, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Or: git://github.com/avar/git.git gettextize-git-mainporcelain-v2
>
> Is that against "next"? =C2=A0For an RFC that's okay, but for a serie=
s
> that will be part of a release it can be tedious to separate out
> (not all topics in "next" necessarily are released, and "next"
> traditionally gets rewound after each release).

Yes it's against next since it had the gettext series merged and next
is about to be released isn't it? I could base it on something else if
that's appropriate.

> Comments on the patches:
>
> =C2=A0Makefile: use variables and shorter lines for xgettext
>
> The -o<whatever> passed to cc isn't usually included in CFLAGS,
> and a part of me is similarly uncomfortable with including it in
> XGETTEXT_OPTIONS. =C2=A0Isn't that parameter something that should be
> possible to change in the build system independently from the
> user's XGETTEXT_OPTIONS preferences?

Maybe, but it'll always be --output=3Dpo/git.pot so I saw no reason to
seperate it. Should it be? The -o for the C compiler changes, but the
"make pot" target will always write to po/git.pot.

> =C2=A0gettext.c: work around us not using setlocale(LC_CTYPE, "")
>
> The perror() problem shows up with strerror(), too, of course.
> (perror just made for an easier demo.)

Yeah, and everything external like that, unfortunately.

> =C2=A0gettext: Make NO_GETTEXT=3DYesPlease the default in releases
>
> Copy-edits for the notes in INSTALL:
>
>> + =C2=A0 =C2=A0 =C2=A0 - Git includes EXPERIMENTAL support for local=
ization with gettext
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 which is currently disabled by default=
 in official Git
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 releases.
>
> s/EXPERIMENTAL/experimental/? =C2=A0No need to shout.

OKEY THEN!

> I'd also s/currently // since this will not be current after a while.

ok.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you really want to build it you hav=
e to specify NO_GETTEXT=3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 as a Makefile argument. If you're a do=
wnstream distributor
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 please don't do so without consulting =
with the Git Mailing List
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 first about the stability of this feat=
ure.
>
> Similarly I'd s/really //. =C2=A0If we want to dissuade people from t=
rying
> it out, we should probably do that with more explicit statements.

Thanks.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 It's only being included in releases s=
o that source messages can
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 be marked for translation without resu=
lting in painful and
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 inevitable merge conflicts between Git=
's pu branch and the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 rest. END WARNING.
>
> Not sure what this means. =C2=A0Maybe:
>
> =C2=A0The infrastructure is only included in this release to avoid
> =C2=A0complications in building other work on top of it. =C2=A0If you=
 turn
> =C2=A0it on, expect breakage.

Yes, that's better. I've worked all these into a
gettextize-git-mainporcelain-v3 branch at the same repository:

    http://github.com/avar/git/compare/gettextize-git-mainporcelain-v2.=
=2E.gettextize-git-mainporcelain-v3

Or: git://github.com/avar/git.git gettextize-git-mainporcelain-v3
