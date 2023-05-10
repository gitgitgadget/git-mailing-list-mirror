Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E762BC77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbjEJMfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbjEJMfC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:35:02 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A529EF6
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:55 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E4E573200919;
        Wed, 10 May 2023 08:34:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 May 2023 08:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722094; x=1683808494; bh=uD
        5wihF8eiw5RnzdsFhWaMGX0G0hCHIaw4G0acluT00=; b=is9ErKz0oWtrg4Er/z
        l8aNBEVdD+Ye7RuzPK1vKp2QZIJfHW3DAzRqtnlKUIsX0a2H3eWSRzfwm6tQDvAS
        72x3loMeM1N/PTv7CIn+MFPdXF5lNvT/bzwSMIH433Ohv7JPtZ2RuxnG5jll0rAX
        At0JAkRHuE6C7uV1/fZmTECwI7JVedTngoogVDpensPFpDWQ9Ct6D4YOmq+wFrcq
        QiYabs9cMLG04mIboGPKns/TNhMsiz3py1ayjcuSb/smqens044RHfyfVx/79OfV
        XDBBxvQdkRKaOIEWw0oG4pqiCC3UyK1hdTqS4MBD2d3OLOfxlZO7m2aG6psq/2n0
        Ie8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722094; x=1683808494; bh=uD5wihF8eiw5R
        nzdsFhWaMGX0G0hCHIaw4G0acluT00=; b=ZuMDPnF927mJV727KoRoYeMkR84dm
        acDpVBLV5dqSfD+j67KJuYLnoOVX04PFPFJhIIVetqVZBzjO9Gl7lZh9lT/um990
        ruizBhWdncfsRcL+7qBLGx77BFZkmJEzjStGU7p3N/5/tK+PVNNCvDyfhn3KBmvn
        Z6xZY6MgfSOD88Z8eKbskBaamTkhRxI2uRoHQu5Vzj5nrChsG56VpAtHvurB0acg
        eB/FfqoLVyLTWWMdujEmmZLRqF4pBtpCjPo2GFxJiCMY4QKbmjho92Xj/95M5EBL
        3q3DaBts4/qSDqhw88nwXwBH5WXKAVGsU3DgBv3cWy4FtpmHsUJ+M4RpQ==
X-ME-Sender: <xms:bo9bZM9_BxywBo4tZ39bWG8yF5WBHgvFX5A_5FD-GptZnXDZgAd44Q>
    <xme:bo9bZEuBz0hqDJht7-F_x56pIKk8DTzuyQ_7Dq1jN2SE724NaEfpCJ51TYN0CHBmB
    e0dsLWslUvxIDxZzA>
X-ME-Received: <xmr:bo9bZCDHB6HOTsEV_3x1IasEwQowIAzHkmwOY5HmdSO7lTzXUHtqSTKvt2-vhb0RFew-fzPFp4uJaBDiUt7H3hZznjFRfPiVNRHxK9nr7gqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:bo9bZMf0mSNLEteAtoP14IIKEFhn8cOdXviE5XOmUlI00yh5lxoGvg>
    <xmx:bo9bZBPHL_CInGYdg3qleBUviLhutxx4yXZHqGWfqTQvstHi9MsCng>
    <xmx:bo9bZGlxnbFAszDLnsp7RhT-ZAoNxrnguJ3mT2jPg70z0aBxbMvJlw>
    <xmx:bo9bZDWommbFocW6UNFAuKo2ofQVdl5hcja6jPudDSkrr9-ISS-sBA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:53 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 705b70a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:44 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:52 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/8] fetch: add a test to exercise invalid output
 formats
Message-ID: <ZFuPbJZ4jtFfX7iY@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
 <006ea93afbef8742a823a9444d2b71785a9b4ec3.1683636885.git.ps@pks.im>
 <xmqqv8h1xu7q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rrVUcS5apKQ+TS8+"
Content-Disposition: inline
In-Reply-To: <xmqqv8h1xu7q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rrVUcS5apKQ+TS8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 10:58:33AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Add a testcase that exercises the logic when an invalid output format is
> > passed via the `fetch.output` configuration.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t5574-fetch-output.sh | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
>=20
> It makes perfect sense to make sure that invalid input gets rejected
> and the command exits with non-zero status, and it is probably a
> good thing that the end-user sees a message that explains why the
> particular input is rejected (even though it adds one more thing
> that needs to be updated when the message gets reworded).
>=20
> But do we need to insist on no output to the standard output stream
> when the command errors out?
>=20
> Other than that, looking good.

Not really, no. Will change.

Patrick

--rrVUcS5apKQ+TS8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj2sACgkQVbJhu7ck
PpRoDBAAnzMX3792u7opmep04cdUVIExOEq4otOU9a+lCHTyS+39D5uY5owova7X
ovWFKPWUhifKwzb1m1xqNjvT3XMIZZ/bC9yiiylZO7WUv03ic+ca98/51h9v8JFw
fu+tYhzf360SvJ0K920Nm5WX1QAKVWNdK9xj7wUmnbq7tkTKSNoMVbKJtSYFDHYQ
pJS4IaVHT+ZwODztxjDwWhhc6KesLlvrK1h8UDYo85ommvXTn+oGGonIZsj7Ywr0
+VuhRVkA5mLuG2fuBmLBcHILpUU41VFQ1m3bAAtHUaX33GM7UM7FBBJ8F9Pa4coj
D508r6mcyIBCK3zEdIqgbcoBtsYG4xZ4HeQh14Pn/IlsQC51gktyF7oatZzjK2Sx
7rwrC/lg4501K97DrvIMZq1SB0UAWMdZ4mj15iRVMwvRrOwspU/ql1TdO8ijzj+U
iYCrfJcyCdmNgGW3IfMTZDEuMXTwdPuKjVeC5LUjmFyPnhp+X+3Z1jWUeevI3Ixw
ykYJUDmcr//9Qm566m+WaDG0I5x/i9POJQQfQ6EV4HCXRvXJPTHtHMu1jQnEPYB5
6+ZE8z9zkZIv/YiKUyOsmA2U2Ye+fMmD9jvgHNz/UoI57yZoKK0ZwSwNOEVQ9PZf
b3pkhb7QRjotkwhPgozFBKL5xGIzgY2v08I/sDtjM/sHe7tO8qU=
=ISzJ
-----END PGP SIGNATURE-----

--rrVUcS5apKQ+TS8+--
