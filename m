Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B754776
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712635435; cv=none; b=dt/xKgg36dtvw3Dwnx52lba/i3Hca4Cy9I7jVKJb+FjvkrlQ8rJWZTLceTnWCa3/aBMUlJwjVFbXuCizPY5DH1S3uzfYSvNohSkKiNw+RK79oBVAbqA1n7pjQ6Ora+G+qq9724gEGUfOtviuvrTSGPPnfmch/XgMDTXLw8lklZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712635435; c=relaxed/simple;
	bh=3CIuf7UG921qAE3K5RJpCnpFSHMxaDErOvbOxLTn6ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCAtCvBsYQ9WMLJhbxekJoloPe9hNgMvjvG3tFnAOhTWw/vkC/MtBrERaCK7MnNxZsly25xDhcrfc2wmPU0H4ORwfMMGEJcbKDq5S4JshwBIMoPXq4bsMfOh/0xtLJ2UTWZD2l9zB35cubtN9M/UyyHtVhiFomkjXSqELtxXBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ObhuvaH8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GyDlkAga; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ObhuvaH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GyDlkAga"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2AB9C1140181;
	Tue,  9 Apr 2024 00:03:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 09 Apr 2024 00:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712635432; x=1712721832; bh=UVLea0QNTi
	u2sl82mYjyfoOja8YqFXcFBZBav3W0cVQ=; b=ObhuvaH8p5DKfZ9pcObaysKh6A
	MDC5AR9CX6zCTXi7Tgs6wtTUc12E34JDCyt0ZhqhOCi8EycpGRZAsRCNR4V3jkez
	BPFHBsPf1HoyqfGY8A0+dHIlCjJn5EfCAXLTFqWJ0EBDgR6mrR+KVNzwh7xlcJcC
	Zv6X/aRsImKjxMQ8801PnYfVdgpy0mg68cxhE7AintyNN5mGDe+vu49l/p77r6qz
	OC7gtE6i4hp5Qn9RxxIlik4zN075BLekjtTITG+8qyeOhkc1e8X468i34g8rleEM
	IIDyG7cmWKY0G031TVFsSlJG14h1PlwOxA8GYkwSAUFqp3W8fp0jfPlbZ0xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712635432; x=1712721832; bh=UVLea0QNTiu2sl82mYjyfoOja8Yq
	FXcFBZBav3W0cVQ=; b=GyDlkAgahYZZ+ih33kPsvkrMCufLlFoai6xRaQDAHlhz
	YUDFDj8apO6wNSLSiVSbRMs0dLuACSj0MPG53bq6a4O1kh4jAEqjOF+vp7gJZRL5
	Wkt8bkhfCxEXZS33vIgYJgPsDTu0r6viWzuIwcNxeL6f7ZTsBAt4GVHP1YEr1G+l
	JNgro55gBWpxoYWsArYZO9ZP9TB/zF0RMZj9asB80amzOSErZmAoWUHUFrH+oLDN
	7Rfaw4K/kp6D1SXrHJii7lCIPp4aC5jrID4xkokIB20A4ZpB1fkuMO8QW9OWAPX7
	ScAQUnqpgiPbQEa15pnOUdic37w/2hdOeYs6JeCObg==
X-ME-Sender: <xms:J74UZqzuwIz1y2Z6tA9oPrMEm-YaO6tXMxKR__bY00Vh73qDYl2Ifw>
    <xme:J74UZmRDGrsA-wHJ4aPYrN1mbzFThUjf0t6HWqz7KSee3QSJvvzTsLyntgvGqjmfG
    _XZF8xdWQRHnn95MQ>
X-ME-Received: <xmr:J74UZsXhShIncJ5hrxpPH26v3dITntOOgJkHR4gK_jyvkaCw-RWqiILVYm26Y7ATg55BVs6_wXfOzlTmaz8g-ZObB4o-4vQfBZJGMoSuBwkeJPAGfCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:J74UZgiLOE1fhnCrWESlX3yE6awwcfNML01vkj96vabs5qvlsETTHQ>
    <xmx:J74UZsAmoAV-ZLg8vgxrtKFN_Hmsxv7BetwLOQiwTu4gJro_mdmbqA>
    <xmx:J74UZhKc5wFPExYS4IEMX-9JL8j0sdWYPWrSXkYnfnQ0jS764WSsUg>
    <xmx:J74UZjAxC9Vv7i4chU0XgScRoHzzv4W6TQlArQUvdjsoyyNh8Ka4ng>
    <xmx:KL4UZqBu67GDBlUba4GdL_oBmxMsyskUsSg1IfUkT93gD9W7qmzacV4->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 00:03:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2bd0e974 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 04:03:41 +0000 (UTC)
