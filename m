From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/4] cleanup: use internal memory allocation wrapper
 functions everywhere
Date: Thu, 6 Oct 2011 12:17:24 -0500
Message-ID: <CA+sFfMdxxZJd6t+KZMz67mSEw=FizYukod2Rd+9Fu17NLwrAhg@mail.gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
	<1316051979-19671-1-git-send-email-drafnel@gmail.com>
	<1316051979-19671-3-git-send-email-drafnel@gmail.com>
	<4E71A0C7.8080602@viscovery.net>
	<CA+sFfMdVntk+U13UeMO=k1SCKJGhPfTpC9_i9kFOkbUJXrF-qg@mail.gmail.com>
	<CA+sFfMf73K3yv_5K633DKOsVufMV6rTjd+SSunq4sBikt4jCsg@mail.gmail.com>
	<CA+sFfMdHpvdMU==a2sUR9sZZCcgqPfGF7+dy6yi8RVoMZ+uZVA@mail.gmail.com>
	<4E8D4812.9090102@viscovery.net>
	<CA+sFfMf8_7ccC9kjEq=2NrehVgS=ahnQA8VibEF10VaULot7=A@mail.gmail.com>
	<CABPQNSak_jDbNQhzMoSN=NdWmyby3xJRwED54Ck5H1Y12HoGCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"peff@peff.net" <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>,
	"bharrosh@panasas.com" <bharrosh@panasas.com>,
	"trast@student.ethz.ch" <trast@student.ethz.ch>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 06 19:17:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrZb-0001GX-S8
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672Ab1JFRR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 13:17:26 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46759 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab1JFRR0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 13:17:26 -0400
Received: by ggnv2 with SMTP id v2so1930795ggn.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=S2cP8LGuIjARnsd5bwVGm8zRJ7uSkzq2R9EWuahgM60=;
        b=FbbI182aqOCW05DUZKX0CyM2wB4qbJD2E0A2uf0VWEu6uA2kl7S/rYhYR7+ZHXKyQ9
         LJq0+DW0a/Vj2/VFn432w+eg4meb6RmwOSFlJgjuOwR0RTZukvFETYbEKEqz0ZAIpDYQ
         uIcP0qUb4EjMVLFg8qoj5udWxtAGycDwr5FkU=
Received: by 10.223.61.211 with SMTP id u19mr4756420fah.29.1317921444909; Thu,
 06 Oct 2011 10:17:24 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 6 Oct 2011 10:17:24 -0700 (PDT)
In-Reply-To: <CABPQNSak_jDbNQhzMoSN=NdWmyby3xJRwED54Ck5H1Y12HoGCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182985>

On Thu, Oct 6, 2011 at 11:50 AM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Thu, Oct 6, 2011 at 6:14 PM, Brandon Casey <drafnel@gmail.com> wro=
te:
>> [removed Alexey Shumkin from cc]
>>
>> On Thu, Oct 6, 2011 at 1:17 AM, Johannes Sixt <j.sixt@viscovery.net>=
 wrote:
>>> Am 10/6/2011 4:00, schrieb Brandon Casey:
>>>> [resend without html bits added by "gmail offline"]
>>>> On Wed, Oct 5, 2011 at 7:53 PM, Brandon Casey <drafnel@gmail.com> =
wrote:
>>>>> On Thursday, September 15, 2011, Brandon Casey wrote:
>>>>>>
>>>>>> On Thu, Sep 15, 2011 at 1:52 AM, Johannes Sixt <j.sixt@viscovery=
=2Enet>
>>>>>>> There is a danger that the high-level die() routine (which is u=
sed by
>>>>>>> the
>>>>>>> x-wrappers) uses one of the low-level compat/ routines. IOW, in=
 the case
>>>>>>> of errors, recursion might occur. Therefore, I would prefer tha=
t the
>>>>>>> compat/ routines do their own error reporting (preferably via r=
eturn
>>>>>>> values and errno).
>>>>>>
>>>>>> Thanks. =C2=A0Will do.
>>>>>
>>>>> Hi Johannes,
>>>>> I have taken a closer look at the possibility of recursion with r=
espect to
>>>>> die() and the functions in compat/. =C2=A0It appears the risk is =
only related to
>>>>> vsnprintf/snprintf at the moment. =C2=A0So as long as we avoid ca=
lling xmalloc et
>>>>> al from within snprintf.c, I think we should be safe from recursi=
on.
>>>>> I'm inclined to keep the additions to mingw.c and win32/syslog.c =
since they
>>>>> both already use the x-wrappers or strbuf, even though they could=
 easily be
>>>>> worked around. =C2=A0The other file that was touched is compat/qs=
ort, which
>>>>> returns void and doesn't have a good alternative error handling p=
ath. =C2=A0So,
>>>>> I'm inclined to keep that one too.
>>>
>>> I'm fine with keeping the change to mingw.c (getaddrinfo related) a=
nd
>>> qsort: both are unlikely to be called from die().
>>>
>>> But syslog() *is* called from die() in git-daemon, and it would be =
better
>>> to back out the other offenders instead of adding to them.
>>
>> Ah. =C2=A0Yes, you're right. =C2=A0x-wrappers should not be used in =
syslog.c and
>> the use of strbuf's should be replaced.
>
> Good point. The patch for this looks something like this:
>
> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index 42b95a9..243538c 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -1,5 +1,4 @@
> =C2=A0#include "../../git-compat-util.h"
> -#include "../../strbuf.h"
>
> =C2=A0static HANDLE ms_eventlog;
>
> @@ -16,13 +15,8 @@ void openlog(const char *ident, int logopt, int fa=
cility)
>
> =C2=A0void syslog(int priority, const char *fmt, ...)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 struct strbuf sb =3D STRBUF_INIT;
> - =C2=A0 =C2=A0 =C2=A0 struct strbuf_expand_dict_entry dict[] =3D {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {"1", "% 1"},
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {NULL, NULL}
> - =C2=A0 =C2=A0 =C2=A0 };
> =C2=A0 =C2=A0 =C2=A0 =C2=A0WORD logtype;
> - =C2=A0 =C2=A0 =C2=A0 char *str;
> + =C2=A0 =C2=A0 =C2=A0 char *str, *pos;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int str_len;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_list ap;
>
> @@ -39,11 +33,20 @@ void syslog(int priority, const char *fmt, ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0str =3D malloc(str_len + 1);
> + =C2=A0 =C2=A0 =C2=A0 if (!str)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /* no chan=
ce to report error */
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_start(ap, fmt);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0vsnprintf(str, str_len + 1, fmt, ap);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_end(ap);
> - =C2=A0 =C2=A0 =C2=A0 strbuf_expand(&sb, str, strbuf_expand_dict_cb,=
 &dict);
> - =C2=A0 =C2=A0 =C2=A0 free(str);
> +
> + =C2=A0 =C2=A0 =C2=A0 while ((pos =3D strstr(str, "%1")) !=3D NULL) =
{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D realloc(st=
r, ++str_len + 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!str)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(pos + 2, p=
os + 1, strlen(pos));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pos[1] =3D ' ';
> + =C2=A0 =C2=A0 =C2=A0 }

Is there any reason not to just use a different character than '%'
when replacing '%n'?  Like '@'?  Then the replacement could be done
in-place.

e.g. convert this:

   fe80::3%1

into this:

   fe80::3@1

I'm not usually on a windows platform, so maybe adding the space is
the common thing to do when trying to write an ipv6 address to the
event log using ReportEvent().  If not, then I think people would
probably figure out easily enough that '@n' referred to interface 'n'.

-Brandon
