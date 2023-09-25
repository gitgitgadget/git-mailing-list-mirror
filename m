Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A74CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 12:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjIYMsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 08:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIYMsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 08:48:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF131C6
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 05:48:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D5685C26F6;
        Mon, 25 Sep 2023 08:48:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 Sep 2023 08:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1695646121; x=1695732521; bh=+a
        FE2HoScXiOWYnr+t5AcWkb0lGZ1Tw618+02EvUgPI=; b=NFvlvi5jhP3hMkBQOF
        jK0709xQ2N6YcB4F6uH1ZiUCZBllMR/RVpqLtneIfgMupiRIYaTHHHbcCmR3+4xD
        tfM0kBf7cfIaeMu9uYlQGCjcyoY/D9rEqFew7wEkCeNSfBz15P1bqnl92UT0KdTw
        CC78n7L6aFXWDCKYnQ7aSGFKry/rfB0kFyk3UTNesCoWlB/boW8g4TB71789NLUJ
        riT18InITf5vIuXA/3dbS86TkwtWEH4xbX2bXISYih2EjyYOk2WpWRntyVK/DI8S
        qdQ+nmm334zjMY0vDl5UEvtvfmaK1pXhFy9mru80mV7j+Wk1myCRLfpTnBqsQPbs
        ysCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695646121; x=1695732521; bh=+aFE2HoScXiOW
        Ynr+t5AcWkb0lGZ1Tw618+02EvUgPI=; b=N5JlcnGcO4zk5fR4VgQqzcR1HmlBJ
        x6wVl1PcJbLfIBgJsH97iqyIbOWc7tDkhsxt02J+fQahPtzflBG5FhBLoB8yFzvc
        JFGzF1mKjuv8ZYZOTOf3G/lTlKVRlCFwrNNYH80i2o64axB9urMYw44dZxe3vIu1
        Q4lucJbxNWdfEiISjAcxODEnn4bNxkrr/oyNJC69V8TV1OBxtzl/gWqAzb02lbVa
        dXS2zY7HeeSdMCLytAC7ObDFMlK6MR6rK7kuJCnNtcBCKCDdZ7Z3P/oTCy9vx5x4
        vkOf+4cANrPp3wGy3Xb5ltFryZg7gEK9cB4CL9dsr585DhlW1uB62CWRQ==
X-ME-Sender: <xms:qYERZWlV8DRgJUCT8QCTzuCdsyPGELfkI1tePDfFiaYOuAYOYQSfOw>
    <xme:qYERZd3P0okNMjDpiBIoleCw_5pgsUmjdc3iDkKLdp1pEnKnB_h63RznA14tgwQ44
    Uf2nLJ6XqSniiQvpA>
X-ME-Received: <xmr:qYERZUpnn1IcJc60YDmQzayYgx9n3w7iRW8bNLL7qGL6fOSmYhHvE0uR5L2PjSUlrOYe5lN6qREOGQnLTxSWgbhPXMIALSOSuqBhSZlmAQWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qYERZanixg0dxOYHaj_1u5QTfsfi4QtMd6i3q8rJxNJFQNHDf97osQ>
    <xmx:qYERZU0cYkvRo77f6eWUzNQXppIUHBtMbJxD3zZV43Rrhh5QqNDA1A>
    <xmx:qYERZRvXFZxLbl-Apl9gmgo1riEvzivF8KlAumGAGRPx1Dyl685s1g>
    <xmx:qYERZR86LiIIN9Lrv4AKweZjdVz91V0K4JKnP8GaSEzshAzonvYqlQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 08:48:40 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 5c89c11b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 25 Sep 2023 12:48:36 +0000 (UTC)
Date:   Mon, 25 Sep 2023 14:48:35 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] revision: make pseudo-opt flags read via stdin behave
 consistently
Message-ID: <ZRGBo1TsgSYrMt01@tanuki>
References: <b93d4c8c23552abab64084b62f27944e7e192c0c.1695290733.git.ps@pks.im>
 <ZQyPOScCKhHeZNrr@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AmjD8Yi2Z3erKeGY"