Date: Tue, 9 Apr 2024 06:03:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/2] rebase -i: improve error message when picking
 merge
Message-ID: <ZhS-IllueSZa1NXs@tanuki>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
 <fbc6746e0188ed7b69c238935ec85b69112ddd79.1712585788.git.gitgitgadget@gmail.com>
 <xmqqle5n7ajt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lfbYzN/CZSR/y19o"
Content-Disposition: inline
In-Reply-To: <xmqqle5n7ajt.fsf@gitster.g>


--lfbYzN/CZSR/y19o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 03:29:42PM -0700, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > The only todo commands that accept a merge commit are "merge" and
> > "reset". All the other commands like "pick" or "reword" fail when they
> > try to pick a a merge commit and print the message
> >
> >     error: commit abc123 is a merge but no -m option was given.
> >
> > followed by a hint about the command being rescheduled. This message is
> > designed to help the user when they cherry-pick a merge and forget to
> > pass "-m". For users who are rebasing the message is confusing as there
> > is no way for rebase to cherry-pick the merge.
> >
> > Improve the user experience by detecting the error when the todo list is
> > parsed rather than waiting for the "pick" command to fail and print a
> > message recommending the "merge" command instead. We recommend "merge"
> > rather than "exec git cherry-pick -m ..." on the assumption that
> > cherry-picking merges is relatively rare and it is more likely that the
> > user chose "pick" by a mistake.
>=20
> Now, the mention of "all the other commands" makes me curious what
> should happen when your "squash" and "fixup" named a merge commit.
> I think it should just error out without any recourse, but it is
> more than likely that I am missing some use cases where it is useful
> to "squash" or "fixup" a merge commit on top of an existing commit?
>=20
> > It would be possible to support cherry-picking merges by allowing the
> > user to pass "-m" to "pick" commands but that adds complexity to do
> > something that can already be achieved with
> >
> >     exec git cherry-pick -m1 abc123
>=20
> I have no strong opinions between this and "merge" for "pick",
> "edit", and "reword".
>=20
> > Reported-by: Stefan Haller <lists@haller-berlin.de>
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> >  sequencer.c                   | 37 +++++++++++++++++++++++++++++++++--
> >  t/t3404-rebase-interactive.sh | 33 +++++++++++++++++++++++++++++++
> >  2 files changed, 68 insertions(+), 2 deletions(-)
>=20
> So, having thought about my version of a solution from the problem
> description above without looking at your answers, let's see how you
> solved it.
>=20
> > diff --git a/sequencer.c b/sequencer.c
> > index a3154ba3347..4012c6f88d9 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2573,7 +2573,35 @@ static int check_label_or_ref_arg(enum todo_comm=
and command, const char *arg)
> >  	return 0;
> >  }
> > =20
> > -static int parse_insn_line(struct repository *r, struct replay_opts *o=
pts UNUSED,
> > +static int error_merge_commit(enum todo_command command)
> > +{
> > +	switch(command) {
> > +	case TODO_PICK:
> > +		return error(_("'%s' does not accept merge commits, "
> > +			       "please use '%s'"),
> > +			     todo_command_info[command].str, "merge -C");
> > +
> > +	case TODO_REWORD:
> > +		return error(_("'%s' does not accept merge commits, "
> > +			       "please use '%s'"),
> > +			     todo_command_info[command].str, "merge -c");
> > +
> > +	case TODO_EDIT:
> > +		return error(_("'%s' does not accept merge commits, "
> > +			       "please use '%s' followed by '%s'"),
> > +			     todo_command_info[command].str,
> > +			     "merge -C", "break");
>=20
> OK.  And when hitting the "break", they know that they are supposed
> to say "git commit --amend" and then "git rebase --continue"?
>=20
> > +	case TODO_FIXUP:
> > +	case TODO_SQUASH:
> > +		return error(_("cannot squash merge commit into another commit"));
>=20
> OK, this is as I expected.
>=20
> > +	default:
> > +		BUG("unexpected todo_command");
> > +	}
> > +}
> > +
> > +static int parse_insn_line(struct repository *r, struct replay_opts *o=
pts,
> >  			   struct todo_item *item, const char *buf,
> >  			   const char *bol, char *eol)
> >  {
> > @@ -2679,7 +2707,12 @@ static int parse_insn_line(struct repository *r,=
 struct replay_opts *opts UNUSED
> >  		return status;
> > =20
> >  	item->commit =3D lookup_commit_reference(r, &commit_oid);
> > -	return item->commit ? 0 : -1;
> > +	if (!item->commit)
> > +		return -1;
> > +	if (is_rebase_i(opts) && item->command !=3D TODO_MERGE &&
> > +	    item->commit->parents && item->commit->parents->next)
> > +		return error_merge_commit(item->command);
>=20
> This is good for now, but we may see command other than TODO_MERGE
> learn how to handle a merge commit, and when that happens, I wonder
> what we want to do here.  One thought is to do this:
>=20
> 	if (is_rebase_i(opts) && is_merge_commit(item->commit))
>         	return error_merge_commit(item);
>=20
> and teach error_merge_commit() to silently return 0 on TODO_MERGE.
> Other commands, when they learn how to deal with a merge commit,
> will then update their entries in error_merge_commit().
>=20
> Would we want to customize the message from error_merge_commit() to
> make it closer to cut-and-paste ready?  For that, something like
>=20
> 	int error_merge_commit(struct todo_item *item)
> 	{
> 		switch (item->command) {
> 		case TODO_PICK:
> 			return error(_("'%s'" is bad, plase use "
> 				       '%s %s'"),
> 				todo_command_info[item->command].str,
> 				"merge -C",
> 				oid_to_hex(item->commit->oid));
> 		...
> 		}
> 	}
>=20
> might go in a more friendly way.

I was asking basically the same thing in [1]. Quoting that part:

> I wonder how actionable these commands are. Can we give the full command
> that the user can use instead, including the commit ID?
>=20
> That raises another question though: how exactly is the user supposed to
> perform the merge? Should they merge the merge commit, resulting in two
> merge commits? Should they pick one of the sides, and if so, which one?
> I guess the answer is "it depends", which makes it harder for us to come
> up with actionable advice here.

So I think it's okay to not mention the exact commit here because we
cannot reliably second-guess the ultimate extent. My basic assumption is
that in many cases the user may not even be aware of them trying to pick
a merge commit, and that it may not have been their intent.

I might just as well be wrong about that assumption though.

Patrick

[1]: https://lore.kernel.org/git/Zg5D3dXYFM2SONE-@tanuki/

--lfbYzN/CZSR/y19o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUviEACgkQVbJhu7ck
PpRG6g/+NSrOwtu1lSPoJheTJDBf/9fzFiikayWtz7s0/wdm88K1Mulru46cv96V
re2PFGgmFYBhbuEB2dg/WCgUHDDL7BAUcOU7G+rB8ODqF/Jel+7Ox5pmSLyGypfG
eCDPqmTcj3Kv0ASxlDPKOa+NIPflDGpvgFJuhHO1qq3PMvzZDiJxYN1Sx7c7UHWi
WV1XqmrhTfLweSEBeMFpl9gyXgJ3VPg7HlYD2uBaEEH5TDhSh0l6VHeGEbjpwtZW
t0d3MQJTHaolik4XNCngdsGe1/ph74rSBUbEt/GzYIqhtD1IojhQALqNkK3EM73X
Mz99AOdFL3A/xjHTp/PcD/bQnFWduNXlNX39Xpi5iGtSpiXALzyX58ARUIvkRVBr
Z3+q3zwzvqUMZZo6cXGlTMNnG2x7YF2q3zAte8XFzHUL/ecqUXyv9brtt8KxIQgd
adRg/M92Y1HlLC8KXWuwMoEz6pVFpP6pvy1CBleiMxVOvJww+sGzjSXZV+em58k1
uj0tBb6i3xmsbK6e3KXdmjBsQ2/Zl6t9MkzZSjlCBhmJ/Xt6ZEpm++dCczpbKQT/
DA+i9Izg4yctkp3iQhSlFtL2A8VlwevxWoN7lKi7hzL9FzV/v/8eK0P4GT0xhet5
LGYdrFS+2btTyK66B2i8ogd0KoFEyvhYv8hMlh9wRuNNsjNTgVM=
=6WHI
-----END PGP SIGNATURE-----

--lfbYzN/CZSR/y19o--
