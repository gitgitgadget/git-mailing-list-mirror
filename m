Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DA2033E
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614071; cv=none; b=JD59ZY7Rs2DY00Fm5wG9H2+NtgB9IBu5yA3Now7wAY6dbzNkhP76XKwVfwDcQ13qHLgSJZjE2VE5Ci82eP1TboVRbP5VOYRmhDhT0ntgA3EMQZ5gbjcyOAaUfriHuTNg2Qfoc7U/5kdo2jmgq3CUMx4TbZrWVyyBgjZ01GUfgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614071; c=relaxed/simple;
	bh=0tstm4I8fXe+FW2FcsJYe376jQc8DJiLmOV8JqX7QpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbAXg3Fx3AjN2KW1Oq8/8HzjN3EqvWw73CQT6UMOHnLKoDKUizsrCIyFbmQpzotf/HzEfQvXzfcQyDnMqUPQvg3dFGpu6DeJ27+GzVP3wjAw5OrmnGiq6RQY3dxBc9d0oc/LZjgvgHQtJv/ZS37dxcJ8biuAM+WpD+rsXi/rcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BYctrsW9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A0q+WiZs; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BYctrsW9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A0q+WiZs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0F9D218000C8;
	Thu, 28 Mar 2024 04:21:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 04:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711614066; x=1711700466; bh=cGwqkNGGf3
	xB8HAlcFgMU406S+66UVftYHMdQFSBNGI=; b=BYctrsW9vXXeYieZDoYFxGfuE+
	t1TeapKia355IQyTJZhXZbqxwo1X3yiWLdHbzKZP+cO/HCXGC0ZnllpqsFrcZQp7
	CIQuSvH/eYdp0sPnRo1+3B4tYCuOnyhokuV1hZ3ojaQDHxnnNWNVQTf3hyQ4USnW
	53ZNAuTzUkF+3WJSfTyrS2YlRgnnyDD4dZvwAtTrZmzS53M6YIFB4+oFpDNuJJC1
	CVLePTHAElqUwwFTwgqe4HtELgp7V/mAADm7hoNnLEBCtoj2Itq148Ruy3H4ouIP
	CPsc3uT01jRMgxCfcri7XV4cZV0B7JrX/7V0R4S8JqFCpwZoDoDCbSSGQv7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711614066; x=1711700466; bh=cGwqkNGGf3xB8HAlcFgMU406S+66
	UVftYHMdQFSBNGI=; b=A0q+WiZs7n1sLklVDrAlm1TAO7din1oTsD2aJEbkstSu
	3KZHHLOAelDTRc9mBmQKDRffUxMkag1zE5bMOYeytWMbi1JCQpXQ/YOTP4gdIay1
	dmlWkZ41golK9/iqMSZXb6YfjnEQBmphx5jSAj5AX8fxD7sWnSe6xZwE/ZXIMN9q
	TaM+SooaIIxHJiqJqygizq2C2eoNmsG1cqZWXDLlI2jhp7bH0F/tKfESk5xsH8HM
	TghkW9IshqgEy83qNaiGg9jJl9OHiYjBBPF8CJBKrH4gkxc47oT2Bxe5EdacOtJE
	cj6wPm/VIoxkqW2Ux+T3SriOzBAxyyh6s3UnvbUApw==
X-ME-Sender: <xms:cigFZrEJNUEJ5xLCddGJuW0MVbccNacKt1VCQ0cZqrX0kBAtDHvOPQ>
    <xme:cigFZoVCbB8DOG_Uu2FLOYAA-0a72RIw7R2fr3tMPHwvlo_cVkszgtg3xsYBwg9ya
    kAowiUVnh6KUMNPqQ>
X-ME-Received: <xmr:cigFZtIo2ERL9smmNKJjJ_eIs3bxYpp2eQjHNZcUBCuJRd-ujiXBB-cHAgrjpFZuWxXAp26POzptVC4iFC4f2uvNsG5ycrNobF2PXnWQgz-IW6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddukedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:cigFZpF5MYdyvOh1tPbqwMV21q05bTTj4-d0CLdUTfzUDdE0fU8BRQ>
    <xmx:cigFZhXNOA8tlZb6aYMbuV1yG6u_x0TJGxCjrQbRCjOvlicAGdvakg>
    <xmx:cigFZkPMskmT5TCAJZFLGeEhIVGWYu9SKI6q2mGaveCB0fG5zEwvBA>
    <xmx:cigFZg28Bt-abG5yR4mauxpgnsn5diP_DA5pOj5MCabkG2w_BZy91A>
    <xmx:cigFZnzffISZkIWBMgIH0Ghk_2Hi_2gcZV4vKL_L3WsEiP4lwyEDebiG3CY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Mar 2024 04:21:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b7261cb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Mar 2024 08:21:02 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:21:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/6] fast-import: tighten parsing of paths
