Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F02E7BB6
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773181782; cv=none; b=iExn/vkOVWD8WvZ7zhUoBAl0uRpbpOOXo50/UeUmdHorlMP0A3IQDmN8T9JCcNqsQ9HyVcV/zdoKIi13pcV4zN024KB3Hleof103f8H8sJ3D7GCtSqphTAor1LsWmJ7cfJ3JdFlJgl+IS285HJZXs+4IlZw13cObw2ipbazLBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773181782; c=relaxed/simple;
	bh=oEbzqs47IQzM4QjuLgVuyQsnAo1BuXwcEVP8mlGOT04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZYB2bx3+gfa5HYm565+O+zUkUul5ih1YV8vaGTf4T6wMpPiHNOfPoGX8/kOfggR8oBFVxhkBgRBmXYjoiCrFhvMYRq4i01zjJXrLymA5Fmr9CV12wYiXyfg8efJFtC/5ykrn7Me3EUf8+nZvCL7Nmb8PMcogiO1iJhtF3E0LXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K4/aPZFG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WWOAS7mQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K4/aPZFG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WWOAS7mQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F2FC1400255;
	Tue, 10 Mar 2026 18:29:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 10 Mar 2026 18:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773181780; x=1773268180; bh=U25/OUiedd
	/8NNUatfuEKFW6i1PnMvhAf72mdSAmL1A=; b=K4/aPZFGKdkebBgTWdor4jUn9T
	bZzgQ/nMm/A4e71S5CkWLAfn6EyhJAXewGEa3anMD9f9xVh5QTV8IeA9QxM9qjsY
	nKvMEpsknEGHHkDcbCzXI7ETG69LFfIs5nz+nXaVSpOuKuaDUrYa+ZAc6Lsht7pI
	7V2Uiej0Ey79soDfa1hBPN3eq4V+LGjFdvAp9YmMyogXTHmvjaIvCmifYxOnypR3
	vssQ5ePYd+nhhOCia86xzaDFkE+VKUiPaPs4eyYITXCngZp5U2WAuzTeuU6o2Y8g
	XmWaY4qaqkOgc2cbbstOiMHpHfMvfdpU56/9j1rgXD0r2HcCZqBC+vwiv4OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773181780; x=1773268180; bh=U25/OUiedd/8NNUatfuEKFW6i1PnMvhAf72
	mdSAmL1A=; b=WWOAS7mQ/4ovhYe9VDhQBHmAgFW7xu/Fv57s70f8JaP7/YRmsjm
	38wV4VUa3oK8MTPm1/Gcj2FgLTguQVzRchn/fqZ5JOkPIt/OVY9GjN7f/hNGUY/U
	cIJCO4vl9OC3AwQl9X8EygSKufs6NxgrNmwYpmom5DPd7naZPaWrg+wUrjm7VujX
	9Gk71nR6rbT9rSDzR0ARR0J1GQjMH9Luccn0zKvXaQx2CFZGwhC8NNq9g2H5coBD
	7MA4NQBa7C9MxfXqjXTrn9+Imz4UgIQC0hJYQxVD69cyzB1hyme5IxcLjmXLbAYH
	QjR/G6yvFWdPQigSb6mi3wvKJfzjbNS6kIQ==
X-ME-Sender: <xms:U5uwaXKpZuYkxCjt2idjBMAPt1ySzmHZkylFIHf1El4Ure2sTX-Aiw>
    <xme:U5uwae3Se17RdsQ7QaqhmsIgpcXIXpyBsf6hsalH9F9r3-lt8AozJgLhzJYjjWLHT
    HK2iMiR3sZiuzJ8A1DycNRhfzs12QkFgLR5V5h4cvhcHNjwcxTrRw>
X-ME-Received: <xmr:U5uwaZgXebsmM2SuCqA-j8ugpqG9lqEXYLyykds3jw80T2jx3fF5fE9IjnBiuPAFtptTn_uWHMC1gi_doC-malb7cKm3p9Ngmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:U5uwaXULzxHoBaSXPdwc8NsVydaSdp_XFHAMNIKTxEgDYdr643wPlg>
    <xmx:U5uwaQXOxAWuEFp9LLDTHBPfCkF-XWqKc4vTL8jYxXHPUIpyQEXWNw>
    <xmx:U5uwafhUsBeXBPGP72sljfU2J2Cvxj2M05DVc1-2VXMk_ptzxRn9eg>
    <xmx:U5uwaTZ0E_XO_I6iHAnjPJFyOKzc2PLxkuxZlOCGd2gfDkefXyyl8Q>
    <xmx:VJuwadXCgiMyIqzsYZ_r0rBw9yXohNFAQS8VC3EAKoGwh3ahSB0LN9-s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 18:29:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3 1/3] commit: remove unused forward declaration
In-Reply-To: <20260310201116.1130160-2-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 10 Mar 2026 15:11:14 -0500")
References: <20260306205359.1723254-1-jltobler@gmail.com>
	<20260310201116.1130160-1-jltobler@gmail.com>
	<20260310201116.1130160-2-jltobler@gmail.com>
Date: Tue, 10 Mar 2026 15:29:38 -0700
Message-ID: <xmqqh5qns4h9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> In 6206089cbd (commit: write commits for both hashes, 2023-10-01),
> `sign_with_header()` was removed, but its forward declaration in
> "commit.h" was left. Remove the unused declaration.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  commit.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/commit.h b/commit.h
> index 1635de418b..f0c38cb444 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -390,8 +390,6 @@ LAST_ARG_MUST_BE_NULL
>  int run_commit_hook(int editor_is_used, const char *index_file,
>  		    int *invoked_hook, const char *name, ...);
>  
> -/* Sign a commit or tag buffer, storing the result in a header. */
> -int sign_with_header(struct strbuf *buf, const char *keyid);
>  /* Parse the signature out of a header. */
>  int parse_buffer_signed_by_header(const char *buffer,
>  				  unsigned long size,

Nice and obvious clean-up.
