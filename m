Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5329CF2
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730449; cv=none; b=CD2qhwN+8N8N+CEEUHVvD+fO6EPilUoTZb4WrZljLC/1NOupSEK95XIhy7Jn2kKP56MewTki9I/NUEwUsK2NT+sUkb8hNeQvnCr5he/Mn2nD865ZniKb31TVIBWWglC88ulRUUdoI5XohmBQsKUouzDljiI7LK8SNiYrdJOg30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730449; c=relaxed/simple;
	bh=y1+DWxuQJ8de9JZ2EEfEkpdDayri6QA0j0WMpm397Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHv0eRtWElQMxuD6LXZzNAm05qwqlIT3Ha8ZSgUGogDG5Pc1Zw2GB95h1OJb9r3+5WaqcnCG2S+lBgJ8aTV/4d9mVnszkMBTpGM+y5/2MgXS/A6QjPX2oQeVKyqreeJuWKsSa5ZU/vulamb94jILV1FkT3FKrJqpodeKebFQNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gTIFLDC3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oV3lT9L3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gTIFLDC3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oV3lT9L3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id CCDC313800DC;
	Wed, 10 Apr 2024 02:27:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 10 Apr 2024 02:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712730445; x=1712816845; bh=44uIXxz2WH
	+yCwl3b5HIVyJ/8gpVZSB7JEMgyUB54YQ=; b=gTIFLDC3kAATYDmn/t54gAfQ+L
	CKEKcsoUnOpuagO3Zah2i3LjvRaKkxT2nwQnyAASAxTjDstN3fQDBVjjlhefx8Vb
	WPmGsR/WVv/8KS8ZpyeP7a0f0g9rogOaESTbEiRclkig9DB/osmtZMxBtRlq5OdN
	QlqGqhYYiIwc8dC2YDDgZOE435h0k6hj9q5/pjoNfxTZKVdLxnUfGgDZeD31FFJd
	L36hiX5tBX6z/7eVyk687qX6Vrw4MTxR0svbTnFTNXOOJeV5CHSZIjd8jY1q9DI4
	jf+AnJ6FaFSSl67OfpBg3ji253KUv9nzvHUJT6BWiahqhgYf5EzYx0u5W6RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712730445; x=1712816845; bh=44uIXxz2WH+yCwl3b5HIVyJ/8gpV
	ZSB7JEMgyUB54YQ=; b=oV3lT9L3AlnvUSKjVeReZW0SHeD5bMFu8PCYIO4WFH56
	5z7Qc81zEuBomTPo+PH7G8lSt0KyheSnk+c+s7K6opn22qNb56FizNecqL4SmitN
	/WVb6q96Dyui9QX/jvSPqe7VezC1N9sI26oJ9esR9xNKaF4+QNKbu+1UOsJFCXuo
	7O4f4rIRERBNG+tQaNjXbRiCDIFMQnOQUI8+JYA/HX/q2qKbhlnzI0DuTyUTz5Ce
	1tWR4Gxwvm4X7dGw8/ay3W2ucn3nmQiPVyTzlMwcTimQHXqapER87FoqmOoMMKfF
	HytJSCZWruK2ySdHrBhTQxld9wbPnEl84HIGZ6t0Ig==
X-ME-Sender: <xms:TTEWZgXUcB_2MvCB8C1e4J9mtSnmU-i0RcOmgGdk4Y9xY821OQ-Rmg>
    <xme:TTEWZkngGNRpUDn4SuBpYK-z-XzIiZgpwFkeTyx6HALVlWLcnU6Gffy3Y5CCGRcZw
    Lrc5e5VWudKNRwRGQ>
X-ME-Received: <xmr:TTEWZkZtxbCXYnVrfq2wVJwqIoVzlGr2En8NsU6GHgX83LIcrOCsOf3UQjHp0MveOzsO-xD1peeYbgpFc6Y5naX6dzcwj2XBBG5SPwWvwT4YYoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehhedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:TTEWZvXWp1m_1oKC39Sen42PmWds87X8cfuLBLw07FGvrmm29aNmDw>
    <xmx:TTEWZqlottO3PkJfrQN0KMacWrLFgeoIDMCxTW1fpQHY0OMX5Vnvig>
    <xmx:TTEWZkcCZZFFIAqGGT_qPs-Dt-xHazqpDichRbpiNi1u-GRrL41nsg>
    <xmx:TTEWZsFTH8a8fMq28RZ1Xc8j1fskOICUGLTNfYGuORnwYGWZSm4x4g>
    <xmx:TTEWZsjJWs271_cCntqmsNpv8NoWETQj9XjCHNl4DsjUqGKs8pi7jpGW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 02:27:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a20ad8c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 06:27:14 +0000 (UTC)