Message-ID: <ZgUobnAVRCfyu1k7@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <20240322000304.76810-2-thalia@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OogWr0Q0Lik/mDHk"
Content-Disposition: inline
In-Reply-To: <20240322000304.76810-2-thalia@archibald.dev>


--OogWr0Q0Lik/mDHk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:03:18AM +0000, Thalia Archibald wrote:
> Path parsing in fast-import is inconsistent and many unquoting errors
> are suppressed.
>=20
> `<path>` appears in the grammar in these places:
>=20
>     filemodify ::=3D 'M' SP <mode> (<dataref> | 'inline') SP <path> LF
>     filedelete ::=3D 'D' SP <path> LF
>     filecopy   ::=3D 'C' SP <path> SP <path> LF
>     filerename ::=3D 'R' SP <path> SP <path> LF
>     ls         ::=3D 'ls' SP <dataref> SP <path> LF
>     ls-commit  ::=3D 'ls' SP <path> LF
>=20
> and fast-import.c parses them in five different ways:
>=20
> 1. For filemodify and filedelete:
>    If `<path>` is a valid quoted string, unquote it;
>    otherwise, treat it as literal bytes (including any number of SP).
> 2. For filecopy (source) and filerename (source):
>    If `<path>` is a valid quoted string, unquote it;
>    otherwise, treat it as literal bytes until the next SP.
> 3. For filecopy (dest) and filerename (dest):
>    Like 1., but an unquoted empty string is an error.
> 4. For ls:
>    If `<path>` starts with `"`, unquote it and report parse errors;
>    otherwise, treat it as literal bytes (including any number of SP).
> 5. For ls-commit:
>    Unquote `<path>` and report parse errors.
>    (It must start with `"` to disambiguate from ls.)
>=20
> In the first three, any errors from trying to unquote a string are
> suppressed, so a quoted string that contains invalid escapes would be
> interpreted as literal bytes. For example, `"\xff"` would fail to
> unquote (because hex escapes are not supported), and it would instead be
> interpreted as the byte sequence `"` `\` `x` `f` `f` `"`, which is
> certainly not intended. Some front-ends erroneously use their language's
> standard quoting routine and could silently introduce escapes that would
> be incorrectly parsed due to this.
>=20
> The documentation states that =E2=80=9CTo use a source path that contains=
 SP the
> path must be quoted.=E2=80=9D, so it is expected that some implementations
> depend on spaces being allowed in paths in the final position. Thus we
> have two documented ways to parse paths, so simplify the implementation
> to that.
>=20
> Now we have:
>=20
> 1. `parse_path_eol` for filemodify, filedelete, filecopy (dest),
>    filerename (dest), ls, and ls-commit:
>=20
>    If `<path>` starts with `"`, unquote it and report parse errors;
>    otherwise, treat it as literal bytes (including any number of SP).
>    Garbage after a quoted string or an unquoted empty string are errors.
>    (In ls-commit, it must be quoted to disambiguate from ls.)
>=20
> 2. `parse_path_space` for filecopy (source) and filerename (source):
>=20
>    If `<path>` starts with `"`, unquote it and report parse errors;
>    otherwise, treat it as literal bytes until the next SP.
>    It must be followed by a SP. An unquoted empty string is an error.
>=20
> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  Documentation/git-fast-import.txt |   3 +-
>  builtin/fast-import.c             | 115 ++++++++------
>  t/t9300-fast-import.sh            | 252 +++++++++++++++++++++++++++++-
>  3 files changed, 316 insertions(+), 54 deletions(-)
>=20
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-i=
mport.txt
> index b2607366b9..271bd63a10 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -649,7 +649,8 @@ The value of `<path>` must be in canonical form. That=
 is it must not:
