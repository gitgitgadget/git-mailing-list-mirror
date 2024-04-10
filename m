Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71037169
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730431; cv=none; b=PMp3QYoaM2eTpLOFcLINUg1O9rolfsCx+PK9NvLGQiMF0IT1mCX5LKeECktDpFTEsnCBd3VE/z7zZW5WoQJSeQxgZfwUEQJO8wjCaXe2zxYFii8nbwXJ0SKyda9dzNynGjhmmV4iV3Yzg3rMk64OS6rPeHbEghHcehmNVIiI9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730431; c=relaxed/simple;
	bh=Ib7JMxJfakJrNO/H3Ezylryq9FQqIQxLU9U/QEBEMNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hELBNChwSsuzn2NAe8SGLfsQ4AJOBT80L5k80ZFylQnRlKf6ibpQsya7G/pjN6uIqzCUb1wpVucQVVq4izFRNr0neo+i+KgSsS2/uxQaR2oekdI3Dy4514JaeVA1W43fN8L9iE9aJOwxnAs8PNZ2h7dxzLAmDNc80wVLN/oGPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hGF2zvy8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NXcM932A; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hGF2zvy8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NXcM932A"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 93A6811400EC;
	Wed, 10 Apr 2024 02:27:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 10 Apr 2024 02:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712730426; x=1712816826; bh=jgtjWJFmWj
	vvIMw2iiysjwbr1uS4oIpToUENJHD6DiE=; b=hGF2zvy8IiRJ9G0H8iclXrqG9Q
	uzBySOHO5kA4L2jmwYuN64bQ8FcLOHT7912t4WV+DaAOIyH07p6kpuQqT3jEWdbn
	TYK0aWLLDQm4ERyH+qAu2uwp8mGQYBn1XrxiEhzhicKqMXdXGVn0ZnK1Z34Uoab+
	ZgTtJN+TmovldDMN+A9QZRvTBW1mUvUxAciw92856Yvrzr21EYnsaP6zinLNa8Or
	vE5Xop5fIrhuQvgKKadioPm59S/X9gkWExCHRyXCRp6X70SHgy8x8T/lI2WitEn4
	JUfw9FpIdfJPw60sTxevnv3r3G71BbxJ+JsUtQbmBhIUM9Uw0bq60VYwQx2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712730426; x=1712816826; bh=jgtjWJFmWjvvIMw2iiysjwbr1uS4
	oIpToUENJHD6DiE=; b=NXcM932AqM/kRoxR6LdIRGrXw4lXYh4sIUtrux9ZmVy1
	q2ufoKnReqNetcKM++/DScr/cbuDMHQ+eSVnuZsauCBtx7zoqmlfAsFDNfkF723r
	FcYeKQbvf2qKj65hy+8uR0p8BUSxkyAar+pV4JmFOH0LYLnmu4ewfRDhUVkAopx6
	5kZ7aVHfQWhhrBFjxLnHU43UXrWDd+zRsuzstnNcuBUGjkajgnrd6xfPHRm1ctPx
	SmySn7zRP2i3I0BQf9SSj6guo3i1VHlBUj7LoebgXUaKHb+GLDtkJUt+mbh+D2oF
	H5prRRY94mMb46ijAm8y/pe/yNrhftpOSoGWnFMQXw==
X-ME-Sender: <xms:OjEWZgJb_YIPbeLf6nuRVtEKsdfES_DQzKUcYIqSBFQL3rJjQry-CQ>
    <xme:OjEWZgKocU_dYnd3Wy1DXQFGEnTIQwP95_L3WqFGCI-CGSf-DR93KxD7DSqJWI5Ke
    4agKlVTIC9xP-Gveg>
