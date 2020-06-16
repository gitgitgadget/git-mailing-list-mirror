Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C757C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD44D206F1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="smrvkHEc";
	dkim=pass (2048-bit key) header.d=nyu-edu.20150623.gappssmtp.com header.i=@nyu-edu.20150623.gappssmtp.com header.b="F66IidWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgFPQbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:31:33 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:41578 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729167AbgFPQbc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Jun 2020 12:31:32 -0400
X-Greylist: delayed 1077 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 12:31:32 EDT
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GG4DF4159485
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=RWL/Fd2bMDMP8wxOFQ5ugCPHAb9MOj+DWQPwmD3Q/Nw=;
 b=smrvkHEcGzLROzIWQ9IcEuO2QdD+jIqXDeaq7xrupGdF2Qvo73yPaAarBUAJvjF7QdSf
 ecIspnS0G4Kc5c+WkIE+Z6NUumc6fnVmGITyx0tx37VuVJeav60q8u3RzdksCbxxDMaN
 qXys/Okmqn4wEopq8EoSCUfBg6GxrCyaTc5iZeBvtulQuAfQs7/60xM0G5uIbR57N1dv
 BRxernZDGohcuw2TkY0lgZShNgtDwqnEj69BiZ1MQAXUaMK8efvC9X3UC1CmjCV2IhCQ
 K9vBXSjfdtR8JGDRxx1kCv/ErHYNTkxQud5OcXb4hOSYuAnyhT3pMjWhKQXQXC+Y0UH9 xg== 
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mx0b-00256a01.pphosted.com with ESMTP id 31nbmfah1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:13:35 -0400
Received: by mail-qt1-f198.google.com with SMTP id l1so17123929qtv.13
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RWL/Fd2bMDMP8wxOFQ5ugCPHAb9MOj+DWQPwmD3Q/Nw=;
        b=F66IidWOHTdQfnN8iVd6PVrcnZdqS0ZeQPPG0kjgJZYRWeSMMdcnWlrCLfcw6BlX7a
         4HETubgeD25r6KKmmTfyoOFwP1Bz3rgrl2jNcUEDKF8Kwz/h7X+VpwnC9zijI++eOV0d
         Y+HqHwRxiHvSfD+1V6H3k0X/PARU8DSG+FbDngD/mCptBqD7grp7d7yBmulPBotzRp91
         bOuG7rBPMl3aM37zLDz5/uabqnIrr4gB6rcXlWaK9ah+WEfzfVeBKC1o/oV2o8OVOVsX
         6NWmJ6BMuiNhmWhlFp1evkXJqhDdkr/2LQFLaXl45MxOd6a7xsL+arpkE9YT+oDcEMIs
         cd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RWL/Fd2bMDMP8wxOFQ5ugCPHAb9MOj+DWQPwmD3Q/Nw=;
        b=otUVcGFmqfuZWetBcq6rsicf/6oUP4X2x6ODnHIsIXTIWlr4czUjdm+QiTtQGRLbfY
         Qa4xhsmUjyZvFSJt7JnVcZ17x97ysBMsBN7vDRewHpKKMYOPQc4ZPIs0n+ln1dAv1VFk
         c7yoCP9pRjsUPyqnYH/ovk0Xmigrj4JcKKXiZM+yeW463E3NqQxfODDSFVEmEBc2Sw6V
         TeXBDCSxhbHuhqn4UbMxdtZEDiNIUrxOz4U42AocCHtPkhjOLjSbV/So9Z78yEBwPSnb
         L2T6yosK0KjVKqTpCo4xKIRvWd6jftmgI9dA+ILTMEKYDUZR2T0fRpyD1gy+s6Wy+CTT
         Q3Ng==
X-Gm-Message-State: AOAM533NLNrX4bYi/71D37kSG+uO+DXTf5McBEUFZE033S1fmfTIM0cL
        NeA+2QlLM6i40bUcNk5oXPL/QG9Gf45ZPG8PHHIdEBe4jKK/GkEcuD2HQqtK3Rikkm6WVzSFP/b
        rDdESMJ+/2ww=
