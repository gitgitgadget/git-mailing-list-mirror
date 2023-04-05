Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F40C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 10:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjDEKQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDEKQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 06:16:03 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874E2135
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 03:16:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4F6BB320027A;
        Wed,  5 Apr 2023 06:16:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 Apr 2023 06:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680689760; x=1680776160; bh=8f
        hd7/L8vgKrWLECcDBFcu4WohIF2doRiRZ4nu1fpDY=; b=bX34uVTb1u2kk/8foF
        N0rRYy2GxMHgwHk7DzHCz2tcvk7WeHsHw7XMfFOcwSrXaCMx+02i487xvenGjS1w
        jRYT4w/+2LdDF0pDnJmeIpsmgRyeqCKVWO5BlnMYksQHKDEyuBiEnOrSwP03u21D
        ed95FUx2kmGeX9fLOCyIZFbvGxWPEQ/o08y4ml4wR5fOUoSQ5GalEjKcIXUcoKmB
        cDRG07Ty89OLVHyVl8LgX0MWLPJQqF6bExcZ7yPiT0VW+p+oGU9D8OFUqXN5Tr2y
        3f08ds4bUAtHB1Ua/jXKTRM+U7QOMCq7EJkLGoDFtkMPyPWCLNGtqSkUH9wpidsv
        G9ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680689760; x=1680776160; bh=8fhd7/L8vgKrW
        LECcDBFcu4WohIF2doRiRZ4nu1fpDY=; b=ZI3FfaucA+Gtnj2pZLAhyxH4OudkW
        TE25SYTTyjodjQfcwXWuOoF3OjmiFoqB+g1mt/qbUeowItshQPVVhwW6mUYeXIlP
        CGnYxKPEjpYipxW4Y/cTnM531uIq/3Tw+PPcJPnDnUbIet1oQs0c6AAEYstjwlSs
        3KDcMvIju1Dro21TTBiCv9t/aDaETyg4czWSB0ZJsdFEDYXfyWVdT+B03suIf6fZ
        /UmUbWfb/sMVe8SOMs//69pVl+JJGWTRYNdktnxDBm10Owj6XYz5sRFii/R9b5hL
        8/VZXMRR02Omw6DiAUhnfNhQtVTKJ+0WGqaFN1rxBwy1camv4REtmh9pQ==
X-ME-Sender: <xms:YEotZGeFnxEwE9fIGIEtCz9Y2gPGRQY-IjOGnMhX0IEmwJ3oW3FQIw>
    <xme:YEotZANzsGeXvKqADY3gHu5mN5gCSq4FeatdcUR3CDcaTxzaszcV0bDiSPmo5213Z
    rPd20S48t5PFHGRrw>
X-ME-Received: <xmr:YEotZHgCmkVx0PTmijwjssPTfSEJOMjK_z-pw-2lVrgB3xH_9ZFf2Z80r8Q5fa4Hl4vN1TFpJhdcQL-TNLnRorZikAG4_LX76KkH58KDsGlh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepfedvleefueetgeeitdekheelffekkefgffduhfduvdefffdtheekiefhkeejkeeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YEotZD9JTpzHUrdJHf7lDj2Fwu894kFQiNajXQedjLJ_vZUNkGG_QQ>
    <xmx:YEotZCuOe0ecHLyH39H6E5ajXVTXD3YYK-YSN2uae20YKgXCgvb-yg>
    <xmx:YEotZKHG4Ev_0XH15aZLikMJpqSy7I5pzQwWHXFtbTmyJImh1z-47Q>
    <xmx:YEotZEJovhYDfed9391Bj3Snl5kC-D3E9P21LHIw_Ija8q6BfvN5-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 06:15:59 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 9f3b8993 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 5 Apr 2023 10:15:50 +0000 (UTC)
Date:   Wed, 5 Apr 2023 12:15:55 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Daniel =?iso-8859-1?Q?Mart=ED?= <mvdan@mvdan.cc>
Subject: Re: [PATCH 1/2] Add fetch.updateHead option
Message-ID: <ZC1KW3oN1JgrvTfn@ncase>
References: <20230405012742.2452208-1-felipe.contreras@gmail.com>
 <20230405012742.2452208-2-felipe.contreras@gmail.com>
 <230405.86fs9evfte.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JpCMTEfuyW7O0F6J"
