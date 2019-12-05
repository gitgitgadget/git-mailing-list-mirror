Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5179AC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 19:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0708F2464E
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 19:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="yheZVNWw";
	dkim=pass (2048-bit key) header.d=nyu-edu.20150623.gappssmtp.com header.i=@nyu-edu.20150623.gappssmtp.com header.b="xU7BvWHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfLETFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:05:30 -0500
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:27258 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726946AbfLETFa (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Dec 2019 14:05:30 -0500
X-Greylist: delayed 4319 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 14:05:29 EST
Received: from pps.filterd (m0142700.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5HlA8q033168
        for <git@vger.kernel.org>; Thu, 5 Dec 2019 12:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=KPaGQDAqlo8IYwlFlOc7FeoBJH3VGuqJyyIQ1uJHSTs=;
 b=yheZVNWw+LdD/YRSzfh9BcwtFTjO55foz9KUAuPvhCl0VAyoWIu2uaLOpgfEw7yc5zQm
 r3rveDv4KuFeJfpPCRD9EWHyyV9r7ZQ96E1gLaiu8eohrZORMjHFEZysps4qhWZm0KzB
 GW2C3ZomK3ZmMXy3KfNNQNhrlXmQFYcO1rmzyK6uE5ttxbGtfR3DcpPntAL1fpcnTBvi
 ex9vJa3WYhrtgIzM3ETPMCnBTQMnN3p5FgcIwMDf4CTy+aMgvSJXsE8PR7NSzB9v5w32
 3WN0ynEE/IVF4ISOsLzbGP9mMsLNk5hF9p4NycLm22qCBRoDYXqHre+JpuyaYhtWv+0d 1Q== 
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mx0b-00256a01.pphosted.com with ESMTP id 2wpvsdhyqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 12:53:29 -0500
Received: by mail-qt1-f198.google.com with SMTP id m8so3014254qta.20
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KPaGQDAqlo8IYwlFlOc7FeoBJH3VGuqJyyIQ1uJHSTs=;
        b=xU7BvWHbpi7rNTGf26TIJhH+8v4HcBA7SzAtEVzxMZRPC4oZbb0M5SpRN3jIJVUzCs
         6h2HVkxqxPvSoHMa565EiNIkdOuC4siVKfves0knGUj2zXnWb0DGvatRutCDptvuPF1k
         CojCEOmom6CaRK7eMjJY3u1ieu3okbVsQTLL9EPaM6Z5w22GCEgN9QDHxCpEZxkw3CQD
         jtrs6f214EUkzHOAXn9Lb8LsITZzYHZxgWgE89OoUs1KPy1GcuWM6xZvvvdPKFM0jfRd
         3qN561Z+jW+hW8QYyYDb5Hfz24dixbnJ9WhRTAIlgEGddn5JsqmrHwV62Y9uY4QXlswU
         K6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KPaGQDAqlo8IYwlFlOc7FeoBJH3VGuqJyyIQ1uJHSTs=;
        b=Q3FYZ87wRXMiTHKO73HqgdP0jMUy6g17nFVUmRugb9E8EXLdUpBGHgg91zXUOqbuip
         DOPctNGWX+KOHcQjGw2ENCbYEtWpo9kfeM8xEcj9pUpOgSyAIWNsNNCsMBshnMnksaUp
         XPRmj3clHEBRq+DbGkZGY/dcx5ZQAgGE50FMhQjKtia0VmLi2O8I67KejJXSH8OCOGQ6
         qvzei8P/kGiul7HbRxm8VV5BpeBJBVuzd08AjqNPIb7nI67GiY9HFie8DhTitRmxsK0k
         ZV8eqczjesvW0HoUuMj3X7Rx6EKCqh+gMTx8J3xu2mkfVEL+s/gsjHBNf0YpVrol3sWN
         WdnQ==
X-Gm-Message-State: APjAAAUGp0i+pwskZaIp/16uAOFwyTKn9LFVWLoOVX53cl+TtmqeRELS
        U7+/A4AeJae54BWN6yiZheHqJeuO1W4uuaYSNu4kMGD68hdteiiFBsptlBTIlwVZNaosPxQjMY9
        iNus5h77a0sU=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr3022826qkb.439.1575568408565;
        Thu, 05 Dec 2019 09:53:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxM3TVlWwYowloLu5oLh+OguIRWGT/Ro2Pq+zRbVuqnAPmuVsr0OZgIzb1HjRFGfvAQOLdqgw==
X-Received: by 2002:a37:61cd:: with SMTP id v196mr3022798qkb.439.1575568408282;
        Thu, 05 Dec 2019 09:53:28 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-130.natpool.nyu.edu. [216.165.95.130])
        by smtp.gmail.com with ESMTPSA id l31sm5418463qte.30.2019.12.05.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 09:53:27 -0800 (PST)
Date:   Thu, 5 Dec 2019 12:53:27 -0500
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Nathaniel Manista' <nathaniel@google.com>, git@vger.kernel.org
Subject: Re: [ISSUE] Stop accessing, storing, and sharing the user's time zone
Message-ID: <20191205175326.fxgfofr4xvh7kaxb@LykOS.localdomain>
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
 <047b01d5ab92$159a8240$40cf86c0$@nexbridge.com>
 <xmqqwobazmzp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kyznzkyacc475o2i"
Content-Disposition: inline
In-Reply-To: <xmqqwobazmzp.fsf@gitster-ct.c.googlers.com>
X-Orig-IP: 209.85.160.198
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=8
 clxscore=1015 malwarescore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912050150
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kyznzkyacc475o2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 09:43:54AM -0800, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
>=20
> > .... I currently am
> > running a repository located at UTC+2, with developers at
> > UTC-5. It is driving us a bit wonky. I would rather see only UTC.
>
> I also feel that TZ being PII is not particularly a brilliant
> argument against recording TZ---of course it is PII, so are the
> committer e-mail address and the committer name.  Those who want to
> hide can hide but in order to keep track of provenance who did what
> when, we do record them.

This is exactly what I had found confusing from the original post.
>=20
> As you can guess from the above reasoning, I am not fundamentally
> opposed to introducing user.tz to complement existing user.name and
> user.email configuration variables.

This sounds like a small delta that would probably please everyone. For
now, using the --date argument on git commit allows you to also pass a
timezone:

    git commit --date=3D"$(TZ=3DPST date)"

Which you could easily alias...

Thanks,
-Santiago

--kyznzkyacc475o2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl3pRBYACgkQRo8SLOgW
IpVBdhAAt94AYqR+zb01kERCvIJQISgaIUkFu3VE5T4Yd9vCK1uY3/59Ve+Iemfl
Tw3oNp2dLFmvnKv6d0+bl247mf4oL++215FbHISNEQHkEViRjr/GnmhsA/tJwCXJ
795dA0ab/5ukeYWUG62el2gC9Vnnygs90fs+FG8p9e2GIuQj1b9vGNSNEzrrmCaF
pCh2RP9A4zyvTT4bUADhlyUSmtWdrken9bwDzr5nb3s/Vpjt0Gvq7bm/EjixWrXH
0z7l2douGEfgs7VtmQYXYwn6JdBKydcg3GJkjPj9DIPIGRyGkAAZPVynw9Y2IV3r
rwHOlXPqSglQbdyBYK9sWr9RGneVIx6TolBuWwELFWY4Izeoserj1L8969/pb+N0
TBrRcg8s7YPXwVC/ns9Wtboet2IbjGmL4oaOX+DR9VmbW27MqeSbo2DuHaN76NTt
UWcVpsthQHGok/9UbZcV0TxCJEguMGRn0cPsjXFx2VwSc7EJKDaVHAcog6A8CrdM
eku/HS5dibazb8FQthYLRxJPZW4Dh5BWGZ5c9nPiohHCHNVhktxyY2VWYGtgoafY
lTenuDFG5LipgRQ+dYcieuJg0rQ3RYtt6lvJbJIppgyBTTvERvtPpzKB6RYNowEn
zzXpk1/N85Q1cJtM2TVVfHkm2iaO/8mT6TL8nT3wnNYsUjt6130=
=mjY3
-----END PGP SIGNATURE-----

--kyznzkyacc475o2i--
