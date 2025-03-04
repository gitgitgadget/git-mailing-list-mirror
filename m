Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A631E505
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112029; cv=none; b=fcr/kRnWGbv6/Y6BxWEqL3ptNep1R+Zd/wjCXejs1eAMtIiem9SkPACPCq4LH5l7baHmIa+cxmTh8jPhu7hf5ytX0lIDxhNnZlwXmxccQ+gCSI5fuEjpXS7gVylR0mWp52sYpMddnJWdjRo2EHIPD4M6swPCRD7Z1UHe+7IBmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112029; c=relaxed/simple;
	bh=xcH4COtuYRXE/9fCS59TIQ5JCndVu/nkxQBv7+TCJG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DNsQxdYpO931Sbf+SJlUc2Hc3MBz2YY011kb0qiE95LoiQfLwPK/Qz0stPERNPg66s8Dc2yx9pAYUpLMh2iMY1YUzsfm+t4/MJjNngKNcDxghtLfCtIsqaBKkNRN90ukg1xL3aGDDtXOyyyGpjx2CnqksQcwvuwRCHPdoQfBEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QznTL5P8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9KDaNOD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QznTL5P8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9KDaNOD"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D6B2E1380F08;
	Tue,  4 Mar 2025 13:13:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 04 Mar 2025 13:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741112026; x=1741198426; bh=d6sp+TawVk
	Qiwgj7ZNgRGfLk8vUWVRTwtrUSv/w1FyA=; b=QznTL5P8DBHFmRPDU81bJpWMkv
	hSVDXlil+JbggwLDk8LMoueyf4rgoLodBZMLyhGQO6mBNx83wrOeAmXSbx9XeuuH
	1AChZdmxoKXbTI6GuCZRAqGXUn1oF4o0Y2pXBr+YI82c35zwH/2OacFn0a/F52Nk
	uPEtcUcb9hzWU1nLlRD3GJxLxI/1vdcxMt/5eYREmU1uuuQslXJoSFnbMtJh5+kj
	orea5Ujcf55ANOftFB9GTgNU9558/0nvnMqah3ct39mb51nCnI1u7gAtHMk0gKg3
	XIcpoIe2c1XgbDH8algib4/5UFS4vp1osW8rdtowjc3VlFn9bQtMjVVGglMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741112026; x=1741198426; bh=d6sp+TawVkQiwgj7ZNgRGfLk8vUWVRTwtrU
	Sv/w1FyA=; b=L9KDaNOD3cr2r/1X5tmojSLrwbmG4do88qb5TcVl+KfL4Rn71tP
	kQOaHB9J2a2k19xF9IqFd3GxkSi/TClspsdWZ+rxVRWIdpL4x47YD28RHb5aQZBU
	2Mlmw6GMJKKMyzIgZoFrQlxbvU0SarCSl8bQ1B94MqSHkhvwFBgTRRxG6d/hPtzN
	f2CyENh84KtOHjoGQ0I95h85BSpG3525R0kk80b8aXGI76fgHABXN915p4ChX8uS
	Ye8EJneRKt65xCPpc1KkcHEhc1MDd5wuwF+lS4MO/V00RcvWcJJ55GyrVdXuybyK
	1xAIwoeCTj9L/O87L8bnwM5BeimHWQshljA==
X-ME-Sender: <xms:2kLHZ4Q721jHLFQYlyP5-BYJb1WvQ1syc0_Zzc1qfgl3eZTNsHjZ_w>
    <xme:2kLHZ1wLd2poCUz7oqrFREWQlXvDIY2ktwzHc2T_1d8Pgphg4m1T_CJOFwCW4eH4B
    nUaXk8njKylm1xj-w>
X-ME-Received: <xmr:2kLHZ13WFIH1lhy7b2nuiAP6T35wul2U3C-ID4okJjfWGYcDi9SQdJFnPbikfCdV5xgFiHrQY4srtAMxzM4SAbtS2mlRRjQ62gpD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhimhgrhh
    gvnhgurhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:2kLHZ8A_FjcQuVxnxj4ine4pCkiividSYpQUaIzYyab81xaDduYw6g>
    <xmx:2kLHZxhpA_MnL5_SJzQqf4cGADqGRcLwq41KKSkDnbubftfCYd0GwA>
    <xmx:2kLHZ4rr5bsz4D19OV_gnxowEOCh9UY1vhvXV-Ombhv_F3d6XCvbxA>
    <xmx:2kLHZ0jXWNQsir7wwLKPk1cw3MIhtG26TZnB8bYK1IlMDh38D5-nrw>
    <xmx:2kLHZ2t4iKzCVFNUzZRK1ZPXalBsMI5li-MEsp646bgOD_qMm9DEv8Wx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 13:13:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] t1403: verify that path exists and is a file
In-Reply-To: <20250304112728.41228-2-danimahendra0904@gmail.com> (Mahendra
	Dani's message of "Tue, 4 Mar 2025 16:57:28 +0530")
References: <20250304094153.28959-1-danimahendra0904@gmail.com>
	<20250304112728.41228-1-danimahendra0904@gmail.com>
	<20250304112728.41228-2-danimahendra0904@gmail.com>
Date: Tue, 04 Mar 2025 10:13:45 -0800
Message-ID: <xmqq5xkopsti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mahendra Dani <danimahendra0904@gmail.com> writes:

> Verify that if the path exists then it is a file using test_path_is_file().
>
> Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
> ---
>  t/t1403-show-ref.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index 9d698b3cc3..9da3650e91 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -196,7 +196,7 @@ test_expect_success 'show-ref --verify with dangling ref' '
>  
>  	remove_object() {
>  		file=$(sha1_file "$*") &&
> -		test -e "$file" &&
> +		test_path_is_file "$file" &&
>  		rm -f "$file"
>  	} &&

Yup, this makes perfect sense.  I would have explained it a bit
differently, perhaps like

    The original uses 'test -e' to ensure that the file exists, but
    (1) it fails silently if the expectation is not met, and (2) we
    expect the loose object file not just to exist but to be a file
    (in other words, the original should have been 'test -f' in the
    first place).

    Use test_path_is_file to improve on both points.

or something, but the proposed commit log message is sufficiently
readable.

Will queue.

Thanks.
