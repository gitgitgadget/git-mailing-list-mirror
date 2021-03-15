Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BACC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8577164EED
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhCONOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:14:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57941 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhCONOe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 09:14:34 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DAC655C00C1;
        Mon, 15 Mar 2021 09:14:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 09:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=IiMi9b9Iz1dvQlGWpMKg78Owxs+
        cHGYVgF5MAYX7wdo=; b=S30xFYGWDrYAEYXHiB7Ievc1NZcYxg442FI8JHOr6bU
        XFeI0bBP8QZEQz6AVA+KlEhv30VO7iiePnPGnpvc7zGTEsinsC7jDsc5qloiGACQ
        OhVMNTAIOU0C78AHru/F6CyRsRVjl/Pv1m7pDDVDmFcDuCsw2P70xdDUeu9KrOm5
        qWBNGulUp5JJOeccnth+m4Fq7jYcq6WnX09SoYYJY8cFIGtARyweWVGZUpRw/ZtX
        S8loVL0BUMaIerg68LvHCPWp5If4wXr+RoFDfSYtVOsReVT+hlbWoNB3VhtnEnoo
        vGxmuXCLPqIKni3TRh/N27aI9ppv9+elNClJe8jIpYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=IiMi9b
        9Iz1dvQlGWpMKg78Owxs+cHGYVgF5MAYX7wdo=; b=lMOUMZRUoGCbzn4uxnMCLG
        PhFAdsac58/aJoLO/K+FtMgeNIPImXIwQxfgPUHa/IB+jNpvhFFtPBr8s3Wx5X30
        m/iZvaH4LodqK2nZ18Jj34d/5ljwiAh9ue2+q4qrmlYZ5fgUvg0I6kvbw0wCpf//
        0bF/3NnPw3JADARLrF6t5WeCC7r9+obm1XMhGq4ZbTEwaGrdk7YFEF07BH+HXcPf
        lUlMih9gKU68vEY6IgH9PiwKQGYVWt84QedufrO1POVQlcY9jaUiGR/gwLIuRtUu
        tRaLbkM9IDPJJbY/P0cnrwj/cJuKFrDJ+YzYyJlH8OaeEoQL+xR6nOGtMpTM5AAg
        ==
X-ME-Sender: <xms:uV1PYIlpG-nuS7d53Ee0Tq780Ju4SJ5KW6Z4dv0RTyz2DhhDLBTJSQ>
    <xme:uV1PYH0hv0Hc7ArRASp_wslgtEAvf3Tqz31SrRuvFPevQ_Y5QYZdXokOBocr3xbhs
    nKRE3TyxU2nit0KeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrleeirddvgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uV1PYGroE_PuaLdaRSjRvSLOu1zjij8ET8oAEcVjbGqxgNVAOW5KnA>
    <xmx:uV1PYEmd5NRgzZ6xUnrDROydFSSH9ow8ihzgVxeMhjZhhV3OyRpFjw>
    <xmx:uV1PYG1SNpR_AzyByhGu9i1s2MylnfoYJ7dmR6ERfkg7RFjpaEihOw>
    <xmx:uV1PYL-oDJ1eQuTYiF2HRCbJqANzH4UKgj8pl1qMAu-Y3CmSEayG5Q>
Received: from vm-mail.pks.im (dynamic-089-014-096-241.89.14.pool.telefonica.de [89.14.96.241])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6247B1080054;
        Mon, 15 Mar 2021 09:14:32 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 868ffb28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 13:14:27 +0000 (UTC)
Date:   Mon, 15 Mar 2021 14:14:26 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/8] rev-parse: implement object type filter
Message-ID: <cover.1615813673.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VRRUTDx2s3C9JIjY"
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VRRUTDx2s3C9JIjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series which implements a new
`object:type` filter for git-rev-parse(1) and git-upload-pack(1) and
extends support for bitmap indices to work with combined filters.

Changes compared to v1:

    - I've added a patch up front which changes the uploadpack
      documentation to explicitly document that setting
      `uploadpackfilter.allow=3Dtrue` will enable all future filters. I'm
      not yet saying that this is the correct thing to do, but rather
      added this patch such that we have a proper place to discuss this
      topic. In the context of object-type filters, I do think though
      that it's not an issue to default-enable type filters: they're not
      expensive to compute anyway.

    - `uploadpackfilter.<filter>.allow` documentation was updated to
      mention the new filter.

    - A bug was fixed which caused us to reset `--filter-allowed` in
      case a normal filter was converted to a combined filter. I've
      added tests to more thoroughly verify that filters work as
      expected and also filter provided objects.

Please see the attached range-diff for more details.

Patrick

