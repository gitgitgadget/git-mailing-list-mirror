Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72C2F1FFC
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960285; cv=none; b=jbOxyVxoTJ5f9oiGCFwCIowmU1iMCOvbZDWAvsfLitHltUm0DY2vY+gOjCvA/IAZ5VVMZYOfa4/crQOOjmbgdblIVAT64fBtctCS0NkXZNJgVFieL3AKoTTj0AWUJRHpaxI4ZZRhvogH6ExSNnZdKaysXalOEUHM2NqlObWQhxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960285; c=relaxed/simple;
	bh=O/kQ7wTtoWtlpRzbDdEDGnWOWbF/2Vof7BA4Eh4+U3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X7UmjN0Q3r9rfqOmsUNVnrw6JKJZkIRBGDrfjp2VVXkKB4Y67jznm3iDLG42xbn8WjAiZnmBH79yOKSVVp5stESZMvZY61u/X63Vz3+6benguzioemdsnwBt0kZ3Ut2/MrR0d2F192hR4BPUB20m9Z3FP4RgKY9814fk6q63mHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PTN4OTDU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wjnQlNZ2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PTN4OTDU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wjnQlNZ2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C39907A01FE;
	Tue, 24 Feb 2026 14:11:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 24 Feb 2026 14:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771960281; x=1772046681; bh=JsVYGHezm0
	rfiBl9/FWE+n1Ayx+n8SP+KMXzKR8K6Bo=; b=PTN4OTDUKJdf7BfNEGA5X+46NT
	V9ive9e69hYopSND4/riV9tKH7ZyB5qx6m5fb3iQ9BvkcUOZNUf9Tf6FPMhPEYBe
	yv+oDE/rGJA7Idcdb4jBAeOO5cxYN329wYNoZf9n8dGnzhw1hsz+HtJr/XQSLzWC
	kt0Zw4ylUfJFe280ycEoUn9MmxKb1rHBS1GBh3IVC6GCH3Kg7Zh0xkryApOTh4EE
	3JkDstjcZoyQw1sAqpDnjP8nKFZOtk99vGsrCppu+RkpWsKZfNxG08wGfSbgxcim
	ytemzUolTGhWeyGaJyNZxpcKkV2azenfaTqL8sh7UickVFKS9x2HX8sfXBSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771960281; x=1772046681; bh=JsVYGHezm0rfiBl9/FWE+n1Ayx+n8SP+KMX
	zKR8K6Bo=; b=wjnQlNZ2J6z4l8/pMWpK2fNNb/Bsb3KeXhBgOvffx8yvjCqSu5X
	ECkAaa6YvAAKqaPYt8J136mhKfMSH6Ltds72tGd86g/IxAU0lD1tyVLz6xLXf1ey
	0Gh1H5nWJkd1NvMT/rugDXGW0Sb525RuY1bxbGrWMkAKqb8FLAhhQSiSRmUBBERt
	ZwDPS/XJmwnDqq6rqxpujqlJc3EU4Skc5B/LwjzrgqKoizUTjw+mtAcCL/Ykd5h1
	FmGj7mCEx4IJTMO6WJnC9I+EiT+mPAar5Fkpxe8nElgr52tiJ2Yd6+bZGe+QhVUW
	mGWm4UdSLV2Dd1XeBIznUiE4jgVxvXO5qLQ==
X-ME-Sender: <xms:2fedaSmKGB07rXDVeIcPojjGw59YbAgNAeYMe7MlDaxOlgkJ2_hUxQ>
    <xme:2fedacGtLVq9GhlH9rhzFSr8DN632GsKIrr1hCw8__VxVY_K0ENzmKIh-OkYQM_xs
    IGe6C1H50DQCiK1cxRcFuf94Ts0lxARFzmZKGtrM15bFSPR61Qdow>
X-ME-Received: <xmr:2fedaS49vuaHH-L9WBakYXk_Ty6UdIeF8atSCzoJglztRHQoUseRoNkISOF53nRqHTRg9tguVaIMrZmhy08I0xCfUgFhXHmbQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2fedacnODgN6HdFT8tdlB8WYWlXfUtJwjmBgheBnb5223d4-awN_Yg>
    <xmx:2fedafp1F9K06DMq653DnyxFce94afLmv_64boL_WMTeUIdI3ltpIQ>
    <xmx:2fedaTs3wWjY1JAujLuk2SCiFXMjq_3NWMtBYlPNFQ8gHKVitwT1qg>
    <xmx:2fedacHhIbrHBRGLRlinLfJEwv7hxXv-cSENIhSj9akvQkaCb301Ew>
    <xmx:2fedafZcolvDdB69Cscvj6bvjaImUCePEiRTSBOT8d2g95bu_eeg7qwC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 14:11:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,
  peff@peff.net,
  "D . Ben Knoble" <benknoble@gmail.com>,
  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] doc: fix list continuation in alias subsection example
In-Reply-To: <20260224171245.458377-2-jonatan@jontes.page> (Jonatan Holmgren's
	message of "Tue, 24 Feb 2026 18:12:35 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260224171245.458377-1-jonatan@jontes.page>
	<20260224171245.458377-2-jonatan@jontes.page>
Date: Tue, 24 Feb 2026 11:11:19 -0800
Message-ID: <xmqqwm02ez3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> The example showing the equivalence between alias.last and
> alias.last.command was missing the list continuation marks (+
> between the shell session block and the following prose, leaving
> the paragraph detached from the list item in the rendered output.
>
> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
> ---
>  Documentation/config/alias.adoc | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

This seems to address the same issue as 0ed2275f (doc: config: fix
list continuation in alias section, 2026-02-23).  Should we treat
this one as a replacement of that one?

> diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
> index 115fdbb1e3..7830379f58 100644
> --- a/Documentation/config/alias.adoc
> +++ b/Documentation/config/alias.adoc
> @@ -30,13 +30,14 @@ Examples:
>  ----
>  +
>  With a Git alias defined, e.g.,
> -
> ++
>      $ git config --global alias.last "cat-file commit HEAD"
>      # Which is equivalent to
>      $ git config --global alias.last.command "cat-file commit HEAD"
> ++
> +`git last` is equivalent to `git cat-file commit HEAD`. 
>  
> -`git last` is equivalent to `git cat-file commit HEAD`. To avoid
> -confusion and troubles with script usage, aliases that
> +To avoid confusion and troubles with script usage, aliases that
>  hide existing Git commands are ignored except for deprecated
>  commands.  Arguments are split by
>  spaces, the usual shell quoting and escaping are supported.
