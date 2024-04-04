Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452905026E
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712210915; cv=none; b=JHJQ3vZYq+vSYFwmF52TI0idFn/U9dEiNxpF/fyGpm/6/Ay5iPcLA5I+MHDAvYIUYpOyLfhBGXSBhErp8KJ4/0lPLnqujYWxgkpA3cl/2uTgY1FugXdp4E9XncyfYLWhDE4AY1tyVp8qrGixifZ92AIOK7Blpr2cHvKjSvUwfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712210915; c=relaxed/simple;
	bh=hEtYlyWkZFt2riD0BjNaBDVrFaZI0fgGyn06ne9yO7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENbEzZfqUjuONNvwWYEv5ufl974N6GaLkukGVnHX4bPjCYSNFA/XHzj4uf4RtgFXEY0SXOBS1j2We5/kDMal3XuWCTlv3m2I9hN0zRrKEqYrKvTcGTow87tU6Vs5mqr82ecJEAoFp9Wu1YvV4v+xY4Y6+gbsy2dLHGiVD07lVkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZQXMY9SJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=haXGAazM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZQXMY9SJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="haXGAazM"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5D3C311400D9;
	Thu,  4 Apr 2024 02:08:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 04 Apr 2024 02:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712210912; x=1712297312; bh=XnOgNKesZ0
	jiIJgxjlwbxL2V/oe20XWENYmgNyi+f1U=; b=ZQXMY9SJJ6epm3yd6xK+bZpGRq
	VZnLoJSTTdG7qvckaWltQf8wD+fP6ugYiHzU2nokY5sDsU7ujLwbmB1AH3xM3bT1
	NoqCIYOvaSDvGglULaTvyxVPqPlvKcuQeT2HNGidONxHRaVRvpIkqqLSy3+0uIMm
	19PrIwD8Xm2EEFuO1zXjiU0op7yb0/aGij6cRd/oLGvSH/FQinK3E7gIG423YCej
	r3NQ503yZ3MdAtgnbWCllJ4Yls/WkEq7elgNbCZ4SAUZ9HSt8KawYlGrspf6ksNC
	6KuuBP1HzKfF/KCG0P56idjJPl4Vjysl+NA/0VO+ejkXnRRrbQsluQ/MSSGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712210912; x=1712297312; bh=XnOgNKesZ0jiIJgxjlwbxL2V/oe2
	0XWENYmgNyi+f1U=; b=haXGAazMUt5ALbnqODPiA+e7/MgEKQWNKnil1a4p1du8
	kDCHzhBqAVBrZl0Lfeo9ggb0WZywCCDy9OWt1UvC3uNgytGJYuZNMa3JE61qBA0N
	FZBGuKUQYRen3yTdF3nwKDTvif8fTZJerFw4O/S9Ibnagi/BxyOc+/lu+6N72mVn
	gR4UDBDhubGQx/mpW4I0W17QwgaLk1OC2KDlogWzW2W0Bu/rAbY07h95WTL+VOZ2
	IN43nUQSsplk9AYRVL/pS7Elre8Hb3RUWji8iNTinHPsUqUJpmIMXCcIg5ZaLA28
	VHa/BFyctYtuP5CteNJHSw/FaJ84WMsivlRvL6fvSQ==
X-ME-Sender: <xms:4EMOZj5pDMmljmPu_ACpadEokjugIO_eAKOEXovE4dLf6Gi_-MDS2g>
    <xme:4EMOZo6f9NEnEidjixGjDAXfTsXbJfRylLiemIDkIGqoxYWW0gPy9GHgnHqJBqb42
    tXdHrrqc8ubb8Jhfg>
X-ME-Received: <xmr:4EMOZqfbyV4ZkNGVQBUq1OaZZ3mWafykELWl1PTt2hHW21eT_kFMZF_CZD4gpwDusyyJhU9vOPWXEX5Afqjr7ZZGuGmXyjQVJvpOG5Zm6aCWyl7W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfev
    leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4EMOZkL8IUx80B75JrYzH2xkPxwv_-c736xWIAlRSEcCPvYAWB-s1g>
    <xmx:4EMOZnJ4N_iaaSD97aGpY-Y6x9GtjevAgmhPTThtvOdUo9_yFpYobg>
    <xmx:4EMOZtxQ0-tdnKTHu3i3G0vVOQB4M77pz8MnrGepxmyjPPc4SC7gGA>
    <xmx:4EMOZjKnDAnktscbLizdhnDpVMen-GjP5vw1coE-PkX14hqNqoK_oQ>
    <xmx:4EMOZv-ZfsBqD7oil0SwT0y-cuTlfZyjeIb61hpdrHnQlHx6b_00cwao>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 02:08:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c2132927 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 06:08:28 +0000 (UTC)
