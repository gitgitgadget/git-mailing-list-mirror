Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE521ABC5
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278828; cv=none; b=jReIMMM5Ps9YX6hKTf+ILnWUwzClEimFxRj+E1spylSuGyfoDiOYHyqsYIw03tAdpUbUIH9GzMJmVBIKzLnEtyamuX4LjvSE+dcNrvbj27M9AgFZwfEom8xFffnAdIF+7qVxK5dASNLdt/gZBpePLDp04wPo5rX4KFJj9JdD6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278828; c=relaxed/simple;
	bh=lgYSw5Pk0Tj76i3KclfycXUMvoR/kdB15gIOWEs38ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qne5ab4ZvoL+unzT7k/clolMGI4IaZwDTVejUpDEUP8+xUw6lyoPFoV0lX6o/3SpTpJeU3UnC2tFPLxUUgeLJ5V30tMgHj5HWV/ZnSpqunGfkwv1vsxB1mfRHR/BHoW9kgitMBaFHL9Upfy/qoHdXy82vjWTfLZ39pb5gvAbyC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q/kIwXKw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z4NLcOTN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q/kIwXKw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4NLcOTN"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EE5F3138276D;
	Thu,  6 Mar 2025 11:33:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 06 Mar 2025 11:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741278824; x=1741365224; bh=x7PWUStXfv
	z4+z/dSn2HWPa8FLj+QQEyjj75t5PQKnw=; b=Q/kIwXKw6GbGZXcUFNkcV8ysjr
	Mi26rUNryUPV093f4UuQcwOob4i0Ah6kouvyqGSX/jMttyi1bNesXEeQFPPPTZFH
	/aX/615/mgoeUWE4FcRYcyvb9msqIyK0irSxcA4vm/fMo6bWSDk9HVY6ia1kW2D6
	epA1BrjYtrepsIPeAxo7xwF1tAlTPLuGAhc+12pPK3NNDSQU9P/a+Jf2hM39HXL+
	9RAdhUcc4gIjzs3scxLr1Vqgx78sVJ1X2Gzhs0S/gtS+vIz0NeSLnHExeaipaC1w
	Jz63g3BbRpooiNnZpHUF7JYjism6rmHbCSKB+efZFmZAgtqNzSHyiTcV/IPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741278824; x=1741365224; bh=x7PWUStXfvz4+z/dSn2HWPa8FLj+QQEyjj7
	5t5PQKnw=; b=Z4NLcOTNPdX8UmFFNYwH06CG0RZfnAzAMOSN9WR6cV5fEKz2rbR
	ipQg5cSg0iG5WXCUMipChT/i5BeMtf8KYZ2QzZgf7QXkwwxeQksPfHKv90AcDXGW
	bBjj7jYUzA2ZRiYQ+9NqA2epIQiWZuRPvFtygV5UYedcK2u140KTeQwS07ZielJI
	TkfQzZVDxFX5mUOPYeIR7KIvzsI7tKiFI8bLAPqNZKe1gRIm+VR9j00FK8npe1oI
	VQHZV+UUiLW9Ttq8bqHJ9y7pbV6eODmU0VXbgbYac1vy2r3ntmV+5njWD88oZN+8
	ki42UIbqMVIDbhBw9LxzpUakV3D6wtgrNUg==
X-ME-Sender: <xms:aM7JZ2s6imXAwe8m2C6M3XtCaCfAElAYwp0srjZz1CcEwAIb0QCA4Q>
    <xme:aM7JZ7cd8ViPLzMDFc5tTRQ2ipRM2ARfggomtdgq7V640lBfbKqZG2KgoOygFreyQ
    tmjxTc5xQIS7cSGYQ>
X-ME-Received: <xmr:aM7JZxxpcI3R8T5z5rpeg7QuHFsUf6nd28_9B1KR2Y1jmOGAfBUGw5G0esWZgS1hqVZa7HI8Z6zV4vb9XgQjfamFK7hl1croi04r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aM7JZxNV_6k4HgohOE0XwuSkM-0wglglVeaY27eQUfjKF8eI6NsXVQ>
    <xmx:aM7JZ28P7utd9e-RKOJgiqcLRbNaq4uAV7KNkU_f7tJqV68WkQAl4g>
    <xmx:aM7JZ5XodFMqyLE4ORfHL7mze5M9x91hCHf799lu4uBcq5sUmizZUQ>
    <xmx:aM7JZ_d2tqMxe6HnNrf-uVJ5QPonKp3Lgu4KpV7as7l0paGN1aI9zA>
    <xmx:aM7JZ9kpvrzgJZKeWRa5I9JMMT0v2paidb7A6g87XOsmqIseUVKfJ8Op>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 11:33:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] ident: stop assuming that `gw_gecos` is writable
In-Reply-To: <3e9ccffc7474698947bdcb6d49b5d0728deadd08.1741256780.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 06 Mar 2025
	10:26:18 +0000")
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
	<pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
	<3e9ccffc7474698947bdcb6d49b5d0728deadd08.1741256780.git.gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 08:33:43 -0800
Message-ID: <xmqq8qpijezc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In other words, contrary to my expectations, the `win+Meson` job is
> ill-equipped to replace the `win build` job because it exercises a
> completely different tool version/compiler flags vector than what Git
> for Windows needs.

It is apparent that meson support is a new procedure to build our
codebase that is untested and unproven on Windows at all, given that
among all people who may have stake in Windows you are discovering
problems in it this late in the cycle.  Nobody knows what other
breakages, other than something obvious and easy to catch like "ah,
compiler refuses to go further", are lurking under the radar.

I would be reluctant to trust the build artifact out of meson-based
build on Windows after seeing your report, especially the above
part.

A reasonable alternative may be to declare that meson-based build is
not ready yet at this point, and possibly disable win+Meson jobs to
punt and divert our engineering resources elsewhere in the meantime.
For a new thing, having an uneven support depending on the platform
early in the evolution is not unusual or to be ashamed of.

> Nevertheless, there is currently this huge push, including breaking
> changes after -rc1 and all, for switching to Meson. Therefore, we need
> to make it work, somehow, even in Git for Windows' SDK, hence this
> patch, at this point in time.

As I said earlier already, I do not mind turning the type of this
pointer, which is only used to read from a struct member, like this
patch does.  It is the right thing to do, so I'll apply.

But I personally would not be comfortable with the product built
with "completely different tool version/compiler flags vector than
what G4W needs", even the compilation passes with just this small
change.  If I were using Windows, that is.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ident.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, will apply.

> diff --git a/ident.c b/ident.c
> index caf41fb2a98..967895d8850 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -59,7 +59,7 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
>  
>  static void copy_gecos(const struct passwd *w, struct strbuf *name)
>  {
> -	char *src;
> +	const char *src;
>  
>  	/* Traditionally GECOS field had office phone numbers etc, separated
>  	 * with commas.  Also & stands for capitalized form of the login name.
