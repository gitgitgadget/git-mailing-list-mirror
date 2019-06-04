Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189F21F462
	for <e@80x24.org>; Tue,  4 Jun 2019 05:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFDFA7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 01:00:59 -0400
Received: from mout.web.de ([212.227.15.3]:51289 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFDFA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 01:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559624438;
        bh=pro5jk9RW7iYR4lQwo6i5LWIzSdv/dwF+9n27sQLzvI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NjlPU8Oxg1xPQcQ/RWTCsq3yW1C92aSrakTlwBrWEiE1bTZCNwAW8qOrzkIzPSl84
         b2+zQjAqmfLVZ35dgP8Fmk6pXRzQMk5jVJqhzkIdjAy1DEXilqacCDaIwce6ojs+yz
         zU5bdODN8FYUd10ixWlgW6gYiC+M+Wmm27DA2ad0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.20.65]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMnD5-1hUycb2Leh-008YLr; Tue, 04
 Jun 2019 07:00:38 +0200
Subject: Re: [PATCH 1/2] url: do not read past end of buffer
To:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org
Cc:     jeffhost@microsoft.com, gitster@pobox.com, spearce@spearce.org,
        jrn@google.com, Jeff King <peff@peff.net>
References: <20190603204526.7723-1-matvore@google.com>
 <20190603204526.7723-2-matvore@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <18ab56e2-3b25-8cfd-438d-72f49145adc4@web.de>
Date:   Tue, 4 Jun 2019 07:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603204526.7723-2-matvore@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K0ajYUqdWjnyDOZzjfwxjbGojxLC9iasz8lEyuDivGGcf3ua1YC
 sfZzd9sQeNZoqZMTY+/L0msR9dNWwtFHMVckLekQEj70l045I4n8B2ObtDDIzoKel0Lm3HC
 83FLtixn3v1jN9vpImfepz8jHZtyric3cshg+q4b1F2/pspyUzTKYFSnQ3xX33da7I2WTTd
 VRHDJgeRmQK7vgDvTqAOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZFfdjTsOy5A=:GGQNv4Xy4LaWFl/KUiqXhE
 FefgaPUJYjn5vQZUJQ/tY0I1unrbl15IgqYomSIgUP5WmSp7lBeZdY46zpehHb06+SY3Qyo2P
 0VjnUmIoKGrkn8BN9r2NtGjKiaiNGHpp9TIxnWuXXCrUt1/Hk6uSPYVUvVfxXGjwriWbTqTQo
 PbUGlQxMb71VrcWmjGfsrM0yvqrLwtGjfylo5X99GPBMq4fQnn+UqmvWnqvzrAP18dZRr5jSw
 Dz5xJeu73/TH63AOwZVWtFlV0C4OaHYJN+m8UsMQRwrzdaMoycDTeJ3v3IKMxtC3HvpZaYgdG
 qZLl1lGDayypP2hrNxMIB2b6bPXAqGJuJe3yV35B8Bqwgiq07KwBXbYjC1FBpUE3suCzwxoMe
 85IUzPifJ5qB619uQEDEkFsJGNL8O7vS1qk8IuYvbju5fZRK9hRHnOmoPRemIzWUdALGdH9uL
 KX0yw8X1muKeb9ztghlFxqeKONRCjuk0QqhsTsVvQRHCjhfLArvxEbEipjxwzjLm6lCxLD3Jo
 3QhA74RRTpBTlX1Tx48zFhXsM9BqjDDVbRPku05M2J9DPBymswzl1xeGn7UqlLobAInXzUIIm
 bkVmB+kKKtc8+devH/qOVWeg1QeqDiAgIiKc23cGRbEmDpgndJnzHrB175js9x9JLzy0qaJXY
 7ANjq+wVEL3aOlR/eCLg7OSbP23isbZL4td7zJwbAYy+42OXOFX2cuRlMprrO4JrmePcBVah5
 eDBnmp1tkdnJN2sctoFtIxsat/ppdDMPrLCVA+CT0/r8w9YJ4NR08UhHVMdmL61fdOG8KtWC6
 Ko7RmZzEXrI0+k14eaqlmlZ/aYkRGmqQe9hEKyArV8VE4kBcR2VASIyR/aDLbW5lE+acgxVTW
 Y/SLAHjFIVQegU0qlEbWFFTzDS+UvRNH6leCLPsUggsJK2anDnrzPVt5x5oC7hG41kDTltbIe
 srP+u8wE+A9gFd6CDVxtZPHBLwnI1pGk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.19 um 22:45 schrieb Matthew DeVore:
> url_decode_internal could have been tricked into reading past the length
> of the **query buffer if there are fewer than 2 characters after a % (in
> a null-terminated string, % would have to be the last character).
> Prevent this from happening by checking len before decoding the %
> sequence.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  url.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/url.c b/url.c
> index 25576c390b..c0bb4e23c3 100644
> --- a/url.c
> +++ b/url.c
> @@ -39,21 +39,21 @@ static char *url_decode_internal(const char **query,=
 int len,
>  		unsigned char c =3D *q;
>
>  		if (!c)
>  			break;
>  		if (stop_at && strchr(stop_at, c)) {
>  			q++;
>  			len--;
>  			break;
>  		}
>
> -		if (c =3D=3D '%') {
> +		if (c =3D=3D '%' && len >=3D 3) {

Tricky.  hex2chr() makes sure to not run over the end of NUL-terminated
strings, but url_decode_internal() is supposed to honor the parameter
len as well.  Your change disables %-decoding for the two callers that
pass -1 as len, though.  So perhaps like this?

		if (c =3D=3D '%' && (len < 0 || len >=3D 3)) {

In any case: Good find!

>  			int val =3D hex2chr(q + 1);
>  			if (0 <=3D val) {
>  				strbuf_addch(out, val);
>  				q +=3D 3;
>  				len -=3D 3;
>  				continue;
>  			}
>  		}
>
>  		if (decode_plus && c =3D=3D '+')
>