Date: Wed, 10 Apr 2024 08:27:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/8] fast-import: allow unquoted empty path for root
Message-ID: <ZhYxSSdqUFx821Hh@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <cover.1711960552.git.thalia@archibald.dev>
 <893bbf5e734903382c22893121252ed49b3c7a69.1711960552.git.thalia@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3zO2D4G0tQtCsoUa"
Content-Disposition: inline
In-Reply-To: <893bbf5e734903382c22893121252ed49b3c7a69.1711960552.git.thalia@archibald.dev>


--3zO2D4G0tQtCsoUa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 09:03:17AM +0000, Thalia Archibald wrote:
> Ever since filerename was added in f39a946a1f (Support wholesale
> directory renames in fast-import, 2007-07-09) and filecopy in b6f3481bb4
> (Teach fast-import to recursively copy files/directories, 2007-07-15),
> both have produced an error when the destination path is empty. Later,
> when support for targeting the root directory with an empty string was
> added in 2794ad5244 (fast-import: Allow filemodify to set the root,
> 2010-10-10), this had the effect of allowing the quoted empty string
> (`""`), but forbidding its unquoted variant (``). This seems to have
> been intended as simple data validation for parsing two paths, rather
> than a syntax restriction, because it was not extended to the other
> operations.
>=20
> All other occurrences of paths (in filemodify, filedelete, the source of
> filecopy and filerename, and ls) allow both.
>=20
> For most of this feature's lifetime, the documentation has not
> prescribed the use of quoted empty strings. In e5959106d6
> (Documentation/fast-import: put explanation of M 040000 <dataref> "" in
> context, 2011-01-15), its documentation was changed from =E2=80=9C`<path>=
` may
> also be an empty string (`""`) to specify the root of the tree=E2=80=9D t=
o =E2=80=9CThe
> root of the tree can be represented by an empty string as `<path>`=E2=80=
=9D.
>=20
> Thus, we can assume that some front-ends have depended on this behavior.
>=20
> Remove this restriction for the destination paths of filecopy and
> filerename and change tests targeting the root to test `""` and ``.
>=20
> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  builtin/fast-import.c  |   5 +-
>  t/t9300-fast-import.sh | 363 +++++++++++++++++++++--------------------
>  2 files changed, 191 insertions(+), 177 deletions(-)
>=20
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index fad9324e59..58cc8d4ede 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2416,11 +2416,8 @@ static void file_change_cr(const char *p, struct b=
ranch *b, int rename)
>  	struct tree_entry leaf;
> =20
>  	strbuf_reset(&source);
> -	parse_path_space(&source, p, &p, "source");

Nit: the diff would be a bit easier to read if you retained the sequence
of `strbuf_reset()` and `parse_path_space()`.

> -
> -	if (!p)
> -		die("Missing dest: %s", command_buf.buf);

>  	strbuf_reset(&dest);

I also wonder why this actually makes a difference. As mentioned in a
preceding mail, `if (!p)` cannot really do anything because the only
case where `p` could be a `NULL` pointer is when strchr(3P) did not
found a subsequent space in `parse_path()`. And in that case we would
have segfaulted because we do dereference `p` afterwards.

> +	parse_path_space(&source, p, &p, "source");
>  	parse_path_eol(&dest, p, "dest");
> =20
>  	memset(&leaf, 0, sizeof(leaf));
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 0fb5612b07..635b1b9af7 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -1059,30 +1059,33 @@ test_expect_success 'M: rename subdirectory to ne=
w subdirectory' '
>  	compare_diff_raw expect actual
>  '
> =20
> -test_expect_success 'M: rename root to subdirectory' '
> -	cat >input <<-INPUT_END &&
> -	commit refs/heads/M4
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	rename root
> -	COMMIT
> +for root in '""' ''
> +do
> +	test_expect_success "M: rename root ($root) to subdirectory" '
> +		cat >input <<-INPUT_END &&
> +		commit refs/heads/M4
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		rename root
> +		COMMIT
> =20
> -	from refs/heads/M2^0
> -	R "" sub
> +		from refs/heads/M2^0
> +		R '"$root"' sub

