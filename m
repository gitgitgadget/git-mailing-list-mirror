From: John Tapsell <johnflux@gmail.com>
Subject: Re: Generalised bisection
Date: Thu, 12 Mar 2009 06:45:43 +0000
Message-ID: <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 07:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhehl-0007UQ-PS
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 07:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbZCLGpq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 02:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbZCLGpp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 02:45:45 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:32608 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbZCLGpp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 02:45:45 -0400
Received: by wf-out-1314.google.com with SMTP id 28so475616wfa.4
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bFGv2hsdqMM++IOydOOmhgF9RN956cyKzBphTaAi+Y0=;
        b=iYxkrq7jlPimtSC3VHeZcoHqPk8qnOFxrnAvaloe7YFXxdkorLm1QCL2e7l4AuIq1M
         st7AMw6dmpIe4qXfmO8pFfPAaxeMT3yFJxqtj9PohgBOkf4EFzHARSljdHc9DHGivJD1
         syoYQx/xbybaXIDqmsNEE5QWIOd3Fx8o2dz9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VoSkS6yW2/0W+yJ7ObFbHZeH2Tdjr2w98uLw+FWu6dAZULIrQuUOFOgvHaogy5jzRG
         5fsRW05KOsFD/yQJRjYbhVoYefh7FzGPW0E59+SyuiPTTmat22R4sNFmkqGbCsgpTaW7
         QVLqChMp5ESW8cMYn7GMybD1bYicgZrLQc5Mo=
Received: by 10.142.214.11 with SMTP id m11mr4144229wfg.125.1236840343238; 
	Wed, 11 Mar 2009 23:45:43 -0700 (PDT)
In-Reply-To: <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113005>

2009/3/11 Ealdwulf Wuffinga <ealdwulf@googlemail.com>:
> [John will get this twice, sorry; not used to this mail interface yet=
=2E]
>
> On Wed, Mar 11, 2009 at 9:35 AM, John Tapsell <johnflux@gmail.com> wr=
ote:
>
>> mpmath might be the more annoying dependency - what functions do you
>> use from it? =C2=A0Could they trivially be reimplemented?
>
> What I use is the multiprecision floating point number class. doubles
> don't seem to be long enough.

Hmm, really really?  Sometimes this sort of thing can be fixed by just
readjusting the formulas.  What formulas are you using that require
more precision than doubles?

> The reason for using mpmath rather than the more =C2=A0widespread GMP=
 (and
> its python wrapper gmpy) is that the latter only supports
> integer powers, whereas BBChop needs fractional powers.
>
> So, it might be possible to switch to gmpy, =C2=A0or some other wides=
pread
> library, =C2=A0by implementing a pow() which supports fractional powe=
rs.
> I think I only use the normal arithmetic operators, log, and pow, so
> in principle those could be reimplemented, to eliminate the dependenc=
y
> altogether.
> It seems a little bit of a waste of time, though.

A little bit of math trickery helps here :-)

y =3D  x^b

log(y) =3D log(x^b) =3D b * log(x)
e^log(y) =3D e^(b log(x))

y =3D exp(b * log(x))

So as long as you have 'exp' and 'log' functions, you can raise x to
the power of b, even if b is fractional.

Just to prove it, square root of 2 is:

$ echo "e(0.5*l(2))" | bc -l
1.41421356237309504878

John
