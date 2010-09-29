From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 0/2] use libcharset.h with gettext if available
Date: Wed, 29 Sep 2010 10:00:14 +0000
Message-ID: <AANLkTin90pKaVGVaG-4PW50TAhgfp1QVtrKpvyVxpnW0@mail.gmail.com>
References: <AANLkTinHCETsaM=ytHuE9S5A+uAb=e3YLETsJJLga+DM@mail.gmail.com>
	<1285698577-28395-1-git-send-email-avarab@gmail.com>
	<AANLkTinxSqPD8H4Giigb1vbi7DC2wpDVqWmXGVZXmeKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 12:00:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0tSa-0007Rv-Lf
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 12:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab0I2KAQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 06:00:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58456 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab0I2KAO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 06:00:14 -0400
Received: by iwn5 with SMTP id 5so829112iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FF9FSPXwaGfm2I54VfYCFaTFY2EUuOceD7n3uQqG13c=;
        b=QW/zGimOblqp/qH3yitC+c7FSa0gk5vIzu44LqzDNKm1xkL7mBH+MuOH55zOvY+DO8
         ClOrV4SuQLHHCwCjYr8FRcoIcUZMzQkN4q0d1+JT0Y3+sDVe1TT0DljGekt1OXfipjTb
         6gWYfQdyDtta3qsJWQspHkvoffJN96x5H4Clk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=utaaEbdoLbWFS8k+trKxPVygt07QlgGpMAqrqTJA0UwQJYSqm8JsJ+HxUyAcPYqUJU
         Yucr4QaOohkJUGjknIfRG0cw4Uy5Z8twnd9+7k45QD/nQti25+rAEo+c5Gh88E+HTCc2
         /WeajfjzlldMzIHW7VJUAr/XmfHzyXmBE8ELI=
Received: by 10.231.11.130 with SMTP id t2mr1478379ibt.154.1285754414222; Wed,
 29 Sep 2010 03:00:14 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 29 Sep 2010 03:00:14 -0700 (PDT)
In-Reply-To: <AANLkTinxSqPD8H4Giigb1vbi7DC2wpDVqWmXGVZXmeKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157550>

On Tue, Sep 28, 2010 at 21:47, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Tue, Sep 28, 2010 at 8:29 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> Yeah, I'm hoping it'll get into next soon so we can get more
>> reports/fixes like these. Anyway, I amended your patches a bit, here
>> are the changes:
>>
>> =C2=A0* Split up the s/char*/const char*/ change into its own patch,=
 or is
>> =C2=A0 there a reason for why this needs to be there along with the
>> =C2=A0 libcharset.h change?
>>
>
> The reason was that my version of locale_charset() returns a const
> char *, so I got a warning if I didn't. nl_langinfo() returns a char
> *, so I don't think that constness-fix patch makes sense in itself.
> But what might make more sense would be to squash it into the origina=
l
> commit for that line.

Ah, then it should be part of the patch. I'll add a note about the
different prototypes to it.

>> =C2=A0* Added docs about the define to the Makefile
>>
>
> Nice!
>
>> =C2=A0* Added defaults for NO_LIBCHARSET to the default, I only chan=
ged the
>> =C2=A0 defaults for the MINGW entry, maybe it should be changed on C=
ygwin
>> =C2=A0 and Windows too? And probably on OpenBSD and NetBSD too.
>>
>
> I don't think NO_LIBCHARSET should be the default. libcharset is
> reported to be a bit better than nl_langinfo at normalizing the
> encoding, and GNU gettext depends on libcharset (through libiconv,
> which libcharset is distributed with). So in the case of a GNU
> gettext, libcharset should really be present.

I can't find any package (with apt-file) on Debian or Ubuntu that
provides libcharset.h, but I have langinfo.h on those systems.

The GNU gettext manual also reccomends the use of nl_langinfo in
"11.2.4 How to specify the output character set `gettext' uses", so it
seems that using that and not libiconv is the default way of doing
things on GNU gettext + GNU libc systems.
