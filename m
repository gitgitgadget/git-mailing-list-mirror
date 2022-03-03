Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E55C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 06:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiCCGwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 01:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCGv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 01:51:59 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4F16A585
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 22:51:14 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A44D85C00D2;
        Thu,  3 Mar 2022 01:51:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Mar 2022 01:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=S/qOkLHyka5l6nOmldkgy4FQB+OaBG5I7KsDgS
        kuQyM=; b=XFA0359VOFhlQ/uCs1LoL0JlIJxJ+kjMfRyBnw904ZF3U2TDRZql8p
        RKqy8Dv7wmnnLM6FByR/64X8H5Q+4qHonP55kywIvIISyXIpH/AHyNVIFOIX+B93
        y8jnPHhPPjo0Jz+fZ5OBs7y9IZYmKbpRE0bfpT3Y08/hRp9ylWe4KKX0bZLt9zwW
        GnfZU+YaXpLglFEDDULxUdsYCofRqlyRiYrkCMq8c5PiQNrVet5H9DNKBOfX47wX
        9BSYWVUw6w0o4f1gBC2WRM39aUBDB42flCNSFA5m0bgCsfJmF1SBd/0/PnE2f3Yi
        voyL2L38BN8mtdakadhbQT4OAPZyt2Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=S/qOkLHyka5l6nOml
        dkgy4FQB+OaBG5I7KsDgSkuQyM=; b=UnghPbJ4Oes0j+PFxrHUfUf5aveUntabS
        QGhtPoM6pvElxVAcAs9qfEO8vXrSXBrnsbE/SRjElh8X7gCnSFj/D0naEeVZus7M
        cplL5kqRAMwVx8NKBQLadv+G6Oh1pDzTR5UcETLKK2Z+QbuQXoqW8ls5V/lzq4pe
        tatUBuezxm0hBVOkJpCfXo6+tkwbDH0kVTVUYkhKjU88Ryu5ZSRhNgpd8nQ1yhok
        BVWuxLMh/r7vakogKY2yHNTXlcZWkq6LRC1iyEobABiG534g4MjIbJISi+GXA1A/
        SJ0CdpaBKN2CvcoaAtUeoTOl48RCwnuFN/srXvHpSAYP9NxkAlirQ==
X-ME-Sender: <xms:YWUgYs7maz6xGWNVYVZGQmE-bpmU7o8ZVvnQmuIzbq-vsWcl_UiuSA>
    <xme:YWUgYt51LDcpupBTxhd9csiZEdRuOPQrMVG68Q8Ybsl2vPajtffAMp40luh19axWP
    RZ-RYvJlnxZxxf_kA>
X-ME-Received: <xmr:YWUgYrf725NaWPPAD0l4TnNpaXWlrKTxbspc3bG9W5kCEzSsQyEyaQiujpsJUKEAmowAwte7uryZurQwM5Am0XCVbKrl8_gLKMjRcvsLRRIjnTKoaHwfR-hulA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddthedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YWUgYhIDaJxH_2TpYk8dM7ZmtEURI9xpkqo-mBeeG1nfkOSYKLaZUQ>
    <xmx:YWUgYgI_57dLy7zbFDLOtC-l2Ah03yAyFrasOZPn9qq9yk36jlzVug>
    <xmx:YWUgYiw80GK5MFlQNS6WlxbPPO2GHqn7ya8pX_GyGotveLsTRGjRIQ>
    <xmx:YWUgYk17O_7wi4OE9FRypVhyYQBTYw2bDxkSukVegAoLSf2mpYmVug>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Mar 2022 01:51:12 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e2cea9c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Mar 2022 06:51:10 +0000 (UTC)
Date:   Thu, 3 Mar 2022 07:51:09 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/7] fetch: increase test coverage of fetches
Message-ID: <YiBlXSrSy1iajd9r@ncase>
References: <cover.1645102965.git.ps@pks.im>
 <cover.1645430423.git.ps@pks.im>
 <081174b7a00cf094a7dacd8aba89fb137ea40f66.1645430423.git.ps@pks.im>
 <xmqqsfrzev2d.fsf@gitster.g>
 <xmqqo82neuz3.fsf@gitster.g>
 <YiBjjV6Kw2KHsMxq@ncase>
 <xmqqmti7bkf2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WokwdfTQYBT8QwnU"
