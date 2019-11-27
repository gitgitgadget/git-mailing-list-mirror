Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61C4C43215
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0DA2068E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WWfzpqWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfK0Tf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:35:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:42285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbfK0Tf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574883356;
        bh=EPOhS2+XTvGsL1DONbx2NUazfKKotVebdp4ZofG3Ci4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WWfzpqWnzlcN/7CM5eYXm9ZBYRTGJy5/4BdX3Rvefl/O8fNWFfdz7PYywKgOKmhZk
         vula/uQwClFGItA3wv3cIAG5uJ/tlIr3nyIZKBKizUmkMORCHRkoEPjnX3UTvHUJpn
         BD3tdIIJjLamw68lGg18VIVTfj9BrCnP7tcnF0/0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1iauJf1lhX-00HRth; Wed, 27
 Nov 2019 20:35:56 +0100
Date:   Wed, 27 Nov 2019 20:35:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/5] mingw: use {gm,local}time_s as backend for
 {gm,local}time_r
In-Reply-To: <2c39f9a04f98fc3d365c80ce57e8edce305846fb.1574867409.git.congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911272034550.31080@tvgsbejvaqbjf.bet>
References: <cover.1574867409.git.congdanhqx@gmail.com> <2c39f9a04f98fc3d365c80ce57e8edce305846fb.1574867409.git.congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HEV8WSAGI0Ja88a+HsUDs/rpJWR3C2l1oktJVxJZ20SR+gYoNTS
 SUs0hCHm/dVPwk20RG2CrnDx6n4ccofnjsXfzeHptV5HL7TRAuy1bd18YBejMVxqBmf5tbI
 Mn68P8Pawlt4dew0qCW2qQl7aa3N92A9U4lFMhiVhoE0Jhf3kwbn5bImn1wfAe40F2TN8+0
 LvP17Nr9WWgSPx7r33vtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k1CiXclfwrQ=:wtmQQGIfbOvl7DsfOVUouh
 dWM/Wz5I2aqQhg4w59S9ZugXXMKBXleJ9dR9pSzBx6LuxvlEtz1sr06BmCaCd/57WD7V71SN8
 s7bFeme4uT8GgIz8YTWoWGiTv0cAJXCU+IVTjPLCwNA94hx1Yz1JaKW33MeDdRU4gbfnafSbM
 ZaLGmmo/Rzy0TH4zDSAEtDqGtU/EH8ut9k9zMVeWsf2ujuBPlOtx1SUKjzH2SBgmKKhGvUeAt
 pYsVFp4CZY7+G4F1V6cDK4GQ9C6ntp710w68jQpXyMSD7UmzlsikTuYLVSX+rLGngXC6plC3E
 qkEod2ns+afMemcIQzZnaOqE4A1GVzpKv5uGLxcXD7GiN+zTmEmPbjk/+VUvGfJt/EIbNNtvj
 VAIGJSW3epbv0ApCOfsJJ1TvoFRV2SyiemdcXhPYi62eambseHOkNOQ1JByR9/YHcXmIdKB0g
 Zin2DbeV/tNS0SOAwEYBWl1j9srdyJzM/Ly4k4F9yKW5EJBzkr8fmgn66XxJLFgBbqdupbDeE
 SsWxG2j0DyjXh4ozb9GARdRbiHcXVyuWUH/6afCpUZNyDhr6qN9E2LWnEpr/B4i4DZjTvnXkB
 b6b1DByiabvDHRJA0sxIxkawM0PzxB5IT7w77cJEbdXvQRV90APjT9AZvHdARkV0tav2WtxZy
 +NjxdS38ZBzrFuHDokzn5zjRZoHYpXaFZ5LntmmzN+W8SQqvMeHYmPN3pgQI6y7xens5u3DN5
 X+ra3U4GA2qqg+qeIcsAPsVWe+4XZ3sfDqMrbVFmrGxwvGZ40V1ydsd9jB3BJFHnyJqvT2lHS
 z5+C3kskPQftGYS3uqibWawVEHoWeycJU2Hd7KD/iulE18AMA/McInwBCs9upRAwdqN4ZFcAL
 9oRcyw8LuttagK1uO8u8B63ifj15Pzr4NwViYlWs+pSHTL1yQeF+wFy6wW+s17ucLeLxzXfC5
 nwRGFj2JzvVdaAgjzZN5PttQmfrRjRkKGK9IQ5rvT1X98fsyoNShkQecl6XAVqG58ptwT7I9H
 puTTRmtjAGRuVElphX73opRKAgD0Z7HUIC+38GnS7eGGzA/yEblIChLnjb1qy3pzl6oNvmfWu
 29p4RAXD2+xXDNRKkjpUCUuoYe5sHDsxBfr2rbhEGkpFuFLF/fqXxLOpCqhcWeFCNWZTNltEJ
 Hfy4mtJMwYGMw+ChFCs9fpCpzIcDZplLfwp04rJ2DSl3+Jv74ajwExFLtzvykhEj5SUTX8Co/
 /kv/BnYeDQpjdEPDaltsLZgAQYX6b71zfcstGnTq2xd/UlJPN9x+XhCHMCSA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Wed, 27 Nov 2019, Doan Tran Cong Danh wrote:

> Since Windows doesn't provide gmtime_r(3) and localtime_r(3),
> we're providing a compat version by using non-reentrant gmtime(3) and
> localtime(3) as backend. Then, we copy the returned data into the
> buffer.
>
> By doing that, in case of failure, we will dereference a NULL pointer
> returned by gmtime(3), and localtime(3), and we always return a valid
> pointer instead of NULL.
>
> Drop the memcpy(3) by using gmtime_s, and localtime_s as backend on

s/and localtime_s/and use localtime_s()/

Otherwise, this looks good to me, thank you!

Ciao,
Dscho

> Windows, and make sure we will return NULL in case of failure.
>
> Cc: Johannes Sixt <j6t@kdbg.org>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
> ---
>  compat/mingw.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index fe609239dd..7b21f4eee5 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1,6 +1,7 @@
>  #include "../git-compat-util.h"
>  #include "win32.h"
>  #include <conio.h>
> +#include <errno.h>
>  #include <wchar.h>
>  #include "../strbuf.h"
>  #include "../run-command.h"
> @@ -986,16 +987,16 @@ int pipe(int filedes[2])
>
>  struct tm *gmtime_r(const time_t *timep, struct tm *result)
>  {
> -	/* gmtime() in MSVCRT.DLL is thread-safe, but not reentrant */
> -	memcpy(result, gmtime(timep), sizeof(struct tm));
> -	return result;
> +	if (gmtime_s(result, timep) =3D=3D 0)
> +		return result;
> +	return NULL;
>  }
>
>  struct tm *localtime_r(const time_t *timep, struct tm *result)
>  {
> -	/* localtime() in MSVCRT.DLL is thread-safe, but not reentrant */
> -	memcpy(result, localtime(timep), sizeof(struct tm));
> -	return result;
> +	if (localtime_s(result, timep) =3D=3D 0)
> +		return result;
> +	return NULL;
>  }
>
>  char *mingw_getcwd(char *pointer, int len)
> --
> 2.24.0.158.gd77a74f4dd.dirty
>
>
