Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D6C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DB8610E5
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 10:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhDILAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:00:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51055 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233749AbhDIK77 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 06:59:59 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F20055C0135;
        Fri,  9 Apr 2021 06:59:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 06:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DlVNzeUx09dfeZVDfIAfdOxNir4
        FYPy4uVsfoX3tq1k=; b=xHNNAfko+dYgxii379ZyneadSvotMbOSXga03fM9kRp
        hgfFgVLB43w/tE/1k80cG2EeiUD9LcoEXJzWnGO00jdgTpVwxfc9P9t2DRai8Aup
        m3UN6MYGgeMJNewAmxm/wIgZ5iQFfpvykeuNqXPRpFCGRz40Py3fYZ0GhUbK15sh
        YRB1PaQ1BFJmAkZj/ptm/iU2d9Yyq8yo14Quz9XUonVkNw/DnZanEk9xU8zLRP5q
        2/YsmnEk0VHKxewuzK2gG6IjeBBNdgPZ0wilPYYLP38EIL6fhiGOePdthHBTs1fg
        rkU9q7qNqD9Nd2kVcvqS8ZQJuUZ5h9/Shisfe1frJlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DlVNze
        Ux09dfeZVDfIAfdOxNir4FYPy4uVsfoX3tq1k=; b=YnblMw7CZFxcYibrC4pPnn
        O75THJvUS6xYWh+XZ4CxrPo7vtuCpHeOiVbdKYs+uG/l8D+lqQPJ7T1PeDF3NhoB
        sfKflTQkEV4L87mlGn4eGbWzbUCnR0Lzl7V6mckMse0fG4fpZuTfvgPg/PDI6TZv
        AU7NZVam5Cpp6M9FopslNpyJEH+gkIB0gbgCz5vE/KAi9Y6uLccfm5JaexmkZU4j
        RPcdw5LT8l3pB51D2cZ1Hsr+wHhFReXJiM1x1DEDvNRYDIs0DmvKcQIr88CLGAzU
        NylJmgM/ppW6eXb1iUNpykFdroicMcY2ibmpPt7kXx9e4F+G0OYgtm98Qs+Wl5kQ
        ==
X-ME-Sender: <xms:oDNwYGY2iWWRI3ly11A2o4fy2izYhf3K26jEqDd8CYi9SiowJrJkiA>
    <xme:oDNwYJbpSWST6QRHKThqbb0ghwIPQCzQHK0dyRcBz3-xwP6YB3Uby_lAA_BI3Drbg
    uURKIU4dFAoUOVlZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgfeejuefgheegueeljeffteefuedthfdvvedugfevvdffleduueeiiefgvedtheen
    ucffohhmrghinhepphgvnhguihhnghdrnhhrnecukfhppeejjedrudeluddrkedrudeile
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:oDNwYA-R_XxNmu7bk0yGjgiQ91Y_Tsg7wa-ictAf9dAgkYmnsLxWxg>
    <xmx:oDNwYIqpAQloF_Fe6YeWbc2p3VYGWTF1WcKzhJhpSO9PjLpsWiHOQQ>
    <xmx:oDNwYBrwgoceS59H0AZFzswKRWe0oDSj4MEjkV3ykI0dEhHKjc7ypA>
    <xmx:oTNwYCCczIOfbIkhJq0WcYtupqOf4lLqg4O-NgM9kSQdI4ql-vsRJQ>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id D9AEE240057;
        Fri,  9 Apr 2021 06:59:43 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4170bdfe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 10:59:42 +0000 (UTC)
Date:   Fri, 9 Apr 2021 12:59:41 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 8/8] rev-list: allow filtering of provided items
Message-ID: <YHAznTddwG/ej4aS@ncase>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <0e26fee8b31e46e87fb9fa1ac599506502a9d622.1615813673.git.ps@pks.im>
 <YGyinyL2UU421hoX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IVpENzOGWawT/Osv"
