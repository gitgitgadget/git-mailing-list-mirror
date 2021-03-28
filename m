Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C93DC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 23:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0696761929
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 23:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhC1XHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 19:07:50 -0400
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:2146 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhC1XHe (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Mar 2021 19:07:34 -0400
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12SN4xaH188433
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 19:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=aqUeypM8qu2Ms8PFfRDcDDgYquSfKf0V8/PCIkA4Stk=;
 b=Do+LkYIW+rvjXbIAteBp1DATdfJ/+kbFugJymiH/gx2cl9piAjbLbeLytbjL6PCE+/39
 LOnfj0gjZeFvj6uQKF4xl+dgtmHYdAsuta8bfNuOkuVdgiP896V2TMSLBOtFCd2glxzT
 loTwaNOsU+Vw0iMS+iW0l19eGLEcYH6oCgGASPvfN9zXyDv/0WLFa44RvipsS2IBry94
 28k5E6+thHWly7YzA0ViidPqKAmPCI+aFiusgP109no+EbBilBkRRXUoLXl/Khhxtzty
 V/bmGnDQ4mW4OFsyT62Z26biA8UVAkFF//bTXZGGj4EsEpXYp0IYkOCjyWS0sqWTcfFA cQ== 
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by mx0b-00256a01.pphosted.com with ESMTP id 37jja4hwv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 19:07:33 -0400
Received: by mail-io1-f70.google.com with SMTP id s6so9635103iom.21
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 16:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqUeypM8qu2Ms8PFfRDcDDgYquSfKf0V8/PCIkA4Stk=;
        b=h4/uwkE80XnG4g4txBTOrCHXMLVMaYOFVd8kMm8GtCuX3OHNHz0IjEAThmKMUcQKFK
         CDJHreND+41Rw7NxfbA4ko11LzfddBqfqFfA9/uBBSYFv35qVe8ewQcYMlO2fEqhN3My
         D0cy3zpXE7peruSr3W+EYK6l6DyRuH+MFl1qUVLySu6/FMSuQ8ogqBF1AyLQ+lAh1aBI
         doa0bKuaM6euzBDHDQrNEV6tKFjaZwSzhE2KFkYGEs7KCOiOZNWUZoIa1EecmeRRnUFD
         JdOAQXTiA1K9Fzq7y9k5xPdxAcnnnlT3Ngcsri9EoDLro5A4VvJ6HY5GzWuB4lhoGjeG
         cBbg==
X-Gm-Message-State: AOAM531kyOWI/PvGmWh1dmF1ljaPJXjZNvdXXAGjt3fWF4icdIFujOhq
        ARs+dtuD1VhTGPwkkwvCtHHqp6b2Jyf34YZcaQcj7sNCfUcTjKa57yqMlYU4a0Tcnyc2n9sxXyR
        zjPi4o4NaMNg=
X-Received: by 2002:a05:6638:210d:: with SMTP id n13mr3076578jaj.100.1616972852976;
        Sun, 28 Mar 2021 16:07:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoezwQrulVNo53o6g5xNlatf41EdZA+l3OKC8cd3B25X/x+o8xKWQYo7frggReR4m41iQ8xA==
X-Received: by 2002:a05:6638:210d:: with SMTP id n13mr3076568jaj.100.1616972852793;
        Sun, 28 Mar 2021 16:07:32 -0700 (PDT)
Received: from meme-cluster (69-174-157-65.symrinaa.metronetinc.net. [69.174.157.65])
        by smtp.gmail.com with ESMTPSA id l14sm6696944ilj.14.2021.03.28.16.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:07:31 -0700 (PDT)
Date:   Sun, 28 Mar 2021 19:07:31 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     ama bamo <pythoncontrol@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: exporting git commands in parsable format for constructing
 language-specific API for git CLI
Message-ID: <YGEMMyAYVlzgv79G@meme-cluster>
References: <CAJxd1DPcCD96NSqzXvh3cgA93d1nCNFQbFWduTCqfx1zi_1o=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ksOyZTFZ5LsQ7Me5"
Content-Disposition: inline
In-Reply-To: <CAJxd1DPcCD96NSqzXvh3cgA93d1nCNFQbFWduTCqfx1zi_1o=w@mail.gmail.com>
X-Proofpoint-ORIG-GUID: Y3zSxuFw9lXXZWD4WEysCEdHn4B85ReX
X-Proofpoint-GUID: Y3zSxuFw9lXXZWD4WEysCEdHn4B85ReX
X-Orig-IP: 209.85.166.70
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 mlxlogscore=784
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280178
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ksOyZTFZ5LsQ7Me5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 27, 2021 at 01:42:09AM +0100, ama bamo wrote:
> While using git commands in my applications and reimplementing the
> same stuff i found out i can just parse git docs then generate
> structures and classes based on that; i have done similiar for
> wordpress and its `wp-cli`, for example see:
> https://github.com/bukowa/gowpcli/tree/master/generated
>=20
> But `wp-cli` allows exporting all of the commands in a json format,
> see: https://github.com/bukowa/gowpcli/blob/master/generate/dump.json

I'm not entirely sure if something like this exists in git, and I'm
alsot unsure of what exactly is the benefit of doing so vs an actual API
(e.g., git2go[1]). Could you help us by elaborating what this is meant to
achieve? Maybe that way we can figure out if something exists...

Cheers!
-Santiago

[1] https://github.com/libgit2/git2go

--ksOyZTFZ5LsQ7Me5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAmBhDC0ACgkQRo8SLOgW
IpWY0Q/+PMFZYeKKWmAn4p02g9WpmIJKmarpUQWzszNIdX+GVgAt0J2nNyMprrp/
h9qodIybr7QzWou6P0twvOvJO00VbtYtE0li9UoGGsfc8dqIlh06tw7W94jonBMi
QsP4/GjlKqY9uo8aUkQsCxLhdiBDxkD9W+g5uOUteXGUesPKmxlI2SHsbm4g6Tz+
ioIfMTA6oyho21SOOFGmB20Bh9R+1zhdZwlE9BHuqLM8zTWSSl6cdTndPohNBQUm
wm1vRE6LVvpfP3Nd29xUpGTjiwvfgJvOMIhyKdfrZFHeT70GfC7k5vfkj7jOxM+z
fBbf/pthaIT1mhHHro3UdqCFDbUpg2B/X80rVXscsSeL7aUh39yc6aX2O05h0uIZ
H1cHQBC/pWM5FKvBW7pGitbAaS3KaP6RCm6n+s7yjG8jpueVEL/c4YbMOoMScL8z
GOIhmCw8sydBzv/gGNIOIembBRK9RxYcGgypCK9xAUZ+5phlY75PY7zZch+is37D
lMPf8paoJ+8ReKOdAeH6IETn899PJYkKnF0fUGTgpCkVMtriaZx6iqSZiUMMP42Z
kQFwLYVoc56S+/jjaCN+bsYtEEFZ93581aroTpGpz7ZgnAqXgGgm1BUEAPRQ23Tf
iS56FUFlH9bZCxYm48oYkpHDePbZvyzgP9VsrN75/zpY2EAaUng=
=qYpr
-----END PGP SIGNATURE-----

--ksOyZTFZ5LsQ7Me5--
