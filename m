Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81941B87C0
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291995; cv=none; b=hl26sJz/uzSUyq3Lg9Ls/cr+K4GmU9zZDvjm1MBjWiKQ/lT7SJoV3vWrMWmTJ67Y1o63tKC+2tJHFFNeuHSqFf0BEKdiN2GRXJ8VXYcwKllmRrrn7BoiPGuzkONb4xrXlakGuT9HGZEEAT/15KhrHWL4QxbJ3Ed3Ey1wJr5y1yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291995; c=relaxed/simple;
	bh=bkQWmr2R2NAijP2L0sl0fyOpWIVqDZoK4gLURPrSgJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b81jMGyvj74i3oLv/Mkp322eZDcJIIsPlM67P4qblIhyecOLfTaYcwrahsA2UZqs3ZPX9Ibbip1oRs3685DbonkYiFVwBm31pL9unpcd7qqj5LtCVSU1qpSKssoz6vJYmzAPsJJLGiBicCfIWyUDbDr6TOqsYwfrXs+NTd8OOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DQBSnz9A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hACEB4TT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DQBSnz9A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hACEB4TT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A3921D0015F;
	Mon,  1 Jun 2026 01:33:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 01:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780291992;
	 x=1780378392; bh=bkQWmr2R2NAijP2L0sl0fyOpWIVqDZoK4gLURPrSgJ0=; b=
	DQBSnz9A/yOXvbMCAwqNWAMh4ejt5M566YT8aw2A/8KxQMior1ZudnKByWmqzMiE
	oKm/0P43WIa2IftMbbPowaYUKOdGzl/jelhoH0IFsMSIEZIpKnJLPDMtoPE3ot/5
	WPspPPhm/dguKbfvgai1NM+z8Nawqe4h5jXr04H5MO0lWsO0kXfl//6k+JaoX5gn
	CoGS+O001y6AZ28Ki44SNTh8wE3RrkXs0C8X2Ai7EguRX8CxaFpbObh8/VkT8Z3u
	zbu9Brd1wB0B94n28kM+db0RXBpp3SMrIr/5j2SpXibsplk/pmNGiidJ/LMO3Lg3
	jX1eCAzqvDma6Fouju6T/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780291992; x=
	1780378392; bh=bkQWmr2R2NAijP2L0sl0fyOpWIVqDZoK4gLURPrSgJ0=; b=h
	ACEB4TTukljoTAZHdTqy491cmK6KBasGn21fNMgNOLTsWcLYr+TlCrIACaimpd9y
	LboxEx76NwxTZVu4nx7h5duFDRbE1Ri6G/fk+PucHq5UF/Lv2GHuUV2harwpLv03
	Ilw8ahp+7mPndvv7zeFfNFLSp7V8prhnY7stEy4B1mGJhkqO2niIUcTX/VjmrDla
	b54BUfjCe09DrwBSKbTjF2CKoQSgoLSkE/VygCGotGjkQjQw0+xK3kYzJlBtJZ1I
	2irm4za6uAKqZL7PTotbgdrh5MQvXhm0x8Tf4UA1ZBTg3alQhLEXCkDkuVT0DbVR
	D7EiLKMtEdE09np38TdZg==
X-ME-Sender: <xms:mBkdavOde7A9R_Kw0AVGWqeTUycGVFgD7_0Y261HCZAoBGoEolyjJQ>
    <xme:mBkdag9Tve30Z5UWxpz6rN3GB7mTR6kyxaWP4n7QSwukLim610eh3PsSiY43D7Vod
    d6xt-AlnEwA6J1C_oXS67QePn8DfsVifPBTlD4y2LAfmDFnXWes_Q>