Same comment here, we should not do the `'"$root"'` dance but can
instead just refer to the variable directly in the quoted block.

Patrick

> -	INPUT_END
> +		INPUT_END
> =20
> -	cat >expect <<-EOF &&
> -	:100644 100644 $oldf $oldf R100	file2/oldf	sub/file2/oldf
> -	:100755 100755 $f4id $f4id R100	file4	sub/file4
> -	:100755 100755 $newf $newf R100	i/am/new/to/you	sub/i/am/new/to/you
> -	:100755 100755 $f6id $f6id R100	newdir/exec.sh	sub/newdir/exec.sh
> -	:100644 100644 $f5id $f5id R100	newdir/interesting	sub/newdir/interesti=
ng
> -	EOF
> -	git fast-import <input &&
> -	git diff-tree -M -r M4^ M4 >actual &&
> -	compare_diff_raw expect actual
> -'
> +		cat >expect <<-EOF &&
> +		:100644 100644 $oldf $oldf R100	file2/oldf	sub/file2/oldf
> +		:100755 100755 $f4id $f4id R100	file4	sub/file4
> +		:100755 100755 $newf $newf R100	i/am/new/to/you	sub/i/am/new/to/you
> +		:100755 100755 $f6id $f6id R100	newdir/exec.sh	sub/newdir/exec.sh
> +		:100644 100644 $f5id $f5id R100	newdir/interesting	sub/newdir/interest=
ing
> +		EOF
> +		git fast-import <input &&
> +		git diff-tree -M -r M4^ M4 >actual &&
> +		compare_diff_raw expect actual
> +	'
> +done
> =20
>  ###
>  ### series N
> @@ -1259,49 +1262,52 @@ test_expect_success PIPE 'N: empty directory read=
s as missing' '
>  	test_cmp expect actual
>  '
> =20
> -test_expect_success 'N: copy root directory by tree hash' '
> -	cat >expect <<-EOF &&
> -	:100755 000000 $newf $zero D	file3/newf
> -	:100644 000000 $oldf $zero D	file3/oldf
> -	EOF
> -	root=3D$(git rev-parse refs/heads/branch^0^{tree}) &&
> -	cat >input <<-INPUT_END &&
> -	commit refs/heads/N6
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	copy root directory by tree hash
> -	COMMIT
> +for root in '""' ''
> +do
> +	test_expect_success "N: copy root ($root) by tree hash" '
> +		cat >expect <<-EOF &&
> +		:100755 000000 $newf $zero D	file3/newf
> +		:100644 000000 $oldf $zero D	file3/oldf
> +		EOF
> +		root_tree=3D$(git rev-parse refs/heads/branch^0^{tree}) &&
> +		cat >input <<-INPUT_END &&
> +		commit refs/heads/N6
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		copy root directory by tree hash
> +		COMMIT
> =20
> -	from refs/heads/branch^0
> -	M 040000 $root ""
> -	INPUT_END
> -	git fast-import <input &&
> -	git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
> -	compare_diff_raw expect actual
> -'
> +		from refs/heads/branch^0
> +		M 040000 $root_tree '"$root"'
> +		INPUT_END
> +		git fast-import <input &&
> +		git diff-tree -C --find-copies-harder -r N4 N6 >actual &&
> +		compare_diff_raw expect actual
> +	'
> =20
> -test_expect_success 'N: copy root by path' '
> -	cat >expect <<-EOF &&
> -	:100755 100755 $newf $newf C100	file2/newf	oldroot/file2/newf
> -	:100644 100644 $oldf $oldf C100	file2/oldf	oldroot/file2/oldf
> -	:100755 100755 $f4id $f4id C100	file4	oldroot/file4
> -	:100755 100755 $f6id $f6id C100	newdir/exec.sh	oldroot/newdir/exec.sh
> -	:100644 100644 $f5id $f5id C100	newdir/interesting	oldroot/newdir/inter=
esting
> -	EOF
> -	cat >input <<-INPUT_END &&
> -	commit refs/heads/N-copy-root-path
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	copy root directory by (empty) path
> -	COMMIT
> +	test_expect_success "N: copy root ($root) by path" '
> +		cat >expect <<-EOF &&
> +		:100755 100755 $newf $newf C100	file2/newf	oldroot/file2/newf
> +		:100644 100644 $oldf $oldf C100	file2/oldf	oldroot/file2/oldf
> +		:100755 100755 $f4id $f4id C100	file4	oldroot/file4
> +		:100755 100755 $f6id $f6id C100	newdir/exec.sh	oldroot/newdir/exec.sh
> +		:100644 100644 $f5id $f5id C100	newdir/interesting	oldroot/newdir/inte=
resting
> +		EOF
> +		cat >input <<-INPUT_END &&
> +		commit refs/heads/N-copy-root-path
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		copy root directory by (empty) path
> +		COMMIT
> =20
> -	from refs/heads/branch^0
> -	C "" oldroot
> -	INPUT_END
> -	git fast-import <input &&
> -	git diff-tree -C --find-copies-harder -r branch N-copy-root-path >actua=
l &&
> -	compare_diff_raw expect actual
> -'
> +		from refs/heads/branch^0
> +		C '"$root"' oldroot
> +		INPUT_END
> +		git fast-import <input &&
> +		git diff-tree -C --find-copies-harder -r branch N-copy-root-path >actu=
al &&
> +		compare_diff_raw expect actual
> +	'
> +done
> =20
>  test_expect_success 'N: delete directory by copying' '
>  	cat >expect <<-\EOF &&
> @@ -1431,98 +1437,102 @@ test_expect_success 'N: reject foo/ syntax in ls=
 argument' '
