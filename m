Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC01CB508
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567550; cv=none; b=DWCe2G5NsAbCCS7aIGPatsnriBNurCwdnqIcDmADImGYa7ru3HnUA6FXn4pyPoIDEdtbgnHRSacgrcK4S7TAHD57AVQlxaVbnPyd+YqDWZDNiNsxg/nBvzqE5DKpu1Ewmr8Mb+8VoprpPU8bE0ffOJzdGogaQKsPLCHZiq0EgYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567550; c=relaxed/simple;
	bh=Wd3G7XrkGtjYx/+3yBPRNfyzaiua23r/l1U+8ET89fs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=W/foEK7S9VIhh4yzwgguicYiCHWLKqS1aFVC9BMb34MmiruRnpFY20ypll3CuSMiQ6Qhotvj3BdlzbWRhrcP1b+i49Gn5AHaS6uxw0ViN2VfDbb5HqkcstF7uIjaB29YrFxCQacLpoIMBKMOZCmzPqlnpHkAdQk2BZhAnaSV5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HXqtvWtp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cZvCk1dg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HXqtvWtp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cZvCk1dg"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E8791138028B;
	Thu, 10 Oct 2024 09:39:06 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 10 Oct 2024 09:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728567546;
	 x=1728653946; bh=XxMnmlHZwdWcDAZ/QflHXmafdOwYT5qrobLdhsC597o=; b=
	HXqtvWtptjKVhAP194qCdB0XDE0s/vRQnsNLyi5ElOphYss5myvLdv/0xmtUSCyO
	768vdINr+N0l2+YoG/geb/Sr9fxMNL1afKUlRlUiA42j1pelrNpDMW3S7Qt1iRqN
	ZQtEulkwnj8NKehKc7hk39fYt3OPEg2dbYtn50xYdO2g4BV4F3WW/rw2RiPlnyuU
	MJepWsRBAEqErFhVBI4emdy1CE0E3lweWszwgARMWdgVdFwCw4JQMZeQn2PSC65W
	vO5FRBC+0GqWXYOVZoPJ4Wk7UPyY9cAsK93PY1pTwO7RzWSQLrNQ9+EApaAyE4oV
	j3Dj5Ini0X1k0dwU5/JinA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728567546; x=
	1728653946; bh=XxMnmlHZwdWcDAZ/QflHXmafdOwYT5qrobLdhsC597o=; b=c
	ZvCk1dg7XiMDP6Kn18fMYd7R16FbuvpHX1ig7hfHmXuVn4rO1bRj+phEV/Almcwm
	HXICzvI2j839bXIeOCB1tlhEfVRGM34gHGNyNWQ+Q+Iu0o9b+a+Io79T6FZNvOrC
	UAv2DTpUa7u+1g2BO2abD87G7qTlqi6G0vB42OP9oH3JSMhbUtBx+ouNY7DsO3E0
	ekSTG5gIVmb3vmmF/BHpQ0XO09ehH/PP6coPizOJYfde8dmSM7cYDMG10bj5Xsc2
	SUcGm0RFeZ2VIcEKzD6O04mAhjOqri8H4An6HsisSxbE6Yw933TSEOlb7KsEHFPz
	/W0bSadruTRmuBcZx/FVQ==
X-ME-Sender: <xms:-tgHZzlSzEVr1mFvz6yNX0dJyI3XXNiOoDGRlrzOr8rO-XI2yJF0taI>
    <xme:-tgHZ21UYMyJ1ymFoApxpqXHOT4atFAzYxRVwzFQ2q7V5ZL2tRPDvNs1Lu3KX90Q9
    8apjLaG_Nfp-YMJeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeduueehtddutefhgfdtgfeiheef
    veelieeltefgfedtieelueejteethfevkeekfeenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsuhhpthgp
    gihinhhggihinhesudeifedrtghomhdprhgtphhtthhopeigihhnghigihhnrdiggiessg
    ihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-tgHZ5o4uuKJOfnskO1JgChdOwGr1ejcBNzcKSRaYovI3g4QkWpYTg>
    <xmx:-tgHZ7nh_9bMm2OV1h_K8IQp8jI09mRSxvz8iT7cZ5yDotln8MX5Cw>
    <xmx:-tgHZx0WjzBPatLtYE9dXKkPAheuJsasQGgrHjs5etHtaP7EgDVx5g>
    <xmx:-tgHZ6sUbUQxLIlxpgsHvGZcOjqMfOYJGSCxgWJ1Lbj27FbgMHoovg>
    <xmx:-tgHZ6xERalMn_LvTXBGyJ-dvzy07kxnk4bYWTK8NDR14fZ4_PyCH0-L>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87F4E780068; Thu, 10 Oct 2024 09:39:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 15:38:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: blanet <bupt_xingxin@163.com>, "Xing Xin" <xingxin.xx@bytedance.com>
Message-Id: <12469838-46f2-474e-bc0c-8e3be37887c1@app.fastmail.com>
In-Reply-To: <pull.1807.git.git.1728566443089.gitgitgadget@gmail.com>
References: <pull.1807.git.git.1728566443089.gitgitgadget@gmail.com>
Subject: Re: [PATCH] Documentation/gitprotocol-v2.txt: fix a slight inconsistency in
 format
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 10, 2024, at 15:20, blanet via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>
>
> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> ---
>     Documentation/gitprotocol-v2.txt fix a slight inconsistency in format
>
> Published-As: 
> https://github.com/gitgitgadget/git/releases/tag/pr-git-1807%2Fblanet%2Fxx%2Fdoc-format-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
> pr-git-1807/blanet/xx/doc-format-v1
> Pull-Request: https://github.com/git/git/pull/1807
>
>  Documentation/gitprotocol-v2.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
> index 414bc625d5d..ca83b2ecc54 100644
> --- a/Documentation/gitprotocol-v2.txt
> +++ b/Documentation/gitprotocol-v2.txt
> @@ -527,8 +527,8 @@ a request.
> 
>  The provided options must not contain a NUL or LF character.
> 
> - object-format
> -~~~~~~~~~~~~~~~
> +object-format
> +~~~~~~~~~~~~~
> 
>  The server can advertise the `object-format` capability with a value 
> `X` (in the
>  form `object-format=X`) to notify the client that the server is able 
> to deal
>
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
> -- 
> gitgitgadget

I can confirm that this is the only heading in this document which is
like this (setext length (name?) is not the same as the length of the
title/header).  Also the only place where the title is not flushed to
the left.  Well-scoped change.

-- 
Kristoffer
