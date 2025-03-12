Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3522528FA
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793811; cv=none; b=FLcIC28b0B/pOaojrpRpBgNSxDd5Ka05DxzLLtGHs1upKAWg5Bk/abCTZg8Pwic6wgVrsZQY6nS5Ibx5yWmga+Dit9pKeosvK51JlFrjBiiC7MLZTY2wGJUDGXS2bEIEeVdQ+QUK3yyk9oCkLaEHJjCKQwZ8GyDGyBNX67hJQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793811; c=relaxed/simple;
	bh=XV7ztpryMCovsTGlylaRFqA/emf89kwKTqMw1Q3lCuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0mtYC86zPpZllvBKrxhmbgzWyTk8yzPpQE383sqy7fs/UheCt7hUdCFTdTvyx86BCKb9be3wqsDaUQA6XCAycGFppVucUpX3/9PcmJRkXltBMNhvBwshBGNk4RetU/cNM5GyEWVL0llq9At3sbE56Mxb6eoFx005QT4MAbltIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SPilDQzo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KaViXmKS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SPilDQzo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KaViXmKS"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E2BE1140158;
	Wed, 12 Mar 2025 11:36:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 11:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741793809; x=1741880209; bh=h0b6hwpegB
	OH5IFyxubAwaFYpBQYUGwocHJYR12zwlc=; b=SPilDQzoF0g0pIj8B/Do19+Mnn
	rBeCjjU6wHHDsPtObgIJkHjJJObEHj4PL6leyKDe8ioKQv2aP++tBhOCzqkx99Iy
	8f8BapotSZi7hND8DMFfvAXdQT6gfYlY5a1fMrArwRTgNTdjasTmlFkwqETJPaed
	KG0LIWY4ummsX6k3pzb0vGBrWmNyM9bsdCxXmq/v9EMdesYzmdUaaY/A0saFOQj2
	gCTt9eqTjEv/6+1Di5z8Iprm/kUGiBDWmhOsby0Lhkw0duySgyRxp5vktI0vlKRf
	kIcd5m7N1+8ZsCZf4Q5UUUJZdAs297WdhgTSW8bP0yFIBlUNPI6KDuoJuQhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741793809; x=1741880209; bh=h0b6hwpegBOH5IFyxubAwaFYpBQYUGwocHJ
	YR12zwlc=; b=KaViXmKSODKZ9WtX6NjZ3PO+slobu8FMVtc0/X0OcofNgE45v0B
	9GplXEIKF1M56lBH4OBBWanPB7fCusmet9BRlTz5o1pq+AQrDfaLuSdH3Df0xGkT
	/8kSJiYVxAt/0MTXuVI2ANeW6qAlSl7QICGs7bBtqemsSEk51MzVO67+gv/L2dSz
	mk4vALdMovsaAFEOK8MDbzookksKRzjAUffF+Rf40JmZEv+Qe/yuFocKX4ExKSP8
	F1Q8S33n+nI/wSeyU25MbbCeRmXPLBzlnZOVLU7GhAWDzHXIKzCtw4ocyEjVNUrE
	RsJv4XwKXdvv9O0rYdIIsbtiUDXX/B4NT2w==
X-ME-Sender: <xms:EKrRZ0gUTVWYK-lenuLcJiKw8KLjMbVzyiHvkNOIAjMSvHKhEY9fhA>
    <xme:EKrRZ9BuYPyrRME5ppoVpTwOfg8s2YzP2hVcwG-AdWpepGwbzdmOiTXcHJDsSmac5
    XeXc1CAdA7LWnwvxg>
X-ME-Received: <xmr:EKrRZ8Fmvpdwth34GtTlWw819z20xE16Zj5KSF8uSeuCCCN8eWegr7KLLKK8H2tMttpLxRb6wt4QjDcJ-_KOwL0iewZzw_zUKC7C77YGMSDuHSbh8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehs
    hhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:EKrRZ1SSMglR6NO1B06JYVBC-PPLSms3y07DgGLWqFQWxm6Wmdpocg>
    <xmx:EKrRZxyKs1OMJXfeLzwXihsr_URkL-yDgHtxVOf3YE1E0lLqJre1-g>
    <xmx:EKrRZz6SPQx-cgaZkN94UrVQyn6d4gWFXm-orH4UzAy26awmb9NYTw>
    <xmx:EKrRZ-yJYI-6phIi5O8emorUgxDHhRiWpCMyfgucprqQJR1I1MQQ5w>
    <xmx:EarRZwxNA_5SJZyIA8z2iXCC-p4_wcDfSUYFNEA-80jRbe3TDsGf-Ms3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:36:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9672fc30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:36:47 +0000 (UTC)
Date: Wed, 12 Mar 2025 16:36:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 07/16] refs/files: batch refname availability checks
 for initial transactions
Message-ID: <Z9GqDjVO3VvFOT4x@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-7-dcb2ee037e97@pks.im>
 <Z9GGwNpfDly4_NIL@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9GGwNpfDly4_NIL@ArchLinux>

On Wed, Mar 12, 2025 at 09:06:08PM +0800, shejialuo wrote:
> On Thu, Mar 06, 2025 at 04:08:38PM +0100, Patrick Steinhardt wrote:
> > The "files" backend explicitly carves out special logic for its initial
> > transaction so that it can avoid writing out every single reference as
> > a loose reference. While the assumption is that there shouldn't be any
> > preexisting references, we still have to verify that none of the newly
> > written references will conflict with any other new reference in the
> > same transaction.
> > 
> > Refactor the initial transaction to use batched refname availability
> > checks. This does not yet have an effect on performance as we still call
> > `refs_verify_refname_available()` in a loop. But this will change in
> > subsequent commits and then impact performance when cloning a repository
> > with many references or when migrating references to the "files" format.
> > 
> > This will improve performance when cloning a repository with many
> > references or when migrating references from any format to the "files"
> > format once the availability checks have learned to optimize checks for
> > many references in a subsequent commit.
> 
> I guess you forgot to delete some sentences for the commit message. This
> paragraph is a little redundant. In the second paragraph, I think we
> have already talked about this.

Not quite: the second paragraph talks about how this does not yet have
an effect, but will have an effect once we have optimized this. The
third paragraph on the other hand talks about which specific parts will
benefit from the optimizations.

Patrick
