Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E39EEBA
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425186; cv=none; b=CQlmcMqzyPIpcfp9mbtgRgk+eLyu2khXKtYVyir7pbVR3xtCtUlzv3YAbdlBr4TqwYOaLM8RIG6Ysefeq9854KEaFcBuSevvhCw75VKaTsfqKE32i4FlUSlk1lk/pfr+a95PEnIpd7uv5eJjiiJ8yGRkS2R7Uwm6O2sMtqp1CFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425186; c=relaxed/simple;
	bh=pqi6A58cOPMgsF/tDOK3jE2DF+pTlv5BVfDOj8Ot9Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIi8HECCh5sBqRoKbyhWwA+DeD0nipGyqCxHEFdJN9gbGFtCfJ41bOhsDK6FWhnuB/PFyV4sNUDhZ6NrQddcTVLuE+I5fmSzoQnFeha0S1qAtqj7SWgIptJwtsVhPBlm5lUeFgwu9DOatWhZ0xV+G6Mg+A1IQFHt3bdVet0XmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qOB3c+pw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wJdMlJRo; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qOB3c+pw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wJdMlJRo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C26F925401A1;
	Mon,  5 May 2025 02:06:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 02:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746425181; x=1746511581; bh=JqcwWRya6W
	EsYTPjqH0YHfRultmBL2NzcnFJdMlTurI=; b=qOB3c+pw30zt9HtG0LnCIThfQd
	/d9v8h6+Z7rzt4UBTWeEdc7l8VAjNNZcnM3TRD2u9m5ap/MWu+4aCwkWHM3UBRLt
	D3IGQyKOza6K36FnfOZl/5moQNCNedY023NNVhVTQHN5lVL7eQPcERmqmHVamRNR
	j4KXPkbdlVdndsYUPnm6leV5Bgdfd8Ajm/oUkpf88VZIlGUQPtxBibNTb9D1jEK5
	5Trl2TIaAozeupZ97yGy7vaW6vylTWfeb9pVLNWNO+hpIQlDOzNJX6JxttRAtJBD
	mNJCX6CrUuQyoEYj8KGr4F+75rpgH6tz6X+YlBzESJssFENt0phWC3S20AiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746425181; x=1746511581; bh=JqcwWRya6WEsYTPjqH0YHfRultmBL2NzcnF
	JdMlTurI=; b=wJdMlJRoiybLi3Bk8Iz1xaw/NfH05C8bF+DsldOee+F/GXHuvm7
	8f6oyslnMr/ZRDemBAxGUWNEx0VXGeVJLFFwgqdCoi1lvagUSNvXG+S3LMo6Fygm
	+cTyG9qyRDRIgCmSKKznaHYa95Wxo9MdJp9qGGOoG3XaBPonG2QXHrLzZzhBpWYF
	HswVqvxG2DYu2hGizS0Ne3HEXo/C42UZX+AP5cgHUfj2QSU7PZfgqkmOB/xXvVEj
	/U6/kJ/ETjBINDTk6EDzSllLh0Tr6jp3XOz0P/poejn6x73V5/I/Og4BZiWFAkL8
	WIuprWJobf/0EpLoGt4/gD6Mf5ftRxdo6xQ==
X-ME-Sender: <xms:XFUYaMaNK4alYTwPlyNxVgMrIRVI7hsFzSk6VWXfCUnHxV0LwaMxXQ>
    <xme:XFUYaHZdafBjInnkm184Cqxpcu_kEAxeqIn7I6fzFFFYvsQVHCKnzyv_b3MSRoRRK
    3-zpZmPS6yHFudLxg>
X-ME-Received: <xmr:XFUYaG8n_Xoj2PfAsDqDjQAySeWB0FO4HIIsQ81v1cFyYHBYIhfNf389lxYrWZPoYBMSP55NV_oBNPIGaoT4PVd2F1fdGDI7AlcjOIGC8fQjUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XFUYaGrwbrAvMgFvvGNay8th0oIwIg5b42yTWwPmvHeztt0pYF52hA>
    <xmx:XFUYaHpdN5XWyTiXObzE7zdiA-cElqiyNUHkc9wsQ0WcRkjUxRBMYQ>
    <xmx:XFUYaEQF7b8XdrJvrXYSOwtDwmSY5VpeawbkndNwmSZSN5QTxcORag>
    <xmx:XFUYaHrn8-9aEwuWSaZxEGMgwKNx6YugAu2sEfav4tiwSw3yrFqcZQ>
    <xmx:XVUYaCOeQBZQnvXoro_TulxIc1G7ScOShrow-7R5J_gC31T33G7-f_qX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 02:06:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1854c9a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 06:06:17 +0000 (UTC)
Date: Mon, 5 May 2025 08:06:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci(win+Meson): build in Release mode
Message-ID: <aBhVWMabOFYRUjvD@pks.im>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
 <pull.1908.v2.git.1746282346370.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1908.v2.git.1746282346370.gitgitgadget@gmail.com>

On Sat, May 03, 2025 at 02:25:46PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Changes since v1:
>     
>      * Rewrote the commit message to reflect that this patch is still
>        needed, even if the symptom that originally motivated the patch was
>        addressed in a different manner, because it was merely a symptom of
>        the underlying root cause that CI builds should not let Visual C
>        build Git in debug mode.

Ok, makes sense. I think we should ideally address this issue
strategically, e.g. by getting rid of asserts completely in our
codebase. But for now I agree that we should just build Git in release
mode on Windows.

Thanks!

Patrick
