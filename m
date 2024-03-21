Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B4E224F2
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017028; cv=none; b=W5FLoF1m5wLdeaOjkUfjndqia/Zn/bW3Tk9FNXt+yfAki8BXLFHjTrrTnnpdMozLworTY+bvGQVNNlkQBhzbBWI3qYcPxEg4Dp81AjUJmPzSIwSkdAbaYHjbx7LVseObxaAG6HiL/hMwCnuwgid35K/ML/q5Ibt8X7esq4xLkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017028; c=relaxed/simple;
	bh=vaVyjDgo6Hg+FvFdxorLdj56zRXJhYl3hsgcNjJJj+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH9c3ZMJLVbpD6LVQq9yVmwBumt2NhYL8Ithhl6lYY9WICyHEUwOO0tanDqdLXLHhTdgwlP6WhS9cNUifEUEzhTP1skAGQc36o3aWd8OqqhiVPUfeUmsMF0Ds2QvntUk4GjFMgtD1qToy1zkk1yCSDdu4Ndm8+LDz5B10OJ2omQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BBGbMIRJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d2XJxt4f; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BBGbMIRJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2XJxt4f"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4ABEA1380142;
	Thu, 21 Mar 2024 06:30:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Mar 2024 06:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711017024; x=1711103424; bh=FZr+bcrpTN
	N3xQ90x46IpLtS8o5K/zQAoHeoEfyW2NQ=; b=BBGbMIRJidEyAXidl8HZ0LEITu
	+75N8/aVZEAsankwuA454UMe14dxcGyABTKaYLwQIA6T4jUsfp4ay4XKAh9XHOWC
	1XL1V49GIzv7H+BSXCUEhzPhBTynaPW/tJBZM5+B0i9QHG31phB7AEKLd7g7y9ve
	/kIzIO6g/eJllxr6KNUI/yW0Cgv7pk53uD6MEOr3dhml6UMd9SJlJFS/Hs4WRDod
	Atc81bJllpGQWcxZ8lX0TDF6mw7Z7lcx7o4cyYCML1gCOvtMeZxV26VQuVB9suUH
	txTR0ak2S19QcmxNR+JRWTx/TMEPmdL1WkGWr75/NZ8mWVS1kFYiWSUamAUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711017024; x=1711103424; bh=FZr+bcrpTNN3xQ90x46IpLtS8o5K
	/zQAoHeoEfyW2NQ=; b=d2XJxt4fEIyoH4IWtuG4TiYgWVK0ryg20/BUPakOsy5r
	k7wq4kyRa21qCppLAR9gBBfyXWFU1V6x0xkkForrn6CFLkCTM930Yq20PrQG+lud
	qW+KEdkfXMtD5RGPL4lPG6wixL+nBt8Ntv2Pes4POkBrRDRawdpEhTeyCLrIHBix
	i+KsKXN68XymppVnNTRa8HoucW6/RF6srBwsHOAWKx+BBsV1yv+NfVUhA/Ugds0p
	Gq6rou1sgGee3G4EJ7E/7uPeR+8neuspg/rsiqekgy4guB3sRRDeNoGkndDoYgaG
	zupWWMxeDn0zSfvzs5QioZ/GWU5czZRN3JeVccz2Tw==
X-ME-Sender: <xms:QAz8ZYmdqp7Mk0wmQbE02TYKG_P5yGGJ5BUrVeCbXoGso4dsGDZcog>
    <xme:QAz8ZX1FcCg6MCLZXaKspzWld5-jBeX_Epy95vtFWKL2_H7qlxquIaDTGgiuMR1kP
    Gu2FAZ1Yz9bSRvqyA>