Content-Disposition: inline
In-Reply-To: <xmqqmti7bkf2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WokwdfTQYBT8QwnU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2022 at 10:49:05PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> >> +				# would cause us to die immediately.
> >> >> +				git update-ref refs/tags/tag1/nested $B
> >> >> +				exit \$!
> >> >> +			fi
> >> >> +		done
> >> >> +	EOF
> >> >
> >> > I think I've reviewed the previous round of these patches in
> >> > detail.  I by mistake sent a comment for this step in v2, but I
> >> > think the same puzzlement exists in this round, too.
> >>=20
> >> Namely:
> >>=20
> >> I have been wondering if we need to do this from the hook?  If we
> >> have this ref before we start "fetch", would it have the same
> >> effect, or "fetch" notices that this interfering ref exists and
> >> removes it to make room for storing refs/tags/tag1, making the whole
> >> thing fail to fail?
> >>=20
> >> > +				exit \$!
> >>=20
> >> In any case, "exit 0" or "exit \$?" would be understandable, but
> >> exit with "$!", which is ...?  The process ID of the most recent
> >> background command?  Puzzled.
> >
> > Oof, this was supposed to be `exit \$?`, thanks for catching this. But
> > your above comment is right: we can indeed just create the D/F conflict
> > outside of the hook and thus avoid the hook script altogether. Thanks!
>=20
> I see.
>=20
> As that shell does not send anything to background, at the point of
> the reference $! would yield an empty string, and "exit" is
> equivalent to "exit $?", it is doing the right thing, I presume.
>=20
> The topic has been in 'next' for a while, so if you are inclined to
> fix it up, please send an incremental patch.  If you do "exit" it
> would be a one-liner change, or if you use a different "cause D/F
> conflict outside the hook" approach, the change may become a bit
> more involved.
>=20
> Thanks.

Fair enough, thanks for clarifying the steps. Does it make sense to also
change indentantion of the heredocs as per your review of v2 or should I
just keep that as-is now?

Patrick

--WokwdfTQYBT8QwnU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIgZVwACgkQVbJhu7ck
PpTNNw/8D9y93L0HnoCEINjPiZoERiIpPX8NxWkzOLn7/zAjV+KQbA5mXVsPWwBi
z4bYg7CV6sSJ9Z0KCoMX14FzeIMK5sP+F5wRlOueUeLPuYA25gj/mxy+6H131F3h
ebG1yL7lD81hxwditSaTBzXTiVSnmKKarZkba0WzT+BZv4bexFjTKCABKkfwS9gX
63UNofk74cHvF5qUKCbW2aAOhfFSXzDNBjjoQVo9HnwBa77o6e4wmx8GBCEmvIgO
O0bU71opivUCQ4LS8p1zDAlUV2anyxNi+e9ZvV1upD3cRH0coUUllXQZRO+wWABI
FQL1UfI9T4yTDo8qF8fGawg5jSR1J8zBAmwDN+O8u1pgNDKcchUee+BrlhQHTNsv
LCN7QQtDWMqUDgdTeEhgNclYQ3fucBRj+ATEweJ/hUn3LK8kbNDQENRW3b+Xf1n5
Wtt2nc4W4WKXwy2Hg/F7iQSRbdbiht9N/IC6pc5Ud6o/Sxztc/JmSc9DlB2hUUye
AbvVXOqhZftbYz75oxzsbDGWh9+tGw0b0iQU/xvfwx4B330TLDAYPkkv+qYjsrZ7
xrqA64Lj6GK/ZNnnjPn9pUsAJMeeW0/V2c9t6shJyeFlDOzfoLryHXYb88gBShUp
XQ2WCCmvLv2x/jh9sX+21Y3ty7uVyrtpUGrwNMyL94P+o9MfuKk=
=DW4r
-----END PGP SIGNATURE-----

--WokwdfTQYBT8QwnU--
