Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D783F4103
	for <git@vger.kernel.org>; Wed, 13 May 2026 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679991; cv=none; b=rfnw7DS5rTfLwKo574GnHz1W2ZUnkzfgqLIfiLN1I1Z4yujFwGICjsLERj9dvkUs1Jn4OKoKGwojtIzvreXsN6kHufuC7RYUWjteFUqQMimSZjCwaengaWS4RuLLXLoxk2fXOmwHps1vkzPNHB9M1LNyIoCU5BfnyX7xvtHF3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679991; c=relaxed/simple;
	bh=p3K9nMdhE5u4x/RIXuozr+EiiucdHt0XbRnkG0/acd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PVurI9O5O4NExASIShlzWivTcJCLcGFYUbgeQNhtzUnNYauTr/frsd5+31IRg+26rcSoB6W3sBOW4S/qyHwGvNh/WTEn4ZTGIwfJBdoVpKUHhCsVN/8uAehoqdXdz69mL4oYDi3DTj3GYfzq3ZDJ6WD8Unxjdw5hB9CB4/bZZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q0rmEfKH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=skMjr6E2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q0rmEfKH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="skMjr6E2"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 08C6EEC01BE;
	Wed, 13 May 2026 09:46:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 13 May 2026 09:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778679989; x=1778766389; bh=DTTMCaImsC
	tc6ez/sMi4i+yv1o5UucAQ+B6RgYE84uo=; b=Q0rmEfKHWvQegMSrgkriUxGTWf
	YFPGZJWMitk6WikMCMjFrOjW7nC6V52gCna1fu/EbTdhzJRmOzKUVddApxjuGfNW
	Guv+iagVQgEWXun5x+4D479B5GpB0VoQ1D9n6EL2v1El4djohh4jsEo7wVZHUGP2
	B3Vb6CiZJBxD8QZODdL7tMkMO7OCncSy+vBO/3O9b0zelXw2n+8dI27/AM7SaZIH
	lc9cpiX/yJ+b3jerjO8N3by43Lk/HEhEdHEYcyc4fKTUjBOkEhTktw2vIi21YzZ2
	H+bUyfe1WMlPrJZX7Suj43EpF+obuOoKE+hKuG1vjb5TA+alQ41V4pTLKOzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778679989; x=1778766389; bh=DTTMCaImsCtc6ez/sMi4i+yv1o5UucAQ+B6
	RgYE84uo=; b=skMjr6E2xmtHkXMpKUjpbUdj1yyphppPa+N/LnltvZ3lVFrjNx+
	8VPPG7o3id3knl1FSDKr4RRq71xToI7Y4JCMhRJ7cRyt3kzt7g2yeuCd8Ql4oJNy
	ODQJscVME2ZuxEXFjsR4LVDUduCh7FI0FmtE6trOK6kwzUlfu5XaJPo7fBLbgQIn
	5eDGQEK2znmbzfHf7u88YCUbssglc15KKBOUWtZrsr+P771cQCM10TevU96jokRA
	buevgSTBRCLPUT5nvxcORX2cUlsmE/OzcBgw+N+M+oPDcI8ZwIqCQZwoRZeMMo7f
	/4u9RmDL9QXyeetKslob9Ngs2AF8Z/uSjPg==
X-ME-Sender: <xms:tIAEan91qJbg3H2YuDwrkb9Y6M7OrnkIRo_30ulGS04cdn41b1ksFg>
    <xme:tIAEanZiz-k5_S3RJXLzfIsnJUKi5LPW_c-6bhkuwSq8if4RJfNl-JIgUIm2fzV2T
    WN0IsezWUo2czxh0kkQTEZe9Fc1mXAe0BxEyQogdEVsE9t6WZ8>
X-ME-Received: <xmr:tIAEau1KTkGu_sxglN4SXGWqIONTPvsmCUgp6rFGZurUs_fs0n_SNUMY72Eq-W3h4-CLGiihVDQhXN5rtyP357DfPWYxLpRFPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehhrghrrghlughnohhr
    ughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:tIAEaqZEEKIOQUnYz0xjS6WCjJVVdmg4JzeqBm3F6XR8ItXMLcVM7Q>
    <xmx:tIAEauItGEL4gSausWsR8yvGdKBHasDKlWfsRY8EvoyG5hXgKhhH1w>
    <xmx:tIAEahG0DLXZhfSyH7nfRIHBb3fPrCC_KGf-0X5oFnvlxUfRTwNPSQ>
    <xmx:tIAEattn5Etp_59I9SOMVhn92sTmPoDKT9pDI3iyWQC7ONQbPrSpBQ>
    <xmx:tYAEagoQ1WHDlmXal6pkxsPlZEtM2wtRwBh3YDPc2b_EiwYLycMJ9aMP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 09:46:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8 0/5] branch: prune-merged
In-Reply-To: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Tue, 12 May 2026 17:07:33
	+0000")
References: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
	<pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 22:46:27 +0900
Message-ID: <xmqqqznfifrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      +    Delete the local branches that --forked <remote> would list, but
>      +    only those whose tip is reachable from their configured upstream
>      +    remote-tracking branch (branch.<name>.merge): the work has already
>      +    landed on the upstream it tracks, so the local copy is no longer
>      +    needed.
>      +
>      +    A branch whose upstream no longer resolves locally is left alone --
>      +    its disappearance is not, on its own, evidence that the work was
>      +    integrated.

That matches my understanding of the original motivation of this
topic a lot better than the previous round.

>      +    integrated. With --force, skip the reachability check and delete
>      +    every branch in the candidate set.

I am not sure if this is a good idea at all.  The option is called
prune-MERGED and with or without --force, mergedness should be what
determines if a branch is deleted.

To perform an equivalent of

	$ git branch -D $(git branch --forked <remote>)

it would be better not to (ab)use the more commonly useful and much
safer "--prune-merged", and let's not add "--prune-forked" either as
a short-cut.  A nuclear option should be made harder to trigger, ot
easier to trigger by confusion between "--prune-{merged,forked}".
