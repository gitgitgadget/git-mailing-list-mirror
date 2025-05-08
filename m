Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375E21FF59
	for <git@vger.kernel.org>; Thu,  8 May 2025 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742573; cv=none; b=VHHdUu9emjY/ROHkw+ocS9+1pPH/voHi1AYQgu07sbne9bdvgvABjAGLLQa6VOAqESKDTySplwG8qL+zo4SAJo65wbbuW4nAkVbOkb1j03W9G8zP/E50FSvlV1Qp++j1lVTeg/xJ5cG5F9aJbqt+cgtxz+QzCsk+hCwVk2QPops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742573; c=relaxed/simple;
	bh=CuBgXnFTPwwEY0VxlFacr0Y4SeRQlwmvXPXp8HhGs1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zx1gLxQ4emlh9JX6HKBDd624mJVm/sN4bpdz7Y01m+xpRmZehg98W0N4pFbKJEgQUNLSrQuyOw9yHZe5fGsWqQYMv/kbo6OKvL9NfIXGd/Bf7ShcGX/5f3fv2L17t4JrPLIuPqaKTgOKFeI3vi//KNXHViFHDNlura+1+fAfUXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PsQn0qPD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v9JrhZc2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PsQn0qPD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v9JrhZc2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 75D9111400C5;
	Thu,  8 May 2025 18:16:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 08 May 2025 18:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746742570; x=1746828970; bh=VV1BfC+4Ai
	I4dRGPc6Ut4cfTPvYG+0aq1h1lvfkGCEA=; b=PsQn0qPDZWFqw3eVDpPPbjI2M7
	k6EHJPFO3GXe1J8XqYsuqZYBT6TiqyFrD9anG0RjwstT1VtnQkPE5dm84XM6O0lD
	GWRotzszBKUY/Aq4yEa6sdI1E4ylASFCw7qeaQY38BdtQcdsMAMTmdyY8zvBpjHr
	TumpLhp4HJBFpj65uQDblZHKTVzZocsga+fgJ1hO23Opl7NBIRonaJpfKnal5tNa
	oeTnBft6BrtGZijmIFtAYyt3WRN/gDYhNLf5W9ZTUvnOY/Sfa7KDB/4ORyBP45Hg
	MmgB1FJ5Yj41FLWpElGRT/c+tXNoeItvdHnMPI/4sQNHX72CuvwtlbncKRRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746742570; x=1746828970; bh=VV1BfC+4AiI4dRGPc6Ut4cfTPvYG+0aq1h1
	lvfkGCEA=; b=v9JrhZc2YYIcihEBjv63CkkupaqManRrXYcjRWdi+qhCZeijAQp
	HG9cqsU1dkQFgp0k7Acu+SB6RtiHi6IoVN5PUqBiAIxpXrS9vZzonkg92S4g03yU
	QdkstyKAizNfcDBj2+JEdX0bakCW4AzN3hpbD3JY4/jPvlrBhpwaQ9zymReWctY9
	9/5tV6jhBhiylHQkXJerzveo8hFvNVRkxBWYTa9Npji+mTciBxg/VtKWsvvgqL/i
	noU7+R1ajj/Wd/1iypFrmDHpCdDi5DYwO1EPHJrrG4C34Vf4YPbB7LMUK4fRQyD/
	mesMRf6ubUgVZ5c0N7GI13y8SmdzNhlaIYg==
X-ME-Sender: <xms:KS0daHhCBqmWCLTi1DpAcHmpNdaPHyMNVeBkNvVxar_WnOrHDWdUKA>
    <xme:KS0daEA5-DUucQ8DxAdMCCpz8bzMxECzP-Pwl9_1zQIfDr07D8kRecCvjRnujl8M9
    C1RLU4KcbSb2spwcg>
X-ME-Received: <xmr:KS0daHE4gDwJh9ZJGW-srPBP2Yjpawt4NJRRSF8EMDw6E6Qj9yF4JDguwczXYemQrMmjXti9ZOrHbY8FiUQr1X-K6QrMk02M_caI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephe
    dtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KS0daET6XEBPyv76yK7_87sv_EtrBlIM2iLVD-pF7Lur9duSEq8cag>
    <xmx:KS0daExrY9uXiLXUWFiHJYYnGzj1Jz6euNJUEvYRyVV7KrY-q6yiew>
    <xmx:KS0daK6TsQ4ovDjGlCt_EViQG6bH__qjiPx2owOsMYR_lhBkLSBljQ>
    <xmx:KS0daJzGT0flXes9vW1gHNB2VN9mcG0fzfVoDCttFqARrosfDTVh1g>
    <xmx:Ki0daK2RPUr6_u99N6sfo6X9kfAuqkSrFBihUqdno8A4RuIkDT7UURXT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 18:16:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] decode_header: fix pointential memory leak if
 decode_header failed
In-Reply-To: <pull.1956.git.git.1746711521614.gitgitgadget@gmail.com> (Lidong
	Yan via GitGitGadget's message of "Thu, 08 May 2025 13:38:41 +0000")
References: <pull.1956.git.git.1746711521614.gitgitgadget@gmail.com>
Date: Thu, 08 May 2025 15:16:07 -0700
Message-ID: <xmqqh61u4ul4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored
> in dec will leak. Simply add strbuf_release and free(dec) will solve
> this problem.

We try to write our proposed log messages so that readers can
understand the idea behind the change without having to look at the
patch.  Even to those who are intimately familiar with this area of
the code base, an exact line number reference rarely add any useful
information.  Something like "In mailinfo.c:decode_header()" would 
help them better than "In mailinfo.c line 539".

> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>     decode_header: fix pointential memory leak if decode_header failed
>     
>     In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored in
>     dec will leak. Simply add strbuf_release and free(dec) will solve this
>     problem.

Just FYI, here is a space to describe what would not have to go into
the proposed log message; there is no need to duplicate what you
already said in the log message above.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1956%2Fbrandb97%2Ffix-mailinfo-decode-header-leak-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1956/brandb97/fix-mailinfo-decode-header-leak-v1
> Pull-Request: https://github.com/git/git/pull/1956
>
>  mailinfo.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mailinfo.c b/mailinfo.c
> index 7b001fa5dbd..7a54471a481 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -536,8 +536,11 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
>  			dec = decode_q_segment(&piecebuf, 1);
>  			break;
>  		}
> -		if (convert_to_utf8(mi, dec, charset_q.buf))
> +		if (convert_to_utf8(mi, dec, charset_q.buf)) {
> +			strbuf_release(dec);
> +			free(dec);

OK, this fix is obviously correct.

A nicer fix for longer-term may however be to fix the calling
convention for decode_?_segment() functions, so that they take a
caller-prepared strbuf as a parameter and fill it (and signal an
error by returning -1, a success by returning 0).  There is no way
for them to signal errors they detect (if we do not count the usual
form of doing so by returning NULL, which this caller is not
expecting) with the current calling convention.

We'd still need to release the data in the strbuf "dec" even if we
did so, but the strbuf would be on stack so there is no need to
free().

>  			goto release_return;
> +		}
>  
>  		strbuf_addbuf(&outbuf, dec);
>  		strbuf_release(dec);
>
> base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75

Thanks.
