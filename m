Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811CA21D596
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011267; cv=none; b=r9zWZrxalkGah+xvuYUNgU1xcgG5yy05OF0DzNUvgl/HeFTHZS56c/6UhNtTtshMeqHcVd0cTcZnrfiNVUpGrOxIgxHNIICsj5kcAEECGwxeE7g1pro5QIuqiVMu4uKZ1J6xYDee/Xlb94HLhSociBkGRrwb2HGf0WHbYREShiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011267; c=relaxed/simple;
	bh=Bs0ytz/uefk/ujy7qx2fcDOn7IMXWP1aLP8Ff5nCIjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QoR+RXicekPwwbhXkxUNNKqiPIljH2hVKJAWEqKfkDL99BoGOThSor2cQHqfTxvWgVeUo/uHJqjzF/5r8RsbXA/5lrCZPbXc1kjSn6eWosutJC5lxz9cE8/DSd/dTC6OxqA9jTXBAX78HLXHV3KulDQtxbGDK15Ht2qFCen14dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I9QlHV5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUgXVF/B; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I9QlHV5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUgXVF/B"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DC8CEC012B;
	Tue, 12 Aug 2025 11:07:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 12 Aug 2025 11:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755011264; x=1755097664; bh=Bs0ytz/uef
	k/ujy7qx2fcDOn7IMXWP1aLP8Ff5nCIjc=; b=I9QlHV5kQrTM2cdxxmjpZoof2Y
	jUgtGzitiznJWr+U/EtMCMz923X+/CXum46inrwlXMbGahjXfdygxHdZ22ppYedH
	zmWlkcNqBv5h9itdxCcyHlsughETJm3daBjZBbxkS1rlAVq1eWhyTn1hUJ5FD2KG
	r/xb9yuHmIpyvy7tHhgTzeldwQ1R1GVmKOUd94grqlZUUelmPFTQ+lWhVdEfIXvp
	Ch986UkHgot4Vl+c7hAJutFg4OJgAJz1uioabYWKawOyGYBjvPcpa2nthWohty7L
	d3Q0eUXE1jBtqdvg1O1cZxFixl4nANg19CVoHZm5QNErwNBuFhAASXojJKEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755011264; x=1755097664; bh=Bs0ytz/uefk/ujy7qx2fcDOn7IMXWP1aLP8
	Ff5nCIjc=; b=gUgXVF/BybaOhuXfLtVItgu1MwDXBm+ypSumv/fjakFrRmZ5gAJ
	Wc1h8+uyNtQkm9QDGc19HLXGSlBpFHDqow+pgUOGtqEVcbfqRA8LiHanYEVNnb6u
	N3xr0GDMdI1++LIiIwcezF5oMOoFX5PwT8QiOIqrd6sD7qiIcELNp6zIX7WXVoxu
	Aq0R/vHd348jbZGgVLn8uCWKGhWSmpqAsTVxfmwnw63BvMMMC37fZcvk+fBkRFl4
	S24VRcUnM1QR1uh+LinIkxy05HkzF7YQ8Fk7eMvsNTr9EnUAl6ROXHQ3w/5Cm0Tj
	X+BNLh1x/dXhvrIG8WtxnFIW37e2BMVaOEQ==
X-ME-Sender: <xms:v1ibaA8du6BTS_N-PHS3K05f57JdUKe6WRWSArxsZghy650c2iWcNA>
    <xme:v1ibaCIP3ARn1Ulc3D6aCmZHbKawsegdAMfugTCJkIUMqNNSX9H0zbYOiylJHOnug
    BxR0K_sxu0UpPzRwg>
X-ME-Received: <xmr:v1ibaFlLOYUIIoydvH7zV_HkOFwB7GHPrZCEM2zcG_YeOxvHT1r2J1p-wZBwvTgHjMKVZd8l3sE65zZqFL-AUICVgTmYUGbtZtkxpOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhpvghnshhouhhrtggvsehgrhgvghhoihhrvghgvg
    drihhspdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v1ibaGMeDl9ssFecwVpmjcDTATODfRyLzcTlQNqNgWg9fh3taHVOqw>
    <xmx:v1ibaL3IwCDx_j_pz9KZcY-Jm0NN-747cJnLfQQzFC7VNw6b9cS2Vg>
    <xmx:v1ibaFnZvb1H7uzXNFqsPBWmEoUnAPr0vTTC__eaRduqY2geQf_cog>
    <xmx:v1ibaCWryGw_TPc9XDkJyQ0q49tFAuwgX7mEJ8yMbBQh-HsYXpLEOA>
    <xmx:wFibaCdHhfWQTeUaFC2rjFf1vyHLalpPymsOAQ5ZGuYq0oVTjWdQ4Qs2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 11:07:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: opensource@gregoirege.is
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2] diff: --no-index should ignore the worktree
In-Reply-To: <B90C049E-677E-449A-A899-B6071F852298@gregoirege.is>
	(opensource@gregoirege.is's message of "Tue, 12 Aug 2025 23:37:39
	+0900")
References: <xmqq1ppk58ob.fsf@gitster.g>
	<B90C049E-677E-449A-A899-B6071F852298@gregoirege.is>
Date: Tue, 12 Aug 2025 08:07:42 -0700
Message-ID: <xmqq8qjowpc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

opensource@gregoirege.is writes:

> I don't know how the review process goes at this point as you took
> over the patch. The handling of the chdir failure in v2 LGTM. I ran
> the t*-diff*.sh tests again and tried a couple of commands, and
> everything seems to work.

Thanks.