X-ME-Received: <xmr:QAz8ZWo82ILKV5AXI2ogSJZP5EDyw85tpdRalMaW9TAQtfugDfVklD3H3TJdtdXPBNRxZWRH7CBXQuyHMRLruXoc1lphBAn_CUVgFkuRupI7oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:QAz8ZUlh9N5olBz8Htu_hfDiVHKagtaZ6bepjo1o1zAaG4rk_e5DoQ>
    <xmx:QAz8ZW3GBLc6qYt9Jg6YM4xhuJEOY3hoZPfDrWBgsR9VxQ6x-bKebQ>
    <xmx:QAz8ZbsGsSqE5fa8dOKc0Dty456sG2wipDAxjpeFOpnFHz86Ogp-iw>
    <xmx:QAz8ZSVxbQpekD6Tlv6mMYkRxA0QS0GBCLG9WRV17pE5LnfbCVLf8Q>
    <xmx:QAz8ZZQfrPtXn90v-vw1j7VE2tY2_iUIHF9bh1mgl-gkppvR7c-jHw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 06:30:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de135630 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 10:30:18 +0000 (UTC)
Date: Thu, 21 Mar 2024 11:30:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Mohit Marathe <mohitmarathe@proton.me>
Subject: Re: [PATCH 1/2] utf8: change type from int to size_t
Message-ID: <ZfwMO-6IEXDm3z1b@tanuki>
References: <pull.1690.git.1710664071.gitgitgadget@gmail.com>
 <2e89da2e72b460228b3f77b1a5168f0a1fe0adcf.1710664071.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xAXqWTfYckAE2DEv"
Content-Disposition: inline
In-Reply-To: <2e89da2e72b460228b3f77b1a5168f0a1fe0adcf.1710664071.git.gitgitgadget@gmail.com>


--xAXqWTfYckAE2DEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 08:27:50AM +0000, Mohit Marathe via GitGitGadget wr=
ote:
> From: Mohit Marathe <mohitmarathe@proton.me>
>=20
> This update modifies the variable types that are used in calls to the
> `utf8_strnwidth` and `utf8_strwidth` functions. This modification is
> a proactive measure in anticipation of an upcoming interface change
> to these functions in the subsequent patch.

It would help to mention `utf8_str{,n}width()` in the commit subject so
that it's immediately obvious which functions get touched by this
commit.

> Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
> ---
>  builtin/blame.c    | 6 +++---
>  builtin/branch.c   | 2 +-
>  builtin/fetch.c    | 2 +-
>  builtin/worktree.c | 4 ++--
>  column.c           | 2 +-
>  diff.c             | 8 +++++---
>  gettext.c          | 2 +-
>  gettext.h          | 2 +-
>  pretty.c           | 4 ++--
>  utf8.c             | 4 ++--
>  wt-status.c        | 4 ++--
>  11 files changed, 21 insertions(+), 19 deletions(-)
>=20
> diff --git a/builtin/blame.c b/builtin/blame.c
> index db1f56de61a..a72e2552305 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -53,7 +53,7 @@ static const char *annotate_opt_usage[] =3D {
>  };
> =20
>  static int longest_file;

We also end up assigning `longest_file =3D num`, where `num` became a
`size_t` now. We should likely change this variable's type to `size_t`
as well.

