Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F56CD68F4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 06:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442225AbjJJGTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 02:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442229AbjJJGTS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 02:19:18 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856E497
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 23:19:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2EC215C0277;
        Tue, 10 Oct 2023 02:19:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 10 Oct 2023 02:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696918753; x=1697005153; bh=iY
        6S0ICQBwfu1PZqi3S65HHnr+p+LUqg2cAbMd7zJys=; b=qw7bxS52iuq9uPY6ga
        Tr1yuzLYXclxc/dRVQXlwYu73y/5Aw35BTQLXFSQVganY8vdAlOhOTwKwVAPCmyM
        kBu79EnhJ2L+k8smI62yjlrIijdxWejjRSusnRJokeG+Bc7zRhw6MZ6C35gRvSn3
        x384Mwrtx3ip5TOcepyIMmQ1Iyc4RmS3xwY26tUot2rt0nju4FdhtHu2AOiEhV42
        MLrq7vHFKvrh8/4B2rOv698Ku6BPH2Gwvrn4MDl7vOKCVFbqpHWfGjadBDsBqfR/
        o/5K0DPqHTzpxaPKh/kfhmjS4ogA67IqpnqJlZRBkHP09X/+sJ/rP2h4G5Pxt+Lu
        C0sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696918753; x=1697005153; bh=iY6S0ICQBwfu1
        PZqi3S65HHnr+p+LUqg2cAbMd7zJys=; b=juIr0hRGEwkQuFQP6dEieC8oVnpJf
        DibvrRY5mZUmVkfrfXkD5F/2jwQKx+5pvigPDvP4SP2F532CAdeY5pYBs8itAI6K
        Vf5qbOe6YvTj5w6P6Hg8y4VIfXvBR5BB0gYCBhLjneX7BFpZCUh2Vhcwq+TEu/If
        gzeXsAXSI1dGVGwcGNmahZkm433KciUGHR4kp+AGPJ/WblgN7o6LR2CGHr2aKiVo
        GhiEi/IyxQBjf/4tN3v7Phku99ACVuybM5pidVwStyJMT1tAxx3VpdSinVvLZ+Hw
        P6hngzOEo13Sp5/h9OdcaIw67zj2o/FXwecELgfthnMNrGg5SOrOgoI4w==
X-ME-Sender: <xms:4OwkZXE926JRYy5UNHcJXVJ-VhGjaDGfWnGzuh_1EirgTR022jv8UA>
    <xme:4OwkZUXLrjrXSnvC4nXz-XzEdfunfOd-VA2LBHJzb6NKqcYQMlUpFAyWve-dm4Ci1
    SCtMLv0rWQrAp_eJA>
X-ME-Received: <xmr:4OwkZZLiCDhNM3FOXStE_XzcLshU4t43dKXkZptVpQFYw-bhaWvA52AKaCnzqy7E2zlpOet0rfbv41cnmmcFuAWePDLLN8SUzSj2IyXFIGRpdcjP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheeggddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:4OwkZVEQ05YqnbEM94DTZ5iYl1BXVeYjDmTlsAZFfQkhxto1Rql1OQ>
    <xmx:4OwkZdV8dl13m933N1CvudGqJeXvFiPwNtVfTs2a6SWDdjXd9fJeiQ>
    <xmx:4OwkZQMh3YqcwJQFuX0l0cdnyMZYXx2rWCmmkO8hTd4OaveS2jL52A>
    <xmx:4ewkZef_RFMNJACySpDq2o3CCrBSKsxbaKYawJ-w58Ea9VvD_jMzww>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 02:19:12 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 1dfd56ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 10 Oct 2023 06:19:10 +0000 (UTC)
