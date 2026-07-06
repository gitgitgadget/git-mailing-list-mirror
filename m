Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740D30D401
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349054; cv=none; b=r1yIYZ2wCyQRM2jkfJaQKNWMrCLIm5rUYxzmJEhKgTngYPG1XhoTHwNHRZ2f3SYnXKkpwbpuzSItMBJza0htPEfqZ5nWTi4epRPJQwyz/dYm79HoxUVrI/sAA+u1/031Y3Gt1ICMdPaH1G/FbpUVUiWPvoSzQ4sfdr4qSdvjZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349054; c=relaxed/simple;
	bh=/Iy5SNGsMDqFr3tPXawgEXFns9sKpoNuzpJXBBVB460=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cr0z9c9Cr/9vXNQ5318wjRi68fTnpBpJCzkiJ5khGsGYXH1n7QQOrPF3pdlsJoX3Ybs0cP66MKCZvgdM7ItRXJs0yBXOa4eH4qS9x3hUifF2fkCHh2zLvRA/ckN5WUBcbX3OvVFq8V5ZgJnOtU+hjujd/9d0Fc18xjfUZ8n4kUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q1auEIrq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QLNoAWNI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q1auEIrq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QLNoAWNI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E4B01D000F5;
	Mon,  6 Jul 2026 10:44:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 06 Jul 2026 10:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783349052; x=1783435452; bh=osOw4IKwu5
	21jxddBcGwXhzkXVNk08BodomzWVHVcug=; b=Q1auEIrqgh3LSQVP3baIkPpRJq
	yN7alAYSoRhO6GpHScp1jMifgywWgVL3V3RiPbpzREGPGwIun6fIZi8rV4K0rF61
	hUWvCDkA8eztfvJeGoCDz5S28Hur1SoL6TgLHH6keZeN5h6LOXMEhDyfvzPYkmFw
	+oREBDBCLeUTR+ZOn8eUXbskJd34RYDpFQjX5c0F85CRBWzaKBjaPnx0lSjj8pzI
	xLqkKDoa3ScU9mq9uSlTKPeBc1ZeuoYCCufIiMSsjpt5jpMv9q4QSwNZz37CpSIL
	laudDD0VM4zQB68RUmqdGnm+Nnh2IFAkAdJ87NDGKtsWM1n3Bpc6Hkelbmnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783349052; x=1783435452; bh=osOw4IKwu521jxddBcGwXhzkXVNk08Bodom
	zWVHVcug=; b=QLNoAWNIeK4WDsfzLTBf6xQ7Urx9a52wK5b8/7LHAs4OH1v78FQ
	98l4i67jLMiA5BwYUAbs52WcS64fR6sxJ4k4PXREc3d3/Y41eT8+KeZ6mihQQqLT
	uOpqTqr1w2veee84ZymFJ3rLzhiIhWWEPPyeueKYPDWN58WHvgPJFpPgcFnIMoIH
	4s6wGpgdd3puONEnE5roYRJUdE39NQVNNmh+TPED+7vcxLGgM8zHdXrtkRD+OGfB
	Yk+uncmnUXa0vtJgKe/4kiiPQbhP1QqjQhdcBOOQ5BdgjtNGQEakZStyJ43IBYtV
	HJS3Nlhk/kbOWK4ztWBCrUczp54oYmPoF6w==
X-ME-Sender: <xms:O79LauY32FrsAxa8A-OtJMXOH9RBc5eFxyPA5M1AQXpslbuTP1w8Gg>
    <xme:O79LaqXKTPAR9UWAONSqbBz4cgXkLLDBaKPfhhVPla3fMJmqEwbI_Yq2wLq3vm6gc
    CWXmoHMW0JzcUNCrfybXqOqYqbhPmLLQzVDB5iSuRqeE85fPuKKmg>
