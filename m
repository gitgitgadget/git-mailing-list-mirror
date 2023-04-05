Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7FDC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 14:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbjDEOwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjDEOwq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 10:52:46 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AD91FE6
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 07:52:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C9C1A3200949;
        Wed,  5 Apr 2023 10:52:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Apr 2023 10:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680706364; x=1680792764; bh=9c
        enJisXpyKPSWSQGq4ejrqvdZAeXc1xQ9o0x5ZNtQs=; b=zV4CMnDR6LYwsxXOnR
        DEEpMdlQLPNjDHe+d0QLeGQj1/EwrgAKhgFFhYR83jGRzPvrLehP0ZX46r6Kg6gD
        eWU020zsmxiUMaXZi/lb5WsCLzuYRD9kLtOK5i2TXvSnXDWyVqCmZn41l2TONnj/
        3A0wrRMXczEzW88eeVUwlk/4mGVIVdQMw2+4/9Q0BaGH/wq+QPuAHMaZG6ua8Uu6
        OXj2ziRQmqNxrIySBZelNaDm5he4G8SzX00fu4KDL3Pyf3kjmu/damdqwqy2K3AP
        WcZrHIldsCMQ8WCNLk/XNmQZoH+SRQ1LS/AjTBrwG4YArV4XL/+2rL1NFBHF9KEI
        qp1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680706364; x=1680792764; bh=9cenJisXpyKPS
        WSQGq4ejrqvdZAeXc1xQ9o0x5ZNtQs=; b=OxJXvtFVbrF9M2T6bEtGoIXqrrcER
        /n9Ju85xSKYuQX7U0XGF5ikQRsClqL1IxakA74lJvwYQ0sGJdH8/yashssjaLDcI
        +ylUVq9q+nARQtWcHfvlOYrLnWw2U3ZuetYfCVYT8ktg9LsGQUwjpOIx+F9U9W6/
        v+9nqG8w6IVxsYDHUf3ate0aVvXiNKYkT+Z9FKERedCGMAFGMiTZvo5t8K97WRzQ
        vO5nUYsZfbnfYMeEZ86QTM+6LQHB5h44I1EZIxSz0wlLYpmIe9fpmKLf9Ex6RTka
        inbILdlSv0KuS1URVP0LJUiw8U3bYjI5ayVdlGchB9Gur9US7QfbQlJoA==
X-ME-Sender: <xms:PIstZMB-mPK3ta6pXSzoOZnWhzvAiuFCpkHPqHkTnAQkU05pDL-4GA>
    <xme:PIstZOiTxO1TctGPwopI5WR3CvW28LKFpTgvn3G_AdMPZ1l3y09PdJSrS1EnVAffA
    pM8VG1aRbHtdTsNMw>
X-ME-Received: <xmr:PIstZPnB1VpOKRjDeBPEGXFQxuT5HAU3F_yVgkgirIHlh9PLNWRxdXAzlAE4hjes8yfm6z8Rlg9XwRLs9Ti-mArwY-ZSH_3Vy001cswlZqEx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PIstZCy5uL0vrZ_b4VDKyVFFsfMUvBMgspMaRrlSch2suqyz0LTljw>
    <xmx:PIstZBQk2NZiUZ8xP7Lc4DJdAKho23I6nhL7cSlv9VjE5MGXgGqXPw>
    <xmx:PIstZNbwx8UsvVqO1HUURb6xSbAt8ViYqmhve5JPPL0AMysusKwbyQ>
    <xmx:PIstZC7FUVHfI7JDKmLyBxmqiVsUY_-3yNohL1eNNtduRR3PXW42fA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 10:52:43 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 87723ad3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 5 Apr 2023 14:52:36 +0000 (UTC)
Date:   Wed, 5 Apr 2023 16:52:40 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <ZC2LOAwycdaUawxM@ncase>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4rjD0QfuCAdWU9Ra"
Content-Disposition: inline
In-Reply-To: <ZC2I7CfVzY6Tl7Pk@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4rjD0QfuCAdWU9Ra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 10:42:52AM -0400, Todd Zullinger wrote:
> Patrick Steinhardt wrote:
> > The majority of Perl scripts we carry in Git have a `#!/usr/bin/perl`
> > shebang. This is not a portable location for the Perl interpreter and
> > may thus break on some systems that have the interpreter installed in a
> > different location. One such example is NixOS, where the only executable
> > installed in `/usr/bin` is env(1).
>=20
> Is there a reason to not set PERL_PATH, which is the
> documented method to handle this?  From the Makefike:
>=20
> # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl=
).

Setting PERL_PATH helps with a subset of invocations where the Makefile
either executes Perl directly or where it writes the shebang itself. But
the majority of scripts I'm touching have `#!/usr/bin/perl` as shebang,
and that path is not adjusted by setting PERL_PATH.

I'd be happy to amend the patch series to only fix up shebangs which
would not be helped by setting PERL_PATH. But if we can make it work
without having to set PERL_PATH at all I don't quite see the point.

Patrick

--4rjD0QfuCAdWU9Ra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQtizcACgkQVbJhu7ck
PpQDmRAAjYI3kt/rm4mRUtSCCQGVh4bacGjF1uvkhQjeLeiRYrzHYH8Kf4kXNv/R
fneZQ5DY8b2zHNKjTW4Y7PvnXP6QgwMuDGIY+I2q1nkmToa5CVx7Jjpa8keqSK+w
mGcQ+ulbBNNQUi1SUmvHHlrC8ULMJ38igcfEZKGVFJ00goKfCRRpxDpmVt6sdKFf
jgRsplfzG0tia8vYpRFL++DpNX7KqoO6VXPYpkJpQMv8CEPC3NWbmLUkGaMqNTv5
CCGdKFbhRLCkQTMNwb0TrmpKf5ihljmZ2ZW9Lnb1AvAnqN7ZSzBf+9gCilRF0PPm
n5/cRohGo5gA9mX42cU94TeYMkWMo4fzUA2alDEyeOOVAC2Ob4dP5Bu13pooNte9
xnCDRrQN9AIVAH+JqFEbGuptKy7UsCoLF1gsRYb6foWezG/j2Onhs95uej67+L7t
wYmNtBWDlKdh+Fwywu8vFbBa647DZE7EHeHOrZwJ4gEE/tN4Ztqfv16ldoHo3Un5
qkbvwlvfvXhm1KkfL2rHDlfEQdp68v91TYrCA4fPMKql405MXVdj1q0cZjxyP2ek
i+VW0RFZr6eRrxm1kz0Zt1ibdC09GlTa+CRC97CYz1sV1d4gEY3UdU7+ob1gPIgD
zCKpKuN/LIG+KlNhNWdnIv50ZrWZztFX12Lbyk0A/+kQlsQQM4U=
=Dd43
-----END PGP SIGNATURE-----

--4rjD0QfuCAdWU9Ra--