Date: Thu, 4 Apr 2024 08:08:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: improve error message when picking merge
Message-ID: <Zg5D3dXYFM2SONE-@tanuki>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ab+E2IdXzkDOUpEP"
Content-Disposition: inline
In-Reply-To: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>


--ab+E2IdXzkDOUpEP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:58:07AM +0000, Phillip Wood via GitGitGadget wro=
te:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>=20
> The only todo commands that accept a merge commit are "merge" and
> "reset". All the other commands like "pick" or "reword" fail when they
> try to pick a a merge commit and print the message
>=20
>     error: commit abc123 is a merge but no -m option was given.
>=20
> followed by a hint about the command being rescheduled. This message is
> designed to help the user when they cherry-pick a merge and forget to
> pass "-m". For users who are rebasing the message is confusing as there
> is no way for rebase to cherry-pick the merge.
>=20
> Improve the user experience by detecting the error when the todo list is
> parsed rather than waiting for the "pick" command to fail and print a
> message recommending the "merge" command instead. We recommend "merge"
> rather than "exec git cherry-pick -m ..." on the assumption that
> cherry-picking merges is relatively rare and it is more likely that the
> user chose "pick" by a mistake.
>=20
> It would be possible to support cherry-picking merges by allowing the
> user to pass "-m" to "pick" commands but that adds complexity to do
> something that can already be achieved with
>=20
>     exec git cherry-pick -m1 abc123

Okay. I think it's reasonable to abort early and give some advice here.
It's certainly a lot more user friendly than to abort during the rebase.
And if we ever gain the ability to e.g. `pick -m1` in the instruction
sheet directly we can adapt accordingly.

> The change is relatively straight forward but is complicated slightly as
> we now need to tell the parser if we're rebasing or not.
>=20
> Reported-by: Stefan Haller <lists@haller-berlin.de>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     rebase -i: improve error message when picking merge
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1672%2F=
phillipwood%2Frebase-reject-merges-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1672/phill=
ipwood/rebase-reject-merges-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1672
>=20
>  builtin/rebase.c              |  2 +-
>  rebase-interactive.c          |  7 ++---
>  sequencer.c                   | 49 ++++++++++++++++++++++++++++++-----
>  sequencer.h                   |  2 +-
>  t/t3404-rebase-interactive.sh | 33 +++++++++++++++++++++++
>  5 files changed, 81 insertions(+), 12 deletions(-)
>=20
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5b086f651a6..a33e41c44da 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -297,7 +297,7 @@ static int do_interactive_rebase(struct rebase_option=
s *opts, unsigned flags)
>  	else {
>  		discard_index(&the_index);
>  		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
> -						&todo_list))
> +						&todo_list, 1))

I think these booleans are somewhat hard to read. I may be
overengineering this, so please feel free to push back, but would it
make more sense to introduce a `unsigned flags` field and then have a
`PARSE_INSN_IS_REBASING` flag?

