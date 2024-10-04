Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F573466
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 04:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728016375; cv=none; b=e/nlAlkikUclHK8RHcjH43TPyeco1aTzJ2wRiEl9MhV3JXyRYgPgvEwKNFL7yK02+mo+zYUO7RQ1rXZ1SVw0TT7xn1hZcqUV9F5PPqZHvgT1YHwi9iJONH0rs09waR6aK5BhGIbw0hV6uVvfVJoLYQQygC5MbIALf1XMu47z0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728016375; c=relaxed/simple;
	bh=5fdRHgR9oyy7JpFWVhnvmm2b3ItbLYGzT7iFdOjHbrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBtvMtjmIfdA1koL7F2KQEbWn+G8+JnJcTnNYSUJ44gm9Lq7fAPuEMC4kEVq9U1CyNjBTMEm2BY7/nCv1W0miFxyyPmHiFyvYemPV9RoCC4+T9cxKM48qmTev9ievF/Bu2uT6Kh8leWn3my1ET27imkRJMExQSZ7tjus3q+LsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g8m7qJvr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AL63TlN2; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g8m7qJvr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AL63TlN2"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 64AC2138046A;
	Fri,  4 Oct 2024 00:32:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 04 Oct 2024 00:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728016373; x=1728102773; bh=JrZkqZOf90
	cEBnU9Q1QC63F3kfaFWoy1F/9AQU9+w6A=; b=g8m7qJvrVBISzxF9apXr8tHs9S
	DnLP9aNMYhy8/Eg0AiY79dz/sfLMyYFpGsUli99yXWFOI5GgghP+YatDAoUPZnMo
	KdRxwPRumimMfLP9uPXP5JzHbcU8nORZs6vmcM4QsrUTDLSTsKANoPgfxm0X7FeP
	vAWVo85O5nfh5Yrcg8Y22dpywfSNR3C1ZUQaXFLPgxVC4E1qwpYH7MvI/56HrPN9
	3zhQLSUZUXjwrpZqTMyRDEIeuipxSp/VkiyqUJf64oGmxoQooeTJ+SbcG2/1Hyny
	QRIlHJz2RVqWuuRog1ZYtFvL2AY7qZnjJEhQrSFEQ6yQ/IH7RdxlAeGlFCrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728016373; x=1728102773; bh=JrZkqZOf90cEBnU9Q1QC63F3kfaF
	Woy1F/9AQU9+w6A=; b=AL63TlN28jWP+Zw1uT6tNgW/eLYUkZ1W41oMtmhxdOxg
	Hh0/t4K2rWmRsk0mwHX+48mGSDYeLE30e6h9Z4EW2iaGTpvPjIVoUs7sqjXKnToO
	5o4uuU5v9lvKuT1w9AH5THeih78dMYwvr6+fXPFQtD7TwYO6j9bhbLA/t0PBmt09
	Lu0Mmw4Euqmjg2UtX1oOvVkCQNnFM35k9s9+qV+FiAhl0NbATOQSUnrHTKXrmaCC
	Y/KCTGh91iGiLcWXyy8oKv/7a+Thfr2rnVggIo+OTZtKBVeIidR1AB3JEz/c5zUa
	RMB/+B40halFFBYrrDl+F9Xd55gxW46Yx33jc38frQ==
X-ME-Sender: <xms:9W__ZtGjV6hv80wgfLbvuhdtpxToCJPWxdrcwV3FBvUDce3Pi3jStw>
    <xme:9W__ZiWiIPUfMkmTB-K2W_X3CqlYZDGI0_cv0ScEMIlH5JOU8CRtGZWHKQlO4Z-nP
    hK4GcEB6iVcmOIIMQ>
X-ME-Received: <xmr:9W__ZvKfDjge8qy09TB5EgB3_ZGBTVZxHcekGgBnsZfBQbx3ZqXS13h-6NK03U6e6o3u32FFaW-3evU8CcbdpN3mkgaoTPT6Xk8XMPb9A1lbgtpf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:9W__ZjHy6JXxoRl2rh-jxcsMgQmOYpgeW1NGDSQhCZsye-GptEF5qg>
    <xmx:9W__ZjXpNh0loY7OJ-f5_h35I1vu7CagF4zFTek48HGl5Asjq9h7yw>
    <xmx:9W__ZuOFqTnsnMN_Sg6ssVCkLfaatJKrTgY2Po531HRZc8-gLk-vDg>
    <xmx:9W__Zi2FWZUtS57EF_O69jWWF89PYr50IzPgCvE2WVU1eUNlYUvkgw>
    <xmx:9W__ZpecraKfCVf0e8ry2H5SmuDVbi15V7D_eRmda19OtrZUy4pVTfqb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 00:32:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e9e9d924 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 04:31:59 +0000 (UTC)
Date: Fri, 4 Oct 2024 06:32:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/3] line-log: protect inner strbuf from free
Message-ID: <Zv9v8ZKIgQpxpuVv@pks.im>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
 <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
 <05c21616c350b5141c17fde1aa5d3aea881c6031.1727956724.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c21616c350b5141c17fde1aa5d3aea881c6031.1727956724.git.gitgitgadget@gmail.com>

On Thu, Oct 03, 2024 at 11:58:42AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> The output_prefix() method in line-log.c may call a function pointer via
> the diff_options struct. This function pointer returns a strbuf struct
> and then its buffer is passed back. However, that implies that the
> consumer is responsible to free the string. This is especially true
> because the default behavior is to duplicate the empty string.
> 
> The existing functions used in the output_prefix pointer include:
> 
>  1. idiff_prefix_cb() in diff-lib.c. This returns the data pointer, so
>     the value exists across multiple calls.
> 
>  2. diff_output_prefix_callback() in graph.c. This uses a static strbuf
>     struct, so it reuses buffers across calls. These should not be
>     freed.
> 
>  3. output_prefix_cb() in range-diff.c. This is similar to the
>     diff-lib.c case.
> 
> In each case, we should not be freeing this buffer. We can convert the
> output_prefix() function to return a const char pointer and stop freeing
> the result.
> 
> This choice is essentially the opposite of what was done in 394affd46d
> (line-log: always allocate the output prefix, 2024-06-07).
> 
> This was discovered via 'valgrind' while investigating a public report
> of a bug in 'git log --graph -L' [1].
> 
> [1] https://github.com/git-for-windows/git/issues/5185
> 
> This issue would have been caught by the new test, when Git is compiled
> with ASan to catch these double frees.

Thanks a bunch for fixing this! The change looks good to me.

Patrick
