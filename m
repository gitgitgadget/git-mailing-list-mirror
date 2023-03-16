Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E5DC6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 15:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCPPGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCPPGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 11:06:19 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F209C2DAD
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 08:06:18 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E8EB532008FF;
        Thu, 16 Mar 2023 11:06:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 Mar 2023 11:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678979177; x=1679065577; bh=j9
        ionya3K5DCcKOhfhO58ieOmubM5Xl9qgLFwkI2XwE=; b=gTF97om8jEW5zACNnp
        9V4ONBSyZNxkZN+0o0ma9QqpjXLcA6WNAV4qMobkEJfI2XsqsGLUWAPy5e5bPqPG
        y98B0KzzazCOa9kheyaeKhOjFp+rmzfIIcTojaKdeAFPoCivGEDHcFBSZRLi7Z+u
        NMP5QCnkVofwcJt/8CYRFS2sDVyV8ibYKdqEoeqYzEtVfLwByPl0VipJfxdnZ64y
        ux/oeMX9QJiKkEBGVkF1DUKCX0BOmijTNxSFaVMNjVNccOpwPqMRJ9Ff/O/8LseE
        2KQ5PYqSTqWXK3JLmU/DhN2qkBHeIuWJezol+9iLeW2YtjqMPwdcthqml+vV+1mn
        /j3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678979177; x=1679065577; bh=j9ionya3K5DCc
        KOhfhO58ieOmubM5Xl9qgLFwkI2XwE=; b=hHA2aP7wyQomU3jhqx+LsHG4sUoo8
        raTIjvBH2rZukQYuHt9ukRf1cxYJ1wxTqQVa8TvwlXfCRyjlauQc+n4u2bw4NEfW
        VcEqBkWcH9V9Iu+EK2wYHP8HT63E/U3XlqLVv81qfqUO6yP/XftXyKiDlcbCTZEg
        ZO19wiScTWlO/VADg+ZFFf0CDqAZiSaaLGW1X8Gmw1eeVvPdFl/ach0Ls9eO03XR
        jy2oY+h/zKmLJJDOjjuOSDa0ua77+MjzjxmizuluqcMDuoFOIvP4f+jCLD09Dy+X
        yq+KO94tis6ZH8rOHRjwlOkrWo3hUXRf5Mr+FKhUiQGx2c5Sy7wQtx70A==
X-ME-Sender: <xms:aTATZLshqiXE9gaM3K3mNg5ME3QGTHTAXb1-CoYaDjy7Rdu4yZj9gQ>
    <xme:aTATZMd6GG7Gb1ETfEK3ykjMdSLamFeecW710_W_Rk2Q60PIEQE8GeLWncUY8XOdk
    Yp1YH793TccHyoEAQ>
X-ME-Received: <xmr:aTATZOxoj5f0M5K8q0C3j7o3aFRduJbioyn7Ndb2d8trtMoT_Jj5S00wQHiq2uiBIKEwSrpysLBkEwSUNp9L8IfqZt7Xi_OSmf8i__rMczvgPgOW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:aTATZKMgxwY7QjI9ErY6UnZKUe18eoq9JkBNuF6tNBMRA-MfUbT08w>
    <xmx:aTATZL8bo3ZkoYcl8mFceQ3G4se8yRtwMT5GJBZFhgtOqIeM6mMyXg>
    <xmx:aTATZKUGW8XdJCkXaHcR6e4VC4UNbkSWpnTqMIMsU_aa4GO2cSG4ew>
    <xmx:aTATZIE3EIKp4v1Uo8L275mzdVhfO5aVraeLAgtYN-49Vr1qyHKI8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 11:06:16 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 071b1b56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 16 Mar 2023 15:05:51 +0000 (UTC)
Date:   Thu, 16 Mar 2023 16:06:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/8] fetch: deduplicate logic to print remote URL
Message-ID: <ZBMwZvQOooFiIl6S@ncase>
References: <cover.1678878623.git.ps@pks.im>
 <2ea3a4e308d2fb89f24d0cd2efc9d3867983a4b0.1678878623.git.ps@pks.im>
 <xmqqy1nxmxdx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yE3PW4RAIcPmLtjq"
Content-Disposition: inline
In-Reply-To: <xmqqy1nxmxdx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yE3PW4RAIcPmLtjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 04:02:18PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When fetching from a remote, we not only print the actual references
> > that have changed, but will also print the URL from which we have
> > fetched them to standard output. The logic to handle this is duplicated
> > across two different callsites with some non-trivial logic to compute
> > the anonymized URL. Furthermore, we're using global state to track
> > whether we have already shown the URL to the user or not.
>=20
> If we are certain that store_updated_refs() is called only once for
> the entire process, then storing the preprocessed url in the display
> state and passing it around does sound like a good optimization and
> clean-up.  What do we do when fetching from multiple remotes?

We execute separate git-fetch(1) processes when fetching from multiple
remotes or when fetching submodules, so we should be fine here.

> > +	display->url_len =3D strlen(display->url);
> > +	for (i =3D display->url_len - 1; display->url[i] =3D=3D '/' && 0 <=3D=
 i; i--)
> > +		;
> > +	display->url_len =3D i + 1;
>=20
> This loop is inherited from the original, but we may want to use
> strrchr() or rindex() as a post clean-up after this series settles.

Yeah, that'd make sense.

Patrick

--yE3PW4RAIcPmLtjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQTMGUACgkQVbJhu7ck
PpSbAA/7BzbnPCVS7H7MpUFSQ18j2R5XVSNaf7jDaGIPb9MgHaeoNHkNJE7aP7uK
Io3JcapzaDi5rDZyMjYwU6wmKbVl4EFZCOfqXh7E28hoPJxHU95RqweTRgsCmDG+
eG6rh/rMcs6hMHtoWM1EB7zeoLmM1+FVq9rrjajIn68hVCthasE6snePoe/S+Ivj
iL/2DA1MHoDsycBZrqsLdCozZpNPX3xJZGN3eJKpHmyYDMb92QP09WZJCJdlho3S
7SrOGFmD5KvG5MqapGnFucSX9qCaQMcm7FcCsXao9Cf+rU6Klp2cdd4QF4iCA61E
dcw+yzMdzeq0/V7gv/pueV3I+nS8Ytp/Bng3O9NVd18aRIO+jnXBmkFgV7oBWIGF
Tea4ChuHkZXbpQifrXS0QC8iBrbjZQfwocFCRVDqWWgl+7Nro5/HSCHUdQagTldD
mWkNv3C2IxK/1hwfPprqoQNNp3ef77lsjeCXS6lM8h68ovyC0EWMHIVcTztArU7F
WO9bPq3gz384rAKoZ/yid7FuX4Igc51aZdcmz8BmwVjwTnVxbjPik/WfkY0jV9hr
eHVdH5QYqyOos0bfaA42N2u1F9EMM4emecWN8jSiApK/2BRZxiYzOfRa2pbxXIzv
vAMBP7kH6L0TMMJ9oSoyjqBbmhq6F1+WXO51lj9aTCY0j3KECII=
=ONic
-----END PGP SIGNATURE-----

--yE3PW4RAIcPmLtjq--
