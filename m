Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6141187FFA
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734758; cv=none; b=BDMibWdEdat1zgz+5PfVlT7krtKKRuGP/OkaxXJulnWf7EXSjdrnCX4PgH4M2DhuiiBFKqTfg034R9PhGMyc9lGYsZ5AQoroYW6QAqVb7FgdyAKkk1FHB9Ij+UP1VyXNFIlnlAgcVgDfMK8Br1CXoPTiXkrYPOWzC4Gou/yIZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734758; c=relaxed/simple;
	bh=e+rQRaOjaFg+fLduhEtSZAbj3JKCvpQ2MLgYAVIlVu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sVBP+mT6vTdZ8KZqy8ST/P2p+lkEuomh4HUGguETKTfSjHMTFf+kfgRsyS3JvOhi5pfxbBL9FQKLSRidGztkI8meMx7yzOBWPsC6ScspUFoozL2gedHzcbSUiZAWNpoJ5Rx+bclT7GLsX+GUM3sWcydDGaWx8pmqhdG+/56USIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tTrIIJNV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H6rgNDDu; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tTrIIJNV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H6rgNDDu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E890B2540163;
	Tue, 15 Apr 2025 12:32:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 12:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744734755;
	 x=1744821155; bh=77sck+9ZXUVFjCpm1vJzWn9rKViGxEZohxcY6aohZK4=; b=
	tTrIIJNVZnw6MPv4Usii0BT7NTriKS/yin6K6PZ5WyAyg2rmTLc3cjK4Sz6aTbmT
	OdmCuaWYHO5wrgzUf09NresXEuvtlKfX+gcHQBg0sc+x3DdCUK3WWtVTIDw02mrA
	gAgL0OL+boY1OKiNIeK52J5nManC7vI+/+rXzswZ3ryEbX5/eaFjThmtbWUJkXoJ
	BTOyFnSM/wp757IPlv9huKVd6ewjhwreZFQ6oQmx5pYU+D1Fn/2wFRKDoWy/dk/S
	6tbwnlDv7gduC3BXkfObF2m27IBqDDAaVePLIbhhTsbNy6ovuSwMvyDJrQDkAgxx
	Nlhg0Pd5R4hMY1exiNZC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744734755; x=
	1744821155; bh=77sck+9ZXUVFjCpm1vJzWn9rKViGxEZohxcY6aohZK4=; b=H
	6rgNDDu/gS+7FiQfinjquzkUw1xNEsmOhi58K5fDCmZnXGHNZfwl0HuIpBxuc+U8
	NiBj2ciDMJwm/BV0p1oJhQm4CG3yZleGVSFRcw1vEGMoh7n15Dp3AzNNjlXe79oB
	X2rl6iEGOLm6xECVu4Wa4DJCkvhXAnJv9tQFC+OKlIBYBzpSnh5lqxnpB+l9Yx/d
	LkKF2mca0hJYI1ZEiHrhMwD41VIF56fmjp30mePJ4PugQQhBfZ2lQZ9ws/tsjY/q
	sWNJXNb/u86xgqRZPwkK0mhvHycFsXEVhUvBbBaprDY5yCrRtm4FrbOe6mMr6uQM
	0n+4rEunL2+CvGbEhKBPw==
X-ME-Sender: <xms:I4r-Z2e9yK4kvJBvSqzwP_h0sgeR4dgghozuzWKz8mOHIzgst4nHSg>
    <xme:I4r-ZwNLjfrEHml36rzTZuJijoHGW5TKqNorp5TjxcI1OYaYZgnndyUK_xjT00P20
    cKdGJz0-LalRZHAWw>
X-ME-Received: <xmr:I4r-Z3j6sVcIdpYItE9cbJC-J8DC9lHa4It_LVvw6Zz3myOST6bFgbIYskgaAovbs5hz_bsaMhRytlC9uF7erE1MVvhO7CUiyXjN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkefotddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdt
    jefhgfekhffhteeiffetheelhedtgfehtdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I4r-Zz_hUnltpcAGXp5zPSKkh4vs90cdofzDLXcQrm0LsTS4l-OLAQ>
    <xmx:I4r-ZytGAKPN-aAOOAL9YozV384nH0sKaJaWMM1EajUMbjiqeoHiGA>
    <xmx:I4r-Z6EesyCkKZ5O_WFSWvAvRUm_6oZSpHQarqLEK-w_P7cyCvMMyA>
    <xmx:I4r-ZxNC0iaHkkJyH72g9h1f95NBZ9-Lvb2W9boMi-SRD84uuaVu6A>
    <xmx:I4r-Z4jWTyhF9qNj_-D0Dyd78GOCMnG-Q7MSaCAwa_CoB6P512zVnim6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 12:32:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Documentation: stop depending on Perl to generate
 command list
