Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356254776
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712635440; cv=none; b=tsFGuvea3tzU/j20SpDOx/B4Gwgw2iq4Ln4Ztw+LjQxnr/hDGWYIEyLcl7kFSr7Wh9VyCfNYji6aMy+R2ezy2hzAGy2MUcnp2fZkTTm9AuozpG8w3oFLbEOy2oA8T9sQvK7z4LSfrC62KiSTPJB9pEj4cunpV30Wg4XKi7gonng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712635440; c=relaxed/simple;
	bh=/AWpNOLz6NXOEoOMrUw3b0GjQcrnXUZE4i8XE2Q/MjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH7AQwt+hvgobBDRcyd/NDeUw90d/MAgisn9wJmaczxnf7GR8u+Zd/Eg2wmHqMO8MWju9aTTtH0Ymn0JQnG5fywgFc/iL2tExQH8fovcSS3Vyt7aBQfUMecmyZXiZ4iVFB8us5broDtC1Y0uC7PwHjZqGFjVsCizMm/B5H/Vthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=id8T2TYv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1k2ikQK; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="id8T2TYv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1k2ikQK"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A24C61140163;
	Tue,  9 Apr 2024 00:03:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 09 Apr 2024 00:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712635437; x=1712721837; bh=IUpR982PN6
	CWI7LKL+M3PPwCyHEp8qSP78dEonZkQIw=; b=id8T2TYvBpchzZUy3Pvy2kRZy/
	cffxkOmWA+qFf00qVEffMq1u8uXvwWmX2KVFa7PXioixNIXUAVz72ryZsG1IoGZh
	s0RGxqGUBN7doVjWlU7j8I6x0NBvlHTrI1I8djZA5+tUJ/9cAaZyz0rMBzCIJQ7Q
	H/vAJbO4MWwQyTEByjJ0JTDvH8nwzd/8fzdKOoQR9bNoqU34M5parYNU4azWUwyK
	bpqQP1641GuZBQ0xE8+5irPSAGUPCbjdtX8D9jKB69mwIoqrIeOLFNitMp/SGq7B
	EQRacyM9IxwLpEXEuLyQU3ez/BMoOiff5CLh1sb0JljJoUbHiOxR/TmT2a7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712635437; x=1712721837; bh=IUpR982PN6CWI7LKL+M3PPwCyHEp
	8qSP78dEonZkQIw=; b=D1k2ikQK4vSHynxjaw5So2aE9cS3tB2NH1PF6OhPA2vX
	h+9KMH8XYln3Xp9GOhxLrsxGMG7mqhRuQ7ED9by4tQ0TXJnOpdEjqeLezf46++No
	Wq1b3heKlc2pHL+sKJ1P2KhjRUz9gSG4AiM0x6M0u6PcIKHgvLa+KhL+SJ0mkNFD
	BcnBdhaRfmfmB069dQdTyyXMtqfRYyeUCyH3AP4AUw8PxbelmBUe+KgyF+qiv+YF
	tki2CytDIkalSNNbHGS4Bg00PLXoovsye3Mikl8llOJ9BjT2xfAVhhymz8ClzAPs
	Sz+yBsc5HjqnTIs+0b3ZutFZ7PEoMYcWLZu1TtPpdA==
X-ME-Sender: <xms:Lb4UZls0Z4izTWwLuDemy4fJ7BBmntDQUFm-6LVS9XVYckp3IZqWqg>
    <xme:Lb4UZuco1UI--JMpcK9ZNN1ytxzcj4DtEi0KGGN25PpA4mTkB5liPW35fn-iXz2wS
    Jp75Z35DxGse259Yg>
X-ME-Received: <xmr:Lb4UZoxM1vVxJE3uT_tm7NYSQqGexkgUy46UySoJvLIGgMNMxSklbHafFMvaZznobv_damo3RoDANIoA7W4dWuI1mW3UqfqeLhzUSm2itfi2hSrUa40>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Lb4UZsPL93LErttuD4p_9UyIGfexb_12veUShcOqrrlAkl2EHOqNEQ>
    <xmx:Lb4UZl-4msLyndz2zw48lkTeaca0aJQqbcOdeZBMMaC9ljsBiclU9A>
    <xmx:Lb4UZsV2ALiy8CNmAKqi6yQb7SAFA1uml6436iYnDPucLoQmGbnD-g>
    <xmx:Lb4UZmchIYmevFMGhqj2sd8jRJsG7Kw1VaMkFuKQUHt4EBXdW2NdZw>
    <xmx:Lb4UZlxmRvUTSjtmyGTDrjoK-DSqUCAt-fVpAhHkGzlikOuJOVoUacLI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 00:03:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2bbf7781 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 04:03:49 +0000 (UTC)
