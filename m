Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18849C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F6461029
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 08:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhHCIzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:55:33 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53743 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234603AbhHCIzc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Aug 2021 04:55:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C28AA5C012A;
        Tue,  3 Aug 2021 04:55:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Aug 2021 04:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=jnHuSTxYMJjSVjBgtE5k7/XY/Fa
        alL8XNolG8g7mbe8=; b=tSGTQvYCzDX5U6Iq54o5JHH4pivE6l67u8Q33+3wJ5F
        ZheVueVY0EIgMPUX0fTvZsow/4X9YW4dzCxVGz5CwkpTYssLPK+zyworLMmnZyJc
        1IvdL2+Ahbq6FjNZH58jmn3kuF8CqKLWU3IGB7Rxkfwf4U+1qaV67jdCsxKNuyKI
        TVoP9shB/bUvDcICWFGjmzDgLxVDbb+mtmzCXxN6H9xuvF+uZh5HnBST18epYrAO
        g4GBu77cPXvLyyvtiTRvzsRB0iaCvL0de0K3a0Td5yICPCiQEYReeTKSclDwdLFW
        axBH9TLBAd45jnf0kywrZMRKlsM1S6tx8uFtyE89oIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jnHuST
        xYMJjSVjBgtE5k7/XY/FaalL8XNolG8g7mbe8=; b=wrTWl8p7bQYwUv4pc/MPjq
        H+ojwCq74qvRqe/jcmxjly0FrwcqoXTovqK4Ey+A7YVmE9loGcWO5x6mIgOBrtPy
        puHPN+8HFTUbozppWfMBBAkdcjeJOFi0xIAE7W3/WXL2gFdbqKn2EHX1x/6IjXHw
        8CGiPBFv54yjSxA8KoDaCfBekv88TGsy+PAO93Hn+ITiW8v0rclM9VQ/r5I42c6I
        yXDq0pGkZB4xmpZ7ii3YtpDuj1zydGxMQVWLe43qVpRnhfgscMyFxgoErk3nVPI7
        nTqbs6/lTcIA15Y/EXitylWrPHRTWV3/VaZGeMSimbC0nM+swguAbgfr6OMlvJWw
        ==
X-ME-Sender: <xms:eQQJYb1wx-_Oe8aWcDl_ZbZ6D_-VYGOyMJWGLxG8jJ8NrT4XdHyiFQ>
    <xme:eQQJYaHqZmObhFMxWm8AaUxgFR3xS36-var0ibo_WGpuV7FBYsaAF3WYlZ7ZUXP79
    0q-jAxL6ouOY0tPCA>
X-ME-Received: <xmr:eQQJYb7kaqu5eaDTFx3HqfhTf0xSVZVeI2vwGEo2TrV6mJ1wBPsNbjIagHSGoAOYAP9GcewCufPJjxEOs-QnsmCl_jqnQy-KhV6PT0DCflOSqz-l07mtmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeejtdeigfegkefgjeehveevjeejveeuvddtieekffevleeglefhgffgjeejfeefnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:eQQJYQ2FEe5Gq2IWHgOLvNpwQzj9H9MSHiqaBUulVeoy7W6NSRs2sQ>
    <xmx:eQQJYeEYP0W1N48djeNlwXMm5TC0ul2njQ4ufX4camigVbh5JKutkA>
    <xmx:eQQJYR9airpAaLWc92M7OI0GKCVkMi7QHJwunZ1z7PFAlRryAQQgAg>
    <xmx:eQQJYT5_lhGFEHpNl_0DdArc9mjdUBG2iGByxviSdH_1EVNgKCDKWA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:55:20 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id acce20b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Aug 2021 08:55:18 +0000 (UTC)
Date:   Tue, 3 Aug 2021 10:55:17 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/4] connected: do not sort input revisions
Message-ID: <YQkEdYi/7vrS9ydC@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <1fd83f726a04dfb5be27c74cb116618cb76be923.1627896460.git.ps@pks.im>
 <xmqqa6lzwu31.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HLw6RDomtUPJeaNG"
