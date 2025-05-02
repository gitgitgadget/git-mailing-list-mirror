Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC51D619D
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175936; cv=none; b=ZAx+1x1vlMEx9Eow7MrRuDDyT6cJrAgiPwGVGuWE096qpnZzJ082sRW1MdNoHhY6lXr3ORN4y8YlJ+QlIdy+NlCkuqHQRbWZ4m9oHTJkdKxeUwX/ZSOXOYWPxQe/y0Np8KXtX7IBqd+T5PcFSQtnw5fi+gC7StPpQv7Ehf5RgxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175936; c=relaxed/simple;
	bh=8kCH7npKukAmv69CkP65+qqFSwZcYcNIR2G7WMqeXSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBqtBt7//TghqG60UXA0latni5xxoEZHykOkfcoUCHi/Gbpfd4AnDTqTMmHzYRorOSNDOX1sDr5gCvSR70v3ldAryEZgNfSjv8E0U6SEqflYk35UfEuyZ59B/3JIusWZMcjcvB7c0YyI5MbrgX2X6PULnoVVrK0ujI7BMUQ+D6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nerbv2qO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KxAJ3K9O; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nerbv2qO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxAJ3K9O"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 096C51380212;
	Fri,  2 May 2025 04:52:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 02 May 2025 04:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746175934; x=1746262334; bh=YCGQa0WqDw
	XVm8kbOwYv7fweqKv6kBghapNlLd3G/eQ=; b=Nerbv2qOlBM5iKB8lMCz9x0EeK
	H2Wrrr6nJ1yY5gvdZd+EqDnljPWdLtRpcNmF9tLNmuvizDH48SdCpJfqo7aITZlo
	cjqvUJZc+iFYd4C3SgWaLTVAiuEYq3DDseixIAJXK/7aWWDVWbnXtUUZg3l1HSlv
	iYMzz5JkAJBccuwuMpZDVqqcpOlY0dK4tttx4rx9KX0TGsw/E6BM73Ns1pfGd6F2
	5tOJk3vM9X9/O0NKlMyqY/94a7Ouqm/JVld+L/RyG65+Y1NdxmQ4pw/+QSInFdcZ
	V4ffjd9dCELfKrW4bSqpUY2JcM6SAVQJBjqR2D7ezTmnYM6tJDQs4vCIw9wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746175934; x=1746262334; bh=YCGQa0WqDwXVm8kbOwYv7fweqKv6kBghapN
	lLd3G/eQ=; b=KxAJ3K9OIWC6AH2ZfWPu2Dw0PJu7Ti4EDcz54hOp1Cu1lkWg3Yy
	ZylIMDgTnFAiaomG50dxThEL4IObeZN/lFIacuITT0LlRiVFXUjFKF2NCU1B5Ezm
	8kw3sLUy94I5oEEJyBXU047ITp2OWhRoFv0bmtbldm2JNpclcZVWbvPlK/XAkoIR
	tzMe8cwZHNPCwL1vFbzMDo8J4m5VbrjG6jn5/sDmXfkaNrULawZzSv7Vvtsszrdu
	qjVvIr5ZgsZckevUKEuoNcszVex2G79vUL4mBaWIuW1k35/eZiPSiJ0iOthmzedP
	sTWM+Izv8HFZBvS7/JLLyxwWzS0OZGunyPQ==
X-ME-Sender: <xms:vYcUaHti_LkRJKjYxiVdA56Wx9FVEPr-kISRdH2v6GavkY0sLW-Cyg>
    <xme:vYcUaIeMSqxoGBcBh-5aUkbd8cfdm3wbACKp7k8QQ8WdegSFr2kaDvpiokFj3CJpQ
    8-fFbg3hGkaxZoL_Q>
X-ME-Received: <xmr:vYcUaKx30-vtnK1jY7kQYGewapDQkXFA5AXDDTbbbC7p9WGVgRQXodsdpe1EaA33RXBZO566m6lVkP0c86X5vWuaxhiQshMnFijg2Yptf3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:vYcUaGPoASb5-YshzBCdEi3_oh-36mGXK5_kCy1jEQR8FdKy_RaGxw>
    <xmx:vYcUaH-oIDc124gTk59DahVlXsaw-flh-faRlkeKXI9_UX58ec2_oA>
    <xmx:vYcUaGV0RMjakKstDPb-ErlJC7GJPzFnTSwWvo3fyq1yDtjcqrX7Fg>
    <xmx:vYcUaIfecRuCR_bLuM1fKE5go63guuGQpFRvDf1SDt9P7ZXWIXBj0Q>
    <xmx:vocUaDtWszUZaU9x0WgHyL7KvEqzpiI_rKzPbO43Aj1x83qQuuwFdKpS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:52:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb27a539 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:52:11 +0000 (UTC)
Date: Fri, 2 May 2025 10:52:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] config: values of pathname type can be prefixed with
 :(optional)
Message-ID: <aBSHugZcH8NusOcI@pks.im>
References: <CAPig+cQUycUyto6=cDadaCahzDBQ_GDngAEEtK0bshLr15ok8g@mail.gmail.com>
 <20250501214057.371711-1-gitster@pobox.com>
 <20250501214057.371711-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501214057.371711-3-gitster@pobox.com>

On Thu, May 01, 2025 at 02:40:56PM -0700, Junio C Hamano wrote:
> Sometimes people want to specify additional configuration data
> as "best effort" basis.  Maybe commit.template configuration file points
> at somewhere in ~/template/ but on a particular system, the file may not
> exist and the user may be OK without using the template in such a case.
> 
> When the value given to a configuration variable whose type is
> pathname wants to signal such an optional file, it can be marked by
> prepending ":(optional)" in front of it.  Such a setting that is
> marked optional would avoid getting the command barf for a missing
> file, as an optional configuration setting that names a missing or
> an empty file is not even seen.
> 
> cf. <xmqq5ywehb69.fsf@gitster.g>
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt                  |  5 ++++-
>  config.c                                  | 16 ++++++++++++++--
>  t/t7500-commit-template-squash-signoff.sh |  9 +++++++++
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8c0b3ed807..199e29ccea 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -358,7 +358,10 @@ compiled without runtime prefix support, the compiled-in prefix will be
>  substituted instead. In the unlikely event that a literal path needs to
>  be specified that should _not_ be expanded, it needs to be prefixed by
>  `./`, like so: `./%(prefix)/bin`.
> -
> ++
> +If prefixed with `:(optional)`, the configuration variable is treated
> +as if it does not exist, if the named path does not exist or names an
> +empty file.

I can see why it may be useful to allow for non-existent paths. But I
wonder whether we really should be skipping over empty files, as well,
as it may be assuming too much about the semantics of a given config
key. In other words, are we reasonably sure that there won't ever be a
usecase where you may want to specify an optional and empty file? And
are there any use cases where an empty file should be ignored?

Patrick