X-ME-Received: <xmr:OjEWZgutjoWzgB6_X3F6T2wrpZDEvhFxbfvh6u5alyupxQYmLkfQElVTwR_wtBEn3PWgq9RCbd8BFzumJ6NRg2PbsUD4KcPgIgkG8YW5nMxrHXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehhedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:OjEWZtb7PmKYVuvOw5OOmr_7pbUW42giblrfj0wZFaBjF1jkh49v7g>
    <xmx:OjEWZnZCn2TtK2_PFZ_roEZ5ajTFE8SbGqkezbE61oEg9xQTpmFY9w>
    <xmx:OjEWZpDsMwf-8LhmsydCWeU2feUhUBwoD3CU4SP3b36AgE9ByEZ05w>
    <xmx:OjEWZtaqAh_NzLtXp_43ibpasIAWh6LetYWhiRMQx98JFXEfg7ujLw>
    <xmx:OjEWZjFUF7QGiTnFnZ0svBWekSvDyY6aRbpmYIX4TBRaM74UGGzr-eNg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 02:27:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5291c3f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 06:26:53 +0000 (UTC)
Date: Wed, 10 Apr 2024 08:27:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/8] fast-import: tighten path unquoting
Message-ID: <ZhYxNYR33ftEfcPk@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <cover.1711960552.git.thalia@archibald.dev>
 <e790bdf714bb4c2a67708c016a97cf4f9e79ac48.1711960552.git.thalia@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zM7Vc0bzI0n86yfF"
Content-Disposition: inline
In-Reply-To: <e790bdf714bb4c2a67708c016a97cf4f9e79ac48.1711960552.git.thalia@archibald.dev>


--zM7Vc0bzI0n86yfF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 09:02:47AM +0000, Thalia Archibald wrote:
> Path parsing in fast-import is inconsistent and many unquoting errors
> are suppressed or not checked.
>=20
> <path> appears in the grammar in these places:
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
>    Try to unquote <path>. If it unquotes without errors, use the
>    unquoted version; otherwise, treat it as literal bytes to the end of
>    the line (including any number of SP).
> 2. For filecopy (source) and filerename (source):
>    Try to unquote <path>. If it unquotes without errors, use the
>    unquoted version; otherwise, treat it as literal bytes up to, but not
>    including, the next SP.
> 3. For filecopy (dest) and filerename (dest):
>    Like 1., but an unquoted empty string is forbidden.
> 4. For ls:
>    If <path> starts with `"`, unquote it and report parse errors;
>    otherwise, treat it as literal bytes to the end of the line
>    (including any number of SP).
> 5. For ls-commit:
>    Unquote <path> and report parse errors.
>    (It must start with `"` to disambiguate from ls.)
>=20
> In the first three, any errors from trying to unquote a string are
> suppressed, so a quoted string that contains invalid escapes would be
> interpreted as literal bytes. For example, `"\xff"` would fail to
> unquote (because hex escapes are not supported), and it would instead be
> interpreted as the byte sequence '"', '\\', 'x', 'f', 'f', '"', which is
> certainly not intended. Some front-ends erroneously use their language's
> standard quoting routine instead of matching Git's, which could silently
> introduce escapes that would be incorrectly parsed due to this and lead
> to data corruption.
>=20
> The documentation states =E2=80=9CTo use a source path that contains SP t=
he path
> must be quoted.=E2=80=9D, so it is expected that some implementations dep=
end on
> spaces being allowed in paths in the final position. Thus we have two
> documented ways to parse paths, so simplify the implementation to that.
>=20
> Now we have:
>=20
> 1. `parse_path_eol` for filemodify, filedelete, filecopy (dest),
>    filerename (dest), ls, and ls-commit:
>=20
>    If <path> starts with `"`, unquote it and report parse errors;
>    otherwise, treat it as literal bytes to the end of the line
>    (including any number of SP).
>=20
> 2. `parse_path_space` for filecopy (source) and filerename (source):
>=20
>    If <path> starts with `"`, unquote it and report parse errors;
>    otherwise, treat it as literal bytes up to, but not including, the
>    next SP. It must be followed by SP.
>=20
> There remain two special cases: The dest <path> in filecopy and rename
> cannot be an unquoted empty string (this will be addressed subsequently)
> and <path> in ls-commit must be quoted to disambiguate it from ls.
>=20
> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  builtin/fast-import.c  | 102 ++++++++++-------
>  t/t9300-fast-import.sh | 251 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 309 insertions(+), 44 deletions(-)
>=20
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 782bda007c..6f9048a037 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2258,10 +2258,54 @@ static uintmax_t parse_mark_ref_space(const char =
**p)
>  	return mark;
>  }
> =20
> +/*
> + * Parse the path string into the strbuf. It may be quoted with escape s=
equences
> + * or unquoted without escape sequences. When unquoted, it may only cont=
ain a
> + * space if `include_spaces` is nonzero.
> + */
> +static void parse_path(struct strbuf *sb, const char *p, const char **en=
dp, int include_spaces, const char *field)