Content-Disposition: inline
In-Reply-To: <230405.86fs9evfte.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JpCMTEfuyW7O0F6J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 11:16:12AM +0200, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
> On Tue, Apr 04 2023, Felipe Contreras wrote:
[snip]
> > @@ -1579,6 +1584,47 @@ static int backfill_tags(struct transport *trans=
port,
> >  	return retcode;
> >  }
> > =20
> > +static void update_head(int config, const struct ref *head, const stru=
ct remote *remote)
>=20
> Here you pass a "const struct remote".
>=20
> > +{
> > +	char *ref, *target;
> > +	const char *r;
> > +	int flags;
> > +
> > +	if (!head || !head->symref || !remote)
> > +		return;
> > +
> > +	ref =3D apply_refspecs((struct refspec *)&remote->fetch, "refs/heads/=
HEAD");
> > +	target =3D apply_refspecs((struct refspec *)&remote->fetch, head->sym=
ref);
>=20
> But here we end up with this cast, as it's not const after all, we're
> modifying it.
>=20
> I think this sort of thing makes the code harder to read & reason about,
> and adds cast verbosity.
>=20
> If you want to clearly communicate that the "remote->name" and
> "remote->mirror" you're using are "const" I think a better way to do
> this is to pass those as explicit parameters to this new static helper
> function, and then just pass a "struct refspec *fetch_rs" directly.

I think the underlying problem is that `apply_refspecs()` and
transitively called functions expect the argument to be non-const even
though they never modify it.

So maybe the proper way to handle this would be to add a preparatory
patch that constifies the parameter. Something like what I've attached
to the end of this mail.

Patrick

-- >8 --

diff --git a/remote.c b/remote.c
index b04e5da338..1752c391c3 100644
--- a/remote.c
+++ b/remote.c
@@ -851,7 +851,7 @@ static int refspec_match(const struct refspec_item *ref=
spec,
 	return !strcmp(refspec->src, name);
 }
=20
-int omit_name_by_refspec(const char *name, struct refspec *rs)
+int omit_name_by_refspec(const char *name, const struct refspec *rs)
 {
 	int i;
=20
@@ -880,7 +880,7 @@ struct ref *apply_negative_refspecs(struct ref *ref_map=
, struct refspec *rs)
 	return ref_map;
 }
=20
-static int query_matches_negative_refspec(struct refspec *rs, struct refsp=
ec_item *query)
+static int query_matches_negative_refspec(const struct refspec *rs, struct=
 refspec_item *query)
 {
 	int i, matched_negative =3D 0;
 	int find_src =3D !query->src;
@@ -968,7 +968,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	}
 }
=20
-int query_refspecs(struct refspec *rs, struct refspec_item *query)
+int query_refspecs(const struct refspec *rs, struct refspec_item *query)
 {
 	int i;
 	int find_src =3D !query->src;
@@ -1002,7 +1002,7 @@ int query_refspecs(struct refspec *rs, struct refspec=
_item *query)
 	return -1;
 }
=20
-char *apply_refspecs(struct refspec *rs, const char *name)
+char *apply_refspecs(const struct refspec *rs, const char *name)
 {
 	struct refspec_item query;
=20
diff --git a/remote.h b/remote.h
index 5b38ee20b8..cd3c1439ab 100644
--- a/remote.h
+++ b/remote.h
@@ -253,7 +253,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);
  * Check whether a name matches any negative refspec in rs. Returns 1 if t=
he
  * name matches at least one negative refspec, and 0 otherwise.
  */
-int omit_name_by_refspec(const char *name, struct refspec *rs);
+int omit_name_by_refspec(const char *name, const struct refspec *rs);
=20
 /*
  * Remove all entries in the input list which match any negative refspec in
@@ -261,8 +261,8 @@ int omit_name_by_refspec(const char *name, struct refsp=
ec *rs);
  */
 struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *r=
s);
=20
-int query_refspecs(struct refspec *rs, struct refspec_item *query);
-char *apply_refspecs(struct refspec *rs, const char *name);
+int query_refspecs(const struct refspec *rs, struct refspec_item *query);
+char *apply_refspecs(const struct refspec *rs, const char *name);
=20
 int check_push_refs(struct ref *src, struct refspec *rs);
 int match_push_refs(struct ref *src, struct ref **dst,


--JpCMTEfuyW7O0F6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQtSloACgkQVbJhu7ck
PpRFnBAAjiyFuXwG/d77IQLh7T1iqT7wPh3SEqetSBOw+AshDDclWndbC/DtNGm8
1ees1xjyxc3TWzF4VoPHw5ioOv/y0rrfta61ftl9/2CuDVRNvdisTDzCkKqU2OMn
I5MWTTOf3Qp8PmK+b5zqOlQplVxcs6dl0j5DUYUjE6R9RALxjWxj501nsiJD7jwZ
RmuvjucW2L9HE8PuOZiyZbA4vffrrLSX87LHOlbBj3uwvbQrU7AiYH+hAjlXsJcL
wETX3SAwMEs7gHL35HTWNd4hC3/HouJFwxNMhGc0kAME5Bxk5jWlJ7R/v5MI3Yv0
9q9NBFcx6kPYAvHxmO6dlKmfgLu16Ul7KDkROnHS7LJohQS2iBlqH3M8PAx9MQAB
33Foh2rawNCbD7KUg8UA0wNJEp/JJSAccBRDn5rF7TTjcvb2rGvPtempjCzSSO4T
97FZRZYAXQRW9rPeFxvj5WLf1ZiA0Qf1TwfHPB8V8HTE3IKrSoXYAGe7SF6vUKLj
ExtoSYjA1XZjRSUD14xHbo/Bl8UiT09GBj9ZZi+evocO/CH7HVuMfh/eRaywJ4oU
g+cTR3upf1Eq54apQ17lQdlYU39NrqaE6PRbGGgO9zpkk69kDhJJWcgwv0/hCbus
pSwN+8QTj0pnn+V9foE19hvMtANTUVUcr5pqxpW2KvPTQZgGY3Y=
=1kKk
-----END PGP SIGNATURE-----

--JpCMTEfuyW7O0F6J--
