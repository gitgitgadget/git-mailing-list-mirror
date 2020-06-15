Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00BAC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB5C207D3
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="tuuV2SaO";
	dkim=pass (2048-bit key) header.d=nyu-edu.20150623.gappssmtp.com header.i=@nyu-edu.20150623.gappssmtp.com header.b="su/ihXhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgFOVmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:42:17 -0400
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:23394 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgFOVmQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jun 2020 17:42:16 -0400
X-Greylist: delayed 1878 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 17:42:16 EDT
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FL9K22097919
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 17:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=2Q8qkZuU6/DwOSL4ZWfq1ESGYUA7M/ME6DqfLD5nGno=;
 b=tuuV2SaOBTmW1OYflUG85ERatPosx82/uKG4noC5UP+MbV68Is8qEeuZ/EctZWrZAxf4
 g32evs/YX4SY8MiXmWKxv+lxRIzykdzQw8GH74kDnGPx6knNR6ySUL6tF+F2h7Z3Yymj
 yZBa3lXdGMub5oFGVJ46EIpk0sAmMGfKIKxyrvcAo9dqgvLWSltKY+mJ8Lur1zbz9z5o
 gA8cyyEbCY3SI06YAcJvtivFb8rsltqqa1nrtDDC793g0y1f446xeQy7AYtZ/uFOZaWU
 q4JIc4YVUIU00UvKzCGwc9OIhEiW9lLZLEtBF/QTTdcb/Angm8K1m/+aLa92chjgtpns Lg== 
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mx0b-00256a01.pphosted.com with ESMTP id 31nn1gbewc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 17:10:57 -0400
Received: by mail-qt1-f197.google.com with SMTP id q21so15046365qtn.20
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Q8qkZuU6/DwOSL4ZWfq1ESGYUA7M/ME6DqfLD5nGno=;
        b=su/ihXhUeZv6xvxY5Uv7pU/58+x4g05fJQDn6LX5NSgnPzKfJ4iIZl58m5Cni1MhKS
         7O85Gn+elZYHstqzVLrbMetKEbV1tQq1Rv/PnZ3K9FhcsJ84Jt2W+LPUfPQ7fyH70/zi
         KAXW1t578pLvDMS0DMV7OVOWw8imx3ev+imi7I7YwZPxGNVqW7LzwWC8ghUiFuAtxLM5
         ZKuICm36Bk/Lrw21WDPyrBhcxQpEskpCIcX3B7jrZQEvyZWjnxEPLE4jysqTZFM7tz+h
         82zlpkYvGIBbwqoyy8PM+HhpuF9MRP5w7bjfctHs0hua7FRKgh+WpyLiR7oDDw2le8DL
         sHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Q8qkZuU6/DwOSL4ZWfq1ESGYUA7M/ME6DqfLD5nGno=;
        b=qwDbKpfhBhMZSdxrJLw0H4tyhy9Wza6MLjxqQH0tAVi12kjDSoOnq6ZYrnUs9KpNu4
         B8fDR0fpehfz3uY/oJ4BVZHNhpijw3H4lTcNOE1/kSSbHH+HxzBomkCL7l5WNcW0c8nz
         1x6PwzgowMgI+JUtUqL6YBWecPQswk+2VLifLlC1oKSRFrTYeMoEhUHv7oXwsHEGL9kL
         v50c2iHvkforX9jfZchxa92CAluvGhST5BUFUoU9EwVWjumvExX23aYgElxSvoDQW8gW
         RkHbu1QI+9DGtdnAmbuFgJt3GvuvJIP0c683JpQtqzGwQlXtosp79hff5aHE38KoyO2z
         t9Uw==
X-Gm-Message-State: AOAM532KaoW9g9BPhwQ7+UMuMODAlWHQ8FRezDX7Vy2ScB9a3/8k2n/D
        dtCRALtXH8OQxQ50A13VdZxLEPf0Q+MakZctweine9Ljk9qDD/hefqJT26XXoEQuJgVU7HwPgcs
        8CnHkxVsHgzo=
