Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E71E2868B
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745010275; cv=none; b=DGggXvtGaUN4LXcAaPtxZ1fvtKWnB+YaNqrqo5uiE4seWjPuI6M1zlWNnyUlSfPQx6q4Q6m0yLGUM5Oga+JZ2qMap+ytaSnJ2ZctCI7VZwZyWAhuOo/CcAa4bVRkCf/rkht/zzcr6JyFQ+sjuyXSgOJP4/EQ5/iG1WpaznXOfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745010275; c=relaxed/simple;
	bh=ICEqsk0vZIsF4f9JpRgxE7YrktQJIw9TqOdE0SWj5AE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LF8OlC9OJv00suCXzeOEP1VnXIyxjRTT84boKYt+HlOMKpgP4p2EuzBcRxkfXVhwAWFkQ4nV12KgwCf9zSuXwtPb8+vwvXMx/7/OiH1ntXN4AJt+mDL0SiFUL9QW9CJCvxi5CPKns1YgQQ73V793jNtoUYkgn5m5tj+x2xzr1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wahbfcq2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mBV1lcfi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wahbfcq2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBV1lcfi"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9935611400B4;
	Fri, 18 Apr 2025 17:04:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 18 Apr 2025 17:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745010272; x=1745096672; bh=QnSZ+Jmsah
	6SR8Ak7GDQM6uFMm3gqsPDNN8DrY3DUvs=; b=wahbfcq2FY6IXUXY/IdH1MxRvb
	GzIKDyHlimvWK/5xhsr3nIvKhVzwF1hfBCyhYoZaW64en2wcX71pGpkChoIM01XH
	wpsUscZIYscpjbIaadTKx7MtNNuoRVc748ZbJFxi3bylb80fwR+zJI7QsXL+G3Vk
	/wIFZfcJxyMWxFFHgYWiKioBQz8O7aTHqVGB20gsqJoFNY4OYk70a4J608J6FR1L
	EwVSLIS0dJTZGCTMHOeTtE8XBw7Vbspd1AFybxXa8fkyYxvIOnL1zGKiF/Pk2KhC
	CPBMqBV0aAm/p8UOqbrFFu4ag0FFcO0zdq5Ys9AievYXPuj1lHeHeb63UwBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745010272; x=1745096672; bh=QnSZ+Jmsah6SR8Ak7GDQM6uFMm3gqsPDNN8
	DrY3DUvs=; b=mBV1lcfiW0o9xcCEf7yMpoJgW1zsJbUdV27G1kWd/gZquMsv5BN
	ZuDNIt1ehPl+cQ1b5+Rv57LciQc5UFAqJt5sUrM9jJCja0Eh0FsmEwA5nbCvFff2
	TxICUOMT6eq1xRfxryXPZLb314uGQ63USsTgHAWBEnqMCcrWkqVKrCbsJ/7Uo5aH
	JABrJxyWm5BkMkBJFiE3p1FvCjYGHZWQ+Ece4Q5wg6SfIYA9To4LnSJ0EBAqoZN6
	rRe6isQx+7+nCbRbUdaDtZkmsOyUvicuy3O91M9Bum/BeUXi2w+/P6vN0OzAGo8I
	UHKjdJkTr4AwkZamoabWK77xjjN1adDiS7g==
X-ME-Sender: <xms:YL4CaAtyHnAy7ycvDQqXjOVmP5QG4z86CKjmcv8S6mfccRghHfk3nw>
    <xme:YL4CaNeMhguR1Yq6mvD5zyfJs-Aa8d7HG0Om5SL7Kon7w7Cx06VauV7q-yP6FMh3S
    X_6a38LbS-rjJ1DZA>
X-ME-Received: <xmr:YL4CaLx5ZwrkIGD9g8I1_L6l2Dmy_ffuL83YWq6PMmgJtFJYDGtEZq0tOKbtyJk-Zte2u8aNMvLErUADck5g3mDTsM4N_9PJYOyL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrsghhihhjvggvthdrnhhkthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YL4CaDMpoetRxHQgDsg5GiEh4wRnonAUz7GOGWEQPYx9gPj3q6-I_g>
    <xmx:YL4CaA8h6o8PVY3lvk5IruIdWUsWT7SKhbBBG6t4VEsOLqf8RVQ9QQ>
    <xmx:YL4CaLUpHp0KsVWcuPIT0VhgYkPGM64KvWJ4rC7QTUx-7UuHzTqvoQ>
    <xmx:YL4CaJfxydoC0JBn3Xtp7Zsw7fsGIZ6ZKzm2SJzDRfTzauZ_87WlKg>
    <xmx:YL4CaFLL-txd0sWZjo9A2gsuLXULrvP-T5IjoW6sSnYq771H0YwG99gE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 17:04:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] environment: fix typo: 'setup_git_directory_gently'
In-Reply-To: <20250418185855.52950-1-abhijeet.nkt@gmaiil.com> (Abhijeet
	Sonar's message of "Sat, 19 Apr 2025 00:28:48 +0530")
References: <20250418185855.52950-1-abhijeet.nkt@gmaiil.com>
Date: Fri, 18 Apr 2025 14:04:31 -0700
Message-ID: <xmqqy0vx9o68.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
>
> Above the declaration of git_work_tree_cfg, we have:
>
>   /* This is set by setup_git_dir_gently() and/or git_default_config() */
>   char *git_work_tree_cfg;
>
> It can be verified that there is no function called
> 'setup_git_dir_gently' by running grep on the codebase:
>
>   $ grep -R setup_git_dir_gently .
>   ./environment.c:/* This is set by setup_git_dir_gently() and/or git_default_config() */
>
> The comment, introduced in e90fdc39b6 (Clean up work-tree handling), is
> the only occurrence of the name 'setup_git_dir_gently'.
>
> It probably meant 'setup_git_directory_gently' as that is a name of a
> real function in setup.c. Correct it.
>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> ---
>  environment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Will queue.  Thanks for a well-written patch.

> diff --git a/environment.c b/environment.c
> index 3c32367c28..970a407753 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -106,7 +106,7 @@ int auto_comment_line_char;
>  /* Parallel index stat data preload? */
>  int core_preload_index = 1;
>  
> -/* This is set by setup_git_dir_gently() and/or git_default_config() */
> +/* This is set by setup_git_directory_gently() and/or git_default_config() */
>  char *git_work_tree_cfg;
>  
>  /*
