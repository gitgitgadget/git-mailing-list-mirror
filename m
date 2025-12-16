Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF93C38
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765845564; cv=none; b=tqm1LJs0rKxaB903OLyq5Ce6SK8YCIt3ajEb4Vz/J5iKAop5e7cRIpBu2WTblnfZkYZrDGQBRSFdoMDvbo/Avtj0TbaUm4FPLjDmaRCmrS0DXiLJe4yhby3jiyiWrpsdaL83IQviJ99mc1fNjdpk1JNaOMPFb1Cs9XiKjjXVygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765845564; c=relaxed/simple;
	bh=7Klou/AxkL+rHq76KI7bzMSpV8vK1dQ0kMjYw8RLZnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZOJazLobKXFk2CvHS245/VrjAWHKaI6LNk6ckhWkGq+tbrFz260XCNiwxtHsazyfQlXDuQQh/iT7OE6QsBk6CbiSPC5iXxuyMSnhyaMCYVxTQzoMTei7d57fAF6UkFvapMhTmVhXdqz9iE2neo4p3z/bkoSKFPo8JLjgHmUJd+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LwWFdg3x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJ1dyD5p; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LwWFdg3x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJ1dyD5p"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D6C67A019E;
	Mon, 15 Dec 2025 19:39:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 15 Dec 2025 19:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765845560; x=1765931960; bh=IvYJrPzBac
	7cZcg8PYQBBE0IyVuJpKYFVkFxjt1erp8=; b=LwWFdg3xE8sgwgAmc7mwN7ffp3
	s7IpezBHicSQlNNT3e4/q71a+NL++3e0oOdWyw6XtPJ5tBmDTdfdgsnN7zvBU8sJ
	dBVpTUEJN3x7RWtw6IyyfeBiS6r0HfeX6afQTbwMptNfdVtJnpna6FzSG0bhiB/f
	HNFA9n7ulmET5DFsIcLFVubO5DAv2ZcBM22orvZQNOjuOld/Gqwjv+nByhbpPQfk
	CXWK6/q45Yqb6nOxntj490SlhO0ONAKcWjq6Bchzl5SJm+tXvhqtymMptznTAXBE
	CzVF48KBRZ7qXdWFcAPHzx6XipPwZUsW4ZfFQJ4nDUgAPlEa1YxBcRIn+2zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765845560; x=1765931960; bh=IvYJrPzBac7cZcg8PYQBBE0IyVuJpKYFVkF
	xjt1erp8=; b=JJ1dyD5pB73zhfrEHiv0T1FJ0u2lNGBfQEO/StaIBpJxjKRq+3F
	T85xpcoy3A1SYIjSbasMx0JE0BAwLtEMk/f8FTM/Hw3U4pp8MukO/YnqdmC1tBrg
	3iAIZfBpHLZCxoHA6W5xsPfzpdd6I8DnasRBDJD1rtsraEptZ5+iGA0GhcVpWvpf
	tz7GVnG4DY5IuJFGVzQ6D0G5ef85amXlc0CUWx/yA2m6MMpcPtxeYwu4xU0wWIH3
	+YgOxfkL3eSKmwRyuvZTgFebUhud3JqcLDMXwL623AW4oZxg7vrIIVOYPpHNsexL
	QRpzKxIE3dxJCtxjb+UIi8DG494hmGZtKfw==
X-ME-Sender: <xms:OKpAaeEn1-MTnGQu2Ca71_YyHjTg9dBgaNEPPzkpyFx5-tkjDJd8nQ>
    <xme:OKpAaR4BkGTGYikAKEhi2YdIYYnzq2U6qxOxv68hXKpQ_h6tfEfKuwlzt-deNYwqa
    1MqXTLnERFiwx0PTrVIMw2R9Ef0NHDJgCAg0yBh_XW4M6n4_pjb-Q>
X-ME-Received: <xmr:OKpAabxCF8WlAfFSFl65zl7bXCqfTxRolFM-KsyWeR4mxMweSD9az1M2CGBhfgU6hCLj6s3vLLIyJNax1P4jqVS_d5dBcrXf_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopegrthhthhgvfihhuhhghhgvshelfeegsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpth
    htohepmhgrthhthhgvfihhuhhghhgvshelfeegsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohephhhfvghrrhgvihhrohesihhgrghlihgrrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OKpAaYMHuWs9sHNM3ap43C0cbpknV6ptP8QEuHGnFaTl1KTS6iWAPw>
    <xmx:OKpAaZkUzCICaVcnjdXfLLDsIYTIE2raMcViP59I-yNW4p5YVHCxOQ>
    <xmx:OKpAaVTxE-hcXHn_uE8VBv_vVpW3USM72O-p_C9pr69WbPb-N0SNAg>
    <xmx:OKpAaQU1xtU50J_-P4fS5tAQIYVwyox62M2VJ00ef-r57j1L9L_q1w>
    <xmx:OKpAaduICJJcoPl-Zrhi-T-8Xmj9Lswe2R9IPxchIy-z8TW7SUg7kTfQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 19:39:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  ps@pks.im,  atthewhughes934@gmail.com,
  johannes.schindelin@gmx.de,  Matthew Hughes <matthewhughes934@gmail.com>,
  Henrique Ferreiro <hferreiro@igalia.com>
Subject: Re: [PATCH v3 0/5] Audit and document Scalar config
In-Reply-To: <ee4acbe5-5efb-4bd2-a361-dc7f183b4f41@gmail.com> (Derrick
	Stolee's message of "Mon, 15 Dec 2025 09:33:55 -0500")
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
	<pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
	<xmqqecozb6rl.fsf@gitster.g>
	<ee4acbe5-5efb-4bd2-a361-dc7f183b4f41@gmail.com>
Date: Tue, 16 Dec 2025 09:39:19 +0900
Message-ID: <xmqq5xa76z0o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>>>      -+	which enables parallel index reads.
>>>      ++	when reading the index due the default value of	`core.preloadIndex`,
>>>      ++	which enables parallel index reads. This explicit setting also enables
>>>      ++	`index.recordOffsetTable=true` to speed up parallel index reads.
>> 
>> I understood the previous "due to" version (from the middle school
>> English class I took eons ago), but not the updated one.
>> 
>> Other than that, there weren't anything iffy in the new version.
>> Will replace.  Thanks.
>
> Indeed, I don't know how I dropped that "to".

Will locally amend, then.  Also on the same line, "value of
`core.preloadIndex`" has a tab (instead of a space) after `of`,
which looked funny.

I wonder if there a need for a new whitespace error class that spots
a HT at the 7th column and has non-whitespace characters on both
sides.  #leftoverbits

