Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5271F404
	for <e@80x24.org>; Thu, 22 Mar 2018 21:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeCVVcq (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 17:32:46 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:44109 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeCVVco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 17:32:44 -0400
Received: by mail-io0-f173.google.com with SMTP id h23so12731006iob.11
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=TjZzcffjnHYDpN9Hmsi93x4+7Hk8/L0LyTxnmDMdsQg=;
        b=NPrYmT9rHWMr/+ak4pOYsZ8v4TLMvkS1pjrxxKIGrAM8Qrz7/OYBnS7GLNzfCC2K5p
         TBpI7bczBhcHyq/NxLcDZXsGAqzXLpgILH77ymcAAJAuE5g26PVrQBh0aKgf0VBPLJeB
         i+k5vQdEX+/V8XdqvEs9dlaVcGbtgCk3SaY/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=TjZzcffjnHYDpN9Hmsi93x4+7Hk8/L0LyTxnmDMdsQg=;
        b=FxOb+Mmnog4q9pjjcfDnfMl4ZOuVB2B/XU36bIaiaUTlGebeYSKJ7MM1tNuOKXNfnd
         ubMsVwF1aIVhAzCCAuQ8eHVLMeNUB7bnhVQYP3pvl/OVug/zvJoXM+5e403qyTRi3YCc
         mtBSXB7JN9p+h7V9RBQ2Ib8/mrnbqY+qujFf4sX0GNJ0F4hZKhZpa58qiKZJ10iHHb+u
         ZKyNrrlo6zC1hor6RxuuJNhAkdMFZ84em45R1PXkmToY2xpbzR6vQ6xihTt5CuBZO6Cl
         9P2RBJMfgNmbAiMKckRaVCfwkh3sr5qU72gOV9iMkbi/02iPVINYqSa2dTmxyd/IYpj+
         N3gg==
X-Gm-Message-State: AElRT7EjvoK0Zv1irKu8M1R0Y+Q1HkWSKxgHqgh+O1pvfjta+hXePcSq
        Zb8ieTam0L5u6RWhQZVE8f8dCsqT8WM=
X-Google-Smtp-Source: AG47ELtBH9jzEF0EBZ3917PoNe15Kk5fWvTd/BXk+A92zgZZiM8EFTnXU2CARznh/Y/ubNHKvsf+ZQ==
X-Received: by 10.107.84.8 with SMTP id i8mr26566253iob.254.1521754363342;
        Thu, 22 Mar 2018 14:32:43 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id e73sm5422337iod.34.2018.03.22.14.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 14:32:42 -0700 (PDT)
Subject: Re: The most efficient way to test if repositories share the same
 objects
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
 <87o9jfyl0y.fsf@evledraar.gmail.com>
 <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <906555df-e906-775a-0255-fbc71f7138f6@linuxfoundation.org>
Date:   Thu, 22 Mar 2018 17:32:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bLkDaopkoNS4bN3RJfGm0fPJ9tkaYXh2j"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bLkDaopkoNS4bN3RJfGm0fPJ9tkaYXh2j
Content-Type: multipart/mixed; boundary="ZlfJtcDl4dln360no51XJMURV9Vb6C3YU";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <906555df-e906-775a-0255-fbc71f7138f6@linuxfoundation.org>
Subject: Re: The most efficient way to test if repositories share the same
 objects
References: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
 <87o9jfyl0y.fsf@evledraar.gmail.com>
 <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlgejlx8e.fsf@gitster-ct.c.googlers.com>

--ZlfJtcDl4dln360no51XJMURV9Vb6C3YU
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 03/22/18 15:35, Junio C Hamano wrote:
> I am not sure how Konstantin defines "the most efficient", but if it
> is "with the smallest number of bits exchanged between the
> repositories", then the answer would probably be to find the root
> commit(s) in each repository and if they share any common root(s).
> If there isn't then there is no hope to share objects between them,
> of course.

Hmm... so, this a cool idea that I'd like to use, but there are two
annoying gotchas:

1. I cannot assume that refs/heads/master is meaningful -- my problem is
actually with something like
https://source.codeaurora.org/quic/la/kernel/msm-3.18 -- you will find
that master is actually unborn and there are 7700 other heads (don't get
me started on that unless you're buying me a lot of drinks).

2. Even if there is a HEAD I know I can use, it's pretty slow on large
repos (e.g. linux.git):

$ time git rev-list --max-parents=3D0 HEAD
a101ad945113be3d7f283a181810d76897f0a0d6
cd26f1bd6bf3c73cc5afe848677b430ab342a909
be0e5c097fc206b863ce9fe6b3cfd6974b0110f4
1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

real    0m6.311s
user    0m6.153s
sys     0m0.110s

If I try to do this for each of the 7700 heads, this will take roughly
12 hours.

My current strategy has been pretty much:

git -C msm-3.10.git show-ref --tags -s | sort -u > /tmp/refs1
git -C msm-3.18.git show-ref --tags -s | sort -u > /tmp/refs2

and then checking if an intersection of these matches at least half of
refs in either repo:

----
#/usr/bin/env python
import numpy

refs1 =3D numpy.array(open('/tmp/refs1').readlines())
refs2 =3D numpy.array(open('/tmp/refs2').readlines())

in_common =3D len(numpy.intersect1d(refs1, refs2))
if in_common > len(refs1)/2 or in_common > len(refs2)/2:
    print('Lots of shared refs')
else:
    print('None or too few shared refs')
----

This works well enough at least for those repos with lots of shared
tags, but will miss potentially large repos where there's only heads
that can be pointing at commits that aren't necessarily the same between
two repos.

Thanks for your help!

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--ZlfJtcDl4dln360no51XJMURV9Vb6C3YU--

--bLkDaopkoNS4bN3RJfGm0fPJ9tkaYXh2j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWrQg+AAKCRC2xBzjVmSZ
bIapAP90LrjMH1NyQaFPdj5FPCaVlAwu7/j0Ml8qoKTFTiWwdwEA7bdOBgJ/OmM1
jW+WUOJdGAKsEK5s/zOpyX/c/383QwU=
=Ni7+
-----END PGP SIGNATURE-----

--bLkDaopkoNS4bN3RJfGm0fPJ9tkaYXh2j--
