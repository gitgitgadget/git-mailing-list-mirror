Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449D2C9D
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769644937; cv=none; b=FNmJ/ZW/V7FGjy2NAc95Cdob/XPDXsz5NSkztxP+vZra3S3rLRUSVvz/fqf3GQPdkYgf0Aq8tUhiuEWH7JppTzSR91uiuld07ze25SqLIaw9QXyK9ugmRRqWkTqHy6TR1ifDw8JFO8pNiJqvf1C80cYLkw1wLHCpCu6/J68omSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769644937; c=relaxed/simple;
	bh=aIz3M78/VAQwXxFgbskmTG2DiWGK887nlfmvychAn+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HxJlN7BqgYZSF0k1F8RzyeMOJgdtBfYRrtmZ8NthHjhK/2/HRigpgBEVoXNugi1rSDzjcfeUY8IB9JABk0tcj7RfrKr89S9CcvxxfpR8a5xVhVMw7dsqjCfo2ivFa1dggP3be4ADu8G7ZPz558LjKSpV/4oRACusnDSJb9aC+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sWh1P6Pt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KlkhNr6W; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sWh1P6Pt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlkhNr6W"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F9B6EC00C3;
	Wed, 28 Jan 2026 19:02:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 28 Jan 2026 19:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769644935; x=1769731335; bh=TSl520WgH9
	pMV9KCjurCGJYhhE2VTUzmK+Qav1HmWXA=; b=sWh1P6PtLJedb+Uvyufvi7pAx0
	J44dzblbKXRzYzxldhS9NtttZjTWr9v3uJCrCMnzE5rfghQWXbykPcaOkTeSbgna
	cfm9aC6qi7pMCaU87F7Os/KwMCbf7CcUqSgrMe8r+OxU4UptVAIyBpy7goTQXLrK
	cqciYgg/6qdJCoGGoz4nlMi3Y3xgwS0hYDI19Le0kSaGqKefoYNunsAl0j2BLXMr
	cA5BbQ3ki440DbziotqD1IvdHRs7+NadPAkj3DM7wEDxCC/3t7WsBAAccoUcYHly
	fuI//s1IwDGcNS0cFl0Y0R/8CJjb6oclK+mROpa1SWRhsISb1zamu4niWPOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769644935; x=1769731335; bh=TSl520WgH9pMV9KCjurCGJYhhE2VTUzmK+Q
	av1HmWXA=; b=KlkhNr6WJvefKFvMEeEoaiX1+l/J9uWhb1OWw/wgY7Y1vwgPRMe
	GX4QQPkEs8Xu3TUCcvQj6qZ0wTgkCcPoqECsXgxv3tlvFeraHjPhSeA41G64wz7l
	gKUFKotfF24ObuMjj3lp8F05xnxPAk2nhKDh1WtRvwxHLAbB9uy8bpKhtmzNh1h8
	c24vDCuCAG4fiPbhnqPOnghQFu/baji/XEMRIlff/u28YCZZ+m0KYXYSlTFn9xY9
	q/5P2WmSeM5D0v6O2g9mM+Q86ahPIW6DhUiwJGJvy2I11MKLUY+zFQTMVXsNZetY
	poklp/rIlKqCwoSxOOb0+skfBhZv9HEO9Tw==
X-ME-Sender: <xms:h6N6abRI--3ZECy_xANSOkAsGgj1MVMcIyuwXrMq0gauWhy2yPPR9Q>
    <xme:h6N6aTxtbpjnBpHycjAX0hu8JjNcBshMoet855feSp_l9z87f04Sar_KYRiN_bF1c
    sJVmsqGVlOQj8uDaOhahTsiZzlLeZ0NhwNY2m366Gt71NOJ0y98oQ>
X-ME-Received: <xmr:h6N6aV14Ykb9-b_Z4UsFEVW2k3EtaZBtFU0m2YVbh4oMog4UCZKDsPkG8MoziBjVVUB8705WRAM0wMgi6RZW9KCeDpM_-_kIdP1ajO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhthhhusggptghhrhhishgpihguvghmrgesphhrohhtohhnrdhmvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:h6N6aZ7b7OR04Vb-FoKdKrax-4RMhaKLO2pleEymfomgTSc29dvDKw>
    <xmx:h6N6aQWsEm2zdz-r8_YIAUFSN1929M_tGh6LdWhh2jyDhTSovcoGaQ>
    <xmx:h6N6aQAKsnAOCorA5qhID2DyBHB4pSrn6im-b6y4v7ClUgPrdzJubw>
    <xmx:h6N6aX5VtbCLpXslxpxUPg5PfP0_Ohs-tIf1WlWdp-yyu7A_FTLhQw>
    <xmx:h6N6ac2i_J9lG62UNcLnRTkN3iP5vzuHTuUVx8068jlgbVPJLMe02ldK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 19:02:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Chris Idema via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Idema <github_chris_idema@proton.me>
Subject: Re: [PATCH/RFC v3] diff.tcl: made alignment of tabs in git-gui diff
 consistent with gitk
In-Reply-To: <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com>
	(Chris Idema via GitGitGadget's message of "Wed, 28 Jan 2026 10:20:39
	+0000")
References: <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
	<pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com>
Date: Wed, 28 Jan 2026 16:02:13 -0800
Message-ID: <xmqqzf5xcmm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Chris Idema via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chris Idema <github_chris_idema@proton.me>
>
> Tab stop width was not properly rendered in TK regardless of
> tab width setting. The + or minus character at start of line made
> tabs align incorrectly.

If git-gui has a feature to show file contents, not comparison of
the old and the new versions of a file as a diff, there won't be
plus or minus at the beginning.  The above paragraph of course is
mostly OK, but it would be more helpful to qualify it by talking
about "diff" somewhere.

    Because the diff view spends the leftmost column for plus sign
    for added line, minus sign for removed line, etc., a tab that
    would push the next character to multiple of 8 (or gui.tabsize)
    column may appear narrower by 1 column.

    Compensate for this by setting tabstops at 9th, 17th, 25th,
    ... columns (or 1+multiple of gui.tabsize) for showing a single
    parent diff, and shift by 2 columns for showing a two parent
    diff.

or something.

I noticed that gitk has code to deal with octopus merges (i.e., a
merge does not necessarily have two parents, but it is possible to
have more parents), but git-gui assumes that merges with two parents
are the only ones that are worth caring about.  Correcting for this
may be almost trivial, but I do not think it falls into the scope of
this topic.  But at least I think this topic should adjust existing
"apply_tab_size 1" used for two-parent merge combined diff to use 2.

>  git-gui/lib/diff.tcl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
> index 442737ba4f..7da6e5ccae 100644
> --- a/git-gui/lib/diff.tcl
> +++ b/git-gui/lib/diff.tcl
> @@ -495,6 +495,7 @@ proc read_diff {fd conflict_size cont_info} {
>  			}
>  		}
>  		set mark [$ui_diff index "end - 1 line linestart"]
> +		apply_tab_size 1
>  		$ui_diff insert end $line $tags
>  		if {[string index $line end] eq "\r"} {
>  			$ui_diff tag add d_cr {end - 2c}
>
> base-commit: 1faf5b085a171f9ba9a6d7a446e0de16acccb1dc
