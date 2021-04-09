Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140FC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 10:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC4560240
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 10:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhDIKcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 06:32:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47441 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhDIKb6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 06:31:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DF69B5C00A3;
        Fri,  9 Apr 2021 06:31:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 06:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=2y0mlhefgjcRMpixzN3H/02zgrv
        rukL5xAPZZzB9j+E=; b=BkxSMPoVbjbu2H1r3RktXM6/8qbhAT80GjV7V4xPRfs
        GZl+FrWym8FqrN720cDqcHyWulJC62Uq6CySeYhMgqDBDNTyBWy3Ttqr6/grl5U3
        sLi8IVK7si1TRFjvjHDPIWodScPowC+kBd0LgSe8mPgoC60jZ0fsDY/gMCbsfNH4
        1wZZrT6lV8L7gK940SdmOJM5GIZdMi+lOPInSpumwc/TDJxmdLXr7Om5h2gOBlPx
        b1ppBiOv8rURNiK/P3tAEJU7Ola5/0S//NfpUfaweKnKHrNCAfT+tcjqKuoFl2wT
        eNHGqcGnyk/rLVVyR77jhc+VQ4DjIkjnMmprWQZZcZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2y0mlh
        efgjcRMpixzN3H/02zgrvrukL5xAPZZzB9j+E=; b=k5VnkLc9ii5HJwbXr4ixmU
        nV4lAG48OqOalUYlFkudWvBRYHAJGOXW/PfeTx9CR+KyAvimIZkchZvON60zPk3A
        LyfEt/JVzhrQWkaxJVcJxCkbM6BCEB/3kmNmxfidxEs6xq5lWSdJf0lSVY7MfwdR
        nJrBuwvqcxsdp80SrLpIz7lc6ssF2fHpu/aSkxlxU2stnVVrHcixD0OZONR+IQfX
        tpW4q/Ng9izCZ9EBc29ZBsAOt7sJ20KRzblz6EFFaBN3h+H4y5J7cBwg7eUNS+oc
        tufwGvW1K+1egBxQbedU+Fpvaix2TOW46CQvuLliA4en6B4VcVO8AxjAAgkvQ0RA
        ==
X-ME-Sender: <xms:ES1wYPIu9f9cLGY26ROwliYnjX6SKnObcMmw-FF-sxBOgOAvKP4ouQ>
    <xme:ES1wYKDkC9Fn7qsASaz3XiXORtRVwC7StTgrydSex5Shz4MqSVnsacHcn_stRpagh
    1bIMd-7fU4jiSTYrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ES1wYEqZiT94T0RYX34eUFA922LKfccyn24qIsmLrnclI36epbYUtA>
    <xmx:ES1wYFjKWZfclUUIHbStEL__XM-cUlwjVmEJ5qL3NdmxJyCVhDcsDw>
    <xmx:ES1wYBD4VFkjbyMT47ypArLp4CAQpHzVWyijZgQZTy0N9EUyEJUnoA>
    <xmx:ES1wYJATAoq9HDdJX2DpDEnboc41n0964uz6oHzaXmTPE9Tb5fXYnA>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC06A108005F;
        Fri,  9 Apr 2021 06:31:44 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2707ee53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 10:31:43 +0000 (UTC)
Date:   Fri, 9 Apr 2021 12:31:42 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/8] pack-bitmap: implement combined filter
Message-ID: <YHAtDp11xFzdUSQl@ncase>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <fac3477d979058da0430b974a34f7c7f866bf456.1615813673.git.ps@pks.im>
 <YGygV1mesbJzdPr5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kxYWc6vT12NSnAk6"
