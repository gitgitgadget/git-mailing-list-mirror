Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABB3C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 10:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCIKxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 05:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCIKxO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 05:53:14 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797450F90
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 02:53:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id az36so844039wmb.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678359182;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ca+cDi7P9Q1OXxZ4i1o22SxJmIFvwtPz8XgKGSBfQ2U=;
        b=fsaX+KyhBA8K4g2Ydkk0UbcBCAlc3o6FfMaCZya4TWbwgMcFt5coS1YPCZAunhiYBC
         +HUifWwAXQ8DZLd0RCDRCAX6sBvsNGFUbMg+10rsqSp7Wk6lmC5o7WBvkAruFtb6p2J6
         yV/hH6XEfei8JYS+NH3M50ZsyzDFC2qOBGccnQz5QLaFlgUJJHeUxx0dxmZu3Wsybl0E
         J1fttugq6kkpXuCWN07KdPwrZRqr+c8xOPy3lWm3s+pxnj8bTIgkEMao0Kt7mzEfD6I5
         WqzjITjQtVjrMcTLXWRXDe0lzKc2fIwQjXRjE/auAsFVE3A+f9OS/KMRrDfBOruNX6rD
         k+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678359182;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ca+cDi7P9Q1OXxZ4i1o22SxJmIFvwtPz8XgKGSBfQ2U=;
        b=X1t30GuvP1K9CPbq1yicbLYVzYW6+Aq7yXYYH/9JD5knWNbSrTAL54TvCQgoG2yfDp
         x7dgYXY9Ae16bMTSibY07BE2g808cr2BX4Whkdu3fU6TI1AbV0EjLjygnpQS7Ga2YYWO
         CpsNFah2LHbepElz+Ssvan7PHK9+2MeF4GZKVcgn7UmtilhaPydnRkLYYNMiQbgEpMIi
         3kCT+F36Aj+qZERAitxwJwvgKVQxArvrwXXvg5YnJHcYyrToeZ+r+EcdRG+dDpNAzaev
         bshtX0BLMoeau3cziF81k8WnhL7xm+XMwcTuhwjmiikUDf/ZMgkabwawH2PKylOJ+fAp
         B0Jg==
X-Gm-Message-State: AO0yUKVS1NVa8a+F+2YUoerfKNeEgdqy5Y1EfUp/Inj9QXf0MdminoG7
        1ihaVAlOMPYYo9Zh1h/KBXA=
X-Google-Smtp-Source: AK7set9E/tHK9UoxEcjuzlIX2A5tn+wd53xPEMWpb2kLBmSCkNjNfPBvZuG/8hQ6gND3sYB75K4SNQ==
X-Received: by 2002:a05:600c:3b95:b0:3eb:2da5:e19 with SMTP id n21-20020a05600c3b9500b003eb2da50e19mr19135565wms.27.1678359181837;
        Thu, 09 Mar 2023 02:53:01 -0800 (PST)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c511600b003daf6e3bc2fsm5469658wms.1.2023.03.09.02.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:53:01 -0800 (PST)
Message-ID: <48706417-c184-fdd8-e3f4-edfd582b4358@gmail.com>
Date:   Thu, 9 Mar 2023 11:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/5] format-patch: do not respect diff.noprefix
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl4pZV08a6Bgoip@coredump.intra.peff.net>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <ZAl4pZV08a6Bgoip@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Lqz7Yii2pH1nbTOmrTHjUNj1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Lqz7Yii2pH1nbTOmrTHjUNj1
Content-Type: multipart/mixed; boundary="------------d4OTwcPilXdPxeGKR7CwH7zt";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Git Mailing List <git@vger.kernel.org>
Message-ID: <48706417-c184-fdd8-e3f4-edfd582b4358@gmail.com>
Subject: Re: [PATCH 4/5] format-patch: do not respect diff.noprefix
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl4pZV08a6Bgoip@coredump.intra.peff.net>
In-Reply-To: <ZAl4pZV08a6Bgoip@coredump.intra.peff.net>

