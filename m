Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8552C2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAB52076F
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c/BUByMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgCYTEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:04:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:34787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgCYTEL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 15:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585163049;
        bh=9vr03eN40P/mzQnQVx/o63vh1tmTQx5onnW9Zjer+14=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c/BUByMJOJflp95osD+3B+oPlwNRow2VYglqeTECaL0JbD1/alJmlPNnkKcePC8yg
         Wjx2rfiwyXCs7ZZ4J+y8LQhW8aUAOnuVCQHC8BYj+QW+KgPs7dc+T7kD9EFtFumbL9
         ykE1xrx8Gym18Z83BnLZrc5uhpD+n54Ol0ATbzMY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.37]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N2DxE-1jODqB2BeY-013gF4; Wed, 25 Mar 2020 20:04:09 +0100
Date:   Wed, 25 Mar 2020 20:04:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Vadim Zeitlin <vz-git@zeitlins.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: allow running as different users in shared
 repositories
In-Reply-To: <20200319010321.18614-1-vz-git@zeitlins.org>
Message-ID: <nycvar.QRO.7.76.6.2003252001560.46@tvgsbejvaqbjf.bet>
References: <20200319010321.18614-1-vz-git@zeitlins.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CfJsjc65qHqRmVMO5nDixpqaocSGCrhEodnqDVlMNt4HLmP29zD
 SIwEBB4sk5ss6zWc21eYi9Q12Jh0hqStccHjHN6PS6758xjOE+3Ml/USP0guyxjgmzFWYFM
 Zoyv9KH7pU+0xtqqhUFHYr0La/0G6RjFPPYw3chWv5+X819ifIVyjAsgkYJxRQOoxKnekzb
 Ta/HojDZfrcoWDyTlBfRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EQIxFmWE/iw=:wSIAtJ2HkJ+GlTiblLgmWX
 dZ94niwuPOnaWVT6NnQHRtij9UXV1GY55eMdgP0NdP4aUG7I4bX1lWaqcnJG1+slOPxK1FNAH
 it4iHn3BuvjxxR7OMjgxR1F3G6EQJMiPHi4uc1iZFHsCj2HZhIm80xLTFHcB0TuBqKpmEya+c
 LYDdyA/i3we2r8VJahTFwGkXf1WJhuTO8NWp6bmua+yTrQqw1AeinJFtFcCKjb06ACCA9GoK8
 K0081iKt7PInoBVlLBr6GwrV1snxcbTCoMDrUiUY7AYZ2EeqddbvCre3C7GEU4eDzfUcxbfTE
 XmRP+pYji94g5dTr3jk36IDClxyRvW/ofU01zsoCiGAnkXspO3Nv853vZMq48Yh3epdMVlZKv
 z/unTKxUt8Tu+bUIRlubyOKUJsI7daihVf+DZM2+uIePxyohTcuOK7yLu2+IXryqKCeebL5O1
 PHL8jy/Aebc/Ex7hhyHmMekCFDq8DIMStsKmCM6A0c4lcU3uVr+VwLEZbGo2/z3zvf6Dev9yr
 dq/4CHGouUQppwpjTT9RZ+kMI5K09cFUSbooSK4U3Ij5807ujHMtmmvtZNSAVRS+f32XzPsmm
 OoybApy9eFDDqXW+vfo0BSiPZbpUTkaJHPIZ5jldg0IXx9PAMhTBKo2ak6qzlpnHhsAl4U8zn
 B6Qu7CdP1cJLRlGUwKqpeqTIY7XKf1qnoZt10JduQ+AqxOp+W8YeO3ETY/5runLZg/dSzB38z
 ZhUJR0A31ssIO2ASNGONbipqMipytbxA2Ni/GD5EnYnaOuubdoXioMsTKMVuXBkALureM8MmZ
 teCaf+gTREdype6aOKA4Eq6jM1sxxX8JREoesMGtNmbQxBGckgxnXHjb2aslHXugKb8o4yeLD
 lxbUOjqb/S9qyiW/iHgARTzH7AT3Jxi+Jv2nfg9CBxSrTx8hI63DwsYUA5Loz50/kdnGsyn1J
 wZebZ+ak/aNRuRPsfLWRLjmZmfTM8eUfuxQOQ2BzUOWHktNyf1ntnspHw4Ta3kkra06rrM53U
 ssx5c0kgZOykAswdjmB25GkUrk5X3LxfZoEaezsRECYvpLZqjSsyLUxZqgg6EqJJxVfeGW6P2
 zzTpwoKFuHX3fHNK+y1UbmywkzWNo6e75TZJ8UZ+5zzF2FSc36b6D0GfmZb6c0PoZF7PDckz5
 K/MUXODSkaFFhSC5E1KPAc8NaI3uUtQgnZwVoKRXSvbbybCyY81QPDCS5O+GTrVnGnWbghWDx
 h3Kn62jM3pHSMhF3R
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vadim,

On Thu, 19 Mar 2020, Vadim Zeitlin wrote:

> The function fopen_for_writing(), which was added in 79d7582e32 (commit:
> allow editing the commit message even in shared repos, 2016-01-06) and
> used for overwriting FETCH_HEAD since ea56518dfe (Handle more file
> writes correctly in shared repos, 2016-01-11), didn't do it correctly in
> shared repositories under Linux.
>
> This happened because in this situation the file FETCH_HEAD has mode 644

I wonder why that is. In a shared repository, it should have mode 664, I
thought.

> and attempting to overwrite it when running git-fetch under an account
> different from the one that was had originally created it, failed with
> EACCES, and not EPERM. However fopen_for_writing() only checked for the
> latter, and not the former, so it didn't even try removing the existing
> file and recreating it, as it was supposed to do.
>
> Fix this by checking for either EACCES or EPERM. The latter doesn't seem
> to be ever returned in a typical situation by open(2) under Linux, but
> keep checking for it as it is presumably returned under some other
> platform, although it's not really clear where does this happen.
>
> Signed-off-by: Vadim Zeitlin <vz-git@zeitlins.org>
> ---
> I couldn't find any system that would return EPERM for a "normal"
> permissions denied error, so maybe it's not worth checking for it, but I
> wanted to minimize the number of changes to the existing behaviour. At t=
he
> very least, testing for EACCES is definitely necessary under Linux, wher=
e
> openat(2) returns it, and not EPERM, in the situation described above, i=
.e.
> non-writable file (even if it's in a writable directory, allowing to unl=
ink
> it without problems).

That rationale makes sense to me, as does the patch.

Thanks,
Johannes

> ---
>  wrapper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/wrapper.c b/wrapper.c
> index e1eaef2e16..f5607241da 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -373,11 +373,12 @@ FILE *fopen_for_writing(const char *path)
>  {
>  	FILE *ret =3D fopen(path, "w");
>
> -	if (!ret && errno =3D=3D EPERM) {
> +	if (!ret && (errno =3D=3D EACCES || errno =3D=3D EPERM)) {
> +		int open_error =3D errno;
>  		if (!unlink(path))
>  			ret =3D fopen(path, "w");
>  		else
> -			errno =3D EPERM;
> +			errno =3D open_error;
>  	}
>  	return ret;
>  }
> --
> 2.26.0.rc2
>
