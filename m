Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3FE35944
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070112; cv=none; b=n0zYYHdnb2ImHkNzNelp4kvkhnQ11zQwr3mbUw0PMsy6rzUzkIpqJ68AOyT/RS5T8hlbbzHkPsQw7P8vHOb9B6bW66bJmhejgpOJst0e7MnYxlIhZXHonXkhruSJn3zX1IiT9xbktH3GI8iHvUwk4kV9CipBiFa+x+wQUxC9cdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070112; c=relaxed/simple;
	bh=4+4gw1kTwpBfwobmpIosQ9w0Bu5aTEO+j1HtXccZa3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7igwEZO3QbV/5Aog2hcVHOsnUd+McUgTNf7Ra43uw+S+YcHQ/PtIUkN+l1Fo/2iu612JVSytuhnwm0lnBggi5nkptUqFYpuCwClZNjnPrAj0TvssaKs7/HSGnGIBnHIn9YfD2QQB9aar1fNhGLAAA5WoK1cYy36epZiMRChZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ees9wT6b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0m3qs+R1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ees9wT6b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0m3qs+R1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CC601140217;
	Tue,  4 Mar 2025 01:35:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 04 Mar 2025 01:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741070109; x=1741156509; bh=5EIoD6YYtT
	nI4KGAGO2AcOWGT5xrYsVarm27qGpy5io=; b=Ees9wT6b3ir/qUmtW0DRCTI2H/
	Aqg5bzMwdrHyH9zC/1Pl4Ztl99+W6oj1H2YzBZf1oUC6VaaN3PSPESc8r5oKKywQ
	Ge6dWbR7ynpk9P4m1KVjH2/jbSHjne8Vvvl4cK5bMJQ1kYEM8CoH2q393vHRr1HC
	RrM6UL+39II7GUSRupq4BJFRFENlfg8di+C8NP1sO7VxZNMgVmgKSzHzpEEn+ZtG
	OPxKQtNaU9f0RNkwChwOsb1TwlegSBD0sgOztd2yT3Cfs3gYywKe2oA+tOlnKOsd
	VC10kRKFWJH5yntbguZ65M0pJ1wwnaHnIk6HUNaV2V7EAlbDOx9unPE/ojog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741070109; x=1741156509; bh=5EIoD6YYtTnI4KGAGO2AcOWGT5xrYsVarm2
	7qGpy5io=; b=0m3qs+R1GP5xj4KYgGfneThDu3WLH99DbtGhYHnPkm7bx+4KcRk
	xrNMOLlX9+6+c9rRI5pRoG1vc7fX40srwBitUKVdGxzZRebo66n5b2duvXRQjVK0
	slH9gd/kHQj4sqwA0yFEmcwyrSXL5l/exqbPiksqv3BOyAflmZRy8CpN5hSPhCGJ
	AirVXlG42y+f8G3hG5IrQaw0bOVnDyKdw6Az4GJEh8/CyFSEK6aG0rtoCRZTcOyC
	W0sgXaWqp3CizjP4aDhfyaVYOdslpiNKxMQ4Saj38TDek/W6cj7KMSdQPOgsPSyJ
	PneDEVBeh/d2YQcwFZW4JZ468qweU+g4Ufg==
X-ME-Sender: <xms:HJ_GZw9yvNuVsI3k8K164Lx0UbjCo3RjUydCJ89O6Zk0M2RoMCTCWQ>
    <xme:HJ_GZ4smgE01PuMSb9al7DPvTaXqpqHNFPBefuDYqWE_JUmdQxFsHIw0gNWJbrEsV
    wX9Q98u9Fafijf30g>
X-ME-Received: <xmr:HJ_GZ2CjtSvstcENOdooDhz6YUwWLkkU_VVboW73LhvE9WlxG7oLjqTssstZEHdKbJ_BIlbDyj_l0MHthdpKIL0GGX_Z9VWDxy6HlAziZPI3N7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddufeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HJ_GZwc8gu5VjReZb1ArJRz_S4BDoJKCT7JxNr5s8X8M3GiAnl0IaA>
    <xmx:HJ_GZ1OdGTTTEx1vK8ZLD9fAsAl1XKItARAikl2pgIAiQhIIYOtK1w>
    <xmx:HJ_GZ6kqq7XhE1rF28DOayR-waaz0MyNGPzmSu6QP1syPmDm3uzIBQ>
    <xmx:HJ_GZ3uRnna66ez3M05_L47zIK_XlCC5CfHfPcLTNeVy-JvHsbO7Mw>
    <xmx:HZ_GZ6q0hIfE41QWIVhM2p5nJdGt-IxWo80lMFROEJFT0N56rvIHRdwz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 01:35:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c685f86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 06:35:06 +0000 (UTC)
Date: Tue, 4 Mar 2025 07:35:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] docs: fix repository-layout when building with breaking
 changes
Message-ID: <Z8afGexTdlqDnPV8@pks.im>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <xmqqbjuivuzm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjuivuzm.fsf@gitster.g>

On Mon, Mar 03, 2025 at 10:18:05AM -0800, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> >     I copied the name from the test prerequisite as I didn't want to have
> >     different names for condition used in the tests and documentation. I do
> >     have some reservations about the naming though as it means we end up
> >     having to use ifdef::!without-breaking-changes[] or test_expect_success
> >     !WITHOUT_BREAKING_CHANGES to document and test breaking changes which is
> >     a double negative.
> 
> It was exactly the first thing that came to my mind when I saw the
> change to the Makefile in the patch.  Unless our breaking changes
> are all removals, which is not likely to be the case in the longer
> term, "without-breaking-changes" would be an invitation for
> confusing double negatives.

I remember not quite being happy with the double-negation myself. I
don't mind renaming the prerequisite we have in our test suite for
consistency, as well, if you want to do that.

Patrick
