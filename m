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
	by dcvr.yhbt.net (Postfix) with ESMTP id A18261F462
	for <e@80x24.org>; Tue,  4 Jun 2019 05:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFDFBT (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 01:01:19 -0400
Received: from mout.web.de ([212.227.15.14]:48319 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfFDFBT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 01:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559624463;
        bh=xzveNjnnkxamftC59LpE2/gbI09jPKN0UF/O+/o35vs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Prfb5hUMJQt8kQmsYR+ONFldkCumz8EezDSvS30YQSOuslOnNpzOHlz9X8riezi5C
         tTCm8QgdsPp9CSA8BjlJGnOwjFvl31XSz34a5c/DDhV+uXFDhjDo1kT1blLCq5Gex3
         oNSJtFWG/rLCnlvpXavjPWOiOLVLI9GW7777RMfs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.20.65]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRlJB-1h9RFG0kNV-00StGm; Tue, 04
 Jun 2019 07:01:03 +0200
Subject: Re: [PATCH 2/2] url: do not allow %00 to represent NULL in URLs
To:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org
Cc:     jeffhost@microsoft.com, gitster@pobox.com, spearce@spearce.org,
        jrn@google.com, Jeff King <peff@peff.net>
References: <20190603204526.7723-1-matvore@google.com>
 <20190603204526.7723-3-matvore@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ca09cb2f-e376-1491-102d-0b06e49530a4@web.de>
Date:   Tue, 4 Jun 2019 07:01:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603204526.7723-3-matvore@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fgd+Bkk+Q4DzVh5MwQSwX0YluY4AyULbkXhG5Recix+s3kwBf2E
 l29r8VsEg8WjunFP3ba1/t9oQ0mY33s1Ihl2/ecuUitL/43o0yJWiL7+vWJ2DlwR5K0vzYj
 okh1R70ZEIZQOucG4+PRZKIGwK7JG04AxvPpNLDGOokXbWnd+DUKRk9/XaSJRSpxlqFy5oC
 /QlghL2GNEOUXkcT2OOLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6X1J14/ikA=:AZ6IVyToWUtZImbN/pD0e/
 Wsbw768Tw79oY/PVfSq7MPG8qQHRTXK8mV5hoZqRVKmQwlDZecU3ADy1/SQuBGHQQvDl4hiQt
 CLCLaLK/G4iVSRJ9JvBFYdCIsmgeDWrriyHy7aXXF/OjNTfVJA0WS/PcOfAZVjdsMnAj6oVAM
 /KWn27Z93rveRMoc1ln0TtVuXtIJw7QAZ2olFYlP6LImNCRV2J0Q1dNdvi+3bbu1O6c8HK407
 j4bmIj7ejhEyKznrA6YxS9agVnywCFaqt89FloWs25BVqjdsPf+FOkzAhuo778nw22cYut7NF
 jTBvEirzZXFIrqrurpszOiC5Ulk6N0Hfgb3ywSJ54wg2TlJlVYy41do3C9jlzRDiVCkckemhG
 d78oKamsqy6hqww3Xe6xUehmu7iqMKA5JcbQScC7oDGuked/j3qRVBF54HK4XfcmwmgneXTYU
 4kpt+ZXLufWCHYV0nU6aPQ4W80jOcTHI6KBrmwqZYSI7kuhBqHhSoiKcJ0Te/aDHUnbrssP+C
 337kuLRxNatb4SHuJy0gQHveSb6uLO4//MrLJr5s6spz7CkUdeRbc90jlRKF1/Tby85AIRE7+
 wtG2G3y3QMGgl0/hHw4chVOQAeiwR04xk0H/ppzpQoQRwzQajtKCRb9O1FTt38xIRlk9Om1Hv
 wJVgddrbNJbFt9FMWUffX1bSJlE5eR6pBD69a2YGPhBfcrbshQ0N4ta3XOSzbMXTw6wHdPXpP
 +nPCub7JMkMoI2BFGEctggndx5IlMDY812DOnY7ZkoUNu8op/3Bil6iIbVm8uMGAEX48nAyBt
 Bdpahdp0QwmQNz7vS5riNrmmFCABQKUH+U2exji7nA7ZSBUphGVu8ediS4sBJYN3Hu6CF6c6G
 KHvmMbDglFbL5LP0SFG319dRaF5mEn834Hw8bRHzjMulFCdxKIOJ92zJZPznFViXuf+hDMabV
 FvZ9LKPRzjcslwK6kY6OSUp0UvzVvqVE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.19 um 22:45 schrieb Matthew DeVore:
> There is no reason to allow %00 to terminate a string, so do not allow i=
t.
> Otherwise, we end up returning arbitrary content in the string (that whi=
ch is
> after the %00) which is effectively hidden from callers and can escape s=
anity
> checks and validation, and possible be used in tandem with a security
> vulnerability to introduce a payload.

It's a bit hard to see with the (extended, but still) limited context,
but url_decode_internal() effectively returns a NUL-terminated string,
even though it does use a strbuf parameter named "out" for temporary
storage.  So callers really have no use for decoded NULs, and this
change thus makes sense to me.

>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  url.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/url.c b/url.c
> index c0bb4e23c3..cf791cb139 100644
> --- a/url.c
> +++ b/url.c
> @@ -41,21 +41,21 @@ static char *url_decode_internal(const char **query,=
 int len,
>  		if (!c)
>  			break;
>  		if (stop_at && strchr(stop_at, c)) {
>  			q++;
>  			len--;
>  			break;
>  		}
>
>  		if (c =3D=3D '%' && len >=3D 3) {
>  			int val =3D hex2chr(q + 1);
> -			if (0 <=3D val) {
> +			if (0 < val) {
>  				strbuf_addch(out, val);
>  				q +=3D 3;
>  				len -=3D 3;
>  				continue;
>  			}
>  		}
>
>  		if (decode_plus && c =3D=3D '+')
>  			strbuf_addch(out, ' ');
>  		else
>

