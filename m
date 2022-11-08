Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A036C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 09:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiKHJLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiKHJLs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 04:11:48 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA861C115
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 01:11:47 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BEB8D5C0120;
        Tue,  8 Nov 2022 04:11:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 08 Nov 2022 04:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667898704; x=1667985104; bh=FSpmqY4Tv8
        3EsadgPosbyAtQUlZYBO13sYWuvXKoYuk=; b=H7V+b7c6gSZUucSPTkNog3U/HE
        js54XoCeRIQbXs5gU63+S+F1OqKLJkxIMZDuABdVqB9YpN0fD+imKw4HaeFEG8h5
        ZaVP9UcB54CiecPY4Uwvp9aWpAs/WZuSBTqsYQVDq1qcVdtSlPMyWGaLeQBKzbY2
        dDfu+7EA2ufs5q4iOlKEK3iEPa72yOcrODuEvq+9dRV5faWIvhbOA4Eays8hSyHX
        /IQrda4+1kQq6pT+cyLbvv8Q2Z+XZTx2EwT6AFtj51yMAQgSyX3zTtjedluZ/4tc
        kL0dleOTSJJVDdCqUH9rHRMGDOLzsacsLafgpw8X6CaWum59uviovK/TQ+gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667898704; x=1667985104; bh=FSpmqY4Tv83EsadgPosbyAtQUlZY
        BO13sYWuvXKoYuk=; b=gWCjhVVN3/ZX5JK9E3mwxDNBkSD/6HQKZhaWxQe3UfZK
        qEcKetLm6mbUkpj413krq1l5ksI9S7Xdg1PpPu+G8Wsyglvh7M2UWwxyuEYAZ5i9
        YIbl1GshB21VXEblWr12/vaeov2ndfUGa2yYOKHM/BQ04habYPrgi/JtNcPBzkrO
        NdcTWrFZT6izfZaE5DKZuhYqvlG1+T2lAwfSjmin/tHnrhrJB9D3g6GZkgybK5EB
        vzeMevU7wKdWTt0jC1+hibDisU/fYNrRe7SZHbhrl323SbhXkXTmcCipDeYEjLou
        LVqbwj/9UFj7FEjf8uZiUguGrMXTNuh0WskyTEZUyA==
X-ME-Sender: <xms:UB1qY65ZA0lNSbeDEuBEEYMJf0FdhKDD_fUewCND789IFrJxwQ_2Gw>
    <xme:UB1qYz6fXfFzpV1Wm-MOQue4VtFYijHQpDwg737tZclN-J0V1yu1WkNVewrvm2yyU
    4RCfCyvIVDOX4hslA>
X-ME-Received: <xmr:UB1qY5fZdmqdjUFwrsY6rsJv2mxJosY8PFia7ZeW6uof1ghggU9-Rg8agPEGMRMCgsMHy8p9UWXZYo-d9YRB6Fu8AjX6F0i2uPkZFaExMS74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekkefgff
    duhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:UB1qY3K7L-qQM99jdezwab8SxPpnTGGePsV-78jTIBt2iR_KwWfHZQ>
    <xmx:UB1qY-L_Fn4xD6L33zyGy1yGPU8fO_ZcgSt7mjtD2WY0dwm_JiyXYA>
    <xmx:UB1qY4yb7rrWGYWvtBMyE8d0ujeAVgEP_TLRpbwlI8Mc3t_Wan-ghA>
    <xmx:UB1qY61mQqCX5-cl5m3E__9hK5vzIEMytDKlBlHEEv7EcvUUrS6mdg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 04:11:43 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id b91d5842 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 09:11:36 +0000 (UTC)
Date:   Tue, 8 Nov 2022 10:11:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/6] revision: introduce struct to handle exclusions
Message-ID: <Y2odS7H8lmom/8C3@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <2a6a67df1d470bf790025d55095c237ddc6a6bd6.1667823042.git.ps@pks.im>
 <221107.86tu3ax5b6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hx4Oe88uQnSWmXgU"