Patrick Steinhardt (8):
  uploadpack.txt: document implication of `uploadpackfilter.allow`
  revision: mark commit parents as NOT_USER_GIVEN
  list-objects: move tag processing into its own function
  list-objects: support filtering by tag and commit
  list-objects: implement object type filter
  pack-bitmap: implement object type filter
  pack-bitmap: implement combined filter
  rev-list: allow filtering of provided items

 Documentation/config/uploadpack.txt |   9 ++-
 Documentation/rev-list-options.txt  |   3 +
 builtin/rev-list.c                  |  14 ++++
 list-objects-filter-options.c       |  18 +++++
 list-objects-filter-options.h       |   8 ++
 list-objects-filter.c               | 116 ++++++++++++++++++++++++++++
 list-objects-filter.h               |   2 +
 list-objects.c                      |  32 +++++++-
 pack-bitmap.c                       |  71 +++++++++++++++--
 revision.c                          |   4 +-
 revision.h                          |   3 -
 t/t6112-rev-list-filters-objects.sh |  76 ++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh  |  68 +++++++++++++++-
 13 files changed, 403 insertions(+), 21 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  270ff80dac uploadpack.txt: document implication of `up=
loadpackfilter.allow`
1:  f2ce5dac89 =3D 2:  ddbec75986 revision: mark commit parents as NOT_USER=
_GIVEN
2:  9feadba124 =3D 3:  d8da0b24f4 list-objects: move tag processing into it=
s own function
3:  4aa13ee83f =3D 4:  5545c189c5 list-objects: support filtering by tag an=
d commit
4:  01b9fdbb9c ! 5:  acf01472af list-objects: implement object type filter
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    + ## Documentation/config/uploadpack.txt ##
    +@@ Documentation/config/uploadpack.txt: uploadpackfilter.allow::
    + uploadpackfilter.<filter>.allow::
    + 	Explicitly allow or ban the object filter corresponding to
    + 	`<filter>`, where `<filter>` may be one of: `blob:none`,
    +-	`blob:limit`, `tree`, `sparse:oid`, or `combine`. If using
    +-	combined filters, both `combine` and all of the nested filter
    +-	kinds must be allowed. Defaults to `uploadpackfilter.allow`.
    ++	`blob:limit`, `object:type`, `tree`, `sparse:oid`, or `combine`.
    ++	If using combined filters, both `combine` and all of the nested
    ++	filter kinds must be allowed. Defaults to `uploadpackfilter.allow`.
    +=20
    + uploadpackfilter.tree.maxDepth::
    + 	Only allow `--filter=3Dtree:<n>` when `<n>` is no more than the valu=
e of
    +
      ## Documentation/rev-list-options.txt ##
     @@ Documentation/rev-list-options.txt: or units.  n may be zero.  The =
suffixes k, m, and g can be used to name
      units in KiB, MiB, or GiB.  For example, 'blob:limit=3D1k' is the same
5:  c97fd28d8f =3D 6:  8073ab665b pack-bitmap: implement object type filter
6:  fe2b7a1e55 =3D 7:  fac3477d97 pack-bitmap: implement combined filter
7:  b43bf401df ! 8:  0e26fee8b3 rev-list: allow filtering of provided items
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, co=
nst char *pr
      		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
      	if (arg_missing_action =3D=3D MA_PRINT)
    =20
    + ## list-objects-filter-options.c ##
    +@@ list-objects-filter-options.c: static void transform_to_combine_typ=
