Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AF2773E4
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148619; cv=none; b=FiN2i8T6dGCUIwD7D8/XI8FdetxomsW+BSwZSegWgs/bpzOWhOGCoUui/vj4qXYFVEL5jabxY+7rQRX+7GOdGWn5hCBJ0v7jQegA4Vr7u71h6K3hkqMDhJ8mln4W0+j5fVNOCO4X4PNZ1Vjo7FOxzUIrGxmJnK36GwazLMW0cUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148619; c=relaxed/simple;
	bh=B7Jfn2g6SHmXqvCmP7H077KEk7QY2+PxxoCly1MLCWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2rOARms1i2FShhe8HGqzmQpAV2aPBlVep5yU3obbFqMk1TTl5q6PTgO8kR0XEVOhgviNjXR0vi5VrWqVCMHPEHknuSfgHlWdeqd9nwFV5sswQYLtgAznRLho8AnhxzU2PcQloDQF3fcD9OK8Y5pUnZsiCUtp9dXqquAA1zck/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DAdDi0e0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5CWALxoB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DAdDi0e0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5CWALxoB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D388EC061C;
	Tue, 10 Mar 2026 09:16:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 09:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773148617; x=1773235017; bh=lXc7wZQ6ng
	nxus+8NfDPEoqefabBrsQuWPXJEtUR1Mw=; b=DAdDi0e0AQ01fh5DpXbFtYQg6P
	e/zA0tV9jSVFXJzIkKwgOnfkHPOQCCDdLbZg2YEAZjqZmTjXdRB3uDGuATEX3kYU
	wapMfkwSdzydr+RP9oMK/5dc5etK2ySJSDAPkCHoVUdEfhH6Y3Gz7hlfrHV3F8tr
	qijpvKrXB8mowlSnAO+4bCR300Ly13wSVdGSJ2y7yEvZl/eR3nZAzp8GUwqqn44C
	kCrDMKSwFawN5/El5xurWNVCWKDQRuovDirteM6L96C9vqse+RlbV0JMMc2oq5Gb
	TwiI97Qs1cftCUnZ7OruPlLZ/ARe6Z3rbu/GB4qFsGrfYD/ei0QEBwsWJnYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773148617; x=1773235017; bh=lXc7wZQ6ngnxus+8NfDPEoqefabBrsQuWPX
	JEtUR1Mw=; b=5CWALxoBfrMqxNn60NhqVgat1Jml12zvWEJmpfvIWeHeyE29PDT
	vHp4yaVuKb0YQyVqEVSeE0K+IybosZbQu854t+IGJLFOdUS1ZAiYSv5W+sXq+KZP
	JNeMpe6Ie0ZHXiLjH4aBLzWlY2HIJJqr/LCKIxa2vjJhzECFh9iV4aWi0v7f71VE
	8ywRKsMJh7jD4JPIutasA+U7lI3z0wB6CqMdtYUHZNeq7o7alvvvVAMXx3SkOV49
	G9TFoWQBOqhIU/veIlOUVu0w0lXbMNQCtG3++uFJDaaU6ppJZGnY7DJSZppDAOg5
	3sLzhiZVzQmD7JGvf4ORgO9QknV9tR4m06Q==
X-ME-Sender: <xms:yRmwadiyj0S253saqTSAgUazQBO9seLsrHOlxO55t9ABp_LaUz5f2Q>
    <xme:yRmwaZD2K95sSmXVDrqwBJZSeQPcfC1IDV40H7YHKpngrR1aEjPaOF60qdf4aLWjo
    SJ39iwzmwUENPmPUubPrJhXF6V6ohE2VsBwjXCk-DNLUEuTIBsbbQ>
X-ME-Received: <xmr:yRmwaSFp57IaigTx2QlexPOF4RE8SziDmtWjZCaoP_9ac1PVp6Q2gsqdyp3WLZsF3bgjmAseJRbVJLIpTCxIHzNVDMbxQgmU99V7AgnF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghrshhhshhrihhvrghsthgrvh
    grtddtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:yRmwaRJ3h3Y0iOjZwdxg1D2Yf18J4qX_8E5Q4HNV3T_A28W_c0DlQQ>
    <xmx:yRmwaWkUgTrO9tiLrmXyj1PW-VGxLxbBvf7B0Ah-5ZCOzq2_WDvhjw>
    <xmx:yRmwaZRUrg5DfiyyYbQDF0_oZ9l5YumbiEharOyS6Lv731rey-1Bow>
    <xmx:yRmwaYIOkrh9_YbrXxKXBE1fLhEHKBe5dsH7bv_wpLgs5ui9fwhu6w>
    <xmx:yRmwaaZNvYMlYmqLy0zIGcq1GSOFB-YQN0M_IT6hyXs2qTCdnuv02wS->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:16:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f34ace7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:16:54 +0000 (UTC)
Date: Tue, 10 Mar 2026 14:16:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Arsh Srivastava <arshsrivastava00@gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
Message-ID: <abAZw-Z1mKf4tAuH@pks.im>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>

On Tue, Mar 10, 2026 at 10:59:24AM +0000, Arsh Srivastava via GitGitGadget wrote:
> diff --git a/advice.c b/advice.c
> index 0018501b7b..e1264f525c 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -81,6 +81,7 @@ static struct {
>  	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
>  	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
>  	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
> +	[ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
>  	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
>  	[ADVICE_STATUS_HINTS]				= { "statusHints" },
>  	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
> @@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
>  			    "* Use \"git add --sparse <paths>\" to update the index\n"
>  			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
>  }
> +
> +void advise_on_checkout_dirty_files(struct string_list *file_list)

Huh. So this patch wires up a new function and advice, but we don't ever
seem to use it. Am I missing something?

Patrick
