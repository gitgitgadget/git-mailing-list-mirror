Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F64C7C
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053389; cv=none; b=E/Y+Vq+NotKGJJZtzWOD5LVCt6+y4XzRI2CuYGxDqM0EvuT/M6FX1yfCoFI3nohWVxijEwRLFhZOjrCO9I4RhV5l73yvOfwNzfeiNdNSVr/YHIrgTpcaimNdF20TYgzOqZlpVqGEm7+wz4wOy2OvCOe15YeC6DmF/d+JuFu11i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053389; c=relaxed/simple;
	bh=NUfIDvD9dnkz63FUtfeOkVVI0bmp1vS7uEi8lOzpNvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzte32TCsxpCW0UDKWdRF6TFZgv79SgNtnP25TpAs8dVUUB758U6dzL/TtTPUsPVbVJZHbPyNxtz3IBk9UsGmKJQbyrzcmOBrvsj9AyGbMskuh/cIqTVeT+LWiCQfTLJHKefAbUw0wRT+N7N3Kg3fpEg2pKrV5SXNL493jcIE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YQ9mqRi9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENC1azWL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YQ9mqRi9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENC1azWL"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E4C12138040A;
	Wed,  4 Jun 2025 12:09:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 04 Jun 2025 12:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749053386; x=1749139786; bh=TdqshaM9X/
	2ssp7ohfEZ9EazNFkbg/5aAvkPDeG/Ax0=; b=YQ9mqRi9679lDBxwdVuXpwib6K
	ca/49hr3pSIpH0IQPTiWXxSoo1ys3YaYvTnwZMCJgoM2LnjvG/IzhOBWs73XOjNT
	A17QR0sX9W49WvjAluUkSyoFMBDMipAdQZuFDb34dWbLNGmnVOWJLuR8sE6wvrd2
	MTeK5Uf1YWoLZAg/PXmYMQbBoc9PGSeCvexQ/sdwUEovkAqLrKFikwgcRSVdrm0d
	xXPy8Qx4dGS/8KyI1DNMlqTUw74OEMMGrUk+jST4+AGWyOFNC9Q96hLcp6H7OL/I
	4SDLTLFsFlpypsZqoYUDiSKpsk/oMTZ3TkqgbIfLLs/cw+aNDlQuZmWVlPJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749053386; x=1749139786; bh=TdqshaM9X/2ssp7ohfEZ9EazNFkbg/5aAvk
	PDeG/Ax0=; b=ENC1azWLWl0cInFg7JrjnAYSeWOqyb270j0tgqYAW6RrtByZzGY
	db3AZndQlLH1dTnGKBcjPbBbg7mZaq84ptGOK8Ab/c7DcGhYevaAeQyvxC5wA7XV
	Vkj+IEvkTscmc13GpEHklpBaJJsIapqqVZgMa0ZYyQhwjyX+1vZpmb/jIiu4bB5Q
	ZPAiF+mNHdwIluAGIYdjzrfZV+T4vAYu84O24CWTQVph7AcAJaP+A+J4u0yAGWai
	GOLFjRH52I45yf10YP4s51PCMVh/mmSPiiWB1YTlfEt+eYekY7saSdJjKu6rvJUq
	IZJj2beR1FLiZWcHpiagEGK8G0Wuzl4xDdg==
X-ME-Sender: <xms:ym9AaGeIPOZWr_EAtFN0A9d234O9n6jH-K7arsBxqPW05d9VVQh4Kg>
    <xme:ym9AaAO6PMPabyJYcRxFMDabHoYynvOfTsivSLSWbTKQ6j5DIPc9oU-oaZ2yvBHBE
    M1vYt3kTDMGa6VA0A>
X-ME-Received: <xmr:ym9AaHg9HrxtjMysmHOwcA9qgNnJcuxfHWVtgRj4UXRfQ522d1U09657skmJFvHvWtcZseQHnBSCJ7Z_Bl5qWg_RbSdpfwdHN4vu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhiirhesmhgvthgrrdgtohhmpdhr
    tghpthhtohepmhiirhesfhgsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:ym9AaD9onUNGkj2AdQwjsm6DymXj80OjiGLpVJw041J8E2_ESYqwFw>
    <xmx:ym9AaCvBBS5UiQ_was39NAB8e8Xfe5Fe_Se7DwrJFyUnZrigP8DhaQ>
    <xmx:ym9AaKF9iqKgzCmWHccSU2ODfs-TllDvs7RyEkH0ZoX9WU4CaKNVcA>
    <xmx:ym9AaBO134LE2Ze9eqFGcoS-fUKKW4mmqZLdtBohTJG8tNJgwfxBWA>
    <xmx:ym9AaLm_1V7nI2EGmu-cE9a7ZjMmEF3NDRSxuJ4yrUfbarBYkWR8Q5Ek>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 12:09:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jan Mazur via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
    Derrick Stolee <stolee@gmail.com>,
    Jan Mazur <mzr@meta.com>,  Jan Mazur <mzr@fb.com>
Subject: Re: [PATCH] bundle-uri: replace printf with fprintf in
 print_bundle_uri function
In-Reply-To: <pull.1985.git.git.1749023960409.gitgitgadget@gmail.com> (Jan
	Mazur via GitGitGadget's message of "Wed, 04 Jun 2025 07:59:20 +0000")
References: <pull.1985.git.git.1749023960409.gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 09:09:44 -0700
Message-ID: <xmqqy0u7bi9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jan Mazur via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: [PATCH] bundle-uri: replace printf with fprintf in print_bundle_uri function

That says _what_ the patch does.  We care more deeply about _why_ it
is a good idea for a patch to do so.  And ...

> From: Jan Mazur <mzr@fb.com>

... there is nothing described here.

> Signed-off-by: Jan Mazur <mzr@meta.com>

Something like this, perhaps?

    Subject: [PATCH] bundle-uri: send debug output to given FILE * stream

    d796cedb (bundle-uri: unit test "key=value" parsing, 2022-10-12)
    introduced the print_bundle_list() function, which takes a "FILE
    *fp" to write the output to.  Later with c93c3d2f (bundle-uri:
    parse bundle.heuristic=creationToken, 2023-01-31) the function
    started showing additional information, which is always written
    to the standard output stream.

    It does not look like a deliberate decision to do so, and it
    does not hurt, as all callers of the function passes stdout to
    it.
    
    We could change the function not to take fp and always write to
    the standard output to simplify, but let's use the FILE *fp
    provided by the caller consistently to write out output.

The change the patch makes looks obviously correct.

Thanks.

> ---
>     bundle-uri: replace printf with fprintf in print_bundle_uri function
>     
>     Small fix to bundle-uri convenience debug function.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1985%2Fmzr%2Fbundle_uri__print_bundle_list_fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1985/mzr/bundle_uri__print_bundle_list_fix-v1
> Pull-Request: https://github.com/git/git/pull/1985
>
>  bundle-uri.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 9accf157b44..c9d65aa0ce8 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -122,7 +122,7 @@ void print_bundle_list(FILE *fp, struct bundle_list *list)
>  		int i;
>  		for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
>  			if (heuristics[i].heuristic == list->heuristic) {
> -				printf("\theuristic = %s\n",
> +				fprintf(fp, "\theuristic = %s\n",
>  				       heuristics[list->heuristic].name);
>  				break;
>  			}
>
> base-commit: b07857f7dcffee4d3b428df8dce6c9b49a57c9c1