X-Received: by 2002:a05:620a:122e:: with SMTP id v14mr17170696qkj.94.1592255457381;
        Mon, 15 Jun 2020 14:10:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrMOEnEZyezAmPJ8F2+PZNqeT2vEtZ1iEadpEgxtWmxL58CLjSjxkOeohaEROSkvhxpXiQeA==
X-Received: by 2002:a05:620a:122e:: with SMTP id v14mr17170676qkj.94.1592255457161;
        Mon, 15 Jun 2020 14:10:57 -0700 (PDT)
Received: from LykOS.localdomain (ool-2f10876a.dyn.optonline.net. [47.16.135.106])
        by smtp.gmail.com with ESMTPSA id g47sm13430641qtk.53.2020.06.15.14.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:10:56 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:10:55 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <jramsay.com.au@syl.local>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200615211055.7fggbfnjk2mawb6h@LykOS.localdomain>
References: <20200615205722.GG71506@syl.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="datp2buig2v2s4rd"
Content-Disposition: inline
In-Reply-To: <20200615205722.GG71506@syl.local>
X-Orig-IP: 209.85.160.197
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=7
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 mlxscore=0 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150152
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--datp2buig2v2s4rd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 02:57:22PM -0600, Taylor Blau wrote:
> Hello,
>=20
> Over the past few days or so, there has been significant discussion [1] a=
nd
> patches [2] about changing the name of the default branch away from 'mast=
er' and
> towards something else.

I've been refraining myself from commenting (specially with so many
passionate voices on [1]), but I'm happy that this is happening. While I
personally don't see anything offensive in 'master', I think it's
worthwhile to try to accomodate more people in the community. As always,
it's harder to identify what is bothering a particular group if you are
not part of that group. Kudos to the community (and to you Taylor) for
trying to move this topic forward in a constructive fashion.
=20

> My interpretation thus far is that 'main' is the planned replacement for
> 'master'. Consensus seems to have formed around this name [5], but if tha=
t's
> incorrect--or there are yet-unvoiced opinions that you would like to shar=
e--now
> is the time to discuss further.

I'm not familiar with how formal consensus is built in this community,
but take this as an explicit +1 from me.

Cheers!
-Santiago

--datp2buig2v2s4rd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl7n494ACgkQRo8SLOgW
IpWd2g//a2hGPRSqdr4EHSZiYwR8CcBr5/WPwZIIVNcKsymfqk+klkl++FMbZmWW
mT19m3rLnhGhxPWJnR3ps12GJ0s1HhOrLUg9ogKZueVNHtbHAX2otNQa5GzxD831
FGwWpddR8pdR1gS/xrZDMVcQUIngfaZRyL1C9S6gW1kijs4mMWHS2pdkx0o/Ndev
DUi+FSRW14W6lzaDXvrmwzzGAfaJJ+iCPG9CntghC7nkl9J7LNxq4QNzqy0akjIF
fdilAE55syy6EtBreBsqPYbOIOBcc+Tlsc4+UyBW/BcK+Im6qjtgDV58DoWbGJ0b
/snk62jBp5ZC3v0BciyTYexL+aNHSegVN997GohPuO+ypn9rCSseqvBmNNLS8FQY
TK5US3yakwwUIgEdVN/XU2nujs+Eod9qB/PS4tYsi0E5y6LE663cEYeuKUoy3bV7
q7eOXtyckUV07HktlSEHsQP/GAJo+e37kpI9qdio9cxnmI8VfytviljCRzLroHSP
MK1SUQE3rg2ruJuMU79JJdgA7D47+O2H23dNUh2N4kbZQvs6SJg2b7BhrfJIDL0p
JAkXSak0EbgS3riWm/Jx1TitodJrTKGpmTOUrY0AzQpz/2h5HKY3Ks45S85QBki8
KWi4p4vWODUjA5YSTAwxwcoI9DXgE59sF95lci7hx7qDORxV0iU=
=1KTJ
-----END PGP SIGNATURE-----

--datp2buig2v2s4rd--