Content-Disposition: inline
In-Reply-To: <YGygV1mesbJzdPr5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kxYWc6vT12NSnAk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 01:54:31PM -0400, Jeff King wrote:
> On Mon, Mar 15, 2021 at 02:14:59PM +0100, Patrick Steinhardt wrote:
>=20
> > When the user has multiple objects filters specified, then this is
> > internally represented by having a "combined" filter. These combined
> > filters aren't yet supported by bitmap indices and can thus not be
> > accelerated.
> >=20
> > Fix this by implementing support for these combined filters. The
> > implementation is quite trivial: when there's a combined filter, we
> > simply recurse into `filter_bitmap()` for all of the sub-filters.
>=20
> The goal makes sense.
>=20
> Before this patch, I think your test:
>=20
> > +test_expect_success 'combine filter' '
> > +	git rev-list --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject=
:type=3Dblob tag >expect &&
> > +	git rev-list --use-bitmap-index \
> > +		     --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject:type=
=3Dblob tag >actual &&
> > +	test_bitmap_traversal expect actual
> > +'
>=20
> would pass anyway, because we'd just skip using bitmaps. Is there a way
> we can tell that the bitmap code actually kicked in? Maybe a perf test
> would make it clear (those aren't always run, but hopefully we'd
> eventually notice a regression there).
>=20
> > +static int filter_supported(struct list_objects_filter_options *filter)
> > +{
> > +	int i;
> > +
> > +	switch (filter->choice) {
> > +	case LOFC_BLOB_NONE:
> > +	case LOFC_BLOB_LIMIT:
> > +	case LOFC_OBJECT_TYPE:
> > +		return 1;
> > +	case LOFC_TREE_DEPTH:
> > +		if (filter->tree_exclude_depth =3D=3D 0)
> > +			return 1;
> > +		return 0;
> > +	case LOFC_COMBINE:
> > +		for (i =3D 0; i < filter->sub_nr; i++)
> > +			if (!filter_supported(&filter->sub[i]))
> > +				return 0;
> > +		return 1;
> > +	default:
> > +		return 0;
> > +	}
> > +}
>=20
> Hmm. This is essentially reproducing the list in filter_bitmap() of
> what's OK for bitmaps. So when adding a new filter, it would have to be
> added in both places.
>=20
> Can we preserve that property of the original code? I'd think that just
> adding LOFC_COMBINE to filter_bitmap() would be sufficient. I.e., this
> hunk:
>=20
> > +	if (filter->choice =3D=3D LOFC_COMBINE) {
> > +		int i;
> > +		for (i =3D 0; i < filter->sub_nr; i++) {
> > +			filter_bitmap(bitmap_git, tip_objects, to_filter,
> > +				      &filter->sub[i]);
> > +		}
> > +		return 0;
> > +	}
>=20
> ...except that we need to see if filter_bitmap() returns "-1" for any of
> the recursive calls. Which we probably should be doing anyway to
> propagate any errors (though I think the only "errors" we'd return are
> "not supported", at least for now).
>=20
> -Peff

But wouldn't that mean that we're now needlessly filtering via bitmaps
all the way down the combined filters only to realize at the end that it
cannot work because we've got a tree filter with non-zero tree depth?
Granted, this will not be the common case. But it still feels like we're
doing needless work for cases where we know that bitmaps cannot answer
the query.

Patrick

--kxYWc6vT12NSnAk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwLQ0ACgkQVbJhu7ck
PpTdEQ//cP/RJ5KTG3sODCB1tOPrMvSjtsskHmdNA/Htnmab4Ezjacc3+JzF5RC7
u/fMKZKogEaLLpTusGagozfwIhvFRGtqhQyMUPxnb97pNGD4/dvuhCSTYARg9XXJ
w+BHnljpkgpiTeovLZfDthtaIdkZX0Bd8BA+86fBmyWMGkqO/JSxhnyCDYiDUWuy
GDqQVDQO3yw7WnT8s7efghLxlIBWRMpCD1k6sjSUAL2TZSMAohcOFwmnIuKWuu3F
9i5gSFnsEjs06BQvctLDpoSNDQWGUbnf2KRk+qTb1dHPXZGNeF1WX3DLwBeiv+XB
SsPhfKDN5LQp5TzZI21j9u7IDyPMgz4bVD41NT5yqKWIkLNCbjrVx+aO7kMUwA3h
iNh0/n2+FY6nuUSJSs3TZooBPxK6pPXl2BRn+ZM7Uz8Ky9GerRJBG001emVQLzGw
E41GtOWrKfpVytGgOYlA2C5QemHm/AlS7Ud8SAkOM4rPaPRFwGQaFQL1rmzd4IL/
gdldH4GUXZkaMXsPnVGQL6zq/W2I7eCTIi97/23MyuAtGecCbub5ZIzGFlDfHrpj
m4tA5rzsYxHhOnSQoRIhIcbCU8imtp5ZALGX3qxQdIqf0pR3uw4c1rFLdYfgMFG4
9+as5uxIgFmHNdYbES1PUhz5VGGIE8+/ugbHsnG2IgqoUPfvlhk=
=XMQf
-----END PGP SIGNATURE-----

--kxYWc6vT12NSnAk6--
