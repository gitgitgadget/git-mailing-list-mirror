Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BDF2DAFA8
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876913; cv=none; b=SRnqHWtKm7EnoLZXh+58acUuVQzOnOh2nH7eE1lh9KwHanW3nWJb9lVVvycJbxQeXhyIXNZB9iHpsXmrNaA6MfclwsvBavGCBj75w/orhuNRpjUFDmLTSCPPIj7rEUCko+NyHgBKNDMkNwEe8a2Kn47O4Oub8UuP9iik+mZW3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876913; c=relaxed/simple;
	bh=OuNC1oGTFHKLDFwoIaFrq4crWMQeKnBOR2treeeRVjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=roHjSBg+cPx9+DwG6iyo/7kAXuZa3q2wR1hqUCw/4COcUUNLBXuHQy6BXvMWK9pEqBSrpIzFsNOOz54+RpYkupBJPrFYDmlgFus1/N9mtK2/Us296Xt5Ql2uck37ZPjCAkV1GWFfU38cnLiFGCKrVz7QiS0/BYHFQiexKro8pzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eTXSQWTZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmSLeg90; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eTXSQWTZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmSLeg90"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 030C8EC00B8;
	Wed, 25 Jun 2025 14:41:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 14:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750876909; x=1750963309; bh=HdUOcl2Q/f
	eD0tP9ksSm4hNnnkbsFBYQlwN0tVpjgF8=; b=eTXSQWTZopM2V3Qow4HDC175en
	upyAFebNNbL0SaoMGx/aSpfpQdRadcaX2z93j0RTBDTA/7xQ7IZmt4aUFUWHk2Qx
	fyjQRLGV8WQads6OxNiL/gAKC1poDanGkEOC+JwlegEADOAzUDxga2d51TJPPV9u
	iXQMtK1Lje+a/vOZh5TrMp1ADiTsec2syiAILhugshBtMlkim4mpmjMMQDC/sU6P
	WWZqX1P6ibfpmYxGeFg1UZzSZUT9V9bH4wmykOWqfi58Rk4h4jOXORj2xKupYhPy
	9sm93RwB7dD0lwPE2Mx8dXbCOAYfRZNi64vBReAYk8yj3iuQ4B/wn11LVvWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750876909; x=1750963309; bh=HdUOcl2Q/feD0tP9ksSm4hNnnkbsFBYQlwN
	0tVpjgF8=; b=AmSLeg90PHibKpH39VEYGo2NwNZHUMnB33ryk/SZVziK6ibCTW5
	sLBYcQFJdPmaaSkqJ9dV0LI4YX0ppRBDJxMduu4ekPhcwPuDNQjHlXPWVQLOZdHq
	EIEZHGpfjCqoX3cH5DmDfw9/nVH00qR4ldMlSf4qO41f4bcIm8+5klncmuc4NsB6
	RufnFttZicJV3sycsbLRZrE9+GUiuUuKJ6ONFbSCzwMWZETojd51UWAonaedAcea
	FdimWvq8CqL51yBF/bupAw/tTLirGLBDVyaINa8zkv/VXTSpBk2HdC8Ojj+Xi79q
	PKbNZHWawnTh5zKMoAVSAaDiMK89x0LS46g==
X-ME-Sender: <xms:7UJcaPUDZqXfG6BQfbNje_zimvQYEXcncVwztTvguPnZL6rE9KSz4A>
    <xme:7UJcaHnpz3dLN0kNgwwASyjkBHJmFWvXShObHaHPar8VOjui3qGZ3YztC95P_zY9q
    9RwJINJlhmN_Bql6g>
X-ME-Received: <xmr:7UJcaLZ2NfDShiwDWg0gr5rAzFqm3RgWa4-EZ-PYI3FVSq7fppCIY_9yp_P-UpwX-NSutO90cP15qNV_Hw49sHRHLSGSRaqe4nDoS94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmih
    hlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7UJcaKV7FtjfXe12xZKJp0qjLiyN5KvMmfd2NJt_Gd7qt8BjteRGGw>
    <xmx:7UJcaJmnCIOFhj5PgPIaKHg4lsQfeUsUA8Q3V5opbcRMbjqqs6gYIw>
    <xmx:7UJcaHduNUGAX2ulyy9gfLsE0albS8Wgvp0HNlh6IYaH3LPxyVbETw>
    <xmx:7UJcaDGEUD_q7d7c0q7madstL_CiooYHj5bGY4dujnGkmWeIcV6pbg>
    <xmx:7UJcaCLBHwhAjAkCORuxrjS3q6NyxcKG2xBEnXQ0yqktk8RG9X1ANorQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 14:41:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] editorconfig: set maximum line length to 120
 characters
In-Reply-To: <20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com>
	(Karthik Nayak's message of "Wed, 25 Jun 2025 18:43:26 +0200")
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
	<20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com>
Date: Wed, 25 Jun 2025 11:41:47 -0700
Message-ID: <xmqqo6ubu0ic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> As per 'Documentation/CodingGuidelines', we try to keep to at most 80
> characters per line. However, there are often certain cases where we
> extend this for the sake of readability.
>
> Add a maximum limit of 120 characters to the '.editorconfig'. This means
> that if an individual line exceeds 120 characters, the editor will wrap
> that line. This provides a lot wiggle room over the recommended 80
> character limit.

Ideally "when the line is overly long to be more than 120 columns,
please wrap it to 80 columns or less" is what we want.  If the
result of formatting a single 125 column line leaves us with two
lines, one with 100 columns and another with 25 columns, this would
not be very useful.  As this is meant to give suggestions without
enforcing hard rule, wouldn't it make more sense to set it to 80?

I dunno.

> Contrary to settings within '.clang-format' which are used for
> statically formatting source code, the '.editorconfig' rules are hints
> to the editor. These are not enforced by CI and are guidelines for
> editors to follow. As such, the 'max_line_length' used here is only
> supported in a set of editors [1].
>
> [1]: https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties#max_line_length

Thanks.

The discussion around "rulers" https://github.com/editorconfig/editorconfig/issues/89
was also interesting.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .editorconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.editorconfig b/.editorconfig
> index 2d3929b591..d0f940fd23 100644
> --- a/.editorconfig
> +++ b/.editorconfig
> @@ -7,6 +7,7 @@ insert_final_newline = true
>  [{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
>  indent_style = tab
>  tab_width = 8
> +max_line_length = 120
>  
>  [*.py]
>  indent_style = space