>  	INPUT_END
>  '
> =20
> -test_expect_success 'N: copy to root by id and modify' '
> -	echo "hello, world" >expect.foo &&
> -	echo hello >expect.bar &&
> -	git fast-import <<-SETUP_END &&
> -	commit refs/heads/N7
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	hello, tree
> -	COMMIT
> +for root in '""' ''
> +do
> +	test_expect_success "N: copy to root ($root) by id and modify" '
> +		echo "hello, world" >expect.foo &&
> +		echo hello >expect.bar &&
> +		git fast-import <<-SETUP_END &&
> +		commit refs/heads/N7
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		hello, tree
> +		COMMIT
> =20
> -	deleteall
> -	M 644 inline foo/bar
> -	data <<EOF
> -	hello
> -	EOF
> -	SETUP_END
> +		deleteall
> +		M 644 inline foo/bar
> +		data <<EOF
> +		hello
> +		EOF
> +		SETUP_END
> =20
> -	tree=3D$(git rev-parse --verify N7:) &&
> -	git fast-import <<-INPUT_END &&
> -	commit refs/heads/N8
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	copy to root by id and modify
> -	COMMIT
> +		tree=3D$(git rev-parse --verify N7:) &&
> +		git fast-import <<-INPUT_END &&
> +		commit refs/heads/N8
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		copy to root by id and modify
> +		COMMIT
> =20
> -	M 040000 $tree ""
> -	M 644 inline foo/foo
> -	data <<EOF
> -	hello, world
> -	EOF
> -	INPUT_END
> -	git show N8:foo/foo >actual.foo &&
> -	git show N8:foo/bar >actual.bar &&
> -	test_cmp expect.foo actual.foo &&
> -	test_cmp expect.bar actual.bar
> -'
> +		M 040000 $tree '"$root"'
> +		M 644 inline foo/foo
> +		data <<EOF
> +		hello, world
> +		EOF
> +		INPUT_END
> +		git show N8:foo/foo >actual.foo &&
> +		git show N8:foo/bar >actual.bar &&
> +		test_cmp expect.foo actual.foo &&
> +		test_cmp expect.bar actual.bar
> +	'
> =20
> -test_expect_success 'N: extract subtree' '
> -	branch=3D$(git rev-parse --verify refs/heads/branch^{tree}) &&
> -	cat >input <<-INPUT_END &&
> -	commit refs/heads/N9
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	extract subtree branch:newdir
> -	COMMIT
> +	test_expect_success "N: extract subtree to the root ($root)" '
> +		branch=3D$(git rev-parse --verify refs/heads/branch^{tree}) &&
> +		cat >input <<-INPUT_END &&
> +		commit refs/heads/N9
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		extract subtree branch:newdir
> +		COMMIT
> =20
> -	M 040000 $branch ""
> -	C "newdir" ""
> -	INPUT_END
> -	git fast-import <input &&
> -	git diff --exit-code branch:newdir N9
> -'
> +		M 040000 $branch '"$root"'
> +		C "newdir" '"$root"'
> +		INPUT_END
> +		git fast-import <input &&
> +		git diff --exit-code branch:newdir N9
> +	'
> =20
> -test_expect_success 'N: modify subtree, extract it, and modify again' '
> -	echo hello >expect.baz &&
> -	echo hello, world >expect.qux &&
> -	git fast-import <<-SETUP_END &&
> -	commit refs/heads/N10
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	hello, tree
> -	COMMIT
> +	test_expect_success "N: modify subtree, extract it to the root ($root),=
 and modify again" '
