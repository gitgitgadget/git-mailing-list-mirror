Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0A35C1AE
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771844079; cv=none; b=DGm4/w1TqUO/oje2D6znw/HF/E6vQoK7LHwnqXGAVx8NAra5d65rbv99pcvnjJ908lwZL2RhXBLbdRZemT75wvLfyfN4H3FkfnIFU5WW8tgXynaI5zKQ+WVlr8BIX7sQpEg67KtnK0FMB0yxC6x4ikh5pRsSBPcsa3m0WWqup8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771844079; c=relaxed/simple;
	bh=2DXNYvW556mZOUXJHa8QukA138mr4rbJJOC1e9pPFa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWHi2u+jDoMQ6V8IlJlfvg7cpsnSUuvPEsrArhVDHfnjLQhfTo55j4v5QdPK3QU1sidyL5erazIUPvXtMC20K8Q2tEhTxRvM3Dyk6NFdQ0fWpjsK/NWpb2s0aKkB8bkETF4aSaKhKxx20z++AloDcaPiScRaPhTmAfNao8X9sF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sgIGdXFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLEw1iX7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sgIGdXFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLEw1iX7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 32385EC0591;
	Mon, 23 Feb 2026 05:54:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 05:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771844078; x=1771930478; bh=y6Sfj/VnjA
	VBg2ZUAf0gLH6MBXdBVMZt7xefUAPPzjw=; b=sgIGdXFNkT+iDYmvHj4qLWIaFH
	AK8JkjaJ4gSYx/T+NkENHOFJhU1TH/oSAM9PBHoYLt5CLVonz6KwkB1HNk1HPviJ
	CcdOYqgxnqe0ZQuLa/z8zkQqknlcybFxmzf17MZF5fRgUH6VrqpewvpCxA5bYHDf
	xnlKsd61GzE4IySIKtfrdxNJT30oCJcNij8+cA4GrWtTsXzZX7pfim5tBNqSlFLs
	68PKzg/W9+++VRaXxdCbxCnZ4ygDL920iP9xZjsuycnenLX6czZKDJ0l2XoIBgZn
	iANDy4hJSOXd69rgVrdimUhpCIix+nCrOIJHbN9wJz3dakmK8gnKYJNSulyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771844078; x=1771930478; bh=y6Sfj/VnjAVBg2ZUAf0gLH6MBXdBVMZt7xe
	fUAPPzjw=; b=lLEw1iX7YMQ0qxc0Mjyqmh2+5avt5twOfZxsKEKOzoN2/WSggrh
	0Os+X8t4G3V/J5VdvWZB+6vjSWPF8Pt1XlXlfx9+Ao/P0A5uPuvPQl/dc5e79rF1
	0I3XVg97LsIHeT1GurXVW/6DyRBwF1zKD0JhP2qBUrt0SpnxhbB8Cnr/T5umqKh1
	u9ZtStpeVFJ4lWEhasDzPd12egozD3801jJ8o+DAmGYQBrIYTfqA+h5nNzRF8trw
	tGQ0OmIimegwPZyb2kX78zDt2O8YhMBom9tmhvVZhDPaX+O7Znf/1+wdcfqz4YNb
	8YitZMtp17blpswjt5gsfc9k/sHMjfy59JQ==
X-ME-Sender: <xms:7TGcabd1vDTMsZT05nth8LgkB9j6G6d8aTo0O_Gw8bYTZxDzMDETXA>
    <xme:7TGcaYFv4Rfs7b4TUl-LYYR46ZwnEokUIyPTRlSgv1kK_gu0g0rMcuIMSSGLZYbfG
    tBFjP7-yRADg3CgeCBqSbAt9wuKOSaHXWijes0xor7EeXn1meTV7A>
X-ME-Received: <xmr:7TGcac3yKAF2OGNeOmZGrIRjV1rYaDs8BquuPDnrzub_9ZS7mAR8KrJywwJRRFtMb82t__fBr-cE5wR5FduUkQ8B6b70jO-fqcJC0L31_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfedutdduhfdtleffieekvdfgheegvdevgedtudefvddvffdtteduvdehfedufedtnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7TGcaYm5MGm3zIsonuCNtysko0L5wg4Vkq7iaukX052HYp8RHknxDA>
    <xmx:7TGcaU_S0Z2WOFX6AQy_We7_WnyifktGcylWBAENgKFkaDguvI2ZrA>
    <xmx:7TGcaVrfGRwfGermWImCg5nhs8YeClqAfcfc0d8w161V7rc8P-4wGw>
    <xmx:7TGcaVk94H7U9BQrUuGPQKa8WVmkWtZCzWTC81XCnfsx3n6nAn5XEw>
    <xmx:7jGcaeA3XExW4j8LA0JqdfZEMCGVpVONs6l7AiL0XNGPie7TdahtARib>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 05:54:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1cbc94d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 10:54:35 +0000 (UTC)
Date: Mon, 23 Feb 2026 11:54:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v8 0/6] refs: allow setting the reference directory
Message-ID: <aZwx6F-ZeQ-LZv1M@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>

On Mon, Feb 23, 2026 at 09:01:35AM +0100, Karthik Nayak wrote:
> Changes in v8:
> - Fix a typo/grammar in commit 4.
> - In the final commits tests, avoid creating a file for text
>   comparison.
> - Link to v7: https://patch.msgid.link/20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com

Thanks, I'm happy now with the current version based on the range-diff.

Patrick
