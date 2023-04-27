Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E12C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 10:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243394AbjD0K6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjD0K6t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 06:58:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA4A468F
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:58:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CB2945C0230;
        Thu, 27 Apr 2023 06:58:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Apr 2023 06:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682593127; x=1682679527; bh=eZ
        bGvvMqN+O36tMM1pbOpzZ5bWv2y18ebA3K89XR2KQ=; b=CNQYVgnORx5YjDQY5E
        hAtQQ+GVgzMYxnmfDmA6LnQ3mg0N07Abpn+CFIjuWtwZO5xhTZ6flLvfpSqMxMw6
        AaTtqrNW2Xl0iUntAteVqcal+pXn6bv1IWxl2uLXRK7sxxDVCYtCumL+0yW/Zgep
        PRCiwotwKCRcs5mhCeHgCqMo7EKLd0jiMw00J48N+hKQrZ13JJRdmo3jdf9q+K4b
        riiQf/q1/0TSrOhm63+wUBF4LZf3ioQU2tLyGDWtkWCXlFWUHxNWLfYax7pKnPuc
        UGZuDz6cMwJtMwihhm0BfHiJoMAqUO41qs/D87rj8v1Tr8Ez4ei7R4oexgYB6PI1
        rTWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682593127; x=1682679527; bh=eZbGvvMqN+O36
        tMM1pbOpzZ5bWv2y18ebA3K89XR2KQ=; b=CGweGWPHf/MXmSY7K8FTYxTbZGkcC
        hVeYOoA0FCiIZCmVLKSodNOJTX1NHENefhm/FfbGzFHBMXsh9xevS1jcJQbNRzYJ
        TwV0ayhWjkkzP+AHOcO93DpPoRngRQ9KrchF4DA0WkW9WJ1W3KIvxSHxUtFVBuss
        8iGzfucKwG+3snFJ5TOeCtrO+iD3jgF2BP21sU5ZKY7V+tDg5Ul0W2SkiJ+fGVNQ
        74rsopbZdhs10DP+8/eebbOkomNsYXKrrtBLbYL7g3inSZY8H6GsEEQYAnCSXE5Z
        GMDSSHn8/bJCXEysoSwcLorTmpnuBXVt3cwwxffM3zHn4zneN4j06AUKQ==
X-ME-Sender: <xms:Z1VKZBORfTmqv_5XbEbgk-lYWONNNAhrlUfh7K4iLdglq5EpoQFcUg>
    <xme:Z1VKZD_zR8ruYUxH2-B20PZLdQr9UbUPUqoO4a4-aFgXMblXtzz0nsnVByfQ9nWQ2
    ppleM8NQPkcM1-ceA>
X-ME-Received: <xmr:Z1VKZASEoZynqI6iZ--Z2bQzErQnTEYwhz41Xs9rPmYZLZI6uaMatgQFa5t6PM63lxsfuFPisLSIzNL3IyMzTu1ry9tjgBmze1JqoKPREFDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Z1VKZNs59D3ND1rLlL09r9x-xOJpWTHjpViCMjFxvob4fLwiFwdZ5w>
    <xmx:Z1VKZJcoH0mHllubNoavTYEVUCx-SsEHK8e3BtnpLEZjdWosHnTOGQ>
    <xmx:Z1VKZJ2O1v6FXyxQjRUjkK-tA16ey83uMqfeE-h5oLTy0uDlo2Czzg>
    <xmx:Z1VKZJGFaCm2YRfAyZX8CM_nnFh9WnnKKOvp-Dnkv_DzPVwDbpCBpw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 06:58:46 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id c680aedd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 10:58:18 +0000 (UTC)
Date:   Thu, 27 Apr 2023 12:58:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/8] fetch: fix missing from-reference when fetching
 HEAD:foo
Message-ID: <ZEpVZcvz_OWhno1O@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <596e12f03a296d753ee6fe8face9522edc9e397e.1681906948.git.ps@pks.im>
 <kl6l5y9io37i.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A3qMUfJSn2/UvlIa"