X-Received: by 2002:ad4:50c8:: with SMTP id e8mr3000258qvq.98.1592324013685;
        Tue, 16 Jun 2020 09:13:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbGl7e4DI+pn98+HwkU3PuVl6mWUBJrAd5jG1bcKyI02YNAiPUJc86Sctiut3ZBgeyvFqGIw==
X-Received: by 2002:ad4:50c8:: with SMTP id e8mr3000241qvq.98.1592324013443;
        Tue, 16 Jun 2020 09:13:33 -0700 (PDT)
Received: from LykOS.localdomain (ool-2f10876a.dyn.optonline.net. [47.16.135.106])
        by smtp.gmail.com with ESMTPSA id a82sm15090013qkb.29.2020.06.16.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:13:32 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:13:31 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616161331.7gosaynkqg5ofgwn@LykOS.localdomain>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7wsd24lkdztug7r7"
Content-Disposition: inline
In-Reply-To: <20200616161001.fa5wa2br5ois2csr@chatter.i7.local>
X-Orig-IP: 209.85.160.198
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 cotscore=-2147483648 adultscore=0
 suspectscore=7 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160114
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7wsd24lkdztug7r7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 12:10:01PM -0400, Konstantin Ryabitsev wrote:
> On Tue, Jun 16, 2020 at 10:31:07AM -0400, Jeff King wrote:
> >=20
> > My biggest concern here was trying to understand what could break.
> > Having read the patches from Johannes and thought about it a lot, I have
> > a pretty good handle on where Git itself cares about the name. And I
> > feel pretty confident that we can make the change in a way that won't
> > cause problems there (and in fact, I think some of the code will be
> > made more robust by relying on HEAD more appropriately).
> >=20
> > There's a more open question of what _else_ will break in the ecosystem.
>=20
> What if we work on making this configurable for now, but stick with the=
=20
> legacy name until we introduce breaking sha1 changes? Almost everything=
=20
> will need to retool for those anyway (and all documentation rewritten),=
=20
> so it is reasonable to bundle these changes to happen at the same time.

I wonder if allowing the buildsystem to set this default value would be
a wortwhile stepping stone. This way we can test things in different
ecosystems.

Thoughts?
-Santiago

--7wsd24lkdztug7r7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl7o76sACgkQRo8SLOgW
IpWpLg/9GfJhzzQeEttf2rny22YGxpO4xqEkhKLBH370IWIuUOmYxY5axGY/zpq9
84LvvqHziga2/IHjXDdTm4Hy1FPSdJwhw5wEUlH9z1Y6bLwOW7OSHhyT2ezRcz0m
7HaEQ13Axmql8DArGQ4+2owiCR94H9woIr1GrHzTLcGmft/UxffoDqrnXoXszmtF
nhKrkCs2gHt7rLOrPLLG47P/gQZPkbbLoXIobKBu/4wsCUGzDG4MyPfQO08nCKM2
0k7M5S77H/ctegE3TiOIQGJGl99wrpOISdOEH3p2HUAyDaxLq8+rUz+6EpEuky0d
ACHfjkX6WeDvz+e6ISZjXM06rE8sh1sBWoQK2wbHgaKlOpVl14udGWWSm/xk4nXN
iYex5MWgmCjjUam1NmwiMSnHth+lnbVN9+wTq1QjYqwGgNQLa0LtEsthdeJ1bCPn
HsI5B5Yg+uAf7k0Zgyls+8xn1YGjp5la03Fb8sTSNmSh5NZ4izFwJ3qw7D9sC5Xu
+OG2x97rVR4rmyj3h+ukz0jSIzW1jXiSuP87Ub34SAEaem0rRms/1vXnqka5XItZ
kIDQOuJLKm2jT5Km71BUYPsTLeB97WWmKJBaNKN8vURokQCIWkeeIt6ARgGjIiSe
kHCOmtxR3E+oMyvU5hbvU6zi9Lf0nJ/pnh696tG+x+2dbK029I4=
=UsLO
-----END PGP SIGNATURE-----

--7wsd24lkdztug7r7--