X-ME-Received: <xmr:O79LakjOF4vNuT5XAVbAV2l1iy7bTIkHQS1btaCLL9e8OJGckx8kbqXr42H0xZ62dTLFE96Tyx6XG0EwPFhOFeQMmRWi-Xy7AFUB4EQ>
X-ME-Proxy-Cause: dmFkZTFKRh2L3yjgFcR0GjJj427I7icCL9HBxHfGipiFpfTPsa510ljUIdkC7mmwqCO6yZ
    ysYcneoZA3k4am1aj3NWePKLxP+Og8qLo/BBw5lItNEFWfqZ07jyilE6GvBeWDwhp0s1vV
    Cpf9pY2pY8T/k3UCtoAwW+lZBie3D6/ZGEy87uPLrQEAhhncuo1oe6XO5Y271mfrym+E6l
    t0EmfzeUS1dK9TcCWKpV8bOMlEtu380u64k7aNTWhvvzJ1JgNLjrYiKs6FddlzvzIcxEzP
    YRosa+7aHpazfDL8CFgQJ4wSsnKMgjAaAB4uqi/kdBRM/st0ADBNmEaYv2OFuscNNluOAW
    HeziOa0npC9Iw39crmk+StuLD3knF0YDMmsigQYU6KnqafX+IkV50hKRWNjHQ8wZldaYVq
    RwYgmOPO2N0X6p1gvSvB/pwbMtg+Fmbe/CTpaDK1RQAdYIw7yiQ1kDnEYR92WesoUMqv7r
    k/5LUOtVuzATWTgIk69KgG+yP4JhLOzwXozJD8aFt7yfsvgQCG35PIrUYKJhvvkH4MJVYU
    MH5TYWMW5MCUgqfN9VTZJtf2mzQxSNJkZ73VeBhajY0k0+cfqiitWCSAKvDIwZI20OfGar
    RKEiyoJEEmVaTfRl+nkUgEbYn1e5SsNsKhjXK23DD/rA4X/gOzrJxRtDnpJw
X-ME-Proxy: <xmx:O79LagvGSC5nnnInMCvavLoHmdvZJ4DXDBtvcA4q6FFRPdxsB1SxMQ>
    <xmx:O79Lal6P0Xs9KMNJiqQrz2gvJo56iMeh63gP94MQSkFP5HBnagjfjg>
    <xmx:O79LasPunZHbuvtUFdbcS3WobRiLWMf3wvGWgL7uLh1Lr7Thje1oAw>
    <xmx:O79Lajuq-4A5xdDV1DjzpXciiC-36GaB5en0qgeXO_CZ7YHiK2emsQ>
    <xmx:PL9Lal0g5d87TbVFjDBA_P6YdmYATYiZYPPhlDO_Uts-kxXnRaV_6wPH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 10:44:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: git@vger.kernel.org,  Colin Stagner <ask+git@howdoi.land>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite
In-Reply-To: <20260706115816.20267-2-ijackson@chiark.greenend.org.uk> (Ian
	Jackson's message of "Mon, 6 Jul 2026 12:58:15 +0100")
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
Date: Mon, 06 Jul 2026 07:44:10 -0700
Message-ID: <xmqqy0fob2kl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

> +# Usage: reject_if_v2_config REV
> +#
> +# Bails if we find .git-subtree/config.  This file is used by the RIIR
> +# git-subtree, which can read data from this script, but which generates
> +# data that this script cannot cope with.  So if we find that the user's
> +# project has already been processed with the new tool, we stop, to
> +# avoid generating broken output.
> +reject_if_v2_config () {
> +	local config=.git-subtree/config
> +	if git rev-parse --verify -q "$rev:$config"; then
> +		die "fatal: tree contains $config: has been processed with new standalone (Rust) git-subtree; use that tool instead of this one.  See https://codeberg.org/diziet/git-subtree https://crates.io/crates/git-subtree"
> +	fi
> +}

[warning: I have no idea what is going on in the code we see here,
as I do not use subtree script at all]

The above helper may work for one caller that passes "$rev" but not
for the other caller that passes "HEAD", no?


	if git rev-parse --verify -q "$1:$config"
	then
		die "fatal: tree contains $config: has been processed with new standalone (Rust) git-subtree; use that tool instead of this one.  See https://codeberg.org/diziet/git-subtree https://crates.io/crates/git-subtree"
	fi

Overly long output does not look very easy to read, but I kept it
the same as the original.

> @@ -846,6 +860,7 @@ process_split_commit () {
>  #    Or: cmd_add REPOSITORY REF
>  cmd_add () {
>  
> +	reject_if_v2_config HEAD
>  	ensure_clean

If (global) $rev is not set here, we'd check :.git-subtree/config in
the index in order to detect the v2's configuration.  It seems to me
that this code however wants to inspect HEAD's tree.

> @@ -934,6 +949,8 @@ cmd_split () {
>  		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
>  	fi
>  
> +	reject_if_v2_config "$rev"

This would happen to work, as the global "$rev" visible here is the
same one as what the new helper function sees and uses.

>  	# Now validate prefix against the commit, not the working tree
>  	if ! git cat-file -e "$rev:$dir" 2>/dev/null
>  	then
> @@ -1034,6 +1051,7 @@ cmd_merge () {
>  	then
>  		repository="$2"
>  	fi
> +	reject_if_v2_config HEAD
>  	ensure_clean

The same comment as the one for cmd_add's usage.

>  	if test -n "$arg_addmerge_squash"