Content-Disposition: inline
In-Reply-To: <kl6l5y9io37i.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--A3qMUfJSn2/UvlIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 12:25:53PM -0700, Glen Choo wrote:
> Rearranging the lines slightly,
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When displaying reference updates, we print a line that looks similar to
> > the following:
> >
> > ```
> >  * branch               master          -> master
> > ```
> >
> > The "branch" bit changes depending on what kind of reference we're
> > updating, while both of the right-hand references are computed by
> > stripping well-known prefixes like "refs/heads/" or "refs/tags".
> >
> > [...]
> >                   we also use this value to display reference updates.
> > And while the call to `display_ref_update()` correctly figures out that
> > we meant "HEAD" when `what` is empty, the call to `update_local_ref()`
> > doesn't. `update_local_ref()` will then call `display_ref_update()` with
> > the empty string and cause the following broken output:
> >
> > ```
> > $ git fetch --dry-run origin HEAD:foo
> > From https://github.com/git/git
> >  * [new ref]                          -> foo
> > ```
> >
> > [...]
> >
> > Fix this bug by instead unconditionally passing the full reference name
> > to `display_ref_update()` which learns to call `prettify_refname()` on
> > it. This does fix the above bug and is otherwise functionally the same
> > as `prettify_refname()` would only ever strip the well-known prefixes
> > just as intended. So at the same time, this also simplifies the code a
> > bit.
>=20
>=20
> The bug fix is obviously good. I'm surprised we hadn't caught this
> sooner.
>=20
> As a nitpicky comment, the commit message goes into a lot of detail,
> which makes it tricky to read on its own (though the level of detail
> makes it easy to match to the diff, making the diff quite easy to
> follow). I would have found this easier to read by summarizing the
> high-level mental model before diving into the background, e.g.
>=20
>=20
>   store_updated_refs() parses the remote ref name to create a 'note' to
>   write to FETCH_HEAD. This note is usually the prettified ref name, so
>   it is used to diplay ref updates (display_ref_update()). But if the
>   remote ref is HEAD, the note is the empty string [insert bug
>   description]. Instead, use the note only as a note and have
>   display_ref_update() prettify the ref name itself...

I like that and will use a variant of this.

[snip]
> > diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
> > index 0e45c27007..55f0f05b6a 100755
> > --- a/t/t5574-fetch-output.sh
> > +++ b/t/t5574-fetch-output.sh
> > @@ -54,6 +54,25 @@ test_expect_success 'fetch compact output' '
> >  	test_cmp expect actual
> >  '
> > =20
> > +test_expect_success 'fetch output with HEAD and --dry-run' '
>=20
> The commit message and diff didn't imply that this is a --dry-run only
> bug. I tested locally, and it seems to reproduce without --dry-run too,
> so I think we should drop "--dry-run" from this test name. In a later
> patch, you also add a test for porcelain output with --dry-run, but
> since this test seems designed for just this bug, I think we can drop
> the later test.

True, I'll amend the test.

Patrick

--A3qMUfJSn2/UvlIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKVWQACgkQVbJhu7ck
PpQu7w/8Dz1bQVqyteAlO6pR/WFKlbTZaao6vgM2uNRIDSeXwbhKjmaaum5mg1hy
PSq5P1FomPwE1ltuakQd5lPY1UlQD4SE6AEbgZTP3ObPui4Z15ATJYk/qBhDY5R7
VMH4r6hYxrwUoVrud/yo20/VZjIk77yj1pUg5FeR+BWFgAvAt9CmHI4WkIWAIF+l
tbNkykviPRfw3t8JGW8Jh3EfgOeLoEqAeezx5l6AOevis996pBfNxE1Nx65F4IT2
M1CsWvoLAASOwQ/d8jk8zT7lwWUw+6RvwfN9ply3pqNoMf/Hmcyo+ElgMlAbgL9o
AYDtupVmVwk8nRxxhhnjlwZOXauxhj/vIaZ7Wh9jsKjQxGAcPNISAwiHajUSgofj
6BUNifIsLo3mpJRy/EX7rNb0YXDlnbW6DAhMEerAh8qOaerjmzgwwYWN8WO26JOq
H+eqsjySN1XfleCimCEnprp73jWS3sxdCRVVzWU6/GaeLhYpUVKzOZpibRnOKdp7
JZ1CPcchs/X/AIaaXbblloH+6LqxKzAaXwQ4OXBVEmIRyuoTArr6Djytm4i6A24e
moBZDHF7g9PWuu6KE9Ob7qaABo6lhrAkH6S8ARgUIdrZ5t6qk/HgjYnzrGFBs7Rz
fP9n59GRu3mlmoEoFp6I69KxjHfi9BqCLBZiugUGIktd0IIbIeE=
=U7QR
-----END PGP SIGNATURE-----

--A3qMUfJSn2/UvlIa--
