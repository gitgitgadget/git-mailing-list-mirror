Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213AD26E164
	for <git@vger.kernel.org>; Fri,  9 May 2025 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746773513; cv=none; b=o733Gm5xDJ7hZMW6xnBB0kF8LdlbKrfnCvbGOaKykWixYiBVmwG5ew2eIKklqqwWPxhxj0M+HV/ap2yQNXyhljrsKa9Ver5t6qjf4PqKYhHCBwUBVvndbtR6ph380gkgLbNi73bVYd/OFFwlpALWMqoS2OZpVYyTaH0PoY2OAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746773513; c=relaxed/simple;
	bh=6RrwUXEbNPOlRBdk9pmjXj5pI2Is3uz1NRVjFdekpuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do31vXAhu9rZfbNqFmRGuyBsbleqp1dsdl7CUusNlWmGcyz+in/rs4dhY7Rt1eHIRBdB/rg8FS4c8n02cLi+NytwBXGizbYlyXCn7xAFaHFffR2BExuqghJxka2j+bWOwvjOMaeWdq/4E/iktFDyqcz9TskK0TMBFL1xskRyyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wZg0QuPF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MGWCfc9x; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wZg0QuPF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MGWCfc9x"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0244C13801A7;
	Fri,  9 May 2025 02:51:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 09 May 2025 02:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746773509; x=1746859909; bh=6Qu5ULY//F
	IOQZZQb4BM6nkHomR/jP6Z55Smc7CpBiM=; b=wZg0QuPFnBLRvd4nMG8wLnf8+P
	1idGPlbm0aVAhHHNLJByUaKRSY2ZRoGwtbmN7BJdzHiZUtnpp+oez3jCYpS4sFym
	7Q38Ok9noFoXtP1YTJ0oR0rpMbruSn8JZCeiq43JuwILRNJCuqavWtow4kwjs+L1
	fXQYDcOA8VjKOn0vWKbPR80z/YYFLlHnFtW26miOp0crNmTpItWLrlnU/wgX/9y3
	Eff83H/xHlSTA9b/pH9xlzCQg0HHsLX1sJkczkE+Pv6rWCZHLo2IiGHWo97TPnt6
	tIv/uO9bV1ogtjHuK5wU6XPaelTxe1EV3SvvtW+cRw8wy8jh2FxG0+qnUoqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746773509; x=1746859909; bh=6Qu5ULY//FIOQZZQb4BM6nkHomR/jP6Z55S
	mc7CpBiM=; b=MGWCfc9xg6sJ2klbQmcayZLWpK5K0Zn4Z1SzGpCu8qZg6gF9k6x
	EpKrqRi5RUnDenXXYKWINboMcjNrXYqtXjvtWOCI5sbRUxPNouN+Cra0vmvhNs7I
	mGdWtkOjZMK4pXOVWsWfbzf9MxuDlNzkACFMHIZVhKdgo3cun85a8DIsmAY8S68F
	r9N6yDv70UpeTyV0ZY6/ojhaoFfJpJ01j819gBSgMnlZwRQZXUKJaLjbdQEY0qIK
	+seTIW3+YNWfyDEjcrJdNGwaCshBQoPVZVwn9zOn5FNDzs4O1giaTx7MyMQvO1fj
	dgjNGJHZUA3+fXD2IMV2Z7hdSe0BsM8f9HA==
X-ME-Sender: <xms:BKYdaFeQ2ElwyTwiz0MjZzECrTpZcr1qo72tHM0XoLB-HHNBx11vzg>
    <xme:BKYdaDO7Dc3y7lJmSL5ILYTbMWFuw5ljJ3kURq8iqkD-tCbML1P0O7QIvkhHqhSpE
    Pa4PHtcZsFOtcVR_g>
X-ME-Received: <xmr:BKYdaOjebGnigkSImI2oYrR_zASD4P1EQmLAJ8e89pdxq7ezNySuf_3roNsjq5xmJHFu0yFwNbg1v67x18pHyJ7FDxwSUJmA06PasSasEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtg
    hpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:BKYdaO_EYqbEvIMxocU7_Vg2iknfI4miibTNXjBt3v9gxNUbIAAQ3g>
    <xmx:BKYdaBtYlJ_ZOYO8rSdPl3WiS5AUais5FrV5TGLpZJ5-eXqOTSqhnQ>
    <xmx:BKYdaNFhHF2SbPKu7zr2mBiaTyikKkx0ncIJY3CM13DRRNaYToPXxg>
    <xmx:BKYdaIP9QAJPgA9nTLk7gyyPCROZs224qG9W8Zire_iFEofMzO-fNw>
    <xmx:BaYdaDQ9EDhnfCXUiQXnfzqdjvgMe8fdUiUhuR29MUVYA40GmP4HS6Mv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 02:51:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6398c419 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 06:51:46 +0000 (UTC)
Date: Fri, 9 May 2025 08:51:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2] REFTABLE_REALLOC_ARRAY: remove this unsafe yet unused
 macro
Message-ID: <aB2l_WaBFyz5POld@pks.im>
References: <pull.1955.git.git.1746711583166.gitgitgadget@gmail.com>
 <pull.1955.v2.git.git.1746756263207.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1955.v2.git.git.1746756263207.gitgitgadget@gmail.com>

On Fri, May 09, 2025 at 02:04:22AM +0000, Lidong Yan via GitGitGadget wrote:
> diff --git a/reftable/basics.h b/reftable/basics.h
> index d8888c12629..667feffd935 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -199,16 +199,8 @@ static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
>  			(x) = reftable_malloc(alloc_size); \
>  		} \
>  	} while (0)
> -#define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
> -#define REFTABLE_REALLOC_ARRAY(x, alloc) do { \
> -		size_t alloc_size; \
> -		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { \
> -			errno = ENOMEM; \
> -			(x) = NULL; \
> -		} else { \
> -			(x) = reftable_realloc((x), alloc_size); \
> -		} \
> -	} while (0)
> +#define REFTABLE_CALLOC_ARRAY(x, alloc) \
> +	(x) = reftable_calloc((alloc), sizeof(*(x)))

Let's avoid reformatting unrelated macros. But other than that I fully
agree -- we should remove stuff that we don't use in the first place.

Thanks!

Patrick