Content-Disposition: inline
In-Reply-To: <221107.86tu3ax5b6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hx4Oe88uQnSWmXgU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 01:51:51PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Mon, Nov 07 2022, Patrick Steinhardt wrote:
[snip]
> > +	string_list_init_dup(&exclusions->excluded_refs);
>=20
> Okey, so this is partly my fault for not following up on f196c1e908d
> (revisions API users: use release_revisions() needing REV_INFO_INIT,
> 2022-04-13) :); But here:
>=20
> If we keep this *_init() function don't duplicate what you're adding to
> the macro, just init this in terms of the macro. See the two-line
> examples in:
>=20
> 	git grep -W memcpy.*blank

Makes sense.

> But here (and this is the part that's mostly me) as we don't malloc this
> anymore you're only needing to keep this init function for
> repo_init_revisions().
>=20
> So, probably too big a digression for a "while at it", but FWIW this on
> top of your topic would do:
> =09
> 	 revision.c | 10 ++--------
> 	 revision.h | 10 +++++++---
> 	 2 files changed, 9 insertions(+), 11 deletions(-)
> =09
> 	diff --git a/revision.c b/revision.c
> 	index 45652f9b0bb..cf352d1fa43 100644
> 	--- a/revision.c
> 	+++ b/revision.c
> 	@@ -1534,12 +1534,6 @@ int ref_excluded(const struct ref_exclusions *exc=
lusions, const char *path)
> 	 	return 0;
> 	 }
> 	=20
> 	-void init_ref_exclusions(struct ref_exclusions *exclusions)
> 	-{
> 	-	string_list_init_dup(&exclusions->excluded_refs);
> 	-	string_list_init_dup(&exclusions->hidden_refs);
> 	-}
> 	-
> 	 void clear_ref_exclusions(struct ref_exclusions *exclusions)
> 	 {
> 	 	string_list_clear(&exclusions->excluded_refs, 0);
> 	@@ -1897,7 +1891,8 @@ void repo_init_revisions(struct repository *r,
> 	 			 struct rev_info *revs,
> 	 			 const char *prefix)
> 	 {
> 	-	memset(revs, 0, sizeof(*revs));
> 	+	struct rev_info blank =3D REV_INFO_INIT;
> 	+	memcpy(revs, &blank, sizeof(*revs));
> 	=20
> 	 	revs->repo =3D r;
> 	 	revs->abbrev =3D DEFAULT_ABBREV;
> 	@@ -1933,7 +1928,6 @@ void repo_init_revisions(struct repository *r,
> 	=20
> 	 	init_display_notes(&revs->notes_opt);
> 	 	list_objects_filter_init(&revs->filter);
> 	-	init_ref_exclusions(&revs->ref_excludes);
> 	 }
> 	=20
> 	 static void add_pending_commit_list(struct rev_info *revs,
> 	diff --git a/revision.h b/revision.h
> 	index fef5e063d16..75b8ecc307b 100644
> 	--- a/revision.h
> 	+++ b/revision.h
> 	@@ -94,6 +94,10 @@ struct ref_exclusions {
> 	 	 */
> 	 	struct string_list hidden_refs;
> 	 };
> 	+#define REF_EXCLUSIONS_INIT { \
> 	+	.excluded_refs =3D STRING_LIST_INIT_DUP, \
> 	+	.hidden_refs =3D STRING_LIST_INIT_DUP, \
> 	+}
> 	=20
> 	 struct oidset;
> 	 struct topo_walk_info;
> 	@@ -371,7 +375,9 @@ struct rev_info {
> 	  * called before release_revisions() the "struct rev_info" can be left
> 	  * uninitialized.
> 	  */
> 	-#define REV_INFO_INIT { 0 }
> 	+#define REV_INFO_INIT { \
> 	+	.ref_excludes =3D REF_EXCLUSIONS_INIT, \
> 	+}
> 	=20
> 	 /**
> 	  * Initialize a rev_info structure with default values. The third param=
eter may
> 	@@ -455,10 +461,8 @@ void show_object_with_name(FILE *, struct object *,=
 const char *);
> 	 /**
> 	  * Helpers to check if a reference should be excluded.
> 	  */
> 	-#define REF_EXCLUSIONS_INIT { .excluded_refs =3D STRING_LIST_INIT_DUP, =
=2Ehidden_refs =3D STRING_LIST_INIT_DUP }
> 	=20
> 	 int ref_excluded(const struct ref_exclusions *exclusions, const char *p=
ath);
> 	-void init_ref_exclusions(struct ref_exclusions *);
> 	 void clear_ref_exclusions(struct ref_exclusions *);
> 	 void add_ref_exclusion(struct ref_exclusions *, const char *exclude);
> 	 void exclude_hidden_refs(struct ref_exclusions *, const char *section);
>=20
> But I'll submit that cleanup seperately, but for now let's not duplicate
> your REF_EXCLUSIONS_INIT macro here in init_ref_exclusions(), just have
> the function do what the macro is doing, now that we don't need the
> malloc.

Great, thanks.

[snip]
> >  static void add_pending_commit_list(struct rev_info *revs,
> > @@ -2689,10 +2684,10 @@ static int handle_revision_pseudo_opt(struct re=
v_info *revs,
> >  			init_all_refs_cb(&cb, revs, *flags);
> >  			other_head_refs(handle_one_ref, &cb);
> >  		}
> > -		clear_ref_exclusion(&revs->ref_excludes);
> > +		clear_ref_exclusions(&revs->ref_excludes);
> >  	} else if (!strcmp(arg, "--branches")) {
> >  		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
> > -		clear_ref_exclusion(&revs->ref_excludes);
> > +		clear_ref_exclusions(&revs->ref_excludes);
> >  	} else if (!strcmp(arg, "--bisect")) {
> >  		read_bisect_terms(&term_bad, &term_good);
> >  		handle_refs(refs, revs, *flags, for_each_bad_bisect_ref);
> > @@ -2701,15 +2696,15 @@ static int handle_revision_pseudo_opt(struct re=
v_info *revs,
> >  		revs->bisect =3D 1;
> >  	} else if (!strcmp(arg, "--tags")) {
> >  		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
> > -		clear_ref_exclusion(&revs->ref_excludes);
> > +		clear_ref_exclusions(&revs->ref_excludes);
> >  	} else if (!strcmp(arg, "--remotes")) {
> >  		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
> > -		clear_ref_exclusion(&revs->ref_excludes);
> > +		clear_ref_exclusions(&revs->ref_excludes);
> >  	} else if ((argcount =3D parse_long_opt("glob", argv, &optarg))) {
> >  		struct all_refs_cb cb;
> >  		init_all_refs_cb(&cb, revs, *flags);
> >  		for_each_glob_ref(handle_one_ref, optarg, &cb);
> > -		clear_ref_exclusion(&revs->ref_excludes);
> > +		clear_ref_exclusions(&revs->ref_excludes);
> >  		return argcount;
> >  	} else if ((argcount =3D parse_long_opt("exclude", argv, &optarg))) {
> >  		add_ref_exclusion(&revs->ref_excludes, optarg);
> > @@ -2718,17 +2713,17 @@ static int handle_revision_pseudo_opt(struct re=
v_info *revs,
> >  		struct all_refs_cb cb;
> >  		init_all_refs_cb(&cb, revs, *flags);
> >  		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
> > -		clear_ref_exclusion(&revs->ref_excludes);
> > +		clear_ref_exclusions(&revs->ref_excludes);
> >  	} else if (skip_prefix(arg, "--tags=3D", &optarg)) {
> >  		struct all_refs_cb cb;
> >  		init_all_refs_cb(&cb, revs, *flags);
> >  		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
> > -		clear_ref_exclusion(&revs->ref_excludes);
> > +		clear_ref_exclusions(&revs->ref_excludes);
> >  	} else if (skip_prefix(arg, "--remotes=3D", &optarg)) {
> >  		struct all_refs_cb cb;
> >  		init_all_refs_cb(&cb, revs, *flags);
> >  		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
> > -		clear_ref_exclusion(&revs->ref_excludes);
> > +		clear_ref_exclusions(&revs->ref_excludes);
>=20
> The churn I mentioned with the renaming, so maybe worth doing that as a
> "prep" commit?

Hm. I don't think it's too bad, and it's weird to rename things already
without any clear justification why that's visible from the diff. Like,
there is no `struct ref_exclusions` yet, why rename it?

I'll retain this in a single commit if you don't mind, but amend the
commit message to explicitly mention the rename.

> > +struct ref_exclusions {
> > +	/*
> > +	 * Excluded refs is a list of wildmatch patterns. If any of the
> > +	 * patterns matches, the reference will be excluded.
> > +	 */
> > +	struct string_list excluded_refs;
> > +};
>=20
> Per the above POC diff though, please move...
>=20
> >  struct oidset;
> >  struct topo_walk_info;
> > =20
> > @@ -103,7 +111,7 @@ struct rev_info {
> >  	struct list_objects_filter_options filter;
> > =20
> >  	/* excluding from --branches, --refs, etc. expansion */
> > -	struct string_list *ref_excludes;
> > +	struct ref_exclusions ref_excludes;
> > =20
> >  	/* Basic information */
> >  	const char *prefix;
> > @@ -439,12 +447,14 @@ void mark_trees_uninteresting_sparse(struct repos=
itory *r, struct oidset *trees)
> >  void show_object_with_name(FILE *, struct object *, const char *);
> > =20
> >  /**
> > - * Helpers to check if a "struct string_list" item matches with
> > - * wildmatch().
> > + * Helpers to check if a reference should be excluded.
> >   */
> > -int ref_excluded(struct string_list *, const char *path);
> > -void clear_ref_exclusion(struct string_list **);
> > -void add_ref_exclusion(struct string_list **, const char *exclude);
> > +#define REF_EXCLUSIONS_INIT { .excluded_refs =3D STRING_LIST_INIT_DUP }
>=20
> ...this macro to right after declaring the struct, which is what we
> usually do, and will help in adding it to "REV_INFO_INIT" sooner than
> later.

Fair, will change.

> Also, at the end of your series this end up being overly long, so per
> the diff-above (which is tot he end of the series), let's start by
> line-wrapping it:
>=20
> 	#define ..._INIT { \
>         	.member =3D ..._INIT, \
> 	}

Makes sense.

Patrick

--hx4Oe88uQnSWmXgU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqHUoACgkQVbJhu7ck
PpTHJhAAmyH+VuoVEarRXGFDRdEpYgW3dkeeGLjNk0v3NvHlDwdOvGQxX94fulwl
P+Twk24rk89FmcW44/lIE+4Ma0XNxmu+4GplCcUMiB0sBswkLQKRWH9OLVDPqbYX
nv4trRt27I/GOkJjePwdviwjqzCKGNEX0uvgzHG7oWgVxFnzwsgIfRGJmCU3M96Y
PdESv3LgU3imUp25xo8f/NXkf6bteRsv/7EYQj1D2yPojP+GogcZ+f6H3/NLskJO
fynQrRTJ9/D55OZS4ikaciILylit0j/iGnpIsoPqBeQghGfFtSVIVkU1lTV+uMRF
Pcq58HU80+YPi3UYUWmSZwNO8FmkYJJN9X/yDpw+n40KdhuupA4A0mY3lXt55C6V
rRRPxWw5mHC/lN6FaK2s62GzGh18ZYbuH7pPDfAezeIYUypHM8ce57YdLv6JW4PQ
sEqjRRMAACtqIQzyxapHvJEnCiJMqyE27h4xNN8ixIH+YrV3QOoqxSC7Sxbmdgkq
hHzSERwsVb6sWJRG1/bq3SV/d7r27nUiFIsrdIoPU9VelVQbL74vVN3loB6vili7
5wdQgxyZEzpxrM9ewBWUIxTevmrpsl0meDKROatrEEbKqk6TAwqJHk6siKaY1Z5v
mQQPVIR7Z2e9OhGLeBD/y1vxS6YF+2cdGGl0jpOPx4isIGw0Ptc=
=yiri
-----END PGP SIGNATURE-----

--hx4Oe88uQnSWmXgU--
