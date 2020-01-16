Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AB3C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A174206D5
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="U68JKlbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgAPQRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:17:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:39741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPQRy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579191455;
        bh=9vsv0n3rF1rIxGAVXulBAK2xKOUEjEJ1GvVQSFCcREo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U68JKlbbBCIvNzI2RPpbdRTiEbHM5H58MkhItOJlvkeCuIlyheaecspqoQuN+zrqo
         nb85XAew2RKcrtSzh6Aa2wUoYWl76anWafaDt9Ke11O0k546GaTYCSs2fY24fJu7gM
         lavQh4jtpv4aVfI0eBxjGY5IYrZwavjWWGXs889M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1iv92S2KeR-0032LP; Thu, 16
 Jan 2020 17:17:35 +0100
Date:   Thu, 16 Jan 2020 17:17:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kyle Meyer <kyle@kyleam.com>, Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Yaroslav O Halchenko <debian@onerussian.com>
Subject: Re: [PATCH] submodule add: show 'add --dry-run' stderr when
 aborting
In-Reply-To: <20200108003121.28034-1-kyle@kyleam.com>
Message-ID: <nycvar.QRO.7.76.6.2001161711310.46@tvgsbejvaqbjf.bet>
References: <20200108003121.28034-1-kyle@kyleam.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gyJXHSf6IcghEAU8eXIk6naLlMIz4jr/Yb/n8bBsugQgu/6HFAx
 Dt8x7HzKgJpA76FW9rRGlbUVprLWN9TGv1H3j7KpYjyD7HWJGTr3+8OLdFDFASuffgqyje8
 1HfwX6nvWg86wDJF2EtPNxgPiHbf4J5vpwxE5Q3hq4FGW5w+34hFJnWYvhxHFVV/2coETrm
 3Z/vk6tA2prUdIcAPM65w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:STONTAMRW98=:jwRmUOESpMBGamV5e8Etgy
 Yj3WcdppBhz72drl4xntWaAOZNEJUMGRuA48oSGECViYGNDwFk6awUeAOwvAk4oLPDwbT/hI/
 PFsC+HF1bplvv6SgKWsvowfRXxVoMACyF/1mCpwexc7mO5iVOSWo+waW/z0y3PyvJdVuDluWG
 FS5NTyet4/Q+Zyou/++FBf7AWoTn89L8RUZyXsGBRGXzIASfDPj/biQ4OlWLxRtyeLDJnI2wd
 ij7rBUU6uG2YkCv8BOWctN22kGu2AjcSm7xpPqqYVs4aK9A2AIQzG6+Xh9e06wqKbyHpdg71h
 XKKCod68uiuB3aQ6jd6yDhKzF7dyhMIQUbmU5i+4iNKJ0JLaUs2nFIw/kTdkrif+rUlhfKcBD
 Z6/e5mte0v8TepLD0OVJSFSJyE1rjVWpOeIzrRaE5Zv++WduyJS7XZURSAqa4qOWnVS3BhmOO
 MughAmIHQjauOOsYM8MXBZP+HWcTIpkWJwU9b/o0mKAJUSbdpch05bdd7rEbUoiZQEOU9Vq87
 dVgVwZVfF5cLoHH3geywJeB1TzoIfmhLXKlDENoI+tXJhXd3a+WtlTxIN/o+xxOCyWaFH/BlR
 LOZzuDxkNaTNw8BGyraYRQ5Ky1TGWUu/3DlZfstkn6QrQpQNrJY1OfcCcwZT97ohIGAg21EuK
 1VO4VDxf5jSg4hWYEEbe6YlV8HD4dyBCnLkB/jjJDrLrp9jbS/GWxj7Kjgubv4hqAsp5Bri1M
 QQ3we8OViXHSxgM2EM08VVVpg1KYAW6lxyQ9zUoGeFzL1riDXJLlqxAAzK1MZwdCgmTIH8zqV
 1QO7TEvnE/tjTXoGuAqHb2KnAeg7SN2leSnOZGGlYI1lUY84qUROqQ+mHAzxoF9/aWkmzI+2f
 zRlnMMoGalfB5Z1i3TqvJlP004CsHuzXDyde42yKhlhO+asjLC67SZfe8FFIOU4AvSPOVOGdp
 eUtWjnCyAb6DliNCmlXzW47RiDX41rVCb3VcQpF0IELsJ/oYhPo8tEMOHRpVJH9FsyqaC5C82
 yKtQENhMmobZnBCAtre870sW4bCqvWf0IkfBW7YtwviUXMSyHuUYXKbXDRUZTgxt4+yzDmBQT
 iEY12pAbVS1P14qoDJFit/JZUA2jHzZBKx23o3ODwvD2R80VZ7UDU++NOr+pLQcTWrA6z0wwG
 lb2Jja5DtM+wVNJyjkpzbCUhQU4kCZe3Sj1aagywRD6BOriAXT7zy9rqLRpPdrmklCslaUWn8
 MLoIDJvnI0nivxPXxjgWKSYv/Q5T8UQPeNqnzx4FThgb903+Zm7TvjluH+wc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi (in particular Junio),

On Tue, 7 Jan 2020, Kyle Meyer wrote:

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 7f75bb1be6..42a00f95b9 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -156,9 +156,9 @@ test_expect_success 'submodule add to .gitignored path fails' '
>  	(
>  		cd addtest-ignore &&
>  		cat <<-\EOF >expect &&
> -		The following path is ignored by one of your .gitignore files:
> +		The following paths are ignored by one of your .gitignore files:
>  		submod
> -		Use -f if you really want to add it.
> +		Use -f if you really want to add them.

I think this got mis-merged when merging down `km/submodule-add-errmsg`:
it needs to be prefixed with `hint:` because of `hw/advice-add-nothing`,
i.e.

-- snipsnap --
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 42a00f95b9d..a6973a3003c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -158,7 +158,7 @@ test_expect_success 'submodule add to .gitignored path fails' '
 		cat <<-\EOF >expect &&
 		The following paths are ignored by one of your .gitignore files:
 		submod
-		Use -f if you really want to add them.
+		hint: Use -f if you really want to add them.
 		EOF
 		# Does not use test_commit due to the ignore
 		echo "*" > .gitignore &&
