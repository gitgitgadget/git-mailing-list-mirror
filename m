Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192B2C15A0
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566791; cv=none; b=NxsSNfbmV3ljStdpIb9H02rbrDTL95VGY3KRjx+h16rTSiU1nDtuVMb6Kloq+W9Ny0BK4FyQocFUWuNsqUNorHqlrJESbkCAaYVUQZVHujiDHs6oT+jHX36+U+xMbstYvjdS/bLmPdGqHUU9WbM25OSHfSkobRi39wHxFXfc+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566791; c=relaxed/simple;
	bh=dAnkcy/7RLFKeQucj2e6fp+ISpznukJYmEF/iCrLRE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=efvw37foGQDWqnuGQMDu/tWBn/bJ0SmF0bSfTaMcrUxw16zSeIFpo8P2LqggGH2/VNM/+RC4lS6ICTiXBQpHv0dih1+gPTtxSSqeEBrB13iOOhnoL6cpGMAoyKPp0gQ4wgna+Hz3f6KnN8sfXhiWsxGlvjk0U/tFDOs8etEJFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P+NEnr7j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Alf/p3OR; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P+NEnr7j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Alf/p3OR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C560EC021C;
	Wed, 15 Oct 2025 18:19:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 15 Oct 2025 18:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760566788; x=1760653188; bh=bVQlcOiuUh
	qE9tjOQ4mclUkqndsFK3KSzxVnleoLY60=; b=P+NEnr7jL0nt5+Fo/OrZmkLJZn
	oD6Wf3vvV0Z54u2pTQOXmf2x7ObxXaDTu57UG3sqJZo9LQRq46gckTVI+/ydtutS
	RXEc7mupAq0w9Av1jMCpzTB4nR9HWzAzP67/CONqlrxddSeqXROyMtoYbE7Bd7Cs
	7BC6bm51QFuO7bNoSGaIbD/FRBn01NZ6bUHFuSbLttyKIM9rDtxb5GYwr5z4a4zW
	vUbU/o3NAmH7YyHi1CWLFCHDEwDD+YctK6JG5MC6b1pv33asMx+R19raVcZUJCbu
	y6EQdxEsbOR9P0gZC4E8QTByQVmqUqAI0CP7vRrQLpV+wgwt1IwCtVeA80NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760566788; x=1760653188; bh=bVQlcOiuUhqE9tjOQ4mclUkqndsFK3KSzxV
	nleoLY60=; b=Alf/p3ORVwDmghEyVwvaDyOw880S6VMNH2HjrxZn4tKUrMJ6/eI
	ua/ij1/Gy6O93lmAgLX3f83vUPvT4sRWY09lXtLTht2nWDaaECd5MZZtCxDxLT/P
	LtmLojqi/yFLqaRX3iOLo0o/GM4ATNFh7dw1Ntmc7xf1CeLB4+KaoOsShUdkVIRe
	sr8A4AdRUk97+XRFujAThynu39caPMc4M7q75mpxPr/5sT/D2HKyNzlGmgX/Vkpu
	/svLKL2/khBAsdTh1iC3/KAk764FEgU2Xekqe2LOEv7Pc4D9iNvJnbBEw64mQ2m2
	INREDE6n/l8ubLOYPx3GRXSdPbkG5WulxGg==
X-ME-Sender: <xms:BB7waIhAuNk1gf3a2UTejP7DrCUaSM8FnhlKuBcph4TYTs3H9P9N1w>
    <xme:BB7waH6Q-sWrppKPs092Eyp89rsRAQiptX7FM2ZgBWOhWYg1CRRDc_zlmiZxM4gtq
    854VRNSkAvuzniFKxeyHpdM6eyTSy2CPOntV4Oj3yGAKITNX8NA>
X-ME-Received: <xmr:BB7waIZMu4Q8Klcv_mu1WjZ_-rmWLSIvkRleNaYljkEdheyfDYiXYmxbcNKHV4fEekDQB_ra5D_6qEP7BUwF-ZiLru4Y-B7aoF2y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BB7waE4jqQ9PWfSK9pXVzDnkMjGxkcqSBdSMOIXWhl11pu7AtG5FhQ>
    <xmx:BB7waDDZuQXc0RZ622kpzpPf9ChMVl0IzEhyv2H9NnkN8G8hAdm_rg>
    <xmx:BB7waCfzfkWGWJDTnX_WXS7MVwGRQVQut3eYp97RkwRxJVMSi0j-CA>
    <xmx:BB7waKLZr_W5D9eqNebM0Ak50UMwfaVGI6bGWvgA1N8cKyl-16veEw>
    <xmx:BB7waPJhBq2xoPLaa8ORYBkQPClVf5_BHpekxmo4DBZgDozmMolQRywT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 18:19:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Martin von Zweigbergk via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Martin von Zweigbergk <martinvonz@gmail.com>,
  Martin von Zweigbergk <martinvonz@google.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will
 be removed in 3.0
In-Reply-To: <pull.1989.git.1760566054455.gitgitgadget@gmail.com> (Martin von
	Zweigbergk via GitGitGadget's message of "Wed, 15 Oct 2025 22:07:34
	+0000")
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 15:19:46 -0700
Message-ID: <xmqq4irzu7st.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Martin von Zweigbergk via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Martin von Zweigbergk <martinvonz@google.com>
>
> The `git diff X..Y` syntax is quite misleading because it looks like
> it shows the diff of the commits in the X..Y range but it actually
> shows the diff from X to Y. IMO, if that syntax is supported, it
> should show a diff from the merge base of X and Y to Y. I hope Git 3.0
> is a good time to remove support for the current syntax and
> semantics. Then we can perhaps add the syntax back later with less
> surprising semantics.
>
> Signed-off-by: Martin von Zweigbergk <martinvonz@google.com>
> ---
>     BreakingChanges: say that git diff X..Y syntax will be removed in 3.0

I like it in prinicple and I do wish that we didn't do the lazy
thing when we did the command line parser for "git diff" (we had
revision range parser, so we just reused it instead of doing our own
for "git diff").  But real life may bite us back.

In any case, a declaration that does not come with code changes that
are protected by WITH_BREAKING_CHANGES CPP macro is a patch that is
not quite ready to be applied.



> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1989%2Fmartinvonz%2Fmz%2Fwtmnpolouvvz-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1989/martinvonz/mz/wtmnpolouvvz-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1989
>
>  Documentation/BreakingChanges.adoc | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index 90b53abcea..93fb968840 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -114,6 +114,10 @@ applications and forges.
>  +
>  There is no plan to deprecate the "sha1" object format at this point in time.
>  +
> +Support for "git diff X..Y" syntax will be removed. Use "git diff X Y" instead.
> +This will open up the syntax for a more consistent interpretation of
> +"git diff $(git merge-base X Y) Y".
> ++
>  Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
>  <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
>  <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
>
> base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26
