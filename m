Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A9C8E6
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765847607; cv=none; b=ntp2kRDNTEMWZfwJYEWHHu4STKsKp93xQMNkqrMhh0/5GkpLqw+3YHmHKXQJ6Gkq76VKMu4BWjOAeFk6yKPScladXLqUSpayB53v6aJCDyYsFioouDI3ucilOezXMcu9cgZ/Ua/JPwaLY49tSB64UZe1G2ZdBGbffA+cpNoN9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765847607; c=relaxed/simple;
	bh=P9Qw+BILvbLWen0ZqlgPs9lXdQNrZ9SVMLFr7dPYvNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lm59tn28CknwvuxloeO4Mzx9t8MMsfvoPHWleYUSS84qnkJdpVzt3UpTMHYEUm+YRFwbe8SYVcFoGHUGMgAIkL8AgKiuP472C19PLseDYmMDoHHICZvwyA629qHBam5EaRQKd40Orcy8OrqTW3SfbDn62HDn1bW4dXk1jvAAn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jNnkl5Vd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vCwI1FMT; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jNnkl5Vd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vCwI1FMT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 77E9A1D00140;
	Mon, 15 Dec 2025 20:13:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 20:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765847604; x=1765934004; bh=dElC7KJgmX
	5FYnFbgWND1+Iv69YvphthLez5YTBcknE=; b=jNnkl5Vd3UlhhkktxkqFYBZWyg
	q/wJtJencyu7mIdvEivozc9JyFfPwtGK/lFb1/2+ubjekkTt4q8Iln0yjDZSW+2W
	xZb+IXIm0St0Q+VSDiBSK6V/T5vV8bRoGp3OJAXTMyR3TpP7sWRHu6m5ASOwBB3z
	pUgdGsRjz4vlioY25g50qvu+tAnOTOr1ryHOEQ0S+asq/3/EIBIv9Aqx/Q/Ae1F9
	nhvEiPH05Mo2cTT1taRPYUEIKYXNRc8v0jEkwzQt1FuMp20kqMTYlh9gw1WWSNpa
	fHDIUOq6icqbN4jE6XgG7a4oc1zT71wF2oarV04Sczr+z4qUY7DkEtEZQLpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765847604; x=1765934004; bh=dElC7KJgmX5FYnFbgWND1+Iv69YvphthLez
	5YTBcknE=; b=vCwI1FMTc79n4zmIGon5x2ql9PnVcWfvvK8fjvxyF8d1o3GL/Fi
	XXEJNUG/lv0ZM19oyT0V2bnmoha2RwC996e+G2kYmWrcvPSJZvtFfJpF4Hbi6Zdo
	ksoAEDssNqbCVaBDfxWX06LmW8FtXSpThlOjrX6tvqXKhaMjN7Ax7tN7DKFCbzGK
	4yu1X6cyCdsAdLCDJaKQSJXSSEppNt7cxLqVlV7oNJ1tDSAQd3lkaq2G3RZg+eLh
	XEPrSpGrg/FsIK68Ctpy+b3XhctMSybRgNTlsq6Rz7P/kWGwWb7f3cNNXHZhRPLr
	4aOkT1lx0LYYuuW8Yq6lEcreYG4gdg9BRTg==
X-ME-Sender: <xms:NLJAaWYMh8FhRzVK8F_pqXR2LdylTyJVPCJI1Cq81GYEpS8xXRsS9g>
    <xme:NLJAaQas2gCdLwBcPWSQ35WgMT2EQdp-JFI81ZkJ9hCH0CwvXcBO7CnuZiffJoGD7
    jViv0YLCznWUHWNSgtxqmU8S9aDXOVoD6aIbrNR4XzCJg0sEud7>
X-ME-Received: <xmr:NLJAaV-wGguxtp1EXYJ5XFwYiISLIIorRGhFaYPbj7ecPTiP0dNvtQPQsYZUYbWeRM7bp46drdl7hJe5MTnBuqG3wyTiYIQgJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NLJAaXiAhockaQfyf23QErYXF5oaV2McN-tmXNi1vF_YpWxZiJBVcQ>
    <xmx:NLJAade4kbdCKNz9RGLHdgSqpmG1tjAayw8gdJwOJz-AQBFsxp8rjw>
    <xmx:NLJAaWor5zttds9CaQ-iKnKVH3Tc2HgC8BHBVbhZ3OO6fCBix-BNAw>
    <xmx:NLJAaaDLEawkt9Ic_NC-PV2ZiP40DSHsE8ShO5X3MQ-J-q7Mmd_mgw>
    <xmx:NLJAaVdjGwaW2hmk-hgzTXkjj2LeSaNXibPOzQUS9bzquSaQs8C2pLAr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 20:13:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH] docs: clarify git-rev-list(1) --filter behavior
In-Reply-To: <20251215200512.2694155-1-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 15 Dec 2025 14:05:12 -0600")
References: <20251215200512.2694155-1-jltobler@gmail.com>
Date: Tue, 16 Dec 2025 10:13:22 +0900
Message-ID: <xmqqwm2n5ivh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> When using the --filter option for git-rev-list(1), objects that are
> explicitly provided ignore filters and are always printed unless the
> --filter-provided-objects option is also specified. Clarify this
> behavior in the documentation.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>
> Greetings,
>
> This small documentation update is in response to discussion from [1].
>
> Thanks,
> -Justin
>
> [1]: <aT-djS-TrQJxxV8i@pks.im>
>
> ---
>  Documentation/rev-list-options.adoc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index d9665d82c8..453ec59057 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -983,7 +983,9 @@ to name units in KiB, MiB, or GiB.  For example, `blob:limit=1k`
>  is the same as 'blob:limit=1024'.
>  +
>  The form `--filter=object:type=(tag|commit|tree|blob)` omits all objects
> -which are not of the requested type.
> +which are not of the requested type. Note that explicitly provided objects
> +ignore filters and are always printed unless `--filter-provided-objects` is
> +also specified.

The above documents the status quo correctly, so let's queue, but it
is unfortunate that we need an extra option to do this.