> -static int longest_author;
> +static size_t longest_author;
>  static int max_orig_digits;
>  static int max_digits;
>  static int max_score_digits;
> @@ -529,7 +529,7 @@ static void emit_other(struct blame_scoreboard *sb, s=
truct blame_entry *ent, int
>  					name =3D ci.author_mail.buf;
>  				else
>  					name =3D ci.author.buf;
> -				pad =3D longest_author - utf8_strwidth(name);
> +				pad =3D cast_size_t_to_int(longest_author - utf8_strwidth(name));

I feel like this cast here is somewhat dubious. Both `longest_author`
and the return value of `utf8_strwidth()` are `size_t` now. So an
alternative way to handle this would be to assign the return value to a
temporary variable and then `if (longest_author > name_len) BUG(...)`.

>  				printf(" (%s%*s %10s",
>  				       name, pad, "",
>  				       format_time(ci.author_time,
> @@ -631,7 +631,7 @@ static void find_alignment(struct blame_scoreboard *s=
b, int *option)

A few lines before this hunk we declare `longest_src_lines` and
`longest_dst_lines` as `int`, but we assign `num` to them. We should fix
those to become `size_t`, as well. This will bubble up so that we also
have to fix `max_orig_digits` and `max_digits`.

>  	for (e =3D sb->ent; e; e =3D e->next) {
>  		struct blame_origin *suspect =3D e->suspect;
> -		int num;
> +		size_t num;
> =20
>  		if (compute_auto_abbrev)
>  			auto_abbrev =3D update_auto_abbrev(auto_abbrev, suspect);
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 8c2305ad2c8..321c3558f2d 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -349,7 +349,7 @@ static int calc_maxwidth(struct ref_array *refs, int =
remote_bonus)
>  	for (i =3D 0; i < refs->nr; i++) {
>  		struct ref_array_item *it =3D refs->items[i];
>  		const char *desc =3D it->refname;
> -		int w;
> +		size_t w;

This isn't sufficient as we end up assignign `max =3D w`, where `max` is
declared as `int`. We would thus also have to change that variable and
then change the return value of `calc_maxwidth()` itself to be `size_t`.

Furthermore, we do `w +=3D remote_bonus` in this function, where
`remote_bonus` is of type `int`. Is it guaranteed that this variable is
always positive? If so, it should likely become a `size_t`, too.
Otherwise we'll need to have some safety checks that the result does not
wrap.

>  		skip_prefix(it->refname, "refs/heads/", &desc);
>  		skip_prefix(it->refname, "refs/remotes/", &desc);
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 46a793411a4..fee992c3c14 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -705,7 +705,7 @@ static int refcol_width(const struct ref *ref_map, in=
t compact_format)
>  		max =3D max * 2 / 3;
> =20
>  	for (ref =3D ref_map; ref; ref =3D ref->next) {
> -		int rlen, llen =3D 0, len;
> +		size_t rlen, llen =3D 0, len;

We assign `width =3D rlen` further down, but `width` is an `int`. It
should likely be changed to become a `size_t` as well, which will
require us to change the return value of this function.

>  		if (ref->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
>  		    !ref->peer_ref ||
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 9c76b62b02d..bdbf46fb658 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -961,8 +961,8 @@ static void show_worktree_porcelain(struct worktree *=
wt, int line_terminator)
>  static void show_worktree(struct worktree *wt, int path_maxlen, int abbr=
ev_len)
>  {
>  	struct strbuf sb =3D STRBUF_INIT;
> -	int cur_path_len =3D strlen(wt->path);
> -	int path_adj =3D cur_path_len - utf8_strwidth(wt->path);
> +	size_t cur_path_len =3D strlen(wt->path);
> +	int path_adj =3D cast_size_t_to_int(cur_path_len - utf8_strwidth(wt->pa=
th));
>  	const char *reason;

I was wondering whether there should be a sanity check here for whether
`cur_path_len >=3D path_adj`. But given that both measure the length of
`wt->path`, and given that `utf8_strwidth()` should only ever return a
value smaller than the original length, I think this should be fine.

>  	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + path_adj, wt->path);
> diff --git a/column.c b/column.c
> index 50bbccc92ee..ec874036de6 100644
> --- a/column.c
> +++ b/column.c
> @@ -22,7 +22,7 @@ struct column_data {
>  };
> =20
>  /* return length of 's' in letters, ANSI escapes stripped */
> -static int item_length(const char *s)
> +static size_t item_length(const char *s)
>  {
>  	return utf8_strnwidth(s, strlen(s), 1);
>  }

The value of this function is assigned to `struct column_data::len`,
which is an array of `int`. That type needs to change.

> diff --git a/diff.c b/diff.c
> index e50def45383..4faf151345a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2629,7 +2629,8 @@ void print_stat_summary(FILE *fp, int files,
> =20
>  static void show_stats(struct diffstat_t *data, struct diff_options *opt=
ions)
>  {
> -	int i, len, add, del, adds =3D 0, dels =3D 0;
> +	int i, add, del, adds =3D 0, dels =3D 0;
> +	size_t len =3D 0;
>  	uintmax_t max_change =3D 0, max_len =3D 0;

It's somewhat weird that `max_len` is declared as `uintmax_t`. Should it
become a `size_t`, as well?

>  	int total_files =3D data->nr, count;
>  	int width, name_width, graph_width, number_width =3D 0, bin_width =3D 0;
> @@ -2780,7 +2781,8 @@ static void show_stats(struct diffstat_t *data, str=
uct diff_options *options)
>  		char *name =3D file->print_name;
>  		uintmax_t added =3D file->added;
>  		uintmax_t deleted =3D file->deleted;
> -		int name_len, padding;
> +		size_t name_len;

We compare `name_len` with `name_width`. The latter should likely become
a `size_t`, as well.

> +		int padding;
> =20
>  		if (!file->is_interesting && (added + deleted =3D=3D 0))
>  			continue;
> @@ -2809,7 +2811,7 @@ static void show_stats(struct diffstat_t *data, str=
uct diff_options *options)
>  			if (slash)
>  				name =3D slash;
>  		}
> -		padding =3D len - utf8_strwidth(name);
> +		padding =3D cast_size_t_to_int(len - utf8_strwidth(name));

I think we shouldn't abuse `cast_size_t_to_int()` like this but instead
explicitly check whether `len >=3D len(name)`.

>  		if (padding < 0)
>  			padding =3D 0;
> =20
> diff --git a/gettext.c b/gettext.c
> index 57facbc21ec..5a77b4f7202 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -127,7 +127,7 @@ void git_setup_gettext(void)
>  }
> =20
>  /* return the number of columns of string 's' in current locale */
> -int gettext_width(const char *s)
> +size_t gettext_width(const char *s)

We also need to adjust the callsite of this function. There's only a
single one in "builtin/fetch.c::display_ref_update()".

>  {
>  	static int is_utf8 =3D -1;
>  	if (is_utf8 =3D=3D -1)
> diff --git a/gettext.h b/gettext.h
> index 484cafa5628..f161a21b45c 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -31,7 +31,7 @@
>  #ifndef NO_GETTEXT
>  extern int git_gettext_enabled;
>  void git_setup_gettext(void);
> -int gettext_width(const char *s);
> +size_t gettext_width(const char *s);
>  #else
>  #define git_gettext_enabled (0)
>  static inline void git_setup_gettext(void)
> diff --git a/pretty.c b/pretty.c
> index bdbed4295aa..f03493c74b1 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1781,7 +1781,7 @@ static size_t format_and_pad_commit(struct strbuf *=
sb, /* in UTF-8 */
> =20
>  	if (padding < 0) {
>  		const char *start =3D strrchr(sb->buf, '\n');
> -		int occupied;
> +		size_t occupied;
>  		if (!start)
>  			start =3D sb->buf;
>  		occupied =3D utf8_strnwidth(start, strlen(start), 1);

We're assigning `padding =3D (-padding) - occupied` next, where `padding`
is of type `int`. We should add some safety checks here.

> @@ -1802,7 +1802,7 @@ static size_t format_and_pad_commit(struct strbuf *=
sb, /* in UTF-8 */
>  		placeholder++;
>  		total_consumed++;
>  	}
> -	len =3D utf8_strnwidth(local_sb.buf, local_sb.len, 1);
> +	len =3D cast_size_t_to_int(utf8_strnwidth(local_sb.buf, local_sb.len, 1=
));

Why did you decide to use `cast_size_t_to_int()` instead of converting
`len` to be of type `size_t`?

>  	if (c->flush_type =3D=3D flush_left_and_steal) {
>  		const char *ch =3D sb->buf + sb->len - 1;
> diff --git a/utf8.c b/utf8.c
> index 6bfaefa28eb..8ccdf684e07 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -466,7 +466,7 @@ int utf8_fprintf(FILE *stream, const char *format, ..=
=2E)
> =20
>  	columns =3D fputs(buf.buf, stream);
>  	if (0 <=3D columns) /* keep the error from the I/O */
> -		columns =3D utf8_strwidth(buf.buf);
> +		columns =3D cast_size_t_to_int(utf8_strwidth(buf.buf));
>  	strbuf_release(&buf);
>  	return columns;
>  }
> @@ -806,7 +806,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type=
 position, unsigned int wid
>  		       const char *s)
>  {
>  	size_t slen =3D strlen(s);
> -	int display_len =3D utf8_strnwidth(s, slen, 0);
> +	size_t display_len =3D utf8_strnwidth(s, slen, 0);
>  	int utf8_compensation =3D slen - display_len;
> =20
>  	if (display_len >=3D width) {

A few lines further down we have:

    int left =3D (width - dispay_len) / 2;

This should be changed to become a `size_t`.

> diff --git a/wt-status.c b/wt-status.c
> index 7108a92b52c..c847b4bb5ed 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -325,7 +325,7 @@ static int maxwidth(const char *(*label)(int), int mi=
nval, int maxval)
> =20
>  	for (i =3D minval; i <=3D maxval; i++) {
>  		const char *s =3D label(i);
> -		int len =3D s ? utf8_strwidth(s) : 0;
> +		size_t len =3D s ? utf8_strwidth(s) : 0;
>  		if (len > result)
>  			result =3D len;

`result` is of type `int`, so we'd have to change both its type as well
as the return type of `maxwidth()`.

>  	}
> @@ -341,7 +341,7 @@ static void wt_longstatus_print_unmerged_data(struct =
wt_status *s,
>  	static char *padding;
>  	static int label_width;
>  	const char *one, *how;
> -	int len;
> +	size_t len;
> =20
>  	if (!padding) {
>  		label_width =3D maxwidth(wt_status_unmerged_status_string, 1, 7);

`len` gets passed to the formatter "%.*s". Quoting fprintf(3p):

    A field width, or precision, or both, may be indicated by an
    <asterisk> ('*'). In this case an argument of type int supplies the
    field width or precision.

So this must be an `int` or otherwise bad things will happen depending
on the size of those types on your platform.

Patrick

--xAXqWTfYckAE2DEv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8DDoACgkQVbJhu7ck
PpRT8Q//ZBKfFpmKL5tkcu+CF5PCNLmrOwJkEDAQKwHzvriw2eV7TOXd6gOB429T
izEX6f2SEIPKHXL6vaOEenR+mnhdpmsYGNZ3JBkralbmIhszZMDRmarlruNcGeiE
qN6XKaynXtCWaOMgQPCfMpQsWX0/odTE6RTzkyWH0M4oTrae3vW4J+1Gb7MnxInL
FpDGjUT5f/KYRXD01Zb297Cz8ReAgs3IqPSS30fitImMklHSL6ZQ7yNRb2JBm47i
r2jpC82+w0j1bL6sLLKgu5OT7Vr3BALVDY78Icm5fsUBYQnGwLor4m4n47NHCMHA
nwI7X8rwSK6zIdysVO8CCjss0JPpgDZK1ys3CEHwQETOPwO3PosmadmoBFfPBEfQ
LFnTHGzYEPrCFrAjwG/hd3ed8lh59ql0FZ8vTGjE9cr3MWR/x/UG1aAIGeEJDWkm
rgXt4h/m8dF7sTjI2cNmFDD7+xvTZZT4p0P3CaZWEKS0AKh+hL8IJC1OLI79D9RN
kM7kbIJVCMLCYCQTmnNIthUKT+gBqHllh5XFpOgOzbTXqeli59e//5ybsIwdmeZD
z6+/QJX4nfHP728vPOyW8M/c5IBNdBTYxrsEJGmQa8VUE5jNXPUL5pG8ZZWs67yr
hE5NxEIqYLyfDMVNQmocoiMRiGb6dIGsCAFdHTnEqBezzGc0CtU=
=FFV4
-----END PGP SIGNATURE-----

--xAXqWTfYckAE2DEv--