> +		echo hello >expect.baz &&
> +		echo hello, world >expect.qux &&
> +		git fast-import <<-SETUP_END &&
> +		commit refs/heads/N10
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		hello, tree
> +		COMMIT
> =20
> -	deleteall
> -	M 644 inline foo/bar/baz
> -	data <<EOF
> -	hello
> -	EOF
> -	SETUP_END
> +		deleteall
> +		M 644 inline foo/bar/baz
> +		data <<EOF
> +		hello
> +		EOF
> +		SETUP_END
> =20
> -	tree=3D$(git rev-parse --verify N10:) &&
> -	git fast-import <<-INPUT_END &&
> -	commit refs/heads/N11
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	copy to root by id and modify
> -	COMMIT
> +		tree=3D$(git rev-parse --verify N10:) &&
> +		git fast-import <<-INPUT_END &&
> +		commit refs/heads/N11
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		copy to root by id and modify
> +		COMMIT
> =20
> -	M 040000 $tree ""
> -	M 100644 inline foo/bar/qux
> -	data <<EOF
> -	hello, world
> -	EOF
> -	R "foo" ""
> -	C "bar/qux" "bar/quux"
> -	INPUT_END
> -	git show N11:bar/baz >actual.baz &&
> -	git show N11:bar/qux >actual.qux &&
> -	git show N11:bar/quux >actual.quux &&
> -	test_cmp expect.baz actual.baz &&
> -	test_cmp expect.qux actual.qux &&
> -	test_cmp expect.qux actual.quux'
> +		M 040000 $tree '"$root"'
> +		M 100644 inline foo/bar/qux
> +		data <<EOF
> +		hello, world
> +		EOF
> +		R "foo" '"$root"'
> +		C "bar/qux" "bar/quux"
> +		INPUT_END
> +		git show N11:bar/baz >actual.baz &&
> +		git show N11:bar/qux >actual.qux &&
> +		git show N11:bar/quux >actual.quux &&
> +		test_cmp expect.baz actual.baz &&
> +		test_cmp expect.qux actual.qux &&
> +		test_cmp expect.qux actual.quux
> +	'
> +done
> =20
>  ###
>  ### series O
> @@ -3067,6 +3077,7 @@ test_expect_success 'S: ls with garbage after sha1 =
must fail' '
>  # There are two sorts of ways a path can be parsed, depending on whether=
 it is
>  # the last field on the line. Additionally, ls without a <dataref> has a=
 special
>  # case. Test every occurrence of <path> in the grammar against every err=
or case.
> +# Paths for the root (empty strings) are tested elsewhere.
>  #
> =20
>  #
> @@ -3314,16 +3325,19 @@ test_path_eol_quoted_fail 'ls (without dataref in=
 commit)' 'ls ' path ''
