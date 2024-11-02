Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F453191
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730574701; cv=none; b=hez0r5mXWB4FtqLn0vG6jluiakHjt66LjL1UM/LeVlIWK3aGFkpWjVSKpZTzSJ/dr8WRkpekcwfofueR82M17mDjrPrIjGNpWZwbHd11U2RgHjjxwus/wrBCwnnSYu+vFczOHo0uXKO5dC/WKLSj8zgfktUirK0KoMo/uVJah2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730574701; c=relaxed/simple;
	bh=vMZtio1uDXvv9Pd0ebPSOV2WVRaRFA9SOjiby2MMsms=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n0B2LQOvIqYjzAGrWSzTyQ2MtHOF3b9lD6Rc+KLnZGoOkhKUhVRV1PzYHYBZFCPx18SWVAkhw1Y4qN1BC6KHbyvmbPoGH3HAeezoUoQOigoPWBQTFH6V/gXxYh4Daw808m1M9igYeMh+pd7pYebyctpDkGWtU+mQx+qm6EBXMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Kky//ZLx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqGdQ+0t; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Kky//ZLx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqGdQ+0t"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17A1425400A3;
	Sat,  2 Nov 2024 15:11:37 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 02 Nov 2024 15:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730574696;
	 x=1730661096; bh=CYqNrYqQh5s1bIKHHi6KW0rCXWihyrppo4r0Kr2CED4=; b=
	Kky//ZLxNjEmGJmrwdQbH8E8zSXfMOysA7wzcjLWx7cUlddCPdwyrMt6xblqFco4
	y1rC95Kj/4sisGhWHQotk0c1NB1kxIuHXNXFIQM9KdkLyBY6bXNErNq25LzFC9Vy
	rGLJuM+l/xhMMBmYiNsYX1z7VoWpzeBcgMUFq40GDBkGDvUQr87gm1Y+LEp78DbI
	5lbsqQDroCq4uqnpeETWm/bXIJ9cQQaYktdZ88vsCvEXoWYFPfgax/ORxfoH0D1p
	XauuhCalJyYUPBF1tQL8mYAO+LVmD4O5B62nh7Vv0ZcEIC1A4sdIyrQMEIk6dp6B
	RBFTPVzA1hiMfNm8nyn/qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730574696; x=1730661096; bh=C
	YqNrYqQh5s1bIKHHi6KW0rCXWihyrppo4r0Kr2CED4=; b=dqGdQ+0tV5pALtMV1
	9alB0T4Aevaca9PrsxUaMHOw3cHM7ZZF8a+U7zXz9muwlml+KiZoQh4asiNoxUU8
	fQrIfW1caHRk2cxwET7XfzOJ0kRpeIfbLGncb38caw0ZUqkGRO5TxkK/ivIRUJfV
	Z8CN3BTIyLxguXpI5nEYAiKUb/RexqhaJdmMjyAbfRlwBgoMk+Sr6zHUiqw9bYu8
	mG38wPDWSVzoetD7dbYWmEs2QbzTuwGZwMi28+lVQARwiV0Y0dSKBXZ4850PV7Mv
	ZU6MPy6DEhIDEl8mW3qrT08+P556PlR14W/VHzdlnRAxSCKnHj0IMjA7ppNLsn47
	eHWzQ==
