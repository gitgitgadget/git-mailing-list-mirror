Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A372FE060
	for <git@vger.kernel.org>; Sun, 24 May 2026 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779666021; cv=none; b=MeLv7TKkIt/7spvvaL7/A8ZbjSi4qLS4u+N/vwbrTEmjfrmqWGBgH3mULbxCEmbh5eobjCmEnSpnMqug23oWW3pGWwCXzcr7eQDfnJNZQSXeXH+4hW/tfJ7s80FP174HvmtOwcD25IgAxUjs05Kh+BKIxHYgMhkzV0XigX/1XOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779666021; c=relaxed/simple;
	bh=YdgOk+Vfis0aPcco3BiJVmkNG6Oj8v1ioOjcZTsmDOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aLnp6A0UYsiToEbYN/RtFKJDdbaeIvqZdj4x1m9iEvu5ZJfewjRrN4NGkEdQinwNnRjT6pNitX00JF0QngeEpZuK1BZ0QRL3F8hhFhiF/kk0pwcpSfKE4sDI5wSUw2xRG1i3CKqt8Vzgj/s7LX/BlUpoI1o/ZSYX47Fsf8lUgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SHoeofFc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sR18yQGx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SHoeofFc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sR18yQGx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B076140019A;
	Sun, 24 May 2026 19:40:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 24 May 2026 19:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779666019; x=1779752419; bh=S8ckPGQGwk
	JA8IlJDH2obpkHqmdbWritX/jy3AdJEMA=; b=SHoeofFcEJc8hYAglxuyMKbuUl
	0Q7Qz7KVTK/zbY3F5mEu3gwN4zEVl1GmBjGs1Mrbe03fRRkGVEQ3/Lak/D00Bvew
	DNmLVJN/Yql8WHQL0iVesDu56Kix8tBCXRWJ8uNL1wxjcfMSpvFdJVEt+zul8qJW
	Ig/ifXLkxgR43z01PDvwtlB1sJxlNHegcmI/eRERvM20khumFO2BsT20flt03dY4
	dt+4q90KwisovZDsF5iywCgQ55PD0Q6q+180J3bmUSFes9dzpOTt1oZobypnLeqr
	34JwYqAOLLKVzgAtdkQPBG1n3bABo/rsOic8GDP88W4zsjK9NiJv44Cv8sEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779666019; x=1779752419; bh=S8ckPGQGwkJA8IlJDH2obpkHqmdbWritX/j
	y3AdJEMA=; b=sR18yQGxInK+wbuMGcikENKRef3RpMpG3HhPMaaSf65wTpEIX2N
	lP2zqErO5rjiYQuXIvWEtAEwxl8PgCOOR9HFHdWDBDf2Dw/6nxEvHWKkFNDb5oIY
	cOWUIsr2YSYjH5cMVRDQad5ktaAuwv6v9xZXmRK+KqQSp0QJhkwuiP+ZYAPSn88r
	6TzixcTwx26ZMn6dPTQW2QbkgYPb0hR97ed7yvKFZHFYm6q06qoAaZ8Wq2QgHnZ7
	yMq7gZZ+zGVnA+cr7KRhwvnIabbP4uspYvT62gyKtvSrHMn4lEmrvbZ46khafcmU
	zbjqfZehOnEY5rANdtHagwUpH8ovHwQcnrA==
X-ME-Sender: <xms:Y4wTavosGGcgge1E9I8q1isANlu7lvSCUEE8HaSesBpQ0FfbxDskRg>
    <xme:Y4wTagqDWkPwhqS7xLuFxYt81FozRev0nJZWKLPR8tlFl-AO1MRJRrxQKqVsLUyva
    u7_UVTrzFAvlvJVVZm2bRupXNxxVFMJ1MV-UJDreTNxGtweYslN3A>
X-ME-Received: <xmr:Y4wTahPVZubchNnd3Nl_Mn0YikBjCmWliYqeA3DihbBifcQwMVTR5VK6R9R-PS35C5CGAfupMfCratsLabaJPVQ0oIt049M__xiH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheejvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhkrgesshhpohhtihhfhidrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:Y4wTahzZ2z1EYzDbrHn4BRE035BA_VGGQdLhA5JJZOjvzBtY2v9zFA>
    <xmx:Y4wTaqvOu_bC5svMTJWys5Fz79rWdWj1N8KHo9ZQ5fiOlkABwso2TQ>
    <xmx:Y4wTaq7u3uedmqZN1Fh8hDtfn_whb1DNJgfAy_2f6y84ismJYfE0yg>
    <xmx:Y4wTapQHr3j6kl04DjeWMvcv0RtWaAoK18_MMQqz0wr_J4yYpnfhLQ>
    <xmx:Y4wTaiUjQGHHWKwt1S1Amyl7Uqbjh2JyFNTFtJxsVHDt1SCIf5REtNgp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 19:40:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 1/3] commit-reach: deduplicate queue entries in
 paint_down_to_common
In-Reply-To: <1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Sun, 24 May 2026
	17:42:18 +0000")
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
	<1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 08:40:17 +0900
Message-ID: <xmqqpl2kgyvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/commit-reach.c b/commit-reach.c
> index d3a9b3ed6f..c16d4b061c 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -17,8 +17,9 @@
>  #define PARENT2		(1u<<17)
>  #define STALE		(1u<<18)
>  #define RESULT		(1u<<19)
> +#define ENQUEUED	(1u<<20)
>  
> -static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
> +static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT | ENQUEUED);
> ...
> diff --git a/object.h b/object.h
> index d814647ebe..05cbf728e9 100644
> --- a/object.h
> +++ b/object.h
> @@ -74,7 +74,7 @@ void object_array_init(struct object_array *array);
>   * bundle.c:                                        16
>   * http-push.c:                          11-----14
>   * commit-graph.c:                                15
> - * commit-reach.c:                                  16-----19
> + * commit-reach.c:                                  16-------20
>   * builtin/last-modified.c:                         1617
>   * sha1-name.c:                                              20
>   * list-objects-filter.c:                                      21

Not directly the fault of this series, but we'd need to audit and
update this table of bit assignment to match more recent reality.

For example, there no longer exists sha1-name.c but the table claims
that bit 20 is in use for its own purpose, and it being stale makes
it harder to audit and ensure that this new use would not crash with
these existing uses (note. there are other uses of bit 20 in other
subsystems).

FWIW, object-name.c, which was formerly known as sha1-name.c, uses
the bit 20 as ONELINE_SEEN bit, which is used to turn textual object
names like :/string (i.e., commit with that string in its message)
into raw object name, and bit 20 is cleared from all the objects
involved in the search before the helper function returns.
Presumably, once commit-reach.c starts queueing commits and reuses
this bit for its own purpose, we will never try to parse a textual
commit object name to clobber what we thought is ENQUEUED bit,
breaking the code introduced here, so we are probably safe against
its use.

I didn't check all other uses of bit 20, though.

