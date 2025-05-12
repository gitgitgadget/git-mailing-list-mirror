Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448A25334B
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068310; cv=none; b=Cl5DkBcxbUvD7zH2U6yMSgQHbThirQm8nHcwpjP1/ME4Wsx6/SfZ0JRyHq7HcaVolLGQiN2y8Uvw9c6UxqcqNXYFgVE9tYln/S+lSOPRs26VvU18pXqXtFEuhBfywXGtA8YEWxwWkt8F+uwtcKEXa/ZWkeCJrnnqlEwklXr4R/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068310; c=relaxed/simple;
	bh=Ak0014VsiAES5c5B6/ZBNX6yHRTmbEih1Xyif5CYVbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M0L/6Y4SA5yfjPtg742WR/LOpvhXre2FHRfjt7nj80Hn/iJXIUs4tTLhENGJVmk2MoG+nNff7AcYe0OgFGyNMPD+yR+no+HUKCPkGFOXKH9BHXidwBUqnTE0X7q9RToGd3RE64Gqi+4pbw8EjE25HPnZSh9rx9Vy/a0ipAKiMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cbXR2Trw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GSUroACr; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cbXR2Trw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSUroACr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74B962540105;
	Mon, 12 May 2025 12:45:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 12 May 2025 12:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747068307; x=1747154707; bh=zxXRr6hd3H
	qR+YNCaGh4l4PHX+eox3UB1id6rfB5/nA=; b=cbXR2Trwx3MyNXOqvN12tF/id7
	FgOCxMlFvv+x7fr8wAooGC/PZSMcEw9QzVcQlpPAcNKseSQeV4fD3od7enzXiAtU
	9c8CBFAAi0kqqMqbSUBVwF8yprxLWQphxpGWGAIz9598xuaMApVDXQePyjpAtEWn
	hhDwu+iIxp0N+Sm7sFc6l2WDxafxFdMsgQyvvKTWcQhewUC+h7UYYx8tg7mqFMim
	vfG2FydsH5tZJEpQBEXvQKfV4/WfCKxlk8rD/21eK+ew30p2/JI02gql4mm3svbd
	AyLR/42qom3zJhnNy0LqZ6eC4655OJFJiNs4yNOAVW+n0P7utiutvHDLFqSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747068307; x=1747154707; bh=zxXRr6hd3HqR+YNCaGh4l4PHX+eox3UB1id
	6rfB5/nA=; b=GSUroACrFLoPmaokJbdNueZi80/ht2v5U0uhkuOeErjH0zH+IC3
	QMnbKlk9DSZHynn3ah4foFqh6ywEwnBJkBRwYXXoNWv9TQXGcUkQmjfJIBLF7kpe
	21vWkqgnb+xZeI3nRdXHtYJNhiWTqdDDyLNNrGJk/NXe0L9eR3g5yFweDQN61FpB
	9MaayNMeoQPoAmgP27ha/t4/LLYib80rK1O5O0VhN7RhEdebfPVwEf9PzhjaHfOE
	AhHWC1Rr1fm1P1N4QPNb7Z13bXkswDt8BqAsSlX7w7d6oN0CWrQzQaUPrMSBotM0
	bZ/Fcn3AB0uPgP3QgYCVxoEuGfQJBCLeRvw==
X-ME-Sender: <xms:kyUiaCGwxidieoZfw9S_cs2C78abwyiuhSRmpptj7VpGXvOuIMznaw>
    <xme:kyUiaDXAOLZHEhV4xkUIX-BWJ65taeb3JQRi5VqHW-2xozG6Wi42fgJsoIGxXXg11
    D_rJNELHdKP0d-WjA>
X-ME-Received: <xmr:kyUiaMLMFbHi_yBU3R1a_ZTyGAao-wGiXPy3b0FaHckym2h7N-P7FH0Yec3IT3JeTxTgMrb0rzGQ6zlvni_KSMO59KDtP4sScKWsOJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddujeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlvghonhhmihgthhgrlhgrkheisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kyUiaMHm-T_sh7Fmizps0i1JmJTc_mJVfAb_PD_X-Y_vK6r9_04jlg>
    <xmx:kyUiaIVq6BZq6rKTsLjZEr99t5ccCAyB3f3DA6vcXpjZVXOvxkM0KA>
    <xmx:kyUiaPN0K5rMstP4mFohQSZBx1yPXNiB-Lxv3aOzJOlP88b202JGjA>
    <xmx:kyUiaP2uNKwY10MGwtVXOvyjOcjckCyIv2ChpL2chMsEAwWVIHTQ0w>
    <xmx:kyUiaOhYfuOmIa4-ZFE3hxrGpEZ8yxE1nJ02aG3gUt5CrtmEqi_u8FOg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 12:45:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH v2 4/4] add-patch: add diff.context command line overrides
In-Reply-To: <973dfadd1b3c7e214b14c75494b3b3b786227362.1746884789.git.gitgitgadget@gmail.com>
	(Leon Michalak via GitGitGadget's message of "Sat, 10 May 2025
	13:46:29 +0000")
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<973dfadd1b3c7e214b14c75494b3b3b786227362.1746884789.git.gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 09:45:05 -0700
Message-ID: <xmqq5xi5vkvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/diff-context-options.adoc b/Documentation/diff-context-options.adoc
> new file mode 100644
> index 000000000000..e161260358ff
> --- /dev/null
> +++ b/Documentation/diff-context-options.adoc
> @@ -0,0 +1,10 @@
> +`-U<n>`::
> +`--unified=<n>`::
> +	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
> +	or 3 if the config option is unset.
> +
> +`--inter-hunk-context=<n>`::
> +	Show the context between diff hunks, up to the specified _<number>_
> +	of lines, thereby fusing hunks that are close to each other.
> +	Defaults to `diff.interHunkContext` or 0 if the config option
> +	is unset.

It might not be trivial to do but I wonder if we cannot do better
than this to share more of the same text across manual pages.  These
two being options understood by `git diff`, we certainly have an
existing description for them, no?

Other than that, looking good to me.

Thanks.
