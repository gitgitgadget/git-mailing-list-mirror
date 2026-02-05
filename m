Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7212EC561
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313776; cv=none; b=gwUOGLMrxfQi/PAnYIJNtGamk1DuQIRdOi9WRwjc2Wr594SPw526SWnZls07V0BOjPj+yMS+BlcTs9GOVBYThBeab8xMJGG2Aye8rUqvES+aBV+5iNifh9tL20BJYmVAHPA9lAItq1ymX0mjqm2qjcXTbz0CIFe1pa9MycdsytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313776; c=relaxed/simple;
	bh=s1oslCudkfnhdT5IO1WmyqQEh424THFOryC4ac75TnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bm4sWiG1SicK3Q8RW1ba/X+ZcWrojpxWPuc8wCU44QvDG5IpgS+CO3XbIqrbQHpXQYl+d10K5xZRqHTCeH3rwD1MiIQuuu/n2KCZR3kcWORtRVwK3zek9ZkLx8AlnRTpSlSKC+6go/rHM6qxbssHcw3QLJWTJSn0WW7JCcQS3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SPHZmZYu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FsnBZQPy; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SPHZmZYu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FsnBZQPy"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2E8C7A0101;
	Thu,  5 Feb 2026 12:49:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Feb 2026 12:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770313774; x=1770400174; bh=s3TRIAhFIy
	bP1kCDl9qIZdfMVV7alC+C3YQi3kUmcIA=; b=SPHZmZYuu5ZtMqY2S4aWH5VeU3
	/ayQpgyn2vBFYVxJI1pnabzPsJrIcmeNFsrHW8icgKTprAQBuBXrxxMExo7TpIca
	vghe8Voy4Tga48GYQ04oUC72d9yA59x6ewztC49Y0+8JAesvB5vWEqrEdRzpaGSV
	kBJ76ovJN/vliLNf6T/4c7T74MOrRWAkSwvuspRSMTO8gX8HburGRXfDUErZFYMI
	R13OnaHBaUQ54eNcrah00X/QBh2ltB+OZ7R6K+n2/kRiXHRPFCdpaWzbzgAAm2Wk
	TQV5PIMj89WTnDulP6NPd7u6cwgbF5kGxkNe/KSbGlg1h0GNIRtx5QTnc6TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770313774; x=1770400174; bh=s3TRIAhFIybP1kCDl9qIZdfMVV7alC+C3YQ
	i3kUmcIA=; b=FsnBZQPyU6cmsa3pgcdlmpiG7sDOxdDIt87/yxohWOWX5NmM0Jg
	hS5NRRK7scBN9gekYFxt6VSe04gmldPGapR+saWwPv/Ux4Fig0pzZjYWM1u1TKcY
	LMMh8lublHGZOxc1sUA0hwcoUTcj/iTw78eSLnrWEBj3xExrmzbOQgNXal4osWYj
	XHgInFNiT4FBTuqxdNZQLv2qYAT+yzigzGi/q3C4bXqJcYx1l4ukN23dJx52Lahj
	I+cpWTzlkaOCksUJidiLUYckfh6cIA+vNUxw0gWm8aPyjtlMUUouhaqBj6bWabVA
	Q/CP1Trb93kxRphGysPBB3s7t8Fu0mrjmTQ==
X-ME-Sender: <xms:LtiEactbbJImGQoZyoDFWNQu9s4cbPgtXAZcsHVLB10SOUkETR2--w>
    <xme:LtiEadK4MFNhvnf-362ayH2h5D9w1sOWmS1BfLgaPkPQ33-MC136x86ejoKQZJh2Q
    5jj4i4_eLw2SvXUCW9AQ8inNIiggCNkLpjkpXWJL2z9Vsf1gKpdXA>
X-ME-Received: <xmr:LtiEaRm4JvjOJTjOPCHD-sqjZ7MA0bZXnLqq0UMnB9I5tM_I6iqaTwkaFopDfxVpX1qx-A-9OXJ9nsbe5HrTGYxva1jXF2MSQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LtiEaWJI3LptTJH9w13uj8Vz_76hLVnPdEL6_9TU5py-VgqKV23zhA>
    <xmx:LtiEae6soJXhHZ_Lxet6c_LBTVOHffH-1BAcNiAP8Ek7DiKxGJiFBg>
    <xmx:LtiEaS2UX2-UitOj6SC6IFNjzoeDHBypFcAj5vvP3Oqo1fQp24BqBA>
    <xmx:LtiEacf7VvizSSbyz2dVOHh-AHcUK7bXgh659XS6hIAgfinVft_IUQ>
    <xmx:LtiEadKy8u_ijgpEIYN_oFoocJxzgHsG4Oiomj92cGurxAIXPGy01-uH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 12:49:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] global: constify some pointers that are not written to
In-Reply-To: <342b01acd42f1fcaa3abefa38dc589e12ccb1134.1770261829.git.collin.funk1@gmail.com>
	(Collin Funk's message of "Wed, 4 Feb 2026 19:24:19 -0800")
References: <342b01acd42f1fcaa3abefa38dc589e12ccb1134.1770261829.git.collin.funk1@gmail.com>
Date: Thu, 05 Feb 2026 09:49:32 -0800
Message-ID: <xmqqecmzm66r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> This patch fixes the more obvious ones by making them const when we do
> not write to the returned pointer.
>
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  add-patch.c                    | 2 +-
>  apply.c                        | 2 +-
>  builtin/commit.c               | 2 +-
>  builtin/receive-pack.c         | 2 +-
>  builtin/remote.c               | 2 +-
> ...
>  wrapper.c                      | 2 +-
>  28 files changed, 34 insertions(+), 31 deletions(-)

Indeed, the number of files makes it look worse than it really is.

> diff --git a/pkt-line.c b/pkt-line.c
> index fc583feb26..3fc3e9ea70 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -384,10 +384,10 @@ int packet_length(const char lenbuf_hex[4], size_t size)
>  		hexval(lenbuf_hex[3]);
>  }
>  
> -static char *find_packfile_uri_path(const char *buffer)
> +static const char *find_packfile_uri_path(const char *buffer)
>  {
>  	const char *URI_MARK = "://";
> -	char *path;
> +	const char *path;
>  	int len;
>  
>  	/* First char is sideband mark */

Everything other than this hunk is adding "const" to local pointers
and compilers will complain if we depended on them being writable,
so this is an easy patch to review.  We can trust even this hunk to
compilers, as the callers of this function would be flagged if they
tried to write through the return value from it.

Looking good.  I agree with Peff that the removal of unused NULL
initialization would have been much better done in a separate patch.

Thanks.