Let's break this overly long line, for example after `**endp,`.

> +{
> +	if (*p =3D=3D '"') {
> +		if (unquote_c_style(sb, p, endp))
> +			die("Invalid %s: %s", field, command_buf.buf);
> +	} else {
> +		if (include_spaces)
> +			*endp =3D p + strlen(p);
> +		else
> +			*endp =3D strchr(p, ' ');
> +		strbuf_add(sb, p, *endp - p);

strchr(3P) may return a NULL pointer in case there is no space, which
would make us segfault here when dereferencing `*endp`. We should
probably add a testcase that would hit this edge case.

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
> @@ -2299,11 +2343,8 @@ static void file_change_m(const char *p, struct br=
anch *b)
>  	}
> =20
>  	strbuf_reset(&uq);
> -	if (!unquote_c_style(&uq, p, &endp)) {
> -		if (*endp)
> -			die("Garbage after path in: %s", command_buf.buf);
> -		p =3D uq.buf;
> -	}
> +	parse_path_eol(&uq, p, "path");
> +	p =3D uq.buf;
> =20
>  	/* Git does not track empty, non-toplevel directories. */
>  	if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *p) {
> @@ -2367,48 +2408,29 @@ static void file_change_m(const char *p, struct b=
ranch *b)
>  static void file_change_d(const char *p, struct branch *b)
>  {
>  	static struct strbuf uq =3D STRBUF_INIT;
> -	const char *endp;
> =20
>  	strbuf_reset(&uq);
> -	if (!unquote_c_style(&uq, p, &endp)) {
> -		if (*endp)
> -			die("Garbage after path in: %s", command_buf.buf);
> -		p =3D uq.buf;
> -	}
> +	parse_path_eol(&uq, p, "path");
> +	p =3D uq.buf;
>  	tree_content_remove(&b->branch_tree, p, NULL, 1);
>  }
> =20
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
>  	strbuf_reset(&s_uq);
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
>  	s =3D s_uq.buf;
> =20
> -	endp++;
> -	if (!*endp)
> +	if (!p)
>  		die("Missing dest: %s", command_buf.buf);

So this statement right now doesn't make a whole lot of sense because
`p` cannot ever be `NULL` -- we'd segfault before that. Once we update
`parse_path()` to handle this correctly it will work as expected though.

I was briefly wondering though whether we really want `parse_path()` to
set `p` to be a NULL pointer. If we didn't, we could retain the previous
behaviour here and instead check for `!*p`.

Patrick

> -	d =3D endp;
>  	strbuf_reset(&d_uq);
> -	if (!unquote_c_style(&d_uq, d, &endp)) {
> -		if (*endp)
> -			die("Garbage after dest in: %s", command_buf.buf);
> -		d =3D d_uq.buf;
> -	}
> +	parse_path_eol(&d_uq, p, "dest");
> +	d =3D d_uq.buf;
> =20
>  	memset(&leaf, 0, sizeof(leaf));
>  	if (rename)
> @@ -3152,6 +3174,7 @@ static void print_ls(int mode, const unsigned char =
*hash, const char *path)
> =20
>  static void parse_ls(const char *p, struct branch *b)
>  {
> +	static struct strbuf uq =3D STRBUF_INIT;
>  	struct tree_entry *root =3D NULL;
>  	struct tree_entry leaf =3D {NULL};
> =20
> @@ -3168,16 +3191,9 @@ static void parse_ls(const char *p, struct branch =
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
> +	strbuf_reset(&uq);
> +	parse_path_eol(&uq, p, "path");
> +	p =3D uq.buf;
>  	tree_content_get(root, p, &leaf, 1);
>  	/*
>  	 * A directory in preparation would have a sha1 of zero
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 60e30fed3c..0fb5612b07 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -2142,6 +2142,7 @@ test_expect_success 'Q: deny note on empty branch' '
>  	EOF
>  	test_must_fail git fast-import <input
>  '
> +
>  ###
>  ### series R (feature and option)
>  ###
> @@ -2790,7 +2791,7 @@ test_expect_success 'R: blob appears only once' '
>  '
> =20
>  ###
> -### series S
> +### series S (mark and path parsing)
>  ###
>  #
>  # Make sure missing spaces and EOLs after mark references
> @@ -3060,6 +3061,254 @@ test_expect_success 'S: ls with garbage after sha=
1 must fail' '
>  	test_grep "space after tree-ish" err
>  '
> =20
> +#
> +# Path parsing
> +#
> +# There are two sorts of ways a path can be parsed, depending on whether=
 it is
> +# the last field on the line. Additionally, ls without a <dataref> has a=
 special
> +# case. Test every occurrence of <path> in the grammar against every err=
or case.
> +#
> +
> +#
> +# Valid paths at the end of a line: filemodify, filedelete, filecopy (de=
st),
> +# filerename (dest), and ls.
> +#
> +# commit :301 from root -- modify hello.c (for setup)
> +# commit :302 from :301 -- modify $path
> +# commit :303 from :302 -- delete $path
> +# commit :304 from :301 -- copy hello.c $path
> +# commit :305 from :301 -- rename hello.c $path
> +# ls :305 $path
> +#
> +test_path_eol_success () {
> +	local test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
> +	test_expect_success "S: paths at EOL with $test must work" '
> +		test_when_finished "git branch -D S-path-eol" &&
> +
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
> +		commit refs/heads/S-path-eol
> +		mark :301
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		initial commit
> +		COMMIT
> +		M 100644 :401 hello.c
> +
> +		commit refs/heads/S-path-eol
> +		mark :302
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filemodify
> +		COMMIT
> +		from :301
> +		M 100644 :402 '"$path"'
> +
> +		commit refs/heads/S-path-eol
> +		mark :303
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filedelete
> +		COMMIT
> +		from :302
> +		D '"$path"'
> +
> +		commit refs/heads/S-path-eol
> +		mark :304
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filecopy dest
> +		COMMIT
> +		from :301
> +		C hello.c '"$path"'
> +
> +		commit refs/heads/S-path-eol
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

I think it is more customary to format as follows:

	(
		printf "100644 blob $blob2\t'"$unquoted_path"'\n" &&
		printf "100644 blob $blob1\thello.c\n"
	) | sort >tree_m.exp &&

Same for other statements further down.

Also, there is no need to do `'"$unuoted_path"'` here. You should be
able to refer to `$unquoted_path` just fine even without unquoting again
because we use eval to execute the code block. In fact, it can even be
harmful as it is known to break shells under some circumstances. See
also 7c4449eb31 (t/README: document how to loop around test cases,
2024-03-22), which I think should apply in your case, too.

Patrick

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
> +		test_cmp out tree_r.exp
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
> +# commit :301 from root -- modify $path (for setup)
> +# commit :302 from :301 -- copy $path hello2.c
> +# commit :303 from :301 -- rename $path hello2.c
> +#
> +test_path_space_success () {
> +	local test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
> +	test_expect_success "S: paths before space with $test must work" '
> +		test_when_finished "git branch -D S-path-space" &&
> +
> +		git fast-import --export-marks=3Dmarks.out <<-EOF 2>err &&
> +		blob
> +		mark :401
> +		data <<BLOB
> +		hello world
> +		BLOB
> +
> +		commit refs/heads/S-path-space
> +		mark :301
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		initial commit
> +		COMMIT
> +		M 100644 :401 '"$path"'
> +
> +		commit refs/heads/S-path-space
> +		mark :302
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		commit filecopy source
> +		COMMIT
> +		from :301
> +		C '"$path"' hello2.c
> +
> +		commit refs/heads/S-path-space
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
> +		test_cmp tree_r.exp tree_r.out
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
> +	local change=3D"$1" what=3D"$2" prefix=3D"$3" path=3D"$4" suffix=3D"$5"=
 err_grep=3D"$6"
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
> +	local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
> +	test_path_fail "$change" 'unclosed " in '"$field"          "$prefix" '"=
hello.c'    "$suffix" "Invalid $field"
> +	test_path_fail "$change" "invalid escape in quoted $field" "$prefix" '"=
hello\xff"' "$suffix" "Invalid $field"
> +}
> +test_path_eol_quoted_fail () {
> +	local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
> +	test_path_base_fail "$change" "$prefix" "$field" "$suffix"
> +	test_path_fail "$change" "garbage after quoted $field" "$prefix" '"hell=
o.c"x' "$suffix" "Garbage after $field"
> +	test_path_fail "$change" "space after quoted $field"   "$prefix" '"hell=
o.c" ' "$suffix" "Garbage after $field"
> +}
> +test_path_eol_fail () {
> +	local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
> +	test_path_eol_quoted_fail "$change" "$prefix" "$field" "$suffix"
> +}
> +test_path_space_fail () {
> +	local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
> +	test_path_base_fail "$change" "$prefix" "$field" "$suffix"
> +	test_path_fail "$change" "missing space after quoted $field" "$prefix" =
'"hello.c"x' "$suffix" "Missing space after $field"
> +}
> +
> +test_path_eol_fail   filemodify       'M 100644 :1 ' path   ''
> +test_path_eol_fail   filedelete       'D '           path   ''
> +test_path_space_fail filecopy         'C '           source ' world.c'
> +test_path_eol_fail   filecopy         'C hello.c '   dest   ''
> +test_path_space_fail filerename       'R '           source ' world.c'
> +test_path_eol_fail   filerename       'R hello.c '   dest   ''
> +test_path_eol_fail   'ls (in commit)' 'ls :2 '       path   ''
> +
> +# When 'ls' has no <dataref>, the <path> must be quoted.
> +test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path ''
> +
>  ###
>  ### series T (ls)
>  ###
> --=20
> 2.44.0
>=20

--zM7Vc0bzI0n86yfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWMTQACgkQVbJhu7ck
PpSbcQ//S6x2MIjEH33jwp5RxnmuD5nznOFuXxbPx/ycM8rK/z8w4EACiqGeUznx
qJO8LjmyRbTiumwn1FM7rhN1QRUB/cIJPwczfBL47gLrjznsM/olpDLHIexwRRmN
9TcILd3pe94NCHtGvCj6b3udw0nFM+VoJ4kFvNqWwavuWHGOFWDqG35lv8i8QRyz
/1L6bq6bHRLnHbtxldb645lZIkoWdE0LY/umFZX8VozCZ5qUm1+bY1VMWJKTOmKq
sZ7cg5eQj9QPGSGimprXyN//4bN4eAIArMxGD9dzTprS+hiERqmdqgMHfbrW7TQi
WecuZTevknAeoY0E2Fm8S7ahtyIENvdlcTw254nTacunoCezT4P5bVbREP/DkKf6
LcM45EviNMt7YWSGTOI+XzD1O4qwb0YUcyyifjqQDLCB4BlHWVI5QSadBn/qkqb6
G24zQfxZCJAGkCbTW/c4XZxL5XMNFwpQl78BPaAc4y2/w0JtSElM724DrA9SjzQa
K7do3Q3xXzG7XkoZabR7D0HJC3kUlPSAITeM/7QpRNiqnwIDxBA9J+9HifE4m8H+
ZAOGs/4+Ow5zEi0tavAK2BO9WUFl14HABxo6urF7DCgf2ff6yitaB5AiIAbFk6Xe
g/rOtzYSNYTBr7KtVKC9IYut40ky+3TLWz/IJcgnCWEYEugyuLg=
=VuDM
-----END PGP SIGNATURE-----

--zM7Vc0bzI0n86yfF--
