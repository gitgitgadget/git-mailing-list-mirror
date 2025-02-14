Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244EB1FDE05
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572971; cv=none; b=ETGmj3pAUfCKZ8l9kTbxukzD2XKpR8KfJ0Ae1NFYSOlzeMxLBaiRcLuO3M8kWaUWSxRcq/IQmlVTKQFd/mHsUJRxu7GItchemRXvbo4RsHBSZFDFrBFN31FwIVrCYtj+pi8YRcIdtUPZQMytoi8fFk4fISt/ho9kdESeX/sOHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572971; c=relaxed/simple;
	bh=+LtF4YPIwuV+8hRhV3lbHosK6uytrvLruGSvi1+ozQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XgduUMYh1fmAIoQ+fT4uFzEk/S3SoGYRiYJYPE6vALtCIYGgw81wxxIpLz8DDwB4JMZ+ZpR2l2YiCNFztlLnLHtjRs+XFyp82dWsSwZIVFO0h9y2qmSMwqgWyxgQX+xkfxJimE/dQdGG2+DxKH6qbzPuQ7D/Y00cH2FMM3pyvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g9QlBajb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZSbLXhVC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g9QlBajb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZSbLXhVC"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2804513800CB;
	Fri, 14 Feb 2025 17:42:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 14 Feb 2025 17:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739572968; x=1739659368; bh=QYqbXmkpc8
	J5DelloJ3SYvgx4ftFRBSxwkRW0QvbAIs=; b=g9QlBajblkgRRX5a1BG8a3y0gZ
	n9Kdpehpfud5Urp0FtVq66MqUi5xNBTa2tpaSI2RaFBLuWW7hhenFi0BCzzuwATK
	LPvA37jw09AjNIwRuRi3A7ET3t3sI/D2OLbWHxxPkkRZ/OYCzQL9u5pSuDwpdgqy
	6Heett6RJmv2Ogufu57D6a7F8SK7YFPbDJXLGe4XWqJ1r7izkS/toi6wVS0ydU41
	IG06gm4GWzcsavSZ045TjkyUX1Mn2BsD5nplDzRjjF2olqbtK/frLDbI3z27yh/p
	DQP23bXXsMx8Qi9j5yp7rrRaZ5G+iZNdAEbo3RUxeS6BK+33mbbtARYYr6+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739572968; x=1739659368; bh=QYqbXmkpc8J5DelloJ3SYvgx4ftFRBSxwkR
	W0QvbAIs=; b=ZSbLXhVCkmPqAhhoHu8qMWP1SEiWLDmmupbq4EMKlnecgMPaffF
	3bexdZuDK4Bwnz5CJVoIVPFhNYA+B0bPsIWHkrcBWlIbnzK6SklfNgOAqX0g+kJK
	Ml5fXF8+3AZLXOPjiqng9pdq6dzrx2upQHTYQmzHWNCFgVGxDjis/fuWwTvhBBpE
	XHf0HMNx5lmWVO5xn3erCsZjWbZEzfkAV8EJHq2gQ2rixKFkETOy6weYK3TnFZll
	rYBV82xuFL1eJsXLjUkCmaNarNHzR2soZfrUmzP7vpmkCAMnryZ/Z07zCmT0kFQq
	kDRoBr1nTrmKp03Pkx6IYbOFdkZakuNnVSw==
X-ME-Sender: <xms:58avZ5F_8asHpHkAp5lH_DLAq7ozrMeF1W6QPzfHu2daMbZml6xUpg>
    <xme:58avZ-WyEc52OLyUcBb4_6M9yCKMML7WIJENDe1nCpgnoBKW_4nWyphTn8t2-uf1p
    bscaIjnj1OJMJP2IA>
X-ME-Received: <xmr:58avZ7JBvxxCaq7J7rl60qUm2gSgzgxD_5-K2SLLTpV3y7nLheTJ7YweUZo01EjHXeL3c2kyWf8ZRp2wQ2LpF4ACeJ4AJV6azQDlrxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegruggrmhesughinh
    ifohhoughivgdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6MavZ_FQcEM-QTTrwAcKEDH0HrQe3Hq5cv8ex_S7UbAXaayrsw0Kcw>
    <xmx:6MavZ_XA-ncvbbU7ttE_B1FYnlLWq5Ec5l8oanCMHM9qACoJYt4Esw>
    <xmx:6MavZ6Pi4jfUVjE50-SZNFj18ghaIUGuvLK-iJERVPnwj_nl2fd8dw>
    <xmx:6MavZ-2CGl7IXM_7oqqfBkScQY9rEwJeeis5kqc-jK0SG4lI0b335g>
    <xmx:6MavZ1e_kpB4njKjicopkKEdft8ruTCTKJOg9zHBlZkniim4gG7j8koL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 17:42:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adam Dinwoodie <adam@dinwoodie.org>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] Makefile: correct default docs build target
In-Reply-To: <20250214215717.2854453-1-adam@dinwoodie.org> (Adam Dinwoodie's
	message of "Fri, 14 Feb 2025 21:52:55 +0000")
References: <20250214215717.2854453-1-adam@dinwoodie.org>
Date: Fri, 14 Feb 2025 14:42:46 -0800
Message-ID: <xmqq34gg172x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adam Dinwoodie <adam@dinwoodie.org> writes:

> Put the "all" target definition near the top of Documentation/Makefile,
> so that attempts to run make in the documentation directory actually
> build the documentation.

Good eyes.  To make the intent even more clear, please adopt the
trick (or "convention") used by t/Makefile and our main Makefile to
have an empty "all::" at the very beginning of the file, instead of
moving things around, to avoid this kind of mistake to ever enter
the repository again.

Thanks.


[Footnote]

* If existing "all" targets are single-colon rules by mistake, they
  need to be corrected.  There is no reason why these phony targets
  should be anything but double-colon rules).


>
> This seems like the expected behaviour, and was the behaviour up until
> a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
> 2024-12-06).  That commit added some config files as build targets, and
> put the configuration in a sensible place, but unfortunately that
> sensible place was above any other build target definitions, meaning the
> default goal changed to being those configuration files only.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>
> Sending with my apologies to anyone who receives this twice; I made an
> error with my sendmail configuration, meaning servers checking the DMARC
> records would have rejected the previous patch.
>
>  Documentation/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index aedfe99d1d..31f40b6f37 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -3,6 +3,8 @@ include ../shared.mak
>  
>  .PHONY: FORCE
>  
> +all: html man
> +
>  # Guard against environment variables
>  MAN1_TXT =
>  MAN5_TXT =
> @@ -238,8 +240,6 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
>  ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
>  endif
>  
> -all: html man
> -
>  html: $(DOC_HTML)
>  
>  man: man1 man5 man7
