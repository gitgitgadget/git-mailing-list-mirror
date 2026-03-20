Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6503CA4B3
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025432; cv=none; b=St2kYuueDdWG2jRKjB8Z344z5iFYE4Re+alwycy4BhE04XH53A7Za72u3ghrAz9G3SjLqA12dK4fZBPxoPYJSsuQAT3GizNShqE3XPlLejagHgqgJ4Oe1wN0XWyM8L4Q/pZkzNAyoFhSz7k/4Hok2efocApINTUV+lAWxLcVDCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025432; c=relaxed/simple;
	bh=LeDFEEJSPmHKCNS8sTmeBf4/HUFcX4k7ArzFoCt9EN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SXOg/ETMYUt4ShHQObHrsHmy1vYPQEkb9IyBmVw9s82D8Lw+C2GmTef/DH4BUzyg4VDxmALHUpYBFEtavLLedSxX10TvweKrH6SKNrbmZjdpSzracHFwVDOekcBj2SiipPB8Rqe9KHQBZrbnZl244gtd4F59Do/Ta9kBNfBHedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ThPev6Ab; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eHZHOCgM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ThPev6Ab";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eHZHOCgM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C90EEC0194;
	Fri, 20 Mar 2026 12:50:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 12:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774025430; x=1774111830; bh=Zf9qnTg0nV
	MhhJl2lCmHno5PCPg0tD2n7rCkQwCHMIA=; b=ThPev6AbLRzjjqjz/pDgsA/FTC
	mG496+X49ouje+HVV/Qy8xfmx4Uh4LWXG9/r9T7dH/+vQSQlbCpSUStkerL412IE
	I842RWClNDdALNTWydPE3lC67crMJZCbbWmRBdl0OnMTcRdeHtUor9nzB2f8HdIT
	y1E/gWNJlat5ttX4mV7aP3hpyA4NxTARcFmpfvlqxEEOS8UnmoqO3TGS2ZOPCKmw
	C7YtjqX/+alZqxePI4GhMnQL+GaOe++zmtzyqwMZkSTbv+phhlHbA6lLh0OgkcNI
	elBE8She/wF+Thwj24PZm0efH36olhAeM/470D1Cp7lUa05yQpgMnrg+xLDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774025430; x=1774111830; bh=Zf9qnTg0nVMhhJl2lCmHno5PCPg0tD2n7rC
	kQwCHMIA=; b=eHZHOCgMtCo9tmPb1IqP7Aonj1SWSwTsJ/AvNyjI/vM7DRvjmwa
	LlWLw0JBvecHUh1pM42i9LZVE+S7/kdaIPKCjQ3D1OQvtJAO2XhCQdkPDVW5Z1hS
	l4jUMxQTUWuvOcjmGaRVoCqg0tjOYVYLqsYsJez5Y2WztZRhom/WFq1jbr87/qVt
	wP+kiw6124txiO7S23w4JRQJYGgZpiiLYX+PjbhriRRqstaLzGMRZnsgS6Qj8R7w
	sUXHeo7zQQNIf+l0q+hh4lAQVj+uYLjRtve0a5nKeMcXut+rYw1dBxNKcviIZOFk
	PpbqzeHLfe91s/AC8LeH12X5NrYzrtkCkmQ==
X-ME-Sender: <xms:1nq9aW9huRgKk3TsG3KvLK_8u6A9ViEzyr9kv4NhQupKNWa6vBWKFA>
    <xme:1nq9adv2-oso4hW0mNKVaqtEYm4-fB_u6Dd-B4Z3N5UPeNk8Zal5CJTLx8bFj4DfT
    13wAe4w8MgSHXF5_7pjy83EaEvdKS5T11v0MlX0eImUGPDGf8ehUA>
X-ME-Received: <xmr:1nq9aRDrcf0cWxj52bze6ZunskVguG3nkjG7D2B3xMDl2DCmeVpINYSwU4jh-9JGrP1faNaOCBDn8x9UAtpjqtLZthTXhoQj5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteehffehffektddufeejtefhteeiudfhgeduveegleehgfeiieeffedugeej
    ffegnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdrug
    gvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1nq9adWDka4pyV2l--mQCk3430S-waN01i1Nos4ofq8DSHlSvliP_g>
    <xmx:1nq9aXC1A_ybCFzHttdPhjrVf_YMmoKmxQMd44dfCGE01tUmgnyKHw>
    <xmx:1nq9aY8ubVRA2AHTDd9Ul9bzMBNVB_HAa_ftP972S_ttQYmxoIKGiQ>
    <xmx:1nq9aWFgEIAmNFPdWaCineU4HmgrXVwiPOynYycRa5Ovnyxe2usA1g>
    <xmx:1nq9aUGd4Dwu5u0JBTYEpeUuVuyiTktnjlDjKwHXgC3PWYdTeYOoNaXN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 12:50:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] regex: not all macOS platforms seem to have REG_ENHANCED
In-Reply-To: <6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de> (Johannes
	Schindelin's message of "Fri, 20 Mar 2026 08:55:54 +0100 (CET)")
References: <xmqq8qbnigxp.fsf@gitster.g>
	<6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de>
Date: Fri, 20 Mar 2026 09:50:28 -0700
Message-ID: <xmqqcy0yfnsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> While this lets the build pass, it _does_ change behavior. Where
> previously, EREs were enforced, now BREs are silently enforced.

Enhanced is not about ERE/BRE but yes, you're right.  A build that
does not support REG_ENHANCED (due to the lack of definition in the
header) would compile but without enhanced features like \b, so the
"patch" above would not something I want to apply and blamed by
macOS users for X-<.

> So it might be desirable to instead imitate what `meson.build` does,
> namely define `USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS` on macOS when
> compiling with `clang`.
>
> But that should already be the case:
> https://gitlab.com/git-scm/git/-/blob/v2.53.0/config.mak.uname#L151
>
>> ifeq ($(uname_S),Darwin)
>> [...]
>> 	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS = YesPlease
>
> So: hmm.

Hmm, indeed.
