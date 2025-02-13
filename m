Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC32054F2
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 04:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420781; cv=none; b=M5mJGVQyE3XO4jWX30pvEIQ/Ph+1wPA63Nsr5UIR0EoqLL0aN4CI2z8j6pln8jgQzCGkmj3UHSvPJkbq5Zq67sBWHs6yADhKC43s8aYSCK5Yzw1gzV3hKMAalxnCny18riPUra/iPpEgqIZDfUK3/cDI9nFm1pog4nYUPdbbVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420781; c=relaxed/simple;
	bh=J9aLTrxQt72SuDb8QUJEpg5viGhGHtv8xjhwep3SlSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rMsB9LBfG9VP5iELKMsmAWdM2uNW2wp6EpXm6M5tRhGO5moFPm1fkFmuJjmaKg1x54T1I7zRmbJLIoQNtr5hNq9J7fRZKSirWl0x8j6X8bGi86aTw7+WkOAPfOn4d1rnJIx9e8u3dvcEJJKxpvUS52wIB4qiIxoLom5GuA13iVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UrZxC0eu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psrlUzz6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UrZxC0eu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psrlUzz6"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F17C2540110;
	Wed, 12 Feb 2025 23:26:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 12 Feb 2025 23:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739420777; x=1739507177; bh=RHakjsJKmf
	8JV+DFgz1p6oReMfy+djiaNZ3dKWQsU+A=; b=UrZxC0euQ7tuKYRwT5tVXjI8KZ
	WY5erdh7OA2ub7Uw3roGVJoG/odhM2LFEeag8BvzHG46GEbzE8EtAChFq9+97cf5
	nEqTI9BJGXS8uWSqYBJ0wVgas6FI9FQtNG6Wf1KvhZjoszJgThKSGBtK7VS7pHDH
	Pnof/jzCufGByuSz3TrpeIlSHtyC18MeC8Ob4UO9xE/TuAK1Otg93/UR4GJrNN7C
	AIyFIC5R0CwOjOjscUfIzUls+4L42fPZiAIp22N2CicNesxMBVL3tYHOVET/VpJi
	UWDm0HlJvyC1WABjiobJGYvCg2EZ3NhdPQwOWPJTfHh2N7Ssm5bp94HhQrdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739420777; x=1739507177; bh=RHakjsJKmf8JV+DFgz1p6oReMfy+djiaNZ3
	dKWQsU+A=; b=psrlUzz6BiqjqNytCh3oWbyPk6MN06MsSrFX7WIVsw/gVbt1NRE
	RWyCgYmwebfPHkNcOCoyFAgFR8DHULeLoc0ZMeh9zNI239S4y9Quf3K0UajxAi8w
	dVV5mIGkSHQlskXeIwg7IO0GgaWU5MDXy/NJRKkamfJuSFe7hdmMC0TN32zVUzE3
	OVOYjQH9lSrFnYczNr+CaGbnZucSYAK32iXNWQXZaWxn8dRCt/OcKzTNP4OAenYq
	SypbffOE0joKY0JIuHD7yi9uoJzi7vpUkZv5EFSRhMa/yhAuUM50WXAlFyeC82mg
	tpDvy1PJqDnH0ZPZOS0dlU8xZHCxLyvS2hw==
X-ME-Sender: <xms:aXStZ7L7gR2Kg6Ikc8_fwjOZVdPs6hJYFecy4NRQHYpt8x2js_qMlA>
    <xme:aXStZ_IyiARPojyF3AQr4qB8ek6KvxAIqEaDzE8vzzxDrOME11u-kj8hEW-l6I9W-
    WIPb533zmajEhRtjg>
X-ME-Received: <xmr:aXStZzt1OxYB6uIvpoRyQZBJIx5yAprYOhEXWkFE7qSX5pIwaFRct-8fnHsZXHMM07ha8mYevsJ4qjl486tQ1A7BCCcxuMbZlmhgmVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegheekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepihhllhhirgdrsghosgihrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aXStZ0ZY62O5v2KjcTdj_5IqruW3yq3d1MKt_e9rMDbN8Unb9uroKA>
    <xmx:aXStZyY-T03DJhRoVBDKipYQN_uNppVDNjsXz8MZ7xlEdFTNE2DXqg>
    <xmx:aXStZ4A2gtwsCtBNML7ytjOWFf1FY28t0yyKwFe5x7wTMWx4URjWXw>
    <xmx:aXStZwbGBZHqw1SM93iw7-q0Ihd-vl2XXo8tBsPLwRZOoeq8AaeIZQ>
    <xmx:aXStZyHsypKBcuwxTvgb_lYvmlpiEmdCrXeJKXL22UcH9ATODLUl9NlM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 23:26:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 03/10] diff: short help: Correct -S description
In-Reply-To: <20250212032657.1807939-4-illia.bobyr@gmail.com> (Illia Bobyr's
	message of "Tue, 11 Feb 2025 19:26:47 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-4-illia.bobyr@gmail.com>
Date: Wed, 12 Feb 2025 20:26:16 -0800
Message-ID: <xmqqzfiqpj13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> `-S` shows changes that modify the number of occurrences of the
> specified string, rather than only those that either completely remove
> it or add it for the first time.
> ---

[jc: title, sign-off, and this should be done outside the main topic
are shared with other patches, so I won't repeat them]

>  diff.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.h b/diff.h
> index 0a566f..49ece3 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -606,7 +606,7 @@ void diffcore_fix_diff_index(void);
>  "                try unchanged files as candidate for copy detection.\n" \
>  "  -l<n>         limit rename attempts up to <n> paths.\n" \
>  "  -O<file>      reorder diffs according to the <file>.\n" \
> -"  -S<string>    find filepair whose only one side contains the string.\n" \
> +"  -S<string>    find filepair who differ in the number of occurrences of string.\n" \

Given that the initial motivation of -S<block-of-text> was to find
"before it wasn't there in that shape, now there it is" [*1*] (and
<block-of-text> wasn meant to be something unique in the codebase),
the original conveys the intent better, but the updated text
describes the actual behaviour more correctly (in other words, the
behaviour of the option when a not-so-unique string that may produce
multiple hits is given is whatever it happens to do---which is "see
the number of occurrences are different").

So this is a good change.


[Foornote]

 *1* The original motivation of "-S<block-of-text>" was to be a
     building block for the tool Linus dreamed in his message
     https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org
     that explained why recording renames at the commit time is a
     bad idea.


>  "  --pickaxe-all\n" \
>  "                show all files diff when -S is used and hit is found.\n" \
>  "  -a  --text    treat all files as text.\n"
