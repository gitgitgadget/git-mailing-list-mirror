Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732D279333
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413730; cv=none; b=A5esH3AwE8qlaHGugy6WRC7pRRCzfUTYzh+D6UzQH6lOnyAWOBvg8pD1TwelSyEMCbeyvvQwfvVNWKGPdKlZMV9wTXXeIQzCZdsUmQTX/caGX8oRl7AZCzI85/PdFC/RE7B5wxqG3GRRS5BxEeNyYOzU6dA9d+hZ2DSkIYQcxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413730; c=relaxed/simple;
	bh=9M+TkJgsIwVgOHDuVeP0xxbuDuUGvoJw7+zySFLYTUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rnl6HODm9idCt23rXFw3EAw7EB0X7NJ6/Qiib/saiF2p8CPUHWHJxynbam/I2NG93xm1gPAbg72CJ10mVemOYtAyYo26Q1N+TdZ9ph1ZI69YD0Jfle2ALn5rJAFp9T5vi54e1uYfTFvCd9tV5Sk9dgN49UJVYhAwu8TuMTCCdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z4YkbGfp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iv4rlEPd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z4YkbGfp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iv4rlEPd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB7C47A0133;
	Tue,  5 Aug 2025 13:08:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 05 Aug 2025 13:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754413727; x=1754500127; bh=NR/AxOmxt9
	jNXWh7LKJP2fOoNzM6VOCxQvxyJRys6vw=; b=Z4YkbGfpqB5qtAkacnaoKXy95v
	KwVdvpGRTOEwnCChVNQ31SWpt2N8BeUqrK/X41gvfSBXc0HuptPbY75weOWcDCSW
	YkqZDYj5ggyBoDJwi26VgsFXqIJZn3O5sl2499o6/Jbz0nMdm7nF1LH+cTwf8mk1
	3dbJ1iyMnE6/GID+eaXI3E2bJh3/h7ZHMxChj/VKjzYhcylxr29q3PfZRBVrzbGV
	nGmsvEFvUAukol5lf9sPdu7MlZwyuc21xk47fzexmkdX0daKl+HZuRWE2I79Pno5
	ed19ec65D46XKaPniQf6GmgbX/K1rjQvL833V+acRG76HO4bcFw8PwUWROFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754413727; x=1754500127; bh=NR/AxOmxt9jNXWh7LKJP2fOoNzM6VOCxQvx
	yJRys6vw=; b=Iv4rlEPd7Xe7ZO9V4b30DjL6Z9hh7fGCPrExqeF1VxAC9/mB4AN
	DUrDBFTniDH9hF3+7EpX8zlK2c541d4yY7vQEoBqR6QhC3MC4aEtXAvgIg/7CHjS
	cxSfc/jXkzt+Mm6/5gaZqBhdxxRzcmAgAX8vv6X9CBTjBkvi7TaWxpGbLk4yuZzV
	id0WD5zGf2UMvW2yCznzwUs6smQ8Gdy0VwcdAL6Vb85k4XMqjV32GB8s7dMErHxH
	1XzkpFNiqUuOWspS3HR89ToI61UzP0IxI9oXP7kT43eXEfoNzsPd7iFPPQ1IHdVn
	8BH2JsOWIpzx9H1BYEYs6aesFLHt8TFsgQg==
X-ME-Sender: <xms:nzqSaJhRzBKpZLNXdSv-xlMqcUmjwRnaiHEOmgrvWjdQRyEvRleVIg>
    <xme:nzqSaIlbVwg9GQHFzMULt1nQxWFb5mcfl8AtEGlMHI297VFbopQ0UgV4fBwgya6Jc
    -FUeZpPLkhDdvifyA>
X-ME-Received: <xmr:nzqSaFod2xIKx0MIYrVtGaqfGVcKWuGmf3RDk0C9EuRiZOwHaSyorg2_icn1reATX4lt1nSKIfeGhD2mAcgaFDUJMKX3AJx6t2le9T0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nzqSaBGR46tGiiGgBrjK2HnQthFqXXobh7eW6ka8fJIcjaXaFWd8ww>
    <xmx:nzqSaBxYfGyJkdU2dzSoF93hAuNarS4_hGqF1GfYow4qRx9PDj7wGg>
    <xmx:nzqSaGq_1fGFqh8BafIXvwoxKGC3iVZR3YGg7WALCKklEtYw2wX0OA>
    <xmx:nzqSaLii4H79mfjM_8skDqZRESTw17lPkD6AY-pblMcRvXM67sSHRQ>
    <xmx:nzqSaMPJzQVTey4chEp-JjA5duAMhpCHvJbH772mpA__HemnTcQ59wGs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 13:08:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
In-Reply-To: <20250805125120.GA1291837@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 5 Aug 2025 08:51:20 -0400")
References: <xmqqms8fbilv.fsf@gitster.g> <aJCBlnHp-db4Nd5w@pks.im>
	<xmqqqzxr88jg.fsf@gitster.g> <aJDI16RBR9QKdtW9@pks.im>
	<20250804154129.GC109984@coredump.intra.peff.net>
	<xmqqectq4ne9.fsf@gitster.g>
	<20250805125120.GA1291837@coredump.intra.peff.net>
Date: Tue, 05 Aug 2025 10:08:46 -0700
Message-ID: <xmqqzfcdzof5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think I don't think it's pretending that nothing bad happened, though.
> The user did not ask us to update HEAD, and we are able to fill their
> original request completely. So there really was nothing bad that
> happened.
>
> To me the options are "try to do the best thing in a racy situation,
> even though it almost never happens and will be complex and somewhat
> untested" vs "do the simple and stupid thing that does not happen enough
> for anyone to care too much".

OK.  I still prefer the latter ;-)

Thanks.
