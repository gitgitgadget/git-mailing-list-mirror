Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB0C230D1E
	for <git@vger.kernel.org>; Thu, 29 May 2025 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562324; cv=none; b=TOhXvK7TAZQt6nhIVGlK48GTI08ijfL7OXWhWHhM9AXS6mun81L52mBZQQhCzYJg4d6oTvM+XKYuPDJ9HPaMlkmiYCVPNOhwfUKvyqJZ5ukxL1Eqj6S/um5M/Vagu7F+02btlsArzDraASnK/flLmJGyP/OkJwOI6OrUeIQM9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562324; c=relaxed/simple;
	bh=J5riAQQUMNgsKgIEgHkz9W5zfM2gVuwblfC4OISEdhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xfm09N0oq/tljbhsXi9mAzUdQJfSuUU237pIa1Flzb97K/XcHq80GX6WxRPKUGgLfDaMba+tvl+/mHJPAzO3HfLa5t1DoqaEUblI30wR/PRyHFHsKlA4PBHFTb0UXt/bN7+IrHVhm4h9+7ucnXfCLarJHZsiCnHt63gxXjaAhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G8sq1lef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EjB+oLdN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G8sq1lef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EjB+oLdN"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29F901140152;
	Thu, 29 May 2025 19:45:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 29 May 2025 19:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748562321; x=1748648721; bh=d/sfEuf+V2
	K8YtQPVbHx5G3WvHHztDrFgnr/CPO+gyw=; b=G8sq1lefHOThyYGRj1m0M/iESw
	iyJ8OaM3MksKQ81wmEc9ncKtRgAr53nuXmBej+CiMPiFeZk/g/KmpUD0V6Yqe3Jp
	LASizZPI1AsJAEBJXaYeQDB/qrboPLynFjg0jIvYz3iVSzeLU/wpy0I34QsosvrR
	x3gsJgZths7sUZ4a3gHkc1P8tAoAJyg0zyA8rFvvdJRmXYFzu2aMkMztpicgn1oD
	QgZTc5ySe44P7nepQPidSHIeBHhiq3kPGvRochmoryQ6CVqDad0VRBHALY8GnvN/
	US1g7VEw2bIuC2gfAEZTrffHta0ZHbNmxMXUdUfXkWtmCpKwlZqNg1cVCEXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748562321; x=1748648721; bh=d/sfEuf+V2K8YtQPVbHx5G3WvHHztDrFgnr
	/CPO+gyw=; b=EjB+oLdNjAnHJgDdCZQjYjkjLuL8bz9g1tzkew/7U3nVpD1QlWF
	HvZY0YR2+rO+buxCVNTaC6ZrnDq0y+xTVJT058XNpoKG5fB8B8+hyEUVk1jfhCBU
	qKvnBnItpB53V9mP/Sadjtr4ROIoFtj5KJ2UuMR7zil4GHwihJA14gptYn54Bwuj
	/f38jpPBQs1jMKqCxlob/0ClGoRREBNTuhZV8GLyjWr7e/qMVR35ZMVSkvKZvUmA
	72Q23BVs2alwH4rajTmHUd6uon1C8XaVPszIZhyehnuEiXJ4qBrYAw1Jz6VhJLC/
	lrb3nW0mT3hqLjvb+LPRm6Gvv5d2EwbC39g==
X-ME-Sender: <xms:kPE4aAD4giurhdjXyD1uR9I7fpWrWcc8ifRl80NM5qhcOFYNhIBogw>
    <xme:kPE4aCi0iRkCpTJs-iAPDnyBq2s2REn5ibX7UeCnsD1cQaJdtk-oWpj4DQZqeugQM
    1-YsVO6n093FBLQlw>
X-ME-Received: <xmr:kPE4aDn9vVPMm5O6oACtnJqeFx1oB57dpslOGhsmxQsF0xB8KXsNouzCgoxLUs9NHXDGFcYY83wo6Fb5D54jytgR2REv1rTzbAcyt8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvjeegkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehprghtrhhikhesphhsphgufhhkihhtrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrphgvnhifrghrrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kPE4aGxz1XxZ_BSOMMztjReVyzNOtagFuAa4apQx0Vpm340KJRucQw>
    <xmx:kPE4aFTxaDj1VRNHC1RzNV3TWcPUbeJFWQL-HFeST8tfQ4icsLq8Bg>
    <xmx:kPE4aBbV1h8V5LPFBd9QHbw8sfHCYVHG9aCcUQMR5-ZBOIf7MRhOCA>
    <xmx:kPE4aOQP0IibkveR7BCIqdyP9lgmEc_5dd9qhUYPwbAdvA6O73pWug>
    <xmx:kfE4aOjd5HUT38ac4QhmK3EIZ5fvyoEP_tH1FHWIrZblv2bn-Ww4qIPQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 19:45:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrik Weiskircher <patrik@pspdfkit.com>
