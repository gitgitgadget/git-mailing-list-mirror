Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDDA3AE1BC
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415263; cv=none; b=asfkBDtz2hJP1Jx+GxCuEauoEiee5CRi9UsxDmTNuBcqIYIcOdmKh+WzZVNJP+koehsmO/IkHWmNV7h8CN/JcbSZfgd1Xoqv8SwhTusoskC6bQBDP5nYus3IfWPN0O1sOvQ7VbRP7GXejBgEKrISLLrQNAZlNTdOddsdBqlPEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415263; c=relaxed/simple;
	bh=ayrPpqomsPMmjIbr+2pgwPGOnE0hx42vnb/l1AkV/l8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n1ivTzO36dbgpwf22ywhWRIvdZkVPYvu5tgBh1WA3ECYp+LzzsBLFUGNnUfI6CI/U86OgetB/twGLd3O4GnkpxKbV+Sha3UuAz7zEI5YEIMlPeGWDrZeZS30a1QqrBZ8hGWJS/QJeDeyQkvY6Lqcq0avUX5AB4cmWr/+PlA1elQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W389TF7E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vgMm7rYw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W389TF7E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vgMm7rYw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 21681EC02EA;
	Fri, 13 Mar 2026 11:21:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 11:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773415261; x=1773501661; bh=/puyzLhVdS
	adRyKhOlTl//uk2cRx6i05Mc1MmxtV3sE=; b=W389TF7EdTZgosBgC+RJ7BobKY
	+NX2UQDLPCxYuRVWT14NhUBuMoN3wG2EXva2nI2heTKKT8Y0/sBOaFjEk0fEIxVD
	YnRq5vQeu4HZLif673+Qqy3X/kh8ZCF90ub14TSwX3xTWGdlJuMaZcunmSGJ2s95
	K/0y+xb38RX0ubRUfEQdIE+/6isTnC6QUURUiMtxytXcHl42g2vVdVxvTR0eG1pV
	oTu6V3J8HcfaPEh9rP0imO724imkpnI4L1htYJreYLgrYc/ROspC5xW3a67I9TLL
	XTRaMrBR+47CqoCPljDs5MSrWvBJtuELt6ldmPE6+ql+UOLHjHhj6ZTKdSLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773415261; x=1773501661; bh=/puyzLhVdSadRyKhOlTl//uk2cRx6i05Mc1
	MmxtV3sE=; b=vgMm7rYwi0z4mNONK5xVEWCZh1Pjb33l61aeKNp4Vaq+ywzTQtt
	8V8FFb0D16qpo9ndndXnBOz9YpdMb/fsTB+ts5Y5o2/2De48DzvcHcCwxgA5zCZm
	+eKXd2Jtuvl2f0aFPwLUOjyOypDBt0XDs1a6RvayuwYiJP8aNrPsWQk4CyUhNS0h
	ioV+8blN6IvtF/NThJ+WKNFanoRsLh18f2TA2rJN4mrl8e+4gADvWUUWompxitBI
	GdTWL4UFmMqFTatpgALxuvV6+PP5tdbaRUfJ38gy0j66bFPXSvf7tGeau3q50Yb6
	UTb0cQVYT5Lz875nVh1COSqRO6RKZtbIQlw==
X-ME-Sender: <xms:XCu0aUX_jLWBR1kJy2rFtVTEWrE8h_prn8hQ8GUuSkjjCNeDdTs4mw>
    <xme:XCu0aXqpZbLbLagJaGTF1mk9wS9TRTki7EKXRxKL95bldlROXYnGnph6nan03zjaz
    sUeUC4tI3L071FVIh3tNgJ8zlMHTSF48qe9RVF61Vms4AwLAPy0JQ>
X-ME-Received: <xmr:XCu0aemCkefUA4kQK7C25LfUqEPlLYNlMWHxGDQRiK8BDTZjMquScakvIrRg153Jq7WdxPBBS1qp34am5IdoYzK3E0GZYYF3tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimhgrlhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpuhhshhhkrghrkhhu
    mhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:XCu0af0wR4YY4OZ9uehTXxkuPNsVe483m24AwKqxt76R7TGCnVeqrg>
    <xmx:XSu0aTS4zdmvm0JtsVQj2hK4F6mqoY1A8ljQ9Gd9JZT30K3QkpkyUA>
    <xmx:XSu0aQwkvliaPLhtn5nxQVmtZPMPNpQ_IvwbTYQNbOsERwilkwX0xA>
    <xmx:XSu0abBxK8OYWbIKRjbC8ctpTaSU8NRtL6yXTc-kz_HoyPDZtamU8A>
    <xmx:XSu0aYEV9oq7N8cRcKA20HN8Jd6Zg5Q6XZhQj1AM3vq_2nJ9nO3ZXcV7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 11:21:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  peff@peff.net,
  pushkarkumarsingh1970@gmail.com,  christian.couder@gmail.com,
  karthik.188@gmail.com
Subject: Re: [PATCH v3] t0410: modernize delete_object helper
In-Reply-To: <20260313053159.36492-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Fri, 13 Mar 2026 11:01:59 +0530")
References: <20260313025852.30010-1-r.siddharth.shrimali@gmail.com>
	<20260313053159.36492-1-r.siddharth.shrimali@gmail.com>
Date: Fri, 13 Mar 2026 08:20:59 -0700
Message-ID: <xmqqa4wb92n8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> Changes in v3:
> - Added quotes to 'local' variable assignments to improve shell 
>   portability.

Oh, our mails crossed with some timezone differences.  The update
looks good.

Thanks.  Will replace.

>
> Changes in v2:
> - Added 'local' to variables and ensured they are properly quoted.
> - Removed 'test_path_is_file' as 'rm' provides sufficient 
>   error reporting.
>
>  t/t0410-partial-clone.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 2a5bdbeeb8..52e19728a3 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -11,7 +11,10 @@ test_description='partial clone'
>  GIT_TEST_COMMIT_GRAPH=0
>  
>  delete_object () {
> -	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
> +	local repo="$1"
> +	local obj="$2"
> +	local path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&
> +	rm "$path"
>  }
>  
>  pack_as_from_promisor () {
