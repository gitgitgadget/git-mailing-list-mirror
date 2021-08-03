Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7B9C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 09:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420EA603E7
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 09:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhHCJQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 05:16:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55607 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234805AbhHCJQx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Aug 2021 05:16:53 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D5A8F5C00D8;
        Tue,  3 Aug 2021 05:16:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 03 Aug 2021 05:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=FZjBheSGR85XSANNgaMLDNhpGQn
        nzdafwIN951AIVoY=; b=k6evN/EVURG3cexkUoB1ERnEVLc2SQjew3x+h0QZ2z8
        P1V1WqMFLsWrczPO8fcIiMsFgdeC/o/KNRNaPHs5UAcLI9PXnii28MRsCo4uYnqJ
        vaapxPjof+8MFhXCaEGeYzXK5DmpTpW7qO1gk7MZzT6r1uECcCuuvDnRzGZVTleC
        CaJPIpFYSvmizpzFYyupF99OF9RCjUsb1tII1duenyb4ein9ZAI7rTP0adDDpqhj
        nJDtCJo02BRC7AIGNg+h5Nrwnkkc/Oaa/HlpiL0rP8kawcPtSten0BMQm53YK3HC
        43lx6E2tw5rojGmzfhKas6yEGUPojls4oM/g30qtZGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FZjBhe
        SGR85XSANNgaMLDNhpGQnnzdafwIN951AIVoY=; b=NvkQE9Ss4255lc5l/bihp0
        ujwJtBIUaOmFvpOPA96TFaXvrRmimqdZNqiVufwRROhcady9r3iNhXZ5bQWHhTSb
        np9rdEgrn2100JynnPXQXtxQu2Bx+qk4z7StZBwDYceR+RrxOVGopsTbcTSRjOr5
        StLclmgzZs3Q69hw4Q1SeT1MwH77IMeFatM6Sl9ek0Bq71TNDX7tG5uAyTIa/V8h
        ALRerppcb9Xvg+qr11cRYcGBoBKIGBpYRljYKPVIiyNXc2jHSpQjwPxTCIKvUZoD
        4r3O6b8Ts30L3TKDqOQQ5Va8POPEF3ryTtI677hmFgfTYNaJ2p1luu0m5Yk8KaQA
        ==
X-ME-Sender: <xms:egkJYeG5d94zg_CXgGHYG1zMl-FEltYRthNc5szqCNZ8hDBm0iRpEA>
    <xme:egkJYfVmXAuRhtzQLyRvIlMYYYAWPl98wijAaL-VHta3O6CyIXIh1TjnuThKgzyJX
    P0YbyUs-VVE2s6xmg>
X-ME-Received: <xmr:egkJYYJMFDLjDRxLGoJce9GtS7RZeqeYmpGbs6VBqI-OMRk0eV-7czta80Lq3Nl_Z4qaivSBdmib1RT4ugYWLhHWeEXTRGvSCr1Z0rp67dvz_2ZZF6fioQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdeffedvhfelheehleeghedtveeiieekffduvedvudetfeffjeffjeelleefvefhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:egkJYYHLHBjlmfdttddUrnG4GWpfFipykMsDzg1y4LvYwGOdpxrz0A>
    <xmx:egkJYUVQSNiJGqcpq85eH2xSnDN0C6ZyTierCudaMU8ecgaYu099Cw>
    <xmx:egkJYbPHamUxK6eD2eES07-tcBu9hLB_I14BU08eG1KwGQH-UVfQ1Q>
    <xmx:egkJYWJZO7HoDwPrLr_mjZhgci03BxTiammTAVfJyo58jo-LApzP_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 05:16:40 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 37a508c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Aug 2021 09:16:37 +0000 (UTC)
Date:   Tue, 3 Aug 2021 11:16:36 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 4/4] revision: avoid hitting packfiles when commits
 are in commit-graph
Message-ID: <YQkJdDvRtyOPzszU@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <f6fc2a5e6d94befa915fb59b6296ce3153820c13.1627896460.git.ps@pks.im>
 <xmqqwnp3vcow.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fl+HNKyGWIRjgBOS"