In-Reply-To: <20250415-b4-pks-drop-perl-v1-4-c6addf175858@pks.im> (Patrick
	Steinhardt's message of "Tue, 15 Apr 2025 11:57:11 +0200")
References: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
	<20250415-b4-pks-drop-perl-v1-4-c6addf175858@pks.im>
Date: Tue, 15 Apr 2025 09:32:33 -0700
Message-ID: <xmqqmschmllq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> The "cmd-list.perl" script is used to extract the list of commands part
> of a specific category and extracts the description of each command from
> its respective manpage. The generated output is then included in git(1)
> to list all Git commands.
>
> The script is written in Perl. Refactor it to use shell scripting
> exclusively so that we can get rid of the mandatory dependency on Perl
> to build our documentation.
>
> The converted script is slower compared to its Perl implementation. But
> by being careful and not spawning external commands in `format_one ()`
> we can mitigate the performance hit to a reasonable level:
>
>     Benchmark 1: Perl
>       Time (mean ± σ):      10.3 ms ±   0.2 ms    [User: 7.0 ms, System: 3.3 ms]
>       Range (min … max):    10.0 ms …  11.1 ms    200 runs
>
>     Benchmark 2: Shell
>       Time (mean ± σ):      74.4 ms ±   0.4 ms    [User: 48.6 ms, System: 24.7 ms]
>       Range (min … max):    73.1 ms …  75.5 ms    200 runs
>
>     Summary
>       Perl ran
>         7.23 ± 0.13 times faster than Shell
>
> While a sevenfold slowdown is significant, the benefit of not requiring
> Perl for a fully-functioning Git installation outweighs waiting a couple
> of milliseconds longer during the build process.

I personally do not feel Perl such a drag but whether it is 10ms vs
75ms, as long as we won't run the script excessively (and either
meson or make should be set-up to avoid unnecessary work already), I
do not think a shell script being slightly slower than a Perl script
is a big deal.  Thanks for working on this.

> diff --git a/Documentation/cmd-list.sh b/Documentation/cmd-list.sh
> new file mode 100755
> index 00000000000..fa90781f3c7
> --- /dev/null
> +++ b/Documentation/cmd-list.sh
> @@ -0,0 +1,104 @@
> +#!/bin/sh
> +
> +set -e
> +
> +format_one () {
> +	source_dir="$1"
> +	command="$2"
> +	attributes="$3"
> +
> +	path="$source_dir/Documentation/$command.adoc"
> +	if ! test -f "$path"
> +	then
> +		echo >&2 "No such file $path"
> +		exit 1
> +	fi
> +
> +	state=0
> +	while read line
> +	do
> +		case "$state" in
> +			0)

Style. label and "case" and "esac" align, just like ...

> +				case "$line" in
> +				git*\(*\)|scalar*\(*\))
> +					mansection="${line##*\(}"

... this one.

> +					mansection="${mansection%\)}"
> +					;;
> +				NAME)
> +					state=1;;
> +				esac
> +				;;

> +	case "$description" in
> +		"$command - "*)

Likewise.

> +			text="${description#$command - }"
> +
> +			printf "linkgit:%s[%s]::\n\t" "$command" "$mansection"
> +			case "$attributes" in
> +				*" deprecated "*)

Ditto.

> +					printf "(deprecated) "
> +					;;
> +			esac
> +			printf "$text.\n\n"
> +			;;
> +		*)
> +			echo >&2 "Description does not match $command: $description"
> +			exit 1
> +			;;
> +	esac
> +}
> +
> +source_dir="$1"
> +build_dir="$2"
> +shift 2
> +
> +for out in "$@"

Let's omit 'in "$@"' when iterationg over "$@".

> +do
> +	category="${out#cmds-}"
> +	category="${category%.adoc}"
> +	path="$build_dir/$out"
> +
> +	while read command command_category attributes
> +	do
> +		case "$command" in
> +		"#"*)
> +			continue;;
> +		esac
> +
> +		case "$command_category" in
> +		"$category")
> +			format_one "$source_dir" "$command" " $attributes ";;
> +		esac
> +	done <"$source_dir/command-list.txt" >"$build_dir/$out+"
> +
> +	if cmp "$build_dir/$out+" "$build_dir/$out" >/dev/null 2>&1
> +	then
> +		rm "$build_dir/$out+"
> +	else
> +		mv "$build_dir/$out+" "$build_dir/$out"
> +	fi
> +done

OK.

