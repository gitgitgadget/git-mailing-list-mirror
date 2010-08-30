From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Mon, 30 Aug 2010 08:57:34 +0000
Message-ID: <AANLkTin4A6B9zqSYHsWQ+GLWRqLvzJWAQ0F2WC85zDqC@mail.gmail.com>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
	<AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
	<20100828214641.GA5515@burratino>
	<20100828215956.GB5515@burratino>
	<alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
	<20100828221655.GB5777@burratino>
	<AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com>
	<20100829204519.GB1890@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 10:57:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq0BV-0006Ms-O6
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 10:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab0H3I5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 04:57:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53413 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab0H3I5g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 04:57:36 -0400
Received: by iwn5 with SMTP id 5so4746265iwn.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n+ONT1nYNqkRB6lEdDFiXpBp89zkY89zDUWdrwMJ/yg=;
        b=V6kaV4PVlux5oGS9SsRfHgLumciaBSGEcTE6HgOq9wUIij2LZqdRMDmqopplET+yy7
         euJrqq0cBKovmdXJKeO9YzJpYkfzJBvweSLnhTUjh71VrAXapxvmHv8Y35WAcs+9H+oL
         VeV6XVP9HVX2RVQRAnkD/4s6mOcTiPJqj+0yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cymYz961ubimY4gRgaky6s6OjFRfpW3l+WTJl0XFg3t3jYLW1PxW61f2e5xytXV3Fr
         7BrD4OfxqYOPQdxNIg5gslkQesXLTml9N11k42XS/M4HQIv9JuyoK4ReAh96tzIUdQvb
         mtvdN7sWXNv/1KwVUQCahkEqBtBaKIFxmfdA4=
Received: by 10.231.32.130 with SMTP id c2mr4819734ibd.194.1283158654953; Mon,
 30 Aug 2010 01:57:34 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 30 Aug 2010 01:57:34 -0700 (PDT)
In-Reply-To: <20100829204519.GB1890@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154777>

On Sun, Aug 29, 2010 at 20:45, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> So, my plan of attack is:
>>
>> =C2=A0* Add compat/printf from Free, Open or NetBSD. Maybe make
>> =C2=A0 =C2=A0compat/snprintf.c use that while I'm at it.
>
> I would prefer to get this fixed in glibc, but of course that
> has nothing to do with git.

Yeah, but even if it's fixed there everyone's glibc won't be updated
for at least ten years as far as the glibc's we have to support go.

So even if the bug were fixed upstream today we'd still need a
workaround.

>> =C2=A0* Use that instead of the GNU libc printf on systems that have=
 glibc.
>> =C2=A0* Add a configure check for that.
>> =C2=A0* Revert 107880a
>> =C2=A0* Get gettext goodness with LC_CTYPE
>>
>> Does anyone see a problem with that? The potential issue is that
>> LC_CTYPE is for:
>>
>> =C2=A0 =C2=A0 "regular expression matching,
>
> should be okay, I think (unless http-backend is a problem)

User-level commands that take regexes would have different semantics
based on the locale though, e.g. git log --grep=3D<regex>.

>> character classification,
>
> worked around (see git-compat-util.h)

Yay sane_istest!

>> =C2=A0 =C2=A0 conversion,
>
> I don't know what this means; iconv() is not affected by LC_CTYPE,
> is it?

I think it's only to do with functions like btowc, see:
http://www.gnu.org/s/libc/manual/html_node/Restartable-multibyte-conver=
sion.html#Restartable-multibyte-conversion

>> case-sensitive comparison,
>
> Could be a problem: we use strcasecmp() heavily.

Yeah, strcasecmp is affected by LC_CTYPE.

>> and wide character
>> =C2=A0 =C2=A0 functions."
>
> no problem. :)

Nope.

>> So it might have unintended side-effects. But the only other
>> workaround I can see is to decree that all consumers of the localize=
d
>> messages must have a UTF-8 locale.
>
> And that is no workaround at all; the problem is still seen with UTF-=
8
> locales, no?

No, it'll be seen with all non-UTF-8 locales. Here's the issue:

When we add non-ASCII to the po/*.po files we'll write it in UTF-8 as
a matter of policy, simply because that's all the rave these days.

However, unless we put "Content-Type: text/plain; charset=3DUTF-8\n" in
the file the gettext utilities won't *know* that it's in UTF-8, if
it's not there then to them it'll just be a raw stream of bytes. So
they won't do the right conversion under non-UTF-8 locales.

But users using a gettext translation under a UTF-8 locale won't tell
the difference, since the *.po encoding and their expected encoding
don't differ they don't need any conversion anyway.

We can even keep the "Content-Type: text/plain; charset=3DUTF-8\n" and
*not* use LC_CTYPE if we add a bind_textdomain_codeset("git", "UTF-8")
call to gettext.c. That call declares that the *.po file is in UTF-8
(but without LC_CTYPE there still won't be any conversion), see
http://www.gnu.org/s/libc/manual/html_node/Charset-conversion-in-gettex=
t.html#Charset-conversion-in-gettext

Here's a table explaining the various approaches:

    A: [correctness] LC_CTYPE + *.po charset=3DUTF-8
    B: [UTF-8-only hack] no LC_CTYPE + no *.po charset=3DUTF-8
    C: [UTF-8-only hack] no LC_CTYPE + A *.po charset=3DUTF-8 +
bind_textdomain_codeset("git", "UTF-8")

    | Approach | Correct *.po encoding header | GNU printf() issue |
LANG=3Dis_IS.utf8 OK | LANG=3Dis_IS.iso88591 OK  |
    |----------+------------------------------+--------------------+---=
-----------------+-------------------------|
    | A        | X                            | X                  | X
                 | X                       |
    | B        | No                           | No, no LC_CTYPE    | X
                 | No, still outputs UTF-8 |
    | C        | X                            | No, no LC_CTYPE    | X
                 | No, still outputs UTF-8 |

A would be preferred for correctness, and with a fallback BSD printf()
we can avoid the GNU libc bug, however that'll mean using LC_CTYPE,
which'll have some small side-effects for the rest of the code.