e(
    + 		memset(filter_options, 0, sizeof(*filter_options));
    + 		filter_options->sub =3D sub_array;
    + 		filter_options->sub_alloc =3D initial_sub_alloc;
    ++		filter_options->filter_wants =3D sub_array[0].filter_wants;
    + 	}
    + 	filter_options->sub_nr =3D 1;
    + 	filter_options->choice =3D LOFC_COMBINE;
    +@@ list-objects-filter-options.c: void parse_list_objects_filter(
    + 		parse_error =3D gently_parse_list_objects_filter(
    + 			&filter_options->sub[filter_options->sub_nr - 1], arg,
    + 			&errbuf);
    ++		if (!parse_error)
    ++			filter_options->sub[filter_options->sub_nr - 1].filter_wants =3D
    ++				filter_options->filter_wants;
    + 	}
    + 	if (parse_error)
    + 		die("%s", errbuf.buf);
    +
      ## list-objects-filter-options.h ##
     @@ list-objects-filter-options.h: struct list_objects_filter_options {
      	 */
    @@ t/t6113-rev-list-bitmap-filters.sh: test_expect_success 'object:type=
 filter' '
      '
     =20
     +test_expect_success 'object:type filter with --filter-provided' '
    -+	git rev-list --objects --filter=3Dobject:type=3Dtag --filter-provide=
d tag >expect &&
    ++	git rev-list --objects --filter-provided --filter=3Dobject:type=3Dta=
g tag >expect &&
     +	git rev-list --use-bitmap-index \
    -+		     --objects --filter=3Dobject:type=3Dtag --filter-provided tag >=
actual &&
    ++		     --objects --filter-provided --filter=3Dobject:type=3Dtag tag >=
actual &&
     +	test_cmp expect actual &&
     +
    -+	git rev-list --objects --filter=3Dobject:type=3Dcommit --filter-prov=
ided tag >expect &&
    ++	git rev-list --objects --filter-provided --filter=3Dobject:type=3Dco=
mmit tag >expect &&
     +	git rev-list --use-bitmap-index \
    -+		     --objects --filter=3Dobject:type=3Dcommit --filter-provided ta=
g >actual &&
    ++		     --objects --filter-provided --filter=3Dobject:type=3Dcommit ta=
g >actual &&
     +	test_bitmap_traversal expect actual &&
     +
    -+	git rev-list --objects --filter=3Dobject:type=3Dtree --filter-provid=
ed tag >expect &&
    ++	git rev-list --objects --filter-provided --filter=3Dobject:type=3Dtr=
ee tag >expect &&
     +	git rev-list --use-bitmap-index \
    -+		     --objects --filter=3Dobject:type=3Dtree --filter-provided tag =
>actual &&
    ++		     --objects --filter-provided --filter=3Dobject:type=3Dtree tag =
>actual &&
     +	test_bitmap_traversal expect actual &&
     +
    -+	git rev-list --objects --filter=3Dobject:type=3Dblob --filter-provid=
ed tag >expect &&
    ++	git rev-list --objects --filter-provided --filter=3Dobject:type=3Dbl=
ob tag >expect &&
     +	git rev-list --use-bitmap-index \
    -+		     --objects --filter=3Dobject:type=3Dblob --filter-provided tag =
>actual &&
    ++		     --objects --filter-provided --filter=3Dobject:type=3Dblob tag =
>actual &&
     +	test_bitmap_traversal expect actual
     +'
     +
      test_expect_success 'combine filter' '
      	git rev-list --objects --filter=3Dblob:limit=3D1000 --filter=3Dobjec=
t:type=3Dblob tag >expect &&
      	git rev-list --use-bitmap-index \
    +@@ t/t6113-rev-list-bitmap-filters.sh: test_expect_success 'combine fi=
lter' '
    + 	test_bitmap_traversal expect actual
    + '
    +=20
    ++test_expect_success 'combine filter with --filter-provided' '
    ++	git rev-list --objects --filter-provided --filter=3Dblob:limit=3D100=
0 --filter=3Dobject:type=3Dblob tag >expect &&
    ++	git rev-list --use-bitmap-index \
    ++		     --objects --filter-provided --filter=3Dblob:limit=3D1000 --fil=
ter=3Dobject:type=3Dblob tag >actual &&
    ++	test_bitmap_traversal expect actual &&
    ++
    ++	git cat-file --batch-check=3D"%(objecttype) %(objectsize)" <actual >=
objects &&
    ++	while read objecttype objectsize
    ++	do
    ++		test "$objecttype" =3D blob || return 1
    ++		test "$objectsize" -le 1000 || return 1
    ++	done <objects
    ++'
    ++
    + test_done
--=20
2.30.2


--VRRUTDx2s3C9JIjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBPXbEACgkQVbJhu7ck
PpTRfg//VwxC+Vsc5OHYLTe6ngDFB9wqw0eJHLVsXlyqblzpY+MwSKZzMp9Yox+z
s0zAdCKoH98E8RXl9V5i5UBhMNdTzeTGgbll80DLSsEWo7tvE+xLFIiEq/2xhXer
NVw2i0FGBVwBlBKQ7zhgt2gXFwCpp88GBOOmLr9u+tY6FeJjo4+Pf8zuClslpgrC
vahFJuHVUWztihMmBp0yhUgRok5ynWkkmuiHxv6jRqBw15kRWDU8m8m5uLpjxE90
5FYEBD/zSsTqWX5VIQwnlC17oxGg0Q5fWdHo/FwL/MbMvZ8CPi8i1js7/htehWPJ
rDCcnrFfT8vGUZb74BMNAGnJyWLrFZHNvKfYfvSL6PWyq2sl6rw9uSxQaPFdF3rF
9zf51bVPjPDZDa5oHBlwEP6AKlTEgSlASufxopyYEAUwGof3Qb1QBdylK04yhlWP
PEJ/s+/wBZL0+ZWT5hsP1cDLJRX/3/72SlpnIZSSap1yXYyEyhhAv/R/yAtfoIDa
iu5PoWWCE/kJN1pot8GZlSqt/a/CdMz92D785fO1K0TDNhBb+5ManhdxY+jZwD6e
078XccU/97Vc1sdFCM9pJ+8OsaVwR1IHv2NAo++p7yjufdzeWy1YmuCvaT3L5gHV
R0nvdLJFPdTniiEBUb2Z/QZLxzxagxjSnO9J5HKcdmhoLAx36To=
=GUGv
-----END PGP SIGNATURE-----

--VRRUTDx2s3C9JIjY--
