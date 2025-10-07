Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8D170A11
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847098; cv=none; b=IZ7SPGVQYyl+x80Dza91GiEZV1oIOvSCCCjA9PzQf3fkf9y6oUNgHR/Ivtf8nv6ZXa6ZegjeckAxqp2NFxko+2IN9RojV/sLmz16uVSYKQdLw5qHOPxteNmJofxbgOl9fUocHVdUdmOxSduVOsu+OmaBhN5JrzgMjzu1PEWVvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847098; c=relaxed/simple;
	bh=seBJlxbjKzMkMaZMhmWKneMVMa+kjFDM4XhaAeU2YW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WpcZxh+32YbPuq5hx7l1FOd6V0iin9HeBWGdPiEZ8q3rieuVi0och42Yi9A5slSmCmhB3CxebpzwjCFqlM8DygP9mOYUiWujDDNiGR0d9BgVbbxr/xaGV6DHS1xKd3BQYpE/9C7le52NDTlOBWe12lz6FkWxSbyfd9v3xy1m/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eCa0ovTA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gx7g8bhs; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eCa0ovTA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gx7g8bhs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DD6591D0016B;
	Tue,  7 Oct 2025 10:24:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 07 Oct 2025 10:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759847094;
	 x=1759933494; bh=H9z7oHJXnLAULDiS6VsYKkBSKrusYCCy6o51Lqf52z0=; b=
	eCa0ovTAwH0XD67rOLp5mT5arlJVGGvFn5CspiNBSIYs06fLR3t0c+M5DUtyQYmE
	cPnTW1ZlREussIa2k88iT1RCO0aJ7P2S0ZNR5AIjNjuPKgFnfB4cEC6pcbrnzAEv
	CrkkAcSj/Dog7s5oXj2VtD/TbOUmjK00J4H57XTMASpQvh2lnEJSas3hqrxLyybP
	4UmoULwIuB0cMUyuVZrF6zQ1msxeW11koHqCBWFJwHMyLz24qMCZw2Ew5dTIc3ao
	kAk+amIpQYq+tXBojsGSJ4V6m09/rOCydJc/GwE7ooLpBzNbUh1UQM+x7H6P6qj3
	6ZYCBnWyEsyCYM33SUtkdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759847094; x=
	1759933494; bh=H9z7oHJXnLAULDiS6VsYKkBSKrusYCCy6o51Lqf52z0=; b=g
	x7g8bhsYPx9pLWiM+seYHy4HUSoUGSB7VWoIG6u5Ut9BrYz1ABW/tBWG61+6WXwi
	L/WPRnbaGS7hD6cIE3eLv92cOz04KGL70NV3MZAm0Vjo2+YkisrbPQuExPC1BWZi
	QNIYsrxIyc7JeGqZUdFvlCtrMzZprF+Uq+57fooIlbTmIjstGyeon6Zo0fD9FIge
	jj8xsa25ebHHfEX2NYXV0zGbf0a09uKg7XUwtmTrqvjeDW6mL2DutoWNUHqHpUIn
	ifc+td1k1BXjyuweKpjxjdRKyPxW/h8hKPOQSfPRB0YYp6dErOrSX+ebZzkXNeWR
	dNrzpoBXzJIS3pPWXgWyQ==
X-ME-Sender: <xms:tiLlaI2PpsHKr6qxrK7LbSSE5jH4OZ_91Tnk5zGvd5n0XJFHrmJFLA>
    <xme:tiLlaKGNDhj4NY7xu09rn-gixlm3xSJjoJ_BIz3A2KyoLPM2V8uguwxMAag3NLa7X
    wE3t4a4WhG6TgNX5yGnikP_35-JuvXe04oPWOArP9eY9LOcRK_Xsg>
X-ME-Received: <xmr:tiLlaF4Bx-3iB_xa0O4lsy-yi0uv_Qi32YsdfofM7nkaWHy3gtRX4AeGppZpF46mu-J3B2pZI8GoC8R4dsuj0kfR0269h302q_u1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tiLlaAsXvqjHE2Y61w_UMunUenk0zPDbs4aVM9cj_g0OZ-rh9lD_zQ>
    <xmx:tiLlaG7nCBd4HrtU5YQc22v8R2sr8ZcNAk2z8vONgK9MMBquF_uOfw>
    <xmx:tiLlaLWrtdomimn2qXinD3K8Hfbhb7KF_Ka3OA2osJ32PLGrat29Vg>
    <xmx:tiLlaI_NZSA1V6_C9-seI2rUi2N8wD-DjckcSm21He1SAgiSjUXDxA>
    <xmx:tiLlaDNTZ-_eqOP8iOQ1fiYoJNdEs6IfPhsEQ06BmSx0f9sdzXLRttc0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 10:24:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #02; Mon, 6)
In-Reply-To: <20251007082223.GA3336685@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Oct 2025 04:22:23 -0400")
References: <xmqqqzvfmwcx.fsf@gitster.g>
	<20251007082223.GA3336685@coredump.intra.peff.net>
Date: Tue, 07 Oct 2025 07:24:52 -0700
Message-ID: <xmqqms62n617.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] doc: fix indentation of refStorage item in git-config(1)
>
> Commit 5a12fd2a8c (doc: change the markup of paragraphs following a
> nested list item, 2025-09-27) converted the list of items in
> config/extensions.adoc into a definition list. This caused a small
> regression in the indentation of one item, but only when built with
> AsciiDoctor. You can see the problem with:
>
>   $ ./doc-diff --asciidoctor 5a12fd2a8c^ 5a12fd2a8c
>   --- a/c44beea485f0f2feaf460e2ac87fdd5608d63cf0-asciidoctor/home/peff/share/man/man1/git-config.1
>   +++ b/5a12fd2a8c850df311aa149c9bad87b7cb002abb-asciidoctor/home/peff/share/man/man1/git-config.1
>   @@ -3128,9 +3128,9 @@ CONFIGURATION FILE
>                   •   reftable for the reftable format. This format is
>                       experimental and its internals are subject to change.
>
>   -               Note that this setting should only be set by git-init(1) or git-
>   -               clone(1). Trying to change it after initialization will not work
>   -               and will produce hard-to-diagnose issues.
>   +           Note that this setting should only be set by git-init(1) or git-
>   +           clone(1). Trying to change it after initialization will not work and
>   +           will produce hard-to-diagnose issues.
>
>               relativeWorktrees
>                   If enabled, indicates at least one worktree has been linked with
>
> (along with many other changes which are correctly fixing what
> 5a12fd2a8c intended to fix). The "Note" paragraph should remain aligned
> with the bullet points, as they are left-aligned with the rest of the
> definition text.
>
> The confusion comes from a paragraph following a list item (ironically,
> the same case that 5a12fd2a8c was solving!). We can solve it by adding
> "--" block markers around the nested list. We couldn't have done that
> before 5a12fd2a8c because before then our list was nested inside another
> set of block markers, something that AsciiDoctor has trouble with. But
> now that we are a top-level definition list, it is OK to do so (and in
> fact, you can see that commit already made a similar adjustment for the
> worktreeConfig entry).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config/extensions.adoc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index 49a7598ca5..aaea8c107f 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -55,8 +55,9 @@ For historical reasons, this extension is respected regardless of the
>  refStorage:::
>  	Specify the ref storage format to use. The acceptable values are:
>  +
> +--
>  include::../ref-storage-format.adoc[]
> -
> +--
>  +
>  Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1]. Trying to change it after initialization will not

Thanks.  Will queue.
