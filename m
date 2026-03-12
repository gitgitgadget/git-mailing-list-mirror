Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F138F652
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336044; cv=none; b=NbKQEUGdlUjPmw3QhepR7Jz5IyIRdvj3lrHTGhM8SSfKjzc/WVFOQrzlAt21mTbkT2NfnHfJFQnMiyGNu2NWThO78rme0kJWzR2KetrurVtmNEg4FqKCFBHHuFOtpmxvDpWTLYNxPBkNKJWl9R8Qbg8mRhqdLpV2tk7Ljhl+2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336044; c=relaxed/simple;
	bh=po2Yk9rtKPV/JNmNHnXfhpvS1JPYyd7tva6R27RQK8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H4QcCA7+jc2Y0HkRo1Svq3rspaCb0il62kV9R5fFEPbQui3i/QKcczW5i0xe7l0y7ao8Pmg8QSpnzlXvX5fCKBMSKvYaXqJ1w4H32OfdTaNlNWcFpOR0yTmQCNQgFWkDc89suokqAP0/owdZ7cQHRDazXi99UXFaksiOOChpAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RoWpfsrc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XAlgJQtP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RoWpfsrc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XAlgJQtP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F5867A0119;
	Thu, 12 Mar 2026 13:20:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 13:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773336042; x=1773422442; bh=WeU9hmojtn
	+fF+XPkiTLz/Tu4Dn/8hGRPyqfmDRgKQ4=; b=RoWpfsrcB4dh6gnMrcY1XNjbCO
	ze2gSNGPmC4KNsCkmNUb+McerupC0pQ0cO8knSjweAxqMRHjryBd12K3iEbRdSnC
	t9PFVcTGRZs3AYnah71ypfA9Ixc5C+HOzOWvL9iGkz33LPBpFes8xiPWG8fGPve2
	+NIMNGfQ5o7B+SKboc1bCeNKmvCNhLy7JbmClLpxToA/2gdy16Dm9SumBNv1jI6Z
	dqFP7z1uleBWzkuMegUzNCqDfgTZ54deiIgKKPUoC+Jz4o8LlWM2CcjCGQVFuJux
	5ynzsvw9FFXP5T7c+khiBJteLXwoGmWojIvhj3OXeqeaExoLrt+8zKXUsZsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773336042; x=1773422442; bh=WeU9hmojtn+fF+XPkiTLz/Tu4Dn/8hGRPyq
	fmDRgKQ4=; b=XAlgJQtP6mdlvcs3oU8Mt1Uu2K7z50OP3VavG7B8tLWaCSUrC/O
	6MyH84nYsmBobPuM2LKNVJ9fuF6lzl81jExI9shjkYCzvhb0Mbu7q2isXOC7j20n
	bb8B0w7ywUGG55XNGWyGjCx7hxdSTXH7LqjOFBSpAiQn1tBiv6LIf+7t33Ej3Hjg
	by0NZ4hrjCpuoLmcnNOFOQ02QRxuq9ek61EW1CUWuR5cq+yNkMyBtfra0PrJLYe+
	A8e5f+rD9f4+bxyvtX8gRlSlhvGxPYEJ7P6V3ZaDUeCEAEmYsswsnaEIUh9yrdAx
	6ImJ/O209ctNBSvkAP63AKOI2b+b3guelsg==
X-ME-Sender: <xms:6vWyabmiQHvVHIxttjdVf52NWm_sVvwLgmx4Cu6mYPFm1MJEIaaSuA>
    <xme:6vWyaSjAtPTf88HVftbgTqhP5VWmBMZpXo_JKKDpn93jmDeUbYknlLIQQT7jhQY2b
    jWdqn-xaAWjw01gKPv0j940e485IXuSfHYegru41bjA0peV8YfPrA>
X-ME-Received: <xmr:6vWyabcbPbPNdtTHLOf6BAuV4ADpO6zkrXYSzXsbRKO_pxaI5UXM8P2JqxF-ySC3Zs4Pz8FhyFCRJXaUrnxGSx-3FTywSoMvdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvrhhtrdifvghsrghrghesghhoohhglhgv
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6vWyaaimjFpyIJFGje7ITS87PIbPc28AaGbvZYlGXPGsK25_ZOgYUg>
    <xmx:6vWyaby086RYOowwK8oaNbrOmw3Hsp5kDeOSLjspAL0ym6Y9JgdfAg>
    <xmx:6vWyaeP6pGQnNtNFDzvwqaWthYlwfgEtgBR27YziHMFsaZ54K3Km-g>
    <xmx:6vWyaUU780SRYq4M1uOOvLNKu9X8NiedEocKRw2UdghQbOCILlI67A>
    <xmx:6vWyaf5hEGI97burxkMX5wzPJEm3F7k1efAOrsq9tmz4AmLL0k0LZIXw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 13:20:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 0/4] format-patch: add cover-letter-format option
In-Reply-To: <cover.1773331753.git.mroik@delayed.space> (Mirko Faina's message
	of "Thu, 12 Mar 2026 17:20:07 +0100")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
Date: Thu, 12 Mar 2026 10:20:41 -0700
Message-ID: <xmqqo6ktezh2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Squashed the documentation changes to their relevant patch and added a
> new format preset "chronological".
>
> Thank you for the reviews
>
> [1/4] format-patch: move cover letter summary generation (Mirko Faina)
> [2/4] format-patch: add ability to use alt cover format (Mirko Faina)
> [3/4] format-patch: add "chronological" format for cover (Mirko Faina)
> [4/4] format-patch: add commitListFormat config (Mirko Faina)

By the way, we have merged the topic to 'next' on March 9th already,
so it is a bit awkward to see a wholesale replacement series.

We could revert the merge of the previous attempt out of 'next' and
queue the new iteration in 'seen', but I think the major changes in
this iteration are

 (1) the "log:" prefix is omitted (which I think is a bad change
     that we do not want),

 (2) we no longer consider the option an extended boolean "use the
     modern customized format [Yes/no/use this format]?" (which I
     think is OK), and

 (3) the default modern format has a name (which is OK, even though
     "chronological" may be a mouthful to say).

and associated documentation and test updates, so at this point,
making incremental changes on top of what we already have in 'next'
may be more appropriate.  The incremental changes are easier to
justify as well.


