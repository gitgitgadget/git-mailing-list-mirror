Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375BDC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 15:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhLVP71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 10:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbhLVP66 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 10:58:58 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D586C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 07:58:54 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A22895B216;
        Wed, 22 Dec 2021 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1640188733;
        bh=izuHYQmjGeeAL1w+tuFB6qu2QEll7bjvnOpw20T+pAg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Kl4RZ0FWtB3dBJb/lRBajJYfVipcrg5Jtzbd8zD+dQ6Z9gL5PYdu4SZlWcj4/KJhf
         XqnPkG5sLD/MlUjJoQVRMRINXjeuwXru0VwselzZ4xisXgkU3caHu86sRfCSpgFg+D
         EKVPyhicu+inGtFhevTo8Zf1GMxmi/yS8P92VrTw4W8ZFqlOOwbAqCDGCc+EO1Qiel
         Fl0k6jvCo1e91q3U0oTeIZamxyL7HLFvl6pok7nZH549GSppqZ3heOYijMLCRsOGMU
         XHTqVN+9lmc2w5w0oIeYtYp1aKFOgWfG+fZcpO91talx43TueoJ4SecdJuqAMxjnfh
         9CmJmJF8P10B+mBQ4tTeJZcVFxpJple5FFSW6EzoPIkATQ7rTnvcP0pNKiSOll0diB
         Fqe0LFa2PlqjSAM85CkWBn7ixafEYOE1PQFG5M+QbXphH8EFDhD+ZFUiuARQfoSjGd
         6AOvRA0hMtWvRn3FB4zTk1dvMw6EhPgrYSrl/ajJhN7bpA8n9CF
Date:   Wed, 22 Dec 2021 15:58:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: t7510-signed-commit.sh hangs on old gpg, regression in
 1bfb57f642d (was: [PATCH v8 9/9] ssh signing: test that gpg fails for
 unknown keys)
Message-ID: <YcNLOsuAh85ecKw4@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Fabian Stelzer <fs@gigacodes.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
 <07afb94ed8336d4ca9de7078d7a6c02b1db8a908.1631304462.git.gitgitgadget@gmail.com>
 <211222.86ilvhpbl0.gmgdl@evledraar.gmail.com>
 <20211222101326.fwl3wphr3ev6c7wt@fs>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kYlysQi8OJ63EbgD"
Content-Disposition: inline
In-Reply-To: <20211222101326.fwl3wphr3ev6c7wt@fs>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kYlysQi8OJ63EbgD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-22 at 10:13:26, Fabian Stelzer wrote:
> Hm. I have an identical centos 7.9 installation (same versions/features) =
and
> the key is generated without issues. Does the VM maybe have not enough
> entropy for generating a gpg key?
> Otherwise we could of course pre-generate the key and commit it. I'm usua=
lly
> not a fan of this since over time it can become unclear how it was genera=
ted
> or if the committed version still matches what would be generated today.
> But of course I don't want to slow down CI with rsa key generation stuff =
:/
> If missing entropy is the problem, then maybe CI could benefit from
> something like haveged in general (other tests might want more entropy to=
o).

GnuPG is notorious for using /dev/random for generating keys, so yes,
this is likely to block in a variety of situations.  We don't see this
on newer systems because they've replaced the blocking /dev/random with
a non-blocking one except for when the CSPRNG hasn't been seeded at
least once.

The problem isn't lack of entropy, but the fact that there's no reason
to use /dev/random since /dev/urandom is suitable for all cryptographic
needs once initialized.  On modern versions of Linux, one just uses
getrandom(2), which deals with the uninitialized case and otherwise
doesn't block.  However, CentOS 7 is old.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--kYlysQi8OJ63EbgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYcNLOQAKCRB8DEliiIei
gYK+AP4vhD8AziOxs7MpvM5XjmmUKikkjmsmugfOZIUT3VLGXgEA9IezWgX1MCXm
medAEjKF4nqOtEmgXAhiTE9AVcedPQo=
=mNPo
-----END PGP SIGNATURE-----

--kYlysQi8OJ63EbgD--
