Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024E2C3F2CD
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 05:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8D820CC7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 05:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTCj98fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgCCFTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:19:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45602 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCCFTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 00:19:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id z12so2182292qkg.12
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 21:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=slRrJ1H7XJg/eW9WAQpa+N2wReIIqWstUw6EaaKozmk=;
        b=jTCj98fYiiaXob0aF0pL4kfJVir01Oy272946+aKT81BnVSQ5xAXwXMAtBClpoLwN7
         2bjAkuBSeCnnST35H9+X6i6Q/gsXFsn8fF3NBHvQ9mCiaqU/uZb0BEb5jmliIt1+d75Q
         i/UgHcUsM0rkkFWXQzcbg5IWWuspK6/oTKSFb/pHfGZx7TVgqd8U1CG/srmgftmUpvBJ
         sA3qNadxn396OI+KC4vJqdjeI+PWVEF/Ex3Y0UFbOg3nMGcTsXskmL1UL2lZVEiFUXSC
         haZGK3HVFXY+BF1Fu8C/Q/3H6oPzVi60con/PWhyZ6qfMTxTCRpuUBmEccRozvP3y/kp
         LrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=slRrJ1H7XJg/eW9WAQpa+N2wReIIqWstUw6EaaKozmk=;
        b=V6++eQNWZHOHBFS5+JWe50NMo+coG/pHWk87t3NXNyH8/MqUeXVaLXnxUuVpgZHNHL
         WfByggVWnPRNQGBe4hAxBz1QXo5AVWH/CAxrkR8BC4LdeKShiY99P0uh9Tu3aqA5FPXS
         7HK5P25gYIvTjcWRErnXQZd1VoD34LcCdglDN5i/syLiZgkxB2QAg/RnSBf7KLCh+M0T
         ipHq/sbGBYabMXH1JDhgHQy4EuwG8h5Yy+H9RxAZw34M+PBKI22Wr0S6c6wUUq73dWij
         M4C6zidCAUL5HKDMqgfNddZWcyKgCEqpHTYEJSTc7BBfVn6dzCE9ttEuAWz5xG5jnUYX
         BFWA==
X-Gm-Message-State: ANhLgQ2XAML9SnMMpnzsuGQUPDFGor1wYhdWwVdNUw+o7yaMwwJ9+T4M
        Vt7HNgkCzxz7Qfms6z/x1IY=
X-Google-Smtp-Source: ADFU+vsji2DrIRd0ANGj2zl6hcHM7/NUFkDxbwh525vXbWTTAjjol82Di1yhiXmYF+fQu7C0o7BwPw==
X-Received: by 2002:a37:a750:: with SMTP id q77mr2323761qke.119.1583212740793;
        Mon, 02 Mar 2020 21:19:00 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id w21sm12422838qth.17.2020.03.02.21.18.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Mar 2020 21:19:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/4] doc: --recurse-submodules
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200228104449.o42twhy34fynalk4@feanor>
Date:   Tue, 3 Mar 2020 00:18:57 -0500
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF79EA85-4A15-4B4B-B59E-657E0488D4C6@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com> <20200228104449.o42twhy34fynalk4@feanor>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 28 f=C3=A9vr. 2020 =C3=A0 05:44, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Note that git-switch.txt states that
> 	Using `--recurse-submodules` will update the content of all
> 	initialized submodules according to the commit recorded in the
> 	superproject.
> but actually only 'active' submodules will be updated.

Technically that=E2=80=99s true, but I=E2=80=99d say that in a "simple" =
workflow (you clone a superproject then do
`git submodule update --init`, then maybe set `submodule.recurse` to =
true), then being active and=20
being initialized are equivalent. So I don=E2=80=99t think it=E2=80=99s =
that big of an issue.=20

In any case, if such a change is made, the doc for
all commands that have the flag should be revised, as both "initialized" =
(grep, checkout, switch, read-tree)
and "populated" (fetch, pull) seems to be used currently.

>=20
> Should I also update the doc? It is already stated in =
`gitsubmodules(7)`
> that only 'active' submodules are considered for recursion.
>=20
> --=20
> Damien Robert
> http://www.normalesup.org/~robert/pro

