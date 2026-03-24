Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE3386C07
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339175; cv=none; b=YBaUF/q3s1iKuVfPBI5UCNkpJiDJZSpdN984haXnEo+fl2y8q0T1nYPGEphAFmuozlfvBgAi2UeIqCSXNoYa/BJ3HbQwX95W5LO6Bjehl61cSTbgQjydsBFeWZ9GGMSklUJduzoRB30gZca1daoOas85optbvV3m8V1e2AATosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339175; c=relaxed/simple;
	bh=g/qp7LtXawI+pzrE2lfS+nrmWVnDS5ISqit/HuK3g08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f51+Qi5ZtUl0eg/inb25BR9KbkCI4ffTVUVySeBlIWOX8atMkimwP1LpogLX7DWWyRrljxHmRXZf684Eryu6TvWD16y1gXvzQ6C+uQ5+H41CCeR+FtTmqXxBtsfeuvpxOKbjjiCp9z5vGn/gu+Ju80VALYuN9MTVFU+2mP/Rx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KZ7UKRCZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n50W5rJJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KZ7UKRCZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n50W5rJJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2BC414001D1;
	Tue, 24 Mar 2026 03:59:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 03:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774339163; x=1774425563; bh=GAE3GLEU2V
	n4qykngPo8css/RqEk7oYVV+UCba8XTQk=; b=KZ7UKRCZPCpdn5zJNZI1Vgqq6S
	jJt1th9+JywaTOR0ojZ0QvX42TwmJOlaWNYYB5+fUPd5y3mNXFl/4GSMe9BGfKUN
	6Ek5FqODVgQIy261jookOaeLFOGpzE1YCZXzXJ0zGlvau17LY8JEAzavXCUh8xGz
	YKDSp58mIdI/iR7AV6oKCQQH72MePWDE4o+AZjdQlLPat96AShFQYnQrMnn4UxGy
	5+L0x5GveytSIwXLwAtAqmm2d0r36aSmkRC1Wifdlr77hUnyRR+zwA8ftSyTy7Ix
	Nx3VzTvrIrTO5g7KEiTxg0++VCnoNBWTw6lmT/Svl0T8dwo7GYKVanHYhhcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774339163; x=1774425563; bh=GAE3GLEU2Vn4qykngPo8css/RqEk7oYVV+U
	Cba8XTQk=; b=n50W5rJJfhMbemBRXGrnw41HnKxx5Z0xppvVXz8KlKfrH5f2uqW
	3Wv4LxNoCwSZU+XzlfmZM4l2MsEMeKbh9ueA5Gxa1xNUzDzi8pQ3vYeApTKAeFgJ
	ZS4cvFtNMsRNdqLWCkYggYZRVvfRDXXzdI8jUjjYBoJ5g7eq6QkpP8K29GekLVEG
	NzzL1wiBhg/IbnQ9iptisDpzn/6P8Rdyf7L2u8Gf0GnrM+Y8Nfm7X+igXofMh5Zt
	biQpEdHeMrOwGjCH+YowyRm7ZBJH9RChEPqT1ko9Z/wNNZ/k2mKMrPDJclyoAf39
	ctwD9rGFYJtdsy6HybfQ73OZBm1LxJJdSJQ==
X-ME-Sender: <xms:W0TCafVgCTj0G4jsdOjXMx-i1niA1_caGMZ-D-gQf_IfT7lfYzFsYA>
    <xme:W0TCabSnZxghBTBF2pMbl1t29LTTsuYUMsjvnra88FZYdUqtXKMZm6xyH-IGvdWBF
    Y3yns-mAoJ-es4muaMGfyTisx3mv0G0AWw4kVrdm2mgprFAwdLbOuU>
X-ME-Received: <xmr:W0TCaVN6gX80y2kdPjf9n2Q4wXcxnjK4hAfnANRH7wAumYrRy9XokLcZtfxHzRmGDKHTJ7WP6TZ3tq-HfMHoVR5uQPW7BOPwF_jjSz8dha3utA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhisehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:W0TCaRQXeUA1IvirfQW0p1fUdd9BuzAHLt963VN7dJ2eQpWq-JtBVg>
    <xmx:W0TCabiaMEMvwUFBwumB1JkkltEw7dQiy8kmDWviopEbAHSRLh7haw>
    <xmx:W0TCaS9Pgwdfc_yh-9fCWPFCAv5oasmMEkUBWkNr0ly1hhpgT2wj5A>
    <xmx:W0TCaaFnafsJClJroFMwXLYq8tIqGxCpbjE5qHWFq6vezBxM3WspPQ>
    <xmx:W0TCad7UCeM1ibELcCSzPSkmwQ2EqvARSWVuP8FSVod0e9Ts6v2tyBpk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 03:59:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63f95560 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 07:59:22 +0000 (UTC)
Date: Tue, 24 Mar 2026 08:59:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	r.siddharth.shrimali@gmail.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/6] backfill: work with prefix pathspecs
Message-ID: <acJEV18rQAh2i2a4@pks.im>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
 <f8f2c613260458e3c86109888ee1c51313095319.1774266019.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f2c613260458e3c86109888ee1c51313095319.1774266019.git.gitgitgadget@gmail.com>

On Mon, Mar 23, 2026 at 11:40:17AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/path-walk.c b/path-walk.c
> index 364e4cfa19..0d640e2f24 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -206,6 +207,34 @@ static int add_tree_entries(struct path_walk_context *ctx,
>  				 match != MATCHED)
>  				continue;
>  		}
> +		if (ctx->revs->prune_data.nr) {
> +			struct pathspec *pd = &ctx->revs->prune_data;
> +			bool found = false;
> +
> +			/* remove '/' for these checks. */
> +			path.buf[path.len - 1] = 0;

Hm. Is this _always_ safe to do? We add the directory separator a few
lines further up, but only in the case where `type == OBJ_TREE`. So in
reverse this may mean that there are cases where we don't have a
trailing '/'.

Maybe we should instead:

    did_strip_suffix = strbuf_strip_suffix(path, "/");

    ...

    if (did_strip_suffix)
        strbuf_addch(path, "/");

Patrick