Content-Disposition: inline
In-Reply-To: <xmqqa6lzwu31.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HLw6RDomtUPJeaNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 12:00:02PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > Introduce a new "--unsorted-input" flag to git-rev-list(1) which will
> > cause it to not sort the commits and adjust the connectivity check to
> > always pass the flag. This results in the following speedups, executed
> > in a clone of gitlab-org/gitlab [1]:
> > ...
> > [1]: https://gitlab.com/gitlab-org/gitlab.git. Note that not all refs
> >      are visible to clients.
>=20
> So is this the 2.2 million refs thing?

Yeah, it is. The repo itself got 2.2 million refs, even though only 800k
are publicly visible. It got even more when one considers its alternate,
where it grows to 3.4 million in total.

> > @@ -3584,7 +3586,7 @@ int prepare_revision_walk(struct rev_info *revs)
> > =20
> >  	if (!revs->reflog_info)
> >  		prepare_to_use_bloom_filter(revs);
> > -	if (revs->no_walk !=3D REVISION_WALK_NO_WALK_UNSORTED)
> > +	if (revs->no_walk !=3D REVISION_WALK_NO_WALK_UNSORTED && !revs->unsor=
ted_input)
> >  		commit_list_sort_by_date(&revs->commits);
>=20
> Looks quite straight-forward.
>=20
> I however suspect that in the longer term it may be cleaner to get
> rid of REVSISION_WALK_NO_WALK_UNSORTED if we do this.  The knob that
> controls if we sort the initial traversal tips and the knob that
> controls if we walk from these tips used to be tied to --no-walk
> only because ca92e59e30b wanted to affect only no-walk case, but
> with your new finding, it clearly is not limited to the no-walk case
> to want to avoid sorting.

Right. The question also is what to do when the user calls `git rev-list
--no-walk=3Dsorted --unsorted-input`. Do we sort? Don't we? Should we mark
these options as incompatible with each other and bail out? I guess just
bailing out would be the easiest solution for now.

Patrick

--HLw6RDomtUPJeaNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEJBHQACgkQVbJhu7ck
PpQz+w//fl+Y5277jUuh2mt3jdv5PT51+/AX2+kSwyMspoK6yY5DAkOOAtvNx2U+
sAnPpp31wt09lYF7uju/6s7On5mk1gLsqR4Fr/f4/gQFcn645x4J1/ivYf1Q8PfJ
uYnqQTKzEvLZJU3HgIAb/5D5ryyppd/4KaSv73e9Ko2pcOPfDCrtNvefuXeM9XvC
lOmq42/Va9mfwLI8uIaZ9PsoA/68SMjhGZWpRfYa21HRTLlwxTVY58bYZrAJb8RX
x3tZv5INTtD/+mKTSoATr6M8TXYkJq+BHWNGEhtUjFDuFWx19fGop/chti5beSuP
Zy0CjP3INXgOin19uDb1hAV855iRrxjOZDHZSnviNj0hWqBPdhmIL5fwPxBzi8ah
u+49U5P8sTHnBsvxVromGvjHk0ahCniRN1iyxbHby713bSkVTCWo2lGw8+DPa/6w
BSEUY+Q0a3AT3zgQFUg/Qm7F2VMi/9GPnsdz3MkQj0HyO0CnETLQnfIEWuOSvUMN
IBTMhv3lPG1inuHFYsuAz8QGbP9BH4Ye3i4TnRHCF0XggwckVQ5/OGU683FNmOc0
QKNuXwQRI0v6IuvHmyoaXfSlNO8llgZ3g8m0/TRMb+jTR1/+wM8IatOFsaRw6GEg
s5DlLPRkfeadCzaQJH8ljT8suR8sHQQS8RFx0gyNQuS/lqH98FE=
=IZG4
-----END PGP SIGNATURE-----

--HLw6RDomtUPJeaNG--
