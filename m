Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8FCC5AC75
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 02:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiAZCOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 21:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiAZCOW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 21:14:22 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFAC06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 18:14:22 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 3A4655D4C6;
        Wed, 26 Jan 2022 02:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1643163261;
        bh=oJYNwvTOuv30ac7/397NNuxVxAkATybMkH5SddjHeuY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MueNTNElQZ4B3/Kqxt/u1uhVDKOria1QzguxQv+U2xECBf1uVT5TF/OmRga+uPhxL
         +C/hE9XOm+BiAN28SMj4FT596Xi2YObEMg0B0dDm8YMS1dwqVhY7SPEJwEmw3MvoXo
         HEJTFljjFY+TJ7Ln77mYHlF5OfRsmp38V5rlV/joUaG3vIaBdiO4cdhfP/6NYR5SFA
         RhsVGWtU82kxwL4Q9r2S5FCOe/D8GHy7sKWSPy1I9Sz/wb4thU+vODOe+3+4cUERoC
         0ufyCvLxOHba5rF5FqJlgTIK3fArW4TuGFCZCYG7UpPqpuWJVbs7JdCE+Ez7r/jBJw
         0MLmiLxI1NpoaTq9T17bTp8wumEWXbMj1NWVnseAeyl3JZeMaTwbXYN+l/zo49kl4/
         JpBt0+smtpddvzccjOJzQ7XxIB3UvAUGx6CEsdZcJSCPFnzSm9DiIYb76mwASeesAX
         BCf5JkU2tqvxnVXQMmTrII9ar2RPfgqFVhLf7jWLKtC5rykfsu3
Date:   Wed, 26 Jan 2022 02:14:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Herrmann <michael@herrmann.io>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
Message-ID: <YfCue6m4gqGEWqDj@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Herrmann <michael@herrmann.io>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
 <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
 <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
 <xmqqk0ep57ou.fsf@gitster.g>
 <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
 <xmqqfspc3k8k.fsf@gitster.g>
 <CABrKpmDjrTPhL_55YaXEAVTEmu8iZEsKUJYab7OgK0=w9d_7MA@mail.gmail.com>
 <220125.865yq8ghae.gmgdl@evledraar.gmail.com>
 <87pmog2bbf.fsf@igel.home>
 <CABrKpmAcNsexcmHK5kZvZr_NBm7TWWU=wVQExHwWSPpprptdQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Se06zVd9DUo4IFdM"
Content-Disposition: inline
In-Reply-To: <CABrKpmAcNsexcmHK5kZvZr_NBm7TWWU=wVQExHwWSPpprptdQw@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Se06zVd9DUo4IFdM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-25 at 14:30:11, Michael Herrmann wrote:
> Andreas Schwab wrote:
>=20
> > See the core.trustctime config.
>=20
> This sounds very promising. It also fixes the problem in my
> preliminary tests. Are there known drawbacks to changing this setting
> to false? I haven't yet noticed a performance impact.

The index holds a bunch of information on files and checks that
information to see whether the file has changed.  If the stat
information changes, then the file is marked dirty and may be re-read.
The option above and core.checkStat control which information is
included.

When you do "git reset --hard" and there's no change to the file in the
index, Git happens not to rewrite it in the working tree.  This is an
implementation detail and isn't guaranteed, but that's why things happen
to be working here.

The downside to restricting what's in the index is that Git can miss
changes.  For example, with core.trustctime turned off, a program that
modifies a file without changing its size but resets it to have the same
mtime would probably result in Git missing those changes.  It shouldn't
result in a performance difference, but it could theoretically result in
a correctness difference.  You may decide the tradeoff is worth it,
however.

> Randall wrote:
>=20
> > I think there are more use cases here than are apparent
>=20
> The use case is Chromium's build process. It creates hard links from a
> src/... to a gen/... directory. Some actions do `git reset --hard` in
> src/. This updates the modification time because of the hard links -
> even when there are no changes. That in turn leads to unnecessary
> rebuilds. I have little control over the creation of the hard links.

Thanks, this is helpful context and it explains why you'd want this
behavior.  If you're involved with the project, it may be helpful to
point out to other project members that this occurs and suggest that the
scripts avoid running "git reset --hard".  For example, it may be easy
to avoid if "git status --porcelain" produces empty output.  I've heard
stories about Chromium's build times and I'm sure such an optimization
would be welcome.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Se06zVd9DUo4IFdM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYfCuegAKCRB8DEliiIei
gXzUAP95Lw5Sdr7pO1wKofn0wwR+EqjtLzRoe7n4ovegNAykAwEAjCPYS6ExpgZj
Bsd3iOaFen7b0urVVWBSA6qDgC1hiA0=
=iG8J
-----END PGP SIGNATURE-----

--Se06zVd9DUo4IFdM--