Cc: git@vger.kernel.org,  apenwarr@gmail.com
Subject: Re: [PATCH 1/2] contrib/subtree: Add -S/--gpg-sign option
In-Reply-To: <20250528130116.21534-2-patrik@pspdfkit.com> (Patrik
	Weiskircher's message of "Wed, 28 May 2025 09:01:15 -0400")
References: <20250528130116.21534-1-patrik@pspdfkit.com>
	<20250528130116.21534-2-patrik@pspdfkit.com>
Date: Thu, 29 May 2025 16:45:19 -0700
Message-ID: <xmqqbjrbhtgw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrik Weiskircher <patrik@pspdfkit.com> writes:

> +# Usage: gpg_sign_opt
> +# Returns the GPG signing option for git commit-tree
> +gpg_sign_opt () {
> +	if test "${arg_gpg_sign+set}" = "set"
> +	then
> +		if test -n "$arg_gpg_sign"
> +		then
> +			printf " -S%s" "$arg_gpg_sign"
> +		else
> +			printf " -S"
> +		fi
> +	fi
> +}

I wonder if this misbehaves if the user has arg_gpg_sign defined in
their environment.  I guess that this contrib script is written
loosely in that regard, as none of the other arg_* variables are
cleared upon script start-up, so let's let it pass.

Also, why is this a separate function that needs to be used via
$(command substitution)?  Wouldn't it be more natural to have
something like

	if test "${arg_gpg_sign+set}" = set
	then
		arg_gpg_sign=-S$arg_gpg_sign
	else
		arg_gpg_sign=
	fi

after the option parsing loop and have the caller just interpolate
it as $arg_gpg_sign (without surrounding double quotes)?

Or you can define arg_gpg_sign to be

 * unset, if the user did not give any -S option
 * -S<string>, if the user gave <string> as its value
 * -S, if the user only gave -S without value

directly inside the option parsing loop, so there is no such
clean-up needed, perhaps?

Near the start of "main" function, there is an early pre-parse loop
that iterates over all the arguments and is aware of which option
takes its own value, i.e.

		case "$opt" in
			--annotate|-b|-P|-m|--onto)
				shift
				;;
			--rejoin)
				arg_split_rejoin=1
				;;

If you are adding "-S" as taking its own value separately, don't you
need to add it to that part of the code, next to -b, -P, and their
friends?

>  die_incompatible_opt () {
>  	assert test "$#" = 2
> @@ -240,6 +255,15 @@ main () {
>  			test -n "$allow_addmerge" || die_incompatible_opt "$opt" "$arg_command"
>  			arg_addmerge_squash=
>  			;;
> +		-S)
> +			if test $# -gt 0 && test "${1#-}" = "$1"
> +			then
> +				arg_gpg_sign="$1"
> +				shift
> +			else
> +				arg_gpg_sign=""
> +			fi
> +			;;

The comparison between "${1#-}" and "$1" is "does the next argument
start with a dash?", iow, you attempt to parse this

	git subtree -S -P prefix add HEAD

as "-S" with empty arg_gpg_sign, instead of slurping "-P" as its
argument.  Which is nice, but is that enough to parse this

	git subtree -S add HEAD

correctly?

> +'git subtree' [<options>] -P <prefix> [-S[<keyid>]] add <local-commit>
> +'git subtree' [<options>] -P <prefix> [-S[<keyid>]] add <repository> <remote-ref>
> +'git subtree' [<options>] -P <prefix> [-S[<keyid>]] merge <local-commit> [<repository>]
> +'git subtree' [<options>] -P <prefix> [-S[<keyid>]] split [<local-commit>]

These synopsis elements suggest that <keyid> should be given in the
"stuck" form as the value for the "-S" option, and if that were the
case, your option parser would look more like


		-S*)
			arg_gpg_sign=${opt#-S}
			;;

which is much simpler and more robust.  If you go that route, you
would probably want to retrofit -P and other options to also allow
their value in the "stuck" form as well as their traditional
"separate" form, which would also be annoying, so I do not know if
it is worth it.

Or just use "arg_gpg_sign=$opt" here, if you are following an
earlier suggestion to get rid of the gpg_sign_opt helper function
that does not seem to be doing anything useful.  And then ...

> @@ -537,7 +561,7 @@ copy_commit () {
>  			printf "%s" "$arg_split_annotate"
>  			cat
>  		) |
> -		git commit-tree "$2" $3  # reads the rest of stdin
> +		git commit-tree "$2" $(gpg_sign_opt) $3  # reads the rest of stdin

... here, you'd just say

		git commit-tree "$2" $gpg_sign_opt $3  # reads the rest of stdin

instead.  If your <key-id> has $IFS whitespace, this will break, but
your gpg_sign_out function does not help with that issue anyway
(you'd need to rewrite this and other callers to use eval if you
really wanted to treat $IFS whitespace in values properly, but
looking at the existing code in this script, I do not see any
careful string handling to do so, so it may be more appropriate and
punt, saying "no, key IDs with whitespaces in them are not
supported").