>  * contain the special component `.` or `..` (e.g. `foo/./bar` and
>    `foo/../bar` are invalid).
> =20
> -The root of the tree can be represented by an empty string as `<path>`.
> +The root of the tree can be represented by a quoted empty string (`""`)
> +as `<path>`.

So this is part of the "filemodify" section with the following syntax:

    'M' SP <mode> SP <dataref> SP <path> LF

The way I interpret this change is that <path> could previously be empty
(`SP LF`), but now it needs to be quoted (`SP '"' '"' LF). This seems to
be related to cases (1) and (3) of your commit messages, where
"filemodify" could contain an unquoted empty string whereas "filecopy"
and "filerename" would complain about such an unquoted string.

In any case I don't see a strong argument why exactly it should be
forbidden to have an unquoted empty path here, and I do wonder whether
it would break existing writers of the format when we retroactively
tighten this case. Isn't it possible to instead loosen it such that all
three of the above actions know to handle unquoted empty paths?

>  It is recommended that `<path>` always be encoded using UTF-8.
> =20
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 71a195ca22..b2adec8d9a 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2224,7 +2224,7 @@ static int parse_mapped_oid_hex(const char *hex, st=
ruct object_id *oid, const ch
>   *
>   *   idnum ::=3D ':' bigint;
>   *
> - * Return the first character after the value in *endptr.
> + * Update *endptr to point to the first character after the value.

I think it would make sense to put these improvements for comments into
a separate commit. Otherwise it makes you wonder whether this behaviour
is new now.

>   * Complain if the following character is not what is expected,
>   * either a space or end of the string.
> @@ -2257,8 +2257,8 @@ static uintmax_t parse_mark_ref_eol(const char *p)
>  }
> =20
>  /*
> - * Parse the mark reference, demanding a trailing space.  Return a
> - * pointer to the space.
> + * Parse the mark reference, demanding a trailing space. Update *p to
> + * point to the first character after the space.
>   */

Same.

>  static uintmax_t parse_mark_ref_space(const char **p)
>  {
> @@ -2272,10 +2272,57 @@ static uintmax_t parse_mark_ref_space(const char =
**p)
>  	return mark;
>  }
> =20
> +/*
> + * Parse the path string into the strbuf. It may be quoted with escape s=
equences
> + * or unquoted without escape sequences. When unquoted, it may only cont=
ain a
> + * space if `allow_spaces` is nonzero.
> + */
> +static void parse_path(struct strbuf *sb, const char *p, const char **en=
dp, int allow_spaces, const char *field)
> +{
> +	strbuf_reset(sb);

It's not all that customary in our codebase to have the function reset
the `strbuf` for the caller because it does make the function less
flexible. I would either keep the `strbuf_reset()` on the caller side or
at least document this behaviour in the comment.

> +	if (*p =3D=3D '"') {
> +		if (unquote_c_style(sb, p, endp))
> +			die("Invalid %s: %s", field, command_buf.buf);
> +	} else {
> +		if (allow_spaces)
> +			*endp =3D p + strlen(p);

I wonder whether `stop_at_unquoted_space` might be more telling. It's
not like we disallow spaces here, it's that we treat them as the
separator to the next field.

> +		else
> +			*endp =3D strchr(p, ' ');
> +		if (*endp =3D=3D p)
> +			die("Missing %s: %s", field, command_buf.buf);

Error messages should start with a lower-case letter and be
translateable. But these are simply moved over from the previous code,
so I don't mind much if you want to keep them as-is.

> +		strbuf_add(sb, p, *endp - p);
> +	}
> +}
> +
> +/*
> + * Parse the path string into the strbuf, and complain if this is not th=
e end of
> + * the string. It may contain spaces even when unquoted.
> + */
> +static void parse_path_eol(struct strbuf *sb, const char *p, const char =
*field)
> +{
> +	const char *end;
> +
> +	parse_path(sb, p, &end, 1, field);
> +	if (*end)
> +		die("Garbage after %s: %s", field, command_buf.buf);
> +}
> +
> +/*
> + * Parse the path string into the strbuf, and ensure it is followed by a=
 space.
> + * It may not contain spaces when unquoted. Update *endp to point to the=
 first
> + * character after the space.
> + */
> +static void parse_path_space(struct strbuf *sb, const char *p, const cha=
r **endp, const char *field)
> +{
> +	parse_path(sb, p, endp, 0, field);
> +	if (**endp !=3D ' ')
> +		die("Missing space after %s: %s", field, command_buf.buf);
> +	(*endp)++;
> +}
> +
>  static void file_change_m(const char *p, struct branch *b)
>  {
>  	static struct strbuf uq =3D STRBUF_INIT;
> -	const char *endp;
>  	struct object_entry *oe;
>  	struct object_id oid;
>  	uint16_t mode, inline_data =3D 0;
> @@ -2312,12 +2359,8 @@ static void file_change_m(const char *p, struct br=
anch *b)
>  			die("Missing space after SHA1: %s", command_buf.buf);
>  	}
> =20
> -	strbuf_reset(&uq);
> -	if (!unquote_c_style(&uq, p, &endp)) {
> -		if (*endp)
> -			die("Garbage after path in: %s", command_buf.buf);
> -		p =3D uq.buf;
> -	}
> +	parse_path_eol(&uq, p, "path");
> +	p =3D uq.buf;

This is loosening the condition so that we also accept unquoted paths
now. Okay.

> =20
>  	/* Git does not track empty, non-toplevel directories. */
>  	if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *p) {
> @@ -2381,48 +2424,23 @@ static void file_change_m(const char *p, struct b=
ranch *b)
>  static void file_change_d(const char *p, struct branch *b)
>  {
>  	static struct strbuf uq =3D STRBUF_INIT;
> -	const char *endp;
> =20
> -	strbuf_reset(&uq);
> -	if (!unquote_c_style(&uq, p, &endp)) {
> -		if (*endp)
> -			die("Garbage after path in: %s", command_buf.buf);
> -		p =3D uq.buf;
> -	}
> +	parse_path_eol(&uq, p, "path");
> +	p =3D uq.buf;
>  	tree_content_remove(&b->branch_tree, p, NULL, 1);
>  }

Same.

> -static void file_change_cr(const char *s, struct branch *b, int rename)
> +static void file_change_cr(const char *p, struct branch *b, int rename)
>  {
> -	const char *d;
> +	const char *s, *d;
>  	static struct strbuf s_uq =3D STRBUF_INIT;
>  	static struct strbuf d_uq =3D STRBUF_INIT;
> -	const char *endp;
>  	struct tree_entry leaf;
> =20
> -	strbuf_reset(&s_uq);
> -	if (!unquote_c_style(&s_uq, s, &endp)) {
> -		if (*endp !=3D ' ')
> -			die("Missing space after source: %s", command_buf.buf);
> -	} else {
> -		endp =3D strchr(s, ' ');
> -		if (!endp)
> -			die("Missing space after source: %s", command_buf.buf);
> -		strbuf_add(&s_uq, s, endp - s);
> -	}
> +	parse_path_space(&s_uq, p, &p, "source");
> +	parse_path_eol(&d_uq, p, "dest");
>  	s =3D s_uq.buf;
> -
> -	endp++;
> -	if (!*endp)
> -		die("Missing dest: %s", command_buf.buf);
> -
> -	d =3D endp;
> -	strbuf_reset(&d_uq);
> -	if (!unquote_c_style(&d_uq, d, &endp)) {
> -		if (*endp)
> -			die("Garbage after dest in: %s", command_buf.buf);
> -		d =3D d_uq.buf;
> -	}
> +	d =3D d_uq.buf;

Nice simplification. The source path should behave the same, and parsing
of the destination path has been loosened to also allow unquoted paths.

>  	memset(&leaf, 0, sizeof(leaf));
>  	if (rename)
> @@ -3168,6 +3186,7 @@ static void parse_ls(const char *p, struct branch *=
b)
>  {
>  	struct tree_entry *root =3D NULL;
>  	struct tree_entry leaf =3D {NULL};
> +	static struct strbuf uq =3D STRBUF_INIT;

I know the code had this as a static variable before, as well. But is
this really necessary? Can't we leave it as non-static and then release
the buffer at the end of this function?

>  	/* ls SP (<tree-ish> SP)? <path> */
>  	if (*p =3D=3D '"') {
> @@ -3182,16 +3201,8 @@ static void parse_ls(const char *p, struct branch =
*b)
>  			root->versions[1].mode =3D S_IFDIR;
>  		load_tree(root);
>  	}
> -	if (*p =3D=3D '"') {
> -		static struct strbuf uq =3D STRBUF_INIT;
> -		const char *endp;
> -		strbuf_reset(&uq);
> -		if (unquote_c_style(&uq, p, &endp))
> -			die("Invalid path: %s", command_buf.buf);
> -		if (*endp)
> -			die("Garbage after path in: %s", command_buf.buf);
> -		p =3D uq.buf;
> -	}
> +	parse_path_eol(&uq, p, "path");
> +	p =3D uq.buf;

And this case should behave the same.

>  	tree_content_get(root, p, &leaf, 1);
>  	/*
>  	 * A directory in preparation would have a sha1 of zero
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index dbb5042b0b..ef04b43f46 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -2146,6 +2146,7 @@ test_expect_success 'Q: deny note on empty branch' '
>  	EOF
>  	test_must_fail git fast-import <input
>  '
> +
>  ###
>  ### series R (feature and option)
>  ###
> @@ -2794,7 +2795,7 @@ test_expect_success 'R: blob appears only once' '
>  '
> =20
>  ###
> -### series S
> +### series S (mark and path parsing)
>  ###
>  #
>  # Make sure missing spaces and EOLs after mark references
> @@ -3064,6 +3065,255 @@ test_expect_success 'S: ls with garbage after sha=
1 must fail' '
>  	test_grep "space after tree-ish" err
>  '
> =20
> +#
> +# Path parsing
> +#
> +# There are two sorts of ways a path can be parsed, depending on whether=
 it is
> +# the last field on the line. Additionally, ls without a <tree-ish> has a
> +# special case. Test every occurrence of <path> in the grammar against e=
very
> +# error case.
> +#
> +
> +#
> +# Valid paths at the end of a line: filemodify, filedelete, filecopy (de=
st),
> +# filerename (dest), and ls.
> +#
> +# commit :301 from root -- modify hello.c
> +# commit :302 from :301 -- modify $path
> +# commit :303 from :302 -- delete $path
> +# commit :304 from :301 -- copy hello.c $path
> +# commit :305 from :301 -- rename hello.c $path
> +# ls :305 $path
> +#
> +test_path_eol_success () {
> +	test=3D"$1" path=3D"$2" unquoted_path=3D"$3"

Should these variables be local?

> +	test_expect_success "S: paths at EOL with $test must work" '
> +		git fast-import --export-marks=3Dmarks.out <<-EOF >out 2>err &&
> +		blob
> +		mark :401
> +		data <<BLOB
> +		hello world
> +		BLOB
> +
> +		blob
> +		mark :402
> +		data <<BLOB
> +		hallo welt
> +		BLOB
> +
> +		commit refs/heads/path-eol
> +		mark :301
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		initial commit
> +		COMMIT
> +		M 100644 :401 hello.c
> +
> +		commit refs/heads/path-eol
> +		mark :302
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filemodify
> +		COMMIT
> +		from :301
> +		M 100644 :402 '"$path"'
> +
> +		commit refs/heads/path-eol
> +		mark :303
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filedelete
> +		COMMIT
> +		from :302
> +		D '"$path"'
> +
> +		commit refs/heads/path-eol
> +		mark :304
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filecopy dest
> +		COMMIT
> +		from :301
> +		C hello.c '"$path"'
> +
> +		commit refs/heads/path-eol
> +		mark :305
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filerename dest
> +		COMMIT
> +		from :301
> +		R hello.c '"$path"'
> +
> +		ls :305 '"$path"'
> +		EOF
> +
> +		commit_m=3D$(grep :302 marks.out | cut -d\  -f2) &&
> +		commit_d=3D$(grep :303 marks.out | cut -d\  -f2) &&
> +		commit_c=3D$(grep :304 marks.out | cut -d\  -f2) &&
> +		commit_r=3D$(grep :305 marks.out | cut -d\  -f2) &&
> +		blob1=3D$(grep :401 marks.out | cut -d\  -f2) &&
> +		blob2=3D$(grep :402 marks.out | cut -d\  -f2) &&
> +
> +		( printf "100644 blob $blob2\t'"$unquoted_path"'\n" &&
> +		  printf "100644 blob $blob1\thello.c\n" ) | sort >tree_m.exp &&
> +		git ls-tree $commit_m | sort >tree_m.out &&
> +		test_cmp tree_m.exp tree_m.out &&
> +
> +		printf "100644 blob $blob1\thello.c\n" >tree_d.exp &&
> +		git ls-tree $commit_d >tree_d.out &&
> +		test_cmp tree_d.exp tree_d.out &&
> +
> +		( printf "100644 blob $blob1\t'"$unquoted_path"'\n" &&
> +		  printf "100644 blob $blob1\thello.c\n" ) | sort >tree_c.exp &&
> +		git ls-tree $commit_c | sort >tree_c.out &&
> +		test_cmp tree_c.exp tree_c.out &&
> +
> +		printf "100644 blob $blob1\t'"$unquoted_path"'\n" >tree_r.exp &&
> +		git ls-tree $commit_r >tree_r.out &&
> +		test_cmp tree_r.exp tree_r.out &&
> +
> +		test_cmp out tree_r.exp &&
> +
> +		git branch -D path-eol
> +	'
> +}
> +
> +test_path_eol_success 'quoted spaces'   '" hello world.c "' ' hello worl=
d.c '
> +test_path_eol_success 'unquoted spaces' ' hello world.c '   ' hello worl=
d.c '
> +
> +#
> +# Valid paths before a space: filecopy (source) and filerename (source).
> +#
> +# commit :301 from root -- modify $path
> +# commit :302 from :301 -- copy $path hello2.c
> +# commit :303 from :301 -- rename $path hello2.c
> +#
> +test_path_space_success () {
> +	test=3D"$1" path=3D"$2" unquoted_path=3D"$3"

Same question here, should these be local?

> +	test_expect_success "S: paths before space with $test must work" '
> +		git fast-import --export-marks=3Dmarks.out <<-EOF 2>err &&
> +		blob
> +		mark :401
> +		data <<BLOB
> +		hello world
> +		BLOB
> +
> +		commit refs/heads/path-space
> +		mark :301
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		initial commit
> +		COMMIT
> +		M 100644 :401 '"$path"'
> +
> +		commit refs/heads/path-space
> +		mark :302
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filecopy source
> +		COMMIT
> +		from :301
> +		C '"$path"' hello2.c
> +
> +		commit refs/heads/path-space
> +		mark :303
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filerename source
> +		COMMIT
> +		from :301
> +		R '"$path"' hello2.c
> +
> +		EOF
> +
> +		commit_c=3D$(grep :302 marks.out | cut -d\  -f2) &&
> +		commit_r=3D$(grep :303 marks.out | cut -d\  -f2) &&
> +		blob=3D$(grep :401 marks.out | cut -d\  -f2) &&
> +
> +		( printf "100644 blob $blob\t'"$unquoted_path"'\n" &&
> +		  printf "100644 blob $blob\thello2.c\n" ) | sort >tree_c.exp &&
> +		git ls-tree $commit_c | sort >tree_c.out &&
> +		test_cmp tree_c.exp tree_c.out &&
> +
> +		printf "100644 blob $blob\thello2.c\n" >tree_r.exp &&
> +		git ls-tree $commit_r >tree_r.out &&
> +		test_cmp tree_r.exp tree_r.out &&
> +
> +		git branch -D path-space
> +	'
> +}
> +
> +test_path_space_success 'quoted spaces'      '" hello world.c "' ' hello=
 world.c '
> +test_path_space_success 'no unquoted spaces' 'hello_world.c'     'hello_=
world.c'
> +
> +#
> +# Test a single commit change with an invalid path. Run it with all occu=
rrences
> +# of <path> in the grammar against all error kinds.
> +#
> +test_path_fail () {
> +	what=3D"$1" path=3D"$2" err_grep=3D"$3"

Same.

> +	test_expect_success "S: $change with $what must fail" '
> +		test_must_fail git fast-import <<-EOF 2>err &&
> +		blob
> +		mark :1
> +		data <<BLOB
> +		hello world
> +		BLOB
> +
> +		commit refs/heads/S-path-fail
> +		mark :2
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit setup
> +		COMMIT
> +		M 100644 :1 hello.c
> +
> +		commit refs/heads/S-path-fail
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit with bad path
> +		COMMIT
> +		from :2
> +		'"$prefix$path$suffix"'
> +		EOF
> +
> +		test_grep '"'$err_grep'"' err
> +	'
> +}
> +
> +test_path_base_fail () {
> +	test_path_fail 'unclosed " in '"$field"          '"hello.c'    "Invalid=
 $field"
> +	test_path_fail "invalid escape in quoted $field" '"hello\xff"' "Invalid=
 $field"
> +}
> +test_path_eol_quoted_fail () {
> +	test_path_base_fail
> +	test_path_fail "garbage after quoted $field" '"hello.c"x' "Garbage afte=
r $field"
> +	test_path_fail "space after quoted $field"   '"hello.c" ' "Garbage afte=
r $field"
> +}
> +test_path_eol_fail () {
> +	test_path_eol_quoted_fail
> +	test_path_fail 'empty unquoted path' '' "Missing $field"
> +}
> +test_path_space_fail () {
> +	test_path_base_fail
> +	test_path_fail 'empty unquoted path' '' "Missing $field"
> +	test_path_fail "missing space after quoted $field" '"hello.c"x' "Missin=
g space after $field"
> +}
> +
> +change=3Dfilemodify       prefix=3D'M 100644 :1 ' field=3Dpath   suffix=
=3D''         test_path_eol_fail
> +change=3Dfiledelete       prefix=3D'D '           field=3Dpath   suffix=
=3D''         test_path_eol_fail
> +change=3Dfilecopy         prefix=3D'C '           field=3Dsource suffix=
=3D' world.c' test_path_space_fail
> +change=3Dfilecopy         prefix=3D'C hello.c '   field=3Ddest   suffix=
=3D''         test_path_eol_fail
> +change=3Dfilerename       prefix=3D'R '           field=3Dsource suffix=
=3D' world.c' test_path_space_fail
> +change=3Dfilerename       prefix=3D'R hello.c '   field=3Ddest   suffix=
=3D''         test_path_eol_fail
> +change=3D'ls (in commit)' prefix=3D'ls :2 '       field=3Dpath   suffix=
=3D''         test_path_eol_fail

This is quite confusing because you now mix two different styles, where
some of the functions take arguments while others pass arguments via
variables. I think it would be preferable to pass all arguments as
proper function arguments.

Patrick

> +# When 'ls' has no <tree-ish>, the <path> must be quoted.
> +change=3D'ls (without tree-ish in commit)' prefix=3D'ls ' field=3Dpath s=
uffix=3D'' \
> +test_path_eol_quoted_fail &&
> +test_path_fail 'empty unquoted path' '' "Invalid dataref"
> +
>  ###
>  ### series T (ls)
>  ###
> --=20
> 2.44.0
>=20
>=20
>=20

--OogWr0Q0Lik/mDHk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYFKG0ACgkQVbJhu7ck
PpTwGA/9Hg4nijITtrl5OlGmrzqtYloug0waG9csSUDeLp2p+rnFDTqRpMWqOasy
laF7EzxYHHJR/RN9La2w8YkjoBiQC08iBCHf49r0dzD5+kKwIpjwiP7cXAknoY7R
OpcpkrIVuzj9BxxLG5IqzyA82c3lQj+E+Askxuzr3Vh4KMjqer/3M2M+SSw7R7DT
nMRwBn6Sg7vrNZ+hD3/TtaGBwaCpQ581QzKHajlDkVJDG2s+wkTwwwtwUdEkGw92
26juPoNBUDxUwEkPNWDv43HpooRBVmzuKtNSjaZHrvyoJbUdU/7SnkOzHz1En9/Q
WC5dwn4GAtYf8eEOhLlyWVYXWKPs8z91iZxh/lVCfwkbNnAlSCkD8ntXM6wUgx5Y
oVIesT2O1VGL91+CfvKKBxm5dLRvLDVdZQUQc5+D1vpQGDznW5M/gdD9BFsL8KTY
LBLOYRkKtW2j6rHGrMHeMswzK9Jp2xot3amqhW3zzGwRjwGpjo+lfjHHXUQ8PsHE
PH0MMC06akqmRRXz1NYS4bMLxvYeUnfqNHT5gm5dwuXdtds9Hnz0CY6eqem7kpob
3N/IV+cJPw540yKmyuqOs2HYhMyDzZ91EhoRYt7reb7ZC9JsBVhxrpA0WipWtfq7
yzqKc6myaAyPLA6KKyZxKF+YRLlQVnHFiZm35zW9B3DSynOTuCo=
=se52
-----END PGP SIGNATURE-----

--OogWr0Q0Lik/mDHk--
