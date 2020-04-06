Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332FFC2BA18
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 07:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AE9206F8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 07:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JLePjBQR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sutUwqMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgDFHLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:11:05 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59375 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgDFHLF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Apr 2020 03:11:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CC1F2B5E;
        Mon,  6 Apr 2020 03:11:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 06 Apr 2020 03:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=7MRQJGR3Hm8T2HVImrBtMzx7Xc4
        WMcc4PVxgRWmYhQM=; b=JLePjBQRufyChAN+oiPLYerHFypv5SZ+wACv8J3g28V
        3MnjhhUIUcnO30X1Hfrk0/RevtZkSzPuzsDEK0FPSEt9Yste8YpxDBIB4P+W1Woy
        /nxhqYZdjbFozIUWzJTNOHXWaVKhdUwigHWMatDVONw0Gu/jYn6UJWq5vrk3dD2j
        jqV2WUUfbxbJ9XjexrqAWrWbXlJSUr0ts/r/LVI+UpXMQ44R7k124a4tZzKM+9VV
        wea3zRJQsu2cei/gWso/SPAPDfCx9dazJcppe331KNkV1E8+/j96JS5/EnDhT+Pn
        7/eBkgq9Ec+DxmVvma7XpvRKh49gAz439JDf19QBISg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7MRQJG
        R3Hm8T2HVImrBtMzx7Xc4WMcc4PVxgRWmYhQM=; b=sutUwqMPTvoOIoIWcQezw1
        LedvZE1DlMY+ZId7UPxuqAwj3B8JqiXWMdcNZ/co58RhIvdm4in6MtXoTp94UXFk
        CAc18Yu7Ud1n5pk5jUT9eiwuMOpNlSq9j6IMVtCpMOYtCMsHILCn5MHKC8ye7BdE
        +QcDD7Qd8serPApvyQGvyquGg30UExDTy34SLoG02jrE3uN6MSKn3kKOrISlIIeQ
        l/5RPErXRlfYqEKyFOQpBIZq0se77z/MYld82Ulo2Ag92AcMGljThG5ildYs30hj
        2jU5wDmRhprOrRs/lG3GFZkj6MJ0dFAYUOtCxJzHRCHukSpAKYwkdOM77EPkrobA
        ==
X-ME-Sender: <xms:B9aKXmXZAwIdTwtbqLrXB18vdX5MTI4VRXpdXjLiWyARRZ8gEiWQ4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehhe
    drudefledrvdduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:B9aKXupgJVKAneyIcaY_SLRwnTW-PHsroR9gOXxDO6IDFupz3Xy-lA>
    <xmx:B9aKXjyGUQAZTSdM-itTnupiwTt6fnC2ex1ylK7BqwSfvD_MN-LcyA>
    <xmx:B9aKXljmN-xWFDvne186qgrJR5XjZVrawBfNjswplfLHtFsaCEUEaw>
    <xmx:B9aKXkO4eYKdsvRCHihjGHdOC9zTZ-OpGtdesi8JoDG603_CICZ_xw>
Received: from vm-mail.pks.im (x4e378bd4.dyn.telefonica.de [78.55.139.212])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71BB23280060;
        Mon,  6 Apr 2020 03:11:02 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id be3b4e66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 6 Apr 2020 07:10:58 +0000 (UTC)
Date:   Mon, 6 Apr 2020 09:10:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 9/9] update-ref: implement interactive transaction
 handling
Message-ID: <20200406071057.GB5302@tanuki.pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
 <5670bea2b15bafbd93d7d507b35e54980ad06fb9.1585811014.git.ps@pks.im>
 <fd4b874a-478f-2139-e910-c000b8a1f396@gmail.com>
 <xmqqa73s1njt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <xmqqa73s1njt.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 10:33:58AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>=20
> > I found the talk of "non-transactional" sessions a bit confusing
> > because the normal --stdin does update all the refs it is given as a
> > single transaction, so that if it cannot update one ref none of them
> > are updated. If I've understood correctly these changes are about
> > coordinating transactions across several repositories. I'm not sure
> > how best to convey that in the man page - perhaps we could call them
> > single repository transactions and multi repository transaction or
> > something.
>=20
> FWIW, I described the topic in my "What's cooking" report as adding
> an ingredient to implement two-phase commit-style atomic updates
> across multiple repositories.=20

Fair enough. It definitely may serve as a building block for cross-repo
transactions, which also is the original intent of this patch series.
I'm not sure whether it makes sense to document it as such, as I can
imagine usecases acting on a single repository that still want to be in
the business of doing two-phase commits.

Patrick

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6K1gAACgkQVbJhu7ck
PpS64Q/+IFR5o1J6BUF/KFO4YckO/z25NNMQR+fySWAUOxFIQlTgHaJ8thDfV7L0
jkEtRydTzaAf085yvFp2o3I/0AzSPzm1SKxcnLTn1xPi7NrB5c8vgxZRNtSLppSG
/PHLes3Lfye5WrLpa0Rj75OpklTKukcGJNze8i1HHU4oxchLJRIyHJbAfI961/83
i5fJcEqKcESpIyBe4w/0Vi0e/vDZQBxqw4HEwox3+ura1azh1V8aIAiTVZsINxSP
rY+fPI0N8uI9TQ6tGTDRczyEfzS7i+YdRsr9cvot/JX1N1gF56vDxOO5dJqTKMWF
V1+S6+B7hOMjgeGipLwylvT0TAl1acLc6KPkQaM4ovtkNYfcmn1FjRgOqG6wQ/rr
7L/R9BNCrWms0K3CWbKo8A5KEK6PNpUTV322L9ShBziB5rxoHmq315qZvwnfByqP
WV/gq/ivwY0PoPtw3A6Qo1fgEqxXtu9I+tq4HX6s+iReeFkW5+GSjI2zp9xLQTwc
Ffkr9LP2g+oIaW8ilSXkQa4bc7gxDyUal+pycUijhMmt1I02H35Ww+744GGOLZeC
PWKluhx2lKCTVy35A5lJ2UFB0pYrOrHzkxs2RdqTkD1Pb/B85wwVVSKIdvNd/rK+
42+HJUPfexekA2UrsMfl3fSho4JIcKAXB/hE1j4XRjkVkCU8o1E=
=NPr0
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
