From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Tue, 21 Dec 2010 15:40:56 -0200
Message-ID: <AANLkTikvV1chYnSJUMGGoHTFv8EaXuK5B7Vo71jVyTRy@mail.gmail.com>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
	<AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
	<1292846433.19322.1.camel@drew-northup.unet.maine.edu>
	<AANLkTimkxJHvTAvra+B-0bAQopd8s21ZrFCPG_ALbZZ9@mail.gmail.com>
	<1292863989.19322.27.camel@drew-northup.unet.maine.edu>
	<AANLkTinL6RytF=x7a8URoxGQoLHhx0ip7gRNMp+nRaNB@mail.gmail.com>
	<7vbp4f9gzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Drew Northup <drew.northup@maine.edu>,
	"Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 18:41:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV6Ct-0002XB-K7
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 18:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770Ab0LURk7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Dec 2010 12:40:59 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:54018 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0LURk6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Dec 2010 12:40:58 -0500
Received: by bwz16 with SMTP id 16so4838802bwz.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 09:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qPLGRJdTs8UImYdESEevsSRmspo+Hl7we+YJiBr7gJ0=;
        b=IT8C1cw0YJM8O32zZHDf9L0Vaa1vztUHCWrrX24+2ikZJmjTmE1HurWWOXzgrhWVzw
         SZz9D0Pur6Ek782rvIN6cna2swNDQT4FRN1LI8YkntSV07j/uG+JBzi08VuPE8Ahe2UP
         +KVaOM1dJpAdm4kzRvzcePZagJIBftTQmjEdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oy7DX1I7EZNIkcpqLY8NnRqG3nhRHbMhwayssCsp9gpZNVGhYa47xIcEJnCf/JUbnN
         iVZ/oOJBICxDoA+l4gf6SAKaX/dfIcO4X/SpaZ5XZuP9eMgugzMc7zyEjTCUEAevJ5KQ
         kKwSxFKtvjaFbeq8SXjh0N4ABSNi/wy5l59po=
Received: by 10.204.64.139 with SMTP id e11mr4999741bki.97.1292953256837; Tue,
 21 Dec 2010 09:40:56 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Tue, 21 Dec 2010 09:40:56 -0800 (PST)
In-Reply-To: <7vbp4f9gzh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164041>

On Tue, Dec 21, 2010 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> This is pretty much a clean-up patch from my perspective. Do we real=
ly
>> need two paragraph explanation for marking a function static?
>
> I've already applied it, but I think it is much better to do this ins=
tead
> (on top of Vasyl' Vavrychuk's patch).
>
> A more interesting topic is why the try-to-free-pack-memory logic nee=
ds to
> be disabled in the first place. =C2=A03a09425 (Do not call release_pa=
ck_memory
> in malloc wrappers when GIT_TRACE is used, 2010-05-08) explains that =
it is
> to avoid a race on Windows, and it looks like a workaround not a solu=
tion
> ("can be called without locking"---"why aren't we locking then?").
>
> Not that it matters in the context of "trace", which is a debugging
> facility, that this is a workaround.
>
> -- >8 --
> Subject: set_try_to_free_routine(NULL) means "do nothing special"
>
> This way, the next caller that wants to disable our memory reclamatio=
n
> machinery does not have to define its own do_nothing() stub.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0trace.c =C2=A0 | =C2=A0 =C2=A08 ++------
> =C2=A0wrapper.c | =C2=A0 =C2=A02 ++
> =C2=A02 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/trace.c b/trace.c
> index 62586fa..0fb2a2c 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -25,10 +25,6 @@
> =C2=A0#include "cache.h"
> =C2=A0#include "quote.h"
>
> -static void do_nothing(size_t unused)
> -{
> -}
> -
> =C2=A0/* Get a trace file descriptor from GIT_TRACE env variable. */
> =C2=A0static int get_trace_fd(int *need_close)
> =C2=A0{
> @@ -76,7 +72,7 @@ void trace_printf(const char *fmt, ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> - =C2=A0 =C2=A0 =C2=A0 set_try_to_free_routine(do_nothing); =C2=A0 =C2=
=A0/* is never reset */
> + =C2=A0 =C2=A0 =C2=A0 set_try_to_free_routine(NULL); =C2=A0/* is nev=
er reset */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_init(&buf, 64);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_start(ap, fmt);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D vsnprintf(buf.buf, strbuf_avail(&b=
uf), fmt, ap);
> @@ -108,7 +104,7 @@ void trace_argv_printf(const char **argv, const c=
har *fmt, ...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> - =C2=A0 =C2=A0 =C2=A0 set_try_to_free_routine(do_nothing); =C2=A0 =C2=
=A0/* is never reset */
> + =C2=A0 =C2=A0 =C2=A0 set_try_to_free_routine(NULL); =C2=A0/* is nev=
er reset */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_init(&buf, 64);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_start(ap, fmt);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D vsnprintf(buf.buf, strbuf_avail(&b=
uf), fmt, ap);
> diff --git a/wrapper.c b/wrapper.c
> index 4c1639f..8d7dd31 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -12,6 +12,8 @@ static void (*try_to_free_routine)(size_t size) =3D=
 do_nothing;
> =C2=A0try_to_free_t set_try_to_free_routine(try_to_free_t routine)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0try_to_free_t old =3D try_to_free_routine;
> + =C2=A0 =C2=A0 =C2=A0 if (!routine)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 routine =3D do_not=
hing;

Maybe I'm missing something, or I'm confused (or I do not understand
what I'm reading), but how you are assign routine to do_nothing if you
have removed do_nothing above?