>  			BUG("unusable todo list");
> =20
>  		ret =3D complete_action(the_repository, &replay, flags,
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index d9718409b3d..78d5ed1a41d 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -114,7 +114,8 @@ int edit_todo_list(struct repository *r, struct todo_=
list *todo_list,
>  	 * it.  If there is an error, we do not return, because the user
>  	 * might want to fix it in the first place. */
>  	if (!initial)
> -		incorrect =3D todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_=
list) |
> +		incorrect =3D todo_list_parse_insn_buffer(r, todo_list->buf.buf,
> +							todo_list, 1) |
>  			file_exists(rebase_path_dropped());
> =20
>  	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, sh=
ortonto,
> @@ -134,7 +135,7 @@ int edit_todo_list(struct repository *r, struct todo_=
list *todo_list,
>  	if (initial && new_todo->buf.len =3D=3D 0)
>  		return -3;
> =20
> -	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
> +	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo, 1)) {
>  		fprintf(stderr, _(edit_todo_list_advice));
>  		return -4;
>  	}
> @@ -234,7 +235,7 @@ int todo_list_check_against_backup(struct repository =
*r, struct todo_list *todo_
>  	int res =3D 0;
> =20
>  	if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
> -		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
> +		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup, 1);
>  		res =3D todo_list_check(&backup, todo_list);
>  	}
> =20
> diff --git a/sequencer.c b/sequencer.c
> index 91de546b323..cf808c24d20 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2550,8 +2550,37 @@ static int check_label_or_ref_arg(enum todo_comman=
d command, const char *arg)
>  	return 0;
>  }
> =20
> +static int error_merge_commit(enum todo_command command)
> +{
> +	switch(command) {
> +	case TODO_PICK:
> +		return error(_("'%s' does not accept merge commits, "
> +			       "please use '%s'"),
> +			     todo_command_info[command].str, "merge -C");

I wonder how actionable these commands are. Can we give the full command
that the user can use instead, including the commit ID?

That raises another question though: how exactly is the user supposed to
perform the merge? Should they merge the merge commit, resulting in two
merge commits? Should they pick one of the sides, and if so, which one?
I guess the answer is "it depends", which makes it harder for us to come
up with actionable advice here.

> +	case TODO_REWORD:
> +		return error(_("'%s' does not accept merge commits, "
> +			       "please use '%s'"),
> +			     todo_command_info[command].str, "merge -c");

I was about to suggest that the above two cases should be merged. But
then I realized that it's "merge -c" here, but "merge -C" in the first
case.

Patrick

> +	case TODO_EDIT:
> +		return error(_("'%s' does not accept merge commits, "
> +			       "please use '%s' followed by '%s'"),
> +			     todo_command_info[command].str,
> +			     "merge -C", "break");
> +
> +	case TODO_FIXUP:
> +	case TODO_SQUASH:
> +		return error(_("cannot squash merge commit into another commit"));
> +
> +	default:
> +		BUG("unexpected todo_command");
> +	}
> +}
> +
>  static int parse_insn_line(struct repository *r, struct todo_item *item,
> -			   const char *buf, const char *bol, char *eol)
> +			   const char *buf, const char *bol, char *eol,
> +			   int rebasing)
>  {
>  	struct object_id commit_oid;
>  	char *end_of_object_name;
> @@ -2655,7 +2684,12 @@ static int parse_insn_line(struct repository *r, s=
truct todo_item *item,
>  		return status;
> =20
>  	item->commit =3D lookup_commit_reference(r, &commit_oid);
> -	return item->commit ? 0 : -1;
> +	if (!item->commit)
> +		return -1;
> +	if (rebasing && item->command !=3D TODO_MERGE &&
> +	    item->commit->parents && item->commit->parents->next)
> +		return error_merge_commit(item->command);
> +	return 0;
>  }
> =20
>  int sequencer_get_last_command(struct repository *r UNUSED, enum replay_=
action *action)
> @@ -2686,7 +2720,7 @@ int sequencer_get_last_command(struct repository *r=
 UNUSED, enum replay_action *
>  }
> =20
>  int todo_list_parse_insn_buffer(struct repository *r, char *buf,
> -				struct todo_list *todo_list)
> +				struct todo_list *todo_list, int rebasing)
>  {
>  	struct todo_item *item;
>  	char *p =3D buf, *next_p;
> @@ -2704,7 +2738,7 @@ int todo_list_parse_insn_buffer(struct repository *=
r, char *buf,
> =20
>  		item =3D append_new_todo(todo_list);
>  		item->offset_in_buf =3D p - todo_list->buf.buf;
> -		if (parse_insn_line(r, item, buf, p, eol)) {
> +		if (parse_insn_line(r, item, buf, p, eol, rebasing)) {
>  			res =3D error(_("invalid line %d: %.*s"),
>  				i, (int)(eol - p), p);
>  			item->command =3D TODO_COMMENT + 1;
> @@ -2852,7 +2886,8 @@ static int read_populate_todo(struct repository *r,
>  	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
>  		return -1;
> =20
> -	res =3D todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
> +	res =3D todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list,
> +					  is_rebase_i(opts));
>  	if (res) {
>  		if (is_rebase_i(opts))
>  			return error(_("please fix this using "
> @@ -2882,7 +2917,7 @@ static int read_populate_todo(struct repository *r,
>  		struct todo_list done =3D TODO_LIST_INIT;
> =20
>  		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
> -		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
> +		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done, 1))
>  			todo_list->done_nr =3D count_commands(&done);
>  		else
>  			todo_list->done_nr =3D 0;
> @@ -6286,7 +6321,7 @@ int complete_action(struct repository *r, struct re=
play_opts *opts, unsigned fla
>  	strbuf_release(&buf2);
>  	/* Nothing is done yet, and we're reparsing, so let's reset the count */
>  	new_todo.total_nr =3D 0;
> -	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
> +	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo, 1) < 0)
>  		BUG("invalid todo list after expanding IDs:\n%s",
>  		    new_todo.buf.buf);
> =20
> diff --git a/sequencer.h b/sequencer.h
> index dcef7bb99c0..ed2c4b38514 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -136,7 +136,7 @@ struct todo_list {
>  }
> =20
>  int todo_list_parse_insn_buffer(struct repository *r, char *buf,
> -				struct todo_list *todo_list);
> +				struct todo_list *todo_list, int rebasing);
>  int todo_list_write_to_file(struct repository *r, struct todo_list *todo=
_list,
>  			    const char *file, const char *shortrevisions,
>  			    const char *shortonto, int num, unsigned flags);
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 64b641002e4..20b8589ad07 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2203,6 +2203,39 @@ test_expect_success 'bad labels and refs rejected =
when parsing todo list' '
>  	test_path_is_missing execed
>  '
> =20
> +test_expect_success 'non-merge commands reject merge commits' '
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	git checkout E &&
> +	git merge I &&
> +	oid=3D$(git rev-parse HEAD) &&
> +	cat >todo <<-EOF &&
> +	pick $oid
> +	reword $oid
> +	edit $oid
> +	fixup $oid
> +	squash $oid
> +	EOF
> +	(
> +		set_replace_editor todo &&
> +		test_must_fail git rebase -i HEAD 2>actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	error: ${SQ}pick${SQ} does not accept merge commits, please use ${SQ}me=
rge -C${SQ}
> +	error: invalid line 1: pick $oid
> +	error: ${SQ}reword${SQ} does not accept merge commits, please use ${SQ}=
merge -c${SQ}
> +	error: invalid line 2: reword $oid
> +	error: ${SQ}edit${SQ} does not accept merge commits, please use ${SQ}me=
rge -C${SQ} followed by ${SQ}break${SQ}
> +	error: invalid line 3: edit $oid
> +	error: cannot squash merge commit into another commit
> +	error: invalid line 4: fixup $oid
> +	error: cannot squash merge commit into another commit
> +	error: invalid line 5: squash $oid
> +	You can fix this with ${SQ}git rebase --edit-todo${SQ} and then run ${S=
Q}git rebase --continue${SQ}.
> +	Or you can abort the rebase with ${SQ}git rebase --abort${SQ}.
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>  	test_editor_unchanged
>=20
> base-commit: c875e0b8e036c12cfbf6531962108a063c7a821c
> --=20
> gitgitgadget
>=20

--ab+E2IdXzkDOUpEP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOQ9wACgkQVbJhu7ck
PpQFFg/9G7fCkCllT4lCPpursSjyddqYf9k7HdBxc1xSyJ0a4tbK2VrrBA0fdk58
l8E6+3iJ14J7pYZ6BTrS6T16aCXCnrfCpM+/54n9y3Hv+baxxfKD1ApsdAyBi0ft
XRa9Rr5+uNZ56C7HJm//q4RNOU+vPnSlIaznQmc8+nkJ6yh0M2JtD8JFPpKk3y1l
tR3Gs1KMDFBXoSBPL2x4WcRLvLwgBizvyz1tp6syslVJF+8cZfayYGFsz+NlQsgb
chaqXMcMeIrnEPqjFPzm2aKj9LvTGqspHVhASPocvIXuFI0Wh/AHQSuhxhJBjvVu
nTgl7gfNMwtUrd1GyZoZTR8dT5eY6x5J7RXhBgaybLyPD1gDLo3gN+IiOJ2JPRbB
xOYM4iE8aZ7AT0/oOjclrZzuFRk9bI19ZBPOw+LV7bB5udKzljhfYAFJTG/1SAd7
c3KqnwMyKwD+y3cOHESZfhoVyuHZ3ePYaDpe1JiHp7DMov6bU4sU2dBEsrVFSMDf
cWPfDJL7/GqfRuJZvjFnLL/Opo54Bwe3AgrmWbV7ODaaq8C1FdzDShfx3Hc9cCwa
0w26HPCOwIQ0jBkvsA2d/5MBdLsvEN2F8LycuRAehrp/BnM8s7zioO8ooxc02O2N
31ErKK09OTTZbzE5PEavFzK25yEiekn3ShzJiUNL5STESsRGAlY=
=LQbx
-----END PGP SIGNATURE-----

--ab+E2IdXzkDOUpEP--
