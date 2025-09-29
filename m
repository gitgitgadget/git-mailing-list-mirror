Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9D2E40E
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184290; cv=none; b=p4mzjv0LzDr3eieKHVWERYjNjVzHKyB0m4xwbRm7q2mWkn2RntJAUZX7ISNS0rpFqc1x2oNT+1W6d67CkJunFZRny2FWgH31YKPcOiOHZy6SwuFecc1Ml858a/r9D1+egNk5JLaT3aHlbfTJvFgHVgJUCsbSaIbF6uE6EWG8UrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184290; c=relaxed/simple;
	bh=/JwJhjQxhXPsOvmK2kpIGZw6EhcbyKHhjXePrcM1VdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=unYdaLxL4zCzRh5Rq8D+B9LY0bSShRyBihxonbbleyD4fmB+YBpFTE1mn9J/U0ibPgXySYyXFwTn/YVw3WjIwZgSasfuUIq78BFRfavoD+L/QPr3eRCydOUGC8zfBJ6dBX++kbmIt9/MCi78vKFoPT+WsMViAiuFqFkmFV6MB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gIhAwWkJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wi6vM2il; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gIhAwWkJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wi6vM2il"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B3525EC02AA;
	Mon, 29 Sep 2025 18:18:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 29 Sep 2025 18:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759184287;
	 x=1759270687; bh=p8cBYxkFo2UF0ORPlRIQm1hlWMYIWeglSkD/Sai6T+Q=; b=
	gIhAwWkJiFSKRSwgTZKu7p0RJCPRPSKdejkHrcsbvchez4RRrO86xe1dFwRmQ4ZY
	BqVAkcVjDPqbKpj7TuuhQXVbq/Do6wMIoq27wKX7YF6ModxoJZ1Zh+fCdNYdPzNf
	Hds+Uu1bH2WzGLYT4yBlyt9M+p2v5cwxLR3dubCuHb864ARG1mqFtp5gXNegu4UA
	ciy8rmyTyHoDU8de3YBTckR1ERYex2turQLianTFm3Gc/+QuThOPFSrz96cWOqJP
	YZf6ILj0609vPA3xNUiB6z6OdqRlzZ6n3lOO/6y3r4+uqpWx6044TUPwzi9wuRJi
	c7JjXNYJ3ig1l1lPhQS7UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759184287; x=
	1759270687; bh=p8cBYxkFo2UF0ORPlRIQm1hlWMYIWeglSkD/Sai6T+Q=; b=W
	i6vM2ilSCfNU8MtD6kPIZVdIu5Sp0qYxNwfcIZFCw1rxvgoLZvG8FboPRFkoADlY
	hz+Uj8XzYFZiavp+YUnPKadN87zySuL3UFSXp+jG+f/+NQBa5oAgY0hlV9YFGQm2
	IxJUlTBy8qjFIAjn/fNrBge4ArbmU3TxxPSMOUtcWm8Xnl+BZSWXuz0dO9lU3a7H
	y6UiOlH19jpqs8hUka2aff0f7Q7dIGmlDUOFjb2MIShJajjPUMlJMg3LCqMn+q95
	/+ZggV7DIHfpFc6WSJ5fnUZEClAgiZmOkFW8G8gVATPoz47kqqWKePgTxJBJOgxy
	kkiya7F8z8xL61mwwJF2Q==
X-ME-Sender: <xms:nwXbaIwgX2gZUhY1ND__mVt7f4XHalE9FlGicb3U4cyqZQzTehul3w>
    <xme:nwXbaDRk_bNHasYbIRRYHP7PIRwSOcPV-7O4HMas-q6Tbe42egjPgwpcbvkKQZgvp
    M3Yil-Bm5MHQwd_YmQFi3LP-jiUaXtiwD4DMw2dCNEixv2bgyLJ_w>
X-ME-Received: <xmr:nwXbaPVvxDBskxpQbjGi0zpJh6PE9t5V6wPkehmET4gY_z5veWKVNHOZ3PFOxxiP1Xp-6HSCusyRR0Ow-tAL51YtTJz_PcVol5fl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejledukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:nwXbaFbXNcXU0jyEbvWBsOEd_0-VgCEWaNQptwDcBrRGGjlZa538Kw>
    <xmx:nwXbaF0p7RtDc0X8DZTGXXUVFdAEUtaXhBTaJts8hqs3Ymt77Fcybw>
    <xmx:nwXbaHh4dg0qS03davxFPp-J7gpwdFjBFTKaRC1KIsuhMjoYEyS2wQ>
    <xmx:nwXbaJYuONL3M9wzV3rwZrPZ1JHRe_Cg6hGO1ZAVPbaVuFxQA1Sihw>
    <xmx:nwXbaN8CaoEzetWdt9C3OtsrEbhs6BCiiyHmTKu3SKmmfVrLii5riLCN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 18:18:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] doc: patch-id: fix accidental literal blocks
In-Reply-To: <v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 29 Sep 2025
	22:47:28 +0200")
References: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
	<v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name>
Date: Mon, 29 Sep 2025 15:18:05 -0700
Message-ID: <xmqqzfac6gyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> All the final paragraphs on these three options are rendered as
> literal blocks. The intent was surely to keep each of them wed to their
> respective description list items. But the attempt at maintaining the
> indentation level of the block causes each them to be interpreted as a
> code block, since code blocks can be represented using indentation.
>
> We need to use list continuation (+) in order to keep them wed to
> their blocks.
>
> There is also an unordered list which sandwiches two paragraphs on an
> option. We don’t need to do anything about that since it attaches to the
> description list item without list continuation (i.e. it is already
> correct). But for consistency let’s use list continuation and an open
> block on it.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

Thanks.  Let me mark this for 'next'.
