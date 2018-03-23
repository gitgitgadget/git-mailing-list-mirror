Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB7B1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 13:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeCWN5X (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 09:57:23 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:51520 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeCWN5W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 09:57:22 -0400
Received: by mail-it0-f47.google.com with SMTP id j137-v6so2704942ita.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=LP5lnFP1RLzGJwRk1CJK5f5GdeFO39McpSKIpiVRvuk=;
        b=CGXwCYGDjx/qDaq2Z7KyEA6uuefzhb6Za0nkTPfzMmGDxbsZoVLcV9pTjsLjihq85g
         SP1NtACDOAHjGZGQf3xyr7V5mD/zbMYdXWTL8wx8nYMDA4MH1nYrF34FAvWoaHTfjZXu
         UdS2h1rJLrrh0KstZkwUJpQF814P331iVMGhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=LP5lnFP1RLzGJwRk1CJK5f5GdeFO39McpSKIpiVRvuk=;
        b=Mv9hvOPdYH9RtaTUL8Hvnlqz8KPsBPl//g07166o5hhQwCNBrfvOj4vXz+++dADEk2
         CPIOuPW/DEoQLcxUBkyid8Fbb+asIkCw7LFMxw+62JlFpPa5nyqE3+vkiVtztkcJf3Om
         2Am0F3Rk8tkt4lP+vb/aaF5KQn+Su7L9y65btgi1ClCYMbP1meP8R0Uv4NjRxBdenbNV
         Ra763DVsgkHCrYWe9Jud3KPUrYqln3wjQxE1U5wkgvjWuFmVeWTzN/8it9RKC6VMZfE9
         yms1kZNn4q0xmFwYqL/uAjJVmnGAqDO52FkxMb9iw3Ax9/wr2XLgftDbE7aHxugEXU6b
         NUig==
X-Gm-Message-State: AElRT7GTIoRdT0AOim22Db9IDDukNwAnAewh+lk1+FETpsAfdsEXs4dW
        5zfSrHh0vuY9lsi4aWIO/V7K1mvcNXE=
X-Google-Smtp-Source: AG47ELsGDjCJrlRYJhFBM2lqBQrGCN67RuL5WuvKD8wZxsR8earQ2NmO1xRy628n3KXfrTazwohaIw==
X-Received: by 2002:a24:4507:: with SMTP id y7-v6mr13137738ita.112.1521813441533;
        Fri, 23 Mar 2018 06:57:21 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id i94sm6459655ioo.46.2018.03.23.06.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 06:57:20 -0700 (PDT)
Subject: Re: The most efficient way to test if repositories share the same
 objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
 <87o9jfyl0y.fsf@evledraar.gmail.com>
 <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
 <906555df-e906-775a-0255-fbc71f7138f6@linuxfoundation.org>
 <xmqqa7uzlr8x.fsf@gitster-ct.c.googlers.com>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <179c3cf0-72bd-559a-1e00-b18ce97e8136@linuxfoundation.org>
Date:   Fri, 23 Mar 2018 09:57:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqa7uzlr8x.fsf@gitster-ct.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8YQGB6pimIskkwsvH4bQdCwRdxOm0KZI7"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8YQGB6pimIskkwsvH4bQdCwRdxOm0KZI7
Content-Type: multipart/mixed; boundary="43xofovfbocWTpIR1SJXcjrwvCSGlJhuX";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 git@vger.kernel.org
Message-ID: <179c3cf0-72bd-559a-1e00-b18ce97e8136@linuxfoundation.org>
Subject: Re: The most efficient way to test if repositories share the same
 objects
References: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
 <87o9jfyl0y.fsf@evledraar.gmail.com>
 <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
 <906555df-e906-775a-0255-fbc71f7138f6@linuxfoundation.org>
 <xmqqa7uzlr8x.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7uzlr8x.fsf@gitster-ct.c.googlers.com>

--43xofovfbocWTpIR1SJXcjrwvCSGlJhuX
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 03/22/18 17:44, Junio C Hamano wrote:
> Wouldn't it be more efficient to avoid doing so one-by-one? =20
> That is, wouldn't
>=20
> 	rev-list --max-parents=3D0 --all
>=20
> be a bit faster than
>=20
> 	for-each-ref |
> 	while read object type refname
> 	do
> 		rev-list --max-parents=3D0 $refname
> 	done
>=20
> I wonder?

Yeah, you're right -- I forgot that we can pass --all. The check takes
30 seconds, which is a lot better than 12 hours. :) It's a bit heavy
still, but msm kernel repos are one of the heaviest outliers, so let me
try to run with this.

Thanks for the suggestion!

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--43xofovfbocWTpIR1SJXcjrwvCSGlJhuX--

--8YQGB6pimIskkwsvH4bQdCwRdxOm0KZI7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWrUHvgAKCRC2xBzjVmSZ
bHoPAP9rLlhtKNNegQv3/7hUAseTX/UA8QsEDMvbxZEyagSbFQEAn/bfhGEJAgtm
iNn/6Yu2n+GFjvKOZfKPjOgtmyhF6QU=
=eCaA
-----END PGP SIGNATURE-----

--8YQGB6pimIskkwsvH4bQdCwRdxOm0KZI7--
