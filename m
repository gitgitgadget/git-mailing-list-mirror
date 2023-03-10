Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F4DC6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 06:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCJG0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 01:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCJG0m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 01:26:42 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869C3104F47
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 22:26:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F327532008FD;
        Fri, 10 Mar 2023 01:24:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 Mar 2023 01:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678429486; x=1678515886; bh=7G
        D2sTXnnXMxo23xvhejk1pvDBWLojPtbslDeWEXS0s=; b=FppsOHVNY2i9tOOUyF
        OkGU0qNE/Ua1Uw2yT3wkASxRz7HMD2yzRqXPelLR49Jcnzq4RCR2o9dpy3Gld895
        wGCRze69q1ad06XGHmDj2eD2S4oPat7keZ59syLg1ovG+HHu35OQ08inOTa3+oai
        76G0T0VfYwlufmaOdjJU4PTiRH8QqKpP9v3VHj4uhyadcIp9+idANduT9FkhuO2c
        ANd1q9r4L4DTu1V3KPGsYIfsl/h+ymZlAPXHXyFb0iXUaBWnUVEAcVS7fg8XYRkp
        QSCN/S2yXiNKWXyYEglVdhRl7PxqcQdys2v1JV9+Gc1ELFJj2fKjv+D7BDuQpNGY
        /anA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678429486; x=1678515886; bh=7GD2sTXnnXMxo
        23xvhejk1pvDBWLojPtbslDeWEXS0s=; b=Y4wxlHwer4qmn/WfNB3r3oNEzonER
        2vhrCVbUakNskFAWIWHYzBwuoEY46yajxN9b7e54xFZy1w5yjKF1Inp/SnxgHhZG
        gYR/O0XfEjhgWgvxl6m4TKrTmDh6FRiKn+MNff80y1VAEhwjsLT8CTl44rGz/wtx
        Ey8Ds0NsWT3drKqebBwOQJDKMilscgSrzyEpzB/Y6GYufLb7C8/yWn4Ud9x3TJHi
        b9K2U48yj5aiz4a83E3BktYuJcwtoDTPhH/klfpKGbuQ/9dng94++bqp2Xa4tXe5
        tqqorUafxE+mP4vHBdAGz6f/4iIXtnypZ4gqyaRkpNdyl5/zNQHr1ZbVA==
X-ME-Sender: <xms:Ls0KZJpYkrNyyDCfd73yIn300M2HmTzmfF9MUJVZ2R_wgzaFwaLkTg>
    <xme:Ls0KZLox2HJ5VR_i3pGrdhQt2k2xgHpmpBZEoNkdaB6YzXPbDulK8JNOUB6WN2g4p
    _ohcZMQ1S4YKe1vEw>
X-ME-Received: <xmr:Ls0KZGOgkj3u7q3eDbnybSLmtk_e-ZjV2IiYgzv8mogm1X4Ci5bGhNF59MIRhnOKj6o5URz1g_KfW98uHY9Z2KgvLDYVwho3HKjkp32-aK69>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddujedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Ls0KZE6oru1LWWdWRCe8mKABM-xLv29_ZWzfl3Sr4_zQ99onizcoGg>
    <xmx:Ls0KZI6BvyZLGTUb76SGnuvz_Pf9NUMtTtQAhkaLGtEMadexnNOggw>
    <xmx:Ls0KZMhZvqHwfucC6cuBSskUpfF35Tw7763T7nDVNlpqlZuue-zy1g>
    <xmx:Ls0KZNhGINWyjGf4kuzXp7jSe43zS24Ck6SUYnZ9C1mEPwHJp28jvQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Mar 2023 01:24:45 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e1b4722b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 10 Mar 2023 06:24:28 +0000 (UTC)
Date:   Fri, 10 Mar 2023 07:24:36 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: fix stale packfile locks when dying
Message-ID: <ZArNJHMmPd8QCLwQ@ncase>
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
 <ZAoCUPsHbstSJ0+B@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wZHcan8mHBMg06K4"