X-ME-Sender: <xms:aHkmZzSDx_zCfuY4xCI78lbhs8Iu1B9OovWSjkAZRjJ4PkwgACuNLuA>
    <xme:aHkmZ0yxuTRchDDl43CR-i3_Lkwa4fq81NQSWhKrTVK-GvEC77Ax2ShwU4kG4y85-
    rxhh_m76DHdLxxhEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeluddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudelhfefkeehtefg
    geefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprghlghhonhgvlhhlsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aHkmZ40dy5nJTP59UMIfpHH1FcXgfqKU_idOr6_c-Mtu-CzbwOWlFA>
    <xmx:aHkmZzCv58Azz-3GXmITQ42SKdNxyeDsiLw9GnW-A4VhWqeG3Frwdw>
    <xmx:aHkmZ8h7jqb7XqfAwxDxS4fEU4tGTyXvB4nrv86eFaSzO2FWihbM2g>
    <xmx:aHkmZ3oAJ_te-DunQJ3umrhG1p6xlhvEg7sZ9qvGvf5pBchvtPYBJQ>
    <xmx:aHkmZ4Zw8wDAUxNfQKchnrKZ3YhODTeu0vw3IERKRKR0oNAMlf0aKGFG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA676780068; Sat,  2 Nov 2024 15:11:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 02 Nov 2024 20:11:02 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Andrew Kreimer" <algonell@gmail.com>, git@vger.kernel.org
Message-Id: <2a385fcd-7cb2-4d6c-8372-2139f11c85a8@app.fastmail.com>
In-Reply-To: <20241102165534.17112-1-algonell@gmail.com>
References: <20241102165534.17112-1-algonell@gmail.com>
Subject: Re: [PATCH] t1016: clean up style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

This looks correct according to CodingGuidelines, part =E2=80=9CFor shell
scripts=E2=80=9D.

=E2=80=A2 Whitespace and redirect operator
=E2=80=A2 Case arms indentation
=E2=80=A2 Tabs for indentation.  It might look like some of the lines in=
 the
  preimage (term?) use two nesting levels set to four columns, but that
  is because the first line is indented by four spaces and the next line
  is indented with one tab (eight columns).  The postimage changes them
  to use one tab per level.