Content-Disposition: inline
In-Reply-To: <YGyinyL2UU421hoX@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IVpENzOGWawT/Osv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 02:04:15PM -0400, Jeff King wrote:
> On Mon, Mar 15, 2021 at 02:15:05PM +0100, Patrick Steinhardt wrote:
>=20
> > When providing an object filter, it is currently impossible to also
> > filter provided items. E.g. when executing `git rev-list HEAD` , the
> > commit this reference points to will be treated as user-provided and is
> > thus excluded from the filtering mechanism. This makes it harder than
> > necessary to properly use the new `--filter=3Dobject:type` filter given
> > that even if the user wants to only see blobs, he'll still see commits
> > of provided references.
> >=20
> > Improve this by introducing a new `--filter-provided` option to the
> > git-rev-parse(1) command. If given, then all user-provided references
> > will be subject to filtering.
>=20
> I think this option is a good thing to have.
>=20
> The name seems a little confusing to me, as I can read is as both
> "please filter the provided objects" and "a filter has been provided".
> I guess "--filter-print-provided" would be more clear. And also the
> default, so you'd want "--no-filter-print-provided". That's kind of
> clunky, though. Maybe "--filter-omit-provided"?

Hum, "--filter-omit-provided" doesn't sound good to me, either. Omit to
me sounds like it'd omit filtering provided items, but we're doing
the reverse thing.

How about "--filter-provided-revisions"? Verbose, but at least it cannot
be confused with a filter being provided.

> > @@ -694,6 +698,16 @@ int cmd_rev_list(int argc, const char **argv, cons=
t char *prefix)
> >  			return show_bisect_vars(&info, reaches, all);
> >  	}
> > =20
> > +	if (filter_options.filter_wants) {
> > +		struct commit_list *c;
> > +		for (i =3D 0; i < revs.pending.nr; i++) {
> > +			struct object_array_entry *pending =3D revs.pending.objects + i;
> > +			pending->item->flags |=3D NOT_USER_GIVEN;
> > +		}
> > +		for (c =3D revs.commits; c; c =3D c->next)
> > +			c->item->object.flags |=3D NOT_USER_GIVEN;
> > +	}
>=20
> You store the flag inside the filter_options struct, which implies to me
> that it's something that could be applied per-filter (at least in
> theory; the command line option doesn't allow us to distinguish).
>=20
> But here you treat it as a global flag that munges the NOT_USER_GIVEN
> flags. Given that it's inside the filter_options struct, and that you
> propagate it via transform_to_combine_type(), I'd have expected the LOFC
> code to look at the flag and decide to ignore the whole user-given
> concept completely.
>=20
> To be clear, I don't mind at all having it as a global that applies to
> all filters. I don't think the flexibility buys us anything. But since
> it only applies to rev-list, why not just make it a global option within
> rev-list?
[snip]

Fair point. This probably stems from the confusion where I initially
didn't realize that the filter_options is not a "global" options
structure, but in fact the filter itself already. That's also why there
had been the initial bug where converting filter options into a combined
filter led to `filter_wants` being dropped.

In any case, the resulting code with it being global to rev-list.c
instead of part of the options is a lot cleaner.

Patrick

--IVpENzOGWawT/Osv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwM5wACgkQVbJhu7ck
PpRIig//Y8TMUTxwuwvPnrfP6yIK3MSuNXKDMCaF9x9gmEXNqw4rIFDS1dpC8GMA
PzEFzPAanlhnydkbUy9CnsfD3SQIONbjihUnYGlEXruN3tg8MeyB2+hHAXRYNMwA
8NG0vHQQOfm/ErkpXUcR/IFUUCKH5H43y5nKgriNK5GkSHUaC1OnbhW+mj5x2j9E
13ZRyXJNgL2OPRsEKdthZuw2Wd/yt5e4XF0YgsOUSlVl1fE7RwIYd+pDGUtHiAz5
r9moVg2ruWzpJXgo/eFqWW92gs1GsgvyvoJzJ1EizfdCJw3l4iKTJqaLUOuqJbBT
+91kvCIlamGTsHBCy+tPN+1cRbtdwJ8bO6ItT8oXad5bTcLa6JvGS2PFtPqFZWjL
8DUzxQJuuE4FcneEXSxWSfKkvb6kaGdEYDLIGcXB6+UkP3V+4jQDlWms4Ou/Io9s
lPwUrh9VHycLz02uSPv0Wyu1Yd+6/n4RaTU1/l71n9i6UpDc2v0HvZ6YpWq8nXjh
3lK7i+HcAdBc8FbfnOLjvxcgQwL3x0I9JmFb0Zpt7sjn9T9SfBpuOBsHEnQGqI2A
O03oqZn7mUBI4aV7+L4/lPK2WslNMxOwgd51tR6sPNFAX/gCggqRqA+Pr+bTQJeQ
csIsJDpVNuxy7KeHMg/wSgRLDZM+1RYLPx5KT3Rc9Xrr1MSl9Rg=
=9Pi6
-----END PGP SIGNATURE-----

--IVpENzOGWawT/Osv--
