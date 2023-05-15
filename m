Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C520C77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 05:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjEOFPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 01:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjEOFPx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 01:15:53 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A6E10D7
        for <git@vger.kernel.org>; Sun, 14 May 2023 22:15:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 78BF65C00DA;
        Mon, 15 May 2023 01:15:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 May 2023 01:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684127747; x=1684214147; bh=6f
        Tg3lel1M+x+cTORlOcnHcsLDa2wVHnsZCTqO5gZ4M=; b=e37GRmylzhwXrdgmTe
        kBY59jG6hEaG7i2WKMUvsPF2Dhb7fa529Icu5N0C1FUPiEOhmFBa3jQTR+DFv3as
        2ltgLrBQlv/x43mp0eVbehcU/kGE2xpvfcsDsXkSuMd2AmzwHQQ41Vz7O1t4cClw
        ZtY1Y/TmNcLNPz9qsVjsGo54bUchfHnxueTFKfWY5NaQIG2NvrAelw+IGuCGidSQ
        UQCbtz6LeI/Fh7zle1EjnEUIjyCAeF1kwl9rIfG1fwSzIisQS8vRpp4lwzEXmOM9
        bfYxeNqF8rfB84cw9ikHh8GPGGxPetl72FHDBZwPhpYwXHg5JjqpU85c2lOYHvxe
        f7Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684127747; x=1684214147; bh=6fTg3lel1M+x+
        cTORlOcnHcsLDa2wVHnsZCTqO5gZ4M=; b=w+gdEFjMS3VMu5rOJkyJmUHh4FpoG
        aHC5ZsqnzEMu41deZMgK0VXS0pPk1CxkCmzfEvjT7hiJE4KwJbXblmi9yVMDUyrX
        Hytxyiy/Y8z3hkGxzaY5KNg4xs/qqSdYwcYRtNbe1IVNdCxnNPXl1PuW5rSRl1eg
        XqG1dGhpo8e/cRDOmBAgMCwyj4a8nqGfvlg4y8Dtavrg+ayH29gIkSXDAkylfscO
        j8lFyihDmbePeyfAA965JWYtmks06GteEPZVVz7iM8ROJEZALp0sLA98pj7LcDyv
        2SOuFQzyduGz77aUhd84JC6f8Ta2OcOomytKS2R+FsLE7N24r3lY6AEzQ==
X-ME-Sender: <xms:A8BhZCUL9Y9WqA_HQV_MbfwgYo09_FEAhAOI_WNmA8b_C-NHwb6d1g>
    <xme:A8BhZOkYaxfHU8jR0XnpaBXbYQo9k8nMeL5I5HUv8ONtE9YDIxV6bIgTb3--D9AnJ
    ppVH0HkaelnKNbA6A>
X-ME-Received: <xmr:A8BhZGZJJy1CBxhPG8fuO_snu5syKZPVPvnNbXogRKFe-Pd2oLMhvjHyKttgh7kGzSqqir69y9StgWRwGktzdwova5qshpEwOv0V0M25GBQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehiedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:A8BhZJVQl-iO0pOFtwaVWfMflViC6UeT1QDIK4OJcgeju61F5NukSg>
    <xmx:A8BhZMnxcrZjXKe2eJyR1zX7hqQZIiRDkxt4-RxDn1g1pt3m61zX-g>
    <xmx:A8BhZOckXqjq_qnzX_2kRxLdkeMBEzOJNKj4_jpeVbvs20qFqo5-bQ>
    <xmx:A8BhZLvtnqj6US9eih94liDBjg2rJnGbcFHwfWdmkbptYOdfX13v8w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 01:15:45 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id cb5224e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 May 2023 05:15:23 +0000 (UTC)
Date:   Mon, 15 May 2023 07:15:39 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 4/9] fetch: print left-hand side when fetching HEAD:foo
Message-ID: <ZGG_-7eD9TDanpjP@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
 <2cc7318697ef6062f6deadf7a22feb26c2c829e8.1683721293.git.ps@pks.im>
 <20230513165925.GA113985@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYZDHEhqcvm1B0Ft"
