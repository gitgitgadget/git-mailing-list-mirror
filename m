Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB415533F
	for <git@vger.kernel.org>; Tue, 13 May 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747151258; cv=none; b=BCav4VuetEICmKT5pGY/ur7vOhN9w7jNF4Dxa0QFL+lcOkaFtBeBmMFH8EkkkJJqDe8niCGlPYL/3BDJLAqPVZqeoBEFZjeeS1pWqx+i1gRZz13bfP5+WSZC/p3ra7Zlq/yLDzpA45zGWWhFwb80yROC4f7w5TZPdG+x7KNBM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747151258; c=relaxed/simple;
	bh=P7JWCIjN9kBDrh8LjTH/mK4JQwjgZtGr0xkTd364W20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NPi4yBbSdBZSSWMuMj9UHfzj7H4sRrFKN8j2AYSFF0vX9cd7x59SzhU9MOO2GpNVwDVrPgzxRweMduRHXm+ahg9AMzRJe6WCUgAvOkhzHivT+pLWXUUNrYDE5nJeI3Oe92K9UuilzH99Wvrp7FLq6uAoON/MvqQPPyc4j257u70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pzNUooN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TxgF/0xr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pzNUooN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TxgF/0xr"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EA7FF114014D;
	Tue, 13 May 2025 11:47:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 13 May 2025 11:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747151254; x=1747237654; bh=qPf09w7v9o
	D6a3NXI06v5Vr/k6cZUALNnSeQujwefVQ=; b=pzNUooN8rFZE1kKsnkBViMEC0g
	rtm4p/eMJKm6Ih1ZX/3wqwHIEipVGclZVpl0TF31h0bxIqMoLwgC6KJNdxnm6oKS
	UvRjh85wkd+e8SXbIqwT4nos+GOJ+5RxpLTZThap3hrcH/djlZsXtGBacvba0nCy
	zkJ7rNsdnQa07H3P4wP4eZKueAWRJPEU7Qu5kWut0hwTWeMKewGnQe6f/xvVAqlK
	u6DL9Pknp9YDT8aqsBjKQA9VdLqtQ92G9ye+ozwRioh6OJiQk+6WmUCmDBN0wq9Z
	Oc+ciRewi+puJduLwMJiclsgSbYiWsLssMuuDDG/RDlWtMVLIINVhpiT8qMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747151254; x=1747237654; bh=qPf09w7v9oD6a3NXI06v5Vr/k6cZUALNnSe
	QujwefVQ=; b=TxgF/0xry821XTkIml5bp0E5tJ6bvT7rx80qDGgWiOuQabZfi4+
	VnkmPg02hXGdtAIL4dWcABKT2/TFDyai0isPk/6ba6LvBxI7qYQsYF5Kq8ZUgRGb
	gnkCnRvkoNPj9cw32Co5LdXoRW1fpEOJUETM5Zwnx4lnSbsy9wXVtM5yUYgZagTG
	1pLHkj6C8rvPGWRmpkJR9ji1K49tpowNiHyJdLC0eW5WSmuAl/Or4oLhpHBp94jU
	YjqvtR/kx/Wv6OrOpSjDhCERHNUYqsVxDjsjj1ZFsW3PqI8uUjj2OED8qkH+uJCa
	q7RajxHSW+N89BAnbAw7B93KGZNGnY/z+Dw==
X-ME-Sender: <xms:lmkjaDP4XnTCGIblelLiRx4GUoWyNNyiHntkWyrVCCuM1-jI-ozXCg>
    <xme:lmkjaN-bZzC-VM1umjSRcQO9cJT-QBn5YCckS3WD5bxTAIW43I5sCCd45QPCjlPKv
    PqEAuPwlxqQ2l36dA>
X-ME-Received: <xmr:lmkjaCQQHL3fp5RxGKHZjIwsCU6YqBsQLBPc1ckYq7wM2bCfDbGkniExVts1M9euFKEU0ND6S-Q9DNTJLz1R-FLYrODpfVwMM23shRM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvg
    gtohdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlvghonhhmihgthhgrlhgrkheisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lmkjaHujhhl1h13ik1BXv_N-OzP0v-kMlEJ9k59pE2UkSVrzPPwgug>
    <xmx:lmkjaLfh23AXNhvudZ0P6j_Y60S2ilGZ0x82zQTGkvhiBXEStj_U6g>
    <xmx:lmkjaD0hBOI8s8e1miit0XykJ8fpBx-e-o_tlQwZniVgnXCB_G_vtQ>
    <xmx:lmkjaH-GeO5h2AX4g3S6ZxqFx-jgBp0lYF2xItTnntwPDs7rFpap4Q>
    <xmx:lmkjaEonBCP1QcFtaXHZuSPy747cdfsJwPP3wRxts5SaYRtnjKtLZn-Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 11:47:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Leon Michalak <leonmichalak6@gmail.com>
Subject: Re: [PATCH v2 3/4] add-patch: respect diff.context configuration
In-Reply-To: <f00cdfa1-343a-4fa0-bce5-e06d1ed62c22@gmail.com> (Phillip Wood's
	message of "Tue, 13 May 2025 14:52:25 +0100")
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<f16d3de86110ee61599459a25764248b52883b52.1746884789.git.gitgitgadget@gmail.com>
	<f00cdfa1-343a-4fa0-bce5-e06d1ed62c22@gmail.com>
Date: Tue, 13 May 2025 08:47:32 -0700
Message-ID: <xmqqzffgh5rf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Leon
>
> On 10/05/2025 14:46, Leon Michalak via GitGitGadget wrote:
>> From: Leon Michalak <leonmichalak6@gmail.com>
>> Various builtins that use add-patch infrastructure do not respect
>> the user's diff.context and diff.interHunkContext file configurations.
>
> We could expand this slightly by adding
>
> This is because the plumbing commands used by "git add -p" to generate
> the diff do not read those config settings. Fix this by reading the
> config before generating the patch and passing it along to the diff
> command with the "-U" and "--inter-hunk-context" command-line options.
>
>> This patch fixes this inconsistency.
>> Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
>> ---
>
>> @@ -78,6 +82,19 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>>   	repo_config_get_string(r, "diff.algorithm",
>>   			       &s->interactive_diff_algorithm);
>>   +	if (!repo_config_get_int(r, "diff.context", &context)) {
>> +		if (context < 0)
>> +			die(_("%s cannot be negative"), "diff.context");
>> +		else
>> +			s->context = context;
>> +	};
>> +	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
>> +		if (interhunkcontext < 0)
>> +			die(_("%s cannot be negative"), "diff.interHunkContext");
>> +		else
>> +			s->interhunkcontext = interhunkcontext;
>> +	};
>
> Thanks for changing this. This iteration of the code changes looks good

Lose the ';' (semicolon) after closing {brace}s.
This is C; you do not need an empty statement after a {block}.

Everything in your review I am very happy to see.  Thanks for giving
a great review.