Date:   Tue, 10 Oct 2023 08:19:08 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
Message-ID: <ZSTs3BUVtaI9QIoA@tanuki>
References: <20231009105528.17777-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6BkbKfGtkn8+aZUg"
Content-Disposition: inline
In-Reply-To: <20231009105528.17777-1-karthik.188@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6BkbKfGtkn8+aZUg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 12:55:25PM +0200, Karthik Nayak wrote:
> The `--missing` option in git-rev-list(1) was introduced intitally
> to deal with missing blobs in the context of promissory notes.
> Eventually the option was extended to also support tree objects in
> 7c0fe330d5 (rev-list: handle missing tree objects properly,2018-10-05).
>=20
> This patch series extends the `--missing` option to also add support for
> commit objects. We do this by introducing a new flag `MISSING` which is
> added whenever we encounter a missing commit during traversal. Then in
> `builtin/rev-list` we check for this flag and take the appropriate
> action based on the `--missing=3D*` option used.
>=20
> This series is an alternate to the patch series I had posted earlier:
> https://lore.kernel.org/git/20230908174208.249184-1-karthik.188@gmail.com=
/.
> In that patch, we introduced an option `--ignore-missing-links` which
> was added to expose the `ignore_missing_links` bit to the user. The
> issue in that patch was that, the option `--ignore-missing-links` didn't
> play well the pre-existing `--missing` option. This series avoids that
> route and just extends the `--missing` option for commits to solve the
> same problem.

I had already reviewed the patches internally at GitLab, so for what
it's worth please feel free to add my Reviewed-by.

Patrick

> Karthik Nayak (3):
>   revision: rename bit to `do_not_die_on_missing_objects`
>   rev-list: move `show_commit()` to the bottom
>   rev-list: add commit object support in `--missing` option
>=20
>  builtin/reflog.c            |  2 +-
>  builtin/rev-list.c          | 93 +++++++++++++++++++------------------
>  list-objects.c              |  2 +-
>  object.h                    |  2 +-
>  revision.c                  |  9 +++-
>  revision.h                  | 20 ++++----
>  t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++
>  7 files changed, 145 insertions(+), 57 deletions(-)
>  create mode 100755 t/t6022-rev-list-missing.sh
>=20
> --=20
> 2.41.0
>=20

--6BkbKfGtkn8+aZUg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUk7NcACgkQVbJhu7ck
PpQs6A//ZKzBaqvrJBOrvZ1fOowVuPiLkgkryrztrBJZKB0RYUTcgZcxQKRdz2OW
ewv12HBc8ItbFRd3iwaorYNNK8n9bVMojXTuDdvlb9E6gUihEmxYbr+KERD/gZh9
MzpbQNmZwmkEKdekGrBYEkzvZqwibMRcdJPF084vDMUaba/kI+FqNKo3sbzLtKu7
lrzDxKz+i48WGqlOujDfls58QVdnm82erFKqVxdn0pptng6GnDiSa/bmulo/b4J/
usDtBRtZvs84dNPfk2gCuO/3hrRHyqCHXj52/KZX4uMLFUypxzEsevecHYpN1IGX
A8RjF9J9nopNps+q9SHhNfD0cSDlHgF/dmbNkFBobSwl06u6yO/cXRvMcmY2Am4V
AHwI2xy7emnzjdTtZ4iP4eZDiBdIVehX4RuqSNcQOBZ9DOa5ksFGN6B0v9SXIXYn
ZeWayTFKpNmTE3mxHUlUnOjjuw9qPNw2W3/bBOKr0rrkC1NhpsCSLOL9J+OI8i6E
9GjFbOIgBIpuocE2dS+My9jg9j9PNuzygjvmWwm0VW4RsfwZOMXjDldknYEDh9hQ
V8NhxjshIT811YTIXaL0auDyl0zWv8r4L19xKlNvoQZeFbiOPOvUDBPlM3Gp1OAN
evZT4mHqMyAheEf2HbvjRETn+zm2CBb+B4NZP2z5RsctBS/Gdak=
=JpzQ
-----END PGP SIGNATURE-----

--6BkbKfGtkn8+aZUg--
