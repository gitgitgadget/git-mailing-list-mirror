Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B018233D9E
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 01:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340769; cv=none; b=CZkSTBfj8OapSBbaPEnaWlKZ3wtm2h1w0tPLnxAuq1AtvN7bu5tAX4wiuoRwBO/oAsgU+EZCwSYv8PRg6NKSLeQlR/Hb2eREyqWcOIpwZ6PKHVvf213EaTzsaJYdjL3/AAZatIed0bQoMaMfRBSXTPBFrzSnyFRHlS2lfzM1DKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340769; c=relaxed/simple;
	bh=PylcBvV8KkoijSkpl6ly+T+Rcgari2LEAIN8YtGr8AU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mq1+e00DbCc8er1dDe1Xzq42FPDnPkyLVR26iXYK4zovV1iHG/l81xUxdyUn4R22wvP+5j5jGf+c6vNnjbNFMXeQBqbrDYwZzdjDo6tl0rZyNWN0mHd/BvLVB5gMVl/Czo1mRYVPlqPhFBBcjeyIrSubs1W7YYFTFq7IZIOodKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pelpxWys; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejTsawdC; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pelpxWys";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejTsawdC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DB8C7A0279;
	Mon, 27 Apr 2026 21:46:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 21:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777340767; x=1777427167; bh=wldqM6lmYe
	zq0yu7TI/pUP3jgviDHdn+8adVVriJZMM=; b=pelpxWysxaJNfG54awv5PcPzlA
	6z3tLiPC+fJuRZwePBnG3uHzg2sd641r/WJfHGxfAy57CxRvbdlN2Bc+zTRhSli1
	2Sj6sRmAJWDiK7KLLZLn1kFNOWq8nUcPGur0POVCIHodQBX9i5Kgoua117C0NH5e
	vyb0NrAuy2oqZiPZUf7r7hracatexv/dUbvF4tDDVYne5eZYcD5veT0RQyU5LDdL
	PH3zJ2eJrx21dJiaPdbT8GHU0z9Niqp1p/gpNqsWQAdz6WaqumEM1Tw6hJzHCsSn
	VxL1wbNMCg5gWRJiqQFjN9N+SezGYa2yYTNkmVk+qcXfA5e+i8QVJOPT9Bsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777340767; x=1777427167; bh=wldqM6lmYezq0yu7TI/pUP3jgviDHdn+8ad
	VVriJZMM=; b=ejTsawdCMttJAUX+87Ydy+rJcBE+EQOxq6UW9S1jVrQuLOksRf3
	0kv6UBMe5aWp9FFGJjFGhhAsn5nJsoz86SsR+UqkxCyIVH4P8/DrVZQbhmbq9U7e
	yAORXxGoUEj+pIiGrrD27Wkbldtv45F+9Id2+2rvzNruXWRCQoHX2YGFXXxu94xy
	jbMibXL2OLbq5c1ijw4AKKUdJN80ZZlYb7h8+IEtDVyF94KCjKOSWjV9UB54p5Gn
	jI8pxQB0yRw1oiYXbFCpmnhWIkgD5SNSvRPOmDUmc2jf3LEkE5nPMuhu5LeMP6ic
	SLJ0SJkfOoPfGXXbYGPin+gGsOPv+fOomfw==
X-ME-Sender: <xms:XxHwaUqos8adheMaUFdD58U5pO8uLjxA6NFORzE_xJ5hqbhPLS_uWw>
    <xme:XxHwaZseUuIyEtULcX0zT03apvS1Nmb9R68AVaDEgIAcsjf6jWJYbFgI_S1h3QgW_
    GfJjhRriU3qADjl7duqyTZ9gGY9cc3pKjcsPm7qdX5zshEB2GNR>
X-ME-Received: <xmr:XxHwafYH51jzpBRu3zlljlhpCnawSv1agxijIIRv6NgxmT6nQeOrB8617GszsV4YYM8hnXZrlvZj4E4O6ExqWhVBVvPlYuRgvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghtsehmrghlohhnrdgu
    vghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XxHwaYaFNosBfad_CcQFRUS5aFzDuzMY_KjcGdo74mmhVNJLCBxd1g>
    <xmx:XxHwaYnM87Vit1m8P6n-c_OmB-ukJ5HdA9A_mJZAeMd9B2rCUwYkvw>
    <xmx:XxHwaT0qlb8HVqtqj837obKYueSIm_jljkKataWg4wRRARYIe4FdUw>
    <xmx:XxHwaY0ade_hgfIZ5OGf8Mg-RLIn3X8KCN3ry1Ou0yDFQ8t90PsSqQ>
    <xmx:XxHwac01iOEaMIh2DqLf1rPd9qXyd4p2rCNmKpWa5d6ddJ_RQpAKjKD3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 21:46:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 2/2] revision.c: reduce memory usage on reverse before
In-Reply-To: <7c0bab5d14bb2ce2a10d35d93e3d911ed4c386eb.1777249165.git.mroik@delayed.space>
	(Mirko Faina's message of "Mon, 27 Apr 2026 02:24:58 +0200")
References: <cover.1776984666.git.mroik@delayed.space>
	<cover.1777249165.git.mroik@delayed.space>
	<7c0bab5d14bb2ce2a10d35d93e3d911ed4c386eb.1777249165.git.mroik@delayed.space>
Date: Tue, 28 Apr 2026 10:46:05 +0900
Message-ID: <xmqqpl3j26xu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

>  		reversed = NULL;
> -		while ((c = get_revision_internal(revs)))
> -			commit_list_insert(c, &reversed);
> +		if (revs->reverse == REVERSE_BEFORE && max_count >= 0) {
> +			retrieve_with_window(revs, max_count, &reversed);
> +		} else {
> +			while ((c = get_revision_internal(revs)))
> +				commit_list_insert(c, &reversed);
> +		}

Style: needless {} around single-statement body of if/else.

>  		commit_list_free(revs->commits);
>  		revs->commits = reversed;
>  		revs->reverse_output_stage = 1;
