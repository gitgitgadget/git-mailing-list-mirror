From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: tr/xdiff-fast-hash generates warnings and breaks tests
Date: Sat, 19 May 2012 16:17:23 +0200
Message-ID: <CAA787rmJixvyKhubHXZCDVYc=DdVk8_vHsHF6bOsLQ_j=39bGw@mail.gmail.com>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com>
	<4FB4A4B9.3080009@lsrfire.ath.cx>
	<xmqqmx56rd2r.fsf@junio.mtv.corp.google.com>
	<4FB5460C.10807@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat May 19 16:17:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVkTS-0000SL-Mi
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 16:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760189Ab2ESOR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 May 2012 10:17:26 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52059 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab2ESORY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 10:17:24 -0400
Received: by dady13 with SMTP id y13so4985385dad.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oLKSX3JJOVA1spYm8kI+SEl9jh97LVBbx+4xYpc/UVU=;
        b=J3k9LPpdTnGVAhmeWWHjbpJGzWgNbrOfll57hgs4uPfv4Ul7iXN1VU0DQ1XJq1wt22
         OluC5Clyd51TmnxHhSiq5Q8EOha12r/2S808bknZnUGw//rPUbgSjK9qgxCkfJ60OAnN
         c3Nx5YV8nBfXWb41QzSkvlx6NBqec86+yZfMarZgMEQEOA8uyNf4smJowxWYSDbzprDT
         R7UgAKMajS4GtZfEhjOSr6Yd77GIxqaLHSHoWhhDY6LeImN98Rwu7P2Wyna8K0P6Q1DH
         E4HLLj8uXetF2HyTGNmg8kNmg51tB8ekwvmiyZ9Tw6HOrN0+Mttb6UWrGELEo81XqoBN
         /N5Q==
Received: by 10.68.230.68 with SMTP id sw4mr24027444pbc.142.1337437043667;
 Sat, 19 May 2012 07:17:23 -0700 (PDT)
Received: by 10.68.26.98 with HTTP; Sat, 19 May 2012 07:17:23 -0700 (PDT)
In-Reply-To: <4FB5460C.10807@lsrfire.ath.cx>
X-Google-Sender-Auth: B_0eHASVc9N1gXF9eF8YpOG1x8Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198032>

On 17 May 2012 18:23, Junio C Hamano <gitster@pobox.com> wrote:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
> > On Ubuntu 12.04 x86, t0020 fails for me as well when I compile with
> > XDL_FAST_HASH explicitly set (it's off by default).
>
> OK. =C2=A0So does that indicate at least breakage in the Makefile tha=
t
> attempts to set XDL_FAST_HASH only on x86_64, mistakenly triggering o=
n
> =C3=98yvind's x86 32-bit userland, or did =C3=98yvind manually flippe=
d the
> feature on?

No, I haven't fiddled with any of those, only using standard ./configur=
e
and also verified by running make using the standard Makefile.

On 17 May 2012 20:40, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> w=
rote:
> The following patch on top of master makes the compiler put a sarl in
> my build, and "make -j4 XDL_FAST_HASH=3D1 test" passes.
>
> =C3=98yvind, does this oneliner help in your case as well?
>
> Subject: xdiff: signed right shift for 32-bit case of XDL_FAST_HASH
> [...]
> =C2=A0xdiff/xutils.c | =C2=A0 =C2=A02 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 1b3b471..29df57e 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -311,7 +311,7 @@ static inline long count_masked_bytes(unsigned
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * (a+b+1) giv=
es us
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 corr=
ect 0-3 bytemask count result
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long a =3D (mask -=
 256) >> 23;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long a =3D ((long)=
mask - 256) >> 23;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0long b =3D mas=
k & 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return a + b +=
 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Yes, applied your patch to current master (9de9681), and the whole test
suite runs without errors. The compiler still generates the same
warnings, though:

    CC xdiff/xdiffi.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
xdiff/xutils.c: In function =E2=80=98has_zero=E2=80=99:
xdiff/xutils.c:261: warning: integer constant is too large for =E2=80=98=
unsigned
                    long=E2=80=99 type
xdiff/xutils.c:261: warning: integer constant is too large for =E2=80=98=
unsigned
                    long=E2=80=99 type
xdiff/xutils.c: In function =E2=80=98count_masked_bytes=E2=80=99:
xdiff/xutils.c:273: warning: integer constant is too large for =E2=80=98=
long=E2=80=99
                    type
xdiff/xutils.c: In function =E2=80=98xdl_hash_record=E2=80=99:
xdiff/xutils.c:310: warning: integer constant is too large for =E2=80=98=
unsigned
                    long=E2=80=99 type
xdiff/xutils.c:326: warning: integer constant is too large for =E2=80=98=
unsigned
                    long=E2=80=99 type
    CC xdiff/xemit.o
    CC xdiff/xmerge.o

But with this patch, you're certainly on the right track. Thanks.

Cheers,
=C3=98yvind
