Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A1C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 10:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbjD0K6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbjD0K62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 06:58:28 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D7944A8
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:58:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2594B5C00B6;
        Thu, 27 Apr 2023 06:58:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Apr 2023 06:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682593106; x=1682679506; bh=PG
        RLXqeU9uEa04thLIDEevYi/GDIg1876hTK/ekgjqg=; b=Z9pZQxtYVZQqhQO6Ba
        OgfsdQNX+q5xqK1UR2DmpHiEECCEI6rC6l2GbyYcx/M0/m4EX6DGMz7TorUTzzci
        5qFVe9vgHNRfSPcthof6dWeU6QK9tLIOF1e2wyC+6iZjRIXqnQEMhr+M0R2OtYdM
        7HVb8uTXPvxJwjqlh5/oV9vC9krwGwbjC88JjRN5YGD9GsNS0mWPHByj83vqPF+K
        Ko0rx7qVVlCRczcM6a8XL2QzGNxSbV8RgSuEyN4AJKj5ED6jZMUUhYtAzin8aui4
        F20LbCYVX7BInTyRnaZHr0fDluuoaipLVBsAmC85n3p48xsn3OxLsAUHJcR/OY5X
        MAPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682593106; x=1682679506; bh=PGRLXqeU9uEa0
        4thLIDEevYi/GDIg1876hTK/ekgjqg=; b=FSZTjbV2Rew8kjHdIZQw8deoakTy3
        vkbpmgHI7PQp0z9tO8+cy5Q8kZcwLTbz2QhbAmnZg2V/SbhQyu53UHDeR1VSlvqt
        c92qSMjj2YvxyXPbbTgEEiparbChkJQqvsvEH2e31FvSvQcReqM5ulpXVlC0ggPp
        UUzBxf9ZazMCy1EwkzIwhNV0DCfUAPSBVE82jCRB1MsnIq7yy/tx+WoBAAYxWQGa
        VggPsnaLSzwn/d3cR8IG5A2XBYDbex7BTkWvI/GG3MWSvS7TbO/ZtCA0MStCBPtC
        PerE3ZBAOpkAzNO3Yc36YMbK2YRTrOOUliAUc+YJjpxoeSjHNLshjtpLA==
X-ME-Sender: <xms:UVVKZKu3XLYhToxQ29IiU8P8rGsJB5jEGPYswevCWzJ_vdr0Gk5prQ>
    <xme:UVVKZPfxF9ZtxlzZjvqCE4NwhuhAM9cEszooZ8bj5abudnBh8ln-K0J9PCqQltw_A
    R5H0I2Mv9YK74iMaw>
X-ME-Received: <xmr:UVVKZFxIquS6X8eOQ3aDnF6zFPTltScbDXfd0gePutzA8cKkiP5Yjv-GN2BBpJk6ExrEBh_FiE16c96ip1Hb2HR91cSxk9xIlgVMu9Pdr4I5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:UVVKZFPjNhtxZKHTAUWmv7Y5MbWYGiOJ8Hns1W0BIMYhzIOIIy67vg>
    <xmx:UVVKZK8gY61eoiqsjk5XlLZ7TeHrwncuegBIxIuku-Eb312xWmowiQ>
    <xmx:UVVKZNXAzEaZHppuyJqZym-ixd9E4fLJGMOqhkohdhuQnyPa2Sa0Lw>
    <xmx:UlVKZAnmmRwTFLaagKFMRWU_XKYNLSE8KCINTqR4mogasbxc1fWjLQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 06:58:24 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 956cafc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 10:57:56 +0000 (UTC)
Date:   Thu, 27 Apr 2023 12:58:23 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 7/8] fetch: introduce new `--output-format` option
Message-ID: <ZEpVT-QjzYrmqgw-@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <3b2cad066a3b3446fc335d6944a62bf79b0779bb.1681906949.git.ps@pks.im>
 <kl6l1qk6o2jm.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZygrBdN4CiNAPbQO"
Content-Disposition: inline
In-Reply-To: <kl6l1qk6o2jm.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZygrBdN4CiNAPbQO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 12:40:13PM -0700, Glen Choo wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > @@ -2101,6 +2116,8 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
> >  			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
> >  		OPT_BOOL(0, "dry-run", &dry_run,
> >  			 N_("dry run")),
> > +		OPT_CALLBACK(0, "output-format", &display_format, N_("format"), N_("=
output format"),
> > +			     opt_parse_output_format),
> >  		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
> >  			 N_("write fetched references to the FETCH_HEAD file")),
> >  		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
>=20
> This change is good enough for fetching from a single remote, but if we
> want to support "--all", we'd also need to propagate the CLI flag to the
> child "fetch" processes. (The config option wouldn't have this bug
> because the child processes would parse config and get the correct
> value.)

Oh, right, good catch. Will fix, thanks!

Patrick

--ZygrBdN4CiNAPbQO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKVU4ACgkQVbJhu7ck
PpQP5RAAmnvt5b+8bMLAMJ5neXf5C4WepChaWeuMLf/hNQWbquyDKXl1IcpOGZeZ
wFKRub+xpvnOvlRuQ8DOE6R9OPjO+lPaMleL8+T8dxB8OZE3i5wrJIA193pTSl9g
HI1g3LkR6hmvvr6kVabU7cULp6He/qIYxjfvABStNcq6bXIjMh/HoiZ68zEURVjQ
DlxZlg+vVx12I0JOtTR8cfDr/YXrgMDWaos9DUAMXQs8uBJ3qsyh6hAMbMUKtDd5
nRZskQGS1ZWbeeo+6kVyHK6tgLJhjjwALeOP6K1+2VkIVZN7v/f4DLuOUM91ruuv
tAKzU0xSSCIktwJws/+7BdamkA+xtcJzbCbRKQHK4fFAgUSTj3cuYUdeNGS6s8uI
NXKCnnAG6+I7cfLCWF0PrmfRjK9DJc+WypGgCVJWE8SCAgLMpDuyYbMXZbo5RTKA
z1rm/7BYaVvtYPOM9D5AKCo1DcGYnaR9MhQTYAmW8Gh3hL8wQvY5iW6KCGijvRoH
biyUJZNhp4UingG6UfHnM+cikrKtYVMzb8aNErrQ/S2wlx5GPwjbzDC0MeaYbmzO
bYGrmkPCj+2oe8J/VOw6dcG2FVT6HDSardnxH+zBN6xvogcBlUlvpcUvYPHzKqzF
5mh9hQJRtijBc/lhS0epyagwghQ6OB6pT+GcPSnzDs0r6foKTVc=
=D1RX
-----END PGP SIGNATURE-----

--ZygrBdN4CiNAPbQO--
