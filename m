Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E031DA3D
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676721; cv=none; b=YMJK4wDxnNoXaVv135jASQNe7ioQn3qercbDlG/LvAi+v1FB0onl095bZEj0aHrTaOQJ2+QbuOGLKaNTHKeG0zU3YJ9ajK+d0Ui+/TVE/ic6tCFa3GA/fYsFR18G2mrYU/8mjS7K6JA5KhE0dLX6VuXPIhwz2i0XYcf4SBqWckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676721; c=relaxed/simple;
	bh=7S3mUTSUvHEWPAdEj403gAmRj/qIcupRX9yAUA9NtFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XynPFMHdu82XHepu0PaSY7c0rqFMS4qWFlM2QsNAJdrbN5dRcmHqDL+nvrr5woncYsusF7tjy98splmL7lXxmOIAMD5OkA+3kgXoU31/0tJBu2UiL4iR1x/XjANmNjuZ74KCvDBCLYQAKocTea5MgFZIyd+UavONCLaq7u16DfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U88jH/T0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YlrmKDqQ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U88jH/T0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YlrmKDqQ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B6FD1D00046;
	Fri,  8 Aug 2025 14:11:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 08 Aug 2025 14:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754676718; x=1754763118; bh=7S3mUTSUvH
	EWPAdEj403gAmRj/qIcupRX9yAUA9NtFM=; b=U88jH/T0aRuPlIpKbu1AwoHxZA
	PbfBZBQBS9ZXf3/r2zBGbOHoGjCCuRqBh5fG1cc1hR6m09PIammaDh6ODpXc1xuB
	dKcGWLESVIa1QVjVkuo9t/3uAP/LzRSRcpk0+V3xRPgZh7pQTmsDeZjodx4n1ypX
	Z/c+Fue+y7P5YeaWUBC/gFINlaPM2ujvOnsplDruXZ1xBCm7Niyyoqioth/deJFi
	iiFVG7jtosAN1fSoVjrTStmOBZ+vFAYeOeuqhgYRYArDOUdM08eRODDu4Mdt22rf
	XB2fkopF70PRc/1wuhK6p+NB8AxJ//uFozL01gmt17obE2eFg2NP0+3L6lfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754676718; x=1754763118; bh=7S3mUTSUvHEWPAdEj403gAmRj/qIcupRX9y
	AUA9NtFM=; b=YlrmKDqQSWD6AT8UMNIfO07/D3rv2aU4udIKZDrjmDI766xqdQR
	Fw7RTwCtI8t041zxGIBf+QxqUokGpVI6AoUSj8MV2XgM+Aec1yhSwJPnODBP2N3r
	5CEIwI8852tuTc8G7mDNntC3+YyCT5SzGyCFL2SIanppx5HRXDxhXgNj4+6sEATq
	Tpph8QodUCXRPna6TFYNSU4hE9yMkxp8Q/ZL7enx3YP2jYBDNmnJZwgJ9XMT/Vwp
	FF3u2IwqeEeOaDdADl9jW3mQGV5/rmrmxEQJKnpDthaHgiSvmVR4270DaWPOaoRf
	fDdFuPy6QC3oRUAmdLKJg2X0tQ7o2hwos2A==
X-ME-Sender: <xms:7T2WaAYqiQgxeA1aa7sOcggpoIr6y9I8U5nyzXeLcsU9r2sLKxQnhw>
    <xme:7T2WaF9Wmj0dF9HfLjZSt7dib8fCc15Wq-vebUmg-Le0z3vRQ6KtEuD30LR2zG9T6
    a9UllTPCOyHOldF7w>
X-ME-Received: <xmr:7T2WaHguBL-6iSvfY2LjfWktwH79-tqCVrGphxEG4rGVUDpIHyt3GF1iJDpR21VTCv5t4tlzIDZbcmXSshYNIcShXtn-VGYv6tf7lro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:7T2WaNfOaKpjzMncer2EnPTOIK7v2IU1HXAe-dP5XEFOyJE43MmUtA>
    <xmx:7T2WaGqJPydb9qEorNd07j9C6_6WYBWcPsRV66cQIIPkz_x7nLNt6w>
    <xmx:7T2WaKDRJe3vpyeK7Ui5Rgtlrfk0CudRsiEXof6W3FFw4JcSSd4zIQ>
    <xmx:7T2WaLbnHA6mpg3d2EAWtYKjmz5wZMDXIxB-ICDVMzCXWUMQVpPg1A>
    <xmx:7j2WaEIieWVTzvKLjImqrXxPqp37JBzDXUAo4s1u9S1RsEd6G9Hoigwf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 14:11:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/5] doc: git-rebase: start with an example
In-Reply-To: <f9cd981e-276b-4b13-8e98-c7bae17bcf62@app.fastmail.com> (Julia
	Evans's message of "Fri, 08 Aug 2025 13:13:48 -0400")
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<ac3a91c04bfa5ab2b0e479c0bfeb2ba275fe1d56.1754666665.git.gitgitgadget@gmail.com>
	<xmqq34a1ixo3.fsf@gitster.g>
	<f9cd981e-276b-4b13-8e98-c7bae17bcf62@app.fastmail.com>
Date: Fri, 08 Aug 2025 11:11:56 -0700
Message-ID: <xmqqcy95hedv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I'm very happy to hear that feedback: I thought it was very dry as
> well, but I copied that part from elsewhere in the man page
> because I thought that was git's preferred documentation
> style. I'll work on making it less dry.

[administrivia: please wrap your overlong lines; we write for this
hypothetiical reader on an 80-column terminal].

>> Note that you lost the mention of `git rebase master topic` syntax
>> and the explanation that the form being a shorthand for checkout
>> followed by rebase, which I do not think appear anywhere else in the
>> document, so my suggested rewrite above resurrects it.
>
> That's actually in PATCH 3/5 of this series:...

Which I think is too late; both are quite commonly used and useful,
so showing them upfront when the command line examples are first
introduced would be more preferrable.

Thanks.
