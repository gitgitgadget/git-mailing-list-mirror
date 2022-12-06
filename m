Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C03BC352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 17:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiLFRHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiLFRGv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 12:06:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2214F1134
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 09:06:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so8469764wms.4
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wikimedia.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4tp0VLbrLfRAy5EqD0mnM8y1Xlbl8DDyC2Q0V1QsYI=;
        b=r6qDQnpBVSJefBhkIs7xJIwnwUZcfrvYGoPliNBB+9zPhURPz/8NYh5eu1OX3p7KG7
         8Bf87Ry4uDlcXSjGbmV3oBZnSpxOqAaGVUF/6f8DASBft6W2RJ/qXXBVLiPFucICUSZF
         yZ6WErfq+POKXV7DC250HGbny68ylieqi+AEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4tp0VLbrLfRAy5EqD0mnM8y1Xlbl8DDyC2Q0V1QsYI=;
        b=cYsuwswpitm6SEqCBpAowC9pcg36fJqz2od6hd3lmLSJRoX1IC41o+FTUW0Mgtt2jn
         p0pZLJ73c+voCfY8X7KHT1zmph8H1oFSSmVUJnweMTrWijanwKo0dJ7LAR/U/cK3BUrb
         3WC84HkwaEkNbJDoZFpziWZTcAyUw4sd5djbfcTiuG2qG4wXEcgcjHXBTa35+Ndk5xMs
         3QVf6+YGgrY5aZ3Q11r8utwabjd5TT0KPERSw6PVra9ozvCc9n/ZBG6unIGduzkyV+49
         VSPiqqrLiO7LGXuLEES78tUrc57vNT9W3EYSt21F5heMqvV/e5L5ew/zehLR3/PAbqyl
         JU9w==
X-Gm-Message-State: ANoB5pmY+uglVGYTAtDZMAqrvzvBHTv1Ho2W4fIBDmHEfXmZx+DG0JUJ
        NWGkoHMMFLilB/0WpkbfljaryTJR2QLe9v9p
X-Google-Smtp-Source: AA0mqf7sAQ9SUDnJ4A4RyLhiavyDF7+8pNTtN/BlokPYc54zuylykQcjSmHH8EUANXfZEFEM8ObW0A==
X-Received: by 2002:a05:600c:19cc:b0:3cf:7bdd:e014 with SMTP id u12-20020a05600c19cc00b003cf7bdde014mr58478163wmq.1.1670346408213;
        Tue, 06 Dec 2022 09:06:48 -0800 (PST)
Received: from localhost ([2a01:e0a:8e6:e040:a8e5:5d56:8e6f:5401])
        by smtp.gmail.com with ESMTPSA id co16-20020a0560000a1000b00241b6d27ef1sm17835295wrb.104.2022.12.06.09.06.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:06:47 -0800 (PST)
Date:   Tue, 6 Dec 2022 18:06:46 +0100
From:   David Caro <dcaro@wikimedia.org>
To:     git@vger.kernel.org
Subject: Skipping adding Signed-off-by even if it's not the last on git commit
Message-ID: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="34ptvntwo26zikhl"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--34ptvntwo26zikhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi!

I have noticed that when requesting git commit to add the Signed-off-by hea=
der, it will add it even if it already exists
as long as it's not the last in the footer.

It seems that the functionality to do so has been there for a while (see [1=
]) and it's being used effectively on
format-patch, but it was never enabled for the rest of commands.

I propose enabling it for commit, merge and am.

I can easily send a patch for it if the change is welcome.


Thanks!

[1] https://github.com/git/git/commit/bab4d1097c8be7d688a53b992232063dbf300=
fd4

--=20
David Caro
SRE - Cloud Services
Wikimedia Foundation <https://wikimediafoundation.org/>
PGP Signature: 7180 83A2 AC8B 314F B4CE  1171 4071 C7E1 D262 69C3

"Imagine a world in which every single human being can freely share in the
sum of all knowledge. That's our commitment."

--34ptvntwo26zikhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEcYCDoqyLMU+0zhFxQHHH4dJiacMFAmOPdqYACgkQQHHH4dJi
acN65Qf7Be5uRy7De29gBYE8zqawkChKptuhilAEisdH5VN98oXlUz+43NQkMWom
IpulJS1j2imsqPSKkDckbwh0/v7CshStO2Q7h0BpShfQsFUsohcSJAvDcz3EEOzC
BLZOeku+DFZdp0PZaGGmsFUbbEWHvMQHvk+wcGhnCVqMPnC0GKJX6wEt04BTQdJd
V0xcIn2acd9hBW8hZRTlFvUisozWPqHX7XlU4TGl0lRqK7W5mz9eRrutF0n3AVVZ
uHyBiYDyDTTrDu5kBJar/dDtZKIGaVmCm6eGBzzuJcznUsv5+Vn311ojbiDt4Cd2
6wLIiSe3XwOo+pzLX1wDx1BBAXGzbg==
=sUfn
-----END PGP SIGNATURE-----

--34ptvntwo26zikhl--