Content-Disposition: inline
In-Reply-To: <ZAoCUPsHbstSJ0+B@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wZHcan8mHBMg06K4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 10:59:12AM -0500, Jeff King wrote:
> On Thu, Mar 09, 2023 at 02:09:23PM +0100, Patrick Steinhardt wrote:
>=20
> > Now in production systems we have observed that those `.keep` files are
> > sometimes not getting deleted as expected, where the result is that
> > repositories tend to grow packfiles that are never deleted over time.
> > This seems to be caused by a race when git-receive-pack(1) is killed
> > after we have migrated the kept packfile from the quarantine directory
> > into the main object database. While this race window is typically small
> > it can be extended for example by installing a `proc-receive` hook.
>=20
> That makes sense, and I think this is a good direction.
>=20
> > Fix this race by installing an atexit(3P) handler that unlinks the keep
> > file.
>=20
> This will work if we call die(), but I think you'd be better off using
> the tempfile subsystem:
>=20
>   - this patch doesn't handle signal death, and I don't see any reason
>     you wouldn't want to handle it there (in fact, from your
>     description, it sounds like signal death is the culprit you suspect)
>=20
>   - this will double-unlink in most cases; once when we intend to after
>     calling execute_commands(), and then it will try again (and
>     presumably fail) at exit. Probably not a huge deal, but kind of
>     ugly. You could set it to NULL after unlinking, but...
>=20
>   - as the variable is not marked as volatile, a signal that causes an
>     exit could cause the handler to see an inconsistent state if you
>     modify it after setting up the handler. The tempfile code gets this
>     right and is pretty battle-tested.

Ah, I didn't know that you can easily register an already-existing file
as tempfile. That is indeed much nicer, thanks!

> I think one could also make an argument that index_pack_lockfile()
> should return a tempfile struct itself, but I didn't look too closely at
> the other caller on the fetch side (but it should be conceptually the
> same).

I had a look at it, but git-fetch-pack(1) works quite differently in
that regard as it also supports the case where the packfile lock should
stay locked after it exits via the `--keep` switch. So the logic is more
intricate here.

Furthermore, git-fetch-pack(1) only does the locking, but never unlocks
the packfiles. That is instead handled by git-fetch(1). So converting
the interface to use tempfiles directly wouldn't work as we are crossing
process boundaries here.

And last but not least, git-fetch(1) already knows to unlock packs both
via an atexit handler and via a signal handler. So there is nothing to
be done here.

Patrick

--wZHcan8mHBMg06K4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQKzSMACgkQVbJhu7ck
PpRXHQ//bJPHIKL9+t4ofdW1XXc9ifGM+PSp7mjhhgGdR6A2nEHLj6jRs/xRuqeI
2GAwLNWUJCvYRuihHy87u3UGyvpxE4iuwoa2LEoYjNJr7zVHufqFCgJp7//LlM60
csfnZMy68k5Th9ZXO3uwFrp9yxbpPYY0fls7H/6N9bcbjFjWwFcGDhxZi3CoxaRE
CUMXY1Ka3XhyomCeuIh0m40BAZtXLkAc+sBm9GD369pGk0b3xOZhCbwnIghKeB39
vFey82V8doHv6qmWSctok5cipMdamsnQrGObZeXyrgbnI4fEix0mqd2OdcdF7+o0
vSq38W8kQbVF3oy2ga0y/lHobjsB5NXDTvEoXKu7gFa5qfeHCsyJogGdYG9JVSnN
Kk2RXsWj/aKO2pI81X9TasCS5k35kJrRryc+feSp9LVOWnmqe+2vokCtEEjEs/Nv
De9yzOnk1Tm24SmOe/h9LznF4CdN+eJVucYGjXfra1exWqDpQDAlXafDDe86uyNm
OzyJT6bKgJ8YKVm8N0jc/HeE8z5mAnCHOr8aRfBePC61WbNtFdsecTzT7npv8Y11
ftpOjEZeXjhA+3yrOe/ZDdX5e6uAa2x0di+KDJNv1MLSOBUYeCC6g/e9/7QI4dM/
yEsOL9qQpv9JrvJDtk830d20LsGfXfxICts1PlKWyng8yrjyVyM=
=/Rqo
-----END PGP SIGNATURE-----

--wZHcan8mHBMg06K4--
