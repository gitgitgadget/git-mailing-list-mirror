From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/4] cleanup: use internal memory allocation wrapper
 functions everywhere
Date: Wed, 5 Oct 2011 21:00:44 -0500
Message-ID: <CA+sFfMdHpvdMU==a2sUR9sZZCcgqPfGF7+dy6yi8RVoMZ+uZVA@mail.gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
	<1316051979-19671-1-git-send-email-drafnel@gmail.com>
	<1316051979-19671-3-git-send-email-drafnel@gmail.com>
	<4E71A0C7.8080602@viscovery.net>
	<CA+sFfMdVntk+U13UeMO=k1SCKJGhPfTpC9_i9kFOkbUJXrF-qg@mail.gmail.com>
	<CA+sFfMf73K3yv_5K633DKOsVufMV6rTjd+SSunq4sBikt4jCsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "peff@peff.net" <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>,
	"bharrosh@panasas.com" <bharrosh@panasas.com>,
	"trast@student.ethz.ch" <trast@student.ethz.ch>,
	"zapped@mail.ru" <zapped@mail.ru>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 04:01:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBdGz-0002Cq-2j
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 04:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab1JFCAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 22:00:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65440 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab1JFCAp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 22:00:45 -0400
Received: by eya28 with SMTP id 28so2192790eya.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 19:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=onfdQt3Jcvewjf3IsIbIVdXAjV7GDZjJ/2kw5ilvMcY=;
        b=q+qm1DmjoGyZSLX+iXOqUJIdUJrD3+kDx8I4B261EVZJaOHEDH8Eg0/Dt7+f/pPIEu
         J5OnDjXxQN7WLcVNAAooSsMMBE7ThMQxAwB6gSMvN+JLGO56JGpZDZru/PjH3ufPhwUL
         JBDfWKwyMlMfnM9mPNvzkUExbSzPvPkIJ064A=
Received: by 10.223.61.146 with SMTP id t18mr226419fah.34.1317866444140; Wed,
 05 Oct 2011 19:00:44 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Wed, 5 Oct 2011 19:00:44 -0700 (PDT)
In-Reply-To: <CA+sFfMf73K3yv_5K633DKOsVufMV6rTjd+SSunq4sBikt4jCsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182917>

[resend without html bits added by "gmail offline"]

So, it seems that of all of Google's email clients, only full desktop
gmail allows you to send plain text email (if you're careful to make
sure "Rich formatting" has not been clicked).  The new offline gmail
sends html, gmail android app sends html, gmail mobile web sends html.
 Google's war on plain text continues...

Or have I overlooked the switch that makes gmail send plain text and
only plain text?

On Wed, Oct 5, 2011 at 7:53 PM, Brandon Casey <drafnel@gmail.com> wrote=
:
> On Thursday, September 15, 2011, Brandon Casey wrote:
>>
>> On Thu, Sep 15, 2011 at 1:52 AM, Johannes Sixt <j.sixt@viscovery.net=
>
>> wrote:
>> > Am 9/15/2011 3:59, schrieb Brandon Casey:
>> >> The "x"-prefixed versions of strdup, malloc, etc. will check whet=
her
>> >> the
>> >> allocation was successful and terminate the process otherwise.
>> >>
>> >> A few uses of malloc were left alone since they already implement=
ed a
>> >> graceful path of failure or were in a quasi external library like
>> >> xdiff.
>> >>
>> >> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>> >> ---
>> >> =C2=A0...
>> >> =C2=A0compat/mingw.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 =
+-
>> >> =C2=A0compat/qsort.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 =
+-
>> >> =C2=A0compat/win32/syslog.c | =C2=A0 =C2=A02 +-
>> >
>> > There is a danger that the high-level die() routine (which is used=
 by
>> > the
>> > x-wrappers) uses one of the low-level compat/ routines. IOW, in th=
e case
>> > of errors, recursion might occur. Therefore, I would prefer that t=
he
>> > compat/ routines do their own error reporting (preferably via retu=
rn
>> > values and errno).
>>
>> Thanks. =C2=A0Will do.
>
> Hi Johannes,
> I have taken a closer look at the possibility of recursion with respe=
ct to
> die() and=C2=A0the functions in compat/. =C2=A0It appears the risk is=
 only related to
> vsnprintf/snprintf at the moment. =C2=A0So as long as we avoid callin=
g xmalloc et
> al from within snprintf.c, I think we should be safe from recursion.
> I'm inclined to keep the additions to=C2=A0mingw.c and win32/syslog.c=
 since they
> both already use the x-wrappers or strbuf, even though they could eas=
ily be
> worked around. =C2=A0The other file that was touched is compat/qsort,=
 which
> returns void and doesn't have a good alternative error handling path.=
 =C2=A0So,
> I'm inclined to keep that one too.
> Sound reasonable?
> -Brandon
>