Date: Tue, 9 Apr 2024 06:03:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/2] rebase -i: pass struct replay_opts to
 parse_insn_line()
Message-ID: <ZhS-KktVxRH-Xl3V@tanuki>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
 <1bcf92c6105e6e7ac2b2981575e112072fec383e.1712585787.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jK6b4bmu8dqtPj74"
Content-Disposition: inline
In-Reply-To: <1bcf92c6105e6e7ac2b2981575e112072fec383e.1712585787.git.gitgitgadget@gmail.com>


--jK6b4bmu8dqtPj74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 02:16:26PM +0000, Phillip Wood via GitGitGadget wro=
te:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>=20
> This new parameter will be used in the next commit.

Nit: we don't typically write commit messages as a continuation of their
subject. Other than that this commit looks good to me.

Patrick

> As adding the
> parameter requires quite a few changes to plumb it through the call
> chain these are separated into their own commit to avoid cluttering up
> the next commit with incidental changes.
>=20
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c     | 17 +++++++++++------
>  rebase-interactive.c | 21 +++++++++++++--------
>  rebase-interactive.h |  9 ++++++---
>  sequencer.c          | 22 ++++++++++++----------
>  sequencer.h          |  4 ++--
>  5 files changed, 44 insertions(+), 29 deletions(-)
>=20
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 891f28468e8..a33a2ed413a 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -194,7 +194,7 @@ static struct replay_opts get_replay_opts(const struc=
t rebase_options *opts)
>  	return replay;
>  }
> =20
> -static int edit_todo_file(unsigned flags)
> +static int edit_todo_file(unsigned flags, struct replay_opts *opts)
>  {
>  	const char *todo_file =3D rebase_path_todo();
>  	struct todo_list todo_list =3D TODO_LIST_INIT,
> @@ -205,7 +205,8 @@ static int edit_todo_file(unsigned flags)
>  		return error_errno(_("could not read '%s'."), todo_file);
> =20
>  	strbuf_stripspace(&todo_list.buf, comment_line_str);
> -	res =3D edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NUL=
L, flags);
> +	res =3D edit_todo_list(the_repository, opts, &todo_list, &new_todo,
> +			     NULL, NULL, flags);
>  	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_fil=
e,
>  					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
>  		res =3D error_errno(_("could not write '%s'"), todo_file);
> @@ -296,8 +297,8 @@ static int do_interactive_rebase(struct rebase_option=
s *opts, unsigned flags)
>  		error(_("could not generate todo list"));
>  	else {
>  		discard_index(&the_index);
> -		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
> -						&todo_list))
> +		if (todo_list_parse_insn_buffer(the_repository, &replay,
> +						todo_list.buf.buf, &todo_list))
>  			BUG("unusable todo list");
> =20
>  		ret =3D complete_action(the_repository, &replay, flags,
> @@ -352,9 +353,13 @@ static int run_sequencer_rebase(struct rebase_option=
s *opts)
>  		replay_opts_release(&replay_opts);
>  		break;
>  	}
> -	case ACTION_EDIT_TODO:
> -		ret =3D edit_todo_file(flags);
> +	case ACTION_EDIT_TODO: {
> +		struct replay_opts replay_opts =3D get_replay_opts(opts);
> +
> +		ret =3D edit_todo_file(flags, &replay_opts);
> +		replay_opts_release(&replay_opts);
>  		break;
> +	}
>  	case ACTION_SHOW_CURRENT_PATCH: {
>  		struct child_process cmd =3D CHILD_PROCESS_INIT;
> =20
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index c343e16fcdd..56fd7206a95 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -101,9 +101,10 @@ void append_todo_help(int command_count,
>  	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_str);
>  }
> =20
> -int edit_todo_list(struct repository *r, struct todo_list *todo_list,
> -		   struct todo_list *new_todo, const char *shortrevisions,
> -		   const char *shortonto, unsigned flags)
> +int edit_todo_list(struct repository *r, struct replay_opts *opts,
> +		   struct todo_list *todo_list, struct todo_list *new_todo,
> +		   const char *shortrevisions, const char *shortonto,
> +		   unsigned flags)
>  {
>  	const char *todo_file =3D rebase_path_todo(),
>  		*todo_backup =3D rebase_path_todo_backup();
> @@ -114,7 +115,9 @@ int edit_todo_list(struct repository *r, struct todo_=
list *todo_list,
>  	 * it.  If there is an error, we do not return, because the user
>  	 * might want to fix it in the first place. */
>  	if (!initial)
> -		incorrect =3D todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_=
list) |
> +		incorrect =3D todo_list_parse_insn_buffer(r, opts,
> +							todo_list->buf.buf,
> +							todo_list) |
>  			file_exists(rebase_path_dropped());
> =20
>  	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, sh=
ortonto,
> @@ -134,13 +137,13 @@ int edit_todo_list(struct repository *r, struct tod=
o_list *todo_list,
>  	if (initial && new_todo->buf.len =3D=3D 0)
>  		return -3;
> =20
> -	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
> +	if (todo_list_parse_insn_buffer(r, opts, new_todo->buf.buf, new_todo)) {
>  		fprintf(stderr, _(edit_todo_list_advice));
>  		return -4;
>  	}
> =20
>  	if (incorrect) {
> -		if (todo_list_check_against_backup(r, new_todo)) {
> +		if (todo_list_check_against_backup(r, opts, new_todo)) {
>  			write_file(rebase_path_dropped(), "%s", "");
>  			return -4;
>  		}
> @@ -228,13 +231,15 @@ int todo_list_check(struct todo_list *old_todo, str=
uct todo_list *new_todo)
>  	return res;
>  }
> =20
> -int todo_list_check_against_backup(struct repository *r, struct todo_lis=
t *todo_list)
> +int todo_list_check_against_backup(struct repository *r,
> +				   struct replay_opts *opts,
> +				   struct todo_list *todo_list)
>  {
>  	struct todo_list backup =3D TODO_LIST_INIT;
>  	int res =3D 0;
> =20
>  	if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
> -		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
> +		todo_list_parse_insn_buffer(r, opts, backup.buf.buf, &backup);
>  		res =3D todo_list_check(&backup, todo_list);
>  	}
> =20
> diff --git a/rebase-interactive.h b/rebase-interactive.h
> index 7239c60f791..8e5b181b334 100644
> --- a/rebase-interactive.h
> +++ b/rebase-interactive.h
> @@ -3,17 +3,20 @@
> =20
>  struct strbuf;
>  struct repository;
> +struct replay_opts;
>  struct todo_list;
> =20
>  void append_todo_help(int command_count,
>  		      const char *shortrevisions, const char *shortonto,
>  		      struct strbuf *buf);
> -int edit_todo_list(struct repository *r, struct todo_list *todo_list,
> -		   struct todo_list *new_todo, const char *shortrevisions,
> -		   const char *shortonto, unsigned flags);
> +int edit_todo_list(struct repository *r, struct replay_opts *opts,
> +		   struct todo_list *todo_list, struct todo_list *new_todo,
> +		   const char *shortrevisions, const char *shortonto,
> +		   unsigned flags);
> =20
>  int todo_list_check(struct todo_list *old_todo, struct todo_list *new_to=
do);
>  int todo_list_check_against_backup(struct repository *r,
> +				   struct replay_opts *opts,
>  				   struct todo_list *todo_list);
> =20
>  #endif
> diff --git a/sequencer.c b/sequencer.c
> index 2c19846385b..a3154ba3347 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2573,8 +2573,9 @@ static int check_label_or_ref_arg(enum todo_command=
 command, const char *arg)
>  	return 0;
>  }
> =20
> -static int parse_insn_line(struct repository *r, struct todo_item *item,
> -			   const char *buf, const char *bol, char *eol)
> +static int parse_insn_line(struct repository *r, struct replay_opts *opt=
s UNUSED,
> +			   struct todo_item *item, const char *buf,
> +			   const char *bol, char *eol)
>  {
>  	struct object_id commit_oid;
>  	char *end_of_object_name;
> @@ -2708,8 +2709,8 @@ int sequencer_get_last_command(struct repository *r=
 UNUSED, enum replay_action *
>  	return ret;
>  }
> =20
> -int todo_list_parse_insn_buffer(struct repository *r, char *buf,
> -				struct todo_list *todo_list)
> +int todo_list_parse_insn_buffer(struct repository *r, struct replay_opts=
 *opts,
> +				char *buf, struct todo_list *todo_list)
>  {
>  	struct todo_item *item;
>  	char *p =3D buf, *next_p;
> @@ -2727,7 +2728,7 @@ int todo_list_parse_insn_buffer(struct repository *=
r, char *buf,
> =20
>  		item =3D append_new_todo(todo_list);
>  		item->offset_in_buf =3D p - todo_list->buf.buf;
> -		if (parse_insn_line(r, item, buf, p, eol)) {
> +		if (parse_insn_line(r, opts, item, buf, p, eol)) {
>  			res =3D error(_("invalid line %d: %.*s"),
>  				i, (int)(eol - p), p);
>  			item->command =3D TODO_COMMENT + 1;
> @@ -2875,7 +2876,7 @@ static int read_populate_todo(struct repository *r,
>  	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
>  		return -1;
> =20
> -	res =3D todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
> +	res =3D todo_list_parse_insn_buffer(r, opts, todo_list->buf.buf, todo_l=
ist);
>  	if (res) {
>  		if (is_rebase_i(opts))
>  			return error(_("please fix this using "
> @@ -2905,7 +2906,7 @@ static int read_populate_todo(struct repository *r,
>  		struct todo_list done =3D TODO_LIST_INIT;
> =20
>  		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
> -		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
> +		    !todo_list_parse_insn_buffer(r, opts, done.buf.buf, &done))
>  			todo_list->done_nr =3D count_commands(&done);
>  		else
>  			todo_list->done_nr =3D 0;
> @@ -5251,7 +5252,8 @@ int sequencer_continue(struct repository *r, struct=
 replay_opts *opts)
>  			goto release_todo_list;
> =20
>  		if (file_exists(rebase_path_dropped())) {
> -			if ((res =3D todo_list_check_against_backup(r, &todo_list)))
> +			if ((res =3D todo_list_check_against_backup(r, opts,
> +								  &todo_list)))
>  				goto release_todo_list;
> =20
>  			unlink(rebase_path_dropped());
> @@ -6294,7 +6296,7 @@ int complete_action(struct repository *r, struct re=
play_opts *opts, unsigned fla
>  		return error(_("nothing to do"));
>  	}
> =20
> -	res =3D edit_todo_list(r, todo_list, &new_todo, shortrevisions,
> +	res =3D edit_todo_list(r, opts, todo_list, &new_todo, shortrevisions,
>  			     shortonto, flags);
>  	if (res =3D=3D -1)
>  		return -1;
> @@ -6322,7 +6324,7 @@ int complete_action(struct repository *r, struct re=
play_opts *opts, unsigned fla
>  	strbuf_release(&buf2);
>  	/* Nothing is done yet, and we're reparsing, so let's reset the count */
>  	new_todo.total_nr =3D 0;
> -	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
> +	if (todo_list_parse_insn_buffer(r, opts, new_todo.buf.buf, &new_todo) <=
 0)
>  		BUG("invalid todo list after expanding IDs:\n%s",
>  		    new_todo.buf.buf);
> =20
> diff --git a/sequencer.h b/sequencer.h
> index 437eabd38af..33943e5ed28 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -137,8 +137,8 @@ struct todo_list {
>  	.buf =3D STRBUF_INIT, \
>  }
> =20
> -int todo_list_parse_insn_buffer(struct repository *r, char *buf,
> -				struct todo_list *todo_list);
> +int todo_list_parse_insn_buffer(struct repository *r, struct replay_opts=
 *opts,
> +				char *buf, struct todo_list *todo_list);
>  int todo_list_write_to_file(struct repository *r, struct todo_list *todo=
_list,
>  			    const char *file, const char *shortrevisions,
>  			    const char *shortonto, int num, unsigned flags);
> --=20
> gitgitgadget
>=20

--jK6b4bmu8dqtPj74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUvikACgkQVbJhu7ck
PpS40g/+PZkn5T/rWKgOV19L9nlv0WOqjXeXWEN/vswjoCMAtkHTVuIfxB5yWI8m
+wDOPjvq7mHvwzwuJENlTO1OC/Ddqo8i6SvufPgj7ylQzbYKqdDcbl7qds/fmrY3
DU/JdiJfRDmLoYV8EyFm/WnrSCqklSSJ9FcGwRX3IwmuF7WxMO2B1sOC0KaczX1j
LJTL7geE/1dJmPPk/08oNKxpclj5xK1zM+nmCF33lJeRmFfckEL+aecAD4NdJxRQ
YzkDE7ci4eYU5hu1LTJDyBTCyBhd5cH8xivCORkyhyhHnX/qVu3wyXjLboCwZBwL
7bTQ7p/3yarEipmndl/OVAPhaVnGPXgXEIUC4sj2+DDCNu8KpuH0ASKq9rvGe/yj
GnPEQ7PzNNscXHkCcRaAI7i1afyJ64ZJbWPP3mbqvAjsUvH5pBfCZYlLQ5R+5j3x
Kjam6w6WyFCkjDUpS/XIrPDW/T+wLBSdAj4PBJ3DcbnjV40S4QsfadYSCaCf8xWi
d/kSzfOseFz90XX0a/H8kv6uJiCDRRfELSUZUrdhcF8fLPYNaH9SiSJkQ/Xfeqt7
Diq7hz09bg0bT24AGsOWf0UaXzfDdDKmjjNTvREP48wLHtIRCudXCrcg/rmFnJQh
xwksyRIp7p+lIOZwvE5eMzDvNx8u3qAEwyv8vmH5bGazr6sZOsk=
=21Z1
-----END PGP SIGNATURE-----

--jK6b4bmu8dqtPj74--