X-ME-Received: <xmr:mBkdajTl-VNAnWD9KoQAD6Y8pRI4Pl-GtG4ZOqZcxgTWOoBp4--bU23qe2-7BgjMtiqaoI93QpltaGZHE-4d8vfeAJZxwwQk0HLM>
X-ME-Proxy-Cause: dmFkZTGG00bgU0q3AXTJNVa4g2BOUbU0k1mPj8ZDmMPxirR0KAG9zrd072mnpHMo0yYYH0
    KUkkwc/v08Bts+EqD3yQPQLS78Ymd6YO8rX1B8SVpw9fY69qTJQmCYw/uxKQ/94GusIzx/
    +9P9In+gJmpeB4enjjmRYqUrQhkciGYf9hs6IsdJyBYZ8YVNrCzs/tFirDxCdRQh++g62x
    nJPdOXS871xPc1GQx18489psz9Gy1VhQ4PlBlRhP0xw9RZlsl0UKKS/Mb7Fj1ovXhmbKZB
    z+6qP8HxBPnaP/teA3Z1W7/tTzKnSLO+cYXH+37AfUQlDwjM8Pt34n+senjz6hEPFr81Ky
    CR59oWitH5OMnkM1Gdfn5ujq/vfDFnadMkL7wqYYsP2jnvNz4vA9kNEe1uBLG0wRyArmgc
    BBSBAxL30iazlXdaK55UGg8p8bFh6teKSGc9Fo4lbAp8AkNo20r6fsxTDYsurqrGRpzkgE
    iWWa6JKzVdnwF/G5rkTYaPysekeM8e3hinBOeHBOaxqUOW5xGrbJNL7eoSEIeMXjutXnug
    KQJ/n8EUOn9R9jMP7LbjCyuo7Ub7HFYIx/672s6/eq5nLZ6BIIt4UmJTnfl6sbdrAn4faL
    LgRvQ8mFY8e7ruHk+p0BacFxxs75ShQFpB30idwRRQkkc642EOfIWxGVXjHw
X-ME-Proxy: <xmx:mBkdaildY4KohTru2AFlil6ZPZGMdiJryFvBcbQcT8m_6b_yOLFd4Q>
    <xmx:mBkdajS2Due0d3vVOhrpIqcH9lvEBx3spcZVjtQ-wP5bq8xesL335g>
    <xmx:mBkdagOafPd9UtuIFucZue1WLLWH0jVV5WqBjK9qU6zG1GIHryFLaA>
    <xmx:mBkdasVYG29kujyJtp7t3hoeGMEJNzIS7HQ-vjcxRmKX9i_Ohmk77Q>
    <xmx:mBkdamwUSKZsvpCc8P981Uvj3p31NMDzRl5Kx7uvUSIww_q6R1rzb4AF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 01:33:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Evan Haque via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Evan Haque <evanhaque1@gmail.com>
Subject: Re: [PATCH 0/5] git son: add command to create independent child
 repositories
In-Reply-To: <pull.2122.git.1779814052.gitgitgadget@gmail.com> (Evan Haque via
	GitGitGadget's message of "Tue, 26 May 2026 16:47:26 +0000")
References: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 14:33:10 +0900
Message-ID: <xmqqh5nmakq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Evan Haque via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Motivation
> ==========
>
> When spinning off a new project that is related to an existing repository,
> there is no built-in way to create a child repository that maintains a link
> back to its parent without the tight coupling of submodules. Submodules pin
> the child to a specific commit and require the parent to track the child in
> its index, which is too heavyweight when the child is meant to be fully
> independent.
>
> The typical workflow today is manual: git init, git remote add, update
> .gitignore — three steps that are easy to forget or get wrong. git son
> automates this and establishes a lightweight convention for the parent-child
> relationship: a remote named parent in the child, and nothing in the parent
> except an ignore rule.

Although I am personally not interested in this topic even for local
repository use, I should point out that using this tool to create
this combination of repositories would not be useful for other
people who want to clone your arrangement. Other than leaving
comments in the parent project, there seems to be no way to specify
how or where the child projects should be cloned within the working
tree of the parent project.

Since Git is primarily a tool for collaboration among people with
their own repositories, I fail see how this feature is something we
should ship to all Git users as part of the core distribution.

Thanks.
