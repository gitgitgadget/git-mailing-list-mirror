Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC46335BA
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795459; cv=none; b=DvTu+pc8k1zK9zI9kG3TLJdiWPrhQ0Sa7iwmxOmUT6iK99P/4Qe7XvPMipcMeYMkg8652BkuiTUSTcxNJE0v8Tb9kg1gPVy1CDtT0c4SQhnUisOKn8bIJAOGOsN5BTiz5hRAvQ8DBrd4ueIgZ5U9NcJGSfNngEv5TkGnvCxwIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795459; c=relaxed/simple;
	bh=irvB5JqBjDSitlETou9J7hbyVqZux7bQY2R7eQfP1UY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3WrVqAwbAd43HPt0/K6qmWixg7XDFuYVSlIXi5YoYnv2fQLpeMVY8htICFQ/osapcxB887UQw5TSHZhXHTI8z+QRIZma07nv/1dITo3elCsQ9+UDMrmeqcRZsb0kf0LnZHekA33lG61P5/AoZ5qHu3xmSxuSMAN/TTVEciDIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O3xVYwhA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UG3HHbdF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O3xVYwhA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UG3HHbdF"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4716E1140109;
	Mon, 24 Mar 2025 01:50:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 24 Mar 2025 01:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742795456;
	 x=1742881856; bh=gbq7hrw2ZjMluZR9EZHsNFTPOFpu4dBhyZkmy2333b8=; b=
	O3xVYwhAYqVRgrM9A+wfYtlQ1Uc+Ngfz/L/V3SdGqsaCuCtxIf29X6FbKSxH/3cJ
	hkrTOiHU7XEtus7InjV4jO8nOSxw6VzqWyEIreiuVuWoO+8m9umUfDaXcgbl2NTA
	Mc5f8i08I9/3Lev+m7CfWTQRo3sneecgri/ZwZbvGmry6ZuyOd4s7MnU4PVNlWE2
	0aRzk+C2JZ5DEbWQiDJtJBAGYiH0DoYVmgirHQHJLJN9q4vT+YgvNioxYleDa/KR
	WLEcHAXAyIcSlv+b+emVDP27ialljrl8YHn+iMMeJ1hWIMjodavxiEQKLfA5OxXx
	gwldFrhWTG7hozGxnGq+6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742795456; x=
	1742881856; bh=gbq7hrw2ZjMluZR9EZHsNFTPOFpu4dBhyZkmy2333b8=; b=U
	G3HHbdFIeMsPUFJ64YBdFgrUWHNtZNVKtu3mDydwcS7Zq+MoDW1ypiTPhl49OzJe
	Dl9t8Qux7hKkcENaRNL2tDD7tQblKq2qYbN8uOzyEhQ2JPyef6ApLV7HZcmUMEEx
	V40WgXFmSkmPg3ZHPycLDIJounMZEp040hE+ADbuPJaUWc25cp+k6LSd83yUmLLp
	qn04TiyhtY8HzMCExqHM6xq5HnKu0XsDyCEY3aWoKl6PjAPjnhhMwIIiyHGRx1RV
	+/CTnhuRtMHJg33P0dhjxAAibfS+6uoFERDGmk2jxc/bIpz3ZYUcvGeTLUKqlB+o
	Nmlj9wZ49OjOKUVBamOmg==
X-ME-Sender: <xms:wPLgZ0mHxW_Hd_lZ05NkT637jVDLSOochQZTNux27lXWfLRqdSnEsA>
    <xme:wPLgZz1M6Fvoo1GeRyvNQeOFNVGJ1wgFsS7xjPT6X6oTlzSHnjN7DQFvS-jE9cOK9
    W2DnYYaD207pRgcsQ>
X-ME-Received: <xmr:wPLgZyqcA_yNfhDfWB0bvw-NiNMn3VWY5d6DmdMhQBHhzqHDXGHj1Uifo1nD9HCZgqd-E2IVwz7RNcUjjeRRdVVXL22uYIaLbLcqjNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    eptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:wPLgZwmmcjNhCC-1UmZBbD0R8t2WSuJUQ0gKwV6TEqD0teQKJvrUzA>
    <xmx:wPLgZy2MjAO9Aym6heWvE6XIyL8HbjBCim_Vb9xHGJUr2C9nGE6kdQ>
    <xmx:wPLgZ3u5KonAGY3nze75KaEFe3uAjqt71VAQEYNZdCax4waEIM5LWw>
    <xmx:wPLgZ-UM1-PcY-okvxTE8E3GJGbRYNQxkH8I6ZPfgfIKiGJZzOYiGQ>
    <xmx:wPLgZ3yzJFHFhoH76hkH_N-ckuMcC2APUO_JUu-PwM0ef9IISvCg6wl1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 01:50:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] commit: move clear_commit_marks_many() loop body to
 clear_commit_marks()
In-Reply-To: <80bfd7a9-904c-49d8-a367-ca268c096a9f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 23 Mar 2025 10:53:21 +0100")
References: <80bfd7a9-904c-49d8-a367-ca268c096a9f@web.de>
Date: Sun, 23 Mar 2025 22:50:54 -0700
Message-ID: <xmqqo6xrou2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> clear_commit_marks_many() clears multiple commits one by one.  Move the
> code for handling a single commit to clear_commit_marks() and call it
> instead of the other way around, to simplify the code.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  commit.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

I _suspect_ that the original motivation of the current code layout
was hoping that with more information at hand, the *_many() variant
could be optimized to work on multiple things at once, which may be
more efficient than doing things one-by-one, but such an optimization
never materialized.

And it is much simpler and easier to read what goes on in which
function if these two functions are rewritten the way you just did.
It is crystal clear that there is nothing clever in the *_many()
variant.

Thanks.

> diff --git a/commit.c b/commit.c
> index 6efdb03997..425503bb9f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -780,19 +780,17 @@ static void clear_commit_marks_1(struct commit_list **plist,
>
>  void clear_commit_marks_many(size_t nr, struct commit **commit, unsigned int mark)
>  {
> -	for (size_t i = 0; i < nr; i++) {
> -		struct commit_list *list = NULL;
> -
> -		clear_commit_marks_1(&list, *commit, mark);
> -		while (list)
> -			clear_commit_marks_1(&list, pop_commit(&list), mark);
> -		commit++;
> -	}
> +	for (size_t i = 0; i < nr; i++)
> +		clear_commit_marks(commit[i], mark);
>  }
>
>  void clear_commit_marks(struct commit *commit, unsigned int mark)
>  {
> -	clear_commit_marks_many(1, &commit, mark);
> +	struct commit_list *list = NULL;
> +
> +	clear_commit_marks_1(&list, commit, mark);
> +	while (list)
> +		clear_commit_marks_1(&list, pop_commit(&list), mark);
>  }
>
>  struct commit *pop_commit(struct commit_list **stack)
> --
> 2.49.0