Content-Disposition: inline
In-Reply-To: <xmqqwnp3vcow.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fl+HNKyGWIRjgBOS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 01:01:03PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > +int find_object_in_graph(struct repository *repo, struct object *objec=
t)
> > +{
> > +	struct commit *commit;
> > +	uint32_t pos;
> > +
> > +	if (object->parsed) {
> > +		if (object->type !=3D OBJ_COMMIT)
> > +			return -1;
> > +		return 0;
>=20
> This is puzzling---at least it is not consistent with what the
> function name says ("please say if you find _this_ object in the
> commit-graph file"---if that is not what this function does, it
> needs a comment before the implementation).
>=20
> The caller had object and we has already been parsed.  If the
> function were "with help from commit-graph, please tell me if you
> can positively say this is a commit", the above is understandable.
> If we know positively that it is not commit, we say "no, it is not a
> commit" (which may be suboptimal---if the caller falls back to
> another codepath, the object will still not be a commit) and if we
> know it is a commit, we can say "yes, it definitely is a commit" and
> the caller can stop there.
>=20
> I guess my only problem with this function is that its name and what
> it does does not align.  If the caller uses it for the real purpose
> of the function I guessed, then the logic itself may be OK.

Fair point. The only caller for now only calls the function if the
object's type is unknown, so it really is "Resolve the commit if it is
one". I'll adjust the function's name.

> >  static int find_commit_in_graph(struct commit *item, struct commit_gra=
ph *g, uint32_t *pos)
> >  {
> >  	uint32_t graph_pos =3D commit_graph_position(item);
> > @@ -871,18 +913,7 @@ static int find_commit_in_graph(struct commit *ite=
m, struct commit_graph *g, uin
> >  		*pos =3D graph_pos;
> >  		return 1;
> >  	} else {
> > -		struct commit_graph *cur_g =3D g;
> > -		uint32_t lex_index;
> > -
> > -		while (cur_g && !bsearch_graph(cur_g, &(item->object.oid), &lex_inde=
x))
> > -			cur_g =3D cur_g->base_graph;
> > -
> > -		if (cur_g) {
> > -			*pos =3D lex_index + cur_g->num_commits_in_base;
> > -			return 1;
> > -		}
> > -
> > -		return 0;
> > +		return find_object_id_in_graph(&item->object.oid, g, pos);
>=20
> And I think this one is a op-op refactoring that does not change the
> behaviour of find_commit_in_graph()?  It might be easier if done in
> a separate preparatory step, but it is small enough.

Will do.

One thing that occurred to me this morning after waking up is that this
commit changes semantics: if we're able to look up the commit via the
commit-graph, then we'll happily consider it to exist in the repository.
But given that we don't hit the object database at all anymore, it may
be that the commit-graph was out of date while the commit got
unreachable and thus pruned. So it may not even exist anymore in the
repository.

I wonder what our stance on this is. I can definitely understand the
angle that this would be a deal breaker given that we now claim commits
exist which don't anymore. On the other hand, we update commit-graphs
via git-gc(1), which makes this scenario a lot less likely nowadays. Is
there any precedent in our codebase where we treat commits part of the
commit-graph as existing? If not, do we want to make that assumption?

Patrick

--fl+HNKyGWIRjgBOS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEJCXMACgkQVbJhu7ck
PpQdtBAAkB6J7EUQ+bmkir+AAyTtcbcpdyzch8cUl/i14lN5fLTsdbF5mFMQJVVk
6b3XhJEiGN7ug7oxTcZlSJZ1v0HxY1wPcziU9e+RfPWuPACdb6zSIsYq8n3rIwuE
kkmg+LgNHkpU+So2WQWlglwy9ArNeG/pyCzs9xIuk6zWJTYmmC3Fhk6+g7C6B5e0
Bqg7P3e3ep8S74H/HbIRYnJvOEAm2cfn+5+WE1xKT35nxpmunnhE8im4WzWHkNHV
moK1MhEhuEfpGxrf2kH3Sm61W/aRqz4WYMO4AC0I+s9UUzeyVrlEJG3LmpEnAFLM
wIhIldp8qmv5DZyJOyA8jVYylAEKstKRQFaA94svu97beDJ9dTYIJLhqJ5Lhhj59
pHrKAMTlzHs3KmDkngN8wE64MF+umrGPtAGXVcmWDamW08kR0Mks4K4ucE+4TNtQ
vo+Og7VAm0vYfuDj4tnX7ZIVZP+XyXSiXU0mVNZsFYluS0oXvEbRTZJWYh7Kl0wM
KlEEPjf/LnnM8YlQe0AUvBtqDqHgxqoK82eGglgW8o85mnul0+tIXSvJjSMgHTrq
Gj9+JYfxrfGTbHS0QGcIiFTHHV2im4r5D9RtEEkq1crHFyhvsX/fZ3psK9HzbA4n
ZMQb4jZwff6X+/+fYq909qLc+Wz0V6TGuGErB5l2XZ8fMq32s5k=
=w50C
-----END PGP SIGNATURE-----

--fl+HNKyGWIRjgBOS--