--------------d4OTwcPilXdPxeGKR7CwH7zt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 3/9/23 07:11, Jeff King wrote:
> The output of format-patch respects diff.noprefix, but this usually end=
s
> up being a hassle for people receiving the patch, as they have to
> manually specify "-p0" in order to apply it.
>=20
> I don't think there was any specific intention for it to behave this
> way. The noprefix option is handled by git_diff_ui_config(), and
> format-patch exists in a gray area between plumbing and porcelain.
> People do look at the output, and we'd expect it to colorize things,
> respect their choice of algorithm, and so on. But this particular optio=
n
> creates problems for the receiver (in theory so does diff.mnemonicprefi=
x,
> but since we are always formatting commits, the mnemonic prefixes will
> always be "a/" and "b/").
>=20
> So let's disable it. The slight downsides are:
>=20
>   - people who have set diff.noprefix presumably like to see their
>     patches without prefixes. If they use format-patch to review their
>     series, they'll see prefixes. On the other hand, it is probably a
>     good idea for them to look at what will actually get sent out.
>=20
>     We could try to play games here with "is stdout a tty", as we do fo=
r
>     color. But that's not a completely reliable signal, and it's
>     probably not worth the trouble. If you want to see the patch with
>     the usual bells and whistles, then you are better off using "git
>     log" or "git show".
>=20
>   - if a project really does have a workflow that likes prefix-less
>     patches, and the receiver is prepared to use "-p0", then the sender=

>     now has to manually say "--no-prefix" for each format-patch
>     invocation. That doesn't seem _too_ terrible given that the receive=
r
>     has to manually say "-p0" for each git-am invocation.
>=20
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Alejandro Colomar <alx@kernel.org>

> ---
>  builtin/log.c           | 9 +++++++++
>  t/t4014-format-patch.sh | 5 +++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/builtin/log.c b/builtin/log.c
> index a70fba198f9..eaf511aab86 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1085,6 +1085,15 @@ static int git_format_config(const char *var, co=
nst char *value, void *cb)
>  		return 0;
>  	}
> =20
> +	/*
> +	 * ignore some porcelain config which would otherwise be parsed by
> +	 * git_diff_ui_config(), via git_log_config(); we can't just avoid
> +	 * diff_ui_config completely, because we do care about some ui option=
s
> +	 * like color.
> +	 */
> +	if (!strcmp(var, "diff.noprefix"))
> +		return 0;
> +
>  	return git_log_config(var, value, cb);
>  }
> =20
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index f3313b8c58f..f5a41fd47ed 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -2386,4 +2386,9 @@ test_expect_success 'interdiff: solo-patch' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'format-patch does not respect diff.noprefix' '
> +	git -c diff.noprefix format-patch -1 --stdout >actual &&
> +	grep "^--- a/blorp" actual
> +'
> +
>  test_done

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------d4OTwcPilXdPxeGKR7CwH7zt--

--------------Lqz7Yii2pH1nbTOmrTHjUNj1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQJuowACgkQnowa+77/
2zIoLRAAm4BcBzv420DJWZ0wGkkeSg1DWzFK3D4bTkORmqeXCVHMkG7JOk8azECr
5wf8y4wHIDrIzufXdj8NyRcNpzbeeeYLq+YcREy24vJlU+qOU9MCMxKhHWX3En84
6vpjkaO6yAkUzmfrfcIiQOIYaNwrgBChK1X9aT/7UKN/8U4dTP/PeqYby5R60SJ7
wSZ5mDxwORB2I6OWR4AjRDLr9jgOTVXzP/mu2oBpsqijsbQI9UtmMFSdxjfctFt4
RbyyYwh1xR2NAqkhfQwbjit5ZHZMj4AEhRznsOUn3bSUpWLUuuO4wYjg9ym40Fmc
LJsaGULeXjM+G1IlRLXANIVeOJPmL1pUuE+KKI7GUg4U7RiICIKCFQzkcX/L5/VX
6h8flz4+usolgI5TRPwiwdFcbhrPNSwW235qo4kNranREpH4OsdEnZvtpIEfcVp5
3JSIBlaDvu+lWfHBxZO8HqHG9rP0n/3sodNvBDklYhZu35vqDGm6H6lZv6uwc8QV
r/dg7Z4uw8C+2k6bGu/gCcgbdYCsnK1YBa3FtW2az/s9Px4l06YGk+WwC3s/C20K
BFvfwGADzWlp+vm/XkQG237EjzW9U6k/D0R5TM6BazEON6yKlYBOiY3hBQcWO9Mt
6fqDoqwozoLvZIXDJ1HlsohF9Axajrl0MW+2R26BrRsKOQi4W1A=
=bUNp
-----END PGP SIGNATURE-----

--------------Lqz7Yii2pH1nbTOmrTHjUNj1--