Content-Disposition: inline
In-Reply-To: <20230513165925.GA113985@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TYZDHEhqcvm1B0Ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 13, 2023 at 12:59:25PM -0400, Jeff King wrote:
> On Wed, May 10, 2023 at 02:34:15PM +0200, Patrick Steinhardt wrote:
>=20
> > @@ -946,7 +948,7 @@ static int update_local_ref(struct ref *ref,
> >  	if (oideq(&ref->old_oid, &ref->new_oid)) {
> >  		if (verbosity > 0)
> >  			display_ref_update(display_state, '=3D', _("[up to date]"), NULL,
> > -					   remote, ref->name, summary_width);
> > +					   remote_ref->name, ref->name, summary_width);
> >  		return 0;
> >  	}
>=20
> Here (and in other hunks) we now dereference remote_ref unconditionally.
> But in existing parts of the code, we guard against remote_ref being
> NULL. E.g., later on:
>=20
>           if (!current || !updated) {
>                   const char *msg;
>                   const char *what;
>                   int r;
>                   /*
>                    * Nicely describe the new ref we're fetching.
>                    * Base this on the remote's ref name, as it's
>                    * more likely to follow a standard layout.
>                    */
>                   const char *name =3D remote_ref ? remote_ref->name : "";
> 		  [...]
>=20
> I'm not sure if the old code was being overly defensive, or if the new
> code is ripe for a segfault. But it's probably worth looking into (it
> was noticed by Coverity).
>=20
> Looking at the caller, it is always store_update_refs() which passes its
> own "rm", a pointer iterating over ref_map. And it should always be
> non-NULL, since that's the loop condition.
>=20
> So I think your code is fine, but you might want to double-check my
> logic. (And it may be worth cleaning up the existing redundant check to
> prevent confusion).

I really think that the code is overly defensive. As you mention, there
is a single caller of `update_local_ref()`, only, and that caller
already dereferences the remote reference unconditionally anyway. So if
there was any way for `rm` to become `NULL` we'd already have a segfault
earlier than in `update_local_ref()`.

I'll send a follow-up patch series after the dust has settled that
removes the check.

Thanks!

Patrick

--TYZDHEhqcvm1B0Ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRhv/oACgkQVbJhu7ck
PpS9IQ//XIR4m2mvIcHvDk7p/CzMlCldbYXfxmd816tkrLILRCX4zKWs5v6CVEOO
Es8aSZu6JoidEOPNTIO5il3S/CQSIgXGidLqWnJq+dHr07KxPEvJ5ekmgUty/2DR
L2vJa78QKh03m7264XsvftsjzIrBz8WvwRnf+kMFiLjdPm6URZ+X6hu1Va6oMToQ
ivDs51GdfQVrvFvR66c46CDN064qmM9PokFVUYfdt9/dgh7geZhtdyn/Hiy1bT2u
egTTOhVkNKSJ/WtBxHdzJSoaNkHHg20bMC6Tl1WdCLGKvhA8klhLOSWfL0MgEPVk
rLHpGB/pROf8eG6DPnnS7bx7Jm+GDdiWH9wpGYtMi64CRO7hEa1ejBpxdeCDvut6
oAJd+FgGi8cZZfWsl7SWHkbhj4Fibz7BGuvZAagLuWpAYGJk3FPD+KPxXYeP1yDT
WYrJdVsrO3JfcY5mBMEcS191rci4ufSc78peKJKrDm8Key6Hj04XkaRxnpo5pm/b
y0gvonXlutyZRK/pCXv/4IkOqGZluY6Wb4nUB1eECMuyaiJ+TNoKQ7iWCIMfOz41
HGwrVS5pTAbmwdkedoaFZJmYIuXRrnX6JrQzXkz0eUgTcV8KER9RuSN9wOcnm4OQ
hjyVVMGaTKKaE2vJrqYpZQ5DyINK5pnJ2UdHZ/tUk6YhjpkVmO4=
=o4QA
-----END PGP SIGNATURE-----

--TYZDHEhqcvm1B0Ft--
