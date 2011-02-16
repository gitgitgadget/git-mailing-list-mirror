From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How you can translate things now, and a plan for the i18n series
 going forward
Date: Thu, 17 Feb 2011 00:57:46 +0100
Message-ID: <AANLkTi=E0LYWp7ag8SD8LNCKkKopGczJL0QnuOiH2UEu@mail.gmail.com>
References: <AANLkTim+_zRisVRfnv_Xe69xof3e8rL_BAXxmAsCwins@mail.gmail.com>
	<7vipwpxbam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, kev <kev@riseup.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 00:57:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PprFp-0006in-HZ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 00:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322Ab1BPX5t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 18:57:49 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61259 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab1BPX5r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 18:57:47 -0500
Received: by fxm20 with SMTP id 20so2020704fxm.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 15:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9C+Iwm1JUfRexYzJsDFYm+yqq/ZpZp4N0eqW1Va8Xhs=;
        b=fO2P0iJi0XVYoqmp44VpX7Ud0JEiOyafFX5BUaL4wGAimLYouiQ6p8mptIHihGtPvO
         bLLs0+jfM/+XTOUzFAWaj8MC1aup/s6JKDNsOpAv1yNpF8l4xM7ptntqkTJ1Fs0jwJOH
         0yECAvD7xaxFGzetbs3vG9j/7LxgkoolpqdAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TFdSQPJ+wqPA+tSukMITjtEWT00WNZZeIdujaottKs7KxOw+6mR0pSHjLLNGpCVNh7
         BUukk+uITpLKw3muevDomOw7uRlbkcirzmrqH7D+Lg2kuyii+vC+Al4mAhi2iOxIpAVF
         4CO1ZG4adB6dJK7ABHKnloTEEql0SdQFp/DZg=
Received: by 10.223.114.209 with SMTP id f17mr1517539faq.136.1297900666251;
 Wed, 16 Feb 2011 15:57:46 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Wed, 16 Feb 2011 15:57:46 -0800 (PST)
In-Reply-To: <7vipwpxbam.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167022>

On Sat, Feb 12, 2011 at 21:12, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> =C2=A0 =C2=A0 *** TODO Introduce a skeleton no-op gettext, just the
>> infrastructure minus the interesting stuff
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 I.e. just add:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #define N_(s) (s)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #define _(s) (s)
>>
>> =C2=A0 =C2=A0 *** TODO Add no-op C gettextize patches
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 This will change "foo" to _("foo") every=
where, but will be a no-op
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 due to it being macroed out.
>
> It would be best to get this as early as possible while not many topi=
cs
> are in 'next'; it is preferrable if we can rebase other topics in 'pu=
' on
> top of the result of this step.

Here's a work-in-progress version of this:
https://github.com/avar/git/compare/master...ab/i18n-c-_-only

I still have to:

 * Add NO_GETTEXT_POISON to more tests, some things have broken due to
   new strings / changed tests.

 * Squash the !fixup patches in appropriately.

But otherwise does this seem good? I.e. having just those stub macros,
a lot of *.c patches, including gettext.h in cache.h.

And having NO_GETTEXT_POISON be part of the actual patches, of course
I'd also have to add something to the test suite to always set that
for now.
