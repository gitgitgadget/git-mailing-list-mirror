Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2904FC350
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779041; cv=none; b=VfMpUccBG+9SWLCHC7LdNHh31ZZm0nWjBTAq2hqGPPyHXXMQV5jZe9F8BaDesO6tcgTLTF4705mElu/7YV5brsiBBSplTmdSrUuNZgsv35Ev6dpJrkuIjlZcjp0Dm9S9t0ghZbdfkrBLFGYueHvPQx9dwyYoEk0HQ3nj2nkNaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779041; c=relaxed/simple;
	bh=RomiXGkMA3zrB0RWzi5GcIaEP6wja6LregZCKQPneyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bxrwbKBYNtl0tvX8Ruwn0oUaOseIaAfNRawjoH6e4hY+EBMuSXPw8/QEuqhN2jF58c7/VSItWfJSDQtRpMoBJOJffGC3eNtNo/VhD3GS5DxiyLwnHNpHypTd7EcXzhr+4b4tZphNFonMYQboOI8sLAbYLOQJoGFSXYDRepoL5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lhe35FLU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TJew8Da6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lhe35FLU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJew8Da6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 80393EC02AA;
	Wed, 30 Sep 2026 10:37:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 30 Sep 2026 10:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790779035; x=1790865435; bh=tN6nw3bUAC
	WW18sr3UcWcm4TrRm7BZhGyy3GX+c+0TQ=; b=lhe35FLUQGHFvxFLeKfmGOacP/
	3AcUZrXPhL67OaWcVpOfyKQBfE2+y7aMdCvBy+NojvHU2nkftJit1dwVUVl2SrRi
	iWt0hFmjUCM2UcEeuCwk2VCNBPPx/Hi1gr+2CNXYl5eqoPEUFuhWPc0SHejGN/Qm
	Dz/QqHOiS7xB0yycFAsE9hsuR1WPkH4PLi8oKxH9as4KOI3LEOpx7TaWnhPbVYiN
	0/e6gHCCmb8Hu25CqW/ipEiGymd/l5KndzjQG+Bl6smKTHkePHFL+x/YdsN0rBm9
	v0Sk9f5+BzhY5jdJkcbCNTZZUtU2cI1WjNufh4zVWdyxt6DyQmuAb/NJjaJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790779035; x=1790865435; bh=tN6nw3bUACWW18sr3UcWcm4TrRm7BZhGyy3
	GX+c+0TQ=; b=TJew8Da6NgHELyHOl1sMczp+6NrIFzii0I2vPOLmuHCcWmsj4Xn
	j8JWvia+P1n9R16Y0T3oJ+9Dbv4gWfwM4rQy1J1CcAbav2SPJ+yVAM5IQ1w/3mGs
	JGSYKJKF3n/RsN+e9PXnyQLv+7IUIQgFxkEzkmtYSl2Nysu+oT2DTXQ2EnOARof8
	qvMRbdPpSU0b9uTWdV4n4oks/XynjqmZhXYTWmSvlxpfjkZ7sttf+v3/+uRHKpYt
	XG2xKh111iTZLUexvAM42gum/xwGDtmReeSFv6OlDgJTq17Sf6IEX7BdC9A0cfbQ
	FRpjlZdZxKR/9rbEEGmTwe6ZkmGd1UZv5Bw==
X-ME-Sender: <xms:mx69aiII6HTz_IPYYbm2KP8PA0GZ2dzkrixRT-NAZlD5LZ2rKoO6qQ>
    <xme:mx69at1D4zB4vRrGQUIL5ANllD4k-dmvCVO3INMdMOK7Fxag5AZbZcn0FPXTzGJtN
    FV2t1Hm71XynZD2dhPzXCssDNnhlkcJr_4VcGy0hiEj7G4Cxvv8JQ>
X-ME-Received: <xmr:mx69asjNO34Fkz05FSeZf1_xvRDvTd2qE3wqiXqBQUQm5XanDbUDpW_mCgsf1pE-ydmZuFfN4FhAaIrdj5TXDwAVgzDWdv-tLcJX>
X-ME-Proxy-Cause: dmFkZTEw6RUjQ7nx+Ae5QoTdCTMm4c7jmJvljcKQ3QqVEVxhOlD0q0mosUm0qP1tFsAMEw
    0NSArSW6lEQF661cXYbk9wWPVaHoFCCDigjLeOeWMMJ13Lbr0TJ9p/CFddec91Gw+AMuaX
    7P0H+dZt/F5uykJcllqCs2fprJGJxgXnrtvH/9rSc64Y90P5YhDhUFrhwgGh7dOqtRXjlO
    SmOQ0EfCmKeiGXgQNQTz/iNqcdypLfp2S45AZ3dwqpe9xSUVLzGaWzRe7wN/sMYQe9oVLO
    5qdPbARvWYhxtur42f40On/q1+HIJ8JKL+6LMB09rTQjEOWPiGPxObN8Cv+zDWtGKwM9JU
    +ao2MXPAA7zrRGwNo8+39gRwU2Bi0crhUHAy4gC810vTaY3NsxRkjledjZmJCJz9gD9FWv
    9JUXEwGQfF7RCLT+TNLk2OBbrVb8DNkgPWBw6+J+mryEVt5DkNWuKnPPIebz8L/ss2wOk3
    Q2FSKUx5Ihv60mqyoV2PozMxvvSjNwYOEePV2e2sIHZB6Az7aPT9a0mnCj69awEjwWWta4
    BMtb7Q5a+/Y+//+W2Gg/Xzm4wDTgeYlu8UQb5S0hHdVlpCSF38w/a3I5wbqo7Ugd4azrTY
    nU+9dcZeJxiJKbaTMP6LshTFq/LuS464LuVyWmd36ARhrZlFbqWueYzsmkyg
X-ME-Proxy: <xmx:mx69auW9pYK5-Z0GGtrVe06ilCa1tE0xb8Fsnjjy7wQsSi1gW_hDlA>
    <xmx:mx69arVnv5ROOeUYmHhfmnuoSgL86PBI-R_PAfNHGJfuYlro-z9S_w>
    <xmx:mx69aujkt2xPp_aRSzbcyfrWLkYes51l48ddbBCd7sjluqu6eGnmmg>
    <xmx:mx69amZd3cVCK9E20EKYG8b-3RcrCrkdY3YMCpYynaMIUOO2zB_uJw>
    <xmx:mx69ahvgHmmZ_WQh5bz4vOZ4_CiAh2-Y-3c5bFXUIQbv0Oqvaeq7F4hF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 10:37:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 0/2] ci: link failure and leak annotations to the
 test script
In-Reply-To: <pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 30 Sep 2026 06:09:41
	+0000")
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
Date: Wed, 30 Sep 2026 07:37:13 -0700
Message-ID: <xmqqpkxudcva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Link failure and leak annotations in CI to the test script, so both can be
> found from the job summary.
>
> V3 CI Job where failures and leaks are reported:
> https://github.com/git/git/actions/runs/36537917146/job/109306215909?pr=2426
>
> Changes in v3:
>
>  * Fixed bug in the --immediate exit ordering: the --immediate &&
>    --invert-exit-code path called exit 0 before the test's annotation was
>    written, now a single unconditional call covers both exit paths.
>  * github_escape_message_ no longer relies on \r being a portable sed escape
>    sequence (not POSIX-guaranteed and BSD sed implementations can differ),
>    it splices in the literal carriage-return byte via printf instead.
>  * Reverted unrelated test-tool line back to its original form.

With these updates, the patches look good to me.  Unless others
spot problems I failed to see, let me mark the topic for 'next'.

Thanks.
