Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F4C2F2
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733770; cv=none; b=REoAEphkaA43iEbWnUMPZdZOghkMIS94gqkR416bsFk2/GVL8O+rg997gzE1JOYrYGYj6iUeBFGAGopBjmB9Ksasv2jg2wWXb+nQ1SyUhyNQczFCXppdHz0DX4Vi/lUDA6a9/DACen/no4/mQ6M5jo5BCaYzMco+CeDoDW+D55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733770; c=relaxed/simple;
	bh=mG+NuAQZ0aHDq6II3nJeFRA+o3Ncd2dxn0Zsz/16rPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMT9/i5jlmG6sZ00SQ/GVW5LYYxgUVG1/ug41+uB87ch1p32fuDggLhL0PVPuaZMoAsIXTOQEeKsffSR4kRSnfgVKFbcJB2AdVVV68TJriYYVZuor/fi36bOI7jV5CtDMM7tqRJahoHZx+Mve0W8HVDVEVF47+o5pXsx3cEra9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iFixngjS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgxuNSdS; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iFixngjS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgxuNSdS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B81B21140128;
	Tue, 15 Apr 2025 12:16:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 15 Apr 2025 12:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744733767; x=1744820167; bh=DLMTUMuVfN
	LtOFbZGukpF+JQcA9p98v2twvsF3DAuVI=; b=iFixngjSFVM4BcCE7znep70oV6
	TDOC7EJCev8Mi8j5GN2tUtGKEVpU4fMWFScfZzqrXqouSMdUnHpC6O5qjzgEQslo
	IcMxbytQJu25gZp7kNDdxQcT/7+jaJIOIUAmtXRBjSgxnohO1a6CBixrcAHGdrQo
	u4STHI95g1WTbVuIKNA9KTuMYWoYIyPI3qwk3b4vilLn0Ps2xMcgCW3UIVBUiCA6
	1lnsBhUP2NmmfS2u4nlJKoytR/o8ca6L/xqmlxIfGfILk6C/5U+CTubSLJcd9ah1
	Z+mNyV80IGahGm2wgusN2bqrhNbdGTWOVTiRyPNXX/8QYAy6uL8I6npIY5JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744733767; x=1744820167; bh=DLMTUMuVfNLtOFbZGukpF+JQcA9p98v2twv
	sF3DAuVI=; b=LgxuNSdScsd1K+VauBmQN/VeiJfzG5/e2Y3nyY368zveyHERGIE
	MJCfB8V9P4NZoo+QUn9jjgun3Z+mIkapms8aNFijmInk+Gs0qtAqbSrb8/UYaUC+
	DmnM8Q7ZN7CgKAdxRlIU9XETP08mc8jJElBcwKQu9MraNE923LKt4oRjvkzIYQwy
	FmEpb3galJPzBOsD620UwUeHZx1z/tKZGA6T6VxJgpPT4TI6GBOVxUWMCgB5YU/c
	oia39phdVabQdGeTVuDEBVyjZVXMJ1ZiI1Pf4Irs9Quup665tdYa6FKnihdqy81I
	tZz2NXEkpIEDViqBHi2AXG6HXYB6toHQ6BQ==
X-ME-Sender: <xms:R4b-Z1p__Na3Js6F2317FsoJ51e-wu0AoRvTN415GHdBUs97_mk1kg>
    <xme:R4b-Z3ox2x6CqdCyoDk-4s1VpMLj3YplDfPXeudsnClwr2h0LGiUZXSqexVBkYFT7
    US1O-ZgB68yo9eRLQ>
X-ME-Received: <xmr:R4b-ZyMFoHFZTxjtbqDI7iSXCIiZq9-7-0_XewjDCUkLQL85hRqBdXx0EWY-KryYUmrC6P8_DJYpMndjVmFDPu8C5ZJia3YLVhJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:R4b-Zw4O54CNb5yJpbndwzQwiRtNNTwd9zFe7mxQpfAm4HR-vrZsSQ>
    <xmx:R4b-Z05ULc43liKNtAAjoPxSmmQbKZQIfXM6crpgecO81sObO-thEw>
    <xmx:R4b-Z4iV2V9_MukMdFElhNm5ywLAZt_ns0Tg_dBcsvwBlszhdtJUPw>
    <xmx:R4b-Z25s-ocOB50jV196Q3p7-eYpyfHnKTkxKroo8Izdjt50O2iADQ>
    <xmx:R4b-Z3PzSjm64qm_icWGX4lCGZK_NblNI2MyNm8Q8c8l4yb5UGSultNy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 12:16:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] request-pull: stop depending on Perl
In-Reply-To: <20250415-b4-pks-drop-perl-v1-2-c6addf175858@pks.im> (Patrick
	Steinhardt's message of "Tue, 15 Apr 2025 11:57:09 +0200")
References: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
	<20250415-b4-pks-drop-perl-v1-2-c6addf175858@pks.im>
Date: Tue, 15 Apr 2025 09:16:05 -0700
Message-ID: <xmqqtt6pmmd6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While git-request-pull(1) is written as a shell script, for it to
> function we depend on Perl being available. The script gets installed
> unconditionally though, regardless of whether or not Perl is even
> available on the system. When it's not available, the `@PERL_PATH@`
> variable may be substituted with a nonexistent executable path and thus
> cause the script to fail.
>
> Refactor the script so that it does not depend on Perl at all anymore.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git-request-pull.sh     | 74 ++++++++++++++++++++++++++-----------------------
>  t/t5150-request-pull.sh |  6 ----
>  2 files changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index 775ba8ea11a..59276fe265b 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -78,41 +78,47 @@ fi
>  merge_base=$(git merge-base $baserev $headrev) ||
>  die "fatal: No commits in common between $base and $head"
>  
> -# $head is the refname from the command line.
> -# Find a ref with the same name as $head that exists at the remote
> +find_matching_ref () {
> +	while read sha1 ref
> +	do
> +		case "$ref" in
> +		*"^{}")
> +			ref="${ref%"^{}"}"
> +			deref=true

This got a bit tighter (the original allowed ls-remote output to be
later extended to throw "^something-else" at the end of line), which
I do not know is something we need to worry about.  I think retaining
the original semantics is easy in this case, e.g.,

		*"^"?*)
			ref="${ref%"^*"}"

or something, if we wanted to.  As this is meant to be faithful
rewrite to lose Perl, not a bugfix to correct overly loose pattern
matching in the original, I think we want to in this case.

> +			;;
> +		*)
> +			deref=
> +			;;
> +		esac
> +
> +		if test "$sha1" = "${remote:-HEAD}"
> +		then
> +			echo "$sha1 $sha1"
> +			break
> +		fi
> +
> +		case "$ref" in
> +		"${remote:-HEAD}"|*"/${remote:-HEAD}")
> +			if test -z "$deref"
> +			then
> +				# Remember the matching unpeeled object on the
> +				# remote side.
> +				remote_sha1="$sha1"
> +			fi
> +
> +			if test "$sha1" = "$headrev"
> +			then
> +				echo "${remote_sha1:-$headrev} $ref"
> +				break
> +			fi
> +			;;
> +		esac
> +	done
> +}
> +
> +# Find a ref with the same name as $remote that exists at the remote
>  # and points to the same commit as the local object.
> ...
> -set fnord $(git ls-remote "$url" | @PERL_PATH@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
> +set fnord $(git ls-remote "$url" | find_matching_ref)
>  remote_sha1=$2
>  ref=$3

This is faithful to the original, and having find_matching_ref in
the process substitution means we do not have to worry about
localizing variables in there.  Good.


