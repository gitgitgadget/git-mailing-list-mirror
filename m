Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3D2C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07561207DE
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 11:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RT8mToCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgKMLQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 06:16:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:40327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgKMLDu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 06:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605265420;
        bh=5AjKzSyQBNYZ+aZ7RToeG7ryDDg5FCLMftExLfsHY70=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RT8mToCnEAg5CUz0N/29PHPjB0fU8TcPz9KSSUAGhAWAqYrVWee8W7ytpv6XMI5g1
         g/ZKUPSbHlxhQHx8p9xOnboHzT9G5VGxb4B6QGMJth8IVvTZs0inHvfd3LtdFLE80B
         9Ho2hThTNpQPyrqMwEm//kUnLKzif/Ckz9v8lRi4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1kbJwK2ctk-002F8T; Fri, 13
 Nov 2020 12:03:40 +0100
Date:   Fri, 13 Nov 2020 12:02:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] packfile: detect overflow in .idx file size checks
In-Reply-To: <20201113050719.GE744691@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011131200460.18437@tvgsbejvaqbjf.bet>
References: <20201113050631.GA744608@coredump.intra.peff.net> <20201113050719.GE744691@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h38uKX2N5pYOx8tbpgRQk2PhAkv0N8X7VyPlviJElxE3J+uvJ/u
 NdaA6o4obDjPWRFeHHub44rGfsC/15oTaDhONn4A05QPh9sVAXF81Rh8itgTufcn5DSs6NF
 nnc+RZPoCR7yJpqNE503oRBkTb6RP84qheMB3RIuXDxwA9Tm6fnzKyw9/E+1gvksOX3dz4L
 P84Ltsn/myv62iV92KDhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OLvR1Db3/ns=:d/vL98zaG8JUaVn/2vVd9P
 mXJMG0DP6EkE8tCjhrESBrCvoY8KrOV0xwdK35rNBzwRJ4mVnhQJGWCr/ph5JhPnrm0ygfYa0
 TsQz3+EemP2oTnYgjQM6PLuXpSkwWTMwGnJNcVChU9Dvtu8/sz6/b9N55Ox2fr2S53Kiezaib
 vHjydBalRfUbxly+pePLctKH+dVMUHxwJxqUHsFEgC6M8t7wKziQF07ranZift4n3AjK0UC6U
 /FPqqckAwR7WovdyRMTDP5A71A05ol+wVkLCa57al4+XtsqDNUCfwRZ6c//ABPssYVi5KeseY
 t4GjIirfAaj753DY02GMDhEvIUxUN0U4oBuLjYg3/FNsJoNpTZsW/LWZlQ9b2MJwvCfyV/NV3
 +G9Gc09XpTXw6b5m8p2yPdjF4V7QgfPAUVVVXsRil4gIoT3ohMumn1HVCGKGWECZiiCiwvGh/
 eHilV6/Z4+CEbIsUSWQGtR2FSHO51Wxh+csctW8jcyH3n0VkyMIoz1AHxdkUz+bBOqjA9vAaq
 lXzNEXfdN5g9Wtl5sWiM/ieh+dAFfdEQ02vqcD4/9KrF/Wlt/otJxMv1v6c7zPGgxJ4G7noUi
 NLLT1o2o/S+AOHO2oqMthwozz90c71EXBkbtDUGyscb8zQQ6z8Kj0aBwkGCXnUTnjnX4MtVS6
 hC/AWQGaF0mPwnDsoEnM1Ii0hWM5nKM3q1gA+cJH31yWQvugLo2UXxfRlq3javowYhFI4nX1I
 1xlR8qVGckybPzQw7PHBdppih3RWmsE3f6yXob8sL74Ns0JVcG9Pwajk6ZYhxp8u5Z8yU4gKZ
 lPRWLwRsCAwlyurOaMxgsVy8HTU9eJw0n+cdDz/uVbc1P4pziAvQAFmKbEKd+IQSNzmVhVPye
 5p5crnE5iOeWMRbXto4Fl9RYyINuiTeXhecqYoVl0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 13 Nov 2020, Jeff King wrote:

> diff --git a/packfile.c b/packfile.c
> index 63fe9ee8be..9702b1218b 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -148,7 +148,7 @@ int load_idx(const char *path, const unsigned int ha=
shsz, void *idx_map,
>  		 *  - hash of the packfile
>  		 *  - file checksum
>  		 */
> -		if (idx_size !=3D 4 * 256 + (size_t)nr * (hashsz + 4) + hashsz + hash=
sz)
> +		if (idx_size !=3D st_add(4 * 256 + hashsz + hashsz, st_mult(nr, hashs=
z + 4)))
>  			return error("wrong index v1 file size in %s", path);
>  	} else if (version =3D=3D 2) {
>  		/*
> @@ -164,10 +164,10 @@ int load_idx(const char *path, const unsigned int =
hashsz, void *idx_map,
>  		 * variable sized table containing 8-byte entries
>  		 * for offsets larger than 2^31.
>  		 */
> -		size_t min_size =3D 8 + 4*256 + (size_t)nr*(hashsz + 4 + 4) + hashsz =
+ hashsz;
> +		size_t min_size =3D st_add(8 + 4*256 + hashsz + hashsz, st_mult(nr, h=
ashsz + 4 + 4));
>  		size_t max_size =3D min_size;
>  		if (nr)
> -			max_size +=3D ((size_t)nr - 1)*8;
> +			max_size =3D st_add(max_size, st_mult(nr - 1, 8));

I wondered about these multiplications and whether we should use the
`st_*()` helpers, when reading 1/5. And I am glad I read on!

FWIW I like all five patches.

Thanks,
Dscho

>  		if (idx_size < min_size || idx_size > max_size)
>  			return error("wrong index v2 file size in %s", path);
>  		if (idx_size !=3D min_size &&
> --
> 2.29.2.705.g306f91dc4e
>