On Sat, Nov 2, 2024, at 17:53, Andrew Kreimer wrote:
> Remove whitespace after redirect operator.
>
> Align mixed space/tab usages.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  t/t1016-compatObjectFormat.sh | 261 +++++++++++++++++-----------------
>  1 file changed, 130 insertions(+), 131 deletions(-)
>
> diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectForma=
t.sh
> index 8341a2fe83..06449937a3 100755
> --- a/t/t1016-compatObjectFormat.sh
> +++ b/t/t1016-compatObjectFormat.sh
> @@ -24,84 +24,84 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  # the commit is identical to the commit in the other repository.
>
>  compat_hash () {
> -    case "$1" in
> -    "sha1")
> -	echo "sha256"
> -	;;
> -    "sha256")
> -	echo "sha1"
> -	;;
> -    esac
> +	case "$1" in
> +	"sha1")
> +		echo "sha256"
> +		;;
> +	"sha256")
> +		echo "sha1"
> +		;;
> +	esac
>  }
>
>  hello_oid () {
> -    case "$1" in
> -    "sha1")
> -	echo "$hello_sha1_oid"
> -	;;
> -    "sha256")
> -	echo "$hello_sha256_oid"
> -	;;
> -    esac
> +	case "$1" in
> +	"sha1")
> +		echo "$hello_sha1_oid"
> +		;;
> +	"sha256")
> +		echo "$hello_sha256_oid"
> +		;;
> +	esac
>  }
>
>  tree_oid () {
> -    case "$1" in
> -    "sha1")
> -	echo "$tree_sha1_oid"
> -	;;
> -    "sha256")
> -	echo "$tree_sha256_oid"
> -	;;
> -    esac
> +	case "$1" in
> +	"sha1")
> +		echo "$tree_sha1_oid"
> +		;;
> +	"sha256")
> +		echo "$tree_sha256_oid"
> +		;;
> +	esac
>  }
>
>  commit_oid () {
> -    case "$1" in
> -    "sha1")
> -	echo "$commit_sha1_oid"
> -	;;
> -    "sha256")
> -	echo "$commit_sha256_oid"
> -	;;
> -    esac
> +	case "$1" in
> +	"sha1")
> +		echo "$commit_sha1_oid"
> +		;;
> +	"sha256")
> +		echo "$commit_sha256_oid"
> +		;;
> +	esac
>  }
>
>  commit2_oid () {
> -    case "$1" in
> -    "sha1")
> -	echo "$commit2_sha1_oid"
> -	;;
> -    "sha256")
> -	echo "$commit2_sha256_oid"
> -	;;
> -    esac
> +	case "$1" in
> +	"sha1")
> +		echo "$commit2_sha1_oid"
> +		;;
> +	"sha256")
> +		echo "$commit2_sha256_oid"
> +		;;
> +	esac
>  }
>
>  del_sigcommit () {
> -    local delete=3D"$1"
> -
> -    if test "$delete" =3D "sha256" ; then
> -	local pattern=3D"gpgsig-sha256"
> -    else
> -	local pattern=3D"gpgsig"
> -    fi
> -    test-tool delete-gpgsig "$pattern"
> +	local delete=3D"$1"
> +
> +	if test "$delete" =3D "sha256" ; then
> +		local pattern=3D"gpgsig-sha256"
> +	else
> +		local pattern=3D"gpgsig"
> +	fi
> +	test-tool delete-gpgsig "$pattern"
>  }
>
>
>  del_sigtag () {
> -    local storage=3D"$1"
> -    local delete=3D"$2"
> -
> -    if test "$storage" =3D "$delete" ; then
> -	local pattern=3D"trailer"
> -    elif test "$storage" =3D "sha256" ; then
> -	local pattern=3D"gpgsig"
> -    else
> -	local pattern=3D"gpgsig-sha256"
> -    fi
> -    test-tool delete-gpgsig "$pattern"
> +	local storage=3D"$1"
> +	local delete=3D"$2"
> +
> +	if test "$storage" =3D "$delete" ; then
> +		local pattern=3D"trailer"
> +	elif test "$storage" =3D "sha256" ; then
> +		local pattern=3D"gpgsig"
> +	else
> +		local pattern=3D"gpgsig-sha256"
> +	fi
> +	test-tool delete-gpgsig "$pattern"
>  }
>
>  base=3D$(pwd)
> @@ -146,9 +146,9 @@ do
>  	'
>  	test_expect_success "create a $hash branch" '
>  		git checkout -b branch $(commit_oid $hash) &&
> -		echo "More more more give me more!" > more &&
> +		echo "More more more give me more!" >more &&
>  		eval more_${hash}_oid=3D$(git hash-object more) &&
> -		echo "Another and another and another" > another &&
> +		echo "Another and another and another" >another &&
>  		eval another_${hash}_oid=3D$(git hash-object another) &&
>  		git update-index --add more another &&
>  		git commit -m "Add more files!" &&
> @@ -165,15 +165,15 @@ do
>  	'
>  	test_expect_success GPG2 "create additional $hash signed commits" '
>  		git commit --gpg-sign --allow-empty -m "This is an additional signed
> commit" &&
> -		git cat-file commit HEAD | del_sigcommit sha256 >
> "../${hash}_signedcommit3" &&
> -		git cat-file commit HEAD | del_sigcommit sha1 >
> "../${hash}_signedcommit4" &&
> +		git cat-file commit HEAD | del_sigcommit sha256
> >"../${hash}_signedcommit3" &&
> +		git cat-file commit HEAD | del_sigcommit sha1
> >"../${hash}_signedcommit4" &&
>  		eval signedcommit3_${hash}_oid=3D$(git hash-object -t commit -w
> ../${hash}_signedcommit3) &&
>  		eval signedcommit4_${hash}_oid=3D$(git hash-object -t commit -w
> ../${hash}_signedcommit4)
>  	'
>  	test_expect_success GPG2 "create additional $hash signed tags" '
>  		git tag -s -m "This is an additional signed tag" signedtag34 HEAD &&
> -		git cat-file tag signedtag34 | del_sigtag "${hash}" sha256 >
> ../${hash}_signedtag3 &&
> -		git cat-file tag signedtag34 | del_sigtag "${hash}" sha1 >
> ../${hash}_signedtag4 &&
> +		git cat-file tag signedtag34 | del_sigtag "${hash}" sha256
> >../${hash}_signedtag3 &&
> +		git cat-file tag signedtag34 | del_sigtag "${hash}" sha1
> >../${hash}_signedtag4 &&
>  		eval signedtag3_${hash}_oid=3D$(git hash-object -t tag -w
> ../${hash}_signedtag3) &&
>  		eval signedtag4_${hash}_oid=3D$(git hash-object -t tag -w
> ../${hash}_signedtag4)
>  	'
> @@ -181,81 +181,80 @@ done
>  cd "$base"
>
>  compare_oids () {
> -    test "$#" =3D 5 && { local PREREQ=3D"$1"; shift; } || PREREQ=3D
> -    local type=3D"$1"
> -    local name=3D"$2"
> -    local sha1_oid=3D"$3"
> -    local sha256_oid=3D"$4"
> -
> -    echo ${sha1_oid} > ${name}_sha1_expected
> -    echo ${sha256_oid} > ${name}_sha256_expected
> -    echo ${type} > ${name}_type_expected
> -
> -    git --git-dir=3Drepo-sha1/.git rev-parse
> --output-object-format=3Dsha256 ${sha1_oid} > ${name}_sha1_sha256_found
> -    git --git-dir=3Drepo-sha256/.git rev-parse
> --output-object-format=3Dsha1 ${sha256_oid} > ${name}_sha256_sha1_found
> -    local sha1_sha256_oid=3D"$(cat ${name}_sha1_sha256_found)"
> -    local sha256_sha1_oid=3D"$(cat ${name}_sha256_sha1_found)"
> -
> -    test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
> -	git --git-dir=3Drepo-sha256/.git rev-parse --output-object-format=3D=
sha1
> ${sha256_oid} > ${name}_sha1 &&
> -	test_cmp ${name}_sha1 ${name}_sha1_expected
> -'
> -
> -    test_expect_success $PREREQ "Verify ${type} ${name}'s sha256 oid"=
 '
> -	git --git-dir=3Drepo-sha1/.git rev-parse --output-object-format=3Dsh=
a256
> ${sha1_oid} > ${name}_sha256 &&
> -	test_cmp ${name}_sha256 ${name}_sha256_expected
> -'
> +	test "$#" =3D 5 && { local PREREQ=3D"$1"; shift; } || PREREQ=3D
> +	local type=3D"$1"
> +	local name=3D"$2"
> +	local sha1_oid=3D"$3"
> +	local sha256_oid=3D"$4"
> +
> +	echo ${sha1_oid} >${name}_sha1_expected
> +	echo ${sha256_oid} >${name}_sha256_expected
> +	echo ${type} >${name}_type_expected
> +
> +	git --git-dir=3Drepo-sha1/.git rev-parse --output-object-format=3Dsh=
a256
> ${sha1_oid} >${name}_sha1_sha256_found
> +	git --git-dir=3Drepo-sha256/.git rev-parse --output-object-format=3D=
sha1
> ${sha256_oid} >${name}_sha256_sha1_found
> +	local sha1_sha256_oid=3D"$(cat ${name}_sha1_sha256_found)"
> +	local sha256_sha1_oid=3D"$(cat ${name}_sha256_sha1_found)"
> +
> +	test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
> +		git --git-dir=3Drepo-sha256/.git rev-parse --output-object-format=3D=
sha1
> ${sha256_oid} >${name}_sha1 &&
> +		test_cmp ${name}_sha1 ${name}_sha1_expected
> +	'
>
> -    test_expect_success $PREREQ "Verify ${name}'s sha1 type" '
> -	git --git-dir=3Drepo-sha1/.git cat-file -t ${sha1_oid} > ${name}_typ=
e1
> &&
> -	git --git-dir=3Drepo-sha256/.git cat-file -t ${sha256_sha1_oid} >
> ${name}_type2 &&
> -	test_cmp ${name}_type1 ${name}_type2 &&
> -	test_cmp ${name}_type1 ${name}_type_expected
> -'
> +	test_expect_success $PREREQ "Verify ${type} ${name}'s sha256 oid" '
> +		git --git-dir=3Drepo-sha1/.git rev-parse --output-object-format=3Ds=
ha256
> ${sha1_oid} >${name}_sha256 &&
> +		test_cmp ${name}_sha256 ${name}_sha256_expected
> +	'
>
> -    test_expect_success $PREREQ "Verify ${name}'s sha256 type" '
> -	git --git-dir=3Drepo-sha256/.git cat-file -t ${sha256_oid} >
> ${name}_type3 &&
> -	git --git-dir=3Drepo-sha1/.git cat-file -t ${sha1_sha256_oid} >
> ${name}_type4 &&
> -	test_cmp ${name}_type3 ${name}_type4 &&
> -	test_cmp ${name}_type3 ${name}_type_expected
> -'
> +	test_expect_success $PREREQ "Verify ${name}'s sha1 type" '
> +		git --git-dir=3Drepo-sha1/.git cat-file -t ${sha1_oid} >${name}_typ=
e1
> &&
> +		git --git-dir=3Drepo-sha256/.git cat-file -t ${sha256_sha1_oid}
> >${name}_type2 &&
> +		test_cmp ${name}_type1 ${name}_type2 &&
> +		test_cmp ${name}_type1 ${name}_type_expected
> +	'
>
> -    test_expect_success $PREREQ "Verify ${name}'s sha1 size" '
> -	git --git-dir=3Drepo-sha1/.git cat-file -s ${sha1_oid} > ${name}_siz=
e1
> &&
> -	git --git-dir=3Drepo-sha256/.git cat-file -s ${sha256_sha1_oid} >
> ${name}_size2 &&
> -	test_cmp ${name}_size1 ${name}_size2
> -'
> +	test_expect_success $PREREQ "Verify ${name}'s sha256 type" '
> +		git --git-dir=3Drepo-sha256/.git cat-file -t ${sha256_oid}
> >${name}_type3 &&
> +		git --git-dir=3Drepo-sha1/.git cat-file -t ${sha1_sha256_oid}
> >${name}_type4 &&
> +		test_cmp ${name}_type3 ${name}_type4 &&
> +		test_cmp ${name}_type3 ${name}_type_expected
> +	'
>
> -    test_expect_success $PREREQ "Verify ${name}'s sha256 size" '
> -	git --git-dir=3Drepo-sha256/.git cat-file -s ${sha256_oid} >
> ${name}_size3 &&
> -	git --git-dir=3Drepo-sha1/.git cat-file -s ${sha1_sha256_oid} >
> ${name}_size4 &&
> -	test_cmp ${name}_size3 ${name}_size4
> -'
> +	test_expect_success $PREREQ "Verify ${name}'s sha1 size" '
> +		git --git-dir=3Drepo-sha1/.git cat-file -s ${sha1_oid} >${name}_siz=
e1
> &&
> +		git --git-dir=3Drepo-sha256/.git cat-file -s ${sha256_sha1_oid}
> >${name}_size2 &&
> +		test_cmp ${name}_size1 ${name}_size2
> +	'
>
> -    test_expect_success $PREREQ "Verify ${name}'s sha1 pretty content"
> '
> -	git --git-dir=3Drepo-sha1/.git cat-file -p ${sha1_oid} >
> ${name}_content1 &&
> -	git --git-dir=3Drepo-sha256/.git cat-file -p ${sha256_sha1_oid} >
> ${name}_content2 &&
> -	test_cmp ${name}_content1 ${name}_content2
> -'
> +	test_expect_success $PREREQ "Verify ${name}'s sha256 size" '
> +		git --git-dir=3Drepo-sha256/.git cat-file -s ${sha256_oid}
> >${name}_size3 &&
> +		git --git-dir=3Drepo-sha1/.git cat-file -s ${sha1_sha256_oid}
> >${name}_size4 &&
> +		test_cmp ${name}_size3 ${name}_size4
> +	'
>
> -    test_expect_success $PREREQ "Verify ${name}'s sha256 pretty
> content" '
> -	git --git-dir=3Drepo-sha256/.git cat-file -p ${sha256_oid} >
> ${name}_content3 &&
> -	git --git-dir=3Drepo-sha1/.git cat-file -p ${sha1_sha256_oid} >
> ${name}_content4 &&
> -	test_cmp ${name}_content3 ${name}_content4
> -'
> +	test_expect_success $PREREQ "Verify ${name}'s sha1 pretty content" '
> +		git --git-dir=3Drepo-sha1/.git cat-file -p ${sha1_oid}
> >${name}_content1 &&
> +		git --git-dir=3Drepo-sha256/.git cat-file -p ${sha256_sha1_oid}
> >${name}_content2 &&
> +		test_cmp ${name}_content1 ${name}_content2
> +	'
>
> -    test_expect_success $PREREQ "Verify ${name}'s sha1 content" '
> -	git --git-dir=3Drepo-sha1/.git cat-file ${type} ${sha1_oid} >
> ${name}_content5 &&
> -	git --git-dir=3Drepo-sha256/.git cat-file ${type} ${sha256_sha1_oid}=
 >
> ${name}_content6 &&
> -	test_cmp ${name}_content5 ${name}_content6
> -'
> +	test_expect_success $PREREQ "Verify ${name}'s sha256 pretty content"=
 '
> +		git --git-dir=3Drepo-sha256/.git cat-file -p ${sha256_oid}
> >${name}_content3 &&
> +		git --git-dir=3Drepo-sha1/.git cat-file -p ${sha1_sha256_oid}
> >${name}_content4 &&
> +		test_cmp ${name}_content3 ${name}_content4
> +	'
>
> -    test_expect_success $PREREQ "Verify ${name}'s sha256 content" '
> -	git --git-dir=3Drepo-sha256/.git cat-file ${type} ${sha256_oid} >
> ${name}_content7 &&
> -	git --git-dir=3Drepo-sha1/.git cat-file ${type} ${sha1_sha256_oid} >
> ${name}_content8 &&
> -	test_cmp ${name}_content7 ${name}_content8
> -'
> +	test_expect_success $PREREQ "Verify ${name}'s sha1 content" '
> +		git --git-dir=3Drepo-sha1/.git cat-file ${type} ${sha1_oid}
> >${name}_content5 &&
> +		git --git-dir=3Drepo-sha256/.git cat-file ${type} ${sha256_sha1_oid}
> >${name}_content6 &&
> +		test_cmp ${name}_content5 ${name}_content6
> +	'

Everything up to here looks like whitespace changes.  Indeed.

>
> +	test_expect_success $PREREQ "Verify ${name}'s sha256 content" '
> +		git --git-dir=3Drepo-sha256/.git cat-file ${type} ${sha256_oid}
> >${name}_content7 &&
> +		git --git-dir=3Drepo-sha1/.git cat-file ${type} ${sha1_sha256_oid}
> >${name}_content8 &&
> +		test_cmp ${name}_content7 ${name}_content8
> +	'
>  }

But this is diffed as an addition.  Seems like either a mistake or the
commit message and/or patch comment (`---`) didn=E2=80=99t mention this =
kind of
change.

>
>  compare_oids 'blob' hello "$hello_sha1_oid" "$hello_sha256_oid"
> --
> 2.47.0.170.g23d289d273.dirty