>  ###
>  # Setup is carried over from series S.
> =20
> -test_expect_success 'T: ls root tree' '
> -	sed -e "s/Z\$//" >expect <<-EOF &&
> -	040000 tree $(git rev-parse S^{tree})	Z
> -	EOF
> -	sha1=3D$(git rev-parse --verify S) &&
> -	git fast-import --import-marks=3Dmarks <<-EOF >actual &&
> -	ls $sha1 ""
> -	EOF
> -	test_cmp expect actual
> -'
> +for root in '""' ''
> +do
> +	test_expect_success "T: ls root ($root) tree" '
> +		sed -e "s/Z\$//" >expect <<-EOF &&
> +		040000 tree $(git rev-parse S^{tree})	Z
> +		EOF
> +		sha1=3D$(git rev-parse --verify S) &&
> +		git fast-import --import-marks=3Dmarks <<-EOF >actual &&
> +		ls $sha1 $root
> +		EOF
> +		test_cmp expect actual
> +	'
> +done
> =20
>  test_expect_success 'T: delete branch' '
>  	git branch to-delete &&
> @@ -3425,30 +3439,33 @@ test_expect_success 'U: validate directory delete=
 result' '
>  	compare_diff_raw expect actual
>  '
> =20
> -test_expect_success 'U: filedelete root succeeds' '
> -	cat >input <<-INPUT_END &&
> -	commit refs/heads/U
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	must succeed
> -	COMMIT
> -	from refs/heads/U^0
> -	D ""
> +for root in '""' ''
> +do
> +	test_expect_success "U: filedelete root ($root) succeeds" '
> +		cat >input <<-INPUT_END &&
> +		commit refs/heads/U-delete-root
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DA=
TE
> +		data <<COMMIT
> +		must succeed
> +		COMMIT
> +		from refs/heads/U^0
> +		D '"$root"'
> =20
> -	INPUT_END
> +		INPUT_END
> =20
> -	git fast-import <input
> -'
> +		git fast-import <input
> +	'
> =20
> -test_expect_success 'U: validate root delete result' '
> -	cat >expect <<-EOF &&
> -	:100644 000000 $f7id $ZERO_OID D	hello.c
> -	EOF
> +	test_expect_success "U: validate root ($root) delete result" '
> +		cat >expect <<-EOF &&
> +		:100644 000000 $f7id $ZERO_OID D	hello.c
> +		EOF
> =20
> -	git diff-tree -M -r U^1 U >actual &&
> +		git diff-tree -M -r U U-delete-root >actual &&
> =20
> -	compare_diff_raw expect actual
> -'
> +		compare_diff_raw expect actual
> +	'
> +done
> =20
>  ###
>  ### series V (checkpoint)
> --=20
> 2.44.0
>=20

--3zO2D4G0tQtCsoUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWMUkACgkQVbJhu7ck
PpQ33xAAkdHwW67Eht32FSQOMkGXwv53LaTXT5GoMqqbPndAnN4jrQcu5VE+NDFU
TAw3QtAFtP7409xrN6cFrj7Scd7Yd70obzwFQQc+kIrMHrrpOxNkWozazcqS5wyP
i2OCri3hYmcPmcLPtkxt5WlhBElvY8w/tCKCZLNwR4a3eTnG2psWhIIbCRFNd3Sg
/GVd0WFLTA7Xa/xEU1nvZrJMymfB2M2okM9hqqIrMK7LIHWgw8JN6rAG9aYS/33Q
EwW/7Q7hOra8x/+nkvR/k7xhwUjHuyV324+CTzwFX1C2mkoknLAarMHpztLABV+N
4q2WSvT4SdG56PncAaCOBLjnf1Hnc/wZRIt3otlYjyK0Smp2BNKul5tCZFXGwo6Z
dkUpjPfWmxO6APjw+qGtVMNdwuszAS6fozVeiZnPsSbMyO0KNZjl8km3lmIEgct2
KgPJ1i6BE7exPW/QTj99h7ktwOYzOIsnUu/oIzH0v18mi16IUFRGHcnOAQYrkYbE
Uh15LDZbdTVveHHxTSbiwYLU69tBIlgOp3ywnHveoHbflsH4it+U9ixCQ4yPRP/C
fxJ32GzrhOWbxjHeNjA2vLDmCbE9We2doUerLLNioktZEd2L2+z0Ydtbb11QMJpN
MmtEzWbXskcGFk+jGI48Mxpl7y/4rXJ6mJ0vQNX2HdKk993mXaA=
=AM/q
-----END PGP SIGNATURE-----

--3zO2D4G0tQtCsoUa--
