From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries are well-known
Date: Wed, 6 Apr 2011 15:45:59 -0500
Message-ID: <BANLkTikNv+xGKZv-5bxQJWASym1ZDuAuYw@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
	<1301535481-1085-4-git-send-email-dpmcgee@gmail.com>
	<7v7hba9csn.fsf@alter.siamese.dyndns.org>
	<BANLkTi==M=N+Z3qcsYk+tHap8A1Y41QfLw@mail.gmail.com>
	<BANLkTin9P-OdTQhPTwcvgvpDoBg7E+va5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Antriksh Pany <antriksh.pany@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 22:46:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Zc9-0004UN-Bg
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 22:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162Ab1DFUqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 16:46:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41913 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab1DFUqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 16:46:01 -0400
Received: by wya21 with SMTP id 21so1662587wya.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wvws26mCy+zZaVQhzNGrThwh0CjYTEUYsSJwi8FJmzU=;
        b=NQUDxK9d0yUudEUTv04G1i4BqlRUmqJJfPGTOhiYy280uvb2EjSC8QHub7CiTHVYig
         irziDjjQ4l3pDQA65RUVZ4myk+dBvdMmlCi/CSLLir++m9jKC+RtRZkmzz08lPEErg3b
         xFzQIdVfam1RCeokL/sDO/hTiks8AxRXbBS8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=v3a9JYiEVTEipkNXvqLaleC+62EexB7I5XacdMmC+yrPu2LOaxtYCfp+dx+yR2zpRA
         YfFFC40bN4c72OPg6Tms/xCv6klSHT+Fv75N+3Uk6wz2AWRCK/pGJOKogtdShg99s8wT
         XCdBwmphzEW/BEohn1iNia/E0Kt3CSujgPzHY=
Received: by 10.227.32.132 with SMTP id c4mr51628wbd.190.1302122760184; Wed,
 06 Apr 2011 13:46:00 -0700 (PDT)
Received: by 10.227.147.16 with HTTP; Wed, 6 Apr 2011 13:45:59 -0700 (PDT)
In-Reply-To: <BANLkTin9P-OdTQhPTwcvgvpDoBg7E+va5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171015>

On Tue, Apr 5, 2011 at 6:55 PM, Antriksh Pany <antriksh.pany@gmail.com> wrote:
> On Mon, Apr 4, 2011 at 10:33 PM, Dan McGee <dpmcgee@gmail.com> wrote:
>> ....
>> Totally agree; I should have tried to do it this way in the first
>> place. However, compiling the fixed-length 0 to 5 loop does not
>> produce fully-unrolled assembly for me with CFLAGS="-march=native
>> -mtune=native -O2 -pipe -g" on x86_64. I see two copies of the loop
>> only, and even worse is the (lack of) performance (each is the mode of
>> 3 runs). Compilers are stupid apparently.
>> ....
>
> Can you try -O3? Or an explicit '-funroll-loops'?
> gcc I think does not do aggressive speed optimizations at the cost of
> space when at O2.

Sure- both of these options show the loop being unrolled for all 5
iterations. However, that doesn't help me and the other 95% of people
using distro packages, git-scm.com binaries, or anyone compiling with
the default CFLAGS optimization level which is unfortunate.

-Dan
