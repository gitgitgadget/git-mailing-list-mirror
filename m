From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: Need to change old commit (and regenerate tree)
Date: Fri, 21 May 2010 22:46:29 +0100
Message-ID: <AANLkTin8p1Wdbx0-UXuwOtHn8Z4XKnDBAPVOumnz5YLt@mail.gmail.com>
References: <AANLkTilTAknKPFv5AZBrwsITPsRlVSnsuX8TDXlUTWmw@mail.gmail.com>
	 <m2sk5mtecw.fsf@igel.home>
	 <AANLkTinzl_sc9G1PUtLczEjHFdpRqMFuKkEiQTUXaEgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri May 21 23:46:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFa3A-0001Te-8Q
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 23:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab0EUVqb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 17:46:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45083 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483Ab0EUVqa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 17:46:30 -0400
Received: by gwaa20 with SMTP id a20so691591gwa.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XV970BnBGfTauX4oLPbNCt3jnLgG1Sa9Cjf+6Qgpmf4=;
        b=Nix2WyeRfWUWgJO8o/h0AlHuwMqhXdZcfHj+6UMebbjknSirKllHQMpXvvQTiuVuN/
         SdZbTjR4hPoVYFuT9iOfY2bGeMilZ/llGEOCtQ2pO2c9CqPCm1RXRoYJYZUveFIbsrzT
         c6xwCYRYPUPR+G9RGT2GahBvQhQsNmz56cFME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZJCeHv0D89K7Uu6B6GMh6+Q1VVuMrBtc1a7PPxS9Mcv8SLylGpakpAc32KxbyVDTvl
         yxSMk84JYGgSN1Zqz72SkPkn0YTSGp8d8TXQjrfFjZ+dM85zTWBRAd5u7ZB3ggZ3EWak
         6CHlSrx8oaqzrkvI/24ih/RMvjdFu5BizTlbg=
Received: by 10.151.3.3 with SMTP id f3mr3750431ybi.117.1274478389401; Fri, 21 
	May 2010 14:46:29 -0700 (PDT)
Received: by 10.151.111.3 with HTTP; Fri, 21 May 2010 14:46:29 -0700 (PDT)
In-Reply-To: <AANLkTinzl_sc9G1PUtLczEjHFdpRqMFuKkEiQTUXaEgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147496>

Thanks a lot.

I guess it is then not so straightforward to regenerate trees with
their relative structure
intact when an old commit changes. I was initially of the opinion that
it would be a trivial
rebasing of all branches from which the commit was reachable.
Apparently, not so.

On Fri, May 21, 2010 at 6:31 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, May 21, 2010 at 00:09, Andreas Schwab <schwab@linux-m68k.org>=
 wrote:
>> Antriksh Pany <antriksh.pany@gmail.com> writes:
>>
>>> Instead of (what I initially expected):
>>>
>>> A--------o--------o--------o--------o(old B)--------o--------o-----=
---o(old C)
>>>
>>> A2--------o--------o--------o--------B--------o--------o--------C
>>>
>>>
>>> So what I am missing here? Aren't the new commits B~1, B~2, B~3
>>> identical to C~4, C~5, C~6 (respectively) in all ways so as to have
>>> gotten them the same SHA1 and hence appear as what I expected them =
to
>>> appear?
>>
>> No, they have a different commit time, which is also part of the has=
h.
>
> Indeed.
>
> To avoid this, you have to:
> =A0- rebase B on top of A2 first,
>
> =A0 =A0 =A0 =A0git rebase --onto A2 A B
>
> =A0- rebase of C on top of the new B.
>
> =A0 =A0 =A0 =A0git rebase --onto B B_old C
> =A0 =A0 =A0 ("git rebase --onto B A C" should work too, as usually gi=
t is
> smart enough to see
> =A0 =A0 =A0 =A0that A-B_old is already applied. Use "git rebase --ski=
p" if it isn't)
>
> If A is an ancestor of A2, you can simplify to:
>
> =A0 =A0git rebase A2 B
> =A0 =A0git rebase B C
>
> (Disclaimer: the examples without --onto I use almost daily, the ones
> with I don't)
>
> Gr{oetje,eeting}s,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Linus Torvalds
>