Content-Disposition: inline
In-Reply-To: <ZQyPOScCKhHeZNrr@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AmjD8Yi2Z3erKeGY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 02:45:13PM -0400, Taylor Blau wrote:
> On Thu, Sep 21, 2023 at 12:05:57PM +0200, Patrick Steinhardt wrote:
> > When reading revisions from stdin via git-rev-list(1)'s `--stdin` option
> > then these revisions never honor flags like `--not` which have been
> > passed on the command line. Thus, an invocation like e.g. `git rev-list
> > --all --not --stdin` will not treat all revisions read from stdin as
> > uninteresting. While this behaviour may be surprising to a user, it's
> > been this way ever since it has been introduced via 42cabc341c4 (Teach
> > rev-list an option to read revs from the standard input., 2006-09-05).
>=20
> I'm not sure I agree that `--all --not --stdin` marking the tips given
> on stdin as uninteresting would be surprising to users. It feels like
> `--stdin` introduces its own "scope" that `--not` should apply to.
>=20
> I might be biased or looking at this differently than how other users
> might, but `--all --not --stdin` reads like "traverse everything except
> what I give you over stdin", and deviating from that behavior feels more
> surprising than not.
>=20
> Either way, since this comes from as far back as 42cabc341c4, I think
> that we're stuck with this behavior one way or the other ;-).

I agree with all of what you say. But yes, we both come to the same
conclusion: it's not great behaviour, but we can't really do anything
about it because it's been like this since basically forever.

I'm a bit confused though, because further down your mail you seem to
disagree with what you write here by proposing to change the behaviour
regardless.

[snip]
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > Reported-by: Christian Couder <christian.couder@gmail.com>
> > ---
> >  Documentation/rev-list-options.txt |  6 +++++-
> >  revision.c                         | 10 +++++-----
> >  t/t6017-rev-list-stdin.sh          | 21 +++++++++++++++++++++
> >  3 files changed, 31 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
> > index a4a0cb93b2..9bf13bac53 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -151,6 +151,8 @@ endif::git-log[]
> >  --not::
> >  	Reverses the meaning of the '{caret}' prefix (or lack thereof)
> >  	for all following revision specifiers, up to the next `--not`.
> > +	When used on the command line before --stdin, the revisions passed
> > +	through stdin will not be affected by it.
>=20
> Hmmph. This seems to change the behavior introduced by 42cabc341c4. Am I
> reading this correctly that tips on stdin with '--not --stdin' would not
> be marked as UNINTERESTING?
>=20
> (Reading this back, there are a lot of double-negatives in what I just
> wrote making it confusing for me at least. What I'm getting at here is
> that I think `--not --stdin` should mark tips given via stdin as
> UNINTERESTING).

It does not change the behaviour, it only documents the current state
such that it's at least spelled out somewhere.

