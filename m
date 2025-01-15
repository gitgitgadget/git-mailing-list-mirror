Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7E1DC988
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736984819; cv=none; b=oerXCmeAC4ywDt+iCZfIdtYOlgXaVq7IEX1LjbhfcqBd6UvSLr8QDw95N4Lc8oK1XsukUxsiClX3JN973yE34+mjM1+0JCwLP7h8FjgNYhb9CQQe37U//t61O618jKBaU9ePl1r84TG/QRRpv9dml1lyZYdH3I2dqZ+LfK9TWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736984819; c=relaxed/simple;
	bh=VgOyNkla/L0VftASXFDsJQnSs9QYLcOPkcU33mT4+1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UAJhEt2C+dZEDV3ICTGEncHfbBgXukNNftdTmNmmW9OPhbhcHsKk/At5Gd4oj4ir5t6hf10dUBOFb851B98I5ZhIGox70TCa5E0FsGjwf9B2Hc6imz1NCQW2xDT2B4SpEx+9TxkEOg2ug5LJB66HL4KWq2pRWaBlBWyajMk46CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WKP0ZRaD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9wzVGrH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WKP0ZRaD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9wzVGrH"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC7FA2540162;
	Wed, 15 Jan 2025 18:46:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 15 Jan 2025 18:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736984816;
	 x=1737071216; bh=An3300nesrTuNsP87g6K2FcIo9JPcOV9UjwNUOOaYI8=; b=
	WKP0ZRaDb951PvZQ4u2OhYfpYnR7PDZNDiiqW6yZMTF1E48q6q8ioiDa9aDLcPAm
	G1S2MtD6yDorpxOmc+rQOFu7gUAxCZ+0sS0Q8tbepvebtwS73dd4byYF2S8s1h7N
	HAJfDLb6o08JXzuvlRLKTDp7lhUtGuEs1qiv3j10tAVMt8y61+3Yk1C9mNSnQGlq
	fdXwDDTuPVLO2MmS0AUIseTzEDVAAmDFD6SRJbhwbqWIxHQrVz6Zk9OUVQhn5wmx
	pG2AHBRE/K3vvAH2nOzrJxdj8zs+VsUbfxubmC6DLScVZ8BJ3TJMd8Da3IPnY5ll
	ICWjObD6mcBjNwYeQntApg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736984816; x=
	1737071216; bh=An3300nesrTuNsP87g6K2FcIo9JPcOV9UjwNUOOaYI8=; b=J
	9wzVGrHcqs1iwJcgVfPLxJ0DNENx+CGyA77VGS441WzUJtl+x95t8O6mPVrn+yM3
	9VMXwZQyugFTIzRAoQmxk+agn0hD6st3bRVW1bKFVnnjr7NAsOuULu3rTawjtFL1
	RpNKS8Yykiwt0Q/x94bAQzDWsiHUVCjTs65ZYnUX8zmoIzP92VKy7VQxwDRhmgzP
	5NFbuclQ4qOBu2YhhYaDZz81yuUKDei84XFYciVqxJHO9e5O8GdCPxifcnWnRnrW
	+RIpNWhwWqO8B15QwVc60wJLCZITled42CZgOG73uyQNnj3u/JGJ/zZ6KJbkZlG7
	o4AQhnOZrnykuGuZSIVyA==
X-ME-Sender: <xms:8EiIZyPcKdyt1l7K80CJn0iBbKtnFtDXGsOhwwC_bxEF5Kwj8-RbIQ>
    <xme:8EiIZw9J1Ovyp_-uInFqD1DCwQ6OeN1ZGhCvAbeOOLkBIsewAPxw0xPIufo0cO7D_
    SA10t-lw_tudDY0Dw>
X-ME-Received: <xmr:8EiIZ5TtOnbo5i8ad54ExdRmu9IHk6cPIfcONHGarMuv-IggNYirxRBIgsGBC2UTs6RxVNwIFlJVqSuRmky4SAjUIWDbJjMPJVuK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrg
    hvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:8EiIZyuM3elAN3IbmlaNe-TfeuIQolJSl9ZACGMqnHNUKg77ro1vMg>
    <xmx:8EiIZ6cUK10lINJ80qhd1pu-FBypY-0ngloewbFQV4ohHQcqU_DqTA>
    <xmx:8EiIZ21xwLws5MymwEKzRzuCLEvuy01YPWQ8KYGj07k2W3jhRawnIA>
    <xmx:8EiIZ-_K8cxtFCnkB-r-J1nh4_K8rYu-VuR_EKINRkxVbef232orVA>
    <xmx:8EiIZ3E1StBU65TfuDpretRiC3Wf4cKnxNRDZdNmfRGou_46hX0z3ubw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 18:46:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 1/5] doc: apply new documentation guidelines to git
 commit
In-Reply-To: <91cff84b5f8d9e1140e94dd96d259224ea905611.1736972628.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Wed,
 15 Jan 2025
	20:23:44 +0000")
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
	<pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
	<91cff84b5f8d9e1140e94dd96d259224ea905611.1736972628.git.gitgitgadget@gmail.com>
Date: Wed, 15 Jan 2025 15:46:54 -0800
Message-ID: <xmqqh65zvdw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -[verse]
> -'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> +[synopsis]
> +git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
>  	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]

It is already nice enough that with just writing [synopsis] we do
not have to worry about backquoting literals emphasising
<placeholders> and other mark-up minutiae.  And then ...

> --C <commit>::
> ---reuse-message=<commit>::
> -	Take an existing commit object, and reuse the log message
> +`-C <commit>`::
> +`--reuse-message=<commit>`::

... we also are freed from the same worry whenever we use `here are
things that are treated pretty much the same way as in [synopsis]
section` notation like here.  Quite nice.

> @@ -507,12 +507,12 @@ COMMIT INFORMATION
>  Author and committer information is taken from the following environment
>  variables, if set:
>  
> -	GIT_AUTHOR_NAME
> -	GIT_AUTHOR_EMAIL
> -	GIT_AUTHOR_DATE
> -	GIT_COMMITTER_NAME
> -	GIT_COMMITTER_EMAIL
> -	GIT_COMMITTER_DATE
> + * `GIT_AUTHOR_NAME`
> + * `GIT_AUTHOR_EMAIL`
> + * `GIT_AUTHOR_DATE`
> + * `GIT_COMMITTER_NAME`
> + * `GIT_COMMITTER_EMAIL`
> + * `GIT_COMMITTER_DATE`

OK.
