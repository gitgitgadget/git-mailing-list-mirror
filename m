Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE6142659
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660378; cv=none; b=Agh7SZrRTqbzJWwI+haMPXZK+youydCJj2ialbdcywOh6DNErmVoMwjHqvW3FMyO7ecRrfh0c7WJeEJeaw2/jfKT8dU3RjsB4Q+HTO9dWul7WAdBQA9iXR+nnqldK/ojP2dfpFBbSeIveR5sL65F0JXkadJ3TggyTSW3lU6uXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660378; c=relaxed/simple;
	bh=mr3pJGUHAY8c8rw7j8ZmJKxcLcRB2a38hpqz+qHfNDM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J72GZN1FYoMPG0t8qZHqpBplHdMW+LJ5voLYgUlTA5SZAOmKDSczf8/picwExldaQkDa3DhwCTvoHur2WXJjPRZk5CvGqLDnCeU3XbAoZI/VI1Q04qHeO8FTtyyhEr1AfY6yRn4gS9PFzwYzEYJF63Aj6DosckOX4AQZizUTbCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=elNpc0X+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CH+Za9Ji; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="elNpc0X+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CH+Za9Ji"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D917D25400F3;
	Sun,  3 Nov 2024 13:59:33 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 03 Nov 2024 13:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730660373;
	 x=1730746773; bh=Hx29ejht1YkFG267jos2uCRaWEuWKXoq215SLwTna7g=; b=
	elNpc0X+S2GV6ovi6qPvUMpRDI1Dj8+k3fxahlvLQNDw0/xiLdTiuiaQjkwuWwt2
	xUBs09Va/wDHSafvze5WiFLeksNAXf33Oc9hc91aCJKFh3KWZX+AoYtYvgr3IgMD
	FelVOB9D8WqPCc5tdjPtwyoHN3/r4sFkzzt3xZaRF99jo4UkLHkzU5sUeE/Vzm0p
	EEwQtez+ufOJJczrdICJxWoOtUKZc1hVGVVubPVGZDVYGm2wqsnUgs3LfYn5IQDS
	fiEZuLguKOAH067joB7FTX4S3AMsE9xb177X/VQNZw9iaxsXSUA69R9x14ZUIZ0A
	0Wl17bgw6F56lcFJL9wxVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730660373; x=1730746773; bh=H
	x29ejht1YkFG267jos2uCRaWEuWKXoq215SLwTna7g=; b=CH+Za9JiS6ZffGuoB
	vYhZlyZXwICFgxQ6K84WwiSnsl5dl84mnN1yPr7zLWNN4X2lbPBrJk08KC8q2w2/
	Yb7sgWQgzUcC7smyYtGmTsl5a7/37j+6YCNKcDALUqyBUCO9FZt5UQWqpo559vq4
	P04sOkPr/oU0OgYHtML3JU1Yx2kJ9ieUv+eF3AC3fjyGfuntTJciuwQ2fnd0aqIk
	TMc3p+tJGshPHQUAqcZLe/cIvDcAlubSJSRzj3/d1fKEWYTuXKXYcaByiVZbZCg1
	YyJa7bmNwtIVPIyQw5H/aQZNHsLyvQujksFrj8lQg2lzio9t9E1Dwq4M28AeWzJV
	o48lQ==
X-ME-Sender: <xms:FcgnZyrCxV1wxJLZ_uLuEhju1LdaFX9Dkd3NiCle_ExSVnvbi8vdH_s>
    <xme:FcgnZwqEU0yIhYx6yR8snLqQMEiMyo6iiL-sSa9p5YcJKnirv2MM4v-KC9jGRWdNQ
    eKu7hmjtCxPd8nAAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeukeegfeduveevteeileeihfeu
    gedugfeludetleejieeikeekhfejudfggeeiueenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghlghhonhgvlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FcgnZ3OMyOQtUCiNZGk6N2vjOV55ou9EROVCFyqXCt7p8me8VG1G8A>
    <xmx:FcgnZx6LehBn5v_e3LrwqxQX5xA4PL0XevlOKaADvXqDMxZD-saVcA>
    <xmx:FcgnZx70FZ3Jz0ae6tM2p_2xfeLWAbX6x4VYGARJwsJWBQNBlJGKUw>
    <xmx:FcgnZxiBOixZEE6SGBdVzBkxZHDjQJIVQu78Kb23NnVQpOYAy9dl4g>
    <xmx:FcgnZzSc4BSWn4HzkNaOCIToAVTMtXORcFp9H_hixE5BU86F72V3uApd>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 838C3780068; Sun,  3 Nov 2024 13:59:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 03 Nov 2024 19:59:08 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Andrew Kreimer" <algonell@gmail.com>, git@vger.kernel.org
Message-Id: <66df52dd-1b7c-4ca8-9752-646b5b223feb@app.fastmail.com>
In-Reply-To: <20241103135111.13508-1-algonell@gmail.com>
References: <20241102165534.17112-1-algonell@gmail.com>
 <20241103135111.13508-1-algonell@gmail.com>
Subject: Re: [PATCH v2] t1016: clean up style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I can confirm that everything looks correct now.  Like in my reply
to v1.

https://lore.kernel.org/git/20241103135111.13508-1-algonell@gmail.com/T/=
#m0d6626e6495b978b7116bf1561effe10f6792d24

On Sun, Nov 3, 2024, at 14:50, Andrew Kreimer wrote:
> Adhere to Documentation/CodingGuidelines:
>   - Whitespace and redirect operator.
>   - Case arms indentation.
>   - Tabs for indentation.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> v2:
>   - Base on: "The seventh batch".
>   - Remove the extra line in between functions.
>   - Elaborate on the changes (thank you, Kristoffer).
>
>  t/t1016-compatObjectFormat.sh | 262 +++++++++++++++++-----------------
>  1 file changed, 130 insertions(+), 132 deletions(-)
>
> diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectForma=
t.sh
> index 8341a2fe83..32e0af392e 100755
> --- a/t/t1016-compatObjectFormat.sh
> +++ b/t/t1016-compatObjectFormat.sh
> @@ -24,84 +24,83 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
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
> -
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
> @@ -146,9 +145,9 @@ do
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
> @@ -165,15 +164,15 @@ do
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
> @@ -181,81 +180,80 @@ done
>  cd "$base"

All changes up to here are straightforward.

After this my pager[1] gets confused and `--color-words` becomes useful.

=F0=9F=94=97 1: https://github.com/dandavison/delta

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

At this point the diff gets weird.  There seems to be too many
whitespace changes to get a good diff.  But that can be handled (see
next part).

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

Indeed this looks like only indentation and redirection whitespace fixes.

> +	test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
> +		git --git-dir=3Drepo-sha256/.git rev-parse --output-object-format=3D=
sha1
> ${sha256_oid} >${name}_sha1 &&
> +		test_cmp ${name}_sha1 ${name}_sha1_expected
> +	'

At this point it _looks like_ some `test_expect_success` are moved
around.  But my diff deceives me: all of the eight `test_` are provided
in the same order in the preimage and postimage.

Here I removed the fixes for the trailing `'`, i.e. moved them back to
the beginning of the line:

```
'
```

And that gave me a nice clean diff which again highlighted the
indentation fixes as well as the redirection operator fixes.

Indeed it all looks correct.

> [=E2=80=A6]