> >  --all::
> >  	Pretend as if all the refs in `refs/`, along with `HEAD`, are
> > @@ -240,7 +242,9 @@ endif::git-rev-list[]
> >  	them from standard input as well. This accepts commits and
> >  	pseudo-options like `--all` and `--glob=3D`. When a `--` separator
> >  	is seen, the following input is treated as paths and used to
> > -	limit the result.
> > +	limit the result. Flags like `--not` which are read via standard input
> > +	are only respected for arguments passed in the same way and will not
> > +	influence any subsequent command line arguments.
> >
> >  ifdef::git-rev-list[]
> >  --quiet::
> > diff --git a/revision.c b/revision.c
> > index 2f4c53ea20..a1f573ca06 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -2788,13 +2788,13 @@ static int handle_revision_pseudo_opt(struct re=
v_info *revs,
> >  }
> >
> >  static void read_revisions_from_stdin(struct rev_info *revs,
> > -				      struct strvec *prune,
> > -				      int *flags)
> > +				      struct strvec *prune)
> >  {
> >  	struct strbuf sb;
> >  	int seen_dashdash =3D 0;
> >  	int seen_end_of_options =3D 0;
> >  	int save_warning;
> > +	int flags =3D 0;
>=20
> OK, I think this confirms my assumption that the `--not` in `--not
> --stdin` does not propagate across to the input given over stdin. I am
> not sure that we are safely able to change that behavior.
>=20
> I wonder if we could instead do something like:
>=20
>   - inherit the current set of psuedo-opts when processing input over
>     `--stdin`
>   - allow pseudo-opts within the context of `--stdin` arbitrarily
>   - prevent those psuedo-opts applied while processing `--stdin` from
>     leaking over to subsequent command-line arguments.
>=20
> Here's one approach for doing that, where we make a copy of the current
> set of flags when calling `read_revisions_from_stdin()` instead of
> passing a pointer to the global state.

That was indeed my first approach. But this change would break behaviour
that was introduced with 42cabc341c4 (Teach rev-list an option to read
revs from the standard input., 2006-09-05) almost 17 years ago. If we
change it now then this is very likely to cause problems somewhere.

To clarify:

    - Since 2006 we had `--stdin`. Revisions read via `--stdin` were not
      influenced by `--not`.

    - With Git v2.41 I introduced the ability to read pseudo-opts via
      `--stdin`. These _are_ influenced by `--not`, which is
      inconsistent with the way we handle normal revs.

I want to rectify the newly introduced pseudo-opts-via-stdin to behave
the same as the first point now. Like this, we make the behaviour more
consistent with what we did for the last 17 years.

Is there anything in my commit message that can be clarified such that
it becomes less confusing?

Patrick

> --- 8< ---
> diff --git a/revision.c b/revision.c
> index a1f573ca06..d8dad35d52 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2788,13 +2788,13 @@ static int handle_revision_pseudo_opt(struct rev_=
info *revs,
>  }
>=20
>  static void read_revisions_from_stdin(struct rev_info *revs,
> -				      struct strvec *prune)
> +				      struct strvec *prune,
> +				      int flags)
>  {
>  	struct strbuf sb;
>  	int seen_dashdash =3D 0;
>  	int seen_end_of_options =3D 0;
>  	int save_warning;
> -	int flags =3D 0;
>=20
>  	save_warning =3D warn_on_object_refname_ambiguity;
>  	warn_on_object_refname_ambiguity =3D 0;
> @@ -2906,7 +2906,8 @@ int setup_revisions(int argc, const char **argv, st=
ruct rev_info *revs, struct s
>  				}
>  				if (revs->read_from_stdin++)
>  					die("--stdin given twice?");
> -				read_revisions_from_stdin(revs, &prune_data);
> +				read_revisions_from_stdin(revs, &prune_data,
> +							  flags);
>  				continue;
>  			}
> --- >8 ---
>=20
> Thanks,

--AmjD8Yi2Z3erKeGY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmURgZ4ACgkQVbJhu7ck
PpSayQ/9HmcShHX2GwNOa3H8TESvgYl3OSzCYw69kEk1/mYBoCmeIYMSf6VKfGfc
iHUzzgEe3qjtFwQNILM52gNvGe0PzSrvqty94v2oyODWdJlCGiuLQJd/0YMVGuyF
K5Im9m4EHTD5KC45E85JFmUKFh1kwzznzvk8n2sc18Y8JSHgQzHG5LaEQVlIgUZW
QsGweUnd9seo4m+9S/9LDS/52b87wlHxIBuscB+oJuEJ0Hh7D5166/DIiD/DNxCO
3bAybijnyUwUHE6OqwfJeS50dX1/fiaqkq2cj4I8234hrb5xXf8YymctJumaBO6W
gflUdkZdwKEsBNTsPRr8YobaE5AydLJ0vD/Fw9cjbbavLcQIyqdakp+dXJoYBOcI
lwdG/HCb199Ce4zU3B0apNQCxwNPORFN5t+WL2LUFPQAcUgJYdw/qNKyYxCb0g6j
9jM8aalv+J3RNboQLUrcL8qErqUjaOjBHjbdYQrQO9yHmDvHmlaNXjgEpnLrvMaO
XHhwRWuLPsBWextm7OTZ1JFn/1OxAgwGuqb9ecrvzXaTEC1YyQ074Ufs4xHdoEFz
jm0DUEHpJ9+GYovACKnPfwpXW1Lgmyb6BxeMtj611zsbB5wt4z3aF8/Cu7exM2rS
/Z4OJXjC3c6OqSTIQIIpm4xpxwYTLD2Wwp9JnAlsTM8l6AmXXn8=
=SFwe
-----END PGP SIGNATURE-----

--AmjD8Yi2Z3erKeGY--
