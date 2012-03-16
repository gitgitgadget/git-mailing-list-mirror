From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/5] i18n: mark relative dates for translation
Date: Fri, 16 Mar 2012 18:47:06 +0700
Message-ID: <CACsJy8D0KN_M3txmq3J==3Q5=u2XAa0hR=Wm+=T3qYN+LAuWkQ@mail.gmail.com>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
 <1331198198-22409-3-git-send-email-pclouds@gmail.com> <20120315185102.GA4636@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 12:47:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8VdQ-0002qD-Nb
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 12:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697Ab2CPLrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Mar 2012 07:47:41 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33862 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032706Ab2CPLri convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Mar 2012 07:47:38 -0400
Received: by wibhj6 with SMTP id hj6so729241wib.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vc91Q49xdJn0E6wlZ46614xf/qTsxFKEWZtS0MLhZDI=;
        b=IEOC/gTiQiIFTbnOs2Zq71wZ/yznHH5iwanduOIsR2a3795DxlmPn8wctcbntHd8Gg
         Stz3v0NZL538oo6aACr8SNSQMC7XSJfSMYko+vdxWe9nzSbBbsX76f9bbvNaEcPOun7X
         4gnGi6x4oQgukP5ChcCKetwdzEPP8wvHIIokbhkYBgCRHyh1NMa+kgo8+eSsLgoaWPGH
         dfPejWv+k/11kntWZBN9Ezfb7eovPDXiLSaxZC9VmIegAVIKBy7Wj9+Ni3+WCARxsu/S
         SQmozaPUOMujs3m/X/m9ZpkoM4i4IkmR6kHEe/+fbDK+YVkxgFP5aD/UcCcprpm/S+Xe
         Vb8A==
Received: by 10.216.135.225 with SMTP id u75mr1265095wei.97.1331898457511;
 Fri, 16 Mar 2012 04:47:37 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Fri, 16 Mar 2012 04:47:06 -0700 (PDT)
In-Reply-To: <20120315185102.GA4636@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193252>

On Fri, Mar 16, 2012 at 1:51 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> English dates get correct plural/singular form as a side effect.
> [...]
>> +++ b/date.c
>> @@ -93,38 +93,46 @@ const char *show_date_relative(unsigned long tim=
e, int tz,
> [...]
>> =C2=A0 =C2=A0 =C2=A0 if (diff < 90) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(timebuf, timebu=
f_size, "%lu seconds ago", diff);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(timebuf, timebu=
f_size,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Q_("%lu second ago", "%lu seconds ago", diff), diff);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return timebuf;
>
> This leaves me vaguely nervous --- sure, no language is going to use
> an expression for "<n> years" that is more than 200 bytes long, but i=
f
> one does, it would get truncated.
>
> Would something like the following (untested) on top make sense?

It does. I will reuse your patch next time.

> My other worry is that
>
>> + =C2=A0 =C2=A0 struct strbuf sb =3D STRBUF_INIT;
>> + =C2=A0 =C2=A0 strbuf_addf(&sb, Q_("%lu year", "%lu years", years),=
 years);
>> + =C2=A0 =C2=A0 /* TRANSLATORS: "%s" is "<n> years" */
>> + =C2=A0 =C2=A0 snprintf(timebuf, timebuf_size,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Q_("%s, %lu month =
ago", "%s, %lu months ago", months),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sb.buf, months);
>> + =C2=A0 =C2=A0 strbuf_release(&sb);
>
> seems excessively complicated. =C2=A0How do translations normally dea=
l with
> cases like this of strings with multiple numbers in them?

I don't recall any similar cases. A search for 'ago"' in all gnome
translations I have only shows "<one number> ago", or "%d blah ago,
<absolute time>". The closet is probably strftime, where translators
are free to reorder date and time items, something like this

/* Translators: the first %s is the number of months, the second the
number of years */
sprintf(.., "%s, %s ago", month_string, year_string);

Or we can just round it up and show only one number.
--=20
Duy
